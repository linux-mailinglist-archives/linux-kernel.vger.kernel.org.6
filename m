Return-Path: <linux-kernel+bounces-368783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F60A9A14E7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E794F1F22795
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65071D2B2F;
	Wed, 16 Oct 2024 21:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1Ch8fcqS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0282C1865E2
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114665; cv=none; b=efvzJnZFSB5zkzxLdoxFZ1EO+EAnFqUbuSJnHwzNiCE0KQdsLANBXsyRHSlJzwnbmz3F0+GkMOQNrsc8cqSlkPPtPs+LUbGSZ6h/K+aUN7OT6sgwjee5GdVy+B94M2BgeZgZFVVJFdH+KdQAsRRYd+Ig5FHzbvewRQlU594j020=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114665; c=relaxed/simple;
	bh=GC31XweGRffDUqbHOabMA23kCtlRwpz279XuOqaDFVw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dnR3lUqlEw20ZdgVp/4R9d+ZBS7sR9HbpSU5Xd6JNtrJZXwlSlh0H3KHhzvjA7Uj6kdsm0kyAPRKPgwJi0piIZNWA5207wmKDCFmOLathJLPQ/gp/Uk3bG5XC1v1xGtel6mrWBEqJCVAD2rK+GevBqbGakg5dIeEtj6aaFUqdLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1Ch8fcqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86988C4CEC5;
	Wed, 16 Oct 2024 21:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729114664;
	bh=GC31XweGRffDUqbHOabMA23kCtlRwpz279XuOqaDFVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1Ch8fcqS1DE1m975qHMKe6ECoXdyCLsUKuzhRmVZZnZ0j4bxALkD1dRmGn1tdfjrP
	 uNUjjUUoZSqoRtZXgnR2TF6aRAOTs+ZxW3NVDDMqnjp1wmhCp/SMgz5xWvb7YXc6wC
	 ZZjzsPHSW6ZgbHV+hIprW5jDYRXZYHIwEL3Nn7lk=
Date: Wed, 16 Oct 2024 14:37:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+30eac43568e2b3d65728@syzkaller.appspotmail.com>,
 linmiaohe@huawei.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com, vitaly.wool@konsulko.com
Subject: Re: [syzbot] [mm?] BUG: corrupted list in add_to_unbuddied
Message-Id: <20241016143743.675996b564d269419c129d29@linux-foundation.org>
In-Reply-To: <CANp29Y6czU3c-9FhdcyjfJtWrnaHJZ4o3WyY6TUeGo7TnP0KtQ@mail.gmail.com>
References: <000000000000c6b91e0621a312f4@google.com>
	<670e81a9.050a0220.d9b66.0153.GAE@google.com>
	<20241015153958.df4e735274e389999de60d2e@linux-foundation.org>
	<CANp29Y6czU3c-9FhdcyjfJtWrnaHJZ4o3WyY6TUeGo7TnP0KtQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 16 Oct 2024 08:19:25 +0200 Aleksandr Nogikh <nogikh@google.com> wrote:

> Hi Andrew,
> 
> On Wed, Oct 16, 2024 at 12:40 AM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 15 Oct 2024 07:52:25 -0700 syzbot <syzbot+30eac43568e2b3d65728@syzkaller.appspotmail.com> wrote:
> >
> > > syzbot has found a reproducer for the following issue on:
> > >
> > > HEAD commit:    eca631b8fe80 Merge tag 'f2fs-6.12-rc4' of git://git.kernel..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=14d0845f980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbd94c114a3d407
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=30eac43568e2b3d65728
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16df4c40580000
> >
> > Something seems rather wrong with the "syz repro" page.
> >
> >
> 
> What exactly looks wrong? :)

I click on the link
(https://syzkaller.appspot.com/x/repro.syz?x=16df4c40580000) and I get
the below garbage:

> >
> > # https://syzkaller.appspot.com/bug?id=6b5f76b3a3783e6b1876d25b2d7a981ac0e0131f
> > # See https://goo.gl/kgGztJ for information about syzkaller reproducers.
> > #{"threaded":true,"repeat":true,"procs":6,"slowdown":1,"sandbox":"none","sandbox_arg":0,"tun":true,"netdev":true,"resetnet":true,"cgroups":true,"binfmt_misc":true,"close_fds":true,"usb":true,"vhci":true,"wifi":true,"ieee802154":true,"sysctl":true,"swap":true,"tmpdir":true,"segv":true}
> > syz_mount_image$ntfs3(&(0x7f0000000000), &(0x7f0000000140)='./bus\x00', 0x19c6038, &(0x7f0000000180)=ANY=[], 0x1, 0x1f231, &(0x7f000003e780)="$eJzs3QmYTeUfB/D37Pu+XLvBWEO2RLLvsm+pZAvZyRalGhJRSSWpFElCQqhUEklEsi8JSZKQVEIS/2fu3JlmufOvadf7/TyPOfeee877nnu+94z5ne0ebz25edsGbRISEhKIzZAU50gGSSSJXIq9xsfGXYoNmdi/EZ3nV9ttftQreZxZcOVtoxYUXjVUa7/MfEsim+xOx09VOLwp3JT7+MW2vXoPSeg9JGHAwKEJXRO6DRw4tGu3fj0Suvce0rdsQst+PboO6ZHQe8CQHoMzvNyz38BBg0YmdB3Q3VAHDe4xZEhC1wEjE/r2GJkwdGDC0MEjE7re2rX3gISyZcsmGCqB36jd/H96CQAAAAAAAAAAAAAAAAAA4M9x6VLaoX0AAAAAAAAAAAAAAAAAAAC4TDVo3LR+OaKkPWcIQxoRhsxlCCH2L9OlXvfPZdNO8qRdoo9yRX82Sn10um/5fuf
> > <and a huge amount more>
> >


