Return-Path: <linux-kernel+bounces-545915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D33A4F38C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54AF3A4490
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8A0142624;
	Wed,  5 Mar 2025 01:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgxjJSnG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE22E1426C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137881; cv=none; b=KPtyQYkEAoSGz3ZaWuNNopHlh32OOpfkykGBTWpgCFyQ7CAmGd+l+Eg4KssR9snjpMhwjcHPdVjE0BF4jXYqfv3brcszv6IVCx6iqw9Ls4RW20ULjV1F2lE0frr3PYvZHf5SGiwMEeROPA1NFckyor1JRCPcxQtlqR7BZHiTYoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137881; c=relaxed/simple;
	bh=8ydct3KMoxMe98UJFHOhZoOShOwXxlJ/9YgDjWZk75M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4HojAD/nf7PuteLvbXfLp9AuQLD2Ui566Uw7KZeFGjc8/Kd8WuxQMlElkppVpE/fL9OKnJMCtUKeSlu4x3WsLOlsuWqRwdV3O/MM2ysGQ940tjwDgGXsCpmuxwbX3pgtSB7GqgpcPdHrXSLjYXpfsz2WezbAoNcduv1l7zh/y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SgxjJSnG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741137877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nL7IXd7cWI9sQPKv48ILfgyDbX0MLRczDX4w1id2CAk=;
	b=SgxjJSnGILKjnS/zFyVFC6gCYH0moXHjxJKPCOTN2ooqrlz+juXd/+qJ57f/s/xHZwkuqM
	l9ZHLS04NpMBQbY3loDWptTVAzg84Vg0yjQmJ4Yj5s41/cMCgqTZfuuOSrjBBk2B3cOwiv
	GTmF4mJdq4o4Q6tR0wJHTQ/in/Zgz5w=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-QsMWQXyRM6K1it0MQXVRIQ-1; Tue, 04 Mar 2025 20:24:31 -0500
X-MC-Unique: QsMWQXyRM6K1it0MQXVRIQ-1
X-Mimecast-MFC-AGG-ID: QsMWQXyRM6K1it0MQXVRIQ_1741137870
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2a939f02fso3962975ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 17:24:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741137870; x=1741742670;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nL7IXd7cWI9sQPKv48ILfgyDbX0MLRczDX4w1id2CAk=;
        b=YuooyuSSwqliktk66aCVI6tulGQ8OfGfs4wevrAuQTFD7YcLKdccUcOK36Ctqm8wBc
         TjnckI6B17uZQoDniZxWUrYoFnjz/aKvcpqaSW8VptK1n6wNK9R3rwW32G3/IEiEKwpA
         vC+3S7x0zi65wIBkn52teF+sXXoy4wzdr5ao++qaE0lB1fU5/EI6YK8hoaPaaqcmp6ud
         ZFLnEM+QMQaU+li+r6NO3Qe4g+/+SpSVh0mePmHDH2zwa0od2Xkz2EuUzypoyRUI496h
         P+l0MzaPTnLeqPvYXms3HrVSuLsbhHG9XcJmm4aJPNdR+7iZo94cekW1Xgm0D74r/lLn
         uPPw==
X-Forwarded-Encrypted: i=1; AJvYcCWdXBzps964hcQtkexmVfIKQ4FqbZOgQHzX/Njm+IH2xYlSSlwspXS/z16eOo6ta1byeYv47D6PU9KuGVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq4YoJfF1gSKVf+/OD2gSnW21bPp5qUX+19hEQ2jO2eSTljqcQ
	8+ubyN9SD/dxOKYhAtxZlTUUWUex1f1Qp+Aoypmgj867MaupKw+eTH2ihMG0GAWbKLFHq4aowXa
	PgHwr0WpZHoLAZ2j+Tggh0ufFBO6YRAtOnzAuIukCSZ6BnLf9ScKdCudTf9S2lA==
X-Gm-Gg: ASbGncuGosCbnHyVDPFobLHlGc8DYTm47SePCbGD4GRU5Lo13RSX1vwrsj2XgRyTAB6
	BGGu+8poVlWy7RdM8SuIg8HnT4j5naDa8WwGuEEU4IwmFIy94l5bc4AHqYd6NWu/kup8gvEOodI
	i1i5gHrJdf8X8gxhGQqJq3gkr4Bp+ErJ3Sa8E58M7iBOKUrtef34AWnCvYFY9x/ZDtQuJKAU+XA
	SlosPWiJsyZPOXGcg52wd4rkd9OTAppNhQsDkRlahfU2eufo250SfveaMaEOoWx1daEhbnAZMT+
	pH6DPQoQCqcG6ra6hdU=
X-Received: by 2002:a05:6602:6417:b0:85a:f3db:7cce with SMTP id ca18e2360f4ac-85affbcefccmr47623539f.4.1741137870384;
        Tue, 04 Mar 2025 17:24:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYQ3AelGPFLAWqjO7y5Qjys4d3FF4GK+6yty1mnFya+6E+1J53wcEvdPZwSXUMBOy0C81s7g==
X-Received: by 2002:a05:6602:6417:b0:85a:f3db:7cce with SMTP id ca18e2360f4ac-85affbcefccmr47622439f.4.1741137870083;
        Tue, 04 Mar 2025 17:24:30 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f09170a821sm1688541173.144.2025.03.04.17.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 17:24:29 -0800 (PST)
Date: Tue, 4 Mar 2025 18:24:21 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, nd <nd@arm.com>, Kevin Tian
 <kevin.tian@intel.com>, Philipp Stanner <pstanner@redhat.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Ankit
 Agrawal <ankita@nvidia.com>, "open list:VFIO DRIVER" <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH] vfio/pci: add PCIe TPH to device feature ioctl
Message-ID: <20250304182421.05b6a12f.alex.williamson@redhat.com>
In-Reply-To: <PAWPR08MB89093BBC1C7F725873921FB79FC82@PAWPR08MB8909.eurprd08.prod.outlook.com>
References: <20250221224638.1836909-1-wathsala.vithanage@arm.com>
	<20250304141447.GY5011@ziepe.ca>
	<PAWPR08MB89093BBC1C7F725873921FB79FC82@PAWPR08MB8909.eurprd08.prod.outlook.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 22:38:16 +0000
Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com> wrote:

> > > Linux v6.13 introduced the PCIe TLP Processing Hints (TPH) feature for
> > > direct cache injection. As described in the relevant patch set [1],
> > > direct cache injection in supported hardware allows optimal platform
> > > resource utilization for specific requests on the PCIe bus. This feature
> > > is currently available only for kernel device drivers. However,
> > > user space applications, especially those whose performance is sensitive
> > > to the latency of inbound writes as seen by a CPU core, may benefit from
> > > using this information (E.g., DPDK cache stashing RFC [2] or an HPC
> > > application running in a VM).
> > >
> > > This patch enables configuring of TPH from the user space via
> > > VFIO_DEVICE_FEATURE IOCLT. It provides an interface to user space
> > > drivers and VMMs to enable/disable the TPH feature on PCIe devices and
> > > set steering tags in MSI-X or steering-tag table entries using
> > > VFIO_DEVICE_FEATURE_SET flag or read steering tags from the kernel using
> > > VFIO_DEVICE_FEATURE_GET to operate in device-specific mode.  
> > 
> > What level of protection do we expect to have here? Is it OK for
> > userspace to make up any old tag value or is there some security
> > concern with that?
> >   
> Shouldn't be allowed from within a container.
> A hypervisor should have its own STs and map them to platform STs for
> the cores the VM is pinned to and verify any old ST is not written to the
> device MSI-X, ST table or device specific locations.

And how exactly are we mediating device specific steering tags when we
don't know where/how they're written to the device.  An API that
returns a valid ST to userspace doesn't provide any guarantees relative
to what userspace later writes.  MSI-X tables are also writable by
userspace.  I could have missed it, but I also didn't note any pinning
requirement in this proposal.  Thanks,

Alex


