Return-Path: <linux-kernel+bounces-303829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69996961587
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A941F24037
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E041D1739;
	Tue, 27 Aug 2024 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHEqQFeJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E551C57B3;
	Tue, 27 Aug 2024 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779974; cv=none; b=A2FzPT1pWEToqXTtCgx7XKO/6sEY32p2O//oyBnDzptPXSeQg7IHTO0VUY2bkTEQrkLsxpb2FRsD6tFxhSzMO4Z0FdYyFSD7z11bRmmrMLGdklsXdePr0RgvenVoeQBC3TmDagrdfQh8BryyiZbh1Y/BUUg8/kLPaUr/kE1H6h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779974; c=relaxed/simple;
	bh=M1tmcsqJYY5or/7JXhieSbFm0OxDJE/MjA4OBPadC88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nr3rYPrfzxGdN3M5vsHtRxyrOttHdOrqmiYOv0JJSiM6MBOBNkMCQTRA/39aY/zZKCcUyMHLg+BjzVssJePM/tMEaWLVfbYo34CARP9inAUn9zkYjV/wCnsEmgHfwkgA/T/QO6l2Lf///IKckP7SVdYpjMfgpmAcIQzPgUVgqeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHEqQFeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AE9C4AF0F;
	Tue, 27 Aug 2024 17:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724779974;
	bh=M1tmcsqJYY5or/7JXhieSbFm0OxDJE/MjA4OBPadC88=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dHEqQFeJhreKqMkr4J8GYeRPdfvgIdFX1+cVRRQjCM2JnP2ab0GgvUFNQYwT4Z4Ao
	 a0fGSBXcRAB6k+ZAyovTaLhR6r606kwlWQrUxNo/13yGrGWq/NWP4JCyjAF90pl7Xb
	 Hqv6WCafc6SiWh1U2nnZMhjtvVg4KiZQiXTlkJt4ZaXC+Y5E171l3gXf09ZlYow6v6
	 9xVhaqHFet1qS9HiuIMEoAxgAzKm+lFTmckADrMOgFSOSYlYyi1tFZ185Tu1/ImZxE
	 78mzYESRYGIQaozJ29WOYkVQBtXFzEuKszccknWeaXfwiDowYo5sXCl6O1k1A5DetU
	 7912DwgT/Bu1g==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f406034874so58552761fa.1;
        Tue, 27 Aug 2024 10:32:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWF4/leFJMQ9Hp8Z0MRm7IkRp0iw69w+hGhmC2MbzT5tUxg+YEsBXwnbs5UmQw1rXgwI0xtnd2Y1fjP@vger.kernel.org, AJvYcCWJZcJOUX7xN9fnmE4vTQg9SUIEeLv2yfnEpQYiSc1VPOpgKsOM+3eoPMqdKNNbYVCgeO474buYUlCgqevE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzm16+gQzYfhK7NP1De+GJup3S3jS1DJqD80jBVccNndVwm3IM
	apV9gXHq6m6W6tn1ZEaC14wIy/ySh+dulD8TXRflepuVCvHUslDOs0UBh6vx3PgljvNgHuQQ6ob
	gpq3bblWkmQc+B9rr8Roh2i+eisU=
X-Google-Smtp-Source: AGHT+IHUqPaorA0zdEf5knFXodoByk71NjHVWZR2sveGzC+pXFb0+66HxIC4RctudxY0fssulxiCofQm1kGNSDqzHvI=
X-Received: by 2002:a2e:a9a0:0:b0:2f4:9fb:5905 with SMTP id
 38308e7fff4ca-2f514940df7mr28117221fa.0.1724779972628; Tue, 27 Aug 2024
 10:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826124802.1552738-1-masahiroy@kernel.org> <20240827155158.GA3940418-robh@kernel.org>
In-Reply-To: <20240827155158.GA3940418-robh@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 28 Aug 2024 02:32:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNARAr9r6pzFzONQnNfFsbFFf_NpE39HBdmVHMBEGe1-nfQ@mail.gmail.com>
Message-ID: <CAK7LNARAr9r6pzFzONQnNfFsbFFf_NpE39HBdmVHMBEGe1-nfQ@mail.gmail.com>
Subject: Re: [PATCH] of: move empty_root and unittest data DTBs to
 .init.rodata section
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 12:52=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Mon, Aug 26, 2024 at 09:48:01PM +0900, Masahiro Yamada wrote:
> > Some architectures can embed DTB(s) in vmlinux. Most of them expect a
> > single DTB in the .dtb.init.rodata section.
> >
> > For example, RISC-V previously allowed embedding multiple DTBs in
> > vmlinux, but only the first DTB in the .dtb.init.rodata section was
> > used. Which DTB was used was unpredictable, as it depended on the link
> > order (i.e., the order in Makefile).
> >
> > Commit 2672031b20f6 ("riscv: dts: Move BUILTIN_DTB_SOURCE to common
> > Kconfig") changed the Makefiles to ensure only one DTB is embedded.
> >
> > However, commit 7b937cc243e5 ("of: Create of_root if no dtb provided by
> > firmware") introduced another DTB into the .dtb.init.rodata section.
> >
> > Since then, the symbol dump (sorted by address) for ARCH=3Driscv
> > nommu_k210_defconfig is as follows:
> >
> >     00000000801290e0 D __dtb_k210_generic_begin
> >     00000000801290e0 D __dtb_start
> >     000000008012b571 D __dtb_k210_generic_end
> >     000000008012b580 D __dtb_empty_root_begin
> >     000000008012b5c8 D __dtb_empty_root_end
> >     000000008012b5e0 D __dtb_end
> >
> > The .dtb.init.rodata section now contains the following two DTB files:
> >
> >     arch/riscv/boot/dts/canaan/k210_generic.dtb
> >     drivers/of/empty_root.dtb
> >
> > This is not an immediate problem because the boot code picks up the
> > first DTB. The second one, empty_root.dtb is just ignored.
> >
> > However, as mentioned above, it is fragile to rely on the link order,
> > as future Makefile changes may break the behavior.
> >
> > The cmd_wrap_S_dtb rule in scripts/Makefile.lib is used for embedding a
> > DTB into the .dtb.init.rodata, so that the arch boot code can find it b=
y
> > the __dtb_start symbol.
> >
> > empty_root.dtb is looked up by its own symbol, so it does not need to
> > be located in the .dtb.init.rodata. It can be moved to the .init.rodata
> > section.
> >
> > When CONFIG_OF_UNITTEST is enabled, more unittest DTBOs are embedded in
> > the .dtb.init.rodata section. These are also looked up by name and for
> > generic purposes, so they can be moved to the .init.rodata section as
> > well.
> >
> > I added a wrapper source file, drivers/of/empty_root_dtb.S, because thi=
s
> > is the only wrapper used in driver/of/Makefile. I moved the rule for
> > generating *.dtbo.S to drivers/of/unittest-data/Makefile because it is
> > not used anywhere else.
>
> That is likely to change. We've had fixup overlays (fixup an old dt
> to a new binding) added into the kernel from time to time. There were 2,
> but they've been removed. However, I just recently suggested adding some
> new ones[1].


Heh, surprising.

Will something like commit 841281fe52a7 come back?




> It seems we need a named section when we access the dtb by variable
> name and an unnamed or boot dt section for the one boot dtb.


built-in boot dtb --> stay in .dtb.init.rodata
                      (arch boot code does not know the DTB name)

drivers and drivers/of/  --> can be moved to .init.rodata section
                             because look-up by name is possible.





So, do you want to keep the build rule in scripts/Makefile.lib,
but for a different section?



> Rob
>
> [1] https://lore.kernel.org/all/20240812212139.GA1797954-robh@kernel.org/
>


--=20
Best Regards
Masahiro Yamada

