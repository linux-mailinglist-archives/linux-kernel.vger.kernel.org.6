Return-Path: <linux-kernel+bounces-168855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097D98BBEE8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 02:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE679281FDB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 00:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4C72904;
	Sun,  5 May 2024 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Fo8bw0j2"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F017F7
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 00:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714868131; cv=none; b=fdcb60ZTxGNSLcUvTCrHK9KPzCSRNphYGmCfBrY2tGseDlpM1uzFOAWQvF9HLYfSVo2d1QyDLDe++CzgVHMUpLGQZThVCTooaUJaMTpF0hwWfCg5xz4OugtyWV28DmKDuhN4domw2x+PZz9d6gHRXb8BuiVvxhl4RE7g/A7+9OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714868131; c=relaxed/simple;
	bh=nk/KiriDObB8jrAY4t1yYUr8J9vkeu4uwfBI3E/tlac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QBkjZB+z5wDoFyp6HF1cdExxMug+Q/tOK8jrz4XyFQ0/jQlodO1+VvGVI4SjGnfUIIVfMdr8PUqQvE1RG/mcyse1vcKawyRIF87410xj/jrlLeixJilKybpL0GfME6cWWOeDViZCIhAZzwKYUyWXazoaRnD4cZca0tM1neYYMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Fo8bw0j2; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=9tJdhokC07t5AKnNYTYSjj5ZbBWyfN8CQQLC/CMUQK8=; b=Fo8bw0j2JsDDYWQh
	FPvHs1HYh4xomYTT6G9Rdn6Voo6ryiCiFtJOeVl8wEYYiSurf8ve/gWX2/JuxUU4oAT36WGaNSD8g
	0ZCxmJce00vFdgc/TtmTPbSS8N++zmksHYFK894nF5gLZHGNEAqaGziObeKZtsvlwLtqPGV6vSnpu
	/Kcf/dOuprw/ClTAcgh3FrMdav2hNk7E8a2bTC/AFZVW1CLPRSQ/0T9sEHJahgrp9LQsAF22a/gnF
	wo+vMlnctMQxarWjMR6hy6MVhPoXB5EVEzML3XdHOMEddtvw7YlauXoymFvRHGNo+7YfottsHLpCX
	129XPP1c+hen0brlUg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s3PX5-004kAq-0i;
	Sun, 05 May 2024 00:15:11 +0000
From: linux@treblig.org
To: richard@nod.at,
	hch@lst.de
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] ubd: Remove unused mutex 'ubd_mutex'
Date: Sun,  5 May 2024 01:15:08 +0100
Message-ID: <20240505001508.255096-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Commit fb5d1d389c9e ("ubd: open the backing files in ubd_add")

removed the last use of ubd_mutex.
Remove it.

Build and kernel startup test only.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 arch/um/drivers/ubd_kern.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 63fc062add708..2b855240fbabf 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -106,7 +106,6 @@ static inline void ubd_set_bit(__u64 bit, unsigned char *data)
 #define DRIVER_NAME "uml-blkdev"
 
 static DEFINE_MUTEX(ubd_lock);
-static DEFINE_MUTEX(ubd_mutex); /* replaces BKL, might not be needed */
 
 static int ubd_ioctl(struct block_device *bdev, blk_mode_t mode,
 		     unsigned int cmd, unsigned long arg);
-- 
2.45.0


