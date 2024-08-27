Return-Path: <linux-kernel+bounces-304031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FEF9618E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 22:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30A91F250BF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6EF1D362C;
	Tue, 27 Aug 2024 20:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iw6KriBK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4849156C5E;
	Tue, 27 Aug 2024 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724792263; cv=none; b=obydQ6xewHaVUWS9GviUl6jgOoG+cYFfr5PAD2arV4M0QS+xkGAWYoyJoKv9+8HCH3kLA2tOWPM4f1diINJ9sRXeH1hkjoi+Ik61QKPtSTb+iv/GkS9ZfbEXbjf9tm6x3DIfPr0y+IbrPo1SgdC9YfSvfPS4sNXqZbBtfG2Vzbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724792263; c=relaxed/simple;
	bh=yNq+UV5QXdzpPG/cCfNH7K6qA+YGYMwalmuc/EvXlaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fm9RWc+FkCK20BfAI3nYXhPm9/sJ37GdDqdRO2/v7NKV0TGNv6LyR2K2ljJKdLf79GT3AgcmIVf4X43ONin5zexDq/F86cULuqz7Ebx/XRUk2g3fozqVFHFejNzwHd37V8IJzNfZzWdyyMjZUX1dxh+GgqHq9sqbJluPieXJ5As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iw6KriBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CB1C32786;
	Tue, 27 Aug 2024 20:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724792263;
	bh=yNq+UV5QXdzpPG/cCfNH7K6qA+YGYMwalmuc/EvXlaI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Iw6KriBK2UVm/GDFK1L0lUCUwxNQcXM0/uWyqJ+9SY4fJVcw61H2kFlwLYPPCQ9tl
	 mXzpn7c7APzWCzsdU47ArpmpmtdBb75g/L+v66mPPBy+TMQHlf72hEhfnLwrej83JC
	 jP8krL+/oFaMBovp47t/Z7rEOWJD1w2TL+ewk78A0kDBET1gGw7ts8o9wvdUk3VOvw
	 5YDzpq+46LtpX1OxNWqgoiCQlSrialSHKqo/8llgm3Ja+68eO7gl0qui9sywLFrr5Z
	 ZHOLjZhMDEBwxDapAbDuQE7QTRvJTV6YvD/NRTAJIsZkq4h5kuKOS8qFNjPUEu6bDb
	 4cXW9zxoqdcxA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5343eeb4973so6144056e87.2;
        Tue, 27 Aug 2024 13:57:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKOrRSgOqQFB4VYUd7bKX/rU/WFkHXQHzvBTVA9s+muutK8Sk6UkaFEnwXXXWoSFlBD3llfFMEdGYRJ8pf@vger.kernel.org, AJvYcCWV3KoP8hagk34HY+TWsKm9HWN/HgAzaWugXNxhVxUh8E/HZeXPXCSmZbdAes3VwTaq7udgD4A/Kd7o@vger.kernel.org
X-Gm-Message-State: AOJu0YxiI9UIqGH9jlFz8Ur2ETwN+P/7Dcw5Cn8ijYSKD8VR3xv+PxB8
	zH+QhIRRZJOJ0R0WRYuWolZX03t7GMcEuqnRH4LLhGqcZnpuaqTPyRqmXzhlBs7Uve9zVm1K3vE
	9HaxgIrZdPmyQZDwij7HaQEgg0g==
X-Google-Smtp-Source: AGHT+IGAtcL/w3n9cuEBlninSQcAue9QLhZV/y4afpmNCuFpGUB9BZV/wPoyUiE7ooIU6Y4Wv+NggU8fdP9Pppnmu2A=
X-Received: by 2002:a05:6512:3e19:b0:532:fb9e:a175 with SMTP id
 2adb3069b0e04-5343883d5e7mr15565231e87.6.1724792261652; Tue, 27 Aug 2024
 13:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826124802.1552738-1-masahiroy@kernel.org>
 <20240827155158.GA3940418-robh@kernel.org> <CAK7LNARAr9r6pzFzONQnNfFsbFFf_NpE39HBdmVHMBEGe1-nfQ@mail.gmail.com>
In-Reply-To: <CAK7LNARAr9r6pzFzONQnNfFsbFFf_NpE39HBdmVHMBEGe1-nfQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 27 Aug 2024 15:57:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKRkMBMP6Bjm-_R7aRb5or_hTefi0CovFjBk0Z-OMLVkQ@mail.gmail.com>
Message-ID: <CAL_JsqKRkMBMP6Bjm-_R7aRb5or_hTefi0CovFjBk0Z-OMLVkQ@mail.gmail.com>
Subject: Re: [PATCH] of: move empty_root and unittest data DTBs to
 .init.rodata section
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 12:32=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> On Wed, Aug 28, 2024 at 12:52=E2=80=AFAM Rob Herring <robh@kernel.org> wr=
ote:
> >
> > On Mon, Aug 26, 2024 at 09:48:01PM +0900, Masahiro Yamada wrote:
> > > Some architectures can embed DTB(s) in vmlinux. Most of them expect a
> > > single DTB in the .dtb.init.rodata section.
> > >
> > > For example, RISC-V previously allowed embedding multiple DTBs in
> > > vmlinux, but only the first DTB in the .dtb.init.rodata section was
> > > used. Which DTB was used was unpredictable, as it depended on the lin=
k
> > > order (i.e., the order in Makefile).
> > >
> > > Commit 2672031b20f6 ("riscv: dts: Move BUILTIN_DTB_SOURCE to common
> > > Kconfig") changed the Makefiles to ensure only one DTB is embedded.
> > >
> > > However, commit 7b937cc243e5 ("of: Create of_root if no dtb provided =
by
> > > firmware") introduced another DTB into the .dtb.init.rodata section.
> > >
> > > Since then, the symbol dump (sorted by address) for ARCH=3Driscv
> > > nommu_k210_defconfig is as follows:
> > >
> > >     00000000801290e0 D __dtb_k210_generic_begin
> > >     00000000801290e0 D __dtb_start
> > >     000000008012b571 D __dtb_k210_generic_end
> > >     000000008012b580 D __dtb_empty_root_begin
> > >     000000008012b5c8 D __dtb_empty_root_end
> > >     000000008012b5e0 D __dtb_end
> > >
> > > The .dtb.init.rodata section now contains the following two DTB files=
:
> > >
> > >     arch/riscv/boot/dts/canaan/k210_generic.dtb
> > >     drivers/of/empty_root.dtb
> > >
> > > This is not an immediate problem because the boot code picks up the
> > > first DTB. The second one, empty_root.dtb is just ignored.
> > >
> > > However, as mentioned above, it is fragile to rely on the link order,
> > > as future Makefile changes may break the behavior.
> > >
> > > The cmd_wrap_S_dtb rule in scripts/Makefile.lib is used for embedding=
 a
> > > DTB into the .dtb.init.rodata, so that the arch boot code can find it=
 by
> > > the __dtb_start symbol.
> > >
> > > empty_root.dtb is looked up by its own symbol, so it does not need to
> > > be located in the .dtb.init.rodata. It can be moved to the .init.roda=
ta
> > > section.
> > >
> > > When CONFIG_OF_UNITTEST is enabled, more unittest DTBOs are embedded =
in
> > > the .dtb.init.rodata section. These are also looked up by name and fo=
r
> > > generic purposes, so they can be moved to the .init.rodata section as
> > > well.
> > >
> > > I added a wrapper source file, drivers/of/empty_root_dtb.S, because t=
his
> > > is the only wrapper used in driver/of/Makefile. I moved the rule for
> > > generating *.dtbo.S to drivers/of/unittest-data/Makefile because it i=
s
> > > not used anywhere else.
> >
> > That is likely to change. We've had fixup overlays (fixup an old dt
> > to a new binding) added into the kernel from time to time. There were 2=
,
> > but they've been removed. However, I just recently suggested adding som=
e
> > new ones[1].
>
>
> Heh, surprising.
>
> Will something like commit 841281fe52a7 come back?

Yeah, I expect the QCom DWC3 stuff is going to have N overlays for N SoCs.

> > It seems we need a named section when we access the dtb by variable
> > name and an unnamed or boot dt section for the one boot dtb.
>
>
> built-in boot dtb --> stay in .dtb.init.rodata
>                       (arch boot code does not know the DTB name)
>
> drivers and drivers/of/  --> can be moved to .init.rodata section
>                              because look-up by name is possible.

Right.

> So, do you want to keep the build rule in scripts/Makefile.lib,
> but for a different section?

Yes.

Rob

