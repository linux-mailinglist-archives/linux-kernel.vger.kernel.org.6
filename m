Return-Path: <linux-kernel+bounces-368663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FC89A131E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C863281E25
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B4D18C323;
	Wed, 16 Oct 2024 20:02:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B57512E4A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729108925; cv=none; b=UgH0txH+6ybJ7JHnWqeYHfjitL4//WrZ+amFziAvNruY/nf/vJYwfawrUM5chXsR2GLbEvwJHNeowbBBPdj9Gg+1HI2F/rTPf2LtJORnh0q5/Pai5Ko9AG3PZvYY5fE4HRwzDm61EHwj7Mw+f+IGX+Ln4/8DAyuANmYIzGizMRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729108925; c=relaxed/simple;
	bh=/hM0GH8pP41hNOz3k4QArR0udcAUYYRNBFOhJ8Jjsy8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K4gvJd39/Yfd33upykFfFs9olTeJpzxT49gGmpBq2VsaHDfGJ8faxwoqLfbmXcBV7Q7qidzdMMECkWISWsdW/5XPUG+e0LUqCZOo++K4Wr8/PoIjElEeR4TBQ/Cd7ZNMHi+BtdsDKzWyjAJ6sKAbnx3QnjIali2p7xg5bOeH238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3cc9fa12dso2225035ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729108923; x=1729713723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qA0/1wwvCfN46pLupyOybJmqe7Gy+PVEf+xGhYJvatg=;
        b=sezeJCKV+DLDIT3FGc4AuF5CArGLEFjJ9aL0zA3uviUU1RPvET0cvkcNTku2xYGOjb
         f40XfqFYFwWKfFZEFHASOd16PbCcARIcxrH5KqaQklnHoZWtGJcMwvwiKtN9vBL+6U7c
         jiSAFzIZS2sSOFXO9MdiKA//aaPH172Dt0S880yj0f2HMjgACAatL430ge0KRLNioRNH
         aama+gxpAbZ8Yh+LJHdF4pJITyTi5QnMN7g7eVxIDvYyvgZQJnkTP0eqvs1BpEBDTyf5
         58pb/3haBWgIxpmle+iwtMjB5Fk2ACH9A05e1n+DST/vpEL+N35I/mEgwznQKTzOCy84
         RmJA==
X-Forwarded-Encrypted: i=1; AJvYcCVrfCUXlL0MLOjGzifVI70xKGSYeGKZYT19koLBZ89/llNItKLAogxaxYmwa8ReTK8iu/sIYE9AFFQx0as=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSG/+FMt1/1Vfh4KPl7muN/xVqE8fyZVuUxjTKZh9tCjtxMDpr
	FXuRCwIDVekgSBgXyeUEBv24AH3hp/ln2W+DH3RX7aeB1NPNYS4SWDGj5Nk6D56lUvBJlx/Zvef
	0iiJShBJfiEbw6GliY4790RT93ATsv5qTFmvRoFTgKje+E9zW5Yu4m98=
X-Google-Smtp-Source: AGHT+IHdummiZte34JlUd0vbwbpx6FGCj1sjek4YfaVhsLyzRma0nG5/1Vu7b7KTUro0wJFbZK4Yqf3WUT/k7+XMAvAQjicD141U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2185:b0:3a0:bd91:3842 with SMTP id
 e9e14a558f8ab-3a3bce0b188mr159670605ab.24.1729108923167; Wed, 16 Oct 2024
 13:02:03 -0700 (PDT)
Date: Wed, 16 Oct 2024 13:02:03 -0700
In-Reply-To: <53cfa80b-e1f9-4784-b725-e4e7b5c0cb4c@nvidia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67101bbb.050a0220.d5849.0019.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: cmeiohas@nvidia.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Tested-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com

Tested on:

commit:         89e9ae55 IB/hfi1: make clear_all_interrupts static
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14f6d030580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10527727980000

Note: testing is done by a robot and is best-effort only.

