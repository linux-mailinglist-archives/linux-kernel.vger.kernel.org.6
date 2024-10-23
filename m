Return-Path: <linux-kernel+bounces-378106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3699ACB6C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B782868BA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A289E1B4F24;
	Wed, 23 Oct 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pf3xZiQB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9241AAE02;
	Wed, 23 Oct 2024 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690821; cv=none; b=qH6+lykx1wB4jdHJj59yyuY4P0r67h5O7PSxnHXtazHCAyru0JxVKOcRx7W2piEaZMEi6PDRZc6W7pGmAVA0qGyUXtSYNGRUmDYZtDOAN91sCeMRsAMOA2bBGeaC3bWc02hONqUd9qSossJNX46rLNvt0nxMQJ4fXduN96wZazU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690821; c=relaxed/simple;
	bh=Lu9YSclbTdVAZko8HL1EN4aP4k9nSSYXLWoin86L7dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWOqNfTrQ0uziajVY1F07oozXSIj9f+1XTq5K/bClK3AMpxDo/++GEn4wWtKaZUyiSy94sJMkN7lKK3439dhBPhkB8b/eJOLCdTs9oxRQKFwdV/qxEegYgYjbEXt/EcMfNYPoJ0j1dYKSo3UGY16iWUopUVtvGdk9Mgcf7w5xA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pf3xZiQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E32AC4AF09;
	Wed, 23 Oct 2024 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729690819;
	bh=Lu9YSclbTdVAZko8HL1EN4aP4k9nSSYXLWoin86L7dk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pf3xZiQBCxAPHaN7y/LNoguShipMOR7i6eDCrlw5URNtM7BjG8DaUNBEFtiN+bvFu
	 ggqCHHcXRju5mymBaSBM9HKTeyijIGw7hOj/SCQ8/oOt+zyxoY9krENgYjWJ/m10MS
	 EPWuWXPx5wS+yo1jbo3ONNc1C/ldL6g/tyvYh0cRjWmZ7Z1lyoHKrMvIXBDfGXjuIC
	 5tuL1xnJVp7GcMoKf7FI7iwoXafhfycx079vaaYAbYVTzRa26JYI2bK+hqTymP7H95
	 l0hidiaSWkBqvxQZSdHdu9oNcGCPMjBk6Xo1PTS99Sty73uYUQ1jHi8ce2ZmPG1oEz
	 ncBbnyetDsy6g==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539d9fffea1so6457910e87.2;
        Wed, 23 Oct 2024 06:40:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUN9MeXe3fq49QFUCrQIAnQMt8lUcRHJMtu89kMWsYdpezwnobHcFDK6n4dqkyGyg5cPM6XZtso10qCiYRM@vger.kernel.org, AJvYcCWqQkMSjkIzjyzr50hnvw+trbTf4j4UqNyfgK6WXhwPXV7O6VsHxvXJtOZE+aWycnX3QzLzbhoAzSSJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7wTM87Ymz6VxHjWUZi6twc34HESAgcl7VKlScwLAwRcdQwWIY
	xp6ZQJOokehuol9E0MWjvpvbi46UYt46+hie2rKDyHRfxwdK86fyhWUxBmznhius1rBcLOJtLYu
	gnRVWYKewaA2wruqTQZOsc8lgzQ==
X-Google-Smtp-Source: AGHT+IFp1rlvBvAgovwWIHdkc8JKbjpOUlWvNyNMMr+FomXIFzVaHzZoAryx8MZFai0b1ZgDur6QOvdz+dUkJLEiYps=
X-Received: by 2002:a05:6512:1110:b0:539:da76:c77e with SMTP id
 2adb3069b0e04-53b1a31d8a9mr1461200e87.5.1729690817815; Wed, 23 Oct 2024
 06:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003113840.2972416-1-usamaarif642@gmail.com>
 <20241004000316.GA1910499-robh@kernel.org> <d3d90f10-1ccd-4557-843c-5b546d3b913c@gmail.com>
 <CAL_JsqJVEjPt9tHNr0uAGHQwGnUbZDZoe7kURp3Qx0ce1jv+vw@mail.gmail.com> <4b9456a3-47ea-4a00-92fe-131ccd80e550@gmail.com>
In-Reply-To: <4b9456a3-47ea-4a00-92fe-131ccd80e550@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 23 Oct 2024 08:40:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLLxyhjrc-Aqg12mjUZHGGgw59=AJxPpOfh5uSST8hY0Q@mail.gmail.com>
Message-ID: <CAL_JsqLLxyhjrc-Aqg12mjUZHGGgw59=AJxPpOfh5uSST8hY0Q@mail.gmail.com>
Subject: Re: [PATCH] of/kexec: save pa of initial_boot_params for arm64 and
 use it at kexec
To: Usama Arif <usamaarif642@gmail.com>
Cc: mark.rutland@arm.com, will@kernel.org, leitao@debian.org, 
	catalin.marinas@arm.com, saravanak@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 10:30=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 07/10/2024 15:39, Rob Herring wrote:
> > On Mon, Oct 7, 2024 at 9:06=E2=80=AFAM Usama Arif <usamaarif642@gmail.c=
om> wrote:
> >>
> >>
> >>
> >> On 04/10/2024 01:03, Rob Herring wrote:
> >>> On Thu, Oct 03, 2024 at 12:38:40PM +0100, Usama Arif wrote:
> >>>>  __pa() is only intended to be used for linear map addresses and usi=
ng
> >>>> it for initial_boot_params which is in fixmap for arm64 will give an
> >>>> incorrect value. Hence stash the physical address when it is known a=
t
> >>>> boot time and use it at kexec time instead of converting the virtual
> >>>> address using __pa().
> >>>>
> >>>> Reported-by: Breno Leitao <leitao@debian.org>
> >>>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> >>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >>>> Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt=
()")
> >>>> ---
> >>>>  arch/arm64/kernel/setup.c | 8 ++++++++
> >>>>  drivers/of/fdt.c          | 6 ++++++
> >>>>  drivers/of/kexec.c        | 8 ++++++--
> >>>>  include/linux/of_fdt.h    | 2 ++
> >>>>  4 files changed, 22 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> >>>> index b22d28ec8028..a4d96f5e2e05 100644
> >>>> --- a/arch/arm64/kernel/setup.c
> >>>> +++ b/arch/arm64/kernel/setup.c
> >>>> @@ -194,6 +194,14 @@ static void __init setup_machine_fdt(phys_addr_=
t dt_phys)
> >>>>      /* Early fixups are done, map the FDT as read-only now */
> >>>>      fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
> >>>>
> >>>> +    /*
> >>>> +     * Save dt_phys address so that it can be used later for kexec.=
 This
> >>>> +     * is done as __pa() is only intended to be used for linear map=
 addresses
> >>>> +     * and using it for initial_boot_params which is in fixmap will=
 give an
> >>>> +     * incorrect value.
> >>>> +     */
> >>>> +    set_initial_boot_params_pa(dt_phys);
> >>>
> >>> No new arch->dt functions please. If we need to save off the PA, then=
 do
> >>> that when we set initial_boot_params.
> >>>
> >>> Rob
> >>
> >>
> >> initial_boot_params is set in early_init_dt_verify, called by early_in=
it_dt_scan.
> >> This is done in setup_machine_fdt in arm64 where the PA is available,
> >> but in other functions in other architectures, where the PA is not ava=
ilable.
> >
> > Doesn't __pa() work for all the other architectures? That's what your
> > patch indicates.
> >
>
> Yes, __pa() works for all other architectures.
>
> But we would need to add initial_boot_params_pa of type phys_addr_t
> as an argument for early_init_dt_scan, which is called by all other archs=
,
> and we technically cant use 0 as an invalid value.
>
> We could convert initial_boot_params_pa to void *, and pass NULL for all
> other archs. But again, I don't really think we should be changing the
> early_init_dt_scan(dt_virt) call in all other archs to
> early_init_dt_scan(dt_virt, NULL) just to save initial_boot_params_pa
> in arm64?
>
> >> So it makes it quite messy to set it in the same place as initial_boot=
_params.
> >> Its only needed for arm64 and making a change in all archs probably is=
nt a good idea?
> >>
> >> Any reason to not add a new function to make arch -> of/fdt call?
> >
> > Yes. It is the opposite direction I have reworked the interfaces to.
> > We don't want each arch calling various early DT functions at random
> > times and order. That's fragile when the DT functions make assumptions
> > about when they are called or what's been initialized already.
> >
> > Another option is to make arm64 copy the DT as some arches do.
> >
> > Rob
>
> Ah maybe I didn't understand this properly, but isnt early_init_dt_scan a=
n
> arch -> of/fdt interfaces. set_initial_boot_params_pa is a similar interf=
ace
> to early_init_dt_scan?

Yes, and I don't want more APIs if they can be avoided. When is
set_initial_boot_params_pa() supposed to be called? Is it before or
after early_init_dt_scan()? Can subsequent OF functions assume the PA
is valid? If an arch doesn't call set_initial_boot_params_pa() is
__pa() valid or did they just forget to call it? Requiring the PA to
be set at the same time as initial_boot_params avoids all those issues
with any period of time having the PA incorrect.

Rob

