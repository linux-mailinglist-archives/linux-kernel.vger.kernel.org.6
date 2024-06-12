Return-Path: <linux-kernel+bounces-211046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0DD904C80
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F053B23846
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32CF5B1FB;
	Wed, 12 Jun 2024 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wiPXIsxX"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1A28399
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176532; cv=none; b=ctJ5N1ZKE2U4LvtEdtVB3UWTNNsfNM0zMjuXAY5zP7Ng92LODieW8kk/9tFnZaifsE7N00XLU7AEmssvOAk4sMxZaVW5+Qw5frgMmMGiKGUTvI7R+098zpeBbCzhbnCPFPTAx3mOEWtlCeNkraEPb/dPg9PWV+vobAXF3jFkgIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176532; c=relaxed/simple;
	bh=xFVC0xPm0eXEmudJSkMxtaZYbBcNEsxUF+ByAkbY7cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eyn+CFUcQsDo5odzsIhmWaQItNWsEKmTtuFCHUIFrRlcraO3Qa3c1dyUNGb5oa3OOHAvhq9aGn4b6Lsl9oaMO43A2ixcuTP6w9FgEplYFhbBiFsVFpyXs+HikuC0EqbRnR13n3SeG2AMsuXYvGJhN8DkQOKz7F9XICW9k71u8O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wiPXIsxX; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f223c99a3so425292f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 00:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718176528; x=1718781328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jsA9fUmKBK5EdL/aJskGAqPwShxYcp+fy8oN2nYqXck=;
        b=wiPXIsxXUSLsGCZnwVPXzKHLVLAiCGti0xf1nPMr1uuxbgY8oY3DqyhxB50fIs/Qv5
         vB133lMzAXEgv8QKi8uq5JTKdO8SjGNAO19as/4fHlO+SonT1+G73hA8FASiHqU2UToU
         cc0/Wd5GvvJnC4H0pGA82vWKdHIy/YtZBVpQECpxZPBMMq3IAR2kmQHoXpuKsp5UcOIF
         pfgBsGnxVbIeDPjmi4kO8FMGHi5KZiYe3Zwy3S4bcUeOPGlj9/sOs7tgL92QORe34E4I
         PVfNDcqxYrMiD/aGtodxNjAwhTxc6Ye9BuOu32NZ/eNuGdfc6OiMkLYzQekdETL/CqXa
         bPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718176528; x=1718781328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsA9fUmKBK5EdL/aJskGAqPwShxYcp+fy8oN2nYqXck=;
        b=dAGwYSVRJZXemQctK5WsugDGPvU9xNrapp0gyyEjOHhqo0IZh8Tb05thNZUyNUaQk/
         Bc7p9vKVVhHYXSk7uf1KjZXhefsaqRTCsPYM1n2J8M9i7eDYVp5AiJeObQ9CNAefasmC
         P8LCY13+j4iiGshMhqcos9KndjqylwzFE/+LYALGhL1g6xbyedd8VPf6T0gwKnEKltQj
         Ai62n+r4wSAn99CJRV9dkkQwS3z2Sv2iZ+d9YpGUaGaBetgPlnwwCyNtzfBy3Oj4ClJN
         D7FFZDkIXMJDvuPhKEBfBfcEb8taXQpbOdamd25eW/ZnOUa5L46gQSqnTmox86Putw/g
         rFdw==
X-Forwarded-Encrypted: i=1; AJvYcCU0c3D9MeixKmiQvYnsOTcZY7GjJ7WTGoNS0Fl49NLfVsZU3wfqoDQxn81pT/OcwZqdGhTcs6sSIKW6YiMihtmQO6L5WIkKOQWfRsgS
X-Gm-Message-State: AOJu0YyqBGWmlVw5DJzWaF/A2PgorM3Lhuli0LVrOg+Wpi3fP+IwTTvs
	tz0hwvLztuiolnu1ZfxqxylcpQv6Gpj9cs4ZDV3Aqlc57Tq8wdZ+nAlV/rWKLeI=
X-Google-Smtp-Source: AGHT+IEQ29/S9QpyDljWJ4Q4lcG+cZp9+XdCUGpDNx727bkXJb6iRVuXIr3ff2x3ippJIse1bLhIPw==
X-Received: by 2002:a05:600c:5487:b0:421:7ee4:bbfe with SMTP id 5b1f17b1804b1-42285d851b0mr6833735e9.0.1718176528377;
        Wed, 12 Jun 2024 00:15:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:e10f:8f03:e7e9:a919? ([2a01:e0a:999:a3a0:e10f:8f03:e7e9:a919])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe75ebsm13845365e9.9.2024.06.12.00.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 00:15:27 -0700 (PDT)
Message-ID: <c1f5a958-1130-4bdb-a154-0c0eeb06c8f9@rivosinc.com>
Date: Wed, 12 Jun 2024 09:15:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
To: Deepak Gupta <debug@rivosinc.com>, Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Alexandre Ghiti
 <alex@ghiti.fr>, Jesse Taube <jesse@rivosinc.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Atish Patra <atishp@rivosinc.com>
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
 <Zmht+h75GgxP3ocz@debug.ba.rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <Zmht+h75GgxP3ocz@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/06/2024 17:32, Deepak Gupta wrote:
> On Mon, Jun 10, 2024 at 10:56:35PM +0100, Conor Dooley wrote:
>> On Mon, Jun 10, 2024 at 02:06:50PM -0700, Deepak Gupta wrote:
>>> On Mon, Jun 10, 2024 at 11:16:42AM +0200, Clément Léger wrote:
>>> > On 10/06/2024 11:02, Conor Dooley wrote:
>>> > > On Mon, Jun 10, 2024 at 10:33:34AM +0200, Clément Léger wrote:
>>> > > > On 07/06/2024 20:51, Deepak Gupta wrote:
>>> > > > > On Mon, Jun 03, 2024 at 01:47:40PM +0100, Conor Dooley wrote:
>>> > > > > > On Mon, Jun 03, 2024 at 11:14:49AM +0200, Alexandre Ghiti
>>> wrote:
>>> > > > > I don't know all the details but on first glance it seems
>>> like instead
>>> > > > > of ACPI,
>>> > > > > may be FWFT is a better place for discovery ?
>>> > > > >
>>> https://lists.riscv.org/g/tech-prs/topic/patch_v12_add_firmware/106479571
>>> > > >
>>> > > > IMHO, doing discovery in FWFT is not the goal of this
>>> extension. I think
>>> > > > the "real" solution would be to wait for the unified discovery
>>> task
>>> > > > group to come up with something for that (which is their goal I
>>> think) [1]
>>>
>>> Yeah I understand the conundrum here.
>>>
>>> > >
>>> > > I'm curious to see how that works out. The proposal documents an
>>> m-mode
>>> > > csr, so we'd have to smuggle the information to s-mode somehow...
>>> >
>>> > Ahem, yeah, I spoke a bit too fast. Looked at the proposal and the
>>> > mconfigptr CSR will be accessible by M-mode only so I guess we will
>>> have
>>> > to find another way...
>>>
>>> That's not the only problem. Even if you get mconfigptr access,
>>> parsing the format
>>> is another thing that has to be done. This is early in boot. Although
>>> its strictly (pun
>>> intended) not a firmware feature extension, I think it's much easier
>>> to ask underlying
>>> firmware if platform is `Sstrict`. or may be expose something like below
>>>
>>> `ENABLE_SSTRICT`.
>>> Platforms which support `Sstrict` can return success for this while
>>> platforms which don't
>>> have `Sstrict` can return error code (not supported or not implemented).
>>> This way its not feature discovery.
>>
>> I mean, it's feature discovery in all but name. You're calling it
>> enable, but the behaviour you describe is feature discovery - not that I
>> am against this being feature discovery since it gets us out of an
>> annoying bind.
> 
> Yes I know it's cheating but at least for this case, it seems like easy
> solution which
> doesn't break anything. Neither I see it creating any future problems
> (except FWFT becoming
> to look like discovery mechanism :-) and Clement/Atish hating me for that)

Ahah no worries;) Thinking a bit more about it, if we need only a few
extensions to be discoverable, it seems manageable (ie add a "locked"
feature that report the extension availability itself, get only will
work, set will return SBI_EDENIED). But if need more of them, then a
dedicated mechanism should probably be designed.

Clément

> 
> Another solution to this could be introducing a riscv config
> `CONFIG_RISCV_SSTRICT`.
> By default always select `CONFIG_RISCV_SSTRICT` and any platform owner
> who are not
> sstrict, they can build their own.
> I expect distro (ubuntu, red hat, etc) would want by default
> `CONFIG_RISCV_SSTRICT`.
> 
>>
>> I forget which extension Alex and I discussed previously, but there's
>> some mm-related things that you're gonna have to probe super early and
>> we need to figure out if we can get that info from ACPI or not. I know
>> we discussed it w.r.t. one of the T-Head vendor extensions, but I think
>> another standard one got mentioned too.
>>
>>> It seems like arm64 parses fdt and it reads certain CSRs too
>>> (`arch/arm64/kernel/pi/kaslr_early.c`). Although it doesn't look like
>>> it has to do any
>>> discovery for them.
>>
>> A decree from the Palmer that we don't support things that do not conform
>> in this manner would allow us to do what arm64 does. I brought this up
>> originally because it's been discussed before that we cannot rely on
>> conformance because we want to support people's platforms, whether they
>> comply or not. I'd be wary of making this an exception now, and then
>> later on someone makes a platform we want to support that doesn't
>> conform and hey presto, we regress KASLR support - even if I think it is
>> pretty unlikely that someone is going to repurpose the Zkr CSRs.
>>
>> One of the problems with only supporting conforming platforms is that
>> the definition of conforming changes over time! This has happened with
>> the Andes PMU for example, which I believe uses an interrupt number that
>> was later co-opted by AIA spec. That conformed at the time, but doesn't
>> anymore - do they get to mark themselves as Sstrict?
>>
>> Maybe we can do this on a case-by-case basis, but it's up to Palmer
>> whether or not we can do that.

