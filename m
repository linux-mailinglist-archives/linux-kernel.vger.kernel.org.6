Return-Path: <linux-kernel+bounces-195780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5837E8D51C7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 20:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9A11F24355
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFD64D9FB;
	Thu, 30 May 2024 18:29:20 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB074CE05
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717093760; cv=none; b=UnzpzzPAS5nvjyC4TxXbLrSyiwCZ70oyt1Ylc6iyicn1CUylnmKikPDsf6ZSKIHSsdp0C5IWUGfMNrwEHHxwVz8sIS6CJPe7UUOOvsfGNx7kOpiFGORidCcy3xufouBaK6MCobFcYc3jaVRVqALTtblS35i8JLF02/HHXEH/3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717093760; c=relaxed/simple;
	bh=UzKx2uEzqgslDAiwUDJyVu5c/uy6CYD26vc1Ic3/26A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iE8vX2QnUdpjc9/HGmXAogXo2NAPIWlDpuSTpVXs9ZU/O4T9at5UMZ6+MDRLx6YD5NfN9fxhyPDf2JNBIBM9fG285eDqyyYrN2Qd+N9UkXJ7sPTTamIXtUvKlPHUavw4fiwoo4nWWFRgVjhQDLpkF9JuKNWT3vwKHwRLoq9q08k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36db3bbf931so12311065ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 11:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717093758; x=1717698558;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzKx2uEzqgslDAiwUDJyVu5c/uy6CYD26vc1Ic3/26A=;
        b=KWDeDCWL2GjPVmBU98UtRZV/h0biomiRpNLVjnR2VO3mi6Il9L4Y/InKwnMU5md/Df
         ht4m22UI7tNBZKiSQ3KhKWis2h3y8B0PMNs7Xr/POvgo5e4+aSOr8wEUIG+n63qTdTVc
         GrMavwuScI/0G9k6PKoM/ECNZHpSM5Y35sq4icc3E86PdALNkoimpYqTyrp/zdG+o6yk
         qIUsXnM7nqBgpgo0gqD3aCIaQImmKZZgPX4t5689N5gJfBSqawxLyZ6GjzAjZExvRS0F
         cm7Lg2Izb9JwRea7+NEYby6oPLkihkHSKEOCfOYS2Jb3TrhED+nik7MC0kROUNpl1G6P
         AlXA==
X-Forwarded-Encrypted: i=1; AJvYcCXZDAAYBYjCHNiCo1GEpzQgKnPI5VXj+cyLu9S6joGTzRNxU/41WRbNG2XmEUHH4tnzPHAit1TGpEwwFN6WBOGsHV+KylbUFTfE4t+v
X-Gm-Message-State: AOJu0YydycDYfoQxzQ+xeVgA74JU2c3endUh3ayG0509cVbUqkckSYc1
	jYdd42OUqGHlGr5zj+jvDdRYHmEoxBWtouRZTYQvFcytHStfikjefTH0zd5CacTwWAW6Rlv6xHd
	uDPyQLQBOlJHzRocOZwAjvyWEYj86Cl6ExGsML1fLPk4nixla7qt8fgk=
X-Google-Smtp-Source: AGHT+IH1x3XrkPu1Mun4/eKZJ6gO0mFlPM7u5zN+ddEqmLrd9PtY15ot44oqSZaViQplKE0oLXI5P3hmpwbureOGoiGHSxU3Udsb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b26:b0:369:f7ca:a361 with SMTP id
 e9e14a558f8ab-3747df50c66mr2025035ab.1.1717093758401; Thu, 30 May 2024
 11:29:18 -0700 (PDT)
Date: Thu, 30 May 2024 11:29:18 -0700
In-Reply-To: <000000000000a62351060e363bdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000840b4e0619b00b9b@google.com>
Subject: Re: [syzbot] memory leak in ___neigh_create (2)
From: syzbot <syzbot+42cfec52b6508887bbe8@syzkaller.appspotmail.com>
To: alexander.mikhalitsyn@virtuozzo.com, davem@davemloft.net, den@openvz.org, 
	dsahern@kernel.org, edumazet@google.com, f.fainelli@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	nogikh@google.com, pabeni@redhat.com, razor@blackwall.org, 
	syzkaller-bugs@googlegroups.com, thomas.zeitlhofer+lkml@ze-it.at, 
	thomas.zeitlhofer@ze-it.at, wangyuweihx@gmail.com
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
net: stop syzbot

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=42cfec52b6508887bbe8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

