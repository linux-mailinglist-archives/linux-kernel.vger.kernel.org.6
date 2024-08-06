Return-Path: <linux-kernel+bounces-276174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9063948F75
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754A61F22874
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BD71C37A5;
	Tue,  6 Aug 2024 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UaCL/c/o"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A811FA5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948587; cv=none; b=Ksc2/ryIMer3pGhm6NcrYACdHKBAhaO0Q1ZVO7ary/zXh3p5Xrbi9tJrt6Zu+fGI7C7KZD6dPHr2lcMyWvyBOQup29tclQUlK0mUooWZFLiFLX2CjNT4QSyteOPIi8Z0Yk0vct5qsS3ZQ5EFUcu7B6EZGcXzsDDEG0637+0WqkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948587; c=relaxed/simple;
	bh=o2YjKCknl6M8LtLbfpnw3wCcfLP7Y1pD+V1xIOT7uLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQTKdski4o2S61759EPeCPSdBnG+bmNC/hoS47egzpTJnMzUwj6X4nteQd9ZZi7yR+GWOkbJgLmoAqoTC4tDs/4ImNc/uHZrAevtkSBJQQhoDKVoGUogiUao5zg1K288iidgyCVUP+D9w7ni+ki6RJJQC05Mc1MHcVQxchYh0d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UaCL/c/o; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b7a4668f1fso3532896d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 05:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722948584; x=1723553384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsS8lDANHoxr8XxddcWQLsVxBCftUnrKv7PenmFYu8c=;
        b=UaCL/c/oCjuyNQlOKDLzzHWay2zMcIYa0xcqflWCc1iki4gmlOv8946RxEdGFuUfwn
         KNNIsAM2UWwofmIJL4Vrbfu9fR5IL1L8j/8PEVPxPvCL8wfLD3KOkCU2he9a91SnjGI2
         35KmY5WDFFZ8I2DmzazncInNqCwdLCbsUPn43FQW8mEvMnzhCy93qs7P5lUJ5Cm5cWxv
         gg3DjiGz5zWPoCly3sIfUxZm69DAddZP525iPtRG79w3O7FTPuaM6msrIm7R1LGKIH0l
         y/GxLfsAHMxpjS/bp/kLAFkLQOZ09LhMih2rrv/NZyIdjgv/5pbqT7Dey9V38zenM6SZ
         YWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722948584; x=1723553384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsS8lDANHoxr8XxddcWQLsVxBCftUnrKv7PenmFYu8c=;
        b=s6PB+KdvaVyWQpCfKcaRFVeG1W7/wqK/y3cn82mEHnmf9q+DKGXRSIUZ/pEdBHmgkP
         F26E9cSzA12ICU3lT2wmUtSWDYRbgK0PPZ+TB9wZ567bfKuuNoLH4zOmYaNKzsrcYzqF
         xnnNbAMnD6r12OgV+2Yddh3+jV81uUh0LR+I8O0AIbx4wONFRYkIKPEO0Wk1mWFgeNB1
         KUtsJA9aC53h0no2o1mCs4iP5lz+D++4UOjML9q4+cx9HdkAA15nPTGYmN2+TSmgrfBP
         Sghnl3Rdw41LsQw1J3A6m6WiKep1IjF5R37G0JLXsqw1NLU2EILkqJ8KwhHpGoSr6Vop
         RAUA==
X-Forwarded-Encrypted: i=1; AJvYcCWNZm/nbbvJMtiXF84bhTfRPZ9HCcQX0cGHVNwFmr/CLIkuNDO9WGRosVn7JUsEnCH6gET4v0JFitp8QKVp9MzzOtUOCufJeRGZfsFr
X-Gm-Message-State: AOJu0YywdPKrpIlev6W0bj1aTKCVoH4Qv6wiNb2NVD5LmOabWlLnDOYm
	63Sq1lKbspOo8HMGtDedc2ikrWcdzsT0YFcTyI8ekuM2vTyk7Fd+EFWW/+7r4l4=
X-Google-Smtp-Source: AGHT+IE4gm6wgloJySeIldlxpXgfok3Evok6Njg2O3IYxbHH8YUdW3ULVRl1IGWvijLFTM05yqG0ew==
X-Received: by 2002:a05:6214:5a02:b0:6b5:da50:ac18 with SMTP id 6a1803df08f44-6bb983eeecfmr211113546d6.41.1722948584248;
        Tue, 06 Aug 2024 05:49:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c765e4asm46058956d6.25.2024.08.06.05.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:49:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbJdH-00EL3r-8m;
	Tue, 06 Aug 2024 09:49:43 -0300
Date: Tue, 6 Aug 2024 09:49:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Will Deacon <will@kernel.org>, Kunkun Jiang <jiangkunkun@huawei.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	wanghaibin.wang@huawei.com, yuzenghui@huawei.com,
	tangnianyao@huawei.com
Subject: Re: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
Message-ID: <20240806124943.GF676757@ziepe.ca>
References: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>
 <7d5a8b86-6f0d-50ef-1b2f-9907e447c9fc@huawei.com>
 <20240724102417.GA27376@willie-the-truck>
 <c2f6163e-47f0-4dce-b077-7751816be62f@linux.intel.com>
 <CAN6iL-QvE29-t4B+Ucg+AYMPhr9cqDa8xGj9oz_MAO5uyZyX2g@mail.gmail.com>
 <5e8e6857-44c9-40a1-f86a-b8b5aae65bfb@huawei.com>
 <20240805123001.GB9326@willie-the-truck>
 <ZrDwolC6oXN44coq@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrDwolC6oXN44coq@google.com>

On Mon, Aug 05, 2024 at 03:32:50PM +0000, Pranjal Shrivastava wrote:
> Here's the updated diff:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a31460f9f3d4..ed2b106e02dd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1777,7 +1777,7 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
>  		goto out_unlock;
>  	}
>  
> -	iommu_report_device_fault(master->dev, &fault_evt);
> +	ret = iommu_report_device_fault(master->dev, &fault_evt);
>  out_unlock:
>  	mutex_unlock(&smmu->streams_mutex);
>  	return ret;
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 0e3a9b38bef2..7684e7562584 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -532,6 +532,9 @@ void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
>  	bool last_page;
>  	u16 sid;
>  
> +	if (!evt)
> +		return;
> +

I'm not sure this make sense??

The point of this path is for the driver to retire the fault with a
failure. This prevents that from happing on Intel and we are back to
loosing track of a fault.

All calls to iommu_report_device_fault() must result in
page_response() properly retiring whatever the event was.

> +static void iopf_error_response(struct device *dev, struct iommu_fault *fault)
> +{
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +	struct iommu_page_response resp = {
> +		.pasid = fault->prm.pasid,
> +		.grpid = fault->prm.grpid,
> +		.code = IOMMU_PAGE_RESP_INVALID
> +	};
> +
> +	ops->page_response(dev, NULL, &resp);
> +}

The issue originates here, why is this NULL?

void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
{

The caller has an evt? I think we should pass it down.

Looking at the abort_group path that is effectively what we do, but
the evt is copied to the group's evt first.

I also noticed we have another similar issue with the
report_partial_fault() loosing the fault if memory allocation
fails.. A goto for your new err label after report_partial_fault()
would be appropriate too

Jason

