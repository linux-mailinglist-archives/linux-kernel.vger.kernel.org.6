Return-Path: <linux-kernel+bounces-300998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFAC95EB66
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF75B1F2057F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D061A4D8C3;
	Mon, 26 Aug 2024 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mGhkX/41"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D7F4EB51
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659655; cv=none; b=HNeP5yDUwF0GlmJt4+GAuwin5jHVPCIDrA7BkcjmmALD7inG6Tn4YldY2yvnRSCF7yPCC8doieGYEYWkudpLP075o5XFw6GE+L4f5XcOj6rZs+0Fce+b1d8WVlsXxikzONS22C4Bn2ikbxzRuLGb6D4no4I6TWRpfX5kmOzo3bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659655; c=relaxed/simple;
	bh=hV7TuaBbJxdh8PMDEbM6FyaOUO1HfxZZRMdSrK8OE5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRg208+J1aUVy7y/swzTU9uTVEZXUnRRu8ep1N2RwhD/4UqM5oPzzNpQFzglZM2joZ1IodoWepEmBbViYhbU5rB07HsiYPY3F49LiCTPi+zKIiZKjv0jOXcBJnice0ERf+xYTx802vVtvL/g+N1fCntxjtn247+4jo4PxWRjivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mGhkX/41; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d427fb7c92so2839448a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724659653; x=1725264453; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yvPqTM9lOHuvyIm7/RZh/RxFxg0X7bP4l3quDfoGQkE=;
        b=mGhkX/41zpNBPhM4n3N6tSnwSYIJ9AnNlHHW9d4QKj0WsmQjdaP3XK6Duf2j4MiAEt
         OJ6LeCMg63DuXUpn2JGsqPHUw1wfoyD0U2PQwyK25QT14nwvKdKfjsXvcrnNJ32Dl8Bt
         byQGbhHsq/gcV5FpSaQl1MIz40bjgyZYxD2XXllPZ4aDE7txQyALd/ejJ3SptRntF+g9
         FCU73xOR80nDekvOFMPlqm64+jYzoZF/GzSs2xdV5237vOKbSqgbjNwemLtCEPJST5QD
         9yCObn6lUYYB5YdXKyJNGaT6qY+UFhY4wpf/Y5ISQ9ebXR/p6ZA8NgJkMi7vNbhR6mVv
         AHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724659653; x=1725264453;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvPqTM9lOHuvyIm7/RZh/RxFxg0X7bP4l3quDfoGQkE=;
        b=ifE00oLUD7h0QL1kzWROpQGF45y1DAJjJcZAM/ef1nAyFFMTt7/vXRBWBFXABZam2N
         DtyuGPBOX3nzKKRsBP7DP6YD4Y0WZGqKZ1lYE6e9NPAN8Ncz/6uDHrZeRVZk2grM2wat
         +miKyeyMYbm2ibfwfB7Qs+2LHG+Kb5SC21oUqW24XdDPlymdzTJMODHCQ86T4Obg8vxD
         uFQJciBXN0aSD0WyBPkuIrXQBsJ3Yh0qnG0jinhzEJVfPl9MZuQisFAp39n+JnNYGcKr
         h96rMCwv+CgeglCTkNhCh95QpS4YWCmElbUuyTM9HHvIx2bAJPU/bIts09ThBDCjoDZB
         AvOA==
X-Forwarded-Encrypted: i=1; AJvYcCUIe4swsbA9QACBkmnFuNn8gjF9027y/eq9xaBDeSdWzWRAap3+jPtH+Ai4owp7DtNtEqZT6ptb1GfZ+N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVmAQMoU/qiEtUjH2MYCVx5sRalj7hnU86kNkoro3uSLUi6Mpo
	d5rPkfThoqkVXJ4cFs4okZBSQLOfK6ztzukSGANnATYAeRDlVje++FwYkVu/BQ==
X-Google-Smtp-Source: AGHT+IFX23Te10Zeki5eDRR2JQF2WuxBqrUSKbBm0Dtnccf1x4S1ehHPRhh557+EAHWGUsykWovd3Q==
X-Received: by 2002:a17:90b:4f83:b0:2c9:80fd:a111 with SMTP id 98e67ed59e1d1-2d646bf2bd3mr8610579a91.18.1724659652847;
        Mon, 26 Aug 2024 01:07:32 -0700 (PDT)
Received: from thinkpad ([220.158.156.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613b1cc67sm9071887a91.51.2024.08.26.01.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 01:07:32 -0700 (PDT)
Date: Mon, 26 Aug 2024 13:37:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Daniele Palmas <dnlplm@gmail.com>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Fix the name for the Telit
 FE990A
Message-ID: <20240826080728.myy5whs5kmghnvvo@thinkpad>
References: <20240820080439.837666-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240820080439.837666-1-fabio.porcedda@gmail.com>

On Tue, Aug 20, 2024 at 10:04:39AM +0200, Fabio Porcedda wrote:
> Add a mhi_pci_dev_info struct specific for the Telit FE990A modem in
> order to use the correct product name.
> 
> Cc: stable@vger.kernel.org # 6.1+
> Fixes: 0724869ede9c ("bus: mhi: host: pci_generic: add support for Telit FE990 modem")
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/bus/mhi/host/pci_generic.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 14a11880bcea..fb701c67f763 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -680,6 +680,15 @@ static const struct mhi_pci_dev_info mhi_telit_fn990_info = {
>  	.mru_default = 32768,
>  };
>  
> +static const struct mhi_pci_dev_info mhi_telit_fe990a_info = {
> +	.name = "telit-fe990a",
> +	.config = &modem_telit_fn990_config,
> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> +	.dma_data_width = 32,
> +	.sideband_wake = false,
> +	.mru_default = 32768,
> +};
> +
>  /* Keep the list sorted based on the PID. New VID should be added as the last entry */
>  static const struct pci_device_id mhi_pci_id_table[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0304),
> @@ -697,9 +706,9 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  	/* Telit FN990 */
>  	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0308, 0x1c5d, 0x2010),
>  		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
> -	/* Telit FE990 */
> +	/* Telit FE990A */
>  	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0308, 0x1c5d, 0x2015),
> -		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
> +		.driver_data = (kernel_ulong_t) &mhi_telit_fe990a_info },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
>  		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0309),
> -- 
> 2.46.0
> 

-- 
மணிவண்ணன் சதாசிவம்

