Return-Path: <linux-kernel+bounces-562682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C389A630E6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 18:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2891891DE8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 17:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745C6204C13;
	Sat, 15 Mar 2025 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjhJqgdT"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D11213AA2D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742060436; cv=none; b=HWoa2hkHwtuc8PMkUFRMqbD5mJjpc/lhCnpM+NdcKuRELbIFe+BGTqdtZYyhmL/XYFA13JfOEOkaYR/uNRz8jUFBLdqosM0iZjYgaOzij93g3dRbcGhF8xP0IZbv2w67zm0qizkplPLFVxGNC4y/igBNteLUzCkhW/64Fr4Ikoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742060436; c=relaxed/simple;
	bh=oysJqXkSyQyREhPfjOHk7tt+mSXiKNZhaFpPVKG40QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBg1t9z7OzILIFAiD0apGy8Sw+MAGPHk1qWL/sfjuWpMzpCiK1wJuld937/d5iQiHni5p63wGrkLhM35X5LItyIKnRhZLmTtexFsZFzFc1q+Jl7peeVvKWAQ6NG4eI7aulTFeiQo9WJaWkvg1qvQlMVrg1EBVrSOzBWjRMPN6UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjhJqgdT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30144a72db9so210132a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 10:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742060434; x=1742665234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOk77kqi4lkW0/kdysAwjj2qu3m2pFn+y+VjVbY7SLs=;
        b=FjhJqgdTHh6ob4M0XKV9WFtuGZ9RZFVPEN6yLdBowgb6/bV12Q2RtkSnC/8urS9Hw6
         YpeEq7bErp1KCPmzURCzHaShhOeXNTXLnu02SfR7c8S1POwVYjNB4Ix/sEX1A6lvaFIE
         KTtZnwQFfY94sIySyjdLbcWQV76RmPGnc9rjAuVpV0LRNV3kyhDtV6rCy59tpyv/fOHj
         a/uzDCq2ngl/gPgIHxkMhKFQ03qSIhWBlJkXH+P9SEhmHMPqqQ/ku83pLsDk2CwGfVCv
         o8yVVkvtG2d9nyjzQ8skzsjZ+7Gpj6wafmy1t1PynwiqdW0R1w3zLxW7wTKAd3GscGn2
         7UXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742060434; x=1742665234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOk77kqi4lkW0/kdysAwjj2qu3m2pFn+y+VjVbY7SLs=;
        b=M6Wj7ouR32k4JmgON40MSqSK+tJOCUQLo2oBOaqAfhAVkv4s9ODLbKvLZhkx451BkO
         NLdwB1LMpB/BIr69duyfIi06hs/+IiDADPPLqLRD99XAtU6pluh+GyURiXzWVDeKPPTA
         NX/EoaChJVg5WDNTte9cdhkbcdVt4EgN/Imxn4An2jtgJzrAfJBQhMPl7zozzPKqV9hF
         JohxvVqjPUV2aElkSIbxYWSfIY23CABCloW5vN8f+bLGer7d3SHfNXl1ykwsuI9DqL9V
         s8sSLLPPHP77VKgf0uPXC3f06jRbot/tCdWXIPPvdjYl7kisZb3R3cJTd2wpsLph/6Y1
         NPaw==
X-Forwarded-Encrypted: i=1; AJvYcCUR2/uVR5s6f2V/5DnyhbvUYqbzWNL3OGf9lxNbQLTO30ene4qepsNq9n/gaPLxkxP16+fr1BdQEtrr/qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUuowjjl2oepUMJha1GdoaBe5IImXkL+Ka45dU6rfkMdbKriqu
	PoI+cbbpb65o8ZheaI2FS6Rq1MstlnbBa4FssjNHinYQ1dd2sQySKbG4XjnU+5d5tE17fYMyE8x
	9LvXu/f79ytO5NpGcw+Sic1azCfA=
X-Gm-Gg: ASbGncvXOpGO4UeoE4KCJMEGguaBQp6goQvreGL9AXyfhckY9R6aZkulz9ybiWZ0Nwa
	5rSRCWAuots0+4s0SjOWqGLHlajEVIsNt6H9DK8zuAz4+BwyfkKLkEOXlHqJwdKBs9dM3y9pjd3
	IcCJ2sXzgmMZLNPcou4x2omzE7aA==
X-Google-Smtp-Source: AGHT+IGbXrWrcmJPxnATtMDNxKyBe1McY0iT1NSSp2Cb8noHkhFTSF1Dx9Jsi52xd48mr+ny3QYYGDaJI+EW2EEFqDU=
X-Received: by 2002:a17:90b:4d8d:b0:2fe:b77a:2eba with SMTP id
 98e67ed59e1d1-30151c5dfd6mr3302403a91.1.1742060434249; Sat, 15 Mar 2025
 10:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310112206.4168-1-spasswolf@web.de> <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
 <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com> <09131c563332c892284ec7fb4ce706996131db8c.camel@web.de>
 <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de> <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
 <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de> <12d950ee-4152-4ad6-b93e-7c5b75804b1a@nvidia.com>
 <705e95cec3dc5181ca2aa73722e6b84f63f3e91d.camel@web.de> <20b5823e-247a-456a-bb55-d50f212a9f5a@nvidia.com>
 <a34a1ae0b1d226b1bac7d73daa24da8e5899cb3e.camel@web.de> <c7bb0bd1-529d-466d-9cce-abbac4b480ab@nvidia.com>
 <146277bb0ecbb392d490683c424b8ae0dfa82838.camel@web.de> <b63b1de8-7eec-4235-b61e-e654e78543ba@nvidia.com>
 <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de> <7866593f-0322-4fb3-9729-82366940fc85@nvidia.com>
 <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com> <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
 <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
In-Reply-To: <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 15 Mar 2025 13:40:22 -0400
X-Gm-Features: AQ5f1JqczJSund_yZ9Gc1DJvfi3qHEiMuoBL3Yl78fyXIr_IqcnGk9bdrBiCIdM
Message-ID: <CADnq5_Pvmxa10dJWYjajwxG-0Y_oxhL6wS6NsG2F0dmcJS6o8A@mail.gmail.com>
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Balbir Singh <balbirs@nvidia.com>
Cc: Bert Karwatzki <spasswolf@web.de>, Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 8:42=E2=80=AFPM Balbir Singh <balbirs@nvidia.com> w=
rote:
>
> On 3/15/25 01:18, Bert Karwatzki wrote:
> > Am Samstag, dem 15.03.2025 um 00:34 +1100 schrieb Balbir Singh:
> >> On 3/14/25 17:14, Balbir Singh wrote:
> >>> On 3/14/25 09:22, Bert Karwatzki wrote:
> >>>> Am Freitag, dem 14.03.2025 um 08:54 +1100 schrieb Balbir Singh:
> >>>>> On 3/14/25 05:12, Bert Karwatzki wrote:
> >>>>>> Am Donnerstag, dem 13.03.2025 um 22:47 +1100 schrieb Balbir Singh:
> >>>>>>>
> >>>>>>>
> >>>>>>> Anyway, I think the nokaslr result is interesting, it seems like =
with nokaslr
> >>>>>>> even the older kernels have problems with the game
> >>>>>>>
> >>>>>>> Could you confirm if with nokaslr
> >>>>>>>
> >>>>>> Now I've tested kernel 6.8.12 with nokaslr
> >>>>>>
> >>>>>>> 1. Only one single game stellaris is not working?
> >>>>>>> 2. The entire laptop does not work?
> >>>>>>> 3. Laptop works and other games work? Just one game is not workin=
g as
> >>>>>> expected?
> >>>>>>
> >>>>>>
> >>>>>> Stellaris is showing the input lag and the entire graphical user i=
nterface shows
> >>>>>> the same input lag as long as stellaris is running.
> >>>>>> Civilization 6 shows the same input lag as stellaris, probably eve=
n worse.
> >>>>>> Magic the Gathering: Arena (with wine) works normally.
> >>>>>> Valheim also works normally.
> >>>>>> Crusader Kings 2 works normally
> >>>>>> Rogue Heroes: Ruins of Tasos (a Zelda lookalike) works normally.
> >>>>>> Baldur's Gate I & II and Icewind Dale work normally.
> >>>>>>
> >>>>>> Also the input lag is only in the GUI, if I switch to a text conso=
le (ctrl + alt
> >>>>>> + Fn), input works normally even while the affected games are runn=
ing.
> >>>>>>
> >>>>>> Games aside everything else (e.g. compiling kernels) seems to work=
 with nokaslr.
> >>>>>>
> >>>>>
> >>>>> Would it be fair to assume that anything Xorg/Wayland is working fi=
ne
> >>>>> when the game is not running, even with nokaslr?
> >>>>>
> >>>> Yes, Xorg (I'm normally using xfce4 as desktop) works fine. I also t=
ested with
> >>>> gnome using Xwayland, here the buggy behaviour also exists, with the=
 addtion
> >>>> that mouse position is off, i.e. to click a button in the game you h=
ave to click
> >>>> somewhat above it.
> >>>
> >>> So the issue is narrowed down to just the games you've mentioned with=
 nokaslr/patch?
> >>>
> >>>>
> >>>>> +amd-gfx@lists.freedesktop.org to see if there are known issues wit=
h
> >>>>> nokaslr and the games you mentioned.
> >>>>>
> >>>>>
> >>>>> Balbir Singh
> >>>>>
> >>>>> PS: I came across an interesting link
> >>>>> https://www.alex-ionescu.com/behind-windows-x64s-44-bit-memory-addr=
essing-limit/
> >>>>>
> >>>>> I think SLIST_HEADER is used by wine as well for user space and I a=
m not sure
> >>>>> if in this situation the game is hitting this scenario, but surpris=
ingly the other
> >>>>> games are not. This is assuming the game uses wine. I am not sure i=
t's related,
> >>>>> but the 44 bits caught my attention.
> >>>>
> >>>> Stellaris is a native linux game (x86_64), the one game (MTGA) I tes=
ted with
> >>>> wine worked fine.
> >>>>
> >>>
> >>> Thanks for the update! I wonder if there are any game logs. If you ca=
n look for any
> >>> warnings/errors it might be interesting to see where the difference i=
s coming from?
> >>>
> >>
> >> In addition to the above, does radeontop give you any info about what =
might be
> >> going on? I am also curious if
> >
> > This got me to test stellaris and Civ6 using the discrete Graphics card=
:
> > 03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi=
 23
> > [Radeon RX 6600/6600 XT/6600M] (rev c3)
> >  (with DRI_PRIME=3D1) and here the problems do not occur.
> >
> > This is the CPU-builtin GPU, which I normally use to play stellaris as =
graphics
> > aren't very demanding, here the problems occur when using nokaslr
> > 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/AT=
I]
> > Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
> >
>
> Aaah.. this is strange, because the only movement in iomem was for the di=
screte GPU
>
> From your eariler message
>
>  fee00000-fee00fff : pnp 00:04
>  ff000000-ffffffff : pnp 00:04
>  100000000-fee2fffff : System RAM
> -  3a7e00000-3a89d2f56 : Kernel code
> -  3a8a00000-3a8e31fff : Kernel rodata
> -  3a9000000-3a912a5ff : Kernel data
> -  3a969c000-3a97fffff : Kernel bss
> +  d32200000-d32dd0f56 : Kernel code
> +  d32e00000-d33231fff : Kernel rodata
> +  d33400000-d3352a5ff : Kernel data
> +  d33a9c000-d33bfffff : Kernel bss
>  fee300000-100fffffff : Reserved
>  1010000000-ffffffffff : PCI Bus 0000:00
>    fc00000000-fe0fffffff : PCI Bus 0000:01
> @@ -104,4 +104,4 @@
>        fe30300000-fe303fffff : 0000:04:00.0
>      fe30400000-fe30403fff : 0000:04:00.0
>      fe30404000-fe30404fff : 0000:04:00.0
> -3ffe00000000-3fffffffffff : 0000:03:00.0
> +afe00000000-affffffffff : 0000:03:00.0
>
> I am hoping someone from amd-gfx to chime in with known issues of the dri=
ver
> and nokaslr or help debug further.

I'm not aware of any problems with nokalr off hand with AMD GPUs.

Alex

