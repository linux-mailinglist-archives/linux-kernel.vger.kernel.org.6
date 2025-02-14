Return-Path: <linux-kernel+bounces-514676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB3FA35A16
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29613164D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA71322F3B8;
	Fri, 14 Feb 2025 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CryCj59+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9763122D799
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524823; cv=none; b=Ez5HTDU9x5qSGP8yoSfek9rTQkmuEyMVyTUzjWVpG6oCdYS3wlknaJkPRDEJyQiCIlvpgOAQ8S/qy2E3Q83/pKl4y7hBP/Qa0wVLgWdpx4NAp4NZqj/5ukWPNRiprOiYcB8WGqX9EgAv6bKKMyQbXN+r0CLTviCjJBGQGIhxo+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524823; c=relaxed/simple;
	bh=ZR/58w+1L+EYFW6tjt18wTp/81X9JhLePAFSHTKPVMs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQQoTmD6n4+GopAjHJgQmBCdbsmVVC4v1h1FyAjRhfmSX5yOozkLGsgUxj9eO7CEa/maCOnYw7VuyPG+JdrPQlBY4S72gCSdh6LdaBdu9Fx2RzfOKdKk8cqlR6LNT/xSTR8vG9Kg5vFNKEwTVZ0gNLjoJDLjTCyIvU/9DOpmGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CryCj59+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739524820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZR/58w+1L+EYFW6tjt18wTp/81X9JhLePAFSHTKPVMs=;
	b=CryCj59+PpLj5mgNzCGDcZoyv/nf5nx9maqXC3pEssCc29CfooB83jhHR9095zZExJnR9q
	z9wY0DpHinsgVFNP2JW0wUWk38T4pS/kwuc8MeuSFXOrRiBfGT5Gp72YcZFWSjepLhUrmT
	Vw7ZDbnfnsDcnBz0SSK9AQ4LFO1ygzw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-Nw7jbvLYNFCXv6-mSgdhXQ-1; Fri, 14 Feb 2025 04:20:17 -0500
X-MC-Unique: Nw7jbvLYNFCXv6-mSgdhXQ-1
X-Mimecast-MFC-AGG-ID: Nw7jbvLYNFCXv6-mSgdhXQ_1739524816
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc17c3eeb5so3180193a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:20:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524816; x=1740129616;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZR/58w+1L+EYFW6tjt18wTp/81X9JhLePAFSHTKPVMs=;
        b=dxHvgCBJgzj9P5R5NCpeC1k1B9tnqZK29olp2iogtudp0dLDGJ51x7wxIQotUqZnkT
         eu0zv7GH1LHKwrnMHuotLukcYee8odmXUI2nvWzxpn6TYX5cRiLLVm8RgYTmzMf1Gcik
         ir+1VWxS/wh7TqLbnbY9/53dtiEgieg3gUFVer+h5Ls1qVDg6hKrBTyopCRg4jHlPV8t
         T4bsWzQjbi3DU3W1daQFasJ9gXbgJGT8MimPNlYh1/Vv0OXj4GWuHQs4D6Sr6pGPX5rr
         jomwTNkAlBPqnC14uM6kxg7omknVMaId+Dwnx+btXNiFPn766GMMLvIxCTyRaWrjTbmo
         5hxw==
X-Forwarded-Encrypted: i=1; AJvYcCXRk0/M39mErI4Ttrei5Z8AsmLbwtjm1vjZmkCxWFUIoJnprF/e//F84kicEtxJj7Em6xkmX5F8LnNFX8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+W0+UxYQrlYWnqLiYOazgQIv85RkNSLz0viiRjoACOoRiSO1
	ba8/TSNuvqWybg9pkzJXHM2KGn8WFRAHKb/szfcw5s3U5/g6N1grJlsNtdYSgVdYXg1nzHX4sZx
	wAte1uRxGl8Zec8CN3c07S5mv1sYVke18K7XCRaoZw0uqyQNgQoUlDveBvv2SXcLzKt1KumYlT3
	lEbAqxbEFo05F7GwJJM4CWCL/1MX/lZGsP+Utb
X-Gm-Gg: ASbGncsNJ7S4bvtD7oanerQHPnvndoZlGPPkC5RAn7jtYjBJ30SnmE9VCL8L+5gw3M5
	s+xU2x55xOKhIMWg7dVfwcX/h2mzc0Hnj2zbugww03I9O/sRwic+9Wl9fFw==
X-Received: by 2002:a17:90a:c88e:b0:2fa:20f4:d277 with SMTP id 98e67ed59e1d1-2fbf5c59edamr17083879a91.24.1739524815982;
        Fri, 14 Feb 2025 01:20:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV70tYKaoD72ZWgJewS3S3Ws/yTe5Co7t1AkVMiygQbOPGvw6IrjqyLyAEgiPWE34Qlyn+BspH/JPNCc6Sah8=
X-Received: by 2002:a17:90a:c88e:b0:2fa:20f4:d277 with SMTP id
 98e67ed59e1d1-2fbf5c59edamr17083840a91.24.1739524815700; Fri, 14 Feb 2025
 01:20:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Feb 2025 01:20:15 -0800
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <20250213105231-mutt-send-email-mst@kernel.org>
References: <20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com> <20250213105231-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Feb 2025 01:20:15 -0800
X-Gm-Features: AWEUYZkLDCiAVkg75a5t11ITS9fRDi5xZ4oLEnr_uyiN6ZHVdlUxn8cPTzWG8SU
Message-ID: <CAAiTLFViXr7gVPd3oRhfHSnUxxexPDEJ-MJJOuFrctrr+XvTfQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] virtio: obtain SHM page size from device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, fnkl.kernel@gmail.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, Feb 13, 2025 at 04:49:14PM +0100, Sergio Lopez wrote:
>> There's an incresing number of machines supporting multiple page sizes
>> and, on these machines, the host and a guest can be running with
>> different pages sizes.
>>
>> In addition to this, there might be devices that have a required and/or
>> preferred page size for mapping memory.
>>
>> In this series, we extend virtio_shm_region with a field to hold the
>> page size. This field has a 16-bit size to accommodate into the existing
>> padding virtio_pci_cap, simplifying the introduction of this additional
>> data into the structure. The device will provide the page size in format
>> PAGE_SIZE >> 12.
>>
>> The series also extends the PCI and MMIO transports to obtain the
>> corresponding value from the device. For the PCI one, it should be safe
>> since we're using an existing 16-bit padding in the virtio_pci_cap
>> struct. For MMIO, we need to access a new register, so there's a risk
>> the VMM may overreact and crash the VM. I've checked libkrun,
>> firecracker, cloud-hypervisor and crosvm, and all of them should deal
>> with the unexpected MMIO read gracefully. QEMU doesn't support SHM for
>> the MMIO transport, so that isn't a concern either.
>>
>> How the SHM page size information is used depends on each device. Some
>> may silently round up allocations, some may expose this information to
>> userspace. This series includes a patch that extends virtio-gpu to
>> expose the information via the VIRTGPU_GETPARAM ioctl, as an example of
>> the second approach.
>>
>> This patch series is an RFC because it requires changes to the VIRTIO
>> specifications. This patch series will be used as a reference to
>> propose such changes.
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>
>
> don't you want to negotiate the page size with the
> driver then?

It's not really a negotiation. If the device presents the feature, the
driver must honor the page size, either directly by rejecting or
rounding up allocations, indirectly by informing userspace, or both.

If the driver can't accomodate to the page size, it must refrain from
using the Shared Memory Region.

Thanks,
Sergio.


