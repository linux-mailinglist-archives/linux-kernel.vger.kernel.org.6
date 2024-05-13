Return-Path: <linux-kernel+bounces-177796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838378C44BB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54F21C214CB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2F9155342;
	Mon, 13 May 2024 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZgLAnJcj"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AF8155335
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616092; cv=none; b=LHBCKYe96adjkJHW2/ieaf1giP0d4Mk1DH7vQPMdQ2KiOkqXZthmb+7YzXC7P5kiKJgw5yI5jZF/78ooLAqN6QpGGs1yKUq0Z4azrC833zCcNWCIDMpFmmk7gZUCq9ZMoHhXj0tw4C5Cvi5kHFQ+ITbqrNP3K492rff6PhN/bYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616092; c=relaxed/simple;
	bh=7aIb0LLcOZQItl53cYSnWrlITnVVqi2Ng/kqLoiQdHA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KMinx5NPSGl4IHCPiL12L5iBViop3MjPozm/wAkApyJU0TsrXmcM1WA+DzjaRN69UK02ZqKXMuttzF2BvUpznPo4g4cRIoa2JCRVOCX3sTXvPK+i49FUi5YXUYvYIrLgsBo5ruOAKlMsjtXaTArM47cCglwvviFQwWT0IzwrpNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZgLAnJcj; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de8b6847956so7855320276.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715616090; x=1716220890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7pWGVe0IoguyDwyyQdCj4C526jTQ2Gx3U1Hay8S43k=;
        b=ZgLAnJcjo/nXBo7g9KqHTqtHh6o5UMs9eG45Uy4v9/qb5d3ir9Ep9dgIS9QVsm3EQh
         Jv6w4PnHfQ5hPKPDs75PmnpHyr0yvCm8CsvCsmVsIqW0MwLKAFeiamxgMdXpA5hfIUo8
         bx01D2NMjbSzHgMiVbT4sggBIuegb0gH2K3nLajP3YW+7R8PkEY0UVK860baaJB0CkcZ
         Z39OUrltvdtKMa2kxlCpWX61FvMXyGqCFJQRsJIy+sM7ZSX0FSce7ya8hETpkq16qjPY
         aqlWF3QvNY93lEarQK3hOD/u0LtN8JnzVdW+BPgmbef5b4nkEmSQIyHBtw8FIvaehV1X
         me1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715616090; x=1716220890;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P7pWGVe0IoguyDwyyQdCj4C526jTQ2Gx3U1Hay8S43k=;
        b=ejQimEr1J5sgF1hcootl+ULsbVONE8ssUPsHjy+VC0uNCngrTotuqPypDeRLnp34Zx
         /LDTZdbTfa7Fmj7+FvQ7wwwobkEiWu9d1AXCOUupqP3wU8K7zGFJXgZMffEHqVXI4n7B
         Bim9uwa9hOVpX8flr6iEBgytNUn0wS9uNxk/4s/2czVjD10ui4A+Z8HjtmL51ruFLdH6
         3j66VIfnWSXlT7xkcYoV92kKtXPMa0roEFShPTT2qZpOb12Z650epy2cMYpBnmmZnP2m
         EBg60VaKAkE0Dtk4lXr3rY2gSgGfEuHxsIQx4/MV2BqyypEjXuSKoleyS2OAe3+tIE8N
         gaSA==
X-Forwarded-Encrypted: i=1; AJvYcCVDv9/X/1P8WKeB/OrAxGDJs9mpNnfvR6FsAkb8kNotOv1h13h6U1DBtZR84XLleOOuKFLx08Dnf+4SJOzKxwMUuhxU77dVyif1JhLB
X-Gm-Message-State: AOJu0YwhSFEa28ZjIGHjt2Ds37MJI7Fqe744y4HlNk/rjsdgiKWXox5e
	wBE/h7iGSmoOpIk0NCvAQB1BRH/wW7cxHeW+cJtELF6oQeHdOxOUEbhahVz6BNXtq7ti/Uro08j
	WTw==
X-Google-Smtp-Source: AGHT+IGwuX7zcJx0ogFKg+j/v3Ui4cvmwInv4HbrTsBJ2xd7BgAlVylu3n985aaxuLDYr0jvpd4Zzg3ADZo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:68c3:0:b0:de5:dcb8:5c8a with SMTP id
 3f1490d57ef6-debcfbce27fmr2904889276.2.1715616090015; Mon, 13 May 2024
 09:01:30 -0700 (PDT)
Date: Mon, 13 May 2024 09:01:28 -0700
In-Reply-To: <5dfc9eb860a587d1864371874bbf267fa0aa7922.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425233951.3344485-1-seanjc@google.com> <20240425233951.3344485-2-seanjc@google.com>
 <5dfc9eb860a587d1864371874bbf267fa0aa7922.camel@intel.com>
Message-ID: <ZkI5WApAR6iqCgil@google.com>
Subject: Re: [PATCH 1/4] x86/reboot: Unconditionally define
 cpu_emergency_virt_cb typedef
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024, Kai Huang wrote:
> On Thu, 2024-04-25 at 16:39 -0700, Sean Christopherson wrote:
> > Define cpu_emergency_virt_cb even if the kernel is being built without =
KVM
> > support so that KVM can reference the typedef in asm/kvm_host.h without
> > needing yet more #ifdefs.
> >=20
> > No functional change intended.
> >=20
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/include/asm/reboot.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboo=
t.h
> > index 6536873f8fc0..d0ef2a678d66 100644
> > --- a/arch/x86/include/asm/reboot.h
> > +++ b/arch/x86/include/asm/reboot.h
> > @@ -25,8 +25,8 @@ void __noreturn machine_real_restart(unsigned int typ=
e);
> >  #define MRR_BIOS	0
> >  #define MRR_APM		1
> > =20
> > -#if IS_ENABLED(CONFIG_KVM_INTEL) || IS_ENABLED(CONFIG_KVM_AMD)
> >  typedef void (cpu_emergency_virt_cb)(void);
> > +#if IS_ENABLED(CONFIG_KVM_INTEL) || IS_ENABLED(CONFIG_KVM_AMD)
> >  void cpu_emergency_register_virt_callback(cpu_emergency_virt_cb *callb=
ack);
> >  void cpu_emergency_unregister_virt_callback(cpu_emergency_virt_cb *cal=
lback);
> >  void cpu_emergency_disable_virtualization(void);
>=20
> It looks a little it weird.  If other file wants to include
> <asm/kvm_host.h> (directly or via <linux/kvm_host.h>) unconditionally the=
n
> in general I think <asm/kvm_host.h> or <linux/kvm_host.h> should
> have=C2=A0something like:
>=20
> 	#ifdef CONFIG_KVM
>=20
> 	void func(void);
> 	...
>=20
> 	#else
>=20
> 	static inline void func(void) {}
>=20
> 	#endif
>=20
> But it seems neither <asm/kvm_host.h> nor <linux/kvm_host.h> has this
> pattern.
>=20
> I tried to build with !CONFIG_KVM with patch 2 in this series, and I got
> below error:

Well, yeah.

> In file included from ./include/linux/kvm_host.h:45,
>                  from arch/x86/events/intel/core.c:17:
> ./arch/x86/include/asm/kvm_host.h:1617:9: error: unknown type name
> =E2=80=98cpu_emergency_virt_cb=E2=80=99
>  1617 |         cpu_emergency_virt_cb *emergency_disable;
>       |         ^~~~~~~~~~~~~~~~~~~~~
>=20
>=20
> Looking at the code, it seems it is because intel_guest_get_msrs() needs
> 'struct kvm_pmu' (e.g., it accesses the members of 'struct kvm_pmu').  Bu=
t
> it doesn't look the relevant code should be compiled when !CONFIG_KVM.=C2=
=A0
>=20
> So looks a better way is to explicitly use #ifdef CONFIG_KVM around the
> relevant code in the arch/x86/events/intel/core.c?

Eh, there's no right or wrong way to handle code that is conditionally comp=
iled.
There are always tradeoffs and pros/cons, e.g. the number of #ifdefs, the a=
mount
of effective code validation for all configs, readability, etc.

E.g. if there is only one user of a function that conditionally exists, the=
n
having the caller handle the situation might be cleaner.  But if there are
multiple callers, then providing a stub is usually preferable.

IMO, the real problem is that perf pokes into KVM _at all_.  Same for VFIO.
The perf usage is especially egregious, as there is zero reason perf should=
 need
KVM internals[1].  VFIO requires a bit more effort, but I'm fairly confiden=
t that
Jason's file-based approach[2] will yield clean, robust code that minimizes=
 the
number of #ifdefs required.

I'm planning/hoping to get back to that series in the next few weeks.  As f=
or
this small series, I prefer to unconditionally define the typedef, as it re=
quires
no additional #ifdefs, and there are no meaningful downsides to letting the
typedef exist for all kernel builds.

[1] https://lore.kernel.org/all/20230916003118.2540661-21-seanjc@google.com
[2] https://lore.kernel.org/all/ZXkVSKULLivrMkBl@google.com

> And it seems vfio does it in vfio_main.c:
>=20
> 	#if IS_ENABLED(CONFIG_KVM)
> 	#include <linux/kvm_host.h>
> 	#endif
>=20
> 	#if IS_ENABLED(CONFIG_KVM)
> 	void vfio_device_get_kvm_safe(struct vfio_device *device,=C2=A0
> 			struct kvm *kvm)
> 	{
> 		...
> 	}
> 	...
> 	#endif
>=20
>=20
> The only remaining weird thing is 'struct kvm *kvm' is still used
> unconditionally in vfio_main.c, but I think the reason it builds fine wit=
h
> !CONFIG_KVM is because <linux/vfio.h> declares it explicitly:
>=20
> 	struct kvm;
> 	struct iommufd_ctx;
> 	...
>=20
> So it seems to me that this patch around 'cpu_emergency_virt_cb' is more
> like a workaround of existing non-perfect <linux/kvm_host.h> and/or
> <asm/kvm_host.h>?

