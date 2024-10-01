Return-Path: <linux-kernel+bounces-346039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 505A998BEA3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B261F21A9B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A459A1C6F45;
	Tue,  1 Oct 2024 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kZ4g7tHw"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398681C6F4C
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790822; cv=none; b=r9sIB4BtYc/eAT3ysllFMj5s8JoomDZQC0Rp1GxzhVKMr+aAcqGVv4gAuiQ6tl0EMeHJxIAU7vM/iNjkNchyG0SaRtUXyNSBnFv036dGqipk6HTw6SUJwHdvyfnB+YU96kFO7n9SszukcR0zvH+Sdnn7B5ZJr5jtBTOwpIEVhjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790822; c=relaxed/simple;
	bh=YevOv9CXMoCsWPZuusUeDfG4SKOg29+imb4Q0/GC8UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEjHa2rWDXTpbdyP1UULVdIMHVJ+I9A89tMcgc6vGSS43GNbGq4NQwvMlNU0zg4ES9IlsmFKs42Sy6CGUIvS8haNhKVhWhWakbIIUqdODJGrErk7yl2eogs1qZGSFWWD5dHjZKIKk+lm9LjMYXTZRM+kke4uDsaHdn9B0ZrzmOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kZ4g7tHw; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-45812fdcd0aso57297841cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 06:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1727790819; x=1728395619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mFQGAUbeSLfIECNGNmCvVLq1+ZKKwQ4FuJAi/d5WHE4=;
        b=kZ4g7tHwyPVVQ8SW7zKISIEcqAd/ke7mh+tQFrNLtHV8wwCSx4xcClfEx5VTCqeid2
         12DyMv2KRGzl6euVBRueDX2TLfqp3ifg3p3TPNzZg5e/xLHuMa/cWP7WHbjyGV6rTRRC
         NunynNCFbdQKLrarIH7CHQDx75NKfYJ3sUgDvX9AjLEu1lUDfBggVyEfZ2V34TOIzWzr
         BdvKsLrKJvWMKirBd89bSO4a2mkhNMeJVsqEyr0FE1DLg5/ZXP+zQonVqhPR6qjhQvv5
         fPbb8+vzZEQgwHma8IxLFSbH++B3V5WuVdC3+fCUstMk9je6YmJje2uUsf5lvrhmTnJa
         Ro5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727790819; x=1728395619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFQGAUbeSLfIECNGNmCvVLq1+ZKKwQ4FuJAi/d5WHE4=;
        b=Hkz/A29a8Q0w3CCphaLCVccKurmaFAe9Llc+FkbjCbfmB3VUuzyuAl00fho7Tb+/jT
         Grh4P3sIeSLr7zyaBjgv1cJiqOrWjn/atoIPcH+K+XrqnORGaNtPmCjtNFjcwFVtFL/N
         4i9gy02kmJpi8PBThmekiFx7IgrT6Ri2kkoVdqv4uUZb0T7UL7pHz39n78Rkc9v9g+ZW
         mc2qJzTJrH9PcE9WzEAkQEGF7OMjR7dubuYyYID6MGnoNjGlD74CcdLE5PEBZRwlPROx
         KPMn+Ltu4PXzwusYZUT0LHgJ55TSE00YHJaFTLe4Ljnikmmo3MwUvMyw0fZzJCubHTHa
         h5tA==
X-Forwarded-Encrypted: i=1; AJvYcCVG4PxzrPeWB93JjIQC5sltkTG05R/vVXI1iSSiDPy/8MuHPyOzHcnzN4Acr+14dwDNYhDnQt99E9dihOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMbxZTD69+DAnhMhf58zOmuGgTxbfTcUr61OLBCneqv/fu8ltQ
	XgKvXOHly/m9cctFNWZ+eeDlnjwRhJ/z1NguyESHVtTycv15OL2EWCQ0hzXPyF8=
X-Google-Smtp-Source: AGHT+IGMDILuJiNlDpH4UzWMjHVo6B9bDl4Xt7zGachG89go3KLnheesJvns9n3q9CHL3y+JdKAKXg==
X-Received: by 2002:a05:6214:260a:b0:6c3:575a:a975 with SMTP id 6a1803df08f44-6cb7291621dmr51931186d6.2.1727790819112;
        Tue, 01 Oct 2024 06:53:39 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b600f32sm49887686d6.22.2024.10.01.06.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 06:53:38 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:53:09 -0400
From: Gregory Price <gourry@gourry.net>
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [RFC 3/5] cxl: Separate coherence from target type
Message-ID: <Zvv-xTGGTZee_fr8@PC2K9PVX.TheFacebook.com>
References: <20240925024647.46735-1-ying.huang@intel.com>
 <20240925024647.46735-4-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925024647.46735-4-ying.huang@intel.com>

On Wed, Sep 25, 2024 at 10:46:45AM +0800, Huang Ying wrote:
> Previously, target type (expander or accelerator) and
> coherence (HOSTONLY (HDM-H) or DEV (HDM-D/DB)) are synonym.  So target
> type is used to designate coherence too.  However, it's possible for
> expanders to use HDM-DB now.  So, we need to separate coherence from
> target type.
> 
> Accordingly, the HOSTONLY field of decoder ctrl
> register (CXL_HDM_DECODER0_CTRL_HOSTONLY) need to be set according to
> coherence.
> 
> The coherence of decoders can not be determined via target type too.
> So, accelerator/expander device drivers need to specify coherence
> explicitly via newly added coherence field in struct cxl_dev_state.
> 
> The coherence of each end points in a region need to be same.  So, the
> coherence of the first end point is recorded in struct region.  Which
> will be checked against the coherence of all other end points.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/hdm.c    | 22 +++++++++++++++-------
>  drivers/cxl/core/mbox.c   |  1 +
>  drivers/cxl/core/port.c   |  1 +
>  drivers/cxl/core/region.c | 37 ++++++++++++++++++++++++++++++++++---
>  drivers/cxl/cxl.h         |  9 +++++++++
>  drivers/cxl/cxlmem.h      | 11 +++++++++++
>  6 files changed, 71 insertions(+), 10 deletions(-)
> 

Reviewed-by: Gregory Price <gourry@gourry.net>

> @@ -1925,6 +1933,29 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> +	/* Set the coherence of region to that of the first endpoint */
> +	if (cxlr->coherence == CXL_DECODER_INVALIDCOH) {
> +		unsigned long flags = cxlrd->cxlsd.cxld.flags;
> +		enum cxl_decoder_coherence coherence = cxled->cxld.coherence;
> +
> +		cxlr->coherence = coherence;
> +		if ((coherence == CXL_DECODER_HOSTONLYCOH &&
> +		     !(flags & CXL_DECODER_F_HOSTONLYCOH)) ||
> +		    (coherence == CXL_DECODER_DEVCOH &&
> +		     !(flags & CXL_DECODER_F_DEVCOH))) {

silly nit but my gut tells me we can make this less ugly.
Not a blocker though.

> +			dev_dbg(&cxlr->dev,
> +"%s:%s endpoint coherence: %d isn't supported by root decoder: %#lx\n",
> +				dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +				coherence, flags);
> +			return -ENXIO;
> +		}

