Return-Path: <linux-kernel+bounces-233076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948DC91B1F6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B74CFB25408
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1F91A2542;
	Thu, 27 Jun 2024 22:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNHUFCvz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C1D19EEA9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719525956; cv=none; b=qWyouOc5dierzfB32YAtQP19jtbcXgGnnnA6s/mLiLcPeorgStlBFIfpJiWdhw6hiv2O7VpwGoEAhadiDy1NIASKvnUk3dieU6dT0FDmJKYUS237H+kd8tgvDgOQpcNFt624sBgufgJRJBMeXu6HIlvE0wgD9dYjnZ1SkkPWL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719525956; c=relaxed/simple;
	bh=GPka9uH0tbnuzJFPMYjQ/2ZBGJ77SVwzIe7FH4suRuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7mHYcr1witGuJss2ZSxcePilI67h51g7Tj5Qgd4QosfpxRBNo4uO20CaQ/ydAU+iDwv448EbGn5O0p1FeuDXwES9dNhyxXnytoh6d6UCCBlFr+yOgPqoUxPF+Tt6xKx2PaBSXort6vdcV4wOYbIeGoIKSwEgo52COYvdJkdYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNHUFCvz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719525952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X1trEn5o04941xk6vp/8nx318y7mfTBtf0H5o3zSA70=;
	b=HNHUFCvzRObCsSSJjbBzEznMv6Wy02YylIPxeMAR0xVR6W//g2AUg7Fs7QxEns0wPw2iB9
	qU+CKdFoatzW/ojhZTIdieG845MGIor7ct4waBNDRUJaiTWAg0UKpMYMslTd3Rb3BXko30
	UNUYV12WvwOcjbGC8XdpUuTryVFzTLo=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-C6W0P6apMOmVmttthlYfSA-1; Thu, 27 Jun 2024 18:05:51 -0400
X-MC-Unique: C6W0P6apMOmVmttthlYfSA-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3737ee417baso58335ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719525950; x=1720130750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1trEn5o04941xk6vp/8nx318y7mfTBtf0H5o3zSA70=;
        b=m06UfmMYhZXkSbv1qp1aUdaMvdjjLdFy7VuHjQHHCj3oOsl9+XyTWyoq6jQCPwLXWO
         kDVOFVqO2erCjpLrK2DOJq/8EI5pXdQSQJWboN3v7BKURfQdsLKmlf64IBPzpfwQkk/2
         bqDz3KOpQxJyInos8BTwQd2sYqmM7NVyvYkpxHKfxqFiG/IQ+QrcHCp5B9NLn2Lg/bfX
         eVut960JPELeA2DDeMSvnGYcuqQLjshToS4RjBXi9OPvKsHHSLl1E54ioM+Hpc+qAvFk
         IwYt/SaLmNzDcmXqBe6WYGNSYRR1ijf75tk9Utbzbfa1K34cZ1t6fqfq+go9k4wgRERI
         cZJw==
X-Forwarded-Encrypted: i=1; AJvYcCVPTs/I3ZKzGNDw7t/SV36djJ8DBeZnKxtjdiYUrArW1DvAMtTyObMuO3DCLbSAEZtOSomg9Bq53IPoYtxqFpmvTm5tnAeiqo5aBkrd
X-Gm-Message-State: AOJu0Yz/KG8Sb/sVgQTrphpFgmaPv53nxJVvsxw/9zDetfOCyqQvG42C
	CtqG7uDTcrbYFtnEz7JO4MjSMYfXQDjwPMLXmnu8TP6+/Sb0LW5+ozLhlyPDzGJnf6c2w543GH/
	BoAIpv6hzpwiBdOkhnpCn8JhmIV56lQ3MSGjmZnazykyv8IqU6lnW29K129KN+g==
X-Received: by 2002:a92:d98c:0:b0:376:3fad:bb82 with SMTP id e9e14a558f8ab-37998213149mr19053435ab.2.1719525950607;
        Thu, 27 Jun 2024 15:05:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWyN9z1P+4hFoDr0ILN126oWRY+ZLqxo7RK8d3Xv3l6qhXSmy135HJFuBTabIJvwAzxzW0Hg==
X-Received: by 2002:a92:d98c:0:b0:376:3fad:bb82 with SMTP id e9e14a558f8ab-37998213149mr19053305ab.2.1719525950275;
        Thu, 27 Jun 2024 15:05:50 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73e084c8sm161260173.80.2024.06.27.15.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 15:05:49 -0700 (PDT)
Date: Thu, 27 Jun 2024 16:05:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Gerd
 Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v4 3/4] vfio/pci: Disable mmap() non-compliant BARs
Message-ID: <20240627160547.2879c6b3.alex.williamson@redhat.com>
In-Reply-To: <20240626-vfio_pci_mmap-v4-3-7f038870f022@linux.ibm.com>
References: <20240626-vfio_pci_mmap-v4-0-7f038870f022@linux.ibm.com>
	<20240626-vfio_pci_mmap-v4-3-7f038870f022@linux.ibm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 13:15:50 +0200
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> When VFIO_PCI_MMAP is enabled for s390 in a future commit and the ISM
> device is passed-through to a KVM guest QEMU attempts to eagerly mmap()
> its BAR. This fails because the 256 TiB large BAR does not fit in the
> virtual map. Besides this issue mmap() of the ISM device's BAR is not
> useful either as even a partial mapping won't be usable from user-space
> without a vfio-pci variant driver. A previous commit ensures that pdev->
> non_compliant_bars is set for ISM so use this to disallow mmap() with
> the expecation that mmap() of non-compliant BARs is not advisable in the
> general case either.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 987c7921affa..0e9d46575776 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -128,10 +128,9 @@ static void vfio_pci_probe_mmaps(struct vfio_pci_core_device *vdev)
>  
>  		/*
>  		 * The PCI core shouldn't set up a resource with a
> -		 * type but zero size. But there may be bugs that
> -		 * cause us to do that.
> +		 * type but zero size or non-compliant BARs.
>  		 */
> -		if (!resource_size(res))
> +		if (!resource_size(res) || vdev->pdev->non_compliant_bars)
>  			goto no_mmap;
>  
>  		if (resource_size(res) >= PAGE_SIZE) {
> 

The non_compliant_bars flag causes pci_read_bases() to exit, shouldn't
that mean the resource is not setup and resource_size() is zero and
explicitly testing the non_compliant_bars flag is redundant?  Or does
s390 do this somewhere else?

The non_compliant_bars flag is defined as /* Broken BARs; ignore them */
so it'd be pretty strange if they had a resource size and we chose to
still expose them with read-write access... why wouldn't we just
deny-list the device from use with vfio-pci?

Also probably worth an explicit comment in the commit log why pci-sysfs
mmap support doesn't need to be bypassed on s390.  Thanks,

Alex


