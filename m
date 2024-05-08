Return-Path: <linux-kernel+bounces-172558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE9D8BF397
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C261B2346B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2DF38F;
	Wed,  8 May 2024 00:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mMwJb16b"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ED0376
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127766; cv=none; b=irPYXQ4V4WvZmHSfuPniyX3wcITgphNnF0aRob9DXPkHlDtxpcIpu8S6eKuVnRvbyBx/Zr171/nIH4fBJ74ffe53TVU6GtKkcN48TGQc1xE8pl+Sa8xpKLpBPNylAB0Pb1MnoNGN9plm1j3pNhlUMdpBUhS1ZrquLYxOHn2qP1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127766; c=relaxed/simple;
	bh=WGmcAoiIYkBzYTcnI6cjBMVdcLKjLO/t8etJMyy0xdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4HcKh9fz255KZJqLWD7XLfWwY0t/22qDk+qteyahJOaTt3uzp5DzPYJAZaova6z07XWu/grJwZcMfFknJ/xLfh1PasY+VZr5W0lZJUfhVIYdbvR1fLqnLdC9VnX/kpIFDSigrkf+ebze0W4wfQIN2nnKFJAJKmrL+Zc6OS/GQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mMwJb16b; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-47f1e656a93so751917137.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 17:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715127763; x=1715732563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0vVlsRAg17DQsgwypHbQum2UTPFFlE+iz9hu2GQEt7A=;
        b=mMwJb16bzrIto3Wlhc+uomZluAbvaAO/OAGriUbDYFIYHu9wNyar+QWwAoVs3uGRiM
         Gt88jWUC5L1wsQEAjSYAs9eZqoXx836dJLml/g6JuM11ypCb0VEcvyJ29vr9/jh4v0HS
         7367bwCWYjJ1HoH8L3r7GkebyX4HvkJhOJGq/f55plZGIz6UoIKVP3VG96mnoEK8G5Kz
         SbHFke/XMtZSE6rj5AS0Sh59ySP5bK8ksQHDJpQMdhYK5kNIWnXZL1R/BGZ/Y0NOe6/q
         qgG4zfV1T1T8hyNmAMX6EtPzVp7I0ONJ8U6LzS6QQTLQ0m+QwtCiWO4Enfq9vdTX4GE7
         MqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715127763; x=1715732563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vVlsRAg17DQsgwypHbQum2UTPFFlE+iz9hu2GQEt7A=;
        b=BTFMqtH/1ity0hrRgi7/579naxewFc/KguMg+QoE8V2cyMoRQjm3DU5QeJ1H2wLGy/
         94g/8AK4YxgOhhvfipeAJGT4ZxAc1MNdDTT6Axg2th9rCutzf5FlfF5NaCGIUT5OPz00
         RAPSma3WSR4MH2xN5l0qFFvNqFyu/fRFjOcvWt6h74WW+bSutSqICVfp5cyUUPxg6UTH
         qDEr/CttxwDeAEPiYJpJmyfMkS7ClxXrHVx2g0CTDMuHgAIrwILshggqDFuTGD/mj2vC
         7UGZGurtPdFJxqAHAQexAjhtsPyOw7YicYzAmCdTDSzoPam7wPn3YBpNDsTpGE6IoIYC
         ETvA==
X-Forwarded-Encrypted: i=1; AJvYcCWhz54tNp64iQDKCFfT7uVztLBVgJDp0lPLU7WCLj793V+QGvdOYtNBgTkYiyeTPW9w6q3REcv3pnGc8JTUJqPdzzPJFCrt8SRnMc3y
X-Gm-Message-State: AOJu0YyMJo3YMBVMiVgsSFVHoN9zqWjOhgq7qjko9ZI3RCS9IfSakcTp
	hXhcWFlyC512Ak8ptKxVR8zZf+6W6fjzmxoe0hnr45lOC2xQJVhQ+lgsj1q5iAc=
X-Google-Smtp-Source: AGHT+IECNvqKHwlIYvkCbsFT5xd8nj9nklkhaiaz6B3Vn7SJl6jIjBbaZQht1v4nImwi8swZj3JkDQ==
X-Received: by 2002:a67:f554:0:b0:47b:d787:9ca6 with SMTP id ada2fe7eead31-47f3c2f99d9mr1007624137.18.1715127763605;
        Tue, 07 May 2024 17:22:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id o6-20020a0ccb06000000b006a13cf08fd4sm1804740qvk.66.2024.05.07.17.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:22:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4V50-00059G-L2;
	Tue, 07 May 2024 21:22:42 -0300
Date: Tue, 7 May 2024 21:22:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/9] iommufd: Add iommufd fault object
Message-ID: <20240508002242.GP4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430145710.68112-6-baolu.lu@linux.intel.com>

On Tue, Apr 30, 2024 at 10:57:06PM +0800, Lu Baolu wrote:
> +static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
> +				       size_t count, loff_t *ppos)
> +{
> +	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
> +	struct iommufd_fault *fault = filep->private_data;
> +	struct iommu_hwpt_pgfault data;
> +	struct iommufd_device *idev;
> +	struct iopf_group *group;
> +	struct iopf_fault *iopf;
> +	size_t done = 0;
> +	int rc;
> +
> +	if (*ppos || count % fault_size)
> +		return -ESPIPE;
> +
> +	mutex_lock(&fault->mutex);
> +	while (!list_empty(&fault->deliver) && count > done) {
> +		group = list_first_entry(&fault->deliver,
> +					 struct iopf_group, node);
> +
> +		if (list_count_nodes(&group->faults) * fault_size > count - done)
> +			break;

Can this list_count be precomputed when we build the fault group?

> +
> +		idev = group->attach_handle->idev;
> +		if (!idev)
> +			break;

This check should be done before adding the fault to the linked
list. See my other note about the race.

> +
> +		rc = xa_alloc(&idev->faults, &group->cookie, group,
> +			      xa_limit_32b, GFP_KERNEL);
> +		if (rc)
> +			break;

This error handling is not quite right, if done == 0 then this should
return rc.


> +
> +		list_for_each_entry(iopf, &group->faults, list) {
> +			iommufd_compose_fault_message(&iopf->fault,
> +						      &data, idev,
> +						      group->cookie);
> +			rc = copy_to_user(buf + done, &data, fault_size);
> +			if (rc) {
> +				xa_erase(&idev->faults, group->cookie);
> +				break;

Same here

(same comment on the write side too)

Jason

