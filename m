Return-Path: <linux-kernel+bounces-321512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABFE971B7D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62651F24205
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B56E1BAECA;
	Mon,  9 Sep 2024 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="seVRIdNv"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ADD1BA898
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889563; cv=none; b=Qv8cjuaAGs8nXQiLbhpl9HIEjtoi9+t1Q0FKIdccl8SFxxhSFTKCqrBzwUxrqg/tMSA58vzm6ONfgJxHumAk5dxmvlziREqZh1Jf92nBRy7ZEyXElsapPmJZXfSs31dS9irVS1g0X5W8WXLhgfvtQGbPHUor7l7Mjx1sA7MAox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889563; c=relaxed/simple;
	bh=jzihi3AAHohMCS8Dgz06LgVPmIDnmeWhSRP3zVQyAG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bopT8mbSxx8Jsthm1Dz7MscEG4LhYRWdHBHLy1xwVwfOd4Vei/r1b+Z5sxV1TotcpiRa4KsWTlORnHxeEPFeOwEPgIgtBS9CQ1P9aCvOWxE+16XLX8Di+OHZrrSH6uEuuFuDQ6x/EIbqkpfYbJG+NDuocIf6vJiA/d2l2CHpEQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=seVRIdNv; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d43657255so191005766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725889558; x=1726494358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ICHhUdve8YGyfEsZ3J3BPheEBsB760qWMEEBxUepSFk=;
        b=seVRIdNvLmKA0h7bIqZTZ0OrjfVDSdOaKIkLt2MYRdj3bh9YzwqsVN9NuneIiJ1mjc
         j1F0FtkC3PNqxChLIbnEbx8fCF0Qnu6L/1vVmz3kXnZyVmFxj8OWoSs1jc1lUhTB9tGU
         i6KC0/VxTH2nmZfcrvWFYkL+SlRHpA/uRqwbxbZRSeWexCn+8yoZyNo+mYVi5MBwW3iO
         JuIG6IfN8U5CKW2P6xI8ITaDRe5sAs9slIpOYi/fZfsLg2YVWtfOyg5w4DSp+QDwfy+m
         cvuQq3ORtWUsDpkkj43c+JQvfpF54GLe2Q3Or4/RD/iBo0SWzFriah0G+aHMhETq8G0W
         HA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889558; x=1726494358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICHhUdve8YGyfEsZ3J3BPheEBsB760qWMEEBxUepSFk=;
        b=Ua2BEh0Dk/M0WaBNrUY1znxMrEeZhUD5Qaft/gPOxbj2P9u59dOFSkTXYB4JTlU5oS
         eqmI/dEvcb8wZCRsc6uciDe5Mz+Hxs6nCDSRARKjTJuk+G6iMsu7oi15WXuclIN9ljUK
         X43TpCx0bZ9TZd0/fp784PSh6jVms+JUBiZRvz62P/SHkmSmVxh6egf5BSLUf98grKCg
         kKceVyy+VmHm9SGLFDDuC78h2+YiEE+F6WDAFgZgzGT4LRQC9JyIv9W2ox6pN2PYjEcx
         gszG6BQIOHKZvvTYrHduaNjgJ/oIMk45mYglZpjihTOqGcIkCBXiuJ/+0jKCpQGAPuOi
         R6Uw==
X-Forwarded-Encrypted: i=1; AJvYcCU+fLkg58Go+jkOtwhW1i4y+1QYwPfqW7rvFl3ikpfeBvg/fWvATj/BqKdMvnZ4WFnvef1Xowyk2L1l4mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyXd0p9Hwy1WGQdH7bW3E//5RpnvMD0Q02CPLV3Ubyrt52ak6Y
	tQtBaZzfQstaCf2NpMR89VTBBXPbiye8o7ggeXamMeu68r52F+wFEj9ncdQQIG0=
X-Google-Smtp-Source: AGHT+IFSoHDLd5CxoOPYrLPB59BFyKQbFAvz3qMC62eNkL9xiTGIxxXZg05l93GHxJb2ToC1z/SlNQ==
X-Received: by 2002:a17:907:2d9e:b0:a8a:91f4:fd30 with SMTP id a640c23a62f3a-a8d2494b9d8mr642973166b.56.1725889557837;
        Mon, 09 Sep 2024 06:45:57 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:83d8:caa7:e645:3612:56b6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c80a24sm345022366b.137.2024.09.09.06.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:45:57 -0700 (PDT)
Date: Mon, 9 Sep 2024 15:45:56 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
	Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>, 
	Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] pmdomain: ti_sci: add wakeup constraint management
Message-ID: <rtdegcb5ypszuoqgc4rwcp4vo6wpkybfreo5of4pxxw3lr2qrk@uvhwbiq4mmmy>
References: <20240906-lpm-v6-10-constraints-pmdomain-v4-0-4055557fafbc@baylibre.com>
 <20240906-lpm-v6-10-constraints-pmdomain-v4-2-4055557fafbc@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240906-lpm-v6-10-constraints-pmdomain-v4-2-4055557fafbc@baylibre.com>

On Fri, Sep 06, 2024 at 09:14:50AM GMT, Kevin Hilman wrote:
> During system-wide suspend, check all devices connected to PM domain
> to see if they are wakeup-enabled.  If so, set a TI SCI device
> constraint.
> 
> Note: DM firmware clears all constraints on resume.
> 
> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Tested-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best
Markus

> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index bb95c40ab3ea..1ab1e46924ab 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -74,6 +74,21 @@ static void ti_sci_pd_set_lat_constraint(struct device *dev, s32 val)
>  			pd->idx, val);
>  }
>  
> +static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
> +{
> +	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
> +	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
> +	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
> +	int ret;
> +
> +	if (device_may_wakeup(dev)) {
> +		ret = ti_sci->ops.pm_ops.set_device_constraint(ti_sci, pd->idx,
> +							       TISCI_MSG_CONSTRAINT_SET);
> +		if (!ret)
> +			dev_dbg(dev, "ti_sci_pd: ID:%d set device constraint.\n", pd->idx);
> +	}
> +}
> +
>  /*
>   * ti_sci_pd_power_off(): genpd power down hook
>   * @domain: pointer to the powerdomain to power off
> @@ -115,6 +130,8 @@ static int ti_sci_pd_suspend(struct device *dev)
>  	if (ti_sci_pd_is_valid_constraint(val))
>  		ti_sci_pd_set_lat_constraint(dev, val);
>  
> +	ti_sci_pd_set_wkup_constraint(dev);
> +
>  	return 0;
>  }
>  
> 
> -- 
> 2.46.0
> 

