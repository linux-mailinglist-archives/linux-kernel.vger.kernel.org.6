Return-Path: <linux-kernel+bounces-561631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88DDA6144F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56CB87A631E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5B51FFC66;
	Fri, 14 Mar 2025 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZe/xTMI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8159A201023
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964218; cv=none; b=m8Da1NbpVtCmuuqJJJOeBMdJtWxFqoWs0kl5T4o2P+iWXoi5IfPcsAHXljxmf9Oq7ElWiv10LzoB/AccnjF70+6/5bVzwqz/XWJMdG6GzMoRkOF24RJDEmhz/SybiyKNZPSCPF8kLQRZEMAOknny13PYkkKkXsog7Z/K4As6aUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964218; c=relaxed/simple;
	bh=tZ3aq/CqtI9LEuKu/oITcS3koxM8zmb4/pga8QNlXiY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V50Sz5SNLN7xWVM/GzymYF38v+8JzXREdgI95ecLphKSKBFkyXYGPiBBa3hWLbtgNbERrUq1eLZ9h6uUT00O8xA6c1raq2acZyAtugwJn6m2Lfh3FME0AkMYME8aTcEBSdsyRk5eqdTPAeNcXmhykx368gVKFSPjizCgpzlODNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZe/xTMI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741964214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PlLbRQBxXXDhyAGBx3ZpRwbhQHfFzpByYsCXiv2nj+A=;
	b=LZe/xTMINsGGCPBmoJeAEqvma1IcVtcsXxIcUoi+r2AnxyUYYc/D447y7ey3MzqoOyUrnB
	08kCrL8CFWkFatmYpC6l93Ow9D6VSwIhpK97c2wTwoermyADbSO6tghRo67lidx6lL4Qv4
	iwAFSWHIAaUKJi9xDYETly77+aG8SNw=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-eE3zNA93M1q8xhl5kpu3UQ-1; Fri, 14 Mar 2025 10:56:53 -0400
X-MC-Unique: eE3zNA93M1q8xhl5kpu3UQ-1
X-Mimecast-MFC-AGG-ID: eE3zNA93M1q8xhl5kpu3UQ_1741964212
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-858755ba77cso32350439f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741964212; x=1742569012;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PlLbRQBxXXDhyAGBx3ZpRwbhQHfFzpByYsCXiv2nj+A=;
        b=PBVM/rNfTDpubfjupw7Xnuj2DgnX9aYk49YsSAkMUtm1fUfQzngz8QwAkaPXEM20X2
         LbdsF+fiUr5ZtBJsCpYkJ1oytuB1DcWcYWKmSpk+Ztew8v0c+GYcZlXf867nedeaNC/q
         FpN8MluG8aJJyNJxPSm2rrPVh+Sy72HcabonqR/Y3oPSVUv07QjEYK5ULGOy5C8AJYce
         MDIDmvCemDfJvJkEtKvDrZlFU13UQGALWM/nFpVlTEhU5Iy8sqgGERcBuQBaRZjBkPnP
         rm34jd1EstZIdzikI22ASakoFm2TXmIfYqGLH5YUHmsmtl/E/lWw4tHS9aH3BSijCvVa
         YLcw==
X-Forwarded-Encrypted: i=1; AJvYcCWTI1+9oWRlK5kPQVb3xrPVLkY+zoA47Rr85cTCYnOedXudS2s+YyzRlTS1j9k3Fu2S2eH5n6VRVB/bZxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBHw89ShvB7AN5Ctil47rSHtlIvtgq520mZPwI5ZLCTApp1m6m
	Gayh+hvi23aFRchv5uYD284Y3d+PfTZMJi7SxwjzXm79U6b6FLD1eMrUoCSmMksgwjfOQMwzeaB
	xDwUPhMyu/ZNHKLRg88kZesEdaqTXwzzYqb43nlq9ZQtdFeUk0LzBQ7ymlmlp6Q==
X-Gm-Gg: ASbGncv5Gbbb5oqtLlFVPdHdGQT+EFk3c1XRXBQTl+q6ahFN/vALYVG0To5hT7iXKnW
	aEmNTdrFSJfHeE1KzppAINN/RrfBaNlxdWTGlDNMbj7TrbFrxvT/ebA4970vJTPtYCwD2n6MWKF
	uW+pY3X0zc1jb0/joAGcSd9891I2d5L7TOI/aby9Ko+asHmylQAGBAW/0xQjC39JmfNVo8VP1Cu
	wWw3u5zFgV78CCpghNTt9GcRbjPkrQRmZmeTd0MdQmSBtHNTx7+0AdEYqTqXTe9p4Cz95yF0z/E
	lJNm7r/Paeb4g9FAm74=
X-Received: by 2002:a05:6e02:3188:b0:3d1:9236:ca49 with SMTP id e9e14a558f8ab-3d483985596mr7894075ab.0.1741964212435;
        Fri, 14 Mar 2025 07:56:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0TnXNtM95cSC0zsNjgkP0enen7RRVJxKsA6Xlp8a+oLFTIu0ca2olQqG/k7wlr6lKNf2GyA==
X-Received: by 2002:a05:6e02:3188:b0:3d1:9236:ca49 with SMTP id e9e14a558f8ab-3d483985596mr7893995ab.0.1741964212116;
        Fri, 14 Mar 2025 07:56:52 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f263816d80sm877731173.124.2025.03.14.07.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:56:51 -0700 (PDT)
Date: Fri, 14 Mar 2025 08:56:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?TWljaGHFgg==?= Winiarski
 <michal.winiarski@intel.com>
Subject: Re: [PATCH v2 1/1] PCI: Fix BAR resizing when VF BARs are assigned
Message-ID: <20250314085649.4aefc1b5.alex.williamson@redhat.com>
In-Reply-To: <20250307140349.5634-1-ilpo.jarvinen@linux.intel.com>
References: <20250307140349.5634-1-ilpo.jarvinen@linux.intel.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  7 Mar 2025 16:03:49 +0200
Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> __resource_resize_store() attempts to release all resources of the
> device before attempting the resize. The loop, however, only covers
> standard BARs (< PCI_STD_NUM_BARS). If a device has VF BARs that are
> assigned, pci_reassign_bridge_resources() finds the bridge window still
> has some assigned child resources and returns -NOENT which makes
> pci_resize_resource() to detect an error and abort the resize.
>=20
> Change the release loop to cover all resources up to VF BARs which
> allows the resize operation to release the bridge windows and attempt
> to assigned them again with the different size.
>=20
> As __resource_resize_store() checks first that no driver is bound to
> the PCI device before resizing is allowed, SR-IOV cannot be enabled
> during resize so it is safe to release also the IOV resources.

Is this true?  pci-pf-stub doesn't teardown SR-IOV on release, which I
understand is done intentionally.  Thanks,

Alex
=20
> Fixes: 91fa127794ac ("PCI: Expose PCIe Resizable BAR support via sysfs")
> Reported-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>=20
> v2:
> - Removed language about expansion ROMs
>=20
>  drivers/pci/pci-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index b46ce1a2c554..0c16751bab40 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1578,7 +1578,7 @@ static ssize_t __resource_resize_store(struct devic=
e *dev, int n,
> =20
>  	pci_remove_resource_files(pdev);
> =20
> -	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> +	for (i =3D 0; i < PCI_BRIDGE_RESOURCES; i++) {
>  		if (pci_resource_len(pdev, i) &&
>  		    pci_resource_flags(pdev, i) =3D=3D flags)
>  			pci_release_resource(pdev, i);
>=20
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b


