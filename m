Return-Path: <linux-kernel+bounces-314328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7999696B1EE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6041C2113A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 06:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995E913A88D;
	Wed,  4 Sep 2024 06:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bNGV+pWW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090612C549
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431877; cv=none; b=P12peh/HYwzKK4jxp0vLHM1a7ofREnsk0cH+UIN4TGqBjk0Lh1uJOQAVehKhUtsXQkChQ4Tvv0GNSERE3UQJhwhp7LaunOOjJDPxZQHiAyVCVVIGVwOg8sOLV04k1+s4NbsGbJhkYDW6I7V/y7EMUorI/GndP+j5Z/B8P0867mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431877; c=relaxed/simple;
	bh=Nib65CS/jKWraWvQ+DYxRru/c/gctxD1oYSNGhN1rv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRaR/Lco/5Zqh+PviAJd9/YEMAoYiznDf/3d5Hy9k3PauCF5pPDg5w6IgAQoJ2PGzoewYSEF44eZf9sVZNMFHUgG7W7GgIujhCq7KUyzKEozm0y7qlA9arj7y+oQeQ1Nl1om2okp8zei+WA72R2VY3jLO5woQ90eSr4dNzR0SIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bNGV+pWW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725431874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nib65CS/jKWraWvQ+DYxRru/c/gctxD1oYSNGhN1rv4=;
	b=bNGV+pWWw5PkKRWLvaQaOub1/rNrcRy/NaMVuKzOWWczPKzQrjOuktJ75k+vFVqMxUC1Jm
	2WwvdF/yjZAXOlUZy1mgeJKW1S1qkNyhO+/r3l/MH6Hp8DQsfa8AXOKd4eZKF5XrEi4oaO
	+DetWoRHaQ1gMcwNq3FVOic3oVugvb4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-z5DfV5WyONaIYm-DGDhX8Q-1; Wed, 04 Sep 2024 02:37:53 -0400
X-MC-Unique: z5DfV5WyONaIYm-DGDhX8Q-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7143af9568bso5352495b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 23:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725431692; x=1726036492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nib65CS/jKWraWvQ+DYxRru/c/gctxD1oYSNGhN1rv4=;
        b=GxBskCp/kqOWYs3usXt/MjcdbarWS+g+QcOQMgahw3FlTH5cbCbR5VCAbm+6HndOv6
         H1SwoJYJCFNFsEa10aYCADQsDB0q7NkBw5/X73H9qobOPGX4UZeASNQye/VGN6PWJIzB
         hqYmMbeGehZUSfKf4WmeiCKEysfIPljhpkAYHkEOHxwVyNElkMKB+/0rL1H1yvb5rVrT
         xfJ/+AAZYrFk8Lo2yOpn27QFuMFWZDPFMXzjSdjpTQyrqx8+bIoj2VE6bh4tcpCsSxeT
         S+qfv2hrRmSyMUmKsbEvGvctRaT8LHSolnO0+UEyHeVbFY5CbmG0cGci+Mu07cjQpHCV
         RNeg==
X-Forwarded-Encrypted: i=1; AJvYcCX9rbu+x0ZI+t7xv1aRwQkm9nvRuddiOhNY2LHg4lCJ3/NcSi6dEhlBuCXRASI+8nxoZwvp2+dg0esroYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuUk9084B+T1TL8r1ux8m8ltVNuliitM1I1u4I6g4A4/Lpw2e4
	AUyEvKjBJ1w8lx+otdnQyJDps1eP/VmUBIu3jMW3Qdunt+JVEwPNRjgo3zaeckRXsx1e1mc7W8a
	QOQKu1HExSW5iIYMbtRtd3Xwv4m4H5l0+km610E06EIQ7D+5Iobqn6PaxYNLEooE5huZkVKLPqX
	J8QeHxeAFFVJdYsDoAq29fiF4SOvHknUk8uMf6
X-Received: by 2002:a05:6a21:1706:b0:1c2:8f50:b450 with SMTP id adf61e73a8af0-1cece502d52mr12321290637.18.1725431692598;
        Tue, 03 Sep 2024 23:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELt1GC768sylfd9cTaGwknyMDJpOCJXkmNL6NeitKqFXTFJKiRjDvxPjGsHsp/dkBeUZBjUFKz563x6JqMgvo=
X-Received: by 2002:a05:6a21:1706:b0:1c2:8f50:b450 with SMTP id
 adf61e73a8af0-1cece502d52mr12321276637.18.1725431691959; Tue, 03 Sep 2024
 23:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com>
 <20240903171514.201569-3-carlos.bilbao.osdev@gmail.com> <CACGkMEvHU0VnOEZbVnEr1SvmOF5PhMtKk=M2o7Wwq-DUO9p7Uw@mail.gmail.com>
 <faafc28a-23a9-4dff-8223-1c72acb42443@nvidia.com>
In-Reply-To: <faafc28a-23a9-4dff-8223-1c72acb42443@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Sep 2024 14:34:41 +0800
Message-ID: <CACGkMEtZHnkBj2JKaEp=7xURtkUFy=vFQEO8LZ7z7hoFafDMVg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec compliance
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, mst@redhat.com, shannon.nelson@amd.com, 
	sashal@kernel.org, alvaro.karsz@solid-run.com, christophe.jaillet@wanadoo.fr, 
	steven.sistare@oracle.com, bilbao@vt.edu, xuanzhuo@linux.alibaba.com, 
	johnah.palmer@oracle.com, eperezma@redhat.com, cratiu@nvidia.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Carlos Bilbao <cbilbao@digitalocean.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 1:59=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
>
>
> On 04.09.24 05:38, Jason Wang wrote:
> > On Wed, Sep 4, 2024 at 1:15=E2=80=AFAM Carlos Bilbao
> > <carlos.bilbao.osdev@gmail.com> wrote:
> >>
> >> From: Carlos Bilbao <cbilbao@digitalocean.com>
> >>
> >> Remove invalid ioctl VHOST_VDPA_SET_CONFIG and all its implementations
> >> with vdpa_config_ops->set_config(). This is needed per virtio spec
> >> requirements; virtio-spec v3.1 Sec 5.1.4 states that "All of the devic=
e
> >> configuration fields are read-only for the driver."
> >>
> >> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> >
> > Note that only the config space of the modern device is read only. So
> > it should be fine to remove vp_vdpa which only works for modern
> > devices.
> Just out of curiosity: how will this work for devices that are not
> v1.3 compliant but are v1.2 compliant?

Devices don't know the version of the spec, it works with features.
For example, most devices mandate ACCESS_PLATFORM which implies a
mandatory VERSION_1. So they are modern devices.

> Or is this true of all devices
> except eni?

ENI depends on the virtio-pci legacy library, so we know it's a legacy
device implementation which allows mac address setting via config
space.

Thanks

>
> Thanks,
> Dragos
> >
> > And for eni, it is a legacy only device, so we should not move the
> > set_config there.
> >
> > For the rest, we need the acks for those maintainers.
> >
> > Thanks
> >
>


