Return-Path: <linux-kernel+bounces-242039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C749282FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F078628845B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B677145343;
	Fri,  5 Jul 2024 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3vaEXd4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE71442F4;
	Fri,  5 Jul 2024 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165426; cv=none; b=s1odXfDM2mjFqxrjsTSqs9eG69la/Qz1CiiPu1oqkGQnE2NNp2SZAT6dv6UsrZQn3x+I5zXQTNCu43RJMnmJLeqXjTiYU7zpLx5rdG7DqV5Z8mpOVpu069wwpjnUnxZTPOIdLGkuhRRKKjbSao3Dl07Fwy8us2vtWCDypVRfrRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165426; c=relaxed/simple;
	bh=t4kXHg4frzsPSSTQ4jwgylMVLomLutzNdMNloKpmrgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFaEGhHuTcN9itazeMEpAg4Pv4SG8sd3AFHuw9K7ZI6pua1b4vELsIVR2U22sTZKVoBfWQq9ZnLI9DBtSAdD74qPYDJgmYQ/PspOTKAb0Qw1ytgN7qkr2Y+mtxwfFamBnzlKiAcNn5AJx3JVS5sSkRkXAdRW63Bf9XSmWT4DgFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3vaEXd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657D0C116B1;
	Fri,  5 Jul 2024 07:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720165426;
	bh=t4kXHg4frzsPSSTQ4jwgylMVLomLutzNdMNloKpmrgc=;
	h=From:To:Cc:Subject:Date:From;
	b=p3vaEXd48lD2RbryODvsQOyJuaC/Ld1MKO1HlXkg6KCn9JDRjMmFqZSGgSFVc5p5q
	 Y6AYk/6gindaSpMl7jIXmTZNt34jyvMTcDSvTRkrfyl5RSfR9/KABGRmqCKeQJEmXm
	 n7DoUZ0ll3PWj2HJDu8gou+M1yPSdNARNQb3CvjIIe/QPMWfwkdj12qScPEnp2/+yH
	 5XNGLO3St5IsmxT+Jr5fKlR8Sm5RkJzgXnqYJKYrJPT9r4xO98fsH+Z4Hel0SrQAAd
	 P+hdURBAh/MP8jkXuXS0rNkggP9C5/EFe5CVww2z4MrNLJeau7AbpOfqVzCT3l6HO9
	 avm6+VpJXtzsA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 1/1] usb: gadget: configfs: Prevent OOB read/write in usb_string_copy()
Date: Fri,  5 Jul 2024 08:43:39 +0100
Message-ID: <20240705074339.633717-1-lee@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userspace provided string 's' could trivially have the length zero. Left
unchecked this will firstly result in an OOB read in the form
`if (str[0 - 1] == '\n') followed closely by an OOB write in the form
`str[0 - 1] = '\0'`.

There is already a validating check to catch strings that are too long.
Let's supply an additional check for invalid strings that are too short.

Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/usb/gadget/configfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index ce3cfa1f36f51..0e7c1e947c0a0 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -115,9 +115,12 @@ static int usb_string_copy(const char *s, char **s_copy)
 	int ret;
 	char *str;
 	char *copy = *s_copy;
+
 	ret = strlen(s);
 	if (ret > USB_MAX_STRING_LEN)
 		return -EOVERFLOW;
+	if (ret < 1)
+		return -EINVAL;
 
 	if (copy) {
 		str = copy;
-- 
2.45.2.803.g4e1b14247a-goog


