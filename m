Return-Path: <linux-kernel+bounces-308737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6C2966112
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BD32810DB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8EE19992C;
	Fri, 30 Aug 2024 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeUXaZHx"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAFB1917C8
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725018946; cv=none; b=Vr5LBFodOpNlPu+xUmVYg6qGkVlNz+FuT8kCOqo4/jaS1CxoolpHajRgVONn3VVqrCjrpy3RySSklarx808VR/Aj16E74dmrpAgWmCbdLs66C4Kx7TznE2M8BIRGhg/zlfsd0cpV6vKRVWV0vllhBIJ3p8CiH1vHiRoUWAERfj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725018946; c=relaxed/simple;
	bh=uRPx9Gzpb7WsqBteaCH5lSTBTmLKdmt2JEQyfg5CEtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXDP5wlXbwXBQrHOrbQ/c24vUC2AnQiSEkP2dBXJwYu+/Ga163ubGKzEfmEJpNMRIxURh3/WgJbr6EzL79dBp78k3CB5Ne7iwZLmtbZfey/HNzhCdyTcMUywLF3COW4kLYFaSaxJ1yRtJ32YJ3KOrp0C5VabO1nEq1yDwJKRego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jeUXaZHx; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71431524f33so1292382b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725018944; x=1725623744; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vj5tQXBLna4Jks1OEg0AoadJI6GOwdLoSVDTmyvlHAc=;
        b=jeUXaZHx+h5dmlkVXIzVmRV/gUt+bZnY3r5eYh6I5k8BOrjftVqIxFdmq1r3q+3V1H
         3MFxo0Q7hg6dCal3IkcFtJX2g0nm4Ry/tpkEurAMAl82Fzqy+RvsJwA3YLxcnjwZ2m5O
         GypDF1hz9vf0aYSxEv0giWgu12agRofEhrXd1vEROisXRdaaOqFkc2nHl9gamISVzHNA
         FFFefpmCPLkYpoKAw3oaTzCtauVu9rYgSPyf5o2JgId31nQBfdp+aTnZ7sd40w2GYpvn
         PBq3j5HUCIkx7w3lSuIXuujJ2dfD/4QxHRXYvg+OgMldOOmSBeWycGtWAhvOPRd0gpCq
         UyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725018944; x=1725623744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vj5tQXBLna4Jks1OEg0AoadJI6GOwdLoSVDTmyvlHAc=;
        b=AEVmuz704T5tDMK/tu5gr3b3KU3ljjb0KTBjhA5O/lJfx0NW2hvRx0X4ygiyf3RtSK
         BXr0qg5GTjnmAaYuShBeCxoqZoZPF7VwSzqK0m3xQpTWurE+SAL4k4sYyvoPpgiZyWIe
         exMi8fd6sdLOciWhusNaEJV15iT/8VaH2nrJ8D0hLnSk4uVpbVs7orriovNu5A5BquJP
         6ngTuCJwCNzI5yfsQ8Tfu0hsd04jjedcjdc/m5fRFg1D75ACPFBq1VBWpmHCrhLDHdl9
         KR8W3wNJvbj0rWX08Nd3+S7pnF9sCG6NDhmfKHjazz+uKWTcak+e/fGAtRgib1AkTZtm
         jVXw==
X-Forwarded-Encrypted: i=1; AJvYcCUshmulQRXyQL5mxVv4aIfSgAqA91iVOIzuYVMk3FLEEAPxzymdbiL2KSteJMHIYskfSPcpqwA8/+rvNRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1eSPtA22njRFMmo7CHk/eU6buvRflwqYMU+q5UcpUdgDgpKXK
	x7UxG38vWavE4xu+zsJMhL/y2k5WxhIlgeCi0xBni9hX3upCMGTip/Mh8LhF2w==
X-Google-Smtp-Source: AGHT+IGcO33pwmd8RvHVGGRlKReAeYEqRHa/Rp7NaaBDLLXjQPmmU1g/ailYEl5oUc6IJBrtKBeShg==
X-Received: by 2002:a05:6a00:3e10:b0:70d:22b5:5420 with SMTP id d2e1a72fcca58-715dfb988bamr7197551b3a.15.1725018944332;
        Fri, 30 Aug 2024 04:55:44 -0700 (PDT)
Received: from thinkpad ([117.193.213.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d751asm2597787b3a.169.2024.08.30.04.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 04:55:43 -0700 (PDT)
Date: Fri, 30 Aug 2024 17:25:37 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] bus: mhi: host: pci_generic: Enable trigger_edl
 for Foxconn SDX55/SDX65/SDX24 products
Message-ID: <20240830115537.mtbkfmocab3h5262@thinkpad>
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

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

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

