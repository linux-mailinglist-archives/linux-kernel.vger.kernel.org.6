Return-Path: <linux-kernel+bounces-285287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC15950BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98512842D3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC971A38C6;
	Tue, 13 Aug 2024 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LJkv5DN1"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C01A2C32
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723571520; cv=none; b=E4c9Z7l4VFLMASDmSVV5PDgvqzcOf1puVzEIHkGJTt8h6YBrdmgGsR7bndn2NKVVjqrpBTPMGJyOV2xbTrKYb61smNXj80lnCzwRNbXmL0TuE41+x9dMbPfVU6T0qx/i4gEw39pg6AF8CTtOgVMXWMDsqmBllnBlUCf2jruj65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723571520; c=relaxed/simple;
	bh=ntkDeJlYChEivTX0tyYL1K19WfOpIRbzhRHsrFfpQOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=de67NwkQ51RH1MNkQI76JFhJ25Cc89gaIsJ2BW38EeYn3czC/OGRvnjoise5WjYeddas3Vrtxrq2v4vBDL8Rr6BTb0kro1NJf3zMX1rWtUgIlAdH6KCD4xlZ8d1owBrUuPtBTQhnfa/uKU+juQm8vpsWGVXkwrRgiuBdf6Bt/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LJkv5DN1; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1dd2004e1so361706085a.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723571518; x=1724176318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5G+oWQ6Rh5ISXgA0J/LF+tOSSrj10GPW8g20/rns1U=;
        b=LJkv5DN1LFs7iMaCNYFZgecn5pR9IJosaYoM+3l5crZ5HwXwKS/W+NVJeNQ9KcbOXQ
         ZjguGcjz5RJVmPFMHTZgc284pOwpMSrOTBQcY6gfDPBVy3Tjc30mP6sAnB02/86mJdIm
         lF21Dd8gqeYPxTvBwh0iC5sf/TMImIjhmB6+/NpXRM8F3xHK+S38POh1XBGDXtK9GiFk
         w4i6FdBiAPSQBH9mwENKCWTn9ftYvm1zGpG0XWhpJcspwhnJZfWh/Ix/IS4QNWw+SG3R
         6SqxDBbjRsc84eLn9HC1UZNoUaz3Gy0jpLyV/Jzq7aE2Hy8mhYtdZ3WdHBzK7mEdc7ub
         QXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723571518; x=1724176318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5G+oWQ6Rh5ISXgA0J/LF+tOSSrj10GPW8g20/rns1U=;
        b=IxRWdhIHGpN9ncuWtnuINwdaaBLZbY1oXQjQY5xS9IL+ETv6OV7vWecu/Ug+q9YHiZ
         /ZZKEEy+/6VCG6D3UiNKz1hRKS2tlvnP51W81il0CSRxY9hzhXtXdPmNJa1vswZEK8Qk
         kfsbdVac9Zrl6lY7Shh2lyPGX6H9Q9viWW2fv5MDR7QJSvRzBsFFckU6ormJxKvfoeZW
         ZzJwFAq8Pqltf4sA9/yWz1yUM9coa7lcfyhOSAl3Cralzneq2YwkGBe1n+DrSA2eMZTj
         d5v0IUiUlabpm8P7SCDk34YX4ZnmjWpIGEKyXC/s4GE9wqW0MXOnxkGr9qUpFGPjpesv
         tbDA==
X-Gm-Message-State: AOJu0YxJn8ytnj1O46rHRq1zxYPd0tfK8o8+2GRyXAIqL150CTqR7ENP
	FgkAgsqKxeVftIvh37DqCRSR/Mi4T9mGH2OCDNCuQgeiDXUWfCGmvSOnxPgG3xY=
X-Google-Smtp-Source: AGHT+IGNfxxEytwtzg4vfONpxSKV6VhkyKNxntioOTjoDBXC/X1poTHbuNKyYTIkLBbprh5aPMRUaQ==
X-Received: by 2002:a05:620a:45a5:b0:7a1:6062:ed63 with SMTP id af79cd13be357-7a4ee33bdc5mr47040685a.29.1723571517942;
        Tue, 13 Aug 2024 10:51:57 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7dedf8csm357399085a.77.2024.08.13.10.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:51:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sdvgZ-008nyn-MJ;
	Tue, 13 Aug 2024 14:51:55 -0300
Date: Tue, 13 Aug 2024 14:51:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, nicolinc@nvidia.com,
	mshavit@google.com
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Report stalled S2 events
Message-ID: <20240813175155.GN1985367@ziepe.ca>
References: <20240812205255.97781-1-smostafa@google.com>
 <20240812205255.97781-3-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812205255.97781-3-smostafa@google.com>

On Mon, Aug 12, 2024 at 08:52:55PM +0000, Mostafa Saleh wrote:
> Previously, S2 stall was disabled and in case there was an event it
> wouldn't be reported on the assumption that it's always pinned  by VFIO.
> 
> However, now since we can enable stall, devices that use S2 outside
> VFIO should be able to report the stalls similar to S1.
> 
> Also, to keep the old behaviour were S2 events from nested domains were
> not reported as they are pinned (from VFIO) add a new flag to track this.

I'm not entirely clear on every detail of this stall feature...

But from a core perspective device fault reporting should only ever be
turned on in the STE/CD if the attached domain->iopf_handler is not NULL.

If it is NULL then any access to a non-present address should trigger
some kind of device error failure automatically.

This is new core functionality since this code would have been
originally written. Now it is all handled transparently by the core
code. The driver should just deliver all fault events to
iommu_report_device_fault() and it will sort it out.

> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++-----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 8d573d9ca93c..ffa865529d73 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1733,6 +1733,7 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
>  	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
>  	struct iopf_fault fault_evt = { };
>  	struct iommu_fault *flt = &fault_evt.fault;
> +	struct arm_smmu_domain *smmu_domain;
>  
>  	switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
>  	case EVT_ID_TRANSLATION_FAULT:
> @@ -1744,10 +1745,6 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
>  		return -EOPNOTSUPP;
>  	}
>  
> -	/* Stage-2 is always pinned at the moment */
> -	if (evt[1] & EVTQ_1_S2)
> -		return -EFAULT;
> -

This makes sense at first blush since the domain mode shouldn't define
if events should be processed or not, and the events should be failed
anyhow right? If someone did turn on fault reporting in the STE then
it should always be processed to conclusion.

>  	if (!(evt[1] & EVTQ_1_STALL))
>  		return -EOPNOTSUPP;
>  
> @@ -1782,6 +1779,15 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
>  		goto out_unlock;
>  	}
>  
> +	/* It is guaranteed that smmu_domain exists as EVTQ_1_STALL is checked. */
> +	smmu_domain = to_smmu_domain(iommu_get_domain_for_dev(master->dev));

Strongly discouraging drivers from calling iommu_get_domain_for_dev()
in async paths like this. The locking is tricky and the core code does...

> +	/* nesting domain is always pinned at the moment */
> +	if (smmu_domain->enable_nesting) {

This is not necessary - a nesting domain will never have an
iopf_handler set.

It immediately calls iommu_report_device_fault() which will reject it
because of:

	if (!group->attach_handle->domain->iopf_handler)
		goto err_abort;

Which after the rework will end up in find_fault_handler() at the top
of the function:

 https://lore.kernel.org/r/ZrTNGepJXbmfuKBK@google.com

So I think these parts are not necessary.

Though arguably we should be rejecting domains with iopf_handler set
in some of the attach calls..

Jason

