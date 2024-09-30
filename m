Return-Path: <linux-kernel+bounces-344517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E70AD98AAAF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F732284A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A373197A82;
	Mon, 30 Sep 2024 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4rQ1oR4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8021194C6A
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716221; cv=none; b=cwdEAnC7J8nbwVX/SF4jH3K5LOvGa/uDdR12U8scW1pIbRT6PVOpkqkNIBtodVEm7nuyUqagbrs6C7n7t0R/+T28L41fClsZ3IQ91EUHgtiqjs6kDyXD9LZdAl+SKLUJrbRPwhNz1NBZTDBSZ6sfLk8bYxfQSAuSBzsJN3h5Om4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716221; c=relaxed/simple;
	bh=5wCtd/qenl5aQFXC8VeDAnkSJ10rUAbKI4NRMVb1cAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQHOBU33VrS+93WIrwbp2mz/cfwTu3AIdxJTCYIn4MlwlPunNOzc8r3Tzb5GkUNou6QGrYcveEb6SBMmsZ8pFvUK+L1F820kSv921TfZj/rV+zhGrz/Okiq1MBq8xLw08FVqBsQ4B0PO3hIo0O0Ot8Rs+yfO8o/0foqlXnJmQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4rQ1oR4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727716218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVt/DmzawSuKCiIPGGvUBbDL08MEsVeaKZJjhuNhC/w=;
	b=G4rQ1oR4hWqndzCLArqCPnFKKhx6eWX9rOkxjcEl2RUvgpIkjIyPCCx9oqk4Z3F+5jrVOH
	G0vjKZl7VsQ3oFimryOeseJlipzAsMB3YW/xe70YbzTzpyjf3AZc9wL7IkHPJANsDjuW1r
	66STNguEGod8EFuMxSeZrn9e7LQogeY=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-9X2C4FhQMbGEqtNf3UwHwA-1; Mon, 30 Sep 2024 13:10:17 -0400
X-MC-Unique: 9X2C4FhQMbGEqtNf3UwHwA-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a34615054cso5465895ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716216; x=1728321016;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NVt/DmzawSuKCiIPGGvUBbDL08MEsVeaKZJjhuNhC/w=;
        b=kj0f3pcUFctgYvLHuDofSMFd+eHebkNmXKAsXXydyq4AhrcGaUaAt+uO9KYHyurikT
         4k9hh+d3u8pUvsuLLTiEloUyGoWUbZYY1j1pGtWNMRMgtywwG1HeAppnnf3tg7appzH+
         36DSczlf7RqOIAd9WmNLvxICpfSOE43hkHh7We6HdM0rsRUKbMNvxUBIcJ9oCB0mIn0d
         8K7Qm6cKSGSV9zqS3GuHIZxTIP6QvTJ2H9RDFjkCd2ZX6sShUjgpCpqCMWvsLIUQHYN6
         gXIqnX4DutjrXnsf6tkRedmxUSVluvTGWXGcadjpgXFxD/JmkvuirRwqP7BpKYJwm6IY
         1XPg==
X-Forwarded-Encrypted: i=1; AJvYcCUGcg63GwrzQyDZrz9L1fbbmz/OpL40krkjh9LQqYt//JPkdaZKCDdThZcNTP6wecQ/N+dsdHmIukretGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Wtv3JuR6jkwolRYMUFh6Ym4RsaG/ghLIWQAZq1Dq+At/8XbT
	L6rWWbMF7ZDJUctd8eGJayHXKyClAA+BTVXUMmFAuaFXWFVwvHQWzufZP6Odsoqf2tbSupdC9nG
	PU+aztPPLH/SHmVKKKiY+JrNfNIHlU1bi/aS+KWrdZD1JQPvkVHNZ1UObGWlKfA==
X-Received: by 2002:a05:6e02:1a62:b0:3a0:a1ab:7ce6 with SMTP id e9e14a558f8ab-3a34b39e8bamr23120205ab.1.1727716215890;
        Mon, 30 Sep 2024 10:10:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVY1jcjHI2++bqrj08cP6Loolvcj7a+HYSyjOjpjVAkhKXYhKioDRhz48pxKUu4rJq3/AzdA==
X-Received: by 2002:a05:6e02:1a62:b0:3a0:a1ab:7ce6 with SMTP id e9e14a558f8ab-3a34b39e8bamr23120065ab.1.1727716215513;
        Mon, 30 Sep 2024 10:10:15 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888f979csm2181143173.164.2024.09.30.10.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:10:14 -0700 (PDT)
Date: Mon, 30 Sep 2024 11:10:13 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: kvm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, Eric
 Auger <eric.auger@redhat.com>, kwankhede@nvidia.com, Marc Zyngier
 <maz@kernel.org>, Will Deacon <will@kernel.org>, Quentin Perret
 <qperret@google.com>
Subject: Re: [RFC] Simple device assignment with VFIO platform
Message-ID: <20240930111013.2478261c.alex.williamson@redhat.com>
In-Reply-To: <CAFgf54rCCWjHLsLUxrMspNHaKAa1o8n3Md2_ZNGVtj0cU_dOPg@mail.gmail.com>
References: <CAFgf54rCCWjHLsLUxrMspNHaKAa1o8n3Md2_ZNGVtj0cU_dOPg@mail.gmail.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Sep 2024 17:17:02 +0100
Mostafa Saleh <smostafa@google.com> wrote:

> Hi All,
>=20
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I have been looking into assigning simple devices which are not DMA
> capable to VMs on Android using VFIO platform.
>=20
> I have been mainly looking with respect to Protected KVM (pKVM), which
> would need some extra modifications mostly to KVM-VFIO, that is quite
> early under prototyping at the moment, which have core pending pKVM
> dependencies upstream as guest memfd[1] and IOMMUs support[2].
>=20
> However, this problem is not pKVM(or KVM) specific, and about the
> design of VFIO.
>=20
> [1] https://lore.kernel.org/kvm/20240801090117.3841080-1-tabba@google.com/
> [2] https://lore.kernel.org/kvmarm/20230201125328.2186498-1-jean-philippe=
@linaro.org/
>=20
> Problem
> =3D=3D=3D=3D=3D=3D=3D
> At the moment, VFIO platform will deny a device from probing (through
> vfio_group_find_or_alloc()), if it=E2=80=99s not part of an IOMMU group,
> unless (CONFIG_VFIO_NOIOMMU is configured)
>=20
> As far as I understand the current solutions to pass through platform
> devices that are not DMA capable are:
> - Use VFIO platform + (CONFIG_VFIO_NOIOMMU): The problem with that, it
> taints the kernel and this doesn=E2=80=99t actually fit the device descri=
ption
> as the device doesn=E2=80=99t only have an IOMMU, but it=E2=80=99s not DM=
A capable at
> all, so the kernel should be safe with assigning the device without
> DMA isolation.

If the device is not capable of DMA, then what do you get from using
vfio?  Essentially the device is reduced to some MMIO ranges and
something to configure line level interrupt notification.
Traditionally this is the realm of UIO.
=20
> - Use VFIO mdev with an emulated IOMMU, this seems it could work. But
> many of the code would be duplicate with the VFIO platform code as the
> device is a platform device.

Per Eric's talk recently at KVM Forum[1] we're already at an inflection
point for vfio-platform.  We're suffering from lack of contributions
for any current devices, agreement in the community to end it as a
failed experiment, while at the same time vendors quietly indicate they
depend on it.  It seems that at a minimum, we can't support
vfio-platform like we do vfio-pci, where a meta driver pretends it can
support exposing any platform device.  There's not enough definition to
a platform device.  Therefore if vfio-platform is to survive, it's
probably going to need to do so through device specific drivers which
understands how a specific device operates, and potentially whether it
can or cannot perform DMA.  That might mean that vfio-platform needs to
take the mdev or vfio-pci variant driver approach, and the code
duplication you're concerned about should instead be refactoring in
order to re-use the existing code from more device specific drivers.

> - Use UIO: Can map MMIO to userspace which seems to be focused for
> userspace drivers rather than VM passthrough and I can=E2=80=99t find its
> support in Qemu.

This would need to be device specific code on the QEMU side, so there's
probably not much to share here.

> One other benefit from supporting this in VFIO platform, that we can
> use the existing UAPI for platform devices (and support in VMMs)

But it's not like there's ubiquitous support for vfio-platform devices
in QEMU either.  Each platform device needs hooks to at least setup
device tree entries to describe the device to the VM.  AIUI, QEMU needs
to understand the device and how to describe it to the VM whether the
approach is vfio-platform or UIO.
=20
> Proposal
> =3D=3D=3D=3D=3D=3D=3D=3D
> Extend VFIO platform to allow assigning devices without an IOMMU, this
> can be possibly done by
> - Checking device capability from the platform bus (would be something
> ACPI/OF specific similar to how it configures DMA from
> platform_dma_configure(), we can add a new function something like
> platfrom_dma_capable())
>=20
> - Using emulated IOMMU for such devices
> (vfio_register_emulated_iommu_dev()), instead of having intrusive
> changes about IOMMUs existence.
>=20
> If that makes sense I can work on RFC(I don=E2=80=99t have any code at th=
e moment)

As noted in the thread referenced by Eric, I don't think we want to add
any sort of vfio no-iommu into QEMU.  vfio-platform in particular is in
no position drive such a feature.  If you want to use vfio for this,
the most viable approach would seem to be one of using an emulated
IOMMU in a device specific context which can understand the device is
not capable of DMA.  We likely need to let vfio-platform die as generic
means to expose arbitrary platform devices.  Thanks,

Alex

[1]https://www.youtube.com/watch?v=3DQ5BOSbtwRr8


