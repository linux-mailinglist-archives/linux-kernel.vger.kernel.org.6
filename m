Return-Path: <linux-kernel+bounces-228664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DAB916528
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75961C21B68
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D81814BF98;
	Tue, 25 Jun 2024 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="L/qxmsN9"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D712B14A0BC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310762; cv=none; b=Cu0qpbel/a3kjK6/O1AjlLyZBet8kMO5aGNe9dEAQJCSHbm/bCmSBhtiM/ouCZq9MDQyO8p8iyNmkiNsE+idTbmm+a8SCdfW1xClOS5I8+0296vLwvGry/QlVpnsFrNwmkEpwtQYgG2ZY/gSL0R31qO4YZDa96NSMZ9h4TX1TnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310762; c=relaxed/simple;
	bh=8OPDctfvuC9BxpIbhEk7MshqYOmXZXxn59puCcy8xCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoG320YS92ljLBzdHcraZ4tLK+exT+lIMSY5qHCfly8V6P02J0//B4zOr42vGiv97zLTvZJKJZ2lHItsDzbIvwCVxW28T5myNJEMYzYrY33YYyAjGdBGkssoiJFNqfJyMY1ZlE7Jo1VHNBL1we+RKClKehx/8KgkWwOYQOozyJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=L/qxmsN9; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ec002caeb3so67957171fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1719310759; x=1719915559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e4j7Av8Nq59GpAFUJYmcgApSr33u/5sSai5UJj1fYMw=;
        b=L/qxmsN9iWN1FoO6iZWD4DzOaHUfNedNaAiAY/o2GHmDKJuFHeiaEjslPDYLF380fE
         CgROcxUX5ixrHaCULnWPF7zpJ+jjSCoPJbIccH0LqdG4SyqMl/Mshv/z3s0EFQ9YnuVT
         zH1TggYqamWz4U6xSRDVihzWWx1IpdKOOMmMz6gfwy0sbQU1jE/ptRZALGH8sUdW1K1A
         5Xfk0DVje1oKiMZp6lqnp+WXmUh8+7L1r4WwF8eV0/xq/ZEleGG4+cel8OSMTW5OBXes
         FgK/KprpkSEUELdymOcyvzVqVPpOVxI+9NMR+JldpBqqUPWyRAP3j59V541uF3ZQBSfv
         6p7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719310759; x=1719915559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4j7Av8Nq59GpAFUJYmcgApSr33u/5sSai5UJj1fYMw=;
        b=UwWd0nf5FuNhPMu5z4v3CGCP0u38Fnv+ehBFyI3NsjFUwhlWDcHjZHfMJaPHTE1C8a
         L1Zv9YRZ4BlKumiTQqDgeTI7KwR1Z3+ANJsAU5b+zmtBFDM14wy9vCKbNfMiBMG4MIux
         AT0ep89lzX09iW6zGLNbIEpmDdMQ/Hb1btMdXtLs9inEI08bX2ThS2vpPtOjvXDMvkRn
         mHR/femJUDJuP9p8D/3EhuE5cn6n4J/CpLSbuHSbed4GmnXsA/ppZ50Z4F2zjiICuBzX
         C8CQk1aObUy0qtuxdTmpC6bk91HRUHEOyM9mQD6jvm9669Vi53N9lCbODzWm9ZjEXgh8
         HZjw==
X-Forwarded-Encrypted: i=1; AJvYcCXAiJQL4R1FUx34KUnpiaB1S5vfsY1VntN9Zo3Y5NK6mhX4vQFuyxiWE1y7dr32VRx9p2bHhAKoXMXDGEY/1CWl0jSw2bz0H+OGkT5c
X-Gm-Message-State: AOJu0Yz1rymo4N9q6cOw6GlJnLpEnlvKQ9ZP2VTqFJDd5K6Dk+Z2UhzC
	tRFzfF94eacy9Ibchs5rabxhIVj1Ldees3c0/4jiebSASdeJeq5h676W14ufOuQ=
X-Google-Smtp-Source: AGHT+IHW4ivi9v86O85GxGwVRU8LzjOJfbe+LC73TyIg8LE7Mbff3CySVIzVfV1boeAtnfeBaCShnQ==
X-Received: by 2002:a2e:9495:0:b0:2ec:440c:4e1c with SMTP id 38308e7fff4ca-2ec57967bcemr43276741fa.11.1719310758595;
        Tue, 25 Jun 2024 03:19:18 -0700 (PDT)
Received: from localhost ([185.71.170.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817a9f11sm164326695e9.18.2024.06.25.03.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 03:19:18 -0700 (PDT)
Date: Tue, 25 Jun 2024 12:19:16 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Conor Dooley <conor@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, 
	Conor Dooley <conor.dooley@microchip.com>, Anup Patel <apatel@ventanamicro.com>, 
	Yong-Xuan Wang <yongxuan.wang@sifive.com>, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, greentime.hu@sifive.com, 
	vincent.chen@sifive.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dt-bindings: riscv: Add Svade and Svadu Entries
Message-ID: <20240625-6fb62d7ea4b9f6106e27e149@orel>
References: <CAK9=C2XH7-RdVpojX8GNW-WFTyChW=sTOWs8_kHgsjiFYwzg+g@mail.gmail.com>
 <40a7d568-3855-48fb-a73c-339e1790f12f@ghiti.fr>
 <20240621-viewless-mural-f5992a247992@wendy>
 <edcd3957-0720-4ab4-bdda-58752304a53a@ghiti.fr>
 <20240621-9bf9365533a2f8f97cbf1f5e@orel>
 <20240621-glutton-platonic-2ec41021b81b@spud>
 <20240621-a56e848050ebbf1f7394e51f@orel>
 <20240621-surging-flounder-58a653747e1d@spud>
 <20240621-8422c24612ae40600f349f7c@orel>
 <20240622-stride-unworn-6e3270a326e5@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240622-stride-unworn-6e3270a326e5@spud>

On Sat, Jun 22, 2024 at 01:01:30PM GMT, Conor Dooley wrote:
> On Fri, Jun 21, 2024 at 05:08:01PM +0200, Andrew Jones wrote:
> > On Fri, Jun 21, 2024 at 03:58:18PM GMT, Conor Dooley wrote:
> > > On Fri, Jun 21, 2024 at 04:52:09PM +0200, Andrew Jones wrote:
> > > > On Fri, Jun 21, 2024 at 03:04:47PM GMT, Conor Dooley wrote:
> > > > > On Fri, Jun 21, 2024 at 03:15:10PM +0200, Andrew Jones wrote:
> > > > > > On Fri, Jun 21, 2024 at 02:42:15PM GMT, Alexandre Ghiti wrote:
> > > 
> > > > > > I understand the concern; old SBI implementations will leave svadu in the
> > > > > > DT but not actually enable it. Then, since svade may not be in the DT if
> > > > > > the platform doesn't support it or it was left out on purpose, Linux will
> > > > > > only see svadu and get unexpected exceptions. This is something we could
> > > > > > force easily with QEMU and an SBI implementation which doesn't do anything
> > > > > > for svadu. I hope vendors of real platforms, which typically provide their
> > > > > > own firmware and DTs, would get this right, though, especially since Linux
> > > > > > should fail fast in their testing when they get it wrong.
> > > > > 
> > > > > I'll admit, I wasn't really thinking here about something like QEMU that
> > > > > puts extensions into the dtb before their exact meanings are decided
> > > > > upon. I almost only ever think about "real" systems, and in those cases
> > > > > I would expect that if you can update the representation of the hardware
> > > > > provided to (or by the firmware to Linux) with new properties, then updating
> > > > > the firmware itself should be possible.
> > > > > 
> > > > > Does QEMU have the this exact problem at the moment? I know it puts
> > > > > Svadu in the max cpu, but does it enable the behaviour by default, even
> > > > > without the SBI implementation asking for it?
> > > > 
> > > > Yes, because QEMU has done hardware A/D updating since it first started
> > > > supporting riscv, which means it did svadu when neither svadu nor svade
> > > > were in the DT. The "fix" for that was to ensure we have svadu and !svade
> > > > by default, which means we've perfectly realized Alexandre's concern...
> > > > We should be able to change the named cpu types that don't support svadu
> > > > to only have svade in their DTs, since that would actually be fixing those
> > > > cpu types, but we'll need to discuss how to proceed with the generic cpu
> > > > types like 'max'.
> > > 
> > > Correct me please, since I think I am misunderstanding: At the moment
> > > QEMU does A/D updating whether or not the SBI implantation asks for it,
> > > with the max CPU. The SBI implementation doesn't understand Svadu and
> > > won't strip it. The kernel will get a DT with Svadu in it, but Svadu will
> > > be enabled, so it is not a problem.
> > 
> > Oh, of course you're right! I managed to reverse things some odd number of
> > times (more than once!) in my head and ended up backwards...
> 
> I mean, I've been really confused about this whole thing the entire
> time, so ye..
> 
> Speaking of QEMU, what happens if I try to turn on svade and svadu in
> QEMU? It looks like there's some handling of it that does things
> conditionally based !svade && svade, but I couldn't tell if it would do
> what we are describing in this thread.

It'll use exception mode, but {m,h}envcfg.ADUE is still provided to allow
software to switch to hardware updating when FWFT exists. So I think we're
good to go.

Thanks,
drew

