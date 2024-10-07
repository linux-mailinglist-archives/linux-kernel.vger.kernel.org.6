Return-Path: <linux-kernel+bounces-353572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8940B992F9C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5229A282D2B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392571D5CDB;
	Mon,  7 Oct 2024 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfa4o+1o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8953F1D4353;
	Mon,  7 Oct 2024 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311998; cv=none; b=psUf4ktdgO3ZREvq+T3u2cNqSFwnpCXGEm04tKnOoN4oCxOLtwuXyd3zersD4JS+YrfK9H50anZDrpTYrSXqlD5X76Ca1OGGX5S4zsDDSPKVlbmmQ0IKpTpmv9Dko2/r7vGJmwgeonMN8qt9gWc0vrfoISfWawC3ulpCy19q09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311998; c=relaxed/simple;
	bh=xIKmFdsKl3VoJoRVa+lTTRtmFAYUymUeG0NPSdB4qkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZThvnvuXiL8gSFenWwmZAxMv1O0NxgkEPz/7U7ZsRIX+zC899XyYnQVN08LCfbz8HRDQgesc78JL/YqfYOgLlcvSeQbj4KDOUjELhjt1DyxXhB0CMlmmowbjS/iZjtk+BcJaN9VWm28gIR2QYxMrDcsXZGvzR9eNLYRzvUGDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfa4o+1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137A8C4AF09;
	Mon,  7 Oct 2024 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728311997;
	bh=xIKmFdsKl3VoJoRVa+lTTRtmFAYUymUeG0NPSdB4qkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sfa4o+1olqcPgJpIaH+SDfJrdsUpJdOjPkMbApZLOfM4xIJ08b/N4llmtg1XjlbUu
	 JQe6E0lhXk1HoH8ekYKUyTePuwYCexJxCDXkGP/StWz/VrYUs1qseXDOiL2z7v9GpG
	 iJD9d/e9AgP2dG9KaDC2VQ22oYOeYuGwSyhvw1dq+VZShyEAAjjGCaAWwyfZnnqfEe
	 Dg7Jf9QGs8lH9mfxVpSXLTotHNRX+qAh12ZrS8egHx4FUywBS4Q8QKhDeLtPPlVD1f
	 Jplv06X8RYwFa6ZsujT0tjQ29PTU/s0dfHmQsiPcFZd6jVj1zzNyF6c4Ie+//U28lS
	 l5dK+y1YBFPaA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53995380bb3so5383064e87.1;
        Mon, 07 Oct 2024 07:39:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUc4iaEnB9dXosnTZ0sGV2IZ38MeS6Ju4oNuN5rs/VVk4x3j/BHlMcFsdrsrSNy78SPAUtpRlTQs7wZ@vger.kernel.org, AJvYcCVGGzN32VpHGukK32q1kEf//51YzqrRfDzpkIriUKQNnF8tQtrk3ggKqA0VfBe2FJVtN8bmNrszsM1rW2Ak@vger.kernel.org
X-Gm-Message-State: AOJu0YxQxfxS4PlUasOXCfvZARDUCZMCiT5hf53iWNxbmMLI48XBFjlj
	GUxo6xHH0GPWgbSQHqtGEYzjxv27SZKwzSBlH6zFxVZmFMpvqIX/6DC6D/sVIBEGJV2H2RZFBTn
	OQxzJp8lUMzSYQAYqRmKHa4/MKQ==
X-Google-Smtp-Source: AGHT+IEG5q6+j+CeqLxaVJZa0oofLHHRdz/JFR71IlJpiAgKIbDzqEkmM0wZIXncpHj7oLyHzkEwSpYcacaGxALVOpk=
X-Received: by 2002:a05:6512:31ce:b0:52f:df:db40 with SMTP id
 2adb3069b0e04-539ab9ed4f8mr6140759e87.56.1728311995390; Mon, 07 Oct 2024
 07:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003113840.2972416-1-usamaarif642@gmail.com>
 <20241004000316.GA1910499-robh@kernel.org> <d3d90f10-1ccd-4557-843c-5b546d3b913c@gmail.com>
In-Reply-To: <d3d90f10-1ccd-4557-843c-5b546d3b913c@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 7 Oct 2024 09:39:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJVEjPt9tHNr0uAGHQwGnUbZDZoe7kURp3Qx0ce1jv+vw@mail.gmail.com>
Message-ID: <CAL_JsqJVEjPt9tHNr0uAGHQwGnUbZDZoe7kURp3Qx0ce1jv+vw@mail.gmail.com>
Subject: Re: [PATCH] of/kexec: save pa of initial_boot_params for arm64 and
 use it at kexec
To: Usama Arif <usamaarif642@gmail.com>
Cc: mark.rutland@arm.com, will@kernel.org, leitao@debian.org, 
	catalin.marinas@arm.com, saravanak@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 9:06=E2=80=AFAM Usama Arif <usamaarif642@gmail.com> =
wrote:
>
>
>
> On 04/10/2024 01:03, Rob Herring wrote:
> > On Thu, Oct 03, 2024 at 12:38:40PM +0100, Usama Arif wrote:
> >>  __pa() is only intended to be used for linear map addresses and using
> >> it for initial_boot_params which is in fixmap for arm64 will give an
> >> incorrect value. Hence stash the physical address when it is known at
> >> boot time and use it at kexec time instead of converting the virtual
> >> address using __pa().
> >>
> >> Reported-by: Breno Leitao <leitao@debian.org>
> >> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >> Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()=
")
> >> ---
> >>  arch/arm64/kernel/setup.c | 8 ++++++++
> >>  drivers/of/fdt.c          | 6 ++++++
> >>  drivers/of/kexec.c        | 8 ++++++--
> >>  include/linux/of_fdt.h    | 2 ++
> >>  4 files changed, 22 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> >> index b22d28ec8028..a4d96f5e2e05 100644
> >> --- a/arch/arm64/kernel/setup.c
> >> +++ b/arch/arm64/kernel/setup.c
> >> @@ -194,6 +194,14 @@ static void __init setup_machine_fdt(phys_addr_t =
dt_phys)
> >>      /* Early fixups are done, map the FDT as read-only now */
> >>      fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
> >>
> >> +    /*
> >> +     * Save dt_phys address so that it can be used later for kexec. T=
his
> >> +     * is done as __pa() is only intended to be used for linear map a=
ddresses
> >> +     * and using it for initial_boot_params which is in fixmap will g=
ive an
> >> +     * incorrect value.
> >> +     */
> >> +    set_initial_boot_params_pa(dt_phys);
> >
> > No new arch->dt functions please. If we need to save off the PA, then d=
o
> > that when we set initial_boot_params.
> >
> > Rob
>
>
> initial_boot_params is set in early_init_dt_verify, called by early_init_=
dt_scan.
> This is done in setup_machine_fdt in arm64 where the PA is available,
> but in other functions in other architectures, where the PA is not availa=
ble.

Doesn't __pa() work for all the other architectures? That's what your
patch indicates.

> So it makes it quite messy to set it in the same place as initial_boot_pa=
rams.
> Its only needed for arm64 and making a change in all archs probably isnt =
a good idea?
>
> Any reason to not add a new function to make arch -> of/fdt call?

Yes. It is the opposite direction I have reworked the interfaces to.
We don't want each arch calling various early DT functions at random
times and order. That's fragile when the DT functions make assumptions
about when they are called or what's been initialized already.

Another option is to make arm64 copy the DT as some arches do.

Rob

