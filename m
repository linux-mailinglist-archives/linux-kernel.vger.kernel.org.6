Return-Path: <linux-kernel+bounces-449773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0979F55E9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E71163106
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16111F8680;
	Tue, 17 Dec 2024 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7rezrHl"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368A91F76B1
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459593; cv=none; b=QQDcoVEte0+wJeRY37VmJ66vCksH72yHcA4aMyw+WDw1bal4E4zWrryUXr61M1NNa9vsqRg4UumelRnR2+anRSagEoe5tP1aeBJKgp6KFuhEVboLoFhLdJuckSBm5tvOw7X2mnCN5TbjXqv37OI1puYH2Nbq7bCEKoWMisSRWjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459593; c=relaxed/simple;
	bh=MDvxg5FsFGG4+BV/qBsDXRByXgMjSqP3g7Vqu6f+OhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nd4BSReDnE+WXoB3SvJP7n3ehwuqnd97ovkZ1lf8WxPMsT/cNDmtHUX0ari4naMGrhNXTF/jrR8+/FrWPxkO9Zzgrqj353m8dH+DKMRWOB3/bB8RDNa2jO0NfEdTnYbFudj5MegcSHLMh2k5FdlAt2VhBhmgeJEby0ZZ4H1MlAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7rezrHl; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30036310158so49170961fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734459589; x=1735064389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+P5DKogCq0v/GbW8OSiapHzXqgUsSnRh6uUJF+XX4Dc=;
        b=j7rezrHl5qFped639W0sC8fvj7NdBa/Kdklc4UUmlJ6pAkjUX47Fmo4szZeKhQ/Vyn
         kvayZe6buO/y9KTdeYeN22x1wpf6iSGUMD3aalfXsyGkg5Gt568IMCsht5iGNrBX1LFJ
         7/0Rk5w4PNvGRl4OGTmudberr9vGpsFBrHB4yd6UiBTlYzhgcQ7Sap7ZLGL7PvCK4Uj0
         Di8pcxQrKq2CSNIMTsTSBnMVi6dOuZl7zwi/M761Lnm1xjei1brCBQnLVTCNJQ8K3njw
         DKDc34dLkFKyZS/NLtw/jX3wIK95cJr6fBPzXXUKDl3VDUufmMA8k2G0ABApBTkRT/VQ
         77Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734459589; x=1735064389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+P5DKogCq0v/GbW8OSiapHzXqgUsSnRh6uUJF+XX4Dc=;
        b=CAdQ6rqeslO0Od0k+1sDNOmW7GNIDiJbR9rnFdhceOFHwukwVC6T6wIhQCDN2VFzqw
         3Li/TcGLFRo82CRc58Dhk+uvbtNcIrvsCTX80tFQ62oeGX4Zr3CtQVeGh1sFi8273RFl
         KXdvfkcGmMFHUH2WuNCH1qeUiHUZ+Ndk1TlUgQuLPL3GWANnxIQkmlBBSOo/LZScBQ1g
         qCi96O7oTYhU4Y34u0BAJF+etMV0VGxCfX4ogVOXKOji+BrEHuSBRrj8fJNmgOfZxlZB
         THDnva6XLChFMxTBUtxg7FcXqH2GSQzUwENu9a6T6ftpAtHfGAm/EY4WdeiZoL/H1mBC
         hxGA==
X-Forwarded-Encrypted: i=1; AJvYcCVkcdFNnZzdQyUckCqit1jq/XQqzaY0HWNgyqrPAShhGxlzKwIQ2RLGsBfvkiGXvSN39RZ6/ZcnggZZEIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztDGxyH10m8Hw1CYhQXFiM8KfgYDtERzbUutLq2AwsACxKdaV9
	htmqUjDvlmJkKqYvq52FZkMExBHYnmFKkFafdQmi5PSDK4jh1szHJuBTMZHDQVRMZ7GvoArWbHK
	CcMojGuWnLy2S649jU7oaAYYX4vrorCe7
X-Gm-Gg: ASbGncsqoCHeP0Zd0GB1kTerbnh7FevA4m0YQmoU83f0dwolF1yMCP6jHBFWGiOB7TA
	EKQdPkAMsBQkRgkG0lDwG0WtIPxM7MaGjbB0sEw==
X-Google-Smtp-Source: AGHT+IGf4SqADEjGfG+Ae8Wp6YpZfVo404b3p/VZyDrOJ4qRxgh5WLnRYubpxjPk1DK6HanjOIoImSB9jFtsULQit94=
X-Received: by 2002:a2e:be1a:0:b0:302:48fd:6922 with SMTP id
 38308e7fff4ca-3044db51c69mr249791fa.37.1734459588991; Tue, 17 Dec 2024
 10:19:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675d01e9.050a0220.37aaf.00be.GAE@google.com> <CAOUHufZ+UDx5pXD7b1pBC8P0Ubu1p2Z5r6Qx+ruT5g78q02Cxw@mail.gmail.com>
 <CAMgjq7BpdyJ=Q4OW4gEeCxP9PU5u=4Mp_Bd=uqr5iaosrQJMZg@mail.gmail.com>
 <CAMgjq7ArVJ8hhqLkuEJNVhhFX4BaFz8uDrZvXkHrDsESJpsWmw@mail.gmail.com>
 <CAOUHufYXqj5QqZ5Kv4CNn2HyeUGT6RidKGJ6Jp17NUGjqgKAXA@mail.gmail.com> <Z2Bz9t92Be9l1xqj@lappy>
In-Reply-To: <Z2Bz9t92Be9l1xqj@lappy>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 18 Dec 2024 02:19:32 +0800
Message-ID: <CAMgjq7DBphK_Ww2-s84irRK+NHWSnE3_rgjV=AHzVjr12wDbtg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in lock_list_lru_of_memcg
To: Sasha Levin <sashal@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks! Looking


Sasha Levin <sashal@kernel.org> =E4=BA=8E 2024=E5=B9=B412=E6=9C=8817=E6=97=
=A5=E5=91=A8=E4=BA=8C 02:39=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Dec 15, 2024 at 07:45:38PM -0700, Yu Zhao wrote:
> >Hi Kairui,
> >
> >On Sun, Dec 15, 2024 at 10:45=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> >>
> >> On Sun, Dec 15, 2024 at 3:43=E2=80=AFAM Kairui Song <ryncsn@gmail.com>=
 wrote:
> >> >
> >> > On Sat, Dec 14, 2024 at 2:06=E2=80=AFPM Yu Zhao <yuzhao@google.com> =
wrote:
> >> > >
> >> > > On Fri, Dec 13, 2024 at 8:56=E2=80=AFPM syzbot
> >> > > <syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com> wrote:
> >> > > >
> >> > > > Hello,
> >> > > >
> >> > > > syzbot found the following issue on:
> >> > > >
> >> > > > HEAD commit:    7cb1b4663150 Merge tag 'locking_urgent_for_v6.13=
_rc3' of g..
> >> > > > git tree:       upstream
> >> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D16e9=
6b30580000
> >> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfee2=
5f93665c89ac
> >> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D38a0cb=
d267eff2d286ff
> >> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutil=
s for Debian) 2.40
> >> > > >
> >> > > > Unfortunately, I don't have any reproducer for this issue yet.
> >> > > >
> >> > > > Downloadable assets:
> >> > > > disk image (non-bootable): https://storage.googleapis.com/syzbot=
-assets/7feb34a89c2a/non_bootable_disk-7cb1b466.raw.xz
> >> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/13e083329d=
ab/vmlinux-7cb1b466.xz
> >> > > > kernel image: https://storage.googleapis.com/syzbot-assets/fe384=
7d08513/bzImage-7cb1b466.xz
> >> > > >
> >> > > > IMPORTANT: if you fix the issue, please add the following tag to=
 the commit:
> >> > > > Reported-by: syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.c=
om
> >> > > >
> >> > > > ------------[ cut here ]------------
> >> > > > WARNING: CPU: 0 PID: 80 at mm/list_lru.c:97 lock_list_lru_of_mem=
cg+0x395/0x4e0 mm/list_lru.c:97
> >> > > > Modules linked in:
> >> > > > CPU: 0 UID: 0 PID: 80 Comm: kswapd0 Not tainted 6.13.0-rc2-syzka=
ller-00018-g7cb1b4663150 #0
> >> > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-=
debian-1.16.3-2~bpo12+1 04/01/2014
> >> > > > RIP: 0010:lock_list_lru_of_memcg+0x395/0x4e0 mm/list_lru.c:97
> >> > > > Code: e9 22 fe ff ff e8 9b cc b6 ff 4c 8b 7c 24 10 45 84 f6 0f 8=
4 40 ff ff ff e9 37 01 00 00 e8 83 cc b6 ff eb 05 e8 7c cc b6 ff 90 <0f> 0b=
 90 eb 97 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 7a fd ff ff 48
> >> > > > RSP: 0018:ffffc9000105e798 EFLAGS: 00010093
> >> > > > RAX: ffffffff81e891c4 RBX: 0000000000000000 RCX: ffff88801f53a44=
0
> >> > > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000=
0
> >> > > > RBP: ffff888042e70054 R08: ffffffff81e89156 R09: 1ffffffff2032ca=
e
> >> > > > R10: dffffc0000000000 R11: fffffbfff2032caf R12: ffffffff81e88e5=
e
> >> > > > R13: ffffffff9a3feb20 R14: 0000000000000000 R15: ffff888042e7000=
0
> >> > > > FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000=
000000000000
> >> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> > > > CR2: 0000000020161000 CR3: 0000000032d12000 CR4: 0000000000352ef=
0
> >> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000000000=
0
> >> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000000040=
0
> >> > > > Call Trace:
> >> > > >  <TASK>
> >> > > >  list_lru_add+0x59/0x270 mm/list_lru.c:164
> >> > > >  list_lru_add_obj+0x17b/0x250 mm/list_lru.c:187
> >> > > >  workingset_update_node+0x1af/0x230 mm/workingset.c:634
> >> > > >  xas_update lib/xarray.c:355 [inline]
> >> > > >  update_node lib/xarray.c:758 [inline]
> >> > > >  xas_store+0xb8f/0x1890 lib/xarray.c:845
> >> > > >  page_cache_delete mm/filemap.c:149 [inline]
> >> > > >  __filemap_remove_folio+0x4e9/0x670 mm/filemap.c:232
> >> > > >  __remove_mapping+0x86f/0xad0 mm/vmscan.c:791
> >> > > >  shrink_folio_list+0x30a6/0x5ca0 mm/vmscan.c:1467
> >> > > >  evict_folios+0x3c86/0x5800 mm/vmscan.c:4593
> >> > > >  try_to_shrink_lruvec+0x9a6/0xc70 mm/vmscan.c:4789
> >> > > >  shrink_one+0x3b9/0x850 mm/vmscan.c:4834
> >> > > >  shrink_many mm/vmscan.c:4897 [inline]
> >> > > >  lru_gen_shrink_node mm/vmscan.c:4975 [inline]
> >> > > >  shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
> >> > > >  kswapd_shrink_node mm/vmscan.c:6785 [inline]
> >> > > >  balance_pgdat mm/vmscan.c:6977 [inline]
> >> > > >  kswapd+0x1ca9/0x36f0 mm/vmscan.c:7246
> >> > > >  kthread+0x2f0/0x390 kernel/kthread.c:389
> >> > > >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >> > > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >> > > >  </TASK>
> >> > >
> >> > > This one seems to be related to "mm/list_lru: split the lock to
> >> > > per-cgroup scope".
> >> > >
> >> > > Kairui, can you please take a look? Thanks.
> >> >
> >> > Thanks for pinging, yes that's a new sanity check added by me.
> >> >
> >> > Which is supposed to mean, a list_lru is being reparented while the
> >> > memcg it belongs to isn't dying.
> >> >
> >> > More concretely, list_lru is marked dead by memcg_offline_kmem ->
> >> > memcg_reparent_list_lrus, if the function is called for one memcg, b=
ut
> >> > now the memcg is not dying, this WARN triggers. I'm not sure how thi=
s
> >> > is caused. One possibility is if alloc_shrinker_info() in
> >> > mem_cgroup_css_online failed, then memcg_offline_kmem is called earl=
y?
> >> > Doesn't seem to fit this case though.. Or maybe just sync issues wit=
h
> >> > the memcg dying flag so the user saw the list_lru dying before seein=
g
> >> > memcg dying? The object might be leaked to the parent cgroup, seems
> >> > not too terrible though.
> >> >
> >> > I'm not sure how to reproduce this. I will keep looking.
> >>
> >> Managed to boot the image and using the kernel config provided by bot,
> >> so far local tests didn't trigger any issue. Is there any way I can
> >> reproduce what the bot actually did?
> >
> >If syzbot doesn't have a repro, it might not be productive for you to
> >try to find one. Personally, I would analyze stacktraces and double
> >check the code, and move on if I can't find something obviously wrong.
> >
> >> Or provide some patch for the bot
> >> to test?
> >
> >syzbot only can try patches after it finds a repro. So in this case,
> >no, it can't try your patches.
> >
> >Hope the above clarifies things for you.
>
> Chiming in here as LKFT seems to be able to hit a nearby warning on
> boot.
>
> The link below contains the full log as well as additional information
> on the run.
>
> https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.13-rc2-=
232-g4800575d8c0b/testrun/26323524/suite/log-parser-test/test/exception-war=
ning-cpu-pid-at-mmlist_lruc-list_lru_del/details/
>

Thanks for the info, I'm trying to reproduce and checking the code.

There were similar WARN_ON s some years ago and these WARN_ON was
removed by commit 2788cf0c401c allowing nr_items to become a wrong
value, but as that commit message mentioned, that should not be a
problem. I added these back because the new lock_list_lru_of_memcg
should ensure a stable list_lru, so they might help catch wrong usage.
There could be some corner cases or synchronization issues that are
not well considered for these sanity checks, I'm looking at it. An
bold fix is just remove these WARN_ON as such wrong values might not
be harmful. I'll do more checks and tests locally and report back.


> --
> Thanks,
> Sasha

