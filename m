Return-Path: <linux-kernel+bounces-365510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FCE99E376
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2A928453D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE531E3782;
	Tue, 15 Oct 2024 10:09:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746021B85DB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728986946; cv=none; b=PJyNa6hZ9oxa8IpS6JcMqY4lUgKAbBBwey5/KMllZADmcaQXKvObv/5y4vowk4ii2KQGKqj7ihLOU4GkSx2Oczm+EGHCjf8h4Ah+Kj09x1PA1X+4ZuEqlHAJEos6GGBJwZnRIxl0AxJ2t2AWhegLYlHB51Ecvq3iaJSQ2IK+dr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728986946; c=relaxed/simple;
	bh=IWiPpCQxMvLF+uRCz+z9yoECRgrW+yEQRXfRrZIKtVY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d+7vkNaJ6w/FF7CtM/WIKvxdPq0ZxgWeV/DQRjURIQwezlAWUhadkWqNioOJfZlnCMvv4zdH7s8Ng8ASgGlFZX3O+MHEi48eMBbmoawELa695zPaHLW2FnGyRsDMjNjLk6IwX1hinFuQFmU80R7TbhTedkdqNP+/rvZT8tV7mFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3bcae85a5so20685745ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728986943; x=1729591743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ1XgZLD06jZgmdfCG0BxwXZqAtgXOjAbyLjBcsgS6M=;
        b=qMgmc0cLLHRuqELYUw1JNtlpuy2lv02qgn+TfBiNXtH89Lmx2E71DMmsOdyeB/OsqJ
         hS7qPN+gti1zow/j08WhDz5T+Dspkne7OY9A39rDQU+bsf/ptsrCMfgkklP9frf86n5C
         wsNO3D7wRAGBgoS0mfbvCskXCvnlpVqsIhnybW3HKwafpbE+9a9Y48jX5kDWuc0XRjYR
         Vemsu2RToSvmU0MmbLiPHOvDmIrijUCGrYI0e0UtwPXYtsxCIrDvFzPKAl394rQEak3x
         cuZui4XdgiyqUV9hLCqHqPuMFRDY18TsyOp+dnUePMP4Wq3YLQSF+ttxf3vCOH6sYW4/
         XWKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6vSyV3yqZ0Pw1T/A7GzlN7HPWlVQqjQ7ZzUNE4WtvrLsLdWtKVONx4rrpgPU2fyHFotijYHblt9+NVbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtntEH9HLhsV1lanNS747WihWkoF4gpoICG+2kImgNV3l9Cq1S
	4hrqR0rKWurJgG+nUe+t5vlKZ//0pp/9GpH6VLH1u20EK0/bQfxZti/qCgXCJD57VdBu6IKHrTw
	8QbUkzKK+KZPW+y7b6ij3sz5Cvb5lW8kNuZZAn6J1WRlAlxVNIT3voqQ=
X-Google-Smtp-Source: AGHT+IF1ACL8+aT3InlSzj0jgkv7uhzXC6SoU1xoFZig0zYBBt1vpWJKJJP0NyURctI+RjUawz8qZZtyWUOP4xk2iAc+NLmKXANC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3dc2:b0:39d:3c87:1435 with SMTP id
 e9e14a558f8ab-3a3a709de06mr122817055ab.1.1728986943585; Tue, 15 Oct 2024
 03:09:03 -0700 (PDT)
Date: Tue, 15 Oct 2024 03:09:03 -0700
In-Reply-To: <120ff6bf-3607-4f6b-9ec4-f1af9bdbdbd0@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e3f3f.050a0220.f16b.000b.GAE@google.com>
Subject: Re: [syzbot] [iomap?] WARNING in iomap_iter (3)
From: syzbot <syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com
Tested-by: syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com

Tested on:

commit:         ae54567e erofs: get rid of kaddr in `struct z_erofs_ma..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git erofs-for-6.12-rc4-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=17bac030580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=286b31f2cf1c36b5
dashboard link: https://syzkaller.appspot.com/bug?extid=74cc7d98ae5484c2744d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

