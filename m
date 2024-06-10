Return-Path: <linux-kernel+bounces-208901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 501AE902A65
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2371F238A3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2E854FAD;
	Mon, 10 Jun 2024 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wM5yJSC8"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337C214277
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718053619; cv=none; b=ugRGBx6xcJ6bisUQGvgVutHJklmqgzeyjZQMjaPTXp8wZ6yAwiISxZUSsvZPfZaJbGt6F1nx6g8FhZ66YAb79qsO3eHEsw5RGTChYsedX6k2Jcxf7ZHKagoxtJtehYVFZUtiDJlIRJqXB5RQ3vwJTWvgAbJLOmql60QcQ4njePM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718053619; c=relaxed/simple;
	bh=8kNEcLqnjSBSzmYInfsSoqzXQrLkZOIpu19v13Wpwyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aI7fE6aswqtc8zkHml7o+f1qQjytqM8bhdPHQ8wiT3txhsMuACFS1apivLbfSbh06CpWoviFBPKVQwUE6pvWZNGxRkIAMqZk6k/EOHYEl1FNK97Y0h+1GFXZiSW/k4DNsGD2fSxEumiqncnWbZiwhukm3VCrOjZlJnqAAI/bALE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wM5yJSC8; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c3274d5cc7so547211a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718053617; x=1718658417; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8kNEcLqnjSBSzmYInfsSoqzXQrLkZOIpu19v13Wpwyw=;
        b=wM5yJSC8u7BVTXPwuvb7O27SSY+cRLNCtp/OqGloKvcCOJf3R/eN9tzYYpFzwzT2HR
         82ITb2bEEDLATQX0w/JAUkbephW8iEl7+BEmuTKNVXzzqB5da5MjT5lOMwE9JusTcIU4
         oGfwn5iAJISoh/wSA+p6KuTodr4RGXDsRy8ekjPKqIAKfq0bsZV9ph+cS79q1OWrSpTE
         5CEqhpnu42inNqvwgDS2mMum34Q6BMEgAFt+adWXcYmNN5AGqVXISWGq4vks8AWSwp7d
         bZZaroWt50F9beu66r1vKti1uPh7cFvmLswOWZY+3sDlNl2VQr10toFve6q79DrZ+hmR
         YkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718053617; x=1718658417;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kNEcLqnjSBSzmYInfsSoqzXQrLkZOIpu19v13Wpwyw=;
        b=AjEL+ARqSyAgbNJDSV33ygF/u5+3+mtwxLP8N2WUheOSA/pMkAGYdWXmLEi0Ekjm/J
         OxKswkV+MKWOw1HuFiTKdnHF01Ecw9UgsAUPRkn0rFU/cZWrYeM9sj/tFBIvhFZ4A+q4
         iBTXGXvm2pZdVrO0dWQ4ccSN+AvckS7LfusazIlPT5JWYhd3SZ9fXGPKDGMxImuE5SuJ
         Vt/KPJ85hGHNY+nUkk49717pypGdi6kDiPIOHKULKKt322V8fXWuBxJaL63IK2eDn9j5
         7EVURNMO8ktWi8unZL0o8LRio+M8OfOCat1kdclzKLR1UQimYCPRJ8+UbaSqHyq6uiob
         exHw==
X-Forwarded-Encrypted: i=1; AJvYcCVSAsOxtCI4c9R4JOzYFgIW367pcwvd6HSwys+2Hcf212H4HmoAlGSvUcceDKoPR4l9USp3MPLG9n3vRZM+6Lv420TQKdpKpjLtHkaG
X-Gm-Message-State: AOJu0YwZQMSdSV1Y0qchTL40LOMFmJ3QpXQRZUMSZoHqHz4ilfYrtvsR
	WnipoNXppxw0Kpw4P6XO2qU+RQPJymfFZfox7lxa2Un5HHeeXgsDykrnYvav8y6m5QZzG39320q
	2
X-Google-Smtp-Source: AGHT+IG9/ui2Pdbq/gGpEHhO3Ddv6VFSpBlRz6d5Y0Sa0RbJWoDbM2M3qtgVqvq/pgFE/wY0HE4mJA==
X-Received: by 2002:a17:90a:d397:b0:2bd:ef6b:c33b with SMTP id 98e67ed59e1d1-2c2bc7b4c69mr11530609a91.0.1718053617512;
        Mon, 10 Jun 2024 14:06:57 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2d7814f45sm5746125a91.5.2024.06.10.14.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 14:06:57 -0700 (PDT)
Date: Mon, 10 Jun 2024 14:06:50 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
	Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
Message-ID: <Zmdq6kszPBxAvLdD@debug.ba.rivosinc.com>
References: <20240531162327.2436962-1-jesse@rivosinc.com>
 <20240531-uselessly-spied-262ecf44e694@spud>
 <b199fde6-c24e-4c18-9c38-fdc923294551@ghiti.fr>
 <20240603-stinking-roster-cfad46696ae5@spud>
 <ZmNWmxak9Rc80Kpb@debug.ba.rivosinc.com>
 <c288f739-2a1a-4fd7-884b-12e360a33142@rivosinc.com>
 <20240610-qualm-chalice-72d0cc743658@wendy>
 <01547275-8c8c-43cf-9da0-64825c234707@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01547275-8c8c-43cf-9da0-64825c234707@rivosinc.com>

On Mon, Jun 10, 2024 at 11:16:42AM +0200, Clément Léger wrote:
>
>
>On 10/06/2024 11:02, Conor Dooley wrote:
>> On Mon, Jun 10, 2024 at 10:33:34AM +0200, Clément Léger wrote:
>>>
>>>
>>> On 07/06/2024 20:51, Deepak Gupta wrote:
>>>> On Mon, Jun 03, 2024 at 01:47:40PM +0100, Conor Dooley wrote:
>>>>> On Mon, Jun 03, 2024 at 11:14:49AM +0200, Alexandre Ghiti wrote:
>>>>>> Hi Conor,
>>>>>>
>>>>>> On 31/05/2024 19:31, Conor Dooley wrote:
>>>>>>> On Fri, May 31, 2024 at 12:23:27PM -0400, Jesse Taube wrote:
>>>>>>>> Dectect the Zkr extension and use it to seed the kernel base
>>>>>> address.
>>>>>>>>
>>>>>>>> Detection of the extension can not be done in the typical
>>>>>> fashion, as
>>>>>>>> this is very early in the boot process. Instead, add a trap handler
>>>>>>>> and run it to see if the extension is present.
>>>>>>> You can't rely on the lack of a trap meaning that Zkr is present
>>>>>> unless
>>>>>>> you know that the platform implements Ssstrict. The CSR with that
>>>>>> number
>>>>>>> could do anything if not Ssstrict compliant, so this approach gets a
>>>>>>> nak from me. Unfortunately, Ssstrict doesn't provide a way to detect
>>>>>>> it, so you're stuck with getting that information from firmware.
>>>>>>
>>>>>>
>>>>>> FYI, this patch is my idea, so I'm the one to blame here :)
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> For DT systems, you can actually parse the DT in the pi, we do it
>>>>>> to get
>>>>>>> the kaslr seed if present, so you can actually check for Zkr. With
>>>>>> ACPI
>>>>>>> I have no idea how you can get that information, I amn't an ACPI-ist.
>>>>>>
>>>>>>
>>>>>> I took a look at how to access ACPI tables this early when
>>>>>> implementing the
>>>>>> Zabha/Zacas patches, but it seems not possible.
>>>>>>
>>>>>> But I'll look into this more, this is not the first time we need the
>>>>>> extensions list very early and since we have no way to detect the
>>>>>> presence
>>>>>> of an extension at runtime, something needs to be done.
>>>>>
>>>>> Aye, having remembered that reading CSR_SEED could have side-effects on a
>>>>> system with non-conforming extensions, it'd be good to see if we can
>>>>> actually do this via detection on ACPI - especially for some other
>>>>> extensions that we may need to turn on very early (I forget which ones we
>>>>> talked about this before for). I didn't arm64 do anything with ACPI in
>>>>> the
>>>>> pi code, is the code arch/x86/boot/compressed run at an equivilent-ish
>>>>> point
>>>>> in boot?
>>>>
>>>> cc: +Clement and Atish
>>>>
>>>> I don't know all the details but on first glance it seems like instead
>>>> of ACPI,
>>>> may be FWFT is a better place for discovery ?
>>>> https://lists.riscv.org/g/tech-prs/topic/patch_v12_add_firmware/106479571
>>>
>>> IMHO, doing discovery in FWFT is not the goal of this extension. I think
>>> the "real" solution would be to wait for the unified discovery task
>>> group to come up with something for that (which is their goal I think) [1]

Yeah I understand the conundrum here.

>>
>> I'm curious to see how that works out. The proposal documents an m-mode
>> csr, so we'd have to smuggle the information to s-mode somehow...
>
>Ahem, yeah, I spoke a bit too fast. Looked at the proposal and the
>mconfigptr CSR will be accessible by M-mode only so I guess we will have
>to find another way...

That's not the only problem. Even if you get mconfigptr access, parsing the format
is another thing that has to be done. This is early in boot. Although its strictly (pun
intended) not a firmware feature extension, I think it's much easier to ask underlying
firmware if platform is `Sstrict`. or may be expose something like below

`ENABLE_SSTRICT`.
Platforms which support `Sstrict` can return success for this while platforms which don't
have `Sstrict` can return error code (not supported or not implemented).
This way its not feature discovery.

It seems like arm64 parses fdt and it reads certain CSRs too
(`arch/arm64/kernel/pi/kaslr_early.c`). Although it doesn't look like it has to do any
discovery for them.

>
>>
>>> Link: https://github.com/riscv/configuration-structure [1]
>>

