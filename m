Return-Path: <linux-kernel+bounces-370667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3679A307C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE17128593E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A622B1D6DD8;
	Thu, 17 Oct 2024 22:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doh1to7L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8B11D619E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202964; cv=none; b=OuIundaKZ+XEVkOvxhTdUnbwqj0wwYfCeOfIz9haIPtj3UA7Ebip9Echqgf19UH0DLx2LcDe3LJJnlnyeg0yGJ35GmP5ebzrJTeRGYzaCvKvhBvhzmIww/8Wa4Pg0VYM2G068t7AUOxWPohjpQQx6yjBVYSg+tgnhV60yzC41/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202964; c=relaxed/simple;
	bh=LBIgyrLuaBqTORxE2I1QnJXE28MqvT/ihJpqGGLR23U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILtC4fyd3iQNAWoKyM8mg1ilfhn3v/k75eHbQctr2mnAc/sZ2seUXW6ihgM8xjXGm4CVgI+zKimsbEWkU4Giwn1C6IuNkmYrkruLHBHPTEk0I+mHwmc2lJ4zg1BMBHmhPor5b7PMsu+anAVU4hXFESa5u386ucDghyYdxeZi70E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doh1to7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E08CC4CEC3;
	Thu, 17 Oct 2024 22:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729202963;
	bh=LBIgyrLuaBqTORxE2I1QnJXE28MqvT/ihJpqGGLR23U=;
	h=From:To:Cc:Subject:Date:From;
	b=doh1to7LYjjeZ0+VsLilnbpVolWepENdN4dZsRMrB9Imb+7L4xPmdqH98nnELN/WH
	 00lWgqLw7oseaNmGY4fJpc8BUV9McBTxoxHMjHOlhlVpgcqfWQzQd72Vwg8ObYzoMA
	 nyqMaIN6S/++nqhjqCoNr5XzpUDqYjn2VWoXvx+BAaIpSaHyacllJwIlwIb4/H4Tc1
	 R1l+kJ1DqFXvMBCMln34hIOC4cOhM0afS89pOC8p2B27ZxYK6QUpshDJaxSQHfKAvP
	 QHIUNKUmnnc1iXBNL6OZd7d/ZHuzgPr5tdE6UdCnE0eVLVe4SwXfzpktQDphceUPJp
	 2KMB4rmI9XRRg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: linux-kernel@vger.kernel.org,
	Jordy Zomer <jordyzomer@google.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] cdrom: Avoid barrier_nospec() in cdrom_ioctl_media_changed()
Date: Thu, 17 Oct 2024 15:09:02 -0700
Message-ID: <1d86f4d9d8fba68e5ca64cdeac2451b95a8bf872.1729202937.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The barrier_nospec() after the array bounds check is overkill and
painfully slow for arches which implement it.

Furthermore, most arches don't implement it, so they remain exposed to
Spectre v1 (which can affect pretty much any CPU with branch
prediction).

Instead, clamp the user pointer to a valid range so it's guaranteed to
be a valid array index even when the bounds check mispredicts.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 drivers/cdrom/cdrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 9b0f37d4b9d4..6a99a459b80b 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2313,7 +2313,7 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
 		return -EINVAL;
 
 	/* Prevent arg from speculatively bypassing the length check */
-	barrier_nospec();
+	arg = array_index_nospec(arg, cdi->capacity);
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
-- 
2.47.0


