Return-Path: <linux-kernel+bounces-218368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFDE90BD70
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630392818E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054F91991B4;
	Mon, 17 Jun 2024 22:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjHwgs0a"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C18618FC60
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718662772; cv=none; b=WE9hxUDjVEnBAUQsqvdkAw9ONoY1ZkYIhdL57MC+A5QItzOzrnTuyGg1ujwFj5dTS7DIPH0OP+/jhIk/8U+qBZ9sA2J0Izf0xCV4LMDaKK9y3Kq6LOblvmFPqv3Km1b/kHb5VHfnWvmTh2yjrPieUbgqx1Tm3bhQ24MH0/2LzcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718662772; c=relaxed/simple;
	bh=/mZHW6NSnqSonVrj0SD7oYqmy05WyWu9doyMFUvqYe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izGw3GPFOq1B6MHmMolbI2dENhXlZxCTAXFgdSQHgGPVtEdPTwGEWtSZaI0PPFaBmyXQu1jZSk2M8wgxfnOVxW+Px2/KHJw5bkJ4eEg5e0LBhaNti7r0xtub9Per+Rk4/O691CznsUHFwcvRCoip1Pgmy1c/RtYOKL1QEDqqiZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjHwgs0a; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-24c9f628e71so2531556fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718662769; x=1719267569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBzUobYPaYXoDtpgUkUe8xVvA7zphpv+Q3YDBDgD3M4=;
        b=OjHwgs0arEXdOBzVnCZNKKURLdlvSG2qix0aOJxJFW7ejBtKfew5WRAJ3JPsdwBWa9
         EuVA4aQqAEvt92h22Gkf7F4dhn7i/Ygyu+OQpFeEUZfmngryM4ZFEzyWNLiDvXb4j8hT
         55AfHENbhFrjfkgd0HisUfnMCREgkCiyVey/nneAVpJunXpKXCqOW+/tjd3vzgfBBqqE
         4u/kgK6LgeWVaH++x6aaVLmxVUpr7E0Mgo2jtBVNsjCPTPU7iJHVQ+CGKVubG9K+91MX
         23PqpwyUpldsmBv9MtCafwNrAnpXcc05s08GbSVo1C62uItWLo1wcWAWAveGr8Wwy7sW
         U8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718662769; x=1719267569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBzUobYPaYXoDtpgUkUe8xVvA7zphpv+Q3YDBDgD3M4=;
        b=OceBDzahbmM50Sm/WiXpG++u2rllSjv3WSkvjRdAob/zHHWG4mdO9rGK8BZMn1Mh2J
         UJ1Z3pfrYyEhIiu4ui02VvbdcZl/BPTl9mlnREid1cxx+D8s0xM4z+0FUygfqsgrMAlN
         KNty/AaGksBC4R221jWWq1yEP8p01N0M7fwlh1yy3LF9tX/bybYjrmFYT3h3y4U9w/Xs
         2OiUKflwVln+5o4NbG+10JLpqQXFGp2wCyQ1bF9donkSG68b+tMNC3jcKlaC+oBLh6aJ
         XwLvL8HtHKoi3hkLcn4WaTEaUIL4qHqud5I40jnw7f/ZZ+2CgwDvnqhDAF1RdHVwri7a
         jdjg==
X-Forwarded-Encrypted: i=1; AJvYcCW1p1GjsWKvtJQunX/rTa9WaJcitISaZI51nj6NQaWAd2mV+uVg9ZJwAvkBIbf+VV0/4xdbj/GcJL58aWTyeHy+oXOPzU0wKBq+lWAK
X-Gm-Message-State: AOJu0YzJhuvwRI7HYrnP7wi0SNye5ckvfBKYMpq4u36Hj/jDi0WJMhXY
	z455q2/rtr5D0OXmHlwq9q6/u+r+aJ+Tf2sqAaUSAtj4aH9EMQO3O1ztgg3TdRhuTtI3MBZcf3s
	T0b/SzgTNU3YDVT0HgzYh/HNhpFY=
X-Google-Smtp-Source: AGHT+IG+82cWBOkchNnIARY4Whwz9Pjn2FhOySjsjl70SKRwO+d8nhl9dJm1IfShql70IVjc+b0nIajdzqsC2RviBaA=
X-Received: by 2002:a05:6870:7189:b0:254:963e:cc3f with SMTP id
 586e51a60fabf-258428535d0mr12940794fac.1.1718662768833; Mon, 17 Jun 2024
 15:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMOvFfkQscju1spNKHmEC_Rut+2=qfhKGZSvGhCk_nd5VhuDkg@mail.gmail.com>
 <4ce90767-7d85-47b0-9187-4eb8d257e7e0@leemhuis.info> <44dc1df5f5a1b740b76d1efbf607c49f9d50dda0.camel@sjtu.edu.cn>
 <06cbfba8-13a3-42a3-9262-98310b8ed0ad@leemhuis.info> <7159aa82cbff8eea90cce45fcfc7ecd30a632094.camel@sjtu.edu.cn>
 <CAMOvFfmSU=dFmY+NZQpAV9urLrJM612FvG4OusRVn1omQ_8c_w@mail.gmail.com> <457d6431e128a3ee7e053538ddf51578fbdb31f5.camel@sjtu.edu.cn>
In-Reply-To: <457d6431e128a3ee7e053538ddf51578fbdb31f5.camel@sjtu.edu.cn>
From: Winston Ma <winstonhyypia@gmail.com>
Date: Tue, 18 Jun 2024 06:19:17 +0800
Message-ID: <CAMOvFfnhfNdw-oF44x9S2ohkYG19Qnx=TJrzZoYmzVTku=u0gw@mail.gmail.com>
Subject: Re: [bug report] drm/amdgpu: amdgpu crash on playing videos, linux 6.10-rc
To: Wang Yunchen <mac-wang@sjtu.edu.cn>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Felix.Kuehling@amd.com, Xinhui.Pan@amd.com, 
	alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
	christian.koenig@amd.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As reported in my previous email. In my device I don't see a more
critical system freeze, which causes system reboot, during video play.
But I still experience green screen problem during full screen
toggling while watching video (Screenshot: https://ibb.co/8Dpdxc3). It
didn't cause my system to reboot but I guess there are bug to be
fixed.

Should this issue be monitored by another new ticket?

Thanks and Regards,
Winston

On Mon, Jun 17, 2024 at 5:40=E2=80=AFPM Wang Yunchen <mac-wang@sjtu.edu.cn>=
 wrote:
>
> On Mon, 2024-06-17 at 06:55 +0800, Winston Ma wrote:
> > I only build the kernel once. I could try but I think you couldn't
> > expect much from my side.
> >
> > BTW I installed 6.10-rc4 this morning from Ubuntu mainline
> > (https://kernel.ubuntu.com/mainline/v6.10-rc4/amd64/) and I couldn't
> > replicate the video crash problem. Yunchen could you try 6.10-rc4 and
> > see if you still have the video crash problem?
> >
> > But I still get the green blocky object when I keep toggling full
> > screen during youtube watch (Screenshot: https://ibb.co/8Dpdxc3). I
> > didn't see the green block in 6.9 so it could be another issue.
> >
> > Thanks and Regards,
> > Winston
> >
> >
> > On Sun, Jun 16, 2024 at 12:10=E2=80=AFAM Wang Yunchen <mac-wang@sjtu.ed=
u.cn> wrote:
> > >
> > > On Sat, 2024-06-15 at 17:50 +0200, Thorsten Leemhuis wrote:
> > > > [reply made easier by moving something in the quote]
> > > >
> > > > On 12.06.24 18:55, Wang Yunchen wrote:
> > > > > On Wed, 2024-06-12 at 15:14 +0200, Linux regression tracking (Tho=
rsten
> > > > > Leemhuis) wrote:
> > > > > > On 06.06.24 05:06, Winston Ma wrote:
> > > > > > > Hi I got the same problem on Linux Kernel 6.10-rc2. I got the
> > > > > > > problem
> > > > > > > by
> > > > > > > following the procedure below:
> > > > > > >
> > > > > > >  1. Boot Linux Kernel 6.10-rc2
> > > > > > >  2. Open Firefox (Any browser should work)
> > > > > > >  3. Open a Youtube Video
> > > > > > >  4. On the playing video, toggle fullscreen quickly Then afte=
r 10-
> > > > > > > 20
> > > > > > >     times of fullscreen toggling, the screen would enter free=
ze
> > > > > > > mode.
> > > > > > >     This is the log that I captured using the above method.
> > > > > >
> > > > > > Hmm, seems nothing happened here for a while. Could you maybe t=
ry to
> > > > > > bisect this
> > > > > > (
> > > > > > https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regr=
essions.ht
> > > > > > ml
> > > > > > )?
> > > > >
> > > > > It seems that the issue persists on 6.10 rc3.
> > > >
> > > > That's good to know, but...
> > > >
> > > > > > @amd-gfx devs: Or is this unneeded, as the cause found or maybe=
 even
> > > > > > fixed meanwhile?
> > > >
> > > > ...as there was no reply to that inquiry it seems we really need ei=
ther
> > > > you or Winston Ma (or somebody else that is affected we don't yet k=
now
> > > > about) to perform a git bisection (see the link quoted above) to fi=
nd
> > > > the exact change that broke things. Without this it might not be ge=
tting
> > > > fixed.
> > > >
> > > > Ciao, Thorsten
> > > >
> > > > > > > This is the kernel log
> > > > > > >
> > > > > > > 2024-06-06T10:26:40.747576+08:00 kernel:
> > > > > > > gmc_v10_0_process_interrupt:
> > > > > > > 6 callbacks suppressed
> > > > > > > 2024-06-06T10:26:40.747618+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > [mmhub] page fault (src_id:0 ring:8 vmid:2
> > > > > > > pasid:32789)
> > > > > > > 2024-06-06T10:26:40.747623+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > in process RDD Process pid 39524 thread
> > > > > > > firefox-bi:cs0 pid 40342
> > > > > > > 2024-06-06T10:26:40.747625+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:   in page starting at address
> > > > > > > 0x0000800106ffe000 from client 0x12 (VMC)
> > > > > > > 2024-06-06T10:26:40.747628+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > MMVM_L2_PROTECTION_FAULT_STATUS:0x00203811
> > > > > > > 2024-06-06T10:26:40.747629+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          Faulty UTCL2 client ID: VCN (0x1c)
> > > > > > > 2024-06-06T10:26:40.747631+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          MORE_FAULTS: 0x1
> > > > > > > 2024-06-06T10:26:40.747651+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          WALKER_ERROR: 0x0
> > > > > > > 2024-06-06T10:26:40.747653+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          PERMISSION_FAULTS: 0x1
> > > > > > > 2024-06-06T10:26:40.747655+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          MAPPING_ERROR: 0x0
> > > > > > > 2024-06-06T10:26:40.747656+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          RW: 0x0
> > > > > > > 2024-06-06T10:26:40.747658+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > [mmhub] page fault (src_id:0 ring:8 vmid:2
> > > > > > > pasid:32789)
> > > > > > > 2024-06-06T10:26:40.747660+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > in process RDD Process pid 39524 thread
> > > > > > > firefox-bi:cs0 pid 40342
> > > > > > > 2024-06-06T10:26:40.747662+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:   in page starting at address
> > > > > > > 0x0000800106e00000 from client 0x12 (VMC)
> > > > > > > 2024-06-06T10:26:40.747663+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> > > > > > > 2024-06-06T10:26:40.747664+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          Faulty UTCL2 client ID: MP0 (0x0)
> > > > > > > 2024-06-06T10:26:40.747666+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          MORE_FAULTS: 0x0
> > > > > > > 2024-06-06T10:26:40.747667+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          WALKER_ERROR: 0x0
> > > > > > > 2024-06-06T10:26:40.747668+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          PERMISSION_FAULTS: 0x0
> > > > > > > 2024-06-06T10:26:40.747670+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          MAPPING_ERROR: 0x0
> > > > > > > 2024-06-06T10:26:40.747671+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          RW: 0x0
> > > > > > > 2024-06-06T10:26:40.747674+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > [mmhub] page fault (src_id:0 ring:8 vmid:2
> > > > > > > pasid:32789)
> > > > > > > 2024-06-06T10:26:40.747677+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > in process RDD Process pid 39524 thread
> > > > > > > firefox-bi:cs0 pid 40342
> > > > > > > 2024-06-06T10:26:40.747680+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:   in page starting at address
> > > > > > > 0x0000800106e07000 from client 0x12 (VMC)
> > > > > > > 2024-06-06T10:26:40.747683+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> > > > > > > 2024-06-06T10:26:40.747686+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          Faulty UTCL2 client ID: MP0 (0x0)
> > > > > > > 2024-06-06T10:26:40.747688+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          MORE_FAULTS: 0x0
> > > > > > > 2024-06-06T10:26:40.747691+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          WALKER_ERROR: 0x0
> > > > > > > 2024-06-06T10:26:40.747693+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          PERMISSION_FAULTS: 0x0
> > > > > > > 2024-06-06T10:26:40.747696+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          MAPPING_ERROR: 0x0
> > > > > > > 2024-06-06T10:26:40.747698+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          RW: 0x0
> > > > > > > 2024-06-06T10:26:40.747700+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > [mmhub] page fault (src_id:0 ring:8 vmid:2
> > > > > > > pasid:32789)
> > > > > > > 2024-06-06T10:26:40.747703+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > in process RDD Process pid 39524 thread
> > > > > > > firefox-bi:cs0 pid 40342
> > > > > > > 2024-06-06T10:26:40.747705+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:   in page starting at address
> > > > > > > 0x0000800107001000 from client 0x12 (VMC)
> > > > > > > 2024-06-06T10:26:40.747707+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
> > > > > > > 2024-06-06T10:26:40.747710+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          Faulty UTCL2 client ID: MP0 (0x0)
> > > > > > > 2024-06-06T10:26:40.747713+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          MORE_FAULTS: 0x0
> > > > > > > 2024-06-06T10:26:40.747716+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          WALKER_ERROR: 0x0
> > > > > > > 2024-06-06T10:26:40.747718+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          PERMISSION_FAULTS: 0x0
> > > > > > > 2024-06-06T10:26:40.747721+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          MAPPING_ERROR: 0x0
> > > > > > > 2024-06-06T10:26:40.747723+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:          RW: 0x0
> > > > > > > 2024-06-06T10:26:51.094991+08:00 kernel: [drm:amdgpu_job_time=
dout
> > > > > > > [amdgpu]] *ERROR* ring vcn_dec_0 timeout,
> > > > > > > signaled seq=3D24897, emitted seq=3D24898
> > > > > > > 2024-06-06T10:26:51.095023+08:00 kernel: [drm:amdgpu_job_time=
dout
> > > > > > > [amdgpu]] *ERROR* Process information: process
> > > > > > > RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
> > > > > > > 2024-06-06T10:26:51.095025+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > GPU reset begin!
> > > > > > > 2024-06-06T10:26:52.305509+08:00 kernel: [drm] Register(0)
> > > > > > > [mmUVD_POWER_STATUS] failed to reach value 0x00000001
> > > > > > > !=3D 0x00000002n
> > > > > > > 2024-06-06T10:26:52.586019+08:00 kernel: [drm] Register(0)
> > > > > > > [mmUVD_RBC_RB_RPTR] failed to reach value 0x000003c0 !=3D
> > > > > > > 0x00000360n
> > > > > > > 2024-06-06T10:26:52.639506+08:00 kernel: [drm] Register(0)
> > > > > > > [mmUVD_POWER_STATUS] failed to reach value 0x00000001
> > > > > > > !=3D 0x00000002n
> > > > > > > 2024-06-06T10:26:52.639521+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > MODE2 reset
> > > > > > > 2024-06-06T10:26:52.650614+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > GPU reset succeeded, trying to resume
> > > > > > > 2024-06-06T10:26:52.650633+08:00 kernel: [drm] PCIE GART of 1=
024M
> > > > > > > enabled (table at 0x000000F41FC00000).
> > > > > > > 2024-06-06T10:26:52.650637+08:00 kernel: [drm] VRAM is lost d=
ue to
> > > > > > > GPU
> > > > > > > reset!
> > > > > > > 2024-06-06T10:26:52.650641+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > PSP is resuming...
> > > > > > > 2024-06-06T10:26:52.673474+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > reserve 0xa00000 from 0xf41e000000 for PSP
> > > > > > > TMR
> > > > > > > 2024-06-06T10:26:53.001513+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > RAS: optional ras ta ucode is not available
> > > > > > > 2024-06-06T10:26:53.013802+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > RAP: optional rap ta ucode is not available
> > > > > > > 2024-06-06T10:26:53.013816+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > SECUREDISPLAY: securedisplay ta ucode is not
> > > > > > > available
> > > > > > > 2024-06-06T10:26:53.013819+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > SMU is resuming...
> > > > > > > 2024-06-06T10:26:53.016519+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > SMU is resumed successfully!
> > > > > > > 2024-06-06T10:26:53.017502+08:00 kernel: [drm] DMUB hardware
> > > > > > > initialized: version=3D0x04000044
> > > > > > > 2024-06-06T10:26:53.677511+08:00 kernel: [drm] kiq ring mec 2=
 pipe
> > > > > > > 1 q
> > > > > > > 0
> > > > > > > 2024-06-06T10:26:53.958512+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring
> > > > > > > vcn_dec_0 test failed (-110)
> > > > > > > 2024-06-06T10:26:53.958536+08:00 kernel:
> > > > > > > [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume =
of IP
> > > > > > > block
> > > > > > > <vcn_v3_0> failed -110
> > > > > > > 2024-06-06T10:26:53.958539+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > GPU reset(1) failed
> > > > > > > 2024-06-06T10:26:53.958541+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > GPU reset end with ret =3D -110
> > > > > > > 2024-06-06T10:26:53.959180+08:00 kernel: [drm:amdgpu_job_time=
dout
> > > > > > > [amdgpu]] *ERROR* GPU Recovery Failed: -110
> > > > > > > 2024-06-06T10:26:55.261509+08:00 kernel: [drm] Register(0)
> > > > > > > [mmUVD_POWER_STATUS] failed to reach value 0x00000001
> > > > > > > !=3D 0x00000002n
> > > > > > > 2024-06-06T10:26:55.540507+08:00 kernel: [drm] Register(0)
> > > > > > > [mmUVD_RBC_RB_RPTR] failed to reach value 0x00000010 !=3D
> > > > > > > 0x00000000n
> > > > > > > 2024-06-06T10:27:04.407149+08:00 kernel: [drm] Register(0)
> > > > > > > [mmUVD_POWER_STATUS] failed to reach value 0x00000001
> > > > > > > !=3D 0x00000002n
> > > > > > > 2024-06-06T10:27:04.407252+08:00 kernel: [drm:amdgpu_job_time=
dout
> > > > > > > [amdgpu]] *ERROR* ring vcn_dec_0 timeout,
> > > > > > > signaled seq=3D24898, emitted seq=3D24898
> > > > > > > 2024-06-06T10:27:04.407257+08:00 kernel: [drm:amdgpu_job_time=
dout
> > > > > > > [amdgpu]] *ERROR* Process information: process
> > > > > > > RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
> > > > > > > 2024-06-06T10:27:04.407259+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > GPU reset begin!
> > > > > > > 2024-06-06T10:27:05.033745+08:00 kernel: ------------[ cut he=
re ]-
> > > > > > > ----
> > > > > > > -------
> > > > > > > 2024-06-06T10:27:05.033773+08:00 kernel: WARNING: CPU: 8 PID:
> > > > > > > 47039 at
> > > > > > > drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630
> > > > > > > amdgpu_irq_put+0x9c/0xb0 [amdgpu]
> > > > > > > 2024-06-06T10:27:05.033777+08:00 kernel: Modules linked in:
> > > > > > > nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
> > > > > > > nft_reject xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat
> > > > > > > nf_conntrack_netlink nf_conntrack nf_defrag_ipv6
> > > > > > > nf_defrag_ipv4 xt_addrtype nft_compat nf_tables libcrc32c
> > > > > > > br_netfilter
> > > > > > > bridge stp llc hid_logitech_hidpp usbhid
> > > > > > > xfrm_interface xfrm6_tunnel tunnel4 tunnel6 xfrm_user xfrm_al=
go
> > > > > > > uhid
> > > > > > > rfcomm snd_seq_dummy snd_hrtimer cmac
> > > > > > > algif_hash algif_skcipher af_alg overlay qrtr bnep binfmt_mis=
c
> > > > > > > uvcvideo videobuf2_vmalloc uvc videobuf2_memops
> > > > > > > videobuf2_v4l2 btusb btrtl videodev btintel btbcm
> > > > > > > snd_acp6x_pdm_dma
> > > > > > > snd_soc_dmic snd_soc_acp6x_mach amd_atl
> > > > > > > intel_rapl_msr btmtk videobuf2_common bluetooth mc
> > > > > > > intel_rapl_common
> > > > > > > snd_sof_amd_acp63 snd_sof_amd_vangogh
> > > > > > > snd_sof_amd_rembrandt iwlmvm snd_sof_amd_renoir snd_sof_amd_a=
cp
> > > > > > > snd_sof_pci snd_sof_xtensa_dsp amdgpu snd_sof
> > > > > > > edac_mce_amd mac80211 snd_sof_utils snd_pci_ps
> > > > > > > snd_hda_codec_realtek
> > > > > > > snd_amd_sdw_acpi kvm_amd soundwire_amd
> > > > > > > snd_hda_codec_generic soundwire_generic_allocation soundwire_=
bus
> > > > > > > 2024-06-06T10:27:05.033782+08:00 kernel:
> > > > > > > snd_hda_scodec_cs35l41_spi
> > > > > > > nls_iso8859_1 snd_hda_codec_hdmi
> > > > > > > snd_hda_scodec_component libarc4 kvm snd_soc_core snd_hda_int=
el
> > > > > > > snd_ctl_led snd_intel_dspcfg snd_compress
> > > > > > > snd_intel_sdw_acpi amdxcp snd_seq_midi ac97_bus crct10dif_pcl=
mul
> > > > > > > drm_exec snd_hda_codec polyval_clmulni
> > > > > > > snd_pcm_dmaengine snd_seq_midi_event gpu_sched polyval_generi=
c
> > > > > > > iwlwifi
> > > > > > > ghash_clmulni_intel snd_rpl_pci_acp6x
> > > > > > > drm_buddy sha256_ssse3 snd_hda_core snd_rawmidi snd_acp_pci
> > > > > > > drm_suballoc_helper snd_hda_scodec_cs35l41_i2c
> > > > > > > sha1_ssse3 drm_ttm_helper snd_acp_legacy_common snd_hwdep
> > > > > > > snd_hda_scodec_cs35l41 aesni_intel snd_pci_acp6x amd_pmf
> > > > > > > snd_hda_cs_dsp_ctls ttm crypto_simd snd_pci_acp5x
> > > > > > > snd_soc_cs_amp_lib
> > > > > > > asus_nb_wmi cs_dsp cryptd amdtee snd_seq
> > > > > > > snd_rn_pci_acp3x drm_display_helper snd_pcm asus_wmi
> > > > > > > snd_acp_config
> > > > > > > rapl wmi_bmof sparse_keymap snd_seq_device
> > > > > > > cfg80211 snd_soc_cs35l41_lib cec snd_soc_acpi ccp rc_core
> > > > > > > snd_timer
> > > > > > > i2c_algo_bit i2c_piix4 snd_pci_acp3x k10temp
> > > > > > > amd_sfh tee snd platform_profile soundcore
> > > > > > > serial_multi_instantiate
> > > > > > > amd_pmc acpi_tad
> > > > > > > 2024-06-06T10:27:05.033784+08:00 kernel:  joydev input_leds
> > > > > > > mac_hid
> > > > > > > serio_raw parport_pc ppdev lp parport
> > > > > > > efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4
> > > > > > > hid_multitouch nvme video ucsi_acpi hid_generic
> > > > > > > crc32_pclmul nvme_core typec_ucsi xhci_pci i2c_hid_acpi
> > > > > > > xhci_pci_renesas nvme_auth typec i2c_hid wmi hid 8250_dw
> > > > > > > 2024-06-06T10:27:05.033785+08:00 kernel: CPU: 8 PID: 47039 Co=
mm:
> > > > > > > kworker/u64:0 Tainted: G        W
> > > > > > > 6.10.0-061000rc2-generic #202406022333
> > > > > > > 2024-06-06T10:27:05.033787+08:00 kernel: Hardware name: ASUST=
eK
> > > > > > > COMPUTER INC. Zenbook UM5302TA_UM5302TA/UM5302TA,
> > > > > > > BIOS UM5302TA.311 01/17/2023
> > > > > > > 2024-06-06T10:27:05.033788+08:00 kernel: Workqueue: amdgpu-re=
set-
> > > > > > > dev
> > > > > > > drm_sched_job_timedout [gpu_sched]
> > > > > > > 2024-06-06T10:27:05.033789+08:00 kernel: RIP:
> > > > > > > 0010:amdgpu_irq_put+0x9c/0xb0 [amdgpu]
> > > > > > > 2024-06-06T10:27:05.033790+08:00 kernel: Code: 31 f6 31 ff e9=
 c0
> > > > > > > 05 2f
> > > > > > > e6 44 89 e2 48 89 de 4c 89 f7 e8 97 fc ff
> > > > > > > ff 5b 41 5c 41 5d 41 5e 5d 31 d2 31 f6 31 ff e9 9f 05 2f e6 <=
0f>
> > > > > > > 0b b8
> > > > > > > ea ff ff ff eb c3 b8 fe ff ff ff eb bc 0f
> > > > > > > 1f 40 00 90 90
> > > > > > > 2024-06-06T10:27:05.033791+08:00 kernel: RSP:
> > > > > > > 0018:ffffb65847227c18
> > > > > > > EFLAGS: 00010246
> > > > > > > 2024-06-06T10:27:05.033793+08:00 kernel: RAX: 000000000000000=
0
> > > > > > > RBX:
> > > > > > > ffff9ac0a0280c60 RCX: 0000000000000000
> > > > > > > 2024-06-06T10:27:05.033794+08:00 kernel: RDX: 000000000000000=
0
> > > > > > > RSI:
> > > > > > > 0000000000000000 RDI: 0000000000000000
> > > > > > > 2024-06-06T10:27:05.033796+08:00 kernel: RBP: ffffb65847227c3=
8
> > > > > > > R08:
> > > > > > > 0000000000000000 R09: 0000000000000000
> > > > > > > 2024-06-06T10:27:05.033797+08:00 kernel: R10: 000000000000000=
0
> > > > > > > R11:
> > > > > > > 0000000000000000 R12: 0000000000000000
> > > > > > > 2024-06-06T10:27:05.033798+08:00 kernel: R13: 000000000000000=
1
> > > > > > > R14:
> > > > > > > ffff9ac0a0280000 R15: ffff9ac0a0280000
> > > > > > > 2024-06-06T10:27:05.033799+08:00 kernel: FS:
> > > > > > > 0000000000000000(0000)
> > > > > > > GS:ffff9ac38e600000(0000)
> > > > > > > knlGS:0000000000000000
> > > > > > > 2024-06-06T10:27:05.033800+08:00 kernel: CS:  0010 DS: 0000 E=
S:
> > > > > > > 0000
> > > > > > > CR0: 0000000080050033
> > > > > > > 2024-06-06T10:27:05.033802+08:00 kernel: CR2: 00007d1a5edfe00=
0
> > > > > > > CR3:
> > > > > > > 000000001863c000 CR4: 0000000000f50ef0
> > > > > > > 2024-06-06T10:27:05.033803+08:00 kernel: PKRU: 55555554
> > > > > > > 2024-06-06T10:27:05.033805+08:00 kernel: Call Trace:
> > > > > > > 2024-06-06T10:27:05.033806+08:00 kernel:  <TASK>
> > > > > > > 2024-06-06T10:27:05.033807+08:00 kernel:  ? show_regs+0x6c/0x=
80
> > > > > > > 2024-06-06T10:27:05.033845+08:00 kernel:  ? __warn+0x88/0x140
> > > > > > > 2024-06-06T10:27:05.034598+08:00 kernel:  ?
> > > > > > > amdgpu_irq_put+0x9c/0xb0
> > > > > > > [amdgpu]
> > > > > > > 2024-06-06T10:27:05.034615+08:00 kernel:  ? report_bug+0x182/=
0x1b0
> > > > > > > 2024-06-06T10:27:05.034618+08:00 kernel:  ? handle_bug+0x51/0=
xa0
> > > > > > > 2024-06-06T10:27:05.034619+08:00 kernel:  ?
> > > > > > > exc_invalid_op+0x18/0x80
> > > > > > > 2024-06-06T10:27:05.034620+08:00 kernel:  ?
> > > > > > > asm_exc_invalid_op+0x1b/0x20
> > > > > > > 2024-06-06T10:27:05.034621+08:00 kernel:  ?
> > > > > > > amdgpu_irq_put+0x9c/0xb0
> > > > > > > [amdgpu]
> > > > > > > 2024-06-06T10:27:05.034623+08:00 kernel:  ?
> > > > > > > amdgpu_irq_put+0x55/0xb0
> > > > > > > [amdgpu]
> > > > > > > 2024-06-06T10:27:05.035573+08:00 kernel:
> > > > > > > gmc_v10_0_hw_fini+0x67/0xe0
> > > > > > > [amdgpu]
> > > > > > > 2024-06-06T10:27:05.035580+08:00 kernel:
> > > > > > > gmc_v10_0_suspend+0xe/0x20
> > > > > > > [amdgpu]
> > > > > > > 2024-06-06T10:27:05.035581+08:00 kernel:
> > > > > > > amdgpu_device_ip_suspend_phase2+0x251/0x480 [amdgpu]
> > > > > > > 2024-06-06T10:27:05.035582+08:00 kernel:
> > > > > > > amdgpu_device_ip_suspend+0x49/0x80 [amdgpu]
> > > > > > > 2024-06-06T10:27:05.036529+08:00 kernel:
> > > > > > > amdgpu_device_pre_asic_reset+0xd1/0x490 [amdgpu]
> > > > > > > 2024-06-06T10:27:05.036546+08:00 kernel:
> > > > > > > amdgpu_device_gpu_recover+0x406/0xa30 [amdgpu]
> > > > > > > 2024-06-06T10:27:05.036548+08:00 kernel:
> > > > > > > amdgpu_job_timedout+0x141/0x200 [amdgpu]
> > > > > > > 2024-06-06T10:27:05.036550+08:00 kernel:
> > > > > > > drm_sched_job_timedout+0x70/0x110 [gpu_sched]
> > > > > > > 2024-06-06T10:27:05.036551+08:00 kernel:
> > > > > > > process_one_work+0x186/0x3e0
> > > > > > > 2024-06-06T10:27:05.036552+08:00 kernel:
> > > > > > > worker_thread+0x304/0x440
> > > > > > > 2024-06-06T10:27:05.036554+08:00 kernel:  ?
> > > > > > > srso_alias_return_thunk+0x5/0xfbef5
> > > > > > > 2024-06-06T10:27:05.036555+08:00 kernel:  ?
> > > > > > > _raw_spin_lock_irqsave+0xe/0x20
> > > > > > > 2024-06-06T10:27:05.036556+08:00 kernel:  ?
> > > > > > > __pfx_worker_thread+0x10/0x10
> > > > > > > 2024-06-06T10:27:05.036557+08:00 kernel:  kthread+0xe4/0x110
> > > > > > > 2024-06-06T10:27:05.036558+08:00 kernel:  ?
> > > > > > > __pfx_kthread+0x10/0x10
> > > > > > > 2024-06-06T10:27:05.036559+08:00 kernel:  ret_from_fork+0x47/=
0x70
> > > > > > > 2024-06-06T10:27:05.036561+08:00 kernel:  ?
> > > > > > > __pfx_kthread+0x10/0x10
> > > > > > > 2024-06-06T10:27:05.036562+08:00 kernel:
> > > > > > > ret_from_fork_asm+0x1a/0x30
> > > > > > > 2024-06-06T10:27:05.036563+08:00 kernel:  </TASK>
> > > > > > > 2024-06-06T10:27:05.036564+08:00 kernel: ---[ end trace
> > > > > > > 0000000000000000 ]---
> > > > > > > 2024-06-06T10:27:05.036565+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > MODE2 reset
> > > > > > > 2024-06-06T10:27:05.046502+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > GPU reset succeeded, trying to resume
> > > > > > > 2024-06-06T10:27:05.047516+08:00 kernel: [drm] PCIE GART of 1=
024M
> > > > > > > enabled (table at 0x000000F41FC00000).
> > > > > > > 2024-06-06T10:27:05.047533+08:00 kernel: [drm] VRAM is lost d=
ue to
> > > > > > > GPU
> > > > > > > reset!
> > > > > > > 2024-06-06T10:27:05.047538+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > PSP is resuming...
> > > > > > > 2024-06-06T10:27:05.070481+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > reserve 0xa00000 from 0xf41e000000 for PSP
> > > > > > > TMR
> > > > > > > 2024-06-06T10:27:05.397519+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > RAS: optional ras ta ucode is not available
> > > > > > > 2024-06-06T10:27:05.409509+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > RAP: optional rap ta ucode is not available
> > > > > > > 2024-06-06T10:27:05.409517+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > SECUREDISPLAY: securedisplay ta ucode is not
> > > > > > > available
> > > > > > > 2024-06-06T10:27:05.409518+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > SMU is resuming...
> > > > > > > 2024-06-06T10:27:05.411482+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > SMU is resumed successfully!
> > > > > > > 2024-06-06T10:27:05.413504+08:00 kernel: [drm] DMUB hardware
> > > > > > > initialized: version=3D0x04000044
> > > > > > > 2024-06-06T10:27:06.055474+08:00 kernel: [drm] kiq ring mec 2=
 pipe
> > > > > > > 1 q
> > > > > > > 0
> > > > > > > 2024-06-06T10:27:06.335476+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring
> > > > > > > vcn_dec_0 test failed (-110)
> > > > > > > 2024-06-06T10:27:06.335495+08:00 kernel:
> > > > > > > [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume =
of IP
> > > > > > > block
> > > > > > > <vcn_v3_0> failed -110
> > > > > > > 2024-06-06T10:27:06.335498+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > GPU reset(2) failed
> > > > > > > 2024-06-06T10:27:06.335499+08:00 kernel: amdgpu 0000:03:00.0:
> > > > > > > amdgpu:
> > > > > > > GPU reset end with ret =3D -110
> > > > > > > 2024-06-06T10:27:06.335631+08:00 kernel: [drm:amdgpu_job_time=
dout
> > > > > > > [amdgpu]] *ERROR* GPU Recovery Failed: -110
> > >
> > > I'm limited by time and computing power, can Winston do a bisect?
> > >
> > > If Winston can't I can do a bisect, but don't expect results before
> > > days...
> > > I've only got this laptop and it's heavily used, so it really takes t=
ime.
> > >
> > > Best,
> > > Yunchen
>
> I'm switched to some rather obscure setup, so sorry I couldn't test the
> kernel. If it seemed okay on your side, then maybe this problem is now fi=
xed,
> considering some APU-specific fixes pulled from drm-next during the weeks=
.
>
> If there aren't any more case reports for the next few days then maybe we=
 can
> regard this as resolved?
>
> Best,
> Yunchen

