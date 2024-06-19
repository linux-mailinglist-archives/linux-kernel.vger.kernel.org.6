Return-Path: <linux-kernel+bounces-221453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B579990F3D5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB13C1C219E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39187152188;
	Wed, 19 Jun 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NbGk3xN+"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA781482EE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718813866; cv=none; b=ZlYSzXwnhyb3AJjmNx7sbne5WLziGmk0LM/YMarAzZu9XoHAMaQHobpOZk4KOjDPy53k+Nn58mtrgzKFJQMZglO+7CRN/chC0Q2kYAZdqkvbWT1PgAF4LzP0E3BqE1O0KNKStEKJjGc1yJOGLL5gS8Ee0YFqeztzQaoOyDrWz3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718813866; c=relaxed/simple;
	bh=bxn6wBPCAmgkCi3Qzxt6tA3XbKgMfoOFKK0Ftpv3Svk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpw3JGbqmncMAO4E+B9G7mj4QPqzyoaL+/7HdBr9awXpBdFU0O9wJ32HzdazZ910nlWSwNoKc1Tos1JZZs5bNkFnrqwJhGiwil2eU9/7V8VICLsitBzZsTCIBe9KM0ipe3lJS1HNohvQn/vm1eNV/QfsDw2DXEBfJmb3qAUdd9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NbGk3xN+; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b50a68b0b3so4506586d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718813862; x=1719418662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJVIwzPcIdMQxvtrBPsr6OyaDEL3PRs7k9pYTnL2jas=;
        b=NbGk3xN++2uFFSYmOihXAHTXEVmLD0nTvH32cwcfb+zzAB9Dms+/OAAtX4g1vfUH2L
         2VnbrwDksCEwX0RcB46mlUTznmGIt3FtSfmnzsVPxfno6xuCtYFeaxJdojle2Qglgmwt
         2r3feawcquS9Hde/2hzBDMfeIshnje7Ra8iAJRfbChkPZ+3VgNXOQbc6C3x0f3GamBiA
         Y4Ng2efDttK1akvqpja8/XTs5NeuYXjjaCm7ShsupWunJWnFZaC/agHnqoCDjgb/5/0d
         xV7DW+eSFVo8Nwk2amWuFCX05+sJ+OleyIrqG+AqyeWIc4662dp7UJ7zoC9bapbLj0Gx
         INvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718813862; x=1719418662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJVIwzPcIdMQxvtrBPsr6OyaDEL3PRs7k9pYTnL2jas=;
        b=TRxh943Cw1Iaxt4Dpq1DCg1sYlZbNorQFf1t5Ef3qbTA7+MRg61cMFTa/iwT0MLt9k
         4Sviwc+OpyWDIH9+UuhypDL+FiQy0hMbwbyj858yBMEb2xC4WxFx0qid12nIZRGG1V1j
         GIT2frZGe6VydOjti8YVeEQzPDrtRRFAV78wrVWgslVVbzLi6iPkUp3WoFGb3lNAZhSn
         nQWexNwNyxMnf2K5lCWPJotg89ZvnMm+Q/pfQvVwI6NFDAvvPb6+9xPeQ/PNOjF9iCa+
         Gffg3HzjpcsP5FYi1QJphSVNz9J4gQXD/1FOzWknbPXyKxn3vcZfgaWRKu6J4rJ8xsWq
         UnAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRsqlPXp0lp1JPvzaam9LldUDOzbyJhdV6bWbILfRspPL3u0icKcvFR8/7YZVrg6zhTv1c/TQcMDRw6YUi7Kb5XDNm0En1l4bAg4Df
X-Gm-Message-State: AOJu0Yyi+9gMtoLMmRUPIgUQGMhKzaezS2IZMfFxyBRU+wE+8003eNvi
	ddfqe6fKuY0G+irTCc52zyls4gIV33qJqfI9pD2jwzSTgShfTbxGQWWIYAw0BpdJRHln7r45crC
	h
X-Google-Smtp-Source: AGHT+IFfUciy2ULNoWqjYrlaf+0zX+YLSbjNyDJwf1uvYHiwNEj03UK9PLBK8P2sgu1Fpv3E0J7nRw==
X-Received: by 2002:ad4:58a5:0:b0:6b4:f6ed:ab2b with SMTP id 6a1803df08f44-6b5019d215fmr50749306d6.10.1718813862385;
        Wed, 19 Jun 2024 09:17:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c2e9d2sm79303046d6.59.2024.06.19.09.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 09:17:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJy0C-0055tc-Ng;
	Wed, 19 Jun 2024 13:17:40 -0300
Date: Wed, 19 Jun 2024 13:17:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v2 08/10] iommu/riscv: support nested iommu for
 flushing cache
Message-ID: <20240619161740.GP1091770@ziepe.ca>
References: <20240614142156.29420-1-zong.li@sifive.com>
 <20240614142156.29420-9-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614142156.29420-9-zong.li@sifive.com>

On Fri, Jun 14, 2024 at 10:21:54PM +0800, Zong Li wrote:
> This patch implements cache_invalidate_user operation for the userspace
> to flush the hardware caches for a nested domain through iommufd.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/iommu/riscv/iommu.c  | 90 ++++++++++++++++++++++++++++++++++--
>  include/uapi/linux/iommufd.h | 11 +++++
>  2 files changed, 97 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 410b236e9b24..d08eb0a2939e 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1587,8 +1587,9 @@ static int riscv_iommu_attach_dev_nested(struct iommu_domain *domain, struct dev
>  	if (riscv_iommu_bond_link(riscv_domain, dev))
>  		return -ENOMEM;
>  
> -	riscv_iommu_iotlb_inval(riscv_domain, 0, ULONG_MAX);
> -	info->dc_user.ta |= RISCV_IOMMU_PC_TA_V;
> +	if (riscv_iommu_bond_link(info->domain, dev))
> +		return -ENOMEM;

?? Is this in the wrong patch then? Confused

>  	riscv_iommu_iodir_update(iommu, dev, &info->dc_user);
>  
>  	info->domain = riscv_domain;
> @@ -1611,13 +1612,92 @@ static void riscv_iommu_domain_free_nested(struct iommu_domain *domain)
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

I'm not sure what this remark means, but I expect you will need to
translate any devices IDs from virtual to physical.

>  
>  static int
> -riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_iommu *user_arg)
> +riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_iommu *user_arg,
> +			struct riscv_iommu_domain *s1_domain)
>  {
>  	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>  	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> @@ -1663,6 +1743,8 @@ riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_iommu *user_
>  		       riscv_iommu_get_dc(iommu, fwspec->ids[i]),
>  		       sizeof(struct riscv_iommu_dc));
>  		info->dc_user.fsc = dc.fsc;
> +		info->dc_user.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, s1_domain->pscid) |
> +					      RISCV_IOMMU_PC_TA_V;
>  	}

It is really weird that the s1 domain has any kind of id. What is the
PSCID? Is it analogous to VMID on ARM?

Jason

