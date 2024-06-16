Return-Path: <linux-kernel+bounces-216319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8669F909DD9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 15:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE15E2813EA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C758831;
	Sun, 16 Jun 2024 13:58:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83399748D
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718546284; cv=none; b=NCjGFkt4gKMIijg2/H1PojqJ0wesp4uvsgq5q9oT3ZrQ7GpIPBm9oICTm017zy6W2UUtIzhf82+yUhCGu8Ip1nIpkkkXehB6dA/0d2bgXj+Y3PrmPAZA6e1XzxDVAVSE6NFn5WPodket+llHNU41udaz7mCth5TWQQ6j8J9LGs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718546284; c=relaxed/simple;
	bh=R8D1G0qfWWHzcx64E0FlfEyHwSbRESfbtORt/2rhmFA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=b8Z7aeao2CIlfR33UmG3Hx7tgUD/zCLLv7idgn+Zm7g7tOZQYdKFgInEle2DfHllkEmyjHk4icD00mQ8zrkqAwGJ9GGoMIVYxDK3JO+A48Mm9j8sg3jdnZzZsxKI93+jJBohFQl0rpypfaAcdiMIJmK/wIlDxnRlRCmRUuNMW2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-375da994725so35964745ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 06:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718546282; x=1719151082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5811IuiggWB0+7BglON7P/ruGNAO15FPLwXOim6X9k=;
        b=jjgy1Xrc/FgaPXdyQ6sCfaxu/PI0sMkKu2olyLexWAs4nYMDaq8F9f2thK1nImdM6i
         Ofri41IA3PUkPuWUn/H0m0g8vrm6+/owLtSD9UwSOYtfTb0BVQuF3dK+8oBMmkyKfqvx
         54fvxbse5/u556jliZg780myCCZSm8T6p46sUijvtPSLwofxitJmPNXdl/2STB9SbRhz
         d8dsVVBMixWPB+kZQltO2CufRc6XzaW0A8AC6J0Z8frwJYg5rVJoKW+k6+yL1tTyVE//
         lIO3abxusYCHYZ5FTycW/MCcN+1mr6oOBhYL5h2rsIK47t7o0veSPHC4GH32GQwWmKsn
         UBVg==
X-Forwarded-Encrypted: i=1; AJvYcCVE6L/ElYFd0YWmAHBMMLpEDeLMq2lbWyA8hO+S6p5QmltMsbvqP8e/ofYc6HkJxklwBJAPRKpiRGER7Y1hnvz7PIGQ8MBbvGQUvq83
X-Gm-Message-State: AOJu0Yzd2vkm2vrcuHQOW4/nrXFo2dpPa3ZJlLOLXoPtvNflA7hF+1pb
	dezOoLHLkzq0YKoOUoqTHDyGiiq9Q4dRKg/lkNG7Fo09bnMXVgQ/2qwgpeP3Dg4oja6BHb2bx38
	s6cXS2asm/Inict9Zz3ivXrQwTJnBcYu/RkPX3EWsS2p/UIIwVMDUFjk=
X-Google-Smtp-Source: AGHT+IGFhucqrSCq9TEv7yGJ6u12fMOz5B3+YnK6tfWYh0JCygGdWpFlX4LG4Qt8mHnmbUawHdfGJN1+QEiHrN08KkDH7s12kkfj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164e:b0:375:ae17:a2aa with SMTP id
 e9e14a558f8ab-375e0e9fc29mr5779515ab.3.1718546282638; Sun, 16 Jun 2024
 06:58:02 -0700 (PDT)
Date: Sun, 16 Jun 2024 06:58:02 -0700
In-Reply-To: <20240616111502.1435-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5018c061b023c99@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
From: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

./include/linux/fs_pin.h:4:8: error: redefinition of 'fs_pin'
./include/linux/fs_pin.h:14:20: error: redefinition of 'init_fs_pin'
fs/mount.h:8:8: error: redefinition of 'mnt_namespace'
fs/mount.h:21:8: error: redefinition of 'mnt_pcp'
fs/mount.h:26:8: error: redefinition of 'mountpoint'
fs/mount.h:33:8: error: redefinition of 'mount'
fs/mount.h:82:29: error: redefinition of 'real_mount'
fs/mount.h:87:19: error: redefinition of 'mnt_has_parent'
fs/mount.h:92:19: error: redefinition of 'is_mounted'
fs/mount.h:102:20: error: redefinition of '__path_is_mountpoint'
fs/mount.h:110:20: error: redefinition of 'detach_mounts'
fs/mount.h:117:20: error: redefinition of 'get_mnt_ns'
fs/mount.h:124:8: error: redefinition of 'proc_mounts'
fs/mount.h:133:20: error: redefinition of 'is_local_mountpoint'
fs/mount.h:141:20: error: redefinition of 'is_anon_ns'
fs/mount.h:146:20: error: redefinition of 'move_from_ns'


Tested on:

commit:         83a7eefe Linux 6.10-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=5d34cc6474499a5ff516
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1606492e980000


