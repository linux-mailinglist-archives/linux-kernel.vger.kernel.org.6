Return-Path: <linux-kernel+bounces-321643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC007971D7A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A500284442
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37AB1A716;
	Mon,  9 Sep 2024 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="L8rRQggL"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1112C8DF;
	Mon,  9 Sep 2024 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894390; cv=none; b=Ri0AzpEdiac5tTr4MTW0KHHgvnqtKPyqgIRoWEy3rK2MECMR3q/rlNnwLM8GrIymi1279vlWC0bIlX8FZ9fOwsqq8ao5qLVhVVivgzGTs7/gp5/EB7C2Vt4NPSsg5ZHGSseNstjkUbQOSHLpoUrpxHz9IM1koHbD+RlvjpIJJFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894390; c=relaxed/simple;
	bh=mEfzBH9UUDzeL64oVGZ9YG8/E8wuV86GjdrFpI0djI0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzQ6QAwTfxG6kfJ6AGaVFmlLKBY8G7O+jID0x3AcKkKG3u1IPv9eDv27TBc53n0pTHq04zHPBeEMheX3YPvff4wWWWQwFXen3G/cJthIa024uTL5EzRqnsn4+uIERqUXMDYNi5d5gzY78/adzfG3ffsUXXkDEiLkLeXc/ugKdXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=L8rRQggL; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4895bC0D012744;
	Mon, 9 Sep 2024 10:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=Zt6fqKJBYcIvDy1BdE
	RA1l4JfqzuzikdZ3MHUwdqk84=; b=L8rRQggLGWeLyvDOxoKhLMIdYB0TFR1KN1
	exRSH6XUaC5SP7diOAYBJFymw/JiuKqwvRzzUu4i5EdUdLgGFmbS7h9glosJIgcC
	DWLunoaFVia3GHpntz/3M5Mlpfu4tLJfTm8hAeFbjBdwsrywXqBWyj1BB/KoFhcG
	BxI5tlDEhrR2Ju0y2fzTbmWTZICbwkC8OuSUlYH75zWhutoxtCyukaXnSmGknLTj
	BPgMwLZPu0tILt8lkqdtTkzHC4OGLcMWvHI0MANZhjeAcZj3wGNT8owiHkC7Qsw7
	BfpqPg0qITZU136T2kdjLQZfVuZhvcKD+PZyZqNfVDnfVQ4inb4Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 41gm7x1rnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 10:06:20 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Sep 2024
 16:06:16 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 9 Sep 2024 16:06:16 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 6244E820249;
	Mon,  9 Sep 2024 15:06:16 +0000 (UTC)
Date: Mon, 9 Sep 2024 16:06:15 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
CC: <linux-sound@vger.kernel.org>, <vkoul@kernel.org>, <vinod.koul@linaro.org>,
        <linux-kernel@vger.kernel.org>, <pierre-louis.bossart@linux.intel.com>,
        <bard.liao@intel.com>
Subject: Re: [PATCH 13/14] soundwire: mipi-disco: add new properties from 2.0
 spec
Message-ID: <Zt8O54x+NVu+UwwD@opensource.cirrus.com>
References: <20240827130707.298477-1-yung-chuan.liao@linux.intel.com>
 <20240827130707.298477-14-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240827130707.298477-14-yung-chuan.liao@linux.intel.com>
X-Proofpoint-GUID: loWlG_imP7-qyd1LNjPwKrEbs4n25qnr
X-Proofpoint-ORIG-GUID: loWlG_imP7-qyd1LNjPwKrEbs4n25qnr
X-Proofpoint-Spam-Reason: safe

On Tue, Aug 27, 2024 at 09:07:06PM +0800, Bard Liao wrote:
> diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
> index d6eb63bf1252..2215c53f95de 100644
> --- a/drivers/soundwire/mipi_disco.c
> +++ b/drivers/soundwire/mipi_disco.c
> @@ -398,6 +398,19 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
>  	device_property_read_u32(dev, "mipi-sdw-sink-port-list",
>  				 &prop->sink_ports);
>  
> +	device_property_read_u32(dev, "mipi-sdw-sdca-interrupt-register-list",
> +				 &prop->sdca_interrupt_register_list);
> +
> +	/*
> +	 * The specification defines the property value as boolean, but
> +	 * the value can be defined as zero. This is not aligned the
> +	 * implementation of device_property_read_bool() which only checks
> +	 * the presence of the property.
> +	 * Let's use read_u8 to work-around this conceptual disconnect.
> +	 */
> +	device_property_read_u8(dev, "mipi-sdw-commit-register-supported",
> +				&prop->commit_register_supported);

Would this not be a case for the new helper added earlier in the
series? Or is this some third type of boolean?

Thanks,
Charles

