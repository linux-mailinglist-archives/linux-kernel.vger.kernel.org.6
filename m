Return-Path: <linux-kernel+bounces-251546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D84930616
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 17:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A345282B23
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 15:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B86F13B584;
	Sat, 13 Jul 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4Vy4BAH"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50A91386DA
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720883393; cv=none; b=Xb/qt6oTYMsHX3c74BI3uWGJsxZT2xgRHPs7iZ/ABa04ri+9T1n90OmHFVBbraHYKDJYFJFqxhQM6vlnTg8PBhzg9UDpVr8lp/vRnPmnabQv7yGq95nVLRLEFhhJrkEMyP4GXfFxE7Qf+2PevhfvdzLCLa7HTIrpwZdFDxs8uH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720883393; c=relaxed/simple;
	bh=qVBV1SGYCV3VpJhga8WAVhCZSl/Hloy7KmZf/y1uAnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkJWBTIyHIwg+BT19DT883baXnvAJQQQYHqdAj5x3Woc/MGkWqSFaU5aJb6DdX97kVsWsE1KHGj2q8YLcNRmuMuEgtV5b/eGy8mmBE/yuW76YKBV2umYaDZZMHW0EHCo+O0LtRWDqQHlCf7CoA6hNrBOc6guTfTLTgD/l9W1oIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z4Vy4BAH; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e98087e32so3381076e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720883390; x=1721488190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DnPbtTAkZ7djqLH8dVYwhAmRisUoaziL3oeQP7ZMuXM=;
        b=Z4Vy4BAHSAuXIoLmnjnMJUkJumTBnlch4czOyNg7fCcPq8V5waSjIVJ73R2JLGLx0e
         W7K/SZR3wBT5uuggGqzd2gRmqO4nBn+R23qcKD6TmMD2ImmuYJ8R4MK2dYN9k8jJaJhx
         hv07P0JtGajaYLVqmejFhP7gRUQgHaytoTFlYecewWMzd2AKKxuvEAYhTFfcGkKTDNmH
         jwrge2BlirPF0j3WNmCZ4OLRtYuFJBCZ/UcQkmTmA9/qvFyAIHaJImKFSlg+CbYIB+ok
         i59lbkodJ/CX/big4F8XHPEa7j+ujAGh9iTx5TqIpdfrwojuqLQUZQyPaJg2HTGcovQL
         lxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720883390; x=1721488190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnPbtTAkZ7djqLH8dVYwhAmRisUoaziL3oeQP7ZMuXM=;
        b=glcwHlHx2C2bxhSukwVJUydTaqB5VrZzV5wBQhOtZEI261ew6ruAg+bWJ1adADdu7M
         I3UhCnlHY+RSpDwmrqTQy3i1RE8vb1TyTTQ+PNuQLCFb4yg3lCxYJQ6cwhZspN8LxeGH
         bmJMV1DEFPHn8PyLJmn4vvahUv/pR6NrpoA7vbDfb/QjtUzBGv1PBTp8Rtm29+oGZnPw
         Kh8LsZyzBdB6+TmhYpMm586tXz7YqbWfqEMOLE7deLlKNH2xZhF0xbG72vxY3Q7ogzFW
         KjDsKmMID4UROKkMGpOa+ILxEkeeV6GyDIaIv6LK6b7HMvI8EkuUQ+2rJkuEn2s0iORW
         nwdA==
X-Forwarded-Encrypted: i=1; AJvYcCWI7WQvO+EOuSR5TPpzE3oQ6+68YI5w3BSOWXluxJv2sdRTcAq/C7RHoeG1xWSw8oMYPr1rrifiRIh0KSKB18My91ifGJy6R9jczJ/o
X-Gm-Message-State: AOJu0YyHuIIK1j/j3ebsQAVGKpr8Ng3mfgDW5GtSofXlR3IWZF1q4pm+
	7IE/hr6Lrn1ApGHCLJU4MVyhF8aFAVbtROYLDtb0x6erlxveFIykg8dVwdGYFRU=
X-Google-Smtp-Source: AGHT+IG8f/S6xS3NpK6n/5A6ZgtrNG6rhyc83wV5h+9vg7eHn7uf4I18w28czjlqvaEye2vJRAjSNQ==
X-Received: by 2002:a05:6512:3d02:b0:52e:767a:ada3 with SMTP id 2adb3069b0e04-52eb99cb00dmr10568585e87.47.1720883389805;
        Sat, 13 Jul 2024 08:09:49 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed25391d4sm216199e87.274.2024.07.13.08.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 08:09:49 -0700 (PDT)
Date: Sat, 13 Jul 2024 18:09:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: manivannan.sadhasivam@linaro.org, mhi@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: host: Add firehose support for Foxconn
 SDX24/SDX55/SDX65
Message-ID: <dduv77mdqe633m7amyljhqas7nomrtjrrimvmyqidymy3qjvfa@biepierrz5p3>
References: <20240709015818.110384-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709015818.110384-1-slark_xiao@163.com>

On Tue, Jul 09, 2024 at 09:58:18AM GMT, Slark Xiao wrote:
> Since we implement the FIREHOSE channel support in foxconn mhi
> channels, that means each product which use this channel config
> would support FIREHOSE. But according to the trigger_edl feature,
> we need to enable it by adding '.edl_trigger = true' in device
> info struct.
> Also, we update all edl image path from 'qcom' to 'fox' in case of
> conflicting with other vendors.

Separate patches please. Also don't use "we", just an imerative style:
do this and that.

> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/bus/mhi/host/pci_generic.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 14a11880bcea..440609b81e57 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -433,8 +433,8 @@ static const struct mhi_controller_config modem_foxconn_sdx72_config = {
>  
>  static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
>  	.name = "foxconn-sdx55",
> -	.fw = "qcom/sdx55m/sbl1.mbn",
> -	.edl = "qcom/sdx55m/edl.mbn",
> +	.edl = "fox/sdx55m/prog_firehose_sdx55.mbn",

qcom/sdx55m/foxconn/prog_firehose_sdx55.mbn

> +	.edl_trigger = true,
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -444,8 +444,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
>  
>  static const struct mhi_pci_dev_info mhi_foxconn_t99w175_info = {
>  	.name = "foxconn-t99w175",
> -	.fw = "qcom/sdx55m/sbl1.mbn",
> -	.edl = "qcom/sdx55m/edl.mbn",
> +	.edl = "fox/sdx55m/prog_firehose_sdx55.mbn",

Is it the same file as the one mentioned in the previous chunk or is it
different?

If they are different, then, please,

qcom/sdx55m/foxconn/t99w175/prog_firehose_sdx55.mbn


> +	.edl_trigger = true,
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -455,8 +455,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_t99w175_info = {
>  
>  static const struct mhi_pci_dev_info mhi_foxconn_dw5930e_info = {
>  	.name = "foxconn-dw5930e",
> -	.fw = "qcom/sdx55m/sbl1.mbn",
> -	.edl = "qcom/sdx55m/edl.mbn",
> +	.edl = "fox/sdx55m/prog_firehose_sdx55.mbn",
> +	.edl_trigger = true,
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -466,6 +466,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_dw5930e_info = {
>  
>  static const struct mhi_pci_dev_info mhi_foxconn_t99w368_info = {
>  	.name = "foxconn-t99w368",
> +	.edl = "fox/sdx65m/prog_firehose_lite.elf",
> +	.edl_trigger = true,
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -475,6 +477,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_t99w368_info = {
>  
>  static const struct mhi_pci_dev_info mhi_foxconn_t99w373_info = {
>  	.name = "foxconn-t99w373",
> +	.edl = "fox/sdx65m/prog_firehose_lite.elf",
> +	.edl_trigger = true,
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -484,6 +488,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_t99w373_info = {
>  
>  static const struct mhi_pci_dev_info mhi_foxconn_t99w510_info = {
>  	.name = "foxconn-t99w510",
> +	.edl = "fox/sdx24m/prog_firehose_sdx24.mbn",
> +	.edl_trigger = true,
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -493,6 +499,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_t99w510_info = {
>  
>  static const struct mhi_pci_dev_info mhi_foxconn_dw5932e_info = {
>  	.name = "foxconn-dw5932e",
> +	.edl = "fox/sdx65m/prog_firehose_lite.elf",
> +	.edl_trigger = true,
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

