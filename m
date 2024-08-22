Return-Path: <linux-kernel+bounces-296785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E58195AF27
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60EF11C22C42
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D160917B51B;
	Thu, 22 Aug 2024 07:18:29 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E671B15CD78
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724311109; cv=none; b=ZNQ/X1xh5H7whTWpCH7EjhRyutnDetw70ESAzU4Z431HWFxJp/GUaftQujTLgVzo34TblzY9pwydoJT0gJ/V9muC26cmoL22gbUA3BBG30vBnPLXBN742eXU8Pzsbb8SHC3U9/fSZkLxEqYFt8FE+GWqARRKvGIWOuIz9zEFcVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724311109; c=relaxed/simple;
	bh=GvhhLckA/PmCDLeSJXJtYGvfadU2DCqKSojoaxhzvlc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lHWZq6t5RqFLR0Ei4KORk9q25BTFl6u//DMRqaw8/JEsX9rUo+BzeCKzGctrYc/kxuh/4XC/qVCmveyH+0qOgVBGeaAY1l9meHI6BuDX95m22KFFsMDPMp110hr7MSIeaYIHXp/JJSk4AOMrAvMWtEy6IrOD2rSy7v2il+Yxuug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8223c3509a9so49279639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724311107; x=1724915907;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Spoz+JYemuBGxynbdbIFmHF42sbylqQ6L0Hy+VVbIEA=;
        b=vy5oC47gsEtIW8BDL5EN0KYSirfnjh6VmUPI+VWHC8ywdS+pIaU+AFW7D9a1oHg4KX
         PNHnfCHPWXdvkzJmqbXRA4ur3mYTxv3eMdL0jKoPRc1oP1JdKQUfIpgb7U/ABZuuSiMX
         OU1876bSZ4F1x/P5YVraoabeeXmMLYb042x9ZLu5o4T8MRaOnETTDrysBwVXqg43pUOw
         htTDSTi+7sE1fSIK4rasiz8pN5hcTXevc4bQnEwo9FJspxUfdTWoDvc0t7HW48lEruoz
         L6yKKPpYzNS0Wl30U2ryiaqsD+Hq5mVghoK4UTQZ80R25+2vbJ5tksLAEGR0KI2+Eumr
         ngoQ==
X-Gm-Message-State: AOJu0YxoBEg8iUk+wRt+3HQ/oTZovklHd/I1Sef+4/Mvp9loYaRliIES
	aWOZ+oflCFFuVUKdOjsyLTUGkHM7B6Y2N5+9y2bU1yktqlgXjcDv9k1lSVO/GN0w59RKT7soQDd
	1kLxZ035Iu4nEVOWIEVMRnlKns8ch7vMioYmdj5nRJmW8WBS7TU/UBtU=
X-Google-Smtp-Source: AGHT+IFy4Medu9H1LDSOeGxlZmJjCHiHWb+nbluTXNjtkPz2IaOeuySfAmY1OSKrxptfeTme1uyUgSY9BedjzaSUOQeRE8Wdihpt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:62a7:b0:4c0:8165:c391 with SMTP id
 8926c6da1cb9f-4ce63029bddmr186278173.4.1724311106956; Thu, 22 Aug 2024
 00:18:26 -0700 (PDT)
Date: Thu, 22 Aug 2024 00:18:26 -0700
In-Reply-To: <000000000000ab44fc06203f0d28@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000033fee062040778e@google.com>
Subject: Re: [syzbot] Re: [syzbot] [jfs?] KASAN: slab-use-after-free Read in lmLogInit
From: syzbot <syzbot+d16facb00df3f446511c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [jfs?] KASAN: slab-use-after-free Read in lmLogInit
Author: lizhi.xu@windriver.com

why integrity chaneged?

#syz test: upstream df6cbc62cc9b

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 9609349e92e5..cc33178f720a 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1963,11 +1963,14 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
 {
 	struct bio *bio;
 	struct lbuf *bp;
+	int no_integrity = log->no_integrity;
 
 	/*
 	 * allocate a log buffer
 	 */
+	printk("log1: %p, integrity: %d, %s\n", log, log->no_integrity, __func__);
 	*bpp = bp = lbmAllocate(log, pn);
+	printk("log2: %p, integrity: %d, %s\n", log, log->no_integrity, __func__);
 	jfs_info("lbmRead: bp:0x%p pn:0x%x", bp, pn);
 
 	bp->l_flag |= lbmREAD;
@@ -1979,8 +1982,9 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
 
 	bio->bi_end_io = lbmIODone;
 	bio->bi_private = bp;
+	printk("log3: %p, integrity: %d, %s\n", log, log->no_integrity, __func__);
 	/*check if journaling to disk has been disabled*/
-	if (log->no_integrity) {
+	if (no_integrity) {
 		bio->bi_iter.bi_size = 0;
 		lbmIODone(bio);
 	} else {

