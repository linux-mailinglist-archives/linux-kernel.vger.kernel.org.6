Return-Path: <linux-kernel+bounces-571563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E98A6BECB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775D2189E004
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CAD22D4C0;
	Fri, 21 Mar 2025 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1xrA7UX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00EF1E98ED
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572370; cv=none; b=J94evMGLyXK2BTFqkE7hF9Ay5jVXPc+e67Kui5YPc4QXIEtCsBBGeIGjgWQ7gBkd5R+QX7Jm1JsoKUXkHnIokh8uMHmOmv21hj0YnlUvLI2vUfR7l2lQ6on5BTa6FUV8uIwVeR56x5FMAsB0ynHybI+kwhO0BPtgVkwqyj1feII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572370; c=relaxed/simple;
	bh=GnYJNN30ArioqBq84YCpxjxypr/yQcxXAVwcizPHgMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9EGYDSVlr1Surjhq9e51u3u4DtRNOxNsX1D4Lk1r5m4gpVZQ0lo+tVGuEU7Vxo97dfdfGn/UxTZxt0Ved5kslknlJkuci+tIbVH4NYndqAYGN9W1weT2gYgsW0eFd+fY5AaspusE18YJwnaw+JOb8reM+iiVlqJ0NYEIX6WTzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g1xrA7UX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742572367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lw4tIV8t2velBqSGDFXs1U2au71hmJlMHn//DKDjNqU=;
	b=g1xrA7UXuqXVUL8xVVug2a3HjtBnCL2Fo/gYGPayOkm3msMU1Hxe1BmOmfbe+RWgWhSUuy
	yZznu3ua2xHfOCReFTGDV9vb82fa5xD4Zx9Vp0n8HgaEJor2G7nib/aI+A8Vw5mVVEJ2sT
	LWpzGUO6HzLNHjeBwNo1QYMzOqEw4Mc=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-G05V_cbNMtaJK8oCgL8BYA-1; Fri, 21 Mar 2025 11:52:44 -0400
X-MC-Unique: G05V_cbNMtaJK8oCgL8BYA-1
X-Mimecast-MFC-AGG-ID: G05V_cbNMtaJK8oCgL8BYA_1742572364
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85df453e4c5so35208839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742572364; x=1743177164;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lw4tIV8t2velBqSGDFXs1U2au71hmJlMHn//DKDjNqU=;
        b=v+o/EAx/TvpoSdeYgSOMteK0mnSKXJa3veGmtokfCs14qCozmhBizOuxv6KEUpBBnN
         IhhWatysnPUMwpXpfYim9o7LU1zNOUVXjkzn769rYEdMOozLa98NZArM+RIHXrOI0GG8
         TWMsauraEfviFg+IpU4f9Gxi25Ql/aeEvorM1wVAVV2JLv5R+OhxwYwKY0r1D+wED2g3
         0P58FV3Znf4gvFpKzG8dL3EPbvRlbZAJkVonWQRlHdr99Aw+8kyK5Yu5iH4ljbZRmeOq
         J80LGfNAsMXdp5ENYkhuD8q8eUFAH+QgcxRs5bk+rGvmwpWwtDnYrdZjDIaZJWmsiJWS
         7cQg==
X-Forwarded-Encrypted: i=1; AJvYcCVMz6OHgAto3EaezFIfZB0TzONIzYPdHOOEfz6Kbok1DoHGb89X+C0939yyAo5GAUvgpWLHE51s7r4NWpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwONMQW5l3n4gLb1lUCm/O2YyTcKZ+J6VRmxttggO2Q7iSY5MAI
	OzXb8i0uz6WhMupjwP4694B9ej6DJ2rjwSomRQbdK2VceiYFuIVM6fOpYZvY/sI95lgfGhmYsNz
	KlOVbIR3V0yCoU2253fRQQ2JioWdPNaED05fgXqCywjeu00X7S15iIcdDRG9Hzg==
X-Gm-Gg: ASbGncuOJer8/fWHUs8ljbj7XkcXjtCyEDeArey1XDrBZpHs8dG/Kd5844PSRHfGpFb
	azRV5Xrnqih1lep12y+M0NATRPvhGKL8NzG8wfdX4GHPAPvgx2ul10CdSLaAzODeMW7iCw6cG6w
	R0fBushRvhwLjiqL/1vuEi7PyKTYmvlhxiQnprRKmui94jpZl5j3SxsCdpplRR97v+KdLTftjuj
	s1iagCAOfTI9EEbfF8vHLhcxIORvqPDHPK5GEtSzm/kAbuVB1r4b01VDmlu3EcGfwDpmLQC1pzP
	87tcN/+LUmIRI9QiIW0=
X-Received: by 2002:a92:cd87:0:b0:3d3:d187:7481 with SMTP id e9e14a558f8ab-3d59c331683mr416335ab.1.1742572363828;
        Fri, 21 Mar 2025 08:52:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNF0rfCObrqaWNyBO2CmHGiB8P4GBb5NFORtVt9K+hAaNEXXDIxgqmXZW65xMhulGgmm8UVA==
X-Received: by 2002:a92:cd87:0:b0:3d3:d187:7481 with SMTP id e9e14a558f8ab-3d59c331683mr416305ab.1.1742572363420;
        Fri, 21 Mar 2025 08:52:43 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdb3befsm493367173.24.2025.03.21.08.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:52:42 -0700 (PDT)
Date: Fri, 21 Mar 2025 09:52:40 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Longfang Liu <liulongfang@huawei.com>
Cc: <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
 <jonathan.cameron@huawei.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v6 5/5] hisi_acc_vfio_pci: bugfix live migration
 function without VF device driver
Message-ID: <20250321095240.40bf55ec.alex.williamson@redhat.com>
In-Reply-To: <20250318064548.59043-6-liulongfang@huawei.com>
References: <20250318064548.59043-1-liulongfang@huawei.com>
	<20250318064548.59043-6-liulongfang@huawei.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 14:45:48 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> If the VF device driver is not loaded in the Guest OS and we attempt to
> perform device data migration, the address of the migrated data will
> be NULL.
> The live migration recovery operation on the destination side will
> access a null address value, which will cause access errors.
> 
> Therefore, live migration of VMs without added VF device drivers
> does not require device data migration.
> In addition, when the queue address data obtained by the destination
> is empty, device queue recovery processing will not be performed.
> 
> Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> Reviewed-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  .../vfio/pci/hisilicon/hisi_acc_vfio_pci.c    | 21 ++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index cadc82419dca..68b1c7204cad 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -426,13 +426,6 @@ static int vf_qm_check_match(struct hisi_acc_vf_core_device *hisi_acc_vdev,
>  		return -EINVAL;
>  	}
>  
> -	ret = qm_write_regs(vf_qm, QM_VF_STATE, &vf_data->vf_qm_state, 1);
> -	if (ret) {
> -		dev_err(dev, "failed to write QM_VF_STATE\n");
> -		return ret;
> -	}
> -
> -	hisi_acc_vdev->vf_qm_state = vf_data->vf_qm_state;
>  	hisi_acc_vdev->match_done = true;
>  	return 0;
>  }
> @@ -498,6 +491,13 @@ static int vf_qm_load_data(struct hisi_acc_vf_core_device *hisi_acc_vdev,
>  	if (migf->total_length < sizeof(struct acc_vf_data))
>  		return -EINVAL;
>  
> +	ret = qm_write_regs(qm, QM_VF_STATE, &vf_data->vf_qm_state, 1);
> +	if (ret) {
> +		dev_err(dev, "failed to write QM_VF_STATE\n");
> +		return -EINVAL;
> +	}
> +	hisi_acc_vdev->vf_qm_state = vf_data->vf_qm_state;
> +
>  	qm->eqe_dma = vf_data->eqe_dma;
>  	qm->aeqe_dma = vf_data->aeqe_dma;
>  	qm->sqc_dma = vf_data->sqc_dma;
> @@ -506,6 +506,12 @@ static int vf_qm_load_data(struct hisi_acc_vf_core_device *hisi_acc_vdev,
>  	qm->qp_base = vf_data->qp_base;
>  	qm->qp_num = vf_data->qp_num;
>  
> +	if (!vf_data->eqe_dma || !vf_data->aeqe_dma ||
> +	    !vf_data->sqc_dma || !vf_data->cqc_dma) {
> +		dev_err(dev, "resume dma addr is NULL!\n");
> +		return -EINVAL;
> +	}
> +

I'm not sure how this fits in based on the commit log.  IIUC, we're
actually rejecting the migration data here, which will cause a
migration failure.  We're also testing the validity of the data *after*
we've actually applied it to the hisi_qm object, which seems backwards.

Are we just not processing the migration data because there's no driver
or are we failing the migration?  There shouldn't be a requirement on
the state of the guest driver for a successful migration.  Thanks,

Alex

>  	ret = qm_set_regs(qm, vf_data);
>  	if (ret) {
>  		dev_err(dev, "set VF regs failed\n");
> @@ -1531,6 +1537,7 @@ static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
>  	hisi_acc_vdev->vf_id = pci_iov_vf_id(pdev) + 1;
>  	hisi_acc_vdev->pf_qm = pf_qm;
>  	hisi_acc_vdev->vf_dev = pdev;
> +	hisi_acc_vdev->vf_qm_state = QM_NOT_READY;
>  	mutex_init(&hisi_acc_vdev->state_mutex);
>  	mutex_init(&hisi_acc_vdev->open_mutex);
>  


