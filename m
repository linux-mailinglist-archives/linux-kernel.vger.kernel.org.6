Return-Path: <linux-kernel+bounces-211725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0D9905600
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1782864AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153A917FAAD;
	Wed, 12 Jun 2024 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="MvsU6UpK"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391F717B417
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204303; cv=none; b=nNcTRm7CYhE+cMVHg2mQBIUiG5GpCu/A2/v2bhPDZX3MU4rdoQB/iU+Ljmy2WniiszzueJP/lnAl2Li2fSJ4qGkD/JTR0IThtdL3Tl8SNaQgdly7S61piCpaJy1IhNQFcg9L0Y2iZGoUFg0TvgzLBLSW8sDiELflI4IWp1w5i+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204303; c=relaxed/simple;
	bh=n0t6zpzKRUuFPMrM7Q3gm0V90FFk8BqQaytgPKRJSbo=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=NUnq63BdI3vPcvdpinIM43qH+AKzdz2LVCW1Wrj2osxJq1ZHveeNGqwXQd8oBUNAfgGItwaFmukGlRZhvZ9NWMkZIYIfk/I4vzQFoSXE+4ZbgiPreYveE6lPeOvubIajg7QA3EWhgUU5LEjTbOCK8aDJi5CmPKPSzaSDeiGtRXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=MvsU6UpK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f68834bfdfso51767825ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1718204300; x=1718809100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYVQc7sbI7D0Oe7HLiFsYyb4EXhyajIKibLIV5on50g=;
        b=MvsU6UpKudDuzaEO2AFFDu21KprIxMxtscRM4zAAHhFtueLwwrQ1sgTUCKvjhtircR
         KhpMnOnxDJnvICXf5hkWHtYMU0Dq+9IfSQTehRSgUwkS8juaXQ7AWF7fs+yLCj2cwIO5
         XpQ0mOIVHpzOGC0vITMLaQin0yn4hXraYSplRZ6RHe+OCp9gLI5nVlVepr1XmUe9zu+X
         YbN37nEj2ULEVo2bzPVRymsNp6Eg3lhq4S8t5j/7Zyob8FyYj0oAvNyidxXB6lOOhuww
         jo0TcZ/BLSF2+DjbxT42odbPAvp/ZyaRPPKx5Q/85lFguVQRHjydJURlEL2cJIDIQ9zV
         ofAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718204300; x=1718809100;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYVQc7sbI7D0Oe7HLiFsYyb4EXhyajIKibLIV5on50g=;
        b=WpZ/Ow472qETOG5y9rZwrCEwrsEZUuKvrnCNnj0RIMByPfF7yn8lEKSHvwlxpEC03I
         xYwupmIWBSAxOomB7HmpwjKiJ52QMI5Sri4uh7S0od56iUCcih0yJYQFM5fuqIMP70Je
         CNwMyLC8GiVWeLfK7Aoy/wnRXyvJqw9lu77OMZoN8mANs6+G70pxRwiF6jjHz4v3cThA
         CGofP2PxzZjZ6Gmr5qtMcZqkWdOl4u5yzH94dMN7diCvCJUNp8JlnXEJ+chFjlAKlNjW
         TkLm7tkPFslGcG3MO/1reSMko25OazsNP2FMyvXb1y7tpSBJ8yrUe5EArCi7WNZyOFwC
         b34A==
X-Forwarded-Encrypted: i=1; AJvYcCUIfVboPnOMEqtTTZcxDOlPQ8u3UL7WzYgP+s4hVp/1yiBYfeUZr+YPd7F2fXHTMtEl73JWY2pFhmhJklA4fWqla63VblTAMqRvR75l
X-Gm-Message-State: AOJu0Yx6DZzVoZBGZvDe0CfvpzHXt0PzMc26+DSCDiALuGobWdkJSlJJ
	47huEBHPQTxz01VwAuqIhJcIXYfjRGeCo5+EElzQh9fpayUSLTCEZvTiVIrHL7Y=
X-Google-Smtp-Source: AGHT+IGrq7jW8732rVd+qc8IpryGpylS9Fm49H6HNRQuvUwUSpYg0NbpacN44xXJc7BI5TdojnEihw==
X-Received: by 2002:a17:902:c404:b0:1f4:5dc0:5fe8 with SMTP id d9443c01a7336-1f83b6989b3mr20922595ad.15.1718204300054;
        Wed, 12 Jun 2024 07:58:20 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6d7091e5esm103751575ad.167.2024.06.12.07.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 07:58:19 -0700 (PDT)
Date: Wed, 12 Jun 2024 07:58:19 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jun 2024 07:58:17 PDT (-0700)
Subject:     Re: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
In-Reply-To: <c1f5a958-1130-4bdb-a154-0c0eeb06c8f9@rivosinc.com>
CC: debug@rivosinc.com, Conor Dooley <conor@kernel.org>,
  Conor Dooley <conor.dooley@microchip.com>, alex@ghiti.fr, jesse@rivosinc.com, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org, llvm@lists.linux.dev, alexghiti@rivosinc.com, aou@eecs.berkeley.edu,
  Bjorn Topel <bjorn@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>, nathan@kernel.org,
  ndesaulniers@google.com, masahiroy@kernel.org, Atish Patra <atishp@rivosinc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: cleger@rivosinc.com
Message-ID: <mhng-e9618799-eb28-4e60-a321-41a786f2a332@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 12 Jun 2024 00:15:26 PDT (-0700), cleger@rivosinc.com wrote:
>
>
> On 11/06/2024 17:32, Deepak Gupta wrote:
>> On Mon, Jun 10, 2024 at 10:56:35PM +0100, Conor Dooley wrote:
>>> On Mon, Jun 10, 2024 at 02:06:50PM -0700, Deepak Gupta wrote:
>>>> On Mon, Jun 10, 2024 at 11:16:42AM +0200, Clément Léger wrote:
>>>> > On 10/06/2024 11:02, Conor Dooley wrote:
>>>> > > On Mon, Jun 10, 2024 at 10:33:34AM +0200, Clément Léger wrote:
>>>> > > > On 07/06/2024 20:51, Deepak Gupta wrote:
>>>> > > > > On Mon, Jun 03, 2024 at 01:47:40PM +0100, Conor Dooley wrote:
>>>> > > > > > On Mon, Jun 03, 2024 at 11:14:49AM +0200, Alexandre Ghiti
>>>> wrote:
>>>> > > > > I don't know all the details but on first glance it seems
>>>> like instead
>>>> > > > > of ACPI,
>>>> > > > > may be FWFT is a better place for discovery ?
>>>> > > > >
>>>> https://lists.riscv.org/g/tech-prs/topic/patch_v12_add_firmware/106479571
>>>> > > >
>>>> > > > IMHO, doing discovery in FWFT is not the goal of this
>>>> extension. I think
>>>> > > > the "real" solution would be to wait for the unified discovery
>>>> task
>>>> > > > group to come up with something for that (which is their goal I
>>>> think) [1]
>>>>
>>>> Yeah I understand the conundrum here.
>>>>
>>>> > >
>>>> > > I'm curious to see how that works out. The proposal documents an
>>>> m-mode
>>>> > > csr, so we'd have to smuggle the information to s-mode somehow...
>>>> >
>>>> > Ahem, yeah, I spoke a bit too fast. Looked at the proposal and the
>>>> > mconfigptr CSR will be accessible by M-mode only so I guess we will
>>>> have
>>>> > to find another way...
>>>>
>>>> That's not the only problem. Even if you get mconfigptr access,
>>>> parsing the format
>>>> is another thing that has to be done. This is early in boot. Although
>>>> its strictly (pun
>>>> intended) not a firmware feature extension, I think it's much easier
>>>> to ask underlying
>>>> firmware if platform is `Sstrict`. or may be expose something like below
>>>>
>>>> `ENABLE_SSTRICT`.
>>>> Platforms which support `Sstrict` can return success for this while
>>>> platforms which don't
>>>> have `Sstrict` can return error code (not supported or not implemented).
>>>> This way its not feature discovery.
>>>
>>> I mean, it's feature discovery in all but name. You're calling it
>>> enable, but the behaviour you describe is feature discovery - not that I
>>> am against this being feature discovery since it gets us out of an
>>> annoying bind.
>>
>> Yes I know it's cheating but at least for this case, it seems like easy
>> solution which
>> doesn't break anything. Neither I see it creating any future problems
>> (except FWFT becoming
>> to look like discovery mechanism :-) and Clement/Atish hating me for that)
>
> Ahah no worries;) Thinking a bit more about it, if we need only a few
> extensions to be discoverable, it seems manageable (ie add a "locked"
> feature that report the extension availability itself, get only will
> work, set will return SBI_EDENIED). But if need more of them, then a
> dedicated mechanism should probably be designed.
>
> Clément
>
>>
>> Another solution to this could be introducing a riscv config
>> `CONFIG_RISCV_SSTRICT`.
>> By default always select `CONFIG_RISCV_SSTRICT` and any platform owner
>> who are not
>> sstrict, they can build their own.
>> I expect distro (ubuntu, red hat, etc) would want by default
>> `CONFIG_RISCV_SSTRICT`.

IMO things like Sstrict is going to end up being useless.  It's just 
another way to kick the can down the road on actually having 
compatibility.  We've already seen this with the extensions and the 
profiles, I don't see how Sstrict is any different.

The RISC-V foundation needs to just actually do compatibility, making up 
more names isn't going to change anything.

>>> I forget which extension Alex and I discussed previously, but there's
>>> some mm-related things that you're gonna have to probe super early and
>>> we need to figure out if we can get that info from ACPI or not. I know
>>> we discussed it w.r.t. one of the T-Head vendor extensions, but I think
>>> another standard one got mentioned too.
>>>
>>>> It seems like arm64 parses fdt and it reads certain CSRs too
>>>> (`arch/arm64/kernel/pi/kaslr_early.c`). Although it doesn't look like
>>>> it has to do any
>>>> discovery for them.
>>>
>>> A decree from the Palmer that we don't support things that do not conform
>>> in this manner would allow us to do what arm64 does. I brought this up
>>> originally because it's been discussed before that we cannot rely on
>>> conformance because we want to support people's platforms, whether they
>>> comply or not. I'd be wary of making this an exception now, and then
>>> later on someone makes a platform we want to support that doesn't
>>> conform and hey presto, we regress KASLR support - even if I think it is
>>> pretty unlikely that someone is going to repurpose the Zkr CSRs.

Ya, I think that's fine.  Let's just blindly read the CSR without 
probing, if some hardware has destructive side effects on the CSR read 
then we can figure out what to do with it later.

>>> One of the problems with only supporting conforming platforms is that
>>> the definition of conforming changes over time! This has happened with
>>> the Andes PMU for example, which I believe uses an interrupt number that
>>> was later co-opted by AIA spec. That conformed at the time, but doesn't
>>> anymore - do they get to mark themselves as Sstrict?
>>>
>>> Maybe we can do this on a case-by-case basis, but it's up to Palmer
>>> whether or not we can do that.

Yep.  Trying to stick to only supporting what counts as conforming today 
isn't going to work, RISC-V just isn't managed that way.  That's why we 
have all these strict rules about avoiding breaking what used to work in 
software land, if we didn't have those then we be breaking users every 
release.

