Return-Path: <linux-kernel+bounces-571558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D25A6BEBE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6BC2189D547
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D91227E99;
	Fri, 21 Mar 2025 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjzH7JmN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556671E22FA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572320; cv=none; b=oL2KHF8rROpcTvUQVtGqY3ZBqsuL2Aas9POaMjkIgUI4lkBCZwdp3Au7pBZ9FJSBGTcBlkcPNLPc0gIMtzFsUjlFv3skGHRbJGeRHiEYFcA1TcQIoRdllPbMqG9X8QIsu1JqCG/B731UiqOjCoj2HMAkUdUzGf3iObgog9GEWjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572320; c=relaxed/simple;
	bh=NfMtNzSkWHRadYC7fD0IETSJr8axVNhMTHgjTfoLlLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gv+HSE8FlDx5+70CzEpLAZQ0cbjepkImgW5ZzGgh5NJ2+FBkg/OKEcx6ktuTo0cQgWDYuaKS5KEuynqKwF2+oUNGc15mX2uYwMNwTNPZb5AUoVSQ0tm1gV4S90qWUWswwGKvfIqRv63KF2peVA4vMgLpI7tWGjPYM/Z83cggEVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BjzH7JmN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742572318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PoG6USFI97OiT4qS0soZ/PVlv737qpSqxLyCgHs7OOc=;
	b=BjzH7JmNE4zkhxSCOrWG+23gui97lVWL5wc58SNy/9ZSusVEv/OPP0qgy7qEbf92UWSuVu
	w/LMs20WhVk4q6AsfL8eVQRSlPLbBJ9d9wDqtNNJexNGNUI9YUm2oZCOROVMlpOpI1zaXP
	QK2PJwUyNZgZdSmZe/tJAnJod7VMWqE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-6f2Akc6_NLuN1HJwX1IREg-1; Fri, 21 Mar 2025 11:51:57 -0400
X-MC-Unique: 6f2Akc6_NLuN1HJwX1IREg-1
X-Mimecast-MFC-AGG-ID: 6f2Akc6_NLuN1HJwX1IREg_1742572316
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85b5ea50d28so20348839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742572316; x=1743177116;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PoG6USFI97OiT4qS0soZ/PVlv737qpSqxLyCgHs7OOc=;
        b=D51aW2hNcnELcQSsXzEPYQYWUIIMKpl29+5VQHRc7sWBXX8Lzj9DKcsy5ZYdqiL7yt
         JWUxIr5avi34Fpnmn3qtkQuKdHH8w37TkB2lnhLdFKmWh3FJUaK7OsDLy+ap+Utq7X8n
         uGHKjQego4EAHIMr37kPy+PEP/4dOCoCKQNlIPEMtT0pf8mh9HznnRi/zvGhK+WKrOc8
         8txntYAdKxg+YnlK+ESrbJpqmVVQ1UWEchuMldtFyaEVTSBvG4j94lcvsUAb6IrCsc5i
         pKClSYdnu7NnkBNHFq+TYkHrf9AhithbiaTWBOwQM7/9CWxXfb5m2yWQPh3ksrw3U5L2
         ks5A==
X-Forwarded-Encrypted: i=1; AJvYcCUusxdFgUfb6sox3hadfQlcqnpmfomKzIhvt3eG+W1SG/F4zhDNfMM1kmu86rkjQMJ5cUaY8orxW5iP/sM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHqLvVaNNenqDn2VCLzRbsPTaw8HG1WC09lNdvYBgH+JS4V9e0
	8DlVkR7tCdAWq3qFRowGhzdonrcrq3+LkT8G+rFd4HCyAJaFVa3ZRM+sRlTbsv345bwEsM1ZFId
	H/5MlxdWilwY0HEl/9kbYY6DWGotdGAOEv5CxVOGmqIdTZK18AXru3T8ovrQPWQ==
X-Gm-Gg: ASbGncsfQjbSzSrnZqsgytNsa0ZhpZXLsEXLCEV9bUa/43BTX77A4JyC8ZD9uw5c1lP
	w8OXMf+p3ba6cWSnyN9eGaZGS9Xcwa1IALBQ/TD4ubwm8pup4vN+dvnE+NeMF0JEpbhvo7p9/E2
	j44pa4LPsRa2tw0r1S3hRo5zBbqTQUANcVk7hROe3W4dnZfjoDtengD9hS9Wp6nckQMYT4MO0jt
	xX5tk42ZszdpimVJ9NFfkMVhlNGtLeuecUpTsjAg69Gcv1l/K5Nr4QxIapfVgMIcc+4WXfjZ9yP
	iDYJLC2J1UfKdcX/KW4=
X-Received: by 2002:a05:6e02:1fcf:b0:3d4:3aba:a8b3 with SMTP id e9e14a558f8ab-3d596167e51mr11353055ab.3.1742572316122;
        Fri, 21 Mar 2025 08:51:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhjsy/Vs9brKKBwg2VaxEmCIn6GZl2yXbGu+lZVysKgFANqEcGieBp6AoQ0WZ5eKg1UbhSsw==
X-Received: by 2002:a05:6e02:1fcf:b0:3d4:3aba:a8b3 with SMTP id e9e14a558f8ab-3d596167e51mr11352945ab.3.1742572315661;
        Fri, 21 Mar 2025 08:51:55 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d5960ceb59sm4865145ab.48.2025.03.21.08.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:51:53 -0700 (PDT)
Date: Fri, 21 Mar 2025 09:51:50 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Longfang Liu <liulongfang@huawei.com>
Cc: <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
 <jonathan.cameron@huawei.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v6 4/5] hisi_acc_vfio_pci: bugfix the problem of
 uninstalling driver
Message-ID: <20250321095150.7fe81186.alex.williamson@redhat.com>
In-Reply-To: <20250318064548.59043-5-liulongfang@huawei.com>
References: <20250318064548.59043-1-liulongfang@huawei.com>
	<20250318064548.59043-5-liulongfang@huawei.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 14:45:47 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> In a live migration scenario. If the number of VFs at the
> destination is greater than the source, the recovery operation
> will fail and qemu will not be able to complete the process and
> exit after shutting down the device FD.
> 
> This will cause the driver to be unable to be unloaded normally due
> to abnormal reference counting of the live migration driver caused
> by the abnormal closing operation of fd.

"Therefore, make sure the migration file descriptor references are
 always released when the device is closed."

The commit log identifies the problem, but it's generally also useful
to describe the resolution of the problem as well.  Thanks,

Alex

> Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> Reviewed-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> index d96446f499ed..cadc82419dca 100644
> --- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> +++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
> @@ -1508,6 +1508,7 @@ static void hisi_acc_vfio_pci_close_device(struct vfio_device *core_vdev)
>  	struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
>  	struct hisi_qm *vf_qm = &hisi_acc_vdev->vf_qm;
>  
> +	hisi_acc_vf_disable_fds(hisi_acc_vdev);
>  	mutex_lock(&hisi_acc_vdev->open_mutex);
>  	hisi_acc_vdev->dev_opened = false;
>  	iounmap(vf_qm->io_base);


