Return-Path: <linux-kernel+bounces-212429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B408E906059
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D37C283327
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F090ABA2D;
	Thu, 13 Jun 2024 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJEcPGU3"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D87120E3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718241649; cv=none; b=ngOk0W7TVpG0aeE8HdGt8kbWGXetqqQLjgA+LxN0LUYMV2GvJ31As4W+54X9VtNeq3TQhMJgS8N+W8fvdHH96HONwZU9cQw9xAuiYGfS4rqbpA99uj8T0sTn2Oc+pWO5SM1wnUIca5XQp/1DtoY8LBWOCikktqV2tD2jaEdrRkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718241649; c=relaxed/simple;
	bh=IGZb7jJzJ+fYgo3pfxxlYggzSezW8VULYkGVcUUXaL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5a6zJAVF1+HiBVkGQ0uavcAjfcsUOcweEB73CvDSUzrh9db8KBNAetCILYNWqP6KmzKjFFtS5EJFzHj3KnmCCuRv70xcftOCKpUaG8raWEiFY3t+p30CNBjLLIaVQ9bKdigRUyPUJsOpAb5G2YfvRlDcV6CYaasbba8bXECLLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJEcPGU3; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-254871388d3so253792fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718241646; x=1718846446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wkEg0A6dLkLdYjqnlp/NhYfNHg7StDjTeCf/k0/xgQ=;
        b=bJEcPGU3XISfnfjlXbrUoc+5n58EGH8U0xd4yfoWrU3Wwf/IkLj5otiU5UUgOVlnCc
         83utxjD3PRiyUo9ahXGOwrbsOjP9Kdlc+Y4L4O4ImAKgUKl8/lz7ASVy5Wz3EylCDoWl
         dT2TIhWlXQ7IxnvRph0L2vNMEogU/aZfZv/MbJjH0646dKRCHIwtvW6PR01nCYpHHShg
         VQCXJ3uddvWApOtiB7JRv5qTsSLt+Uh5iotWviBUBqWanfbHatszS9slAYmWXBz1c2Hp
         9xlpAGd5u2oYQ2+tTZASX/XrWdAiUaXU/FKz4y1Q5gIi+AIDYzZ0D6hG/hEUGwgR4q7Y
         YD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718241646; x=1718846446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wkEg0A6dLkLdYjqnlp/NhYfNHg7StDjTeCf/k0/xgQ=;
        b=eZ1tZL0nqdUpjr/C5oGd8z8oR5na6VuxbvOG4wGooZuollMDwJg4xKOvEmqY0kwhP0
         5Z1Ygj+ZRy5IMjYvBVjZlxS8DuAWAWUJ9MfxT2ZbsGihxaob2wIAs37kCzbtdpAXtr6x
         hL04Snqua+YxnO2VB3Mkcqq0T/l98p++9zcuc4qr0VzA6PLS1aY7++DWWE9K0C5mK65c
         Oh7zfFkwmfDuHnHEi5cy2cgctBJGqYpF7WGPM0f8uTRfo5Kheemr2VQ0038PGLjOYS9y
         n41xoAsAKvAcvliEAkgCpQsdD+3cKuyqgpTsVlXVTzNkIB5DrkZSvTPB/tb9dND4ZH9Q
         lRCg==
X-Forwarded-Encrypted: i=1; AJvYcCUum7PLaTU4xv0n9Jg5KHGS8d2sUU6MJOgxBUnDXbeYLb9r/UWT8vIvU4w24FT4juWyrPlKeD+Sy3ZbJV/INc5jC0HAN3zBkwb7r61r
X-Gm-Message-State: AOJu0Yzre2uI32doE4KiTtzBbSTeVw+qXwU1YN7F5bawDbBi29pQk/Gs
	Qe8gA467ai2mNFmourstRBzq3E2kypy3sv3AolAEI9RISRiivQ0gXMuSdor7I2MaEUDyuNBTasQ
	EA9SRpt7VNDFOr8A9uR49In/K9Vg=
X-Google-Smtp-Source: AGHT+IE1vFsD+dtc5+J8vNziCv9wczwzIi64CT2+FvV0mYKajxmTTdW5qU4XW9h4Jue66DEOuvj6rfAnuXrKuz+aylE=
X-Received: by 2002:a05:6870:148e:b0:254:a8d3:6fbb with SMTP id
 586e51a60fabf-25514c684e1mr4036360fac.24.1718241646341; Wed, 12 Jun 2024
 18:20:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMOvFfkQscju1spNKHmEC_Rut+2=qfhKGZSvGhCk_nd5VhuDkg@mail.gmail.com>
 <4ce90767-7d85-47b0-9187-4eb8d257e7e0@leemhuis.info> <44dc1df5f5a1b740b76d1efbf607c49f9d50dda0.camel@sjtu.edu.cn>
 <CAMOvFfkgsbez6fyqUWS9nA=1XubS7_PbjTJ9YzVyZ_MLsetC0Q@mail.gmail.com>
In-Reply-To: <CAMOvFfkgsbez6fyqUWS9nA=1XubS7_PbjTJ9YzVyZ_MLsetC0Q@mail.gmail.com>
From: Winston Ma <winstonhyypia@gmail.com>
Date: Thu, 13 Jun 2024 09:20:33 +0800
Message-ID: <CAMOvFfmcepCLnMq7jSmidGWc__qTcBhwba5vc8eKHSZS=7rZuA@mail.gmail.com>
Subject: Re: [bug report] drm/amdgpu: amdgpu crash on playing videos, linux 6.10-rc
To: Wang Yunchen <mac-wang@sjtu.edu.cn>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Felix.Kuehling@amd.com, Xinhui.Pan@amd.com, alexander.deucher@amd.com, 
	amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thorsten,

Just send this again as my previous email got rejected again. Pls
ignore it if you have already read it.

I come to kernel 6.10 because I would like to run stable diffusion on
my APU, which should related to the following commit: Let VRAM
allocations go to GTT domain on small APUs
(https://www.spinics.net/lists/amd-gfx/msg106897.html).

Coincidentally Yunchen and I use APU machines (7840 HS and 6800U), so
just wonder if video playing issue happen on a dedicated AMD graphic
card?


Thanks and Regards,
Winston

Thanks and Regards,
Winston


On Thu, Jun 13, 2024 at 9:11=E2=80=AFAM Winston Ma <winstonhyypia@gmail.com=
> wrote:
>
> Hi Thorsten,
>
> Just send this again as my previous email got rejected. Pls ignore it if =
you already read it.
>
> I come to kernel 6.10 because I would like to run stable diffusion on my =
APU, which should related to the following commit: Let VRAM allocations go =
to GTT domain on small APUs (https://www.spinics.net/lists/amd-gfx/msg10689=
7.html).
>
> Coincidentally Yunchen and I use APU machines (7840 HS and 6800U), so jus=
t wonder if video playing issue happen on a dedicated AMD graphic card?
>
>
> Thanks and Regards,
> Winston
>
>
> On Thu, Jun 13, 2024 at 12:55=E2=80=AFAM Wang Yunchen <mac-wang@sjtu.edu.=
cn> wrote:
>>
>> On Wed, 2024-06-12 at 15:14 +0200, Linux regression tracking (Thorsten L=
eemhuis) wrote:
>> > On 06.06.24 05:06, Winston Ma wrote:
>> > > Hi I got the same problem on Linux Kernel 6.10-rc2. I got the proble=
m by
>> > > following the procedure below:
>> > >
>> > >  1. Boot Linux Kernel 6.10-rc2
>> > >  2. Open Firefox (Any browser should work)
>> > >  3. Open a Youtube Video
>> > >  4. On the playing video, toggle fullscreen quickly Then after 10-20
>> > >     times of fullscreen toggling, the screen would enter freeze mode=
.
>> > >     This is the log that I captured using the above method.
>> >
>> > Hmm, seems nothing happened here for a while. Could you maybe try to
>> > bisect this
>> > (https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regression=
s.html
>> > )?
>> >
>> > @amd-gfx devs: Or is this unneeded, as the cause found or maybe even
>> > fixed meanwhile?
>> >
>> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' ha=
t)
>> > --
>> > Everything you wanna know about Linux kernel regression tracking:
>> > https://linux-regtracking.leemhuis.info/about/#tldr
>> > If I did something stupid, please tell me, as explained on that page.
>> >
>> > #regzbot poke
>> >
>> > > This is the kernel log
>> > >
>> > > 2024-06-06T10:26:40.747576+08:00 kernel: gmc_v10_0_process_interrupt=
: 6 callbacks suppressed
>> > > 2024-06-06T10:26:40.747618+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: [mmhub] page fault (src_id:0 ring:8 vmid:2
>> > > pasid:32789)
>> > > 2024-06-06T10:26:40.747623+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:  in process RDD Process pid 39524 thread
>> > > firefox-bi:cs0 pid 40342
>> > > 2024-06-06T10:26:40.747625+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:   in page starting at address
>> > > 0x0000800106ffe000 from client 0x12 (VMC)
>> > > 2024-06-06T10:26:40.747628+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: MMVM_L2_PROTECTION_FAULT_STATUS:0x00203811
>> > > 2024-06-06T10:26:40.747629+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        Faulty UTCL2 client ID: VCN (0x1c)
>> > > 2024-06-06T10:26:40.747631+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        MORE_FAULTS: 0x1
>> > > 2024-06-06T10:26:40.747651+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        WALKER_ERROR: 0x0
>> > > 2024-06-06T10:26:40.747653+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        PERMISSION_FAULTS: 0x1
>> > > 2024-06-06T10:26:40.747655+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        MAPPING_ERROR: 0x0
>> > > 2024-06-06T10:26:40.747656+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        RW: 0x0
>> > > 2024-06-06T10:26:40.747658+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: [mmhub] page fault (src_id:0 ring:8 vmid:2
>> > > pasid:32789)
>> > > 2024-06-06T10:26:40.747660+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:  in process RDD Process pid 39524 thread
>> > > firefox-bi:cs0 pid 40342
>> > > 2024-06-06T10:26:40.747662+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:   in page starting at address
>> > > 0x0000800106e00000 from client 0x12 (VMC)
>> > > 2024-06-06T10:26:40.747663+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
>> > > 2024-06-06T10:26:40.747664+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        Faulty UTCL2 client ID: MP0 (0x0)
>> > > 2024-06-06T10:26:40.747666+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        MORE_FAULTS: 0x0
>> > > 2024-06-06T10:26:40.747667+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        WALKER_ERROR: 0x0
>> > > 2024-06-06T10:26:40.747668+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        PERMISSION_FAULTS: 0x0
>> > > 2024-06-06T10:26:40.747670+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        MAPPING_ERROR: 0x0
>> > > 2024-06-06T10:26:40.747671+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        RW: 0x0
>> > > 2024-06-06T10:26:40.747674+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: [mmhub] page fault (src_id:0 ring:8 vmid:2
>> > > pasid:32789)
>> > > 2024-06-06T10:26:40.747677+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:  in process RDD Process pid 39524 thread
>> > > firefox-bi:cs0 pid 40342
>> > > 2024-06-06T10:26:40.747680+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:   in page starting at address
>> > > 0x0000800106e07000 from client 0x12 (VMC)
>> > > 2024-06-06T10:26:40.747683+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
>> > > 2024-06-06T10:26:40.747686+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        Faulty UTCL2 client ID: MP0 (0x0)
>> > > 2024-06-06T10:26:40.747688+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        MORE_FAULTS: 0x0
>> > > 2024-06-06T10:26:40.747691+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        WALKER_ERROR: 0x0
>> > > 2024-06-06T10:26:40.747693+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        PERMISSION_FAULTS: 0x0
>> > > 2024-06-06T10:26:40.747696+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        MAPPING_ERROR: 0x0
>> > > 2024-06-06T10:26:40.747698+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        RW: 0x0
>> > > 2024-06-06T10:26:40.747700+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: [mmhub] page fault (src_id:0 ring:8 vmid:2
>> > > pasid:32789)
>> > > 2024-06-06T10:26:40.747703+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:  in process RDD Process pid 39524 thread
>> > > firefox-bi:cs0 pid 40342
>> > > 2024-06-06T10:26:40.747705+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:   in page starting at address
>> > > 0x0000800107001000 from client 0x12 (VMC)
>> > > 2024-06-06T10:26:40.747707+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
>> > > 2024-06-06T10:26:40.747710+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        Faulty UTCL2 client ID: MP0 (0x0)
>> > > 2024-06-06T10:26:40.747713+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        MORE_FAULTS: 0x0
>> > > 2024-06-06T10:26:40.747716+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        WALKER_ERROR: 0x0
>> > > 2024-06-06T10:26:40.747718+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        PERMISSION_FAULTS: 0x0
>> > > 2024-06-06T10:26:40.747721+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        MAPPING_ERROR: 0x0
>> > > 2024-06-06T10:26:40.747723+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
:        RW: 0x0
>> > > 2024-06-06T10:26:51.094991+08:00 kernel: [drm:amdgpu_job_timedout [a=
mdgpu]] *ERROR* ring vcn_dec_0 timeout,
>> > > signaled seq=3D24897, emitted seq=3D24898
>> > > 2024-06-06T10:26:51.095023+08:00 kernel: [drm:amdgpu_job_timedout [a=
mdgpu]] *ERROR* Process information: process
>> > > RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
>> > > 2024-06-06T10:26:51.095025+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: GPU reset begin!
>> > > 2024-06-06T10:26:52.305509+08:00 kernel: [drm] Register(0) [mmUVD_PO=
WER_STATUS] failed to reach value 0x00000001
>> > > !=3D 0x00000002n
>> > > 2024-06-06T10:26:52.586019+08:00 kernel: [drm] Register(0) [mmUVD_RB=
C_RB_RPTR] failed to reach value 0x000003c0 !=3D
>> > > 0x00000360n
>> > > 2024-06-06T10:26:52.639506+08:00 kernel: [drm] Register(0) [mmUVD_PO=
WER_STATUS] failed to reach value 0x00000001
>> > > !=3D 0x00000002n
>> > > 2024-06-06T10:26:52.639521+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: MODE2 reset
>> > > 2024-06-06T10:26:52.650614+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: GPU reset succeeded, trying to resume
>> > > 2024-06-06T10:26:52.650633+08:00 kernel: [drm] PCIE GART of 1024M en=
abled (table at 0x000000F41FC00000).
>> > > 2024-06-06T10:26:52.650637+08:00 kernel: [drm] VRAM is lost due to G=
PU reset!
>> > > 2024-06-06T10:26:52.650641+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: PSP is resuming...
>> > > 2024-06-06T10:26:52.673474+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: reserve 0xa00000 from 0xf41e000000 for PSP
>> > > TMR
>> > > 2024-06-06T10:26:53.001513+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: RAS: optional ras ta ucode is not available
>> > > 2024-06-06T10:26:53.013802+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: RAP: optional rap ta ucode is not available
>> > > 2024-06-06T10:26:53.013816+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: SECUREDISPLAY: securedisplay ta ucode is not
>> > > available
>> > > 2024-06-06T10:26:53.013819+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: SMU is resuming...
>> > > 2024-06-06T10:26:53.016519+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: SMU is resumed successfully!
>> > > 2024-06-06T10:26:53.017502+08:00 kernel: [drm] DMUB hardware initial=
ized: version=3D0x04000044
>> > > 2024-06-06T10:26:53.677511+08:00 kernel: [drm] kiq ring mec 2 pipe 1=
 q 0
>> > > 2024-06-06T10:26:53.958512+08:00 kernel: amdgpu 0000:03:00.0: [drm:a=
mdgpu_ring_test_helper [amdgpu]] *ERROR* ring
>> > > vcn_dec_0 test failed (-110)
>> > > 2024-06-06T10:26:53.958536+08:00 kernel: [drm:amdgpu_device_ip_resum=
e_phase2 [amdgpu]] *ERROR* resume of IP block
>> > > <vcn_v3_0> failed -110
>> > > 2024-06-06T10:26:53.958539+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: GPU reset(1) failed
>> > > 2024-06-06T10:26:53.958541+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: GPU reset end with ret =3D -110
>> > > 2024-06-06T10:26:53.959180+08:00 kernel: [drm:amdgpu_job_timedout [a=
mdgpu]] *ERROR* GPU Recovery Failed: -110
>> > > 2024-06-06T10:26:55.261509+08:00 kernel: [drm] Register(0) [mmUVD_PO=
WER_STATUS] failed to reach value 0x00000001
>> > > !=3D 0x00000002n
>> > > 2024-06-06T10:26:55.540507+08:00 kernel: [drm] Register(0) [mmUVD_RB=
C_RB_RPTR] failed to reach value 0x00000010 !=3D
>> > > 0x00000000n
>> > > 2024-06-06T10:27:04.407149+08:00 kernel: [drm] Register(0) [mmUVD_PO=
WER_STATUS] failed to reach value 0x00000001
>> > > !=3D 0x00000002n
>> > > 2024-06-06T10:27:04.407252+08:00 kernel: [drm:amdgpu_job_timedout [a=
mdgpu]] *ERROR* ring vcn_dec_0 timeout,
>> > > signaled seq=3D24898, emitted seq=3D24898
>> > > 2024-06-06T10:27:04.407257+08:00 kernel: [drm:amdgpu_job_timedout [a=
mdgpu]] *ERROR* Process information: process
>> > > RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
>> > > 2024-06-06T10:27:04.407259+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: GPU reset begin!
>> > > 2024-06-06T10:27:05.033745+08:00 kernel: ------------[ cut here ]---=
---------
>> > > 2024-06-06T10:27:05.033773+08:00 kernel: WARNING: CPU: 8 PID: 47039 =
at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630
>> > > amdgpu_irq_put+0x9c/0xb0 [amdgpu]
>> > > 2024-06-06T10:27:05.033777+08:00 kernel: Modules linked in: nft_reje=
ct_inet nf_reject_ipv4 nf_reject_ipv6
>> > > nft_reject xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntr=
ack_netlink nf_conntrack nf_defrag_ipv6
>> > > nf_defrag_ipv4 xt_addrtype nft_compat nf_tables libcrc32c br_netfilt=
er bridge stp llc hid_logitech_hidpp usbhid
>> > > xfrm_interface xfrm6_tunnel tunnel4 tunnel6 xfrm_user xfrm_algo uhid=
 rfcomm snd_seq_dummy snd_hrtimer cmac
>> > > algif_hash algif_skcipher af_alg overlay qrtr bnep binfmt_misc uvcvi=
deo videobuf2_vmalloc uvc videobuf2_memops
>> > > videobuf2_v4l2 btusb btrtl videodev btintel btbcm snd_acp6x_pdm_dma =
snd_soc_dmic snd_soc_acp6x_mach amd_atl
>> > > intel_rapl_msr btmtk videobuf2_common bluetooth mc intel_rapl_common=
 snd_sof_amd_acp63 snd_sof_amd_vangogh
>> > > snd_sof_amd_rembrandt iwlmvm snd_sof_amd_renoir snd_sof_amd_acp snd_=
sof_pci snd_sof_xtensa_dsp amdgpu snd_sof
>> > > edac_mce_amd mac80211 snd_sof_utils snd_pci_ps snd_hda_codec_realtek=
 snd_amd_sdw_acpi kvm_amd soundwire_amd
>> > > snd_hda_codec_generic soundwire_generic_allocation soundwire_bus
>> > > 2024-06-06T10:27:05.033782+08:00 kernel:  snd_hda_scodec_cs35l41_spi=
 nls_iso8859_1 snd_hda_codec_hdmi
>> > > snd_hda_scodec_component libarc4 kvm snd_soc_core snd_hda_intel snd_=
ctl_led snd_intel_dspcfg snd_compress
>> > > snd_intel_sdw_acpi amdxcp snd_seq_midi ac97_bus crct10dif_pclmul drm=
_exec snd_hda_codec polyval_clmulni
>> > > snd_pcm_dmaengine snd_seq_midi_event gpu_sched polyval_generic iwlwi=
fi ghash_clmulni_intel snd_rpl_pci_acp6x
>> > > drm_buddy sha256_ssse3 snd_hda_core snd_rawmidi snd_acp_pci drm_suba=
lloc_helper snd_hda_scodec_cs35l41_i2c
>> > > sha1_ssse3 drm_ttm_helper snd_acp_legacy_common snd_hwdep snd_hda_sc=
odec_cs35l41 aesni_intel snd_pci_acp6x amd_pmf
>> > > snd_hda_cs_dsp_ctls ttm crypto_simd snd_pci_acp5x snd_soc_cs_amp_lib=
 asus_nb_wmi cs_dsp cryptd amdtee snd_seq
>> > > snd_rn_pci_acp3x drm_display_helper snd_pcm asus_wmi snd_acp_config =
rapl wmi_bmof sparse_keymap snd_seq_device
>> > > cfg80211 snd_soc_cs35l41_lib cec snd_soc_acpi ccp rc_core snd_timer =
i2c_algo_bit i2c_piix4 snd_pci_acp3x k10temp
>> > > amd_sfh tee snd platform_profile soundcore serial_multi_instantiate =
amd_pmc acpi_tad
>> > > 2024-06-06T10:27:05.033784+08:00 kernel:  joydev input_leds mac_hid =
serio_raw parport_pc ppdev lp parport
>> > > efi_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 hid_multit=
ouch nvme video ucsi_acpi hid_generic
>> > > crc32_pclmul nvme_core typec_ucsi xhci_pci i2c_hid_acpi xhci_pci_ren=
esas nvme_auth typec i2c_hid wmi hid 8250_dw
>> > > 2024-06-06T10:27:05.033785+08:00 kernel: CPU: 8 PID: 47039 Comm: kwo=
rker/u64:0 Tainted: G        W
>> > > 6.10.0-061000rc2-generic #202406022333
>> > > 2024-06-06T10:27:05.033787+08:00 kernel: Hardware name: ASUSTeK COMP=
UTER INC. Zenbook UM5302TA_UM5302TA/UM5302TA,
>> > > BIOS UM5302TA.311 01/17/2023
>> > > 2024-06-06T10:27:05.033788+08:00 kernel: Workqueue: amdgpu-reset-dev=
 drm_sched_job_timedout [gpu_sched]
>> > > 2024-06-06T10:27:05.033789+08:00 kernel: RIP: 0010:amdgpu_irq_put+0x=
9c/0xb0 [amdgpu]
>> > > 2024-06-06T10:27:05.033790+08:00 kernel: Code: 31 f6 31 ff e9 c0 05 =
2f e6 44 89 e2 48 89 de 4c 89 f7 e8 97 fc ff
>> > > ff 5b 41 5c 41 5d 41 5e 5d 31 d2 31 f6 31 ff e9 9f 05 2f e6 <0f> 0b =
b8 ea ff ff ff eb c3 b8 fe ff ff ff eb bc 0f
>> > > 1f 40 00 90 90
>> > > 2024-06-06T10:27:05.033791+08:00 kernel: RSP: 0018:ffffb65847227c18 =
EFLAGS: 00010246
>> > > 2024-06-06T10:27:05.033793+08:00 kernel: RAX: 0000000000000000 RBX: =
ffff9ac0a0280c60 RCX: 0000000000000000
>> > > 2024-06-06T10:27:05.033794+08:00 kernel: RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
>> > > 2024-06-06T10:27:05.033796+08:00 kernel: RBP: ffffb65847227c38 R08: =
0000000000000000 R09: 0000000000000000
>> > > 2024-06-06T10:27:05.033797+08:00 kernel: R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
>> > > 2024-06-06T10:27:05.033798+08:00 kernel: R13: 0000000000000001 R14: =
ffff9ac0a0280000 R15: ffff9ac0a0280000
>> > > 2024-06-06T10:27:05.033799+08:00 kernel: FS:  0000000000000000(0000)=
 GS:ffff9ac38e600000(0000)
>> > > knlGS:0000000000000000
>> > > 2024-06-06T10:27:05.033800+08:00 kernel: CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
>> > > 2024-06-06T10:27:05.033802+08:00 kernel: CR2: 00007d1a5edfe000 CR3: =
000000001863c000 CR4: 0000000000f50ef0
>> > > 2024-06-06T10:27:05.033803+08:00 kernel: PKRU: 55555554
>> > > 2024-06-06T10:27:05.033805+08:00 kernel: Call Trace:
>> > > 2024-06-06T10:27:05.033806+08:00 kernel:  <TASK>
>> > > 2024-06-06T10:27:05.033807+08:00 kernel:  ? show_regs+0x6c/0x80
>> > > 2024-06-06T10:27:05.033845+08:00 kernel:  ? __warn+0x88/0x140
>> > > 2024-06-06T10:27:05.034598+08:00 kernel:  ? amdgpu_irq_put+0x9c/0xb0=
 [amdgpu]
>> > > 2024-06-06T10:27:05.034615+08:00 kernel:  ? report_bug+0x182/0x1b0
>> > > 2024-06-06T10:27:05.034618+08:00 kernel:  ? handle_bug+0x51/0xa0
>> > > 2024-06-06T10:27:05.034619+08:00 kernel:  ? exc_invalid_op+0x18/0x80
>> > > 2024-06-06T10:27:05.034620+08:00 kernel:  ? asm_exc_invalid_op+0x1b/=
0x20
>> > > 2024-06-06T10:27:05.034621+08:00 kernel:  ? amdgpu_irq_put+0x9c/0xb0=
 [amdgpu]
>> > > 2024-06-06T10:27:05.034623+08:00 kernel:  ? amdgpu_irq_put+0x55/0xb0=
 [amdgpu]
>> > > 2024-06-06T10:27:05.035573+08:00 kernel:  gmc_v10_0_hw_fini+0x67/0xe=
0 [amdgpu]
>> > > 2024-06-06T10:27:05.035580+08:00 kernel:  gmc_v10_0_suspend+0xe/0x20=
 [amdgpu]
>> > > 2024-06-06T10:27:05.035581+08:00 kernel:  amdgpu_device_ip_suspend_p=
hase2+0x251/0x480 [amdgpu]
>> > > 2024-06-06T10:27:05.035582+08:00 kernel:  amdgpu_device_ip_suspend+0=
x49/0x80 [amdgpu]
>> > > 2024-06-06T10:27:05.036529+08:00 kernel:  amdgpu_device_pre_asic_res=
et+0xd1/0x490 [amdgpu]
>> > > 2024-06-06T10:27:05.036546+08:00 kernel:  amdgpu_device_gpu_recover+=
0x406/0xa30 [amdgpu]
>> > > 2024-06-06T10:27:05.036548+08:00 kernel:  amdgpu_job_timedout+0x141/=
0x200 [amdgpu]
>> > > 2024-06-06T10:27:05.036550+08:00 kernel:  drm_sched_job_timedout+0x7=
0/0x110 [gpu_sched]
>> > > 2024-06-06T10:27:05.036551+08:00 kernel:  process_one_work+0x186/0x3=
e0
>> > > 2024-06-06T10:27:05.036552+08:00 kernel:  worker_thread+0x304/0x440
>> > > 2024-06-06T10:27:05.036554+08:00 kernel:  ? srso_alias_return_thunk+=
0x5/0xfbef5
>> > > 2024-06-06T10:27:05.036555+08:00 kernel:  ? _raw_spin_lock_irqsave+0=
xe/0x20
>> > > 2024-06-06T10:27:05.036556+08:00 kernel:  ? __pfx_worker_thread+0x10=
/0x10
>> > > 2024-06-06T10:27:05.036557+08:00 kernel:  kthread+0xe4/0x110
>> > > 2024-06-06T10:27:05.036558+08:00 kernel:  ? __pfx_kthread+0x10/0x10
>> > > 2024-06-06T10:27:05.036559+08:00 kernel:  ret_from_fork+0x47/0x70
>> > > 2024-06-06T10:27:05.036561+08:00 kernel:  ? __pfx_kthread+0x10/0x10
>> > > 2024-06-06T10:27:05.036562+08:00 kernel:  ret_from_fork_asm+0x1a/0x3=
0
>> > > 2024-06-06T10:27:05.036563+08:00 kernel:  </TASK>
>> > > 2024-06-06T10:27:05.036564+08:00 kernel: ---[ end trace 000000000000=
0000 ]---
>> > > 2024-06-06T10:27:05.036565+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: MODE2 reset
>> > > 2024-06-06T10:27:05.046502+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: GPU reset succeeded, trying to resume
>> > > 2024-06-06T10:27:05.047516+08:00 kernel: [drm] PCIE GART of 1024M en=
abled (table at 0x000000F41FC00000).
>> > > 2024-06-06T10:27:05.047533+08:00 kernel: [drm] VRAM is lost due to G=
PU reset!
>> > > 2024-06-06T10:27:05.047538+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: PSP is resuming...
>> > > 2024-06-06T10:27:05.070481+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: reserve 0xa00000 from 0xf41e000000 for PSP
>> > > TMR
>> > > 2024-06-06T10:27:05.397519+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: RAS: optional ras ta ucode is not available
>> > > 2024-06-06T10:27:05.409509+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: RAP: optional rap ta ucode is not available
>> > > 2024-06-06T10:27:05.409517+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: SECUREDISPLAY: securedisplay ta ucode is not
>> > > available
>> > > 2024-06-06T10:27:05.409518+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: SMU is resuming...
>> > > 2024-06-06T10:27:05.411482+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: SMU is resumed successfully!
>> > > 2024-06-06T10:27:05.413504+08:00 kernel: [drm] DMUB hardware initial=
ized: version=3D0x04000044
>> > > 2024-06-06T10:27:06.055474+08:00 kernel: [drm] kiq ring mec 2 pipe 1=
 q 0
>> > > 2024-06-06T10:27:06.335476+08:00 kernel: amdgpu 0000:03:00.0: [drm:a=
mdgpu_ring_test_helper [amdgpu]] *ERROR* ring
>> > > vcn_dec_0 test failed (-110)
>> > > 2024-06-06T10:27:06.335495+08:00 kernel: [drm:amdgpu_device_ip_resum=
e_phase2 [amdgpu]] *ERROR* resume of IP block
>> > > <vcn_v3_0> failed -110
>> > > 2024-06-06T10:27:06.335498+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: GPU reset(2) failed
>> > > 2024-06-06T10:27:06.335499+08:00 kernel: amdgpu 0000:03:00.0: amdgpu=
: GPU reset end with ret =3D -110
>> > > 2024-06-06T10:27:06.335631+08:00 kernel: [drm:amdgpu_job_timedout [a=
mdgpu]] *ERROR* GPU Recovery Failed: -110
>> > >
>> Hi Thorsten,
>>
>> It seems that the issue persists on 6.10 rc3.

