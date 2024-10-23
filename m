Return-Path: <linux-kernel+bounces-378323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4596A9ACE72
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA3B1C20A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8635B1C1ADB;
	Wed, 23 Oct 2024 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LolIzHaG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FEB19DF53;
	Wed, 23 Oct 2024 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696652; cv=none; b=Dt1zhr5GdlfrY+dL200W6D+QbO5eAJoDmhzsotZzCtYD3PsSgnJMbV174eZUZtihRceFpwzWOb530tQQX6gciijZwtcSwBqvCZd/1d3kLyzKVuxkHc+fHMnOxEZ38XMJV6xZ+e1uX+Z5cTcPCsu53YkpN2Hh1ZTlsPti0qqRmqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696652; c=relaxed/simple;
	bh=Y9lg95AOBx3IZcZyZeGwM2XaFHswE2uhvCfA6MfY39E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFz8lszRPZ6s0kEswBHtDby7/MeNbAsRNhvbp+FoC7VWu+uthEE17hosg0XKU8vSXOugErBHA8xR/ifKAXpg7sg/Z6N275m3rC+u5yQnUQgIywjPLYJRBQxShehv5mB8hjIDfLzKuq/crbuU7GNb8f8vNcz0GsMYyxLrSh73amE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LolIzHaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1F9C4CECD;
	Wed, 23 Oct 2024 15:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729696652;
	bh=Y9lg95AOBx3IZcZyZeGwM2XaFHswE2uhvCfA6MfY39E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LolIzHaGBLQpJYEPCSMlz4zOflsLfvm459UKKZnqVLNnyDBSFjMiM5+4nDE7b09TY
	 W59UX8xhkcZDTNQjWnZ5g+qI+YpcFQID8DX6WScXw0xrkJnicvZOrqTAcyB+lP9mIB
	 1OyQUTcT3Pdh46IgiETAZSs01umGdWC07ZsiBv3zfRuqcW2lxDH46g5sIcCoEBwdRe
	 Rkrm+ABEdixbBQ+3FSFyy+FGkLb6xPZl0wl2lce9J+B30uHVQR6slXPzO3fzG3Ph9p
	 WJEpm284T6BJt+w1y5P4XXxGxxm5bhuWQwHxyd7I9kpVE/J7n5hWaqvr9ZTx9veeC/
	 WjzSLT1lKSMPw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so9432468e87.1;
        Wed, 23 Oct 2024 08:17:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgx13I0MOrwsi/vU1ABK7VaexfStsU3VA3McHSG3HbK1JU2kSghs2b0/1DR8Zax2gzmJU7iUERLfG922XB@vger.kernel.org, AJvYcCXMz60HGvsm7jG47UZcRcJUMgTc5QuX7BUebCgkU8ee+UyqsWBGIF0h9HisDUxGOJmKXRrKHDjpkWTV@vger.kernel.org
X-Gm-Message-State: AOJu0YxWHEG+IH2Oo07ZPs7Od28ry2g7zsl8EvfOyO2Afs6HawsE9Qah
	c8qGHuZW4t3I4OMMOp2EjT8cjkKIvO4QXQ83Jd3e+dSYYhLqRL4/DmJDCU7ivhFhxeQDKLW/P+y
	1S3tHZ0OG+KzXxMMSkPILHg3mtQ==
X-Google-Smtp-Source: AGHT+IFO2flos8BmUbUaV2MIys/apvRsxd9oWb6MtoGL3InNud08UQCYJA2+z/ZVPUpl+CBNdQz4CESiW+WTCz4l5os=
X-Received: by 2002:a05:6512:2c05:b0:53b:1f90:576f with SMTP id
 2adb3069b0e04-53b1f905959mr889920e87.22.1729696650524; Wed, 23 Oct 2024
 08:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003113840.2972416-1-usamaarif642@gmail.com>
 <20241004000316.GA1910499-robh@kernel.org> <d3d90f10-1ccd-4557-843c-5b546d3b913c@gmail.com>
 <CAL_JsqJVEjPt9tHNr0uAGHQwGnUbZDZoe7kURp3Qx0ce1jv+vw@mail.gmail.com>
 <4b9456a3-47ea-4a00-92fe-131ccd80e550@gmail.com> <CAL_JsqLLxyhjrc-Aqg12mjUZHGGgw59=AJxPpOfh5uSST8hY0Q@mail.gmail.com>
 <1e117d65-b454-4d5c-b03a-c3ab3b078093@gmail.com>
In-Reply-To: <1e117d65-b454-4d5c-b03a-c3ab3b078093@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 23 Oct 2024 10:17:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJhd0X+eCW6WgXUjCLb-dBqHN4_01vzRRLU07Wz5Q2tLw@mail.gmail.com>
Message-ID: <CAL_JsqJhd0X+eCW6WgXUjCLb-dBqHN4_01vzRRLU07Wz5Q2tLw@mail.gmail.com>
Subject: Re: [PATCH] of/kexec: save pa of initial_boot_params for arm64 and
 use it at kexec
To: Usama Arif <usamaarif642@gmail.com>
Cc: mark.rutland@arm.com, will@kernel.org, leitao@debian.org, 
	catalin.marinas@arm.com, saravanak@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 9:43=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 23/10/2024 14:40, Rob Herring wrote:
> > On Mon, Oct 7, 2024 at 10:30=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >>
> >>
> >>
> >> On 07/10/2024 15:39, Rob Herring wrote:
> >>> On Mon, Oct 7, 2024 at 9:06=E2=80=AFAM Usama Arif <usamaarif642@gmail=
.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 04/10/2024 01:03, Rob Herring wrote:
> >>>>> On Thu, Oct 03, 2024 at 12:38:40PM +0100, Usama Arif wrote:
> >>>>>>  __pa() is only intended to be used for linear map addresses and u=
sing
> >>>>>> it for initial_boot_params which is in fixmap for arm64 will give =
an
> >>>>>> incorrect value. Hence stash the physical address when it is known=
 at
> >>>>>> boot time and use it at kexec time instead of converting the virtu=
al
> >>>>>> address using __pa().
> >>>>>>
> >>>>>> Reported-by: Breno Leitao <leitao@debian.org>
> >>>>>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> >>>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >>>>>> Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_f=
dt()")
> >>>>>> ---
> >>>>>>  arch/arm64/kernel/setup.c | 8 ++++++++
> >>>>>>  drivers/of/fdt.c          | 6 ++++++
> >>>>>>  drivers/of/kexec.c        | 8 ++++++--
> >>>>>>  include/linux/of_fdt.h    | 2 ++
> >>>>>>  4 files changed, 22 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> >>>>>> index b22d28ec8028..a4d96f5e2e05 100644
> >>>>>> --- a/arch/arm64/kernel/setup.c
> >>>>>> +++ b/arch/arm64/kernel/setup.c
> >>>>>> @@ -194,6 +194,14 @@ static void __init setup_machine_fdt(phys_add=
r_t dt_phys)
> >>>>>>      /* Early fixups are done, map the FDT as read-only now */
> >>>>>>      fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
> >>>>>>
> >>>>>> +    /*
> >>>>>> +     * Save dt_phys address so that it can be used later for kexe=
c. This
> >>>>>> +     * is done as __pa() is only intended to be used for linear m=
ap addresses
> >>>>>> +     * and using it for initial_boot_params which is in fixmap wi=
ll give an
> >>>>>> +     * incorrect value.
> >>>>>> +     */
> >>>>>> +    set_initial_boot_params_pa(dt_phys);
> >>>>>
> >>>>> No new arch->dt functions please. If we need to save off the PA, th=
en do
> >>>>> that when we set initial_boot_params.
> >>>>>
> >>>>> Rob
> >>>>
> >>>>
> >>>> initial_boot_params is set in early_init_dt_verify, called by early_=
init_dt_scan.
> >>>> This is done in setup_machine_fdt in arm64 where the PA is available=
,
> >>>> but in other functions in other architectures, where the PA is not a=
vailable.
> >>>
> >>> Doesn't __pa() work for all the other architectures? That's what your
> >>> patch indicates.
> >>>
> >>
> >> Yes, __pa() works for all other architectures.
> >>
> >> But we would need to add initial_boot_params_pa of type phys_addr_t
> >> as an argument for early_init_dt_scan, which is called by all other ar=
chs,
> >> and we technically cant use 0 as an invalid value.
> >>
> >> We could convert initial_boot_params_pa to void *, and pass NULL for a=
ll
> >> other archs. But again, I don't really think we should be changing the
> >> early_init_dt_scan(dt_virt) call in all other archs to
> >> early_init_dt_scan(dt_virt, NULL) just to save initial_boot_params_pa
> >> in arm64?
> >>
> >>>> So it makes it quite messy to set it in the same place as initial_bo=
ot_params.
> >>>> Its only needed for arm64 and making a change in all archs probably =
isnt a good idea?
> >>>>
> >>>> Any reason to not add a new function to make arch -> of/fdt call?
> >>>
> >>> Yes. It is the opposite direction I have reworked the interfaces to.
> >>> We don't want each arch calling various early DT functions at random
> >>> times and order. That's fragile when the DT functions make assumption=
s
> >>> about when they are called or what's been initialized already.
> >>>
> >>> Another option is to make arm64 copy the DT as some arches do.
> >>>
> >>> Rob
> >>
> >> Ah maybe I didn't understand this properly, but isnt early_init_dt_sca=
n an
> >> arch -> of/fdt interfaces. set_initial_boot_params_pa is a similar int=
erface
> >> to early_init_dt_scan?
> >
> > Yes, and I don't want more APIs if they can be avoided. When is
> > set_initial_boot_params_pa() supposed to be called? Is it before or
> > after early_init_dt_scan()?
>
> Its only needed in arm64, and can be either before or after, as long as i=
ts
> somewhere in setup_machine_fdt, where dt_phys is available.

Maybe only arm64 today. What happens when riscv decides they too want
to support the DT anywhere in memory including outside the linear
address map and then they need the same thing.

> > Can subsequent OF functions assume the PA
> > is valid?
>
> After set_initial_boot_params_pa has been called, yes.

How do I know it has been called? Do I have to go wade thru every arch
to see? You could document the requirement to be immediately after
early_init_dt_scan(), but then how do you enforce that? You can't
unless you design the interface to just avoid the problem in the first
place.

> > If an arch doesn't call set_initial_boot_params_pa() is
> > __pa() valid or did they just forget to call it?
>
> Only arm64 seems to do the fixmap as discussed in
> https://lore.kernel.org/all/1ea5538f-7e96-4034-9af9-e2d5fd72e069@gmail.co=
m/,
> so __pa should work in others.
>
> Requiring the PA to
> > be set at the same time as initial_boot_params avoids all those issues
> > with any period of time having the PA incorrect.
> >
>
> Are you recommending I send a patch which changes all archs to call
> early_init_dt_scan(dt_virt, NULL)?
> or maybe early_init_dt_scan(dt_virt, __pa(dt_virt))?
> and arm to call early_init_dt_scan(dt_virt, dt_phys).

I believe that's what I suggested already, so yes. Whether NULL or
__pa(dt_virt))? __pa() would be better because then the arch has to
think about whether that is right or not.

> Happy to do send a v2 with that if its the way forward, although I feel
> set_initial_boot_params_pa() in just one arch might be better than
> changing this for all archs.

We don't work around kernel APIs if they don't meet changing needs. We
change them.

Rob

