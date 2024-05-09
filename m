Return-Path: <linux-kernel+bounces-174501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035FE8C0FA9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2831F21E5D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279D286AE5;
	Thu,  9 May 2024 12:32:10 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C47613175D
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715257928; cv=none; b=tnUPty0m52EtZxiU1R+2+NqysskhfkKfjN2mjLbk6gDZ5LjIwxGjhW4l8ajQxjh7z65MGBaXChKBSG8qkDanz6GbCMACKiKzr9b3o4S4DgYYLcf+4dKpg+JMo0YWjF068zrFOTOyUkzhTOm+WUD58KZI2MZk5PSIhN/r5bxi8DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715257928; c=relaxed/simple;
	bh=xgZMRL2Kwcto3vC3Q/mNIYCP0B03xrT0cPEyuQHr8k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhhSq9qBeZ2MMpHsBcmr4I6sf+DqOyDT9+o4KqHyaq9ppqY4dvoAkUnjfX5cp2msafgw3u4HS2zUEPGEBHkJnRf5fThNMzUCyVf90wVn31jnHlNOPe3TGMbDHEDdlB0h5Oh9l4GDmR0IjxRX/aNmg6aeqGCaiSpwlMyuCrvH4AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5210684cee6so830617e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 05:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715257922; x=1715862722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgZMRL2Kwcto3vC3Q/mNIYCP0B03xrT0cPEyuQHr8k4=;
        b=EOlXpAToprSbFSr/kMnL3G9JqLOMyuNX9dr0TghyB6DaYUeydN2xUOSefxgBlYt2Ea
         9I4DHYt5Mo3uTSQQalqG+WAd+7N83+2Azinnguqc1IwoCEV2zx2hWSGbdvl7l8KPKj8V
         2m+tjtcBRFuSbh6Mrkak8QKuN94CjBSKt3TBsQbM3076GtqirxOfKqA6hzWLWzaIYhbU
         4Ndn+Mfll5/6aqCgR1/cOsFu8DvanEP+AzTHs54g7GLOS4zSudnLekRzOwGRxuOwPIZD
         Ec+i533LOLmTkqWMViBlUKoxJfgwWXdCGwWXbSH068BqD01UkGx1OZodYzQxwHr0VTOt
         bMQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUja8O+mrdSqXuJrt+BXPN2RflHuDIGH6dTkjEZAvwUjW03AOXv7Ds6h9WlRBRyQL4lC9HpyMVcAaZuHUCjxzJnisUdYOofllbj76e+
X-Gm-Message-State: AOJu0YxD9LmUJMCKwz9WU/uf7NcdNC0M7cIfUsEnlqOBp/CUdr1yA2YP
	z2qLtfgnWyaBXjPym31/K0FQ5tTOOAST9WiYl1goIQxx8Bz/vJqj2GyP3ABL2MFbfw==
X-Google-Smtp-Source: AGHT+IEYLNU9pCqotkYj/grPbz8UvTqyFnuAP61IK3Y0YSuQYpSCFtlPjIEu9Mcir08NUGB0TyjyXA==
X-Received: by 2002:ac2:43c1:0:b0:51c:cd8d:2865 with SMTP id 2adb3069b0e04-5217cc4585bmr3034531e87.44.1715257922475;
        Thu, 09 May 2024 05:32:02 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39d2d57sm278477e87.260.2024.05.09.05.32.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 05:32:02 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so9199581fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 05:32:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhnIQ28qPso6cFnmKwrtAyjDWodgWBX+TpZ6U5mdMd4GH1zP/MTDVC2mmWyn7wZ6R1JebAXDs6ud8D8nfa00NMWys/je8ouUsNXFMW
X-Received: by 2002:a17:906:f1d5:b0:a59:c209:3e33 with SMTP id
 a640c23a62f3a-a59fb9492famr373848466b.15.1715257901263; Thu, 09 May 2024
 05:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411-tso-v1-0-754f11abfbff@marcan.st> <20240411132853.GA26481@willie-the-truck>
 <87seythqct.fsf@draig.linaro.org> <CAMj1kXFqG7D2Q_T_NXZ-y3NYOjK6d8bP8ihJTeFz8TUJ77W7tw@mail.gmail.com>
 <Zjyv23IuJFrk9Zh0@arm.com>
In-Reply-To: <Zjyv23IuJFrk9Zh0@arm.com>
From: Neal Gompa <neal@gompa.dev>
Date: Thu, 9 May 2024 06:31:04 -0600
X-Gmail-Original-Message-ID: <CAEg-Je-OXR_dxCUc2Vgm8jzZgs7Ph06jqPKsVQML8Qb5FuTWPQ@mail.gmail.com>
Message-ID: <CAEg-Je-OXR_dxCUc2Vgm8jzZgs7Ph06jqPKsVQML8Qb5FuTWPQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Zayd Qumsieh <zayd_qumsieh@apple.com>, 
	Justin Lu <ih_justin@apple.com>, Ryan Houdek <Houdek.Ryan@fex-emu.org>, 
	Mark Brown <broonie@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Miguel Luis <miguel.luis@oracle.com>, Joey Gouly <joey.gouly@arm.com>, 
	Christoph Paasch <cpaasch@apple.com>, Kees Cook <keescook@chromium.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Baoquan He <bhe@redhat.com>, 
	Joel Granados <j.granados@samsung.com>, Dawei Li <dawei.li@shingroup.cn>, 
	Andrew Morton <akpm@linux-foundation.org>, Florent Revest <revest@chromium.org>, 
	David Hildenbrand <david@redhat.com>, Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>, 
	Josh Triplett <josh@joshtriplett.org>, Oleg Nesterov <oleg@redhat.com>, Helge Deller <deller@gmx.de>, 
	Zev Weiss <zev@bewilderbeest.net>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Asahi Linux <asahi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 5:13=E2=80=AFAM Catalin Marinas <catalin.marinas@arm=
com> wrote:
>
> On Tue, May 07, 2024 at 04:52:30PM +0200, Ard Biesheuvel wrote:
> > On Tue, 7 May 2024 at 12:24, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> > > I think the main use case here is for emulation. When we run x86-on-a=
rm
> > > in QEMU we do currently insert lots of extra barrier instructions on
> > > every load and store. If we can probe and set a TSO mode I can assure
> > > you we'll do the right thing ;-)
> >
> > Without a public specification of what TSO mode actually entails,
> > deciding which of those barriers can be dropped is not going to be as
> > straight-forward as you make it out to be.
> >
> > Apple's TSO mode is vertically integrated with Rosetta, which means
> > that TSO mode provides whatever Rosetta needs to run x86 code
> > correctly, and that it could mean different things on different
> > generations of the micro-architecture. And whether Apple's TSO is the
> > same as Fujitsu's is anyone's guess afaik.
>
> Indeed. Apart from using impdef registers, that's what I think is the
> second biggest problem with this feature (and the corresponding
> patches). We don't know the precise memory model, we can't tell whether
> this TSO bit is stored in the TLB. If it is, is it per ASID/VMID? The
> other problem Marc raised is what memory model is between two CPUs where
> only one has the TSO bit set? Does it only break the TSO model or is
> there a chance that it also breaks the default relaxed model? What other
> TSO flavours are out there, how do they compare with the Apple one?
>
> > Running a game and seeing it perform better is great, but it is not
> > the kind of rigor we usually attempt to apply when adding support for
> > architectural features. Hopefully, there will be some architectural
> > support for this in the future, but without any spec that defines the
> > memory model it implements, I am not convinced we should merge this.
>
> There is FEAT_LRCPC (available on Apple Silicon from M2 onwards). Rather
> than having a big knob to turn TSO on or off, this feature introduces
> instructions that permit a code generator to get the TSO semantics in a
> more efficient way (e.g. using LDAPR+STLR instead of the stricter
> LDAR+STLR; not sure how well these are implemented on the Apple
> Silicon). There are further improvements in FEAT_LRCPC{2,3} (with the
> latter adding support for SIMD but not available in hardware yet). So
> the direction from Arm is pretty clear, acknowledging that there is a
> need for such TSO emulation but not in the way of undocumented impdef
> registers. Whether more is needed here, I guess people working on
> emulators could reach out to Arm or CPU vendors with suggestions (the
> path to the architects is not straightforward, usually legal has a say,
> but it's doable, there are formal channels already).
>
> I see the impdef hardware TSO options as temporary until CPU
> implementations catch up to architected FEAT_LRCPC*. Given the problems
> already stated in this thread, I think such hacks should be carried
> downstream and (hopefully) will eventually vanish. Maybe those TSO knobs
> currently make an emulation faster than FEAT_LRCPC* but that's feedback
> to go to the microarchitects on the implementation (or architects on
> what other instructions should be covered).
>

They cannot ever "vanish" because we are supporting every Mx platform
back to the first one. The M1 series will never have FEAT_LRCPC.

I do not think it is unreasonable to support this method when we know
what the CPU platform is and FEAT_LRCPC does not exist.



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

