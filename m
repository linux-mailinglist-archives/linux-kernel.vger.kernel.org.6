Return-Path: <linux-kernel+bounces-574743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BFBA6E965
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F36A47A4AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 05:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF1F1AA1E8;
	Tue, 25 Mar 2025 05:55:44 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5AA339A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742882144; cv=none; b=X6AFwDEl326wdDkZ+f9n/CoLFFwY5yPAs2ej+UtH+tBbd/ksDGjna6xLfzMX3Rd/Z0vzL1N2J7GG5VhUsHFaCYSe32VsXBciB8YPinVK2MfHBz+yxsLEPu0cRQ6kfErckHeVoSPrfNOS44Ivau+zH4oA+K5avQS0Z3rvhE9hTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742882144; c=relaxed/simple;
	bh=045u5XOQ0mXLTqTQJQgsSEfbRNK/mkKdS7wgXOZQRyU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y/2HbYeFdpLC1I5JvoSrpf1wDWraUzophMf3/AEVkjNmLFZ/vyLVijWdo3vy2lcAwrKoF74NGmZj7VkSp6i7bcumjg1ol5F9SiRTdSNc3Q7Srw2apCJPFYtdvpU9NJz+vNelFou7/6+T8JkLWGWdbDPHtIUnzv1lhXdn7wtuqaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85da19887ebso1103134639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 22:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742882142; x=1743486942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jb8bQK82UvOliRezrYlEa3S1w5JfWwLeVfrQwLE3eNw=;
        b=QrfL2Bjw2F+Wq2+6pqoaXERMdikOYlByN3VP20q3c4K1F391BcEqS7oFNXPrjUjmwa
         3K74MEmVSZri0BteMeZReHDe3X26V+hgEXwqvJcy3X4mjFe+c/OaogVd1XQ/IUCGEjW2
         Or46b/n0pVbE/3GnPVVKBQwBsYXmjJF17yrecibsnci+mgAb3u9bs0UIKUltnW4aEwmH
         NmDaiEBXBtlZIjsZJ99MXV9JFF84UmwdrcJ5XzjBYKlG7nIuOmffDKUsOe1Xi7YAOur+
         5RxPYVtv8AmA7Jats1Hypr9iO2rESv0tFKPdvmoU2r9CysSGBOZD+WNGc6v1mqjV2KIq
         pUNw==
X-Gm-Message-State: AOJu0YwNWimlvkt7RBRfIhy71KqZM4kCTrLcFZHRcgD2NPmDqEPOSMBz
	+xsGERXjTY2k2RoEincaYDfFfK5Qte+oLcHwrir6qTOEoB6JwgpdYdG23Hgjfy2tcS2GWCK935h
	avM2Ghk93wbz+01VHAt1H0YBACZB9whf5iFf8eeBaQDEzRMpP8ysm37g=
X-Google-Smtp-Source: AGHT+IGtblVugrZccSMIJrt09qzoFz/sSGXp6RqIik+JWc40GE8lEuOlo5P4Mp+zXI2GBr+TovQ7XI+xjp1Kt6bHiJJJnOPGQ0n2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4603:b0:3d2:b509:af44 with SMTP id
 e9e14a558f8ab-3d5960f5b68mr143701025ab.8.1742882141978; Mon, 24 Mar 2025
 22:55:41 -0700 (PDT)
Date: Mon, 24 Mar 2025 22:55:41 -0700
In-Reply-To: <67da6f4b.050a0220.3657bb.013b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e2455d.050a0220.a7ebc.003a.GAE@google.com>
Subject: Re: [syzbot] #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
 usb-testing
From: syzbot <syzbot+701fc9cc0cb44e2b0fe9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
Author: gshahrouzi@gmail.com

>From 5579a2ebd3af1677dd0bce895328ffb92d014cc6 Mon Sep 17 00:00:00 2001
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Mon, 24 Mar 2025 19:45:55 -0400
Subject: [PATCH] media: Fix invalid link creation when source entity has 0
 pads

This patch addresses the warning triggered in the media_create_pad_link()
function, specifically related to the check WARN_ON(source_pad >=
source->num_pads). The fix proposed adds an additional check to ensure that
source->num_pads is non-zero before proceeding with the
media_create_pad_link() function.

Reported-by: syzbot+701fc9cc0cb44e2b0fe9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=701fc9cc0cb44e2b0fe9
Fixes: a3fbc2e6bb05 ("media: mc-entity.c: use WARN_ON, validate link pads")
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/media/usb/uvc/uvc_entity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
index cc68dd24eb42..5397ce76c218 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -43,7 +43,7 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
 		source = (UVC_ENTITY_TYPE(remote) == UVC_TT_STREAMING)
 		       ? (remote->vdev ? &remote->vdev->entity : NULL)
 		       : &remote->subdev.entity;
-		if (source == NULL)
+		if (source == NULL || source->num_pads == 0)
 			continue;
 
 		remote_pad = remote->num_pads - 1;
-- 
2.43.0


