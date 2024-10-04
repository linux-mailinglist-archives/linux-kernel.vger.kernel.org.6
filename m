Return-Path: <linux-kernel+bounces-351413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AB29910A0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276541F26995
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5FC231CAD;
	Fri,  4 Oct 2024 20:32:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D655231C85
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073924; cv=none; b=SDHCvutGs8IYw2X512iJCG2dNOzAPya0zpOanu5Od8a89cX8TNsytiJBBdHSubuYy0czyKKE0OJogwMlklOQ3FP3sy36rD21eIR69pia4+B7Cri4JHqDu0hKEPv8+GeAvveDMlvqBZmTOvfceD8tKwOwtl6vLx8dKcbtm190Y1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073924; c=relaxed/simple;
	bh=pAOJWKcAkZSHJFHYNrsqn/eifMqWpJCZtqP9xZ/YN78=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ODGmhWlqL0GAFF6S91S5aGk4bkGJI8Ki6P6YsdV0ipzL6feiHhd/KbO/9UJ/6sBkDvG6NKLwDfrcuOKXdQ6TxT7HLyvTQePCaRWhcNdh5Z9z4xu61m8Pln7xKZegjb04lMEelYO96RdpKo8CV/vnjXHvPFaPuDX7NYA22mAjQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cf261659bso348740739f.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 13:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728073922; x=1728678722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KDZj8ZR5eJTu8r8Erb1fCbFIz+gdsYbjMxv3CKzv28Q=;
        b=qHLetZRLkduSJY61Hh5w8euFVeQgkllxTLLByaqgxDLCFOO9HOuIQeu0cy3db0u+M/
         uScRCrCdkS8nvWxVujwo22ziUuaXlBcJsxFfggqCEAtp0h7egZTbU+jiA5mQ4qTFlLUg
         beJaP6QR8SsG9IWxaVA17LVF5Uz3N6ETv9nbIEVg3hX0IownAy2grPNVMVyFB5g8SSSu
         MZsepdHM48aovlPi8D45vwVdqZjrwI2zDqtfFniDoRIYsZwpcKWSj4niqU23IFBL1Nfu
         snrUgk43mETgs5iJtve2S3agcpxVqbQQH+RrUvfIlDZbSP93rxnjzTOKm59lAE7NkXzg
         JDfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYOxHpQw7VuivNAnaURVuMyCZEiicjiJ5oavwk3gANxylCBcxlm+/38gYpk94mPru2G40ZF5URjffF20Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3XVuN8ulVmrSDXdTPBJ0k4KadJ5proYegcS7EDZJG3VokSu+m
	drCipeCHm0VC+cZthNII42vqy9PxPsnJ//ydNTDLITvjFjd4BjH9llKtSqh9TtdCELeMjHekENb
	Hru5OVdSZNWFwtttIPd8gYOO9zsdAt08DAQS4lqQ0p7ORakMZh5lgbSU=
X-Google-Smtp-Source: AGHT+IHjj2c1FkgKMosbzum83+wvJ2/rJlcK9Dy1o7ZkrzLNRM91dtnQeMacqcSCVNi+sxpnbqAjWJI6gKF2InuGTgRJs782GmWH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c24:b0:3a3:68bc:a16d with SMTP id
 e9e14a558f8ab-3a375badf5fmr43211105ab.18.1728073922436; Fri, 04 Oct 2024
 13:32:02 -0700 (PDT)
Date: Fri, 04 Oct 2024 13:32:02 -0700
In-Reply-To: <0000000000009afb860616fa87cf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670050c2.050a0220.49194.049e.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: rcu detected stall in rt_sigreturn
From: syzbot <syzbot+f87fd2bd13a4c9c5af8a@syzkaller.appspotmail.com>
To: bp@alien8.de, bristot@kernel.org, dave.hansen@linux.intel.com, 
	hpa@zytor.com, juri.lelli@redhat.com, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, vineeth@bitbyteword.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 5f6bd380c7bdbe10f7b4e8ddcceed60ce0714c6d
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon May 27 12:06:55 2024 +0000

    sched/rt: Remove default bandwidth control

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15678d80580000
start commit:   48cf398f15fc Merge tag 'char-misc-6.9-rc5' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=85dbe39cf8e4f599
dashboard link: https://syzkaller.appspot.com/bug?extid=f87fd2bd13a4c9c5af8a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152c59fd180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112d3227180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: sched/rt: Remove default bandwidth control

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

