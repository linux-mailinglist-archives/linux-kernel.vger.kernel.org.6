Return-Path: <linux-kernel+bounces-436307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B1E9E842B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 08:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C177188499E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 07:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758BE8249F;
	Sun,  8 Dec 2024 07:51:10 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889CCEEB2
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733644270; cv=none; b=CxEpFK4VyPAp557X84hzBxXhn9I4FkOOIzOyoB25Lr5KJIeUTSGxcOg97pskBpKsvTzuV/P2IT/exBNBAuDfYRNAPAmzy0py0AXCoK4+42R+CJaqXz7yf99cC0o2bFsnbtvcTE8B2Q2XZSh66snfluFfXrJ/Qd8xz220e+56On4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733644270; c=relaxed/simple;
	bh=1CXMJX7fliJETTaEQGyMqY3huxoTjwaj5udFvH6BHG4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sPaxo4zZUdVup6zcV5RLy59GZUYN3BYiPJqe4T3rHa0oVbPtY7RvMewYE7gM42M4GNgbla/U/oTBYola23ZHhq/XkiLuwBkp8qQqm38OrRPFWRPrdyAKB5m/wFY3Qomla+/4ZuHnfVFocD3vK60fCZ5jX5tLcZ1JVur8EKblq6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7cf41b54eso69853205ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 23:51:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733644267; x=1734249067;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgockp1ovx+gxm6JbllIqEY6NFVQ/Iij5zqmcVCT3wY=;
        b=VnCaTvtA+LD/p0Og4k/Ibqz7kF1muMfrVI7+5HTCv3pIDu3xC7F8oV5+lRtu3+vBsz
         oLVjrTGlXViv1KWUxlmohphwekgUw+8TWXWUMsAn5uqaAaN7DzEx5mKD3ccjpMH1E8To
         qdfSmM8s8iGlrSZMSGsjMK3MgYSklGtCRcR0VyY4/Ees4vAFUnoQKV90OcuA1CuTRSL4
         a1CWF+vsnCqi9jW7nHix3X1jNmt/LkloSUF+QMSKjFOTdeD0XN3W8CfsXLtFcPq6bVVo
         TgBloTEUmvC6//xaMpFylR12hEm5siMDrdxLA2KBde9EdgidDNtbjyKxqItG9ZygJdn5
         YHAQ==
X-Gm-Message-State: AOJu0YwSX40Cuh5ynFXFHyjTmJ4+AR+2jzPTAUeHS6ORSKTcPy7py1E/
	XnIxBRLyZxvDEHVjEfU2fbBv0521JZT8ErIDmfC/QlmrOSE2dNSUeCccX84rug8rNlDheyUpMRO
	bYjqKpBL9iJVnryfKdKMz+0Cm3KRmfbPKQS/TItL9aVOQKbLJgCsz7uU=
X-Google-Smtp-Source: AGHT+IGuoJG4BHIHTdxz1O0dYZvyfYju+uBR4tLt3h4FZ0C4Kbm6LuuzSqTviXeT+JTEFrOKYiRY1kEIFSHCCJBrT38JZNnxv4yW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56a:0:b0:3a7:7d26:4ce4 with SMTP id
 e9e14a558f8ab-3a811d9ab17mr88144615ab.9.1733644267753; Sat, 07 Dec 2024
 23:51:07 -0800 (PST)
Date: Sat, 07 Dec 2024 23:51:07 -0800
In-Reply-To: <67409091.050a0220.363a1b.013d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67554feb.050a0220.a30f1.0172.GAE@google.com>
Subject: Re: [syzbot] [PATCH] MTD: fix slab-use-after-free due to dangling
 pointer in notifier chain
From: syzbot <syzbot+0988a383ae7c57b99dd9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] MTD: fix slab-use-after-free due to dangling pointer in notifier chain
Author: dennis.lamerice@gmail.com

Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
---
#syz test

 drivers/mtd/ubi/wl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 4f6f339d8fb8..31a1e5515d98 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -1995,6 +1995,7 @@ static void protection_queue_destroy(struct ubi_device *ubi)
 void ubi_wl_close(struct ubi_device *ubi)
 {
 	dbg_wl("close the WL sub-system");
+	unregister_reboot_notifier(&ubi->wl_reboot_notifier);
 	ubi_fastmap_close(ubi);
 	shutdown_work(ubi);
 	protection_queue_destroy(ubi);
-- 
2.47.0


