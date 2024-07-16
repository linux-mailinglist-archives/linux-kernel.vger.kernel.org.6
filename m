Return-Path: <linux-kernel+bounces-254045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E94FE932BED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E09EB20B01
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E899719DFA7;
	Tue, 16 Jul 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="icn69atk"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388C719AD93
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144999; cv=none; b=Y+FSCbH2fkSkPozikfzSnGLaIKnuO/WycAfYyimdBh0HVmdaeTPRGoubWy7CoEAkr07BuluZzxKf/F2eSjzJ3CCmpUbgG49vVguDdD4INCg6fvUbrHCgiRRyA633k+lyQQ3CoesOh9nbumeo6TgVEgxCAqUNhrY/Dj+Us5xjNxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144999; c=relaxed/simple;
	bh=J6Na8smUBNkvy7o5hOuNXKrDIV0L07cB3uZ5C3y7QgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsLPOexdpH0Cb1HiDtEWh84XG1j/YT8SgE0n69ETt031Vn6qHH/iblqBgwPzxaJhZPtIbX7Itbp7cv76fAwSXosHsQp/NsmsJd5gY8+PlQLpB/aYn3S0FFCnAzARyBL2p7UW13JYViCd1gjSpvyHIil5T1H52GyCMqPr+xvJXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=icn69atk; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70b702be5e4so2949779b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721144996; x=1721749796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qmk5Z4IT/WUXoxm4I3cPr8Nj8s2eF45loLGWh3Zjhdk=;
        b=icn69atkQv67WbjL5mmFo6GJnbyvzycFkGbDckA8CPMfyYk9EBBBrua48K+rEvuNg4
         TTnOygd7/l24trf3uN7TANFVtaicthKgW3gpsYd9mSJ78jYWf5UJ6rOalgwtz6ih4pjD
         QO+L4QM9f6D5N5QmMahKzWKrPkmaYzAPC8rfnB7OeIxGtBuD9e1HUX095aribThH/vLG
         5PBcGOTRRVHobRBfIm8VjjLv/D0XZqwqO/MUhoRCkC8WnuHLAR6fKSmMn+Ojlor4S5ZT
         QHxdkoNBlxfc2oCo5gVE8o1DAXBY2QbZzSqMiqa1ZIGgtHLmnyPts+f608rgkwA25IZE
         85zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721144996; x=1721749796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qmk5Z4IT/WUXoxm4I3cPr8Nj8s2eF45loLGWh3Zjhdk=;
        b=Sgookq/aZ3kzBjZkqlIWJjAOVy4Czua++aPJmmiAc2q4p8GwF8h+RGcLt7jamq9rhy
         1Ns6oiXUd5bjW437u7AsVHZjw/2ivjBgNMxU87hsaxRBDzsDlw07YqEWXrGw2kjU1E2+
         7N3ieUAPvykLEFXntetI/VJzLXXgOLM9z5yD8H4EM5BCxH24azLsi6vfgpm8tV13Aat/
         a7iPinDIDK7LDVv2xvSjn0ybXNbNWkRQr4XzwBEYahhmNAvewwgiSKLWrlPSnrsWMqs1
         kDPTkNq0tin4dmcSNEOEUFcONW10Cdx7cnLIV4Nx6HGC7Lg5HlWfTGI38jmzl9yxXFGf
         5+1w==
X-Forwarded-Encrypted: i=1; AJvYcCVNhVsXVpegouj16XiRQmP18QDPli+jeBxGwuUdtHzhaSk4gJpiZKJ6OxSkGR2zJM1ZpI0wWQG1hb6y+j3gbfkHPmpal3z3L0W5VjLP
X-Gm-Message-State: AOJu0YzHIAZigkfgumDI+DC1Sy4M2rfA1MZembSuEKuQDXtBQkJRN4y6
	hyt8ZOjCysPkpiJklVP9fdqtYtyPFMoNSuRqVCFtxyN8uu1I4XuBDDyZyBjCRno=
X-Google-Smtp-Source: AGHT+IFgsccCrFEj/kSvTt/1puQQ8yew0zZCPSA1ewKljzJ2CdEca2/4yKweZZ7ydQaRy1tTj7ZnnQ==
X-Received: by 2002:a05:6a00:2381:b0:705:b6d3:4f15 with SMTP id d2e1a72fcca58-70c2e9b5544mr3169227b3a.25.1721144996374;
        Tue, 16 Jul 2024 08:49:56 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:5d01:167d:9cf4:148e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ebb8139sm6472526b3a.80.2024.07.16.08.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:49:55 -0700 (PDT)
Date: Tue, 16 Jul 2024 09:49:52 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH 6/6] remoteproc: imx_rproc: handle system off for i.MX7ULP
Message-ID: <ZpaWoNGH/oQvphVJ@p14s>
References: <20240712-imx_rproc-v1-0-7bcf6732d328@nxp.com>
 <20240712-imx_rproc-v1-6-7bcf6732d328@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712-imx_rproc-v1-6-7bcf6732d328@nxp.com>

On Fri, Jul 12, 2024 at 04:34:59PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX7ULP Cortex-A7 is under control of Cortex-M4. The i.MX7ULP Linux
> poweroff and restart rely on rpmsg driver to send a message to Cortex-M4
> firmware. Then Cortex-A7 could poweroff or restart by Cortex-M4 to
> configure the i.MX7ULP power controller properly.
> 
> However the reboot and restart kernel common code use atomic notifier,
> so with blocking tx mailbox will trigger kernel dump, because of
> blocking mailbox will use wait_for_completion_timeout. In such case,
> linux no need to wait for completion.
> 
> Current patch is to use non-blocking tx mailbox channel when system
> is going to poweroff or restart.
> 
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 01cf1dfb2e87..e1abf110abc9 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> +#include <linux/reboot.h>
>  #include <linux/regmap.h>
>  #include <linux/remoteproc.h>
>  #include <linux/workqueue.h>
> @@ -114,6 +115,7 @@ struct imx_rproc {
>  	u32				entry;		/* cpu start address */
>  	u32				core_index;
>  	struct dev_pm_domain_list	*pd_list;
> +	struct sys_off_data		data;
>  };
>  
>  static const struct imx_rproc_att imx_rproc_att_imx93[] = {
> @@ -1050,6 +1052,22 @@ static int imx_rproc_clk_enable(struct imx_rproc *priv)
>  	return 0;
>  }
>  
> +static int imx_rproc_sys_off_handler(struct sys_off_data *data)
> +{
> +	struct rproc *rproc = data->cb_data;
> +	int ret;
> +
> +	imx_rproc_free_mbox(rproc);
> +
> +	ret = imx_rproc_xtr_mbox_init(rproc, false);

This is new functionality and has nothing to do with the rest of this set.
Please introduce patches 5/6 and 6/6 as part of a new patchset.

Thanks,
Mathieu

> +	if (ret) {
> +		dev_err(&rproc->dev, "Failed to request non-blocking mbox\n");
> +		return NOTIFY_BAD;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
>  static int imx_rproc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1104,6 +1122,24 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  	if (rproc->state != RPROC_DETACHED)
>  		rproc->auto_boot = of_property_read_bool(np, "fsl,auto-boot");
>  
> +	if (of_device_is_compatible(dev->of_node, "fsl,imx7ulp-cm4")) {
> +		ret = devm_register_sys_off_handler(dev, SYS_OFF_MODE_POWER_OFF_PREPARE,
> +						    SYS_OFF_PRIO_DEFAULT,
> +						    imx_rproc_sys_off_handler, rproc);
> +		if (ret) {
> +			dev_err(dev, "register power off handler failure\n");
> +			goto err_put_clk;
> +		}
> +
> +		ret = devm_register_sys_off_handler(dev, SYS_OFF_MODE_RESTART_PREPARE,
> +						    SYS_OFF_PRIO_DEFAULT,
> +						    imx_rproc_sys_off_handler, rproc);
> +		if (ret) {
> +			dev_err(dev, "register restart handler failure\n");
> +			goto err_put_clk;
> +		}
> +	}
> +
>  	ret = rproc_add(rproc);
>  	if (ret) {
>  		dev_err(dev, "rproc_add failed\n");
> 
> -- 
> 2.37.1
> 

