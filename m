Return-Path: <linux-kernel+bounces-308755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF64096616E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673751F259D3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B5A199FBF;
	Fri, 30 Aug 2024 12:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v6IbNiMQ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE4916F0DD
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020321; cv=none; b=bj26kdBoGtYpE7nBSaBFQkmsHr6vlSAiRsIBjKkhd5jEhtQ4cnQQO05V3gTxqu6s43mzjM/0CL/h4xjyIIvGCG/8PH5l3LDRBBgeepod5wMVH93RherzuoTXpo+K6WblslVyc2HALyI7pyRwG6clgRUevFXXPCNyJ+0MN8r7YQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020321; c=relaxed/simple;
	bh=as9bZ18482ds0DVCSos5+kV1IKZSHcbXBC2Asfcgf6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDDS4YTXWvxL0CT61FeIu4tgg1j55anxAh6dcB23B24pqOu/wblNpvBECJTSChmubEAvPLci/oIBuxP1RRuA1VrBLrgEfaVW917tzOGZjI3i1mtvnPsxhkYo/CpjuLwISfmRYEv4qt9Ono+eCj5Cq0trTH4HcPuBHi+rjXJXzQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v6IbNiMQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-714263cb074so1299958b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 05:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725020319; x=1725625119; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eJplX0nrFE2YsBh7KtLRDZWDD5YD99Qk9xo9Crw/Jk0=;
        b=v6IbNiMQ8JhpLXKK+ggz29HUQAAKSSjHbR9FyuXwqJ4mRAaGsZhQKT9iXBbYkecHsb
         9q/PoIneWFhh17hdSLyM39M0Ww8Tz3kCPXGLUvEZGLpMhIlaRDK7yFzrHkfVJJY6ER/G
         SX+ZdpBrZzWqJbLZEk13AQPH65mY5zXv8RE/Rn/HE6L83ENX2OjtCwpr59Qa+y0uFGQw
         i4DLMKvfs90RCwbWO7jj2VJMnJNXNpqbVhETRxXAC6B84Tt8sjAKTt2oOsPUhMdwxlGA
         1kKqHj16TaPjvE7TpTzTzdCF0TzptHP0wvPDBqPcfBVLugfzk//kY/5+qg++6vuS0AV0
         0ZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725020319; x=1725625119;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJplX0nrFE2YsBh7KtLRDZWDD5YD99Qk9xo9Crw/Jk0=;
        b=FkKovzx/SrZDSLk7L9pUn0e35o0ltTUKJZDVP01VX5e/MOpbcb8nz71IJvN7IUl9G3
         TxZKrTFMofrBxPvdy5Pyu2ykaSwiwv1sAGY46prX3TgErNDNnjcidvO+x9pHq95+4bq9
         bTGnxS2iPOX1pmbX9ZQ1L7j1cBDTBpayuERmohh16CrpQzOn/ifTbgtffu5XcHRG+JGA
         0txqLflC/gRWa6Vz9ze3qxZd0gMBsaaoh3HPSROG7lG8vx+a9LKSvdINvA1JAk8Dv+UF
         V3rL4ZAmxnQSRmzYMAtP6Okw4rMxeqS5KbPHTt7zAoGx24WwyyhnGnIdB4DSZ60jpg26
         OJxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIdCgWc6knL6CX2PxY4r+hgzeTUWpNNG8HgMrtAX3ujaZzvRlWGiUMrW/UyfGXC5dooErO6j9HLbQBx7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwomBmn3D9LO9i8nxdt5MMvNbWsyTOO6MdeVxm83P+oR8c9iQ/+
	lua2lpWmUW7K7Nx8ZVnVqNZVEz7xIS9c0SsjnebSq2uD/qN7sfqIXLmEWaJD1Q==
X-Google-Smtp-Source: AGHT+IF8bmE5S2LuE60AnWdDtjWDZkmqQ9ygryaZA4rPxnm/Svh7hutBAGdVKk3XDfWvFmcWIRODRw==
X-Received: by 2002:a05:6a20:e196:b0:1c6:cb01:db61 with SMTP id adf61e73a8af0-1cce101a84dmr6071301637.28.1725020319526;
        Fri, 30 Aug 2024 05:18:39 -0700 (PDT)
Received: from thinkpad ([117.193.213.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9be991sm2847738a12.75.2024.08.30.05.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 05:18:39 -0700 (PDT)
Date: Fri, 30 Aug 2024 17:48:34 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] bus: mhi: host: pci_generic: Enable trigger_edl
 for Foxconn SDX55/SDX65/SDX24 products
Message-ID: <20240830121834.e6zhtqj6pwgbxpsr@thinkpad>
References: <20240725022941.65948-1-slark_xiao@163.com>
 <20240725022941.65948-2-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240725022941.65948-2-slark_xiao@163.com>

On Thu, Jul 25, 2024 at 10:29:41AM +0800, Slark Xiao wrote:
> Since generic trigger_edl mechanism has been imported, all
> products support firehose download shall enable 'edl_trigger'.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Applied to mhi-next!

- Mani

> ---
>  drivers/bus/mhi/host/pci_generic.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index f159a9dd53e7..565b280c539e 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -434,6 +434,7 @@ static const struct mhi_controller_config modem_foxconn_sdx72_config = {
>  static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
>  	.name = "foxconn-sdx55",
>  	.edl = "qcom/sdx55m/foxconn/prog_firehose_sdx55.mbn",
> +	.edl_trigger = true,
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -444,6 +445,7 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
>  static const struct mhi_pci_dev_info mhi_foxconn_t99w175_info = {
>  	.name = "foxconn-t99w175",
>  	.edl = "qcom/sdx55m/foxconn/prog_firehose_sdx55.mbn",
> +	.edl_trigger = true,
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -454,6 +456,7 @@ static const struct mhi_pci_dev_info mhi_foxconn_t99w175_info = {
>  static const struct mhi_pci_dev_info mhi_foxconn_dw5930e_info = {
>  	.name = "foxconn-dw5930e",
>  	.edl = "qcom/sdx55m/foxconn/prog_firehose_sdx55.mbn",
> +	.edl_trigger = true,
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -463,6 +466,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_dw5930e_info = {
>  
>  static const struct mhi_pci_dev_info mhi_foxconn_t99w368_info = {
>  	.name = "foxconn-t99w368",
> +	.edl = "qcom/sdx65m/foxconn/prog_firehose_lite.elf",
> +	.edl_trigger = true,
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -472,6 +477,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_t99w368_info = {
>  
>  static const struct mhi_pci_dev_info mhi_foxconn_t99w373_info = {
>  	.name = "foxconn-t99w373",
> +	.edl = "qcom/sdx65m/foxconn/prog_firehose_lite.elf",
> +	.edl_trigger = true,
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -481,6 +488,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_t99w373_info = {
>  
>  static const struct mhi_pci_dev_info mhi_foxconn_t99w510_info = {
>  	.name = "foxconn-t99w510",
> +	.edl = "qcom/sdx24m/foxconn/prog_firehose_sdx24.mbn,
> +	.edl_trigger = true,
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -490,6 +499,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_t99w510_info = {
>  
>  static const struct mhi_pci_dev_info mhi_foxconn_dw5932e_info = {
>  	.name = "foxconn-dw5932e",
> +	.edl = "qcom/sdx65m/foxconn/prog_firehose_lite.elf",
> +	.edl_trigger = true,
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

