Return-Path: <linux-kernel+bounces-422867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95F29D9F26
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645C5166A2C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9111DC759;
	Tue, 26 Nov 2024 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lkm59W86"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ECE1DA632
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 22:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732659524; cv=none; b=knHnYJIMO9XqKxbVv6GqK2GsnRAILBGvuC/XwxrozKF7ecHbz+X+8NyB2BYhMBKgLqOFY23/H5knIw1ejAy3jmy+YMPdW2WcebsxqJO9jjg2YTvDfEXeVrfvCS4S1eT6jQOsKybVOLGVgSdA2d05S3TFQUGRBu+LvIvysPFi5aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732659524; c=relaxed/simple;
	bh=M1kKWss59YR0eCWeJENzIjoaSJFICcYS5L19/gREvtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJCHetUZzBIQNV0+x8DGu4os4MNxNutLwtnXqtwmEtABZXLBLtkaTzFAb1Qh0yJd052PsJoXDLSmAtPCePVQ3cZXpvKDqRhVV3FHIWF6PvBt5XIJRyVD0c0gUKDR9Eq9y6chxhb7KNDLIz8ZqszfRAe/oOEOGvOozJ+HJmiXBA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lkm59W86; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DAAFB3F0DE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 22:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732659517;
	bh=kMWy4R/PWaAd6ZphBglE5PBMsUPyAejlkgoIzfKkTzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=lkm59W860279VtNBtX7zkixehFQYMqG05M9Rv0IoUo/SHmT3eSDDzcP6Bd9xFZiIe
	 S+jNPnsapYV9DYcu7ff3lG3Qrqtc4vZDCs1vm/mH9CXFwshx+X/+edUB6ZSZxMMnzo
	 B0TQlxv2N3gAL2yEIpgmprSQJhtvyDwygbOnXB1TlUrtvHF7hu3ooENIhFXbGed72s
	 z7p3M3hb1BQx3UhHvOkNJj2EkTbtKDxzAGP17/E57hiwl3AIX3roZeROjA6M5OQQ7/
	 X/TE8CiUQ+tSDdYAz74ctw5VwMX86E9npqpwkWNabFfYE6x9K+HyDWu9LgJCLZtcec
	 xVZKEU7HTU6ug==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5cf735604aeso5604665a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:18:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732659517; x=1733264317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMWy4R/PWaAd6ZphBglE5PBMsUPyAejlkgoIzfKkTzI=;
        b=ZGWemVPbc5RXCRFVwNBs4In4HzNGVDPulM+Jnm5qYjM0nA7CAl1hHr0OHPd8ijc9Os
         2PsinClgWECLa/3w2L6L+lVrmOysz8uwQLOQazC2tt1d9ZRH/Yn0+CoTd4H2bgCISaqj
         bgN4wgFpZsrZybn/0y5vH+Ovzq+XkPBK1yeGXXn573PKns0GOQK6uG2Et6XqhKgulPcx
         E5jC+iOpTIuMvFTi7dTj5lK6fh3cBXA2gOb51b7PfPZ3+hlfZwPxiXkk46e4ufbO5oWZ
         WSMX85dQoBRokMYTS9mpvoEU7izES4i3vjXA1iMPKazpBLXJdPgVhaqdGWA7LfTWGznc
         L86Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCutRsSL2Rll7/ppI2adh64GJfPucZIk8D8Isd+w+rxbncPH3o82X5uiM5KJWb4lxxEeOI62xnLnGUZ7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTjJiPWMyThHum+ezzds+yxmbGkL1caXwQbuQKqRudz85kfyx/
	e3xNUPC6UAkNgxfVGOyqej56gq3Hkx93GvmyF6EHvBeOluoPkb8FMw+ScFfBf7HYkt5xvK+clb0
	X1KSeAPo5NqdTkwe4RJUC3Oj5YHPssoGes3r4WUBL6aGSGvtrnK2MN11UCVAVnW3G6JSpsyp4MZ
	6/ViGPQ1GLYnTDOn5c2i067VyuSZ28DBimsaCg8J9+b2yK9wbe8Ko+
X-Gm-Gg: ASbGncvMokIPQvWucEKWOf+aFPd6RsvpZa0fABuzPzVJ4mdAIUqM2gZDkiSVPDU+7IZ
	pLYqpI0J98Ej3dPbrkyyX89Sd3E2E+w==
X-Received: by 2002:a05:6402:358a:b0:5d0:81af:4a43 with SMTP id 4fb4d7f45d1cf-5d081af8571mr327763a12.0.1732659517438;
        Tue, 26 Nov 2024 14:18:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgm+ajJN5VPDoSscUAG9HQprH+2rO2WXmVqqFL7SJmrOXtoUTQ0n5HFsfg5dsr7Izw9vwxGQpOFLYfcYa5aWg=
X-Received: by 2002:a05:6402:358a:b0:5d0:81af:4a43 with SMTP id
 4fb4d7f45d1cf-5d081af8571mr327753a12.0.1732659517035; Tue, 26 Nov 2024
 14:18:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com>
 <20241126103427.42d21193.alex.williamson@redhat.com>
In-Reply-To: <20241126103427.42d21193.alex.williamson@redhat.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Tue, 26 Nov 2024 16:18:26 -0600
Message-ID: <CAHTA-ubXiDePmfgTdPbg144tHmRZR8=2cNshcL5tMkoMXdyn_Q@mail.gmail.com>
Subject: Re: drivers/pci: (and/or KVM): Slow PCI initialization during VM boot
 with passthrough of large BAR Nvidia GPUs on DGX H100
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Alex,

> The VM needs to be given enough 64-bit MMIO space for the devices, at whi=
ch point the BIOS should be able to fully assign the BARs and then pci=3Dno=
crs,realloc should not be necessary

Understood, this is what I have observed as well - pci=3Dnocrs,realloc
is not needed when OVMF advertises a large enough MMIO window.
(initial BAR assignment is correct, just slow to generate.)

> Are you seeing __pci_read_base() called 20-40 times repeatedly for a give=
n device or in total for the VM boot.  Minimally it needs to be called once=
 for every PCI device, so it's not clear to me if you're reporting somethin=
g excessive based on using pci=3Drealloc or there are just enough devices t=
o justify this many calls.

This is total, for the entire VM boot, and this happens even without
pci=3Drealloc. In these tests, I was passing through 4 GPUs to the
guest, and each of those had 3 BARs (albeit only one per GPU that is
128GB).

> If 5s is the measure of enabling one GPU, the VM BIOS will need to do tha=
t at least once and the guest OS will need to do that at least once, we're =
up to 4 GPUs * 5s * 2 times =3D 40s

5s was more of an extreme upper bound on wall clock time. Really, it's
more like 1.5 seconds wall clock time per GPU. (and I was able to get
hotplug working this morning on a VM where the GPUs weren't initially
there at boot, and observed the same.) In my tests, the cumulative
time when doing all 4-8 of these GPU passthroughs after boot using
hotplug is marginal (like, under 20 seconds cumulatively), which is
drastically better than the 1-3 extra minutes of wall clock time for
those init stages when the GPUs are attached at boot. Also, neither of
these are factoring in the time that it takes for the VM to allocate
the entire 900GB guest memory, as that stays the same in all of my
configs and is thus not a concern for me. (the only difference is that
it occurs at first hotplug when I'm hotplugging, vs at boot time when
GPUs are there at start.)

> there's no indication I can find in virt-install command of using hugepag=
es

I just gave this a test with 1G hugepages used as the backing store
for the VM memory, and it doesn't impact the GPU initialization time.

> The BAR space is walked, faulted, and mapped.  I'm sure you're at least e=
xperiencing scaling issues of that with 128GB BARs.

The part that is strange to me is that I don't see the initialization
slowdown at all when the GPUs are hotplugged after boot completes.
Isn't what you describe here also happening during the hotplugging
process, or is it different in some way?

> I know there's room to improve the former. We just recently added kernel =
support for pgd and pmd large page mapping for pfnmap regions and QEMU 9.2-=
rc includes alignment of vfio-pci BARs to try to optimize that towards pgd =
where possible.  We're still trying to pin individual pages though, so perc=
olating the mapping sizes up through the vfio IOMMU backend could help.

Good to hear that there is active work being done to speed this up.
FWIW though, I did just try this out with the 6.12 kernel in my guest
and host with qemu-9.2.0-rc1, and I do not see any improvement in the
PCI init time when my devices are attached during boot.

Thanks,

On Tue, Nov 26, 2024 at 11:34=E2=80=AFAM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Mon, 25 Nov 2024 16:46:29 -0600
> Mitchell Augustin <mitchell.augustin@canonical.com> wrote:
>
> > Hello,
> >
> > I've been working on a bug regarding slow PCI initialization and BAR
> > assignment times for Nvidia GPUs passed-through to VMs on our DGX H100
> > that I originally believed to be an issue in OVMF, but upon further
> > investigation, I'm now suspecting that it may be an issue somewhere in
> > the kernel. (Here is the original edk2 mailing list thread, with extra
> > context: https://edk2.groups.io/g/devel/topic/109651206) [0]
> >
> >
> > When running the 6.12 kernel on a DGX H100 host with 4 GPUs passed
> > through using CPU passthrough and this virt-install command[1], VMs
> > using the latest OVMF version will take around 2 minutes for the guest
> > kernel to boot and initialize PCI devices/BARs for the GPUs.
> > Originally, I was investigating this as an issue in OVMF, because GPU
> > initialization takes much less time when our host is running an OVMF
> > version with this patch[2] removed (which only calculates the MMIO
> > window size differently). Without that patch, the guest kernel does
> > boot quickly, but we can only use the Nvidia GPUs within the guest if
> > `pci=3Dnocrs pci=3Drealloc` are set in the guest (evidently since the M=
MIO
> > windows advertised by OVMF to the kernel without this patch are
> > incorrect). So, the OVMF patch being present does evidently result in
> > correct MMIO windows and prevent us from needing those kernel options,
> > but the VM boot time is much slower.
> >
> >
> > In discussing this, another contributor reported slow PCIe/BAR
> > initialization times for large BAR Nvidia GPUs in Linux when using VMs
> > with SeaBIOS as well. This, combined with me not seeing any slowness
> > when these GPUs are initialized on the host, and the fact that this
> > slowness only happens when CPU passthrough is used, are leading me to
> > suspect that this may actually be a problem somewhere in the KVM or
> > vfio-pci stack. I did also attempt manually setting different MMIO
> > window sizes using the X-PciMmio64Mb OVMF/QEMU knob, and it seems that
> > any MMIO window size large enough to accommodate all GPU memory
> > regions does result in this slower initialization time (but also a
> > valid mapping).
>
> The VM needs to be given enough 64-bit MMIO space for the devices, at
> which point the BIOS should be able to fully assign the BARs and then
> pci=3Dnocrs,realloc should not be necessary.
>
> > I did some profiling of the guest kernel during boot, and I've
> > identified that it seems like the most time is spent in this
> > pci_write_config_word() call in __pci_read_base() of
> > drivers/pci/probe.c.[3] Each of those pci_write_config_word() calls
> > takes about 2 seconds, but it adds up to a significant chunk of the
> > initialization time since __pci_read_base() is executed somewhere
> > between 20-40 times in my VM boot.
>
> A lot happens in the VMM when the memory enable bit is set in the
> command register.  This is when the MMIO BARs of the device enter the
> AddressSpace in QEMU and are caught by the MemoryListener to create DMA
> mappings though the IOMMU.  The BAR space is walked, faulted, and
> mapped.  I'm sure you're at least experiencing scaling issues of that
> with 128GB BARs.
>
> Are you seeing __pci_read_base() called 20-40 times repeatedly for a
> given device or in total for the VM boot.  Minimally it needs to be
> called once for every PCI device, so it's not clear to me if you're
> reporting something excessive based on using pci=3Drealloc or there are
> just enough devices to justify this many calls.
>
> > As a point of comparison, I measured the time it took to hot-unplug
> > and re-plug these GPUs after the VM booted, and observed much more
> > reasonable times (under 5s for each GPU to re-initialize its memory
> > regions). I've also been trying to get this hotplugging working in VMs
> > where the GPUs aren't initially attached at boot, but in any such
> > configuration, the memory regions for the PCI slots that the GPUs get
> > attached to during hotplug are too small for the full 128GB these GPUs
> > require (and I have yet to figure out a way to fix that. More details
> > on that in [0]).
>
> If 5s is the measure of enabling one GPU, the VM BIOS will need to do
> that at least once and the guest OS will need to do that at least once,
> we're up to 4 GPUs * 5s * 2 times =3D 40s.  If the guest OS toggles
> memory enable more than once, your 2 minute boot time isn't sounding
> too far off.  Then there's also the fact that the VM appears to be
> given 900+GB of RAM, which also needs to be pinned and mapped for DMA
> and there's no indication I can find in virt-install command of using
> hugepages.
>
> There are essentially two things in play here, how long does it take to
> map that BAR into the VM address space, and how many times is it done.
> I know there's room to improve the former.  We just recently added
> kernel support for pgd and pmd large page mapping for pfnmap regions
> and QEMU 9.2-rc includes alignment of vfio-pci BARs to try to optimize
> that towards pgd where possible.  We're still trying to pin individual
> pages though, so percolating the mapping sizes up through the vfio
> IOMMU backend could help.  Thanks,
>
> Alex
>


--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

