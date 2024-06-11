Return-Path: <linux-kernel+bounces-210155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F3D90400B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9D31C22B47
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177B32574F;
	Tue, 11 Jun 2024 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fTNYIKeW"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE7F28399
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119935; cv=none; b=CocJitS1+DaPHO+buMyQosIcK2eZkIRW+AfOGUHREQ9HWG3zJ8Lbj9UsAocTqut3ayobJTRjv0euHUMEFeP7OyFpdthkmwoKpyY+K0WhBf55rUhTv5K6RBBk21kWqkecDMxTasu4vzteAYOro3gdUAksMuMuRzK3znXVRUpKPTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119935; c=relaxed/simple;
	bh=Vn7Kc4x7zOZjOguyNFwvnJrV+uFfVWZrPr9+iUiJQvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2U4ril7hztSze2ORufEVVnmQavh0C24C78z3YDqr2+t/zec0ZVWCUJ+EpD95sen4KAGBUNlWWDHY7Z+FuLQPUo9OeXnHX3hMPuX1q9G6ByWiyyTMiiE7h/v/DapGPAqoQ2p/aj2FYcIHgEsU75RVt+rdVzQv/ZQgEXxBmHj63I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fTNYIKeW; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7041f4553ccso3593242b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718119933; x=1718724733; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vn7Kc4x7zOZjOguyNFwvnJrV+uFfVWZrPr9+iUiJQvs=;
        b=fTNYIKeWEUrXdv9I1cGmTXIct7ngrp/oO4pOkT29EuRcpKqE4ZohKfMhG1vZL5oiUY
         /vhQpL2Ks+Fr3k+ACuRZj5dlDEhVOU1KuLm1yDNJw82mL/vkjdVFaJcOEfbWCS97OkHm
         og6WWdDDn/B9ndUdyQ67PTEtfCrpVV6WUywnE8cOT4qO1MyLK65C4K5lnPHwsFS7OuRP
         Dsa7c9iv7AFK3FAL3Mo6356wuGOt6VUjCTmjjZYPTcSroxBPBGfvRVoe4U3trqRuq3II
         aEaRgyPvsx+ORaUdn0nHG15jh2JV3SmF9wyAp/Uh1jkpUIjoFKuv1xucMbFZKCOQNKZZ
         U9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718119933; x=1718724733;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn7Kc4x7zOZjOguyNFwvnJrV+uFfVWZrPr9+iUiJQvs=;
        b=X8CYjk13heIo3htehzYAYQ0pbXM+/fjP16j3pAI/d15f8jYiiQSdWpilZsXX6xklFt
         hzxME5XejTcaod8RjGOMMSUHm40N/f6wLbCZfnyzcR5gnQPK9SG2ArzlXJPrBtMhVPR9
         eFPEVeiqyjG1mbhcMI8DIo7iwLT5FFyjpn3F8Qxfbbr41y0CtqomG+leWGINrq8f9PGK
         EPHyAEaVksJGfzj3od+vRt1VCqzo2/fq5UxxvwXjUCwaf6mq+D1AJXoJ2TPlbe6sQk9H
         Z56DXgVXNo5vmSyTzFLy2iwx1wHehqQjUXiZAII7KT3fBwkHnxLe9KWyKmGnux3nOOxT
         xCDA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ4+BDXXmTy/ptw5MOpzU8ZE9aFDz9dtOD1suybeOZHT9XYBatxIFA75rzhRv8et0zeB5olppaBw2AAVY2kRf6HDpWLrR4g9HWhhKY
X-Gm-Message-State: AOJu0Ywaw4XtOzQqG/bNeTbsU2RJ/aEMrUTDMJe+BbZjfk3glT0hfYfl
	EydYVAPloL3SqhZV80uYxobAlbHyBDBst/m0USCjLBer9D+n5PEG8LHqvga2yMs=
X-Google-Smtp-Source: AGHT+IF8rG5/mjujMehriFq+KOF4rVuXuWFdDgw6V0TBjJ1ZIkoAFk5Q1ybFIIs3W8YsWs7KBpcR4g==
X-Received: by 2002:a05:6a20:9190:b0:1b7:d72e:9e5e with SMTP id adf61e73a8af0-1b7d72ea074mr4679110637.37.1718119932775;
        Tue, 11 Jun 2024 08:32:12 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e668a494c4sm4998087a12.22.2024.06.11.08.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 08:32:12 -0700 (PDT)
Date: Tue, 11 Jun 2024 08:32:10 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Jesse Taube <jesse@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
Message-ID: <Zmht+h75GgxP3ocz@debug.ba.rivosinc.com>
References: <20240531162327.2436962-1-jesse@rivosinc.com>
 <20240531-uselessly-spied-262ecf44e694@spud>
 <b199fde6-c24e-4c18-9c38-fdc923294551@ghiti.fr>
 <20240603-stinking-roster-cfad46696ae5@spud>
 <ZmNWmxak9Rc80Kpb@debug.ba.rivosinc.com>
 <c288f739-2a1a-4fd7-884b-12e360a33142@rivosinc.com>
 <20240610-qualm-chalice-72d0cc743658@wendy>
 <01547275-8c8c-43cf-9da0-64825c234707@rivosinc.com>
 <Zmdq6kszPBxAvLdD@debug.ba.rivosinc.com>
 <20240610-earplugs-anybody-ebd04a5fa777@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610-earplugs-anybody-ebd04a5fa777@spud>

On Mon, Jun 10, 2024 at 10:56:35PM +0100, Conor Dooley wrote:
>On Mon, Jun 10, 2024 at 02:06:50PM -0700, Deepak Gupta wrote:
>> On Mon, Jun 10, 2024 at 11:16:42AM +0200, Clément Léger wrote:
>> > On 10/06/2024 11:02, Conor Dooley wrote:
>> > > On Mon, Jun 10, 2024 at 10:33:34AM +0200, Clément Léger wrote:
>> > > > On 07/06/2024 20:51, Deepak Gupta wrote:
>> > > > > On Mon, Jun 03, 2024 at 01:47:40PM +0100, Conor Dooley wrote:
>> > > > > > On Mon, Jun 03, 2024 at 11:14:49AM +0200, Alexandre Ghiti wrote:
>> > > > > I don't know all the details but on first glance it seems like instead
>> > > > > of ACPI,
>> > > > > may be FWFT is a better place for discovery ?
>> > > > > https://lists.riscv.org/g/tech-prs/topic/patch_v12_add_firmware/106479571
>> > > >
>> > > > IMHO, doing discovery in FWFT is not the goal of this extension. I think
>> > > > the "real" solution would be to wait for the unified discovery task
>> > > > group to come up with something for that (which is their goal I think) [1]
>>
>> Yeah I understand the conundrum here.
>>
>> > >
>> > > I'm curious to see how that works out. The proposal documents an m-mode
>> > > csr, so we'd have to smuggle the information to s-mode somehow...
>> >
>> > Ahem, yeah, I spoke a bit too fast. Looked at the proposal and the
>> > mconfigptr CSR will be accessible by M-mode only so I guess we will have
>> > to find another way...
>>
>> That's not the only problem. Even if you get mconfigptr access, parsing the format
>> is another thing that has to be done. This is early in boot. Although its strictly (pun
>> intended) not a firmware feature extension, I think it's much easier to ask underlying
>> firmware if platform is `Sstrict`. or may be expose something like below
>>
>> `ENABLE_SSTRICT`.
>> Platforms which support `Sstrict` can return success for this while platforms which don't
>> have `Sstrict` can return error code (not supported or not implemented).
>> This way its not feature discovery.
>
>I mean, it's feature discovery in all but name. You're calling it
>enable, but the behaviour you describe is feature discovery - not that I
>am against this being feature discovery since it gets us out of an
>annoying bind.

Yes I know it's cheating but at least for this case, it seems like easy solution which
doesn't break anything. Neither I see it creating any future problems (except FWFT becoming
to look like discovery mechanism :-) and Clement/Atish hating me for that)

Another solution to this could be introducing a riscv config `CONFIG_RISCV_SSTRICT`.
By default always select `CONFIG_RISCV_SSTRICT` and any platform owner who are not
sstrict, they can build their own.
I expect distro (ubuntu, red hat, etc) would want by default `CONFIG_RISCV_SSTRICT`.

>
>I forget which extension Alex and I discussed previously, but there's
>some mm-related things that you're gonna have to probe super early and
>we need to figure out if we can get that info from ACPI or not. I know
>we discussed it w.r.t. one of the T-Head vendor extensions, but I think
>another standard one got mentioned too.
>
>> It seems like arm64 parses fdt and it reads certain CSRs too
>> (`arch/arm64/kernel/pi/kaslr_early.c`). Although it doesn't look like it has to do any
>> discovery for them.
>
>A decree from the Palmer that we don't support things that do not conform
>in this manner would allow us to do what arm64 does. I brought this up
>originally because it's been discussed before that we cannot rely on
>conformance because we want to support people's platforms, whether they
>comply or not. I'd be wary of making this an exception now, and then
>later on someone makes a platform we want to support that doesn't
>conform and hey presto, we regress KASLR support - even if I think it is
>pretty unlikely that someone is going to repurpose the Zkr CSRs.
>
>One of the problems with only supporting conforming platforms is that
>the definition of conforming changes over time! This has happened with
>the Andes PMU for example, which I believe uses an interrupt number that
>was later co-opted by AIA spec. That conformed at the time, but doesn't
>anymore - do they get to mark themselves as Sstrict?
>
>Maybe we can do this on a case-by-case basis, but it's up to Palmer
>whether or not we can do that.

