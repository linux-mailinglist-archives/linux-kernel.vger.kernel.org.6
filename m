Return-Path: <linux-kernel+bounces-171631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341AF8BE6A7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCE01F22411
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4502816079C;
	Tue,  7 May 2024 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ev397yBm"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B73815FCFC
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093701; cv=none; b=Tr0cKpIcYD7pehzKBs3Ar18drrBgTmpzlBrdyf+7ZhdPlwXdPyFsdT8dtzmZ5EOvszRk/k2Wa6A2cm/0zbECz5YAPdlxW5XSTxllZWl33vFJP6vhuCY1Qm8k/xwm9cBZP2uF/fjFYyHvBwL+cjz7czQTELukrw6f9bKD7TUwqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093701; c=relaxed/simple;
	bh=aJBG7fQrQyWTcB7pmO14FhgdBgyrVV0OZ6xe6YRLkUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bm0PdpYlo1NdIut9dU7gGbtF67PrA5SwzwViVMryfjhI9b50f54vIxyCo+OMRDSIlD1WJUfUWHFhHrGyvhdJVZFxiEFfdhdmhruc5xHhS5PrqZtimfnjUD4BeVQNlESzCiTURcdBXjSQrZ64gkA2h0JApY/hF3mMP7qgGUl3os4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ev397yBm; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c968f64cdeso771558b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715093698; x=1715698498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=khya5nPWsz8iIm1AQ53Aurao/H+Jj1OPdGrhqcoxtig=;
        b=Ev397yBmkId8A2Ow87CoPrfRISoQETzfQJl8LWD6CDS72yC4LKy/nEV5ixjNAWZVF/
         XgpBRIPaSrWFR86+QGEKum7+uJytwVR0nrKwGMIrI30pckPua0EHT76pj1uwssdEuAf9
         o9ZgpudO6RiHQbwIUlstiMDQrBVDpc9iGtcAbujmVbxMuDA9iaeKMsxKxc+VKhsQkyRb
         8yr5BSN2Ygo2wtcwgjUcof6UOImr6MOho1yXSFdQcSB4Ze+AlgqkhM4J8tBZw8nTuXB/
         3ljJoqkG29E13iJLQsGTrXjHEHYoTFr+O9okDBmVz3aFU18cH/V4QLbezwa3GB86wIK0
         tX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715093698; x=1715698498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khya5nPWsz8iIm1AQ53Aurao/H+Jj1OPdGrhqcoxtig=;
        b=OwtsQIs8VvNKpwu4AA/IycSQzYrPhcL0MKOIZomM0AMuyYIYi5iCQh8Irh04zfCyQp
         QSG0xOxSm2xZjIx2aXUXWcLvNg6kcOp+YHLicXPOwTTNJqVEnxmabXJ6bQkWhIHK1WR2
         p2XbOJmDGj50XSUFbEeoYDiAgV9xP/fWAEJ8saJY2Rizv+hV0Ye+Ri23k4eqKD0JxNO6
         CAMmdMFK7mOujLmWPOfk5BFsDpWUNbMyOgEH4G+41/EruAF2qIrcPIOoDVbfCeUrygap
         N7h7UknBbv0G+a60w1GhXRMIVuQyVdbfZbeWjIEKVEMNpbcbb8TWhAYKC7DO7bY666Tx
         WNcw==
X-Forwarded-Encrypted: i=1; AJvYcCUhGBfmoH1y+99RCyV7KC3Jx7yIsBbt/iAa6mU8isIPx9G31xbjvBzqbUYNQY09xEGH0nzjuvAiZy3Q1PoK66ihRQ3a7jiwlDpfEJQt
X-Gm-Message-State: AOJu0YzLofzV5X3PTPDnn0EmL5/waKPFctdWN9W7Kq2OXXz/gDPZRJQN
	qcwP9QZBHqLlSbZ6zBJJ334F1D8nVZ1dq6zvSGnpq25KbXf+qUaCnLBQ36H+xVk=
X-Google-Smtp-Source: AGHT+IH06U/MvUqSaZ8CzKk8w5FX8P/20f3bpgKLuBxThf4yEkosHT9oMIC/YgbQ5imbHRsONRdCTA==
X-Received: by 2002:a05:6808:16a9:b0:3c7:79c:72c9 with SMTP id bb41-20020a05680816a900b003c7079c72c9mr19634594oib.54.1715093698542;
        Tue, 07 May 2024 07:54:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id v16-20020a056808005000b003c96907bd58sm981178oic.50.2024.05.07.07.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:54:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4MDY-00825J-2j;
	Tue, 07 May 2024 11:54:56 -0300
Date: Tue, 7 May 2024 11:54:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC RESEND 4/6] iommu/riscv: support nested iommu for
 getting iommu hardware information
Message-ID: <20240507145456.GH901876@ziepe.ca>
References: <20240507142600.23844-1-zong.li@sifive.com>
 <20240507142600.23844-5-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507142600.23844-5-zong.li@sifive.com>

On Tue, May 07, 2024 at 10:25:58PM +0800, Zong Li wrote:
> +{
> +	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> +	struct iommu_hw_info_riscv_iommu *info;
> +
> +	if (!iommu)
> +		return ERR_PTR(-ENODEV);

This is not possible, don't include impossible checks like this.

> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return ERR_PTR(-ENOMEM);
> +
> +	info->capability = iommu->caps;
> +	info->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
> +
> +	*length = sizeof(*info);
> +	*type = IOMMU_HW_INFO_TYPE_RISCV_IOMMU;
> +
> +	return info;
> +}
> +
>  static int riscv_iommu_device_domain_type(struct device *dev)
>  {
>  	return 0;
> @@ -1560,6 +1582,7 @@ static void riscv_iommu_release_device(struct device *dev)
>  static const struct iommu_ops riscv_iommu_ops = {
>  	.pgsize_bitmap = SZ_4K,
>  	.of_xlate = riscv_iommu_of_xlate,
> +	.hw_info = riscv_iommu_hw_info,
>  	.identity_domain = &riscv_iommu_identity_domain,
>  	.blocked_domain = &riscv_iommu_blocking_domain,
>  	.release_domain = &riscv_iommu_blocking_domain,
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 1dfeaa2e649e..ec9aafd7d373 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -475,15 +475,28 @@ struct iommu_hw_info_vtd {
>  	__aligned_u64 ecap_reg;
>  };
>  
> +/**
> + * struct iommu_hw_info_riscv_iommu - RISCV IOMMU hardware information
> + *
> + * @capability: Value of RISC-V IOMMU capability register
> + * @fctl: Value of RISC-V IOMMU feature control register
> + */

Please call out explictly what spec these values come from.

> +struct iommu_hw_info_riscv_iommu {
> +	__aligned_u64 capability;
> +	__u32 fctl;
> +};

Add explicit padding here

Jason

