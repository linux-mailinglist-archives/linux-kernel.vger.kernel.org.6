Return-Path: <linux-kernel+bounces-392202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884C79B90F2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C35283428
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCC219D8BE;
	Fri,  1 Nov 2024 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rYS1Ra6q"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1F019CC27
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462982; cv=none; b=Ku8oznGDPvblRVAtodjHehyZAi6TRa730nx0HfLNcBbB9yXr+1vS1iuEqCWFmqNJBIuRXaIrADSVtOrTTRATabb5SFh5h+pSgotkXXhljNFkz8OeqvVBZVgqBttl/kOetySQDUYjs9XEjNEL+2/zf2DTThjHZFOMdLWbx/kkjy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462982; c=relaxed/simple;
	bh=l1Tx/Mqp1DVL84/pLx+PjPiMjamTKbGhAoU3aGACmdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=daGmsZ19zTlYOUmcfRHRDXF6bbr3yPelpNkx2zkmfm6A+zUt/KSwKbNybIMNEscgI130rv6kM2TAd3+ZUw1zGZN9Kdi9SE5iz25HM/Ca0FXY7CzNVl2BwDLjTHDjmZkLsbGkduU0gtXZkLiTji+aRoH6Bl3QIM2yT6ZK2HFUAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rYS1Ra6q; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso1578010a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730462979; x=1731067779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Hw06b8/XBSAITLf2piQYNBwQQ0z9h7/JKyFJjuUl/c=;
        b=rYS1Ra6qLcWy8HlgezBz/IzF/W872EW+td12irG9Nz9NpMuCSnNBYkM8THoRqdZ8Wt
         3wlKtquHaoYZzezYvrbtDt5IubVOnYeZngj3JL+GEu0nCVbLjCSqxxPDdO+zDZQcUDI/
         EhfMw6YaJAm8WzeYj7Sq9F0/V+rkC818WkN35pAipXnlC9XF0dixmexsvElWj5OIs9lT
         Pm2/x50KiU6r6tpVzyOrq6T5HxjK+KrgFYu7kEb4kAVj1uXN11mrefL9ew4G4L1EPJNS
         zwgOxz6R8bLx9MW3EYrOxLaKNWesw1abyXJ5s8uZBfzS9r0KumH2q8dbrO6LMD1YAg7n
         mABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730462979; x=1731067779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Hw06b8/XBSAITLf2piQYNBwQQ0z9h7/JKyFJjuUl/c=;
        b=SvUAjNrKtelIPyyzjPWd2Og3IKhDEa/Gd04xrdiibi7n0YBNUJXmt2r8MVE1/zakxo
         UtoF0qZz7LrV2LII4/4kh2l8p7xMv8bNPOFONqhU9T1gQMj7/IhCZz9EOQMKObC6+H+f
         c+koZKYugpokGGi+B4ot64S9XKlDSujP2iZlgIIlq7L9D19YrH8LxiwZd8759bCI/C9F
         k8YpqfxHpkiIEsriZPW60B7T/NdyQPA6URN/0woYIXM6MayCdGRpVpMDDjot2rvoMJr6
         9azZ+1E2TnnhFm2lQ/OUfJA3VdOGogUeJxHY7U3dDOivi51S/KLY7azvRp/w8P/OpAPX
         8i0A==
X-Forwarded-Encrypted: i=1; AJvYcCXRatbBLDJ+bicqNUbNmc5VbbJXAGyQCYf50yY8k2DAtuhM1OjBujTh62GyWHMidzEwnG/fyUmxLmaLVPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+K6CwQd4AQMDPn4oBR/1zWr4mIkkLTuAF5+ZgGnqTZ54N5Jku
	Hf9YQTqeAVHey2V5Ia2/E+GE3Ye539c3WVHHKo+v5pE78JR2fnu8xtwGsyc/hI2f7dUZn8EkiFu
	T6N2tz89kFqh8ZcJMMmu5bEclZYNoFGXw3d4x
X-Google-Smtp-Source: AGHT+IF5RsxrkU7RnBDrWCERFHp/phaVhnDnjzEPKD1Zfn0ZTcAn+P8iVv9SsYXnTvR1ARVmNpRkdcYvTanyF6RTtt8=
X-Received: by 2002:a17:90b:2f03:b0:2e2:8995:dd1b with SMTP id
 98e67ed59e1d1-2e93c1591e5mr8521696a91.3.1730462979114; Fri, 01 Nov 2024
 05:09:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c6b63e97-6839-4beb-bb94-e5914837a041@lucifer.local>
 <6723b31e.050a0220.35b515.0165.GAE@google.com> <2928b6e8-3928-411d-82b8-6b17be266deb@lucifer.local>
 <CANp29Y6OdSOrP4q+1QL9bZU7SnDkMvmSAkFAGM0VqX9gwnZghg@mail.gmail.com> <2023ed50-9aa4-4bc9-8283-82a84c55bc36@lucifer.local>
In-Reply-To: <2023ed50-9aa4-4bc9-8283-82a84c55bc36@lucifer.local>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 1 Nov 2024 13:09:24 +0100
Message-ID: <CANp29Y58o0O8jTSP_SpBLVp7VK0bM4Svo7jBNZgDpv=s1DWJqQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] [input?] [usb?] INFO: rcu detected stall in brk (2)
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: syzbot <syzbot+7402e6c8042635c93ead@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, jannh@google.com, liam.howlett@oracle.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	Alan Stern <stern@rowland.harvard.edu>, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 12:11=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Nov 01, 2024 at 12:02:25PM +0100, Aleksandr Nogikh wrote:
> > Hi Lorenzo,
> >
> > On Thu, Oct 31, 2024 at 5:59=E2=80=AFPM 'Lorenzo Stoakes' via syzkaller=
-bugs
> > <syzkaller-bugs@googlegroups.com> wrote:
> > >
> > > +Alan re: USB stalls
> > >
> > > On Thu, Oct 31, 2024 at 09:41:02AM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot has tested the proposed patch and the reproducer did not tri=
gger any issue:
> > > >
> > > > Reported-by: syzbot+7402e6c8042635c93ead@syzkaller.appspotmail.com
> > > > Tested-by: syzbot+7402e6c8042635c93ead@syzkaller.appspotmail.com
> > > >
> > > > Tested on:
> > > >
> > > > commit:         cffcc47b mm/mlock: set the correct prev on failure
> > > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/=
mm.git/ mm-hotfixes-unstable
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1304a63=
0580000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6648774=
f7c39d413
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D7402e6c80=
42635c93ead
> > > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils=
 for Debian) 2.40
> > > >
> > > > Note: no patches were applied.
> > > > Note: testing is done by a robot and is best-effort only.
> > >
> > > OK this seems likely to be intermittant (and unrelated to what's in
> > > mm-unstable-fixes honestly) and does make me wonder if the fix refere=
nced
> > > in [0] really has sorted things out? Or whether it has perhaps help
> > > mitigate the issue but not sufficiently in conjunction with debug thi=
ngs
> > > that slow things down.
> > >
> > > Because we keep getting these reports, that mysteriously don't occur =
if we
> > > re-run (or hit other code paths), they seem to hit somewhat arbitrary=
 parts
> > > of mm, and because CONFIG_DEBUG_VM_MAPLE_TREE is set we spend a _long=
_ time
> > > in mm validating trees (this config option is REALLY REALLY heavy-han=
ded).
> > >
> > > I note we also set CONFIG_KCOV and CONFIG_KCOV_INSTRUMENT_ALL which i=
sn't
> > > going to make anything quicker if the USB gets laggy.
> >
> > These are necessary for coverage-guided fuzzing. Though when we find
> > and run reproducers, we don't actually set up /dev/kcov, so I guess
> > the impact of coverage callbacks here is not that significant here.
> > CONFIG_KASAN is likely slowing down things much more.
> >
> > >
> > > I'm not sure if there's a human who can help tweak the config for the=
se
> > > hardware-centric tests at Google? At least tweaking the RCU stall tim=
e
> > > anyway?
> >
> > We currently set:
> >
> > CONFIG_RCU_CPU_STALL_TIMEOUT=3D100
> > CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=3D21000
> >
> > The expedited RCU timeout was limited to 21 seconds up to some time
> > ago, but I guess now we can safely increase this number as well. I'll
> > send a PR with syzbot config updates.
>
> Ah thanks, just sent a reply immediately prior to receiving this :)
>
> Maybe worth setting CONFIG_RCU_EXP_CPU_STALL_TIMEOUT to 0 so it matches t=
he CPU
> stall timeout? At least for builds that also set heavy debug options like
> CONFIG_DEBUG_VM_MAPLE_TREE?

Oh, that's even simpler than I thought it would be, thank you!
I've sent https://github.com/google/syzkaller/pull/5455, it will come
into effect in a few days.

--=20
Aleksandr

>
> Cheers, Lorenzo
>
> >
> > --
> > Aleksandr
> >
> > >
> > > In any case this continues not to look likely to be an actual mm issu=
e as
> > > far as I can see.
> > >
> > > In [0] we were stalled in a validate call which would align with the =
idea
> > > that perhaps we were just dealing with a very very big tree and getti=
ng
> > > slow down that way.
> > >
> > > Cheers, Lorenzo
> > >
> > > [0]:https://lore.kernel.org/all/967f3aa0-447a-4121-b80b-299c926a33f5@=
rowland.harvard.edu/
> > >

