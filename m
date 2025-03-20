Return-Path: <linux-kernel+bounces-569919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D197A6A983
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627C3188A671
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B121E500C;
	Thu, 20 Mar 2025 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqhnBccL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0631E1022
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742483448; cv=none; b=YMfqET6XoydSHiCx7uEpOG+SxkP7+k2RTiRGWA3XUFr3BLMBzSD2+IJMoz3nC4vb0WoMMnd9dj1Oj14ktxNz2v8HgCcapQTrqDNyWQGi7MiIIrq3/bZ42lmPPk5ys+VXN1UxGXVKDNwSmqmKTjaWn9Ouk68UiKzdwxcEGXhtVDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742483448; c=relaxed/simple;
	bh=wPzCW++mf4BmPY5ZUsq+1T2Ca14nuU9d4Jf4myQk9qs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j12h66EeXxX54nz4tOUiDQcf4d47bkOH0UCi0eA9z1p377Z+NL2OYZInM0QyGF7LUEHkvtnsCG/juCNJZT9aZ2n61tjlCGATjdcvwh8Pfn4b6H2r8BTD025sQC0i0yS9VGODn5WdxzSetpzJybaLQawQ/14Owu6HCZVFme19DBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UqhnBccL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742483444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9pdXhnbmPzOM0AIBWql2puAsWwJXN4dUsFoBkqLS8U=;
	b=UqhnBccLtMHGVgjigIf16ZMjz1eK5+LSICLJJjLvlPBVRVoqqA4YVIiTKlvNhzTNkHSy1R
	99u3xqLGfVxmsfHZ+OlfuWvx4618LYp5CYgUVwhx3YWjqSml5kFNZDwJOjlmRITPawcy/W
	J7fBctl5+1xS6Jbp9Olb2sqIkURoojM=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675--JjJreyFOROX74p8uHEVGw-1; Thu, 20 Mar 2025 11:10:43 -0400
X-MC-Unique: -JjJreyFOROX74p8uHEVGw-1
X-Mimecast-MFC-AGG-ID: -JjJreyFOROX74p8uHEVGw_1742483442
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d4352ce228so982565ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742483442; x=1743088242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9pdXhnbmPzOM0AIBWql2puAsWwJXN4dUsFoBkqLS8U=;
        b=Vo27VDMcMhIU/1NEdACcvRG08q1wpPSk1S6bFhJILbmQB0rlBX/yqfFMKN3bgBposg
         ZEsKVqx8qTv/20F5LxmkMqsJa6bo2hBkz64ggZetXQgmw7V3h7WnlFXAxIyi9PA96fVC
         nD45F9W+8TSnRUEfagkIbvYlug1ke011Ki3PWfbx/aEL6KE5XO12vL+JRg9BK6kIPAx+
         YONGvV7XIFB7d/7SRzl7LAZs6ahUl0QIwIsv4XW8a/cC+wUkhOzwDt3HhwLLtqSUZvzO
         HQfHDVL5uTcbJGPzM3sHmPF8f7I7NkBwNUSRQ+rATwX+TT7ff3pCdQWWHNfK8BtWmDtX
         LgbA==
X-Forwarded-Encrypted: i=1; AJvYcCWT/f5zvOXBqYV+mOWhxHxqYHLko0of+sZI71rqbObXh67VDlGK7vcKNPu9nSqIJ1Gqggbwh+uR51GG4o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ5P06To1riiKG88VtyHbBxxZDouZZhFEL0/JWmRiSPud5fWyT
	KyuoqtSDJIZJ1j0z8u+SKXaMQR1Ut/43nlJ9guE9zBBFIHYR7d4Xf+8GzHfbvMOmMHHPuHpKHBk
	Msgvzp2kUvpOIsgcFQdHYXlXdjN1M6xq4z4vjHjcSNS+IIVsri2GPeevSubs0MQ==
X-Gm-Gg: ASbGncv+s8XBY5INgJ7jrqigczWDW4XAn90DzhsZ3uuwY3f6Of2DKUUAllCW5y995Xb
	pqxKttFKohxx5EJlkWFHFLptA6mR6a7dicZ2DmZWv7D1qjNrmxL6oZjJzCu6gbCqheBiNSNQ2eY
	czumGDFtZGCGbT7+GplU0j9PAhXv0xEa7VEaIdFO5ncp7YRaREjN+gy3Ak8/Uq7kMAK6WoFagRb
	qy6JAtEn4TeM/9c87md3M5YlGB3lF+4ybsk9S/DThMOyidAchRez9l2SORQeVEwfEOfVaZp7Lpj
	l59YAbFTwRUVDS2NIAg=
X-Received: by 2002:a05:6602:3fcf:b0:85a:e406:5836 with SMTP id ca18e2360f4ac-85e13a1a699mr239603939f.5.1742483442460;
        Thu, 20 Mar 2025 08:10:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEudBv7Mx9Yq9q7Bszz6bRWBRPdReFNojD+/x4jBOY4Ws/hoEASf13aNS02c75grP2Hs+mc4Q==
X-Received: by 2002:a05:6602:3fcf:b0:85a:e406:5836 with SMTP id ca18e2360f4ac-85e13a1a699mr239601539f.5.1742483442071;
        Thu, 20 Mar 2025 08:10:42 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85db8777e19sm348840239f.16.2025.03.20.08.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:10:40 -0700 (PDT)
Date: Thu, 20 Mar 2025 09:10:38 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?TWljaGHFgg==?= Winiarski
 <michal.winiarski@intel.com>
Subject: Re: [PATCH v3 1/1] PCI: Fix BAR resizing when VF BARs are assigned
Message-ID: <20250320091038.219fe7d1.alex.williamson@redhat.com>
In-Reply-To: <20250320142837.8027-1-ilpo.jarvinen@linux.intel.com>
References: <20250320142837.8027-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Mar 2025 16:28:37 +0200
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
> If SR-IOV is enabled, disallow resize as it requires releasing also IOV
> resources.
>=20
> Fixes: 91fa127794ac ("PCI: Expose PCIe Resizable BAR support via sysfs")
> Reported-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>=20
> v3:
> - Check that SR-IOV is not enabled before resizing
>=20
> v2:
> - Removed language about expansion ROMs
>=20
>  drivers/pci/pci-sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index b46ce1a2c554..0e7eb2a42d88 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1556,7 +1556,7 @@ static ssize_t __resource_resize_store(struct devic=
e *dev, int n,
>  		return -EINVAL;
> =20
>  	device_lock(dev);
> -	if (dev->driver) {
> +	if (dev->driver || pci_num_vf(pdev)) {
>  		ret =3D -EBUSY;
>  		goto unlock;
>  	}
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

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


