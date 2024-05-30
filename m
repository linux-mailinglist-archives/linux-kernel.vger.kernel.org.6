Return-Path: <linux-kernel+bounces-194985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E86648D457B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE971C21381
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 06:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D23021018F;
	Thu, 30 May 2024 06:32:40 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1B4210193
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717050759; cv=none; b=lH7ziDTYNmLjiEKpaZtikYilT6qxxSjDCvObj5GN8DI5cf7f/MGO5tKc3ogiZ9qM2Z+8k6ZTmLTkS7rZfWVMRpuxBW+4O5HQ4ZVXoEBjnoFiRXi0hBjJ3bVKXam51WjLuYtHkwX7YzM7/ux3FWTPND6izB2KE1KeFp32LS4wjIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717050759; c=relaxed/simple;
	bh=m73+JFtuDXI0pMuUk/s+aCEjSp9eBPVjlEbNzZID2qs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=da5z3fnALSPzcCi55em1X/RoU0sEDu6q0ORAeh4Cn1eD/6yrpFrwJOL84SjIy+bL2f5xDsMM2wPnyLQQKoWiC7jHiPB7nZDCR0/Bewj8Q3gzDUAKI1NN/pw9xE3h1n+ZSTU8Hxc7blIEtc87Wn08cZTuKokKMGAKv/kkdN4Tn4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36eb89514a7so4081885ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 23:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717050757; x=1717655557;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxFuibeuJeiEGR3iN6+8GJivyXJzRIlIqBE5PU6nHHU=;
        b=SmYMBXmCnFaru64tV+5TEAQ0BC88Mgh5FRL2iVhw9Pvcw12gsrakbV0Xr5R7UCT0ud
         WluJOnu60v+SST9fMY365k9CGyZNt9Uhikxbtu0u+yBBKGAbrLzx/VQF2EcfSgnN+GgD
         eSU/HeOxCDOKE4aUdndUoF0qYrWUU8G6DntfSsb6Wbab2uo+S3++qlqIVYxBm/oFQELS
         eYjXMqvd7dfOl69jHkXLf1/NHvMPEq2EpymsWY46KTNvXruzULAUrIySwNLK6vQmgNq2
         IG9smG0jQYkFfrrypyY1QiBgbuSXgTwtUaVl1BnVT1iMh7Ffa4TKXimw3EiZ8eHbwZ4r
         tDiQ==
X-Gm-Message-State: AOJu0Yz8OcOD5UL14GfbHCBMYZUZoycBStGf3Vjyd4nQQZjbFOkH+4JF
	+q3UnpcAcYzpvRGCfhkux7NjNmUcakYGV7L9kSAJ+3QCRghWBrT6xGjKHAIXUbcjTzoiDN3vv/W
	2TdgZbHEmUjfA2JXS2WikdMPxTMubMZVCObbfyXREosXUjZwfge0SnPA=
X-Google-Smtp-Source: AGHT+IHjF25e7UEUWs00h3owUEAvAoEr20Gs5qaak4lAmZ8PF6NW8iA1etbJ6E2puHuZmPuyAox6B9632uwk6olu1FF15JFKu44H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218b:b0:36b:140e:a4c with SMTP id
 e9e14a558f8ab-3747e00e679mr504735ab.3.1717050757623; Wed, 29 May 2024
 23:32:37 -0700 (PDT)
Date: Wed, 29 May 2024 23:32:37 -0700
In-Reply-To: <000000000000cb987006199dc574@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007842d80619a6084a@google.com>
Subject: Re: [syzbot] Re: [syzbot] [fscrypt?] WARNING in fscrypt_fname_siphash
From: syzbot <syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [fscrypt?] WARNING in fscrypt_fname_siphash
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 74eca356f6d4

diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index deabe29da7fb..c8840cfc01dd 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -265,6 +265,10 @@ static int __ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 		__u64	combined_hash;
 
 		if (fscrypt_has_encryption_key(dir)) {
+			if (!IS_CASEFOLDED(dir)) {
+				ext4_warning_inode(dir, "Siphash requires Casefolded file");
+				return -2;
+			}
 			combined_hash = fscrypt_fname_siphash(dir, &qname);
 		} else {
 			ext4_warning_inode(dir, "Siphash requires key");

