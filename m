Return-Path: <linux-kernel+bounces-406779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2061F9C648D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F6EB2F241
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C609821A4B2;
	Tue, 12 Nov 2024 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CO+zcXrx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8D11531C4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 21:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731448250; cv=none; b=tL/4T5Z4qLimYNvVDhLjOt4ss3/i6m2wPx+9p/WuqpCKTtyejtp2vLB08QdL7sIqMh73EHq53/dCdVnt0YBTY+nPIWFsOaKPJ6q1AdeBV+wasDWcaIQtCGqQ5iqP9XPjUzvokQFeDULwlgADMcKE6RKtlAVKozKZwE+WggMUGp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731448250; c=relaxed/simple;
	bh=xm+Ll3JltSLMPgfmR8tv6c18m24LerQYmVmRFqesrUU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQwa1Eo1P45DRDY4XZ1aZV/P3xxqtkmziQ5ueZO1DwWSeWm96RMKlPJBvmTXECxrEvesXh/fNtj1blqE9RRiermOVmvNgKv5rnbJ+wu7qb5pxKk88cqoiukWe4U3XuhXLKsbKL19Bzx0NegQL88wDPZCJKMLD8sg4ZBbVForL6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CO+zcXrx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731448247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tfhiK9YYltYV+RS78G8mwLr7L+fFOTGjTFmv3VdeA1Q=;
	b=CO+zcXrxTmWr686ELQ5KH1OEQ9ZaUAboAlvfFa6ZlTBzUbpkLrOecQyY/3crb7DkCDvKpx
	1H4ZkmoJSsrI8CytxuU1ppN/IMmu4YTEn9+apYU3+c+fpSid6uUB/dmxdvXQO0C/fbWo+z
	ilEpNR2bDp0v+D7QXCCcwsBthA5edMo=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-zgXV83duOwiRStSQwoOctw-1; Tue, 12 Nov 2024 16:50:45 -0500
X-MC-Unique: zgXV83duOwiRStSQwoOctw-1
X-Mimecast-MFC-AGG-ID: zgXV83duOwiRStSQwoOctw
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83deec3041cso8035339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731448245; x=1732053045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfhiK9YYltYV+RS78G8mwLr7L+fFOTGjTFmv3VdeA1Q=;
        b=TSjX1YjFE6+3y2Tg9w5M/+5CA5KrxGk7wwcIhXGLU9A/KuV4RYvbP5atUjqDqC3/15
         Fl61Sbdzey145g67scqhNLgCFXd06B4tXP8/oA6CTf8qQu3vyEVxKaM2c7z9gZGINAoV
         CX3Dk0ZpcmwdQVdmn2MWhDnBNlaHsyIDjm1hDsbQWO7/LUcdX2HV9ht2vHwp58FugV7I
         C7JNj2RKfmr+Ja9/s3g3N12/ieyavtJsdQ8LOZ6hUf4k2KSZcS1Nq3TG+2LkVUj+qZES
         BpeehY3wnoNHGSoqiqACrxzdxdx6guWk0MyBE0IxbWLF8ujWN/tfahuQHHe/P2vQLcXx
         xphA==
X-Forwarded-Encrypted: i=1; AJvYcCXHfL+NYMaYqY+/iz32ffU4wW3Ghm/o32hfhst3d9QfVnZJgMoEelX4BUIXpMvw73BHSMkf8cKHQ7KVsjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGnp5T+HxnH3Urkq+eKlFa9w5pZyo24MS3wLMmQxmPqp4EGU5m
	ssIU+hEPurtVB3DdM86i259qEvC9heokqbZhj0u5CGjLj6aZBHgrHvwRUDJROd2xopnxY9Nd8x4
	UvLno2PKdasjG/8R02j9YxO2BR4Fq9jZwqrv2ynWNawoORPpB/IUJA0tJtsG+Sw==
X-Received: by 2002:a05:6602:3f85:b0:83a:9350:68b with SMTP id ca18e2360f4ac-83e030815a7mr567061939f.0.1731448244898;
        Tue, 12 Nov 2024 13:50:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0+a/6H0ukBrJt0ZjrH3woVs+ukMVKGZsElDCb6uPoCPtT0GWW0ORzC6Ah3fQgeBjw+LAGcQ==
X-Received: by 2002:a05:6602:3f85:b0:83a:9350:68b with SMTP id ca18e2360f4ac-83e030815a7mr567061039f.0.1731448244525;
        Tue, 12 Nov 2024 13:50:44 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83e135272aasm220925839f.31.2024.11.12.13.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 13:50:43 -0800 (PST)
Date: Tue, 12 Nov 2024 14:50:43 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: liulongfang <liulongfang@huawei.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "Jonathan Cameron" <jonathan.cameron@huawei.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxarm@openeuler.org"
 <linuxarm@openeuler.org>
Subject: Re: [PATCH v15 3/4] hisi_acc_vfio_pci: register debugfs for
 hisilicon migration driver
Message-ID: <20241112145043.50638012.alex.williamson@redhat.com>
In-Reply-To: <1c0a2990bc6243b281d53177bc30cc92@huawei.com>
References: <20241112073322.54550-1-liulongfang@huawei.com>
	<20241112073322.54550-4-liulongfang@huawei.com>
	<1c0a2990bc6243b281d53177bc30cc92@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 08:40:03 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> > -----Original Message-----
> > From: liulongfang <liulongfang@huawei.com>
> > Sent: Tuesday, November 12, 2024 7:33 AM
> > To: alex.williamson@redhat.com; jgg@nvidia.com; Shameerali Kolothum
> > Thodi <shameerali.kolothum.thodi@huawei.com>; Jonathan Cameron
> > <jonathan.cameron@huawei.com>
> > Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linuxarm@openeuler.org; liulongfang <liulongfang@huawei.com>
> > Subject: [PATCH v15 3/4] hisi_acc_vfio_pci: register debugfs for hisilicon
> > migration driver
> > 
> > 
> > +static void hisi_acc_vfio_debug_init(struct hisi_acc_vf_core_device
> > *hisi_acc_vdev)
> > +{
> > +	struct vfio_device *vdev = &hisi_acc_vdev->core_device.vdev;
> > +	struct hisi_acc_vf_migration_file *migf = NULL;
> > +	struct dentry *vfio_dev_migration = NULL;
> > +	struct dentry *vfio_hisi_acc = NULL;  
> 
> Nit, I think we can get rid of these NULL initializations.

Yup, all three are unnecessary.

> If you have time, please consider respin (sorry, missed this in earlier reviews.)

If that's the only comment, I can fix that on commit if you want to add
an ack/review conditional on that change.  Thanks,

Alex


