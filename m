Return-Path: <linux-kernel+bounces-234735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4895891C9E8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 03:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFD91C2139E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 01:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A943D17721;
	Sat, 29 Jun 2024 01:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GUZy00Yh"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75274101F7
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 01:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719623512; cv=none; b=K3aRE8z3ll850zi31udMVwcmf1uwlqERhPWj+S0/v1y55WoIGojYcGeAixWNQ/RnYeej+Z6rz02MNQg6cd57IrKeyM2saFWfo+d46Qlo/QVYdW8caRmgyRASlZT2RUR5AUjofxckIJ83LelsD3xqZay6ie3WHvrWsNCmRMVfQ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719623512; c=relaxed/simple;
	bh=4J+wv41/qTOW/XeXcWFye1zeMVG+o14N+SygBRQYWno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awKlIJxNl/t638W54hVNu6dnnELglbm2QmTv2FqfSxg5Hre7wlOy+KZLobVMbh9Ev4XBe9NiLFwmb22Bq5dzkCSVu+PtMZUfrLFutBF5NLsV3NO81QnhFhQGN5hAR1fARBp9H8kAWiaV+drkO2HGq0sY2ITOhmDJ44x8wf/JoOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GUZy00Yh; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d566b147ffso778722b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719623510; x=1720228310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CxuCmnV0ZWEWENto9tfINCmCrw1xBxkvM+e/Do3ps+0=;
        b=GUZy00YhvFa9/YAgRRDy+0bvVR8iodCVgrP3Vl9eGdNaume8sfN6JRkrO48Z/DfEcW
         a7w5l8sysBQewOh/CuYJDQum1do6i/3mde/R+rcBuLvppGMTpiaRuYKqvCPNXZBWEUC3
         OeXpggPw1uAqO6nlYvWQjqGT+Mo6YmRd+wRUP+qS90f1tLVwzVrGIAq1IqqAZGBLPrFi
         S6p/GgA4NZSncRaSZKsc21vSDrA/igaZ0OZKztvq2jB5DqXWt1BdwGslV8aWjbqZzNoJ
         fUFZOevsEuLzCnvVHnqoH/pkoVub3uvTMjM9fsg49Xu3ncGRDSRjj5EVkCaooNmSn6WN
         WYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719623510; x=1720228310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxuCmnV0ZWEWENto9tfINCmCrw1xBxkvM+e/Do3ps+0=;
        b=ZQBBjGA8EDrYPD9IPBbPzttKJTOOXgrczoSgNeJcHxknXd/6QuOXFdn2JauleW0K9G
         JWYMKT5CN8n6q06TsQWjtLUXKNGjQR5MP1pdtmV1Em2A80qMP1MZVTz/ABniQfa4hi5o
         8uSGZmSG0DK3aoFsqRqKfcNH0UD4GIq5RvTEBiREh3EbpX8sgU8F8NzGKB3dustw6+li
         B5WdA8Gu2Cvzca7S1EH/xYvGIJT1+tHfWZNITTLKkGWvfe2rkXdRZ+3Ma8czEnpjtKJZ
         heSf6baZB28OwLwkIItq56DZWP/BTiSASY+XXQuK8Hdda5qRMYHCYPbUmOusgsHIiN7C
         Aa9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVZb0aRoPTbrVn198jNPYzIhDeiVNq2gi/yxTvhjNFfF8kRMM6NLDHKXBrlLgxG7BnS/l158VanM0VHdBXNKbwduHj/nQWUz4uGujG
X-Gm-Message-State: AOJu0YylkpJXmKc/pNpyRLzO9ge210qG45rU7BQgf3HEEwRjLc3M/HX/
	WOUDJIzLitxcOeD0cyb97Hl/syzXUQMMiqO2V8WjxXqdL5khjn1hOk0rUOtqZOI=
X-Google-Smtp-Source: AGHT+IE5gW6TwhDu3dVXkufILwe5Riqxu4x8VUh+MyIJSeF3+uS0xeub7USzPp5b3oOGLO8VOeb/KQ==
X-Received: by 2002:a05:6808:1783:b0:3d6:7726:a4c6 with SMTP id 5614622812f47-3d67726a926mr283479b6e.10.1719623510666;
        Fri, 28 Jun 2024 18:11:50 -0700 (PDT)
Received: from ziepe.ca ([24.114.37.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53be5sm1784142a12.16.2024.06.28.18.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 18:11:50 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNJqL-0004ne-OK;
	Fri, 28 Jun 2024 19:13:21 -0300
Date: Fri, 28 Jun 2024 19:13:21 -0300
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
Subject: Re: [PATCH v7 08/10] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <Zn81gdjwJBfjXekJ@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-9-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616061155.169343-9-baolu.lu@linux.intel.com>

On Sun, Jun 16, 2024 at 02:11:53PM +0800, Lu Baolu wrote:

> @@ -308,13 +315,29 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>  		goto out_put_pt;
>  	}
>  
> +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
> +		struct iommufd_fault *fault;
> +
> +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
> +		if (IS_ERR(fault)) {
> +			rc = PTR_ERR(fault);
> +			goto out_hwpt;
> +		}
> +		hwpt->fault = fault;
> +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
> +		hwpt->domain->fault_data = hwpt;

This is not the right refcounting for a longterm reference... The PT
above shows the pattern:

	pt_obj = iommufd_get_object(ucmd->ictx, cmd->pt_id, IOMMUFD_OBJ_ANY);
	hwpt_paging = iommufd_hwpt_paging_alloc()
            	refcount_inc(&ioas->obj.users);

	iommufd_put_object(ucmd->ictx, pt_obj);

Which is to say you need to incr users and then do the put object. And
iommufd_object_abort_and_destroy() will always destroy the ref on the
fault if the fault is non-null so the error handling will double free.

fail_nth is intended to catch this, but you have to add enough inputs
to cover the new cases when you add them, it seems like that is
missing in this series. ie add a fault object and hwpt alloc to a
fail_nth test and see we execute the iommufd_ucmd_respond() failure
path.

--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -14,7 +14,7 @@ static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
                iommu_domain_free(hwpt->domain);
 
        if (hwpt->fault)
-               iommufd_put_object(hwpt->fault->ictx, &hwpt->fault->obj);
+               refcount_dec(&hwpt->fault->obj.users);
 }
 
 void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
@@ -326,18 +326,17 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
                hwpt->fault = fault;
                hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
                hwpt->domain->fault_data = hwpt;
+               refcount_inc(&fault->obj.users);
+               iommufd_put_object(ucmd->ictx, &fault->obj);
        }
 
        cmd->out_hwpt_id = hwpt->obj.id;
        rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
        if (rc)
-               goto out_put_fault;
+               goto out_hwpt;
        iommufd_object_finalize(ucmd->ictx, &hwpt->obj);
        goto out_unlock;
 
-out_put_fault:
-       if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID)
-               iommufd_put_object(ucmd->ictx, &hwpt->fault->obj);
 out_hwpt:
        iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
 out_unlock:

