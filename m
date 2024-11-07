Return-Path: <linux-kernel+bounces-399722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A689C036E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DAEE1C21EA9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD391F4280;
	Thu,  7 Nov 2024 11:08:32 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191421F12F9;
	Thu,  7 Nov 2024 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977711; cv=none; b=lSZ2VIrrFz+JtwtZ0K2rHXBpfaO8XQixD1Tg07e3ncPeJnEWde7QfyPqgPp3RRFkua5Gutd+3X8f8dK8m2WxsuFvVgIVmzfGWJB4w152Wc0iFFR38I4np5ytRwARi5B+nkFebGQSjrqKOU+I7LnA0YTVXXL2lfBCt5hZ1u03R2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977711; c=relaxed/simple;
	bh=Z7Xqgehlx8wZTxjCgV/aoC/vyS4B8U7q2wXoaRWeyiE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HW52O0iM4xHDaJJ/G9K4rwh36qFCQ8TyznPiH9uPASSDootQIiPHGO7JntIR+4vXWfN1oodKs1ezgjVpPpB6cZpv5ELHu7xeT3QpQAaRBKq1oC6lKutgunndcaPtEg/8ibyqfdEgcnz5stz8mdg2HLr47vqxdEtrkacnUMfPHsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XkfST2ntzz6LDGF;
	Thu,  7 Nov 2024 19:08:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3660A140CB9;
	Thu,  7 Nov 2024 19:08:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 7 Nov
 2024 12:08:12 +0100
Date: Thu, 7 Nov 2024 11:08:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Navneet
 Singh" <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, "Andrew
 Morton" <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, "Alison Schofield"
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/27] cxl/hdm: Use guard() in cxl_dpa_set_mode()
Message-ID: <20241107110810.00000fc1@Huawei.com>
In-Reply-To: <20241105-dcd-type2-upstream-v6-5-85c7fa2140fe@intel.com>
References: <20241105-dcd-type2-upstream-v6-0-85c7fa2140fe@intel.com>
	<20241105-dcd-type2-upstream-v6-5-85c7fa2140fe@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 05 Nov 2024 12:38:27 -0600
Ira Weiny <ira.weiny@intel.com> wrote:

> Additional DCD functionality is being added to this call which will be
> simplified by the use of guard() with the cxl_dpa_rwsem.
> 
> Convert the function to use guard() prior to adding DCD functionality.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

You missed some RBs from v5 and I don't think this changed.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Davidlohr also gave one.

> ---
>  drivers/cxl/core/hdm.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 3df10517a3278f228c7535fcbdb607d7b75bc879..463ba2669cea55194e2be2c26d02af75dde8d145 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -424,7 +424,6 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *dev = &cxled->cxld.dev;
> -	int rc;
>  
>  	switch (mode) {
>  	case CXL_DECODER_RAM:
> @@ -435,11 +434,9 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  		return -EINVAL;
>  	}
>  
> -	down_write(&cxl_dpa_rwsem);
> -	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
> -		rc = -EBUSY;
> -		goto out;
> -	}
> +	guard(rwsem_write)(&cxl_dpa_rwsem);
> +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
> +		return -EBUSY;
>  
>  	/*
>  	 * Only allow modes that are supported by the current partition
> @@ -447,21 +444,15 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  	 */
>  	if (mode == CXL_DECODER_PMEM && !resource_size(&cxlds->pmem_res)) {
>  		dev_dbg(dev, "no available pmem capacity\n");
> -		rc = -ENXIO;
> -		goto out;
> +		return -ENXIO;
>  	}
>  	if (mode == CXL_DECODER_RAM && !resource_size(&cxlds->ram_res)) {
>  		dev_dbg(dev, "no available ram capacity\n");
> -		rc = -ENXIO;
> -		goto out;
> +		return -ENXIO;
>  	}
>  
>  	cxled->mode = mode;
> -	rc = 0;
> -out:
> -	up_write(&cxl_dpa_rwsem);
> -
> -	return rc;
> +	return 0;
>  }
>  
>  int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> 


