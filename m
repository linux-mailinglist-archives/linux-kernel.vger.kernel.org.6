Return-Path: <linux-kernel+bounces-413383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 757C59D1862
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241CC1F24616
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC98A1E882F;
	Mon, 18 Nov 2024 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mrp5yqsZ"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D01E8826
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731955421; cv=none; b=Y6QO1qL2GexDFZGgiCRq51xQTtkU6iWJxAUMim5WxxZmHpRqDfgxkxRdl/rNjRtuZ58PNHa/BW4MBI/U4joj93YvLNZBsx1NtcORG0jj9NdLvJm8mpfbmEakt/hFhpxVNZVaaUcqiFyi5Mx4Sv161hFu8dQu89+0LvViEYwVq/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731955421; c=relaxed/simple;
	bh=2Ct+B8awPnldFMpopuvJ0mHQdWAvzuiku4XskzT+NJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRQ090nF4+cvpfwnkzPDOa+b5/SQzGnqEsoZJW211LKIopVCbsv3kJYA6Fk2C79h302cunIGIf1RzED4Zf07zqz1iMI37kFyTyYzZ6cCKhpGlQRzLsXSiDM67wtHqv1zwdnM/61o5xkh/hpuV04PA7u3P+uQgcmC5DkUhPcU3WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mrp5yqsZ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d40d77aa97so918746d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1731955417; x=1732560217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aiGoxS9y5bO8WAr6g5LjnG9Zf3/IZMgtxFJaSmFRzL8=;
        b=mrp5yqsZUyKB3RmYzXDGCMCtmElakMdYMyz9M3J2edCUEGQEKrfyDzELl9FK0bAAGO
         DLmm6gf/xc8BVOXQwF5gnspaItZo80KOyml7WFS1iRIFTPayOSOg5RAIDh2NUbUndgRG
         iOhEkFz2fLensRKMw0HQKuyKsv79z/LO9UCQnDcxLTfv3kPee/tK9iok7Fw3cAAKYCF9
         mYZJy+9lQzVM5mVyw0l4aNtqqbmVquoq0Z4T9N8wp5LAf9xl5RD625702hcelCtCUUz4
         AADXssppvrYS7GrNdBDxku5EQjI5DiBI4EZhJ3Gx/UhVxL01M4BdqeXfM4XYeipBBYX/
         m/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731955417; x=1732560217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiGoxS9y5bO8WAr6g5LjnG9Zf3/IZMgtxFJaSmFRzL8=;
        b=ez88bExUUaZMsLwsLr3MAKXaQz9KDH/NP/u0L7HLvvmzvSxWk/j+G6qc27nGJmSa34
         LBlKstMvk1aPaQ9PcnUjtL5DtGbsLcte18rDDWavRasAM/QUKjaMj/EVc48Ons5i2zDg
         pS58Bq1HnRJoUJj65ACLTxeCEemtarktOTzhpUXSPZSr+tvX3UGfwjqF6Sg+7CHLSsD0
         qbOg/wxMdZi1TSbHSnaxOEw6ELDDhsKZf5EOHPoATFyvtK+4mg2orQacv7g99Plzz2bu
         CyviMZyo3FFUFwXoriCUSptCngJuxwll5JjpX880kLHvIj3/+65ygYNZVYIEQOWfqYdm
         U45A==
X-Forwarded-Encrypted: i=1; AJvYcCUgd9+h5rQd23z/GK7ISlNYb/jnj4mpfeSd2vtuckoqNtBfpJFiNzICl4qeJvzR3/meHTcGVt83pOQkNIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX1GztAS+K7eUxAA61sG4MjIEJmf/oUUsqhUVhi+wTXPHzefH7
	Kz9mVJ6TEZosnrQrgAwZeCC+hHFoTajubSyd+rz4ug3XbK0+2c4s3MqzWONZ4ss=
X-Google-Smtp-Source: AGHT+IGAvD7jve9I99GoT/BKI80P6y8fMglPCbeBoUgHhPAkZfkRJUQQV//W1VAPjwl3J6cuHo9G2g==
X-Received: by 2002:ad4:5cef:0:b0:6d4:12c:c6cc with SMTP id 6a1803df08f44-6d4012ccda3mr213242956d6.25.1731955417599;
        Mon, 18 Nov 2024 10:43:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40dc41b4fsm38829916d6.59.2024.11.18.10.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 10:43:36 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tD6im-000000037qC-1a8F;
	Mon, 18 Nov 2024 14:43:36 -0400
Date: Mon, 18 Nov 2024 14:43:36 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, tjeznach@rivosinc.com,
	zong.li@sifive.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, anup@brainfault.org, atishp@atishpatra.org,
	tglx@linutronix.de, alex.williamson@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Subject: Re: [RFC PATCH 08/15] iommu/riscv: Add IRQ domain for interrupt
 remapping
Message-ID: <20241118184336.GB559636@ziepe.ca>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
 <20241114161845.502027-25-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114161845.502027-25-ajones@ventanamicro.com>

On Thu, Nov 14, 2024 at 05:18:53PM +0100, Andrew Jones wrote:
> @@ -1276,10 +1279,30 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>  	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>  	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
>  	struct riscv_iommu_dc dc = {0};
> +	int ret;
>  
>  	if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
>  		return -ENODEV;
>  
> +	if (riscv_iommu_bond_link(domain, dev))
> +		return -ENOMEM;
> +
> +	if (iommu_domain->type == IOMMU_DOMAIN_UNMANAGED) {

Drivers should not be making tests like this.

> +		domain->gscid = ida_alloc_range(&riscv_iommu_gscids, 1,
> +						RISCV_IOMMU_MAX_GSCID, GFP_KERNEL);
> +		if (domain->gscid < 0) {
> +			riscv_iommu_bond_unlink(domain, dev);
> +			return -ENOMEM;
> +		}
> +
> +		ret = riscv_iommu_irq_domain_create(domain, dev);
> +		if (ret) {
> +			riscv_iommu_bond_unlink(domain, dev);
> +			ida_free(&riscv_iommu_gscids, domain->gscid);
> +			return ret;
> +		}
> +	}

What are you trying to do? Make something behave different for VFIO?
That isn't OK, we are trying to remove all the hacky VFIO special
cases in drivers.

What is the HW issue here? It is very very strange (and probably not
going to work right) that the irq domains change when domain
attachment changes.

The IRQ setup should really be fixed before any device drivers probe
onto the device.

Jason

