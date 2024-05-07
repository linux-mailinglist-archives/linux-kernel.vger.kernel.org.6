Return-Path: <linux-kernel+bounces-171658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 492D38BE6FC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0C11F23702
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B9F1649B3;
	Tue,  7 May 2024 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="k7EboeF0"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BAB1635B3
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094513; cv=none; b=SVGKrQI1dUGLDa2yTrOsptTLDdDaUwW6IFkA4gxTaOWLkKoBY8DctA9+17MXZ00R/hAGHzk83wWo5YqMwvkkCIDjLXuYtsbXfUR9nV47C47RMdnAFx3Kk4GjDFNq1pe2fSjr4V3wRVdDH55zlhMX/jxjcGm/tq4HhI7I7RlWXSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094513; c=relaxed/simple;
	bh=xHoMxy7vndi4tDKntaT+2miBG1wPVvYn45ngD3ZMnRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=it3IlZU5REa62OCKSrK/slpgH4LBGgdJRDWYFwc5sCuj0QPWwWb60/HEaxZGYipUABBG3mygdmV2N41WKiqJLts0qOYd4yE9tjHBMe1miWBKuMJJCFfQTeQhQow/g0CwJ2Atfoon3/xg7mktLWKgE2HMwNXuWSZIWWaD4zLDM1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=k7EboeF0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso22977215ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 08:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715094511; x=1715699311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fND2M9HAUkm4x+oFcQdmy96kdMgurKLsiwDF1oTNZBY=;
        b=k7EboeF0XEODGEOjoSg8SlcL5ENeflpx7Ib14BNpbLDS/fAQTk10iBsWTjI15W9GKU
         gnJSFSASkG6jxcyqMu0vQ7XpcIoNIx+6jDSBxph77Gp8QqXkCwP0pL55QZiO4oJtr/6g
         q0Nttiv3AVAtYGufNdidJOExaajETlWVrlbRy7YvrjgU5SguYlirUGGAG4YxLOaSBiUD
         MxVvPIf6lj383ttvwbpJ+1RXH5rxcwW3OZOe0fAIhVJQ/2CRWpgHi5ECMeenvhfrexdk
         3ooOAm7KpVw2huvhx7PUAEr/fM/2JB/npPx3Ya1yAGOxxvfH9HqUiw6dKiSwbr2p2sRu
         e0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715094511; x=1715699311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fND2M9HAUkm4x+oFcQdmy96kdMgurKLsiwDF1oTNZBY=;
        b=ninNhomBQ3P1pUUwMnfDozIv1sTQxuQu0xY4YNEHVceARyUvJQu/oHf+uRz1P+AnCh
         hSZCGkjUBVbxR8kXUPXFnGuK3Kb1ILRBi1jk5UUGP21iGAQxasXrF0upFI+cJ4aMxFZf
         cw+fA7K38WwTT+Lo6C5muXBcse80/9knAC/LCHT0MGkxjb+Lmg6/E86RTJzMT68biR5V
         OJB776svKcYM4dHD5ApEYcOdId4sr+h+IGosHwuyfeihPtnYPyMyzfSgyF4rR32AKAV8
         Anw+pRQYAZeCrLlQp812SP2f4S01nb5CLwZMDmeSXZrLWbQYzX6jbTQFBNk65WjPfaBh
         70Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXsprZnPz+nM/Xm4kFanobcyFAYvTveCoWb9cwIi3CyYuJ6qM3IuWzdlBozuUzEQRkOym3VMiI644Hetm+gPcYsKLA6gXX/GP9KkoQO
X-Gm-Message-State: AOJu0YxnmLF67bBWVYT+YG7oIAn6O7ftdl9MyouB9G54beGgp9OBy8n4
	gOb6IR9+w55WAZTm2YxjeMYGLkKFh7ZYhR4agAsz6cOTuAITc5uQMHXh7dPwzLAYwYJpYmwN7ss
	i
X-Google-Smtp-Source: AGHT+IE99ykRACFWdx0o3pmeRQlEzYnavDZRoKHfVvO4jPQEJsMrakgeX588ukvMpQUEMFItCF1XdA==
X-Received: by 2002:a17:902:e752:b0:1e5:c0ee:a7f9 with SMTP id p18-20020a170902e75200b001e5c0eea7f9mr15612425plf.14.1715094511569;
        Tue, 07 May 2024 08:08:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902654c00b001ed9b384b6fsm6325649pln.23.2024.05.07.08.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 08:08:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4MQf-0082xt-Nq;
	Tue, 07 May 2024 12:08:29 -0300
Date: Tue, 7 May 2024 12:08:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC RESEND 6/6] iommu/riscv: support nested iommu for
 flushing cache
Message-ID: <20240507150829.GJ901876@ziepe.ca>
References: <20240507142600.23844-1-zong.li@sifive.com>
 <20240507142600.23844-7-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507142600.23844-7-zong.li@sifive.com>

On Tue, May 07, 2024 at 10:26:00PM +0800, Zong Li wrote:
> This patch implements cache_invalidate_user operation for the userspace
> to flush the hardware caches for a nested domain through iommufd.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/iommu/riscv/iommu.c  | 91 ++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/iommufd.h |  9 ++++
>  2 files changed, 100 insertions(+)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 7eda850df475..4dd58fe2242d 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1522,9 +1522,100 @@ static void riscv_iommu_domain_free_nested(struct iommu_domain *domain)
>  	kfree(riscv_domain);
>  }
>  
> +static int riscv_iommu_fix_user_cmd(struct riscv_iommu_command *cmd,
> +				    unsigned int pscid, unsigned int gscid)
> +{
> +	u32 opcode = FIELD_GET(RISCV_IOMMU_CMD_OPCODE, cmd->dword0);
> +
> +	switch (opcode) {
> +	case RISCV_IOMMU_CMD_IOTINVAL_OPCODE:
> +		u32 func = FIELD_GET(RISCV_IOMMU_CMD_FUNC, cmd->dword0);
> +
> +		if (func != RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA &&
> +		    func != RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA) {
> +			pr_warn("The IOTINVAL function: 0x%x is not supported\n",
> +				func);
> +			return -EOPNOTSUPP;
> +		}
> +
> +		if (func == RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA) {
> +			cmd->dword0 &= ~RISCV_IOMMU_CMD_FUNC;
> +			cmd->dword0 |= FIELD_PREP(RISCV_IOMMU_CMD_FUNC,
> +						  RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA);
> +		}
> +
> +		cmd->dword0 &= ~(RISCV_IOMMU_CMD_IOTINVAL_PSCID |
> +				 RISCV_IOMMU_CMD_IOTINVAL_GSCID);
> +		riscv_iommu_cmd_inval_set_pscid(cmd, pscid);
> +		riscv_iommu_cmd_inval_set_gscid(cmd, gscid);
> +		break;
> +	case RISCV_IOMMU_CMD_IODIR_OPCODE:
> +		/*
> +		 * Ensure the device ID is right. We expect that VMM has
> +		 * transferred the device ID to host's from guest's.
> +		 */
> +		break;
> +	default:
> +		pr_warn("The user command: 0x%x is not supported\n", opcode);
> +		return -EOPNOTSUPP;

No userspace triggerable warnings.

> +static int riscv_iommu_cache_invalidate_user(struct iommu_domain *domain,
> +					     struct iommu_user_data_array *array)
> +{
> +	struct riscv_iommu_domain *riscv_domain = iommu_domain_to_riscv(domain);
> +	struct riscv_iommu_device *iommu;
> +	struct riscv_iommu_bond *bond;
> +	struct riscv_iommu_command cmd;
> +	struct iommu_hwpt_riscv_iommu_invalidate inv_info;
> +	int ret, index;
> +
> +	if (!riscv_domain)
> +		return -EINVAL;
> +
> +	/* Assume attached devices in the domain go through the same IOMMU device */

No, you can't assume that.

Jason

