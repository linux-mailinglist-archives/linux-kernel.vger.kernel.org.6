Return-Path: <linux-kernel+bounces-345465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3B698B69F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30561F21F18
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC6F199FBE;
	Tue,  1 Oct 2024 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2SrU10w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E2A155738
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770715; cv=none; b=u87XVFuztUP6LvEM/Hu9Wo65whKTNbBVuw4LV1RmTDik9FiyVQ/4QXjW2uwp0oMXIyyPRo5JGGsI7IcEHK70NWZRUq9FpxUFuCNQsvpwY/RwDLilrw/KB8/mFOSwPNrtiqD+5QUuOf1mSTfOVwjSGfOlRvadHjWYmTMz7ikODzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770715; c=relaxed/simple;
	bh=FVxXA/46bA5Ju+Ip7o8RoCF1qH4WFWf5J+bvz/jXLNo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bStJGGPTdc32GylcGRomKK+Wqn7mSUxc9WhmmDdn3lsuhw20P7zRoutzPg5SybdtFHa1CE7nctSbeVkT/VEso78PjC+avBuzK6p3udu0BMpEY5b1LXS6QdGuujfmmaMJGVf8dwkESK+sK9zDGvfutrSEfv1rk550+BPRO2KXq+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2SrU10w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727770710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6fHoFX0PDnSZTfecN4IZ6eBr8XhvG76aRuFk6iUg1wg=;
	b=X2SrU10wxz1xKAnN9Gep020hPJNhuF1E0LHb5OkGHHnIyjXNnwHt4zyTJhb00G96Ntk+Pz
	htzFvnmUy/oW1PlSulOk1aw45XeIarMPAOEe002iJBrqKpaNom4TliYbFsN8vlazXRb6fj
	b8MZPj4ICUslQEB2S1DiBHpYu7FUZa0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-yp53AI6kPi6mP6JScelzYg-1; Tue, 01 Oct 2024 04:18:29 -0400
X-MC-Unique: yp53AI6kPi6mP6JScelzYg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cdeac2da6so43501645e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 01:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727770707; x=1728375507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fHoFX0PDnSZTfecN4IZ6eBr8XhvG76aRuFk6iUg1wg=;
        b=B96f0Vw7G/ZQseZBvL1SAVaJIz04xHiNAE+Yf8crh1R02WwmVuTFr4lFuTqKs2ukN6
         AjLLFQRjzAZ6Jb2NP7iRiXqZHh/iEH0DzkSn4CXMYp5B4/wuYDjIe9Cqp54PgTtJ5sye
         BSNclElELuXMbZ8fYx3pGWuNF1TU2ptJKJZyhJZJQht++ce68gGASh3Acr1VC3AZkcDk
         4notMpHnUL/VFNu4GoDHMCRnfSaVOimcJaE42cL6YmRouAd4mSY7TKBNgSEo9es/fvRB
         t39RhHXvKFmouEI+WbQCNd8TfxCq/jP4jMwNfqlFasHnDgoY0k0js/xlg7UePiRvnObJ
         z9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsnrWVxtombQQjgHfsqUUUGoBIeMDRaVcYMcJpii2vqWnAUCDpofWA2Uzfn9NZyptIlQDrVpfizK/33GU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQmWSB/IbkJE1tJjmdoCvp2mloXOZHpnc1AuIuCkX6HIZ1OeIE
	xj599fsxllcETyHSKsAKEyvxSxGhquPCA9AfgVuOBBMBMo5aCrcq9sda6ddklJnY/S+96AyUnId
	/ZmZAjYOWjDd4xD8nCQCgUTrFb+8SbzxrNgPTCARw+mVBTocXVVQ6UUpA51LQw78dGJAwWg==
X-Received: by 2002:a05:600c:a4b:b0:42c:b6e4:e3aa with SMTP id 5b1f17b1804b1-42f5840d0e8mr111361475e9.5.1727770707340;
        Tue, 01 Oct 2024 01:18:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw8ufUH6F5nDbkSSNEqTEzuf4KWYsJLQeJtg49jP8WrSSKL+9gbTDJ/scSAsPl74EhIIVgvA==
X-Received: by 2002:a05:600c:a4b:b0:42c:b6e4:e3aa with SMTP id 5b1f17b1804b1-42f5840d0e8mr111361235e9.5.1727770706900;
        Tue, 01 Oct 2024 01:18:26 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e6875sm11227722f8f.55.2024.10.01.01.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 01:18:26 -0700 (PDT)
Date: Tue, 1 Oct 2024 10:18:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Mackay <eric.mackay@oracle.com>
Cc: boris.ostrovsky@oracle.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com
Subject: Re: [PATCH] KVM/x86: Do not clear SIPI while in SMM
Message-ID: <20241001101825.38b23397@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240930233458.27182-1-eric.mackay@oracle.com>
References: <20240927112839.1b59ca46@imammedo.users.ipa.redhat.com>
	<20240930233458.27182-1-eric.mackay@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Sep 2024 16:34:57 -0700
Eric Mackay <eric.mackay@oracle.com> wrote:

> > On Thu, 26 Sep 2024 18:22:39 -0700
> > Eric Mackay <eric.mackay@oracle.com> wrote: =20
> > > > On 9/24/24 5:40 AM, Igor Mammedov wrote:   =20
> > > >> On Fri, 19 Apr 2024 12:17:01 -0400
> > > >> boris.ostrovsky@oracle.com wrote:
> > > >>    =20
> > > >>> On 4/17/24 9:58 AM, boris.ostrovsky@oracle.com wrote:   =20
> > > >>>>
> > > >>>> I noticed that I was using a few months old qemu bits and now I =
am
> > > >>>> having trouble reproducing this on latest bits. Let me see if I =
can get
> > > >>>> this to fail with latest first and then try to trace why the pro=
cessor
> > > >>>> is in this unexpected state.   =20
> > > >>>
> > > >>> Looks like 012b170173bc "system/qdev-monitor: move drain_call_rcu=
 call
> > > >>> under if (!dev) in qmp_device_add()" is what makes the test to st=
op failing.
> > > >>>
> > > >>> I need to understand whether lack of failures is a side effect of=
 timing
> > > >>> changes that simply make hotplug fail less likely or if this is an
> > > >>> actual (but seemingly unintentional) fix.   =20
> > > >>=20
> > > >> Agreed, we should find out culprit of the problem.   =20
> > > >
> > > >
> > > > I haven't been able to spend much time on this unfortunately, Eric =
is=20
> > > > now starting to look at this again.
> > > >
> > > > One of my theories was that ich9_apm_ctrl_changed() is sending SMIs=
 to=20
> > > > vcpus serially while on HW my understanding is that this is done as=
 a=20
> > > > broadcast so I thought this could cause a race. I had a quick test =
with=20
> > > > pausing and resuming all vcpus around the loop but that didn't help.
> > > >
> > > >   =20
> > > >>=20
> > > >> PS:
> > > >> also if you are using AMD host, there was a regression in OVMF
> > > >> where where vCPU that OSPM was already online-ing, was yanked
> > > >> from under OSMP feet by OVMF (which depending on timing could
> > > >> manifest as lost SIPI).
> > > >>=20
> > > >> edk2 commit that should fix it is:
> > > >>      https://github.com/tianocore/edk2/commit/1c19ccd5103b
> > > >>=20
> > > >> Switching to Intel host should rule that out at least.
> > > >> (or use fixed edk2-ovmf-20240524-5.el10.noarch package from centos,
> > > >> if you are forced to use AMD host)   =20
> > >=20
> > > I haven't been able to reproduce the issue on an Intel host thus far,
> > > but it may not be an apples-to-apples comparison because my AMD hosts
> > > have a much higher core count.
> > >  =20
> > > >
> > > > I just tried with latest bits that include this commit and still wa=
s=20
> > > > able to reproduce the problem.
> > > >
> > > >
> > > >-boris   =20
> > >=20
> > > The initial hotplug of each CPU appears to complete from the
> > > perspective of OVMF and OSPM. SMBASE relocation succeeds, and the new
> > > CPU reports back from the pen. It seems to be the later INIT-SIPI-SIPI
> > > sequence sent from the guest that doesn't complete.
> > >=20
> > > My working theory has been that some CPU/AP is lagging behind the oth=
ers
> > > when the BSP is waiting for all the APs to go into SMM, and the BSP j=
ust
> > > gives up and moves on. Presumably the INIT-SIPI-SIPI is sent while th=
at
> > > CPU does finally go into SMM, and other CPUs are in normal mode.
> > >=20
> > > I've been able to observe the SMI handler for the problematic CPU will
> > > sometimes start running when no BSP is elected. This means we have a
> > > window of time where the CPU will ignore SIPI, and least 1 CPU is in
> > > normal mode (the BSP) which is capable of sending INIT-SIPI-SIPI from
> > > the guest. =20
> >=20
> > I've re-read whole thread and noticed Boris were saying: =20
> >   > On Tue, Apr 16, 2024 at 10:57=E2=80=AFPM <boris.ostrovsky@oracle.co=
m> wrote: =20
> >   > > On 4/16/24 4:53 PM, Paolo Bonzini wrote:   =20
> >   ... =20
> >   > > >
> >   > > > What is the reproducer for this?   =20
> >   > >
> >   > > Hotplugging/unplugging cpus in a loop, especially if you oversubs=
cribe
> >   > > the guest, will get you there in 10-15 minutes. =20
> >   ...
> >=20
> > So there was unplug involved as well, which was broken since forever.
> >=20
> > Recent patch
> >  https://patchew.org/QEMU/20230427211013.2994127-1-alxndr@bu.edu/202304=
27211013.2994127-2-alxndr@bu.edu/
> > has exposed issue (unexpected uplug/unplug flow) with root cause in OVM=
F.
> > Firmware was letting non involved APs run wild in normal mode.
> > As result AP that was calling _EJ0 and holding ACPI lock was
> > continuing _EJ0 and releasing ACPI lock, while BSP and a being removed
> > CPU were still in SMM world. And any other plug/unplug op
> > were able to grab ACPI lock and trigger another SMI, which breaks
> > hotplug flow expectations (aka exclusive access to hotplug registers
> > during plug/unplug op)
> > Perhaps that's what you are observing.
> >=20
> > Please check if following helps:
> >   https://github.com/kraxel/edk2/commit/738c09f6b5ab87be48d754e62deb72b=
767415158
> >  =20
>=20
> I haven't actually seen the guest crash during unplug, though certainly
> there have been unplug failures. I haven't been keeping track of the
> unplug failures as closely, but a test I ran over the weekend with this
> patch added seemed to show less unplug failures.

it's not only about unplug, unfortunately.
QEMU that includes Alexander's patch, essentially denies access to hotplug
registers if unplug is in process. So if there is hotplug going at the same
time, it may be broken by that access deny.
To exclude this issue, you need to test with edk2 fix or use older QEMU
without Alexander's patch.


> I'm still getting hotplug failures that cause a guest crash though, so
> that mystery remains.
>=20
> > So yes, SIPI can be lost (which should be expected as others noted)
> > but that normally shouldn't be an issue as wakeup_secondary_cpu_via_ini=
t()
> > do resend SIPI.
> > However if wakeup_secondary_cpu is set to another handler that doesn't
> > resend SIPI, It might be an issue. =20
>=20
> We're using wakeup_secondary_cpu_via_init(). acpi_wakeup_cpu() and
> wakeup_cpu_via_vmgexit(), for example, are a bit opaque to me, so I'm
> not sure if those code paths include a SIPI resend.

wakeup_secondary_cpu_via_init() should re-send SIPI.
If you can reproduce with KVM tracing and guest kernel debug enabled,
I'd try to do that and check if SIPI are being re-sent or not.
That at least should give a hint if we should look at guest side or at KVM/=
QEMU.


