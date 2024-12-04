Return-Path: <linux-kernel+bounces-430925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D919E3751
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8616B29C7A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DE61ADFE3;
	Wed,  4 Dec 2024 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUvcwzU+"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC151AA1DF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733307252; cv=none; b=leU07OB05dsItZf/PmZ0p4kIsVgrKCO2XmBQzJna0yzaKVDdJYhWFb/WCe+UhyUvPF5ACQvbnCYMyUknDhntZUHOIdbtyvVVTx0IpRw7KuVoOxfjq7a7pWgbMV1ka5bMV/OcbaauqetNHws/7+42e+zVWdOiYKmETuWkfYbKW7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733307252; c=relaxed/simple;
	bh=Pb5PvvE+iVrNyh93aC+zFTPSNXVqukPP+d4ZZTW9AUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I53dQV8vKj5rIItKFNecfed5rxN1hVcEr0+sPDPVOndyBPC29YLOd0+sLkI9SDVUbQlWbpidKTDZU9xg9qmEmtjdBOJPz0gIzqUjAXA3AZXjOzP0imXOH0oIT6NeaXjhaM2zznGJube9nVwnCg/Nq/xhcl1aZfRvXenQxWEdxMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUvcwzU+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4349338add3so38135e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733307249; x=1733912049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BMGnNPxPYgtjLytE4uW9hhJz+Jg05BhCFp2UIgwDwC0=;
        b=HUvcwzU+W4tL5uguE7WRUAG2CHcVG0D/HDxckCG+ygsQRztMgaNlqKuq7rIx29J0je
         UpnVlI/QX5JF/aO4gUEufwl5n1pi89Dj82wn9M8oSrDFH8g2T8yE9mEMmJoz5L4/Cylh
         LO2Sp+Z2vSvmxThb89ZGkb78n9w8l5PBwZ1A8aO9hxCTYOJgZEUvs22JMMTRPTz0trHk
         V2lFIeZqw/K/FbDcatF60HCotUgAI1gE1iLG+1y9A+IBdGGSghXzHTuW/P0fjOdcaDGn
         nLtANOOtkpLL1VuuC94P10/OyBjE1dWtCzZOhMu1KX/TRFYIc8L4gMpKJuDStRgzGyEO
         Y8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733307249; x=1733912049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMGnNPxPYgtjLytE4uW9hhJz+Jg05BhCFp2UIgwDwC0=;
        b=GxVz+/hiLKDVZmUVaSryE/zV+NeJOombreGfqFmxIusiqGB8HH1S87bUFULDBqYLGj
         qQa/PJ8pcF0kXRjAELrkx0KiTyatS3MWLFmN63wK9MRVbnC8TNSv3hAjd7wBoBDKb4A6
         QOsF5dAjXq5OZXZaLVQqU7WZDxGJiXhlDapmzMxwULNBelRntLFe+xrUUc4hvsty7Gzn
         kCTj2BQQcG0OS54NiPqhrDMRhdqoEscv3YPFAWeJmCpbFThSMzn2ICFVNrcTijR+SjlB
         zhEeqKvrxi+5mymPnOhFF577KYwFqGEURG6q6PchSz1zNUwHUHQLAJ+YbVtnNLuFiS22
         yJBw==
X-Forwarded-Encrypted: i=1; AJvYcCUIA9CqfPaLN8VXjJ45/72QenoKxuIBh8oV9HhOxegbY06aKsIzNNy+l7ctoiYrhi+3yhjqFxH6wjRC9bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoVsIwQwwneZFQLRpcs606GlOyCHpNbCcIBCU6YzB6JB7eODzU
	K+Q69hrkNaefXIgXGvwc/Raw3aLgpkGwRJDjIhIz8skl84emF574oWjMxFfhzA==
X-Gm-Gg: ASbGncsyPlEYgwU6L7qC6f5b590AArGo/u+TQN17Exm9ihyF8swCG/Xu24qBCOP8q97
	TV0lLOW9+jjqRrZF7Ah/xaz+3ilcO/oUgU6sqI2R9r72z2nOHpbherdaRKOwAOnn0WwKwwFCma0
	zNTo2cf+UWo8l2Oxq1DV7yuwU176wvdaSvW4hKh6D2f4U036OP3WkjgNDZF+wyuy+CLcO1sCSMD
	LXHB09v/zj9vZWEjI7Gp+UVnMRg4bjfsWeSuLXvhOEIOQMy6tovzDHzcmWJQZHaiLfkYnynuJ78
	zAs+TFDWLcFq
X-Google-Smtp-Source: AGHT+IEI5ovyp1RCIv/DEgpLwXFNydHyjD9DBddbq5V/1dJpcQ7kJme1DtYiR17VJHUI0rTtCpgyHQ==
X-Received: by 2002:a7b:ca4d:0:b0:434:9ff3:8ffc with SMTP id 5b1f17b1804b1-434d4aaada7mr918595e9.4.1733307248895;
        Wed, 04 Dec 2024 02:14:08 -0800 (PST)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e4617a61sm12383645f8f.3.2024.12.04.02.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:14:08 -0800 (PST)
Date: Wed, 4 Dec 2024 10:14:04 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 2/4] iommu/io-pgtable-arm: Re-use the pgtable walk
 for iova_to_phys
Message-ID: <Z1ArbJbqAnD-Qn52@google.com>
References: <20241028213146.238941-1-robdclark@gmail.com>
 <20241028213146.238941-3-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028213146.238941-3-robdclark@gmail.com>

Hi Rob,

On Mon, Oct 28, 2024 at 02:31:38PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Re-use the generic pgtable walk path.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  drivers/iommu/io-pgtable-arm.c | 74 +++++++++++++++++-----------------
>  1 file changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 7e9c0f8ae138..88b128c77893 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -712,42 +712,6 @@ static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iov
>  				data->start_level, ptep);
>  }
>  
> -static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
> -					 unsigned long iova)
> -{
> -	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> -	arm_lpae_iopte pte, *ptep = data->pgd;
> -	int lvl = data->start_level;
> -
> -	do {
> -		/* Valid IOPTE pointer? */
> -		if (!ptep)
> -			return 0;
> -
> -		/* Grab the IOPTE we're interested in */
> -		ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
> -		pte = READ_ONCE(*ptep);
> -
> -		/* Valid entry? */
> -		if (!pte)
> -			return 0;
> -
> -		/* Leaf entry? */
> -		if (iopte_leaf(pte, lvl, data->iop.fmt))
> -			goto found_translation;
> -
> -		/* Take it to the next level */
> -		ptep = iopte_deref(pte, data);
> -	} while (++lvl < ARM_LPAE_MAX_LEVELS);
> -
> -	/* Ran out of page tables to walk */
> -	return 0;
> -
> -found_translation:
> -	iova &= (ARM_LPAE_BLOCK_SIZE(lvl, data) - 1);
> -	return iopte_to_paddr(pte, data) | iova;
> -}
> -
>  struct io_pgtable_walk_data {
>  	struct io_pgtable		*iop;
>  	void				*data;
> @@ -763,6 +727,41 @@ static int __arm_lpae_iopte_walk(struct arm_lpae_io_pgtable *data,
>  				 arm_lpae_iopte *ptep,
>  				 int lvl);
>  
> +struct iova_to_phys_data {
> +	arm_lpae_iopte pte;
> +	int lvl;
> +};
> +
> +static int visit_iova_to_phys(struct io_pgtable_walk_data *walk_data, int lvl,
> +			      arm_lpae_iopte *ptep, size_t size)
> +{
> +	struct iova_to_phys_data *data = walk_data->data;
> +	data->pte = *ptep;
> +	data->lvl = lvl;
> +	return 0;
> +}
> +
> +static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
> +					 unsigned long iova)
> +{
> +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> +	struct iova_to_phys_data d;
> +	struct io_pgtable_walk_data walk_data = {
> +		.data = &d,
> +		.visit = visit_iova_to_phys,
> +		.addr = iova,
> +		.end = iova + 1,
> +	};
> +	int ret;
> +
> +	ret = __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
> +	if (ret)
> +		return 0;
> +
> +	iova &= (ARM_LPAE_BLOCK_SIZE(d.lvl, data) - 1);
> +	return iopte_to_paddr(d.pte, data) | iova;
> +}
> +
>  static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
>  			    struct io_pgtable_walk_data *walk_data,
>  			    arm_lpae_iopte *ptep, int lvl)
> @@ -780,8 +779,9 @@ static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
>  		return 0;
>  	}
>  
> -	if (WARN_ON(!iopte_table(pte, lvl)))
> +	if (!iopte_table(pte, lvl)) {
>  		return -EINVAL;
> +	}
>  
>  	ptep = iopte_deref(pte, data);
>  	return __arm_lpae_iopte_walk(data, walk_data, ptep, lvl + 1);
> -- 
> 2.47.0
> 

