Return-Path: <linux-kernel+bounces-178816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDA18C581E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8C5283F00
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C401617BB37;
	Tue, 14 May 2024 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBe7lPEQ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70830154C10
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697466; cv=none; b=gOS7bkpugyb77QYhvRupmNXBctEVLo1PKDY2aDrqhDYPw+0EwqrLnnkHJ9kFjkcBeQCviM0bJOFRDwnq8sg61StigeDol9UzFafmDdacZtKKUTg/67fLS00pX3nnwLnfD/bJGKSSjP/kiLXFVzHB12ahkqQh5F0fjYnvPL6BcpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697466; c=relaxed/simple;
	bh=cCN6oAFPt/mZTrQVhHoM8Poynt/Vme2RK/JjKPD/hGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQ5aC5HHUppGiisDv1kEAGrFTGnkjFeuGMpUW0jEZPlfyYEa+h2iA/NsFyy6Nezresk74IoNOlNTMHwXEU6AJpD1TpGS9KLgE6x4NPCZTp8MQdXAp8PCXIfPL2Rm4sbFI33Z7/yNB7UiS/oz3C5C0dhPvqyLvRPBXHuNyEiVLgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aBe7lPEQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-420116a6652so21006755e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715697463; x=1716302263; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TAc7NjihDXzocbPFDcPShOeBfL8pHSiZ3S9lbKbtkK4=;
        b=aBe7lPEQFgZdsmP2LG2EGU/JJdnmeeW3/YzPo6MHMTPP95csKglfgHUoFpWM6y4N4A
         gGROjzfvUS1eNecECCG/ccTfsX6JvW0dssXF8M1794/QZ6AIcB6k2Ghv/XlgMO0DVXrS
         il/hP49SHHwknWrJtdk3uc+u4S2PLuTbX7Eah7seO4REgoSTZ2/wa6J76Xc+bbrzbqNu
         NcIXqDLeigfqeL956XYkiSKJzUuar+M7URg7bQ7huL+BlGSQNMB2rEWSfWoel4CVLveu
         woUE2qmpoT6kaN4YREosN1G4Khv4LhblEOAfzwyIPIt0T6LLEqYsc1NC5VN0q5pp8e/u
         PStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715697463; x=1716302263;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TAc7NjihDXzocbPFDcPShOeBfL8pHSiZ3S9lbKbtkK4=;
        b=ojnVVZgR3dRT0OQudw0/9W5DDr4otixWbzDIYnhkW5S3824CUC+dXqANFxHWd4Xv0D
         2eXHdhCpLRvCnZm/yr61VwNNqrFO+xdTTwAZ201YpbKN6lmgRoE7r0gWS3PVyMjI8FuS
         zulVbw5/Kr5G3z8VTn9k4LHH1GkNBwphG1qEaX/p5C3kwxogJDrrYJKqacYnpOV2qCQj
         h0PzgDQOtSUGmp0y3WVIS1tu2j3hrENqUINh82EPeuYHiU6Ah4PzzTb4nCd7vHv9MGtk
         wgwL8uLF/+mUwYhHFg9Llr7PyUrEDd4YbC35aaq0YJ3t+PDyuP9k4C2u6JynyePRtlst
         hVtw==
X-Forwarded-Encrypted: i=1; AJvYcCWhXd6Xw03SWfZ2tkSBa5us91+Rsx5eqh/zi8vf1iU9W35DIhP20JzeCgza7RWDAnEfPqmhtm+k21A7UIrFNvlDMYmN/RoIE4nNko2/
X-Gm-Message-State: AOJu0Yxvw6Xu3z+k7sRJu+qEgLJRwEnFyRPyL89aSmJ+kTkuFYwYa9Fz
	sEP+7xjapE9toUAhu0Sulnzj1sdsdEUrDNz2/J3t2l40bGkbzbV2FFIArPmV8Q==
X-Google-Smtp-Source: AGHT+IGPyRX8qtOMt+JESevQaTVma23gUecjuwUc1IYuJbTTmpZ+UJ3tSQ0+ECufdM0ZY1qj8EQ5xg==
X-Received: by 2002:a05:600c:1c9f:b0:41c:35c:2da7 with SMTP id 5b1f17b1804b1-41feac551a0mr100665255e9.30.1715697462515;
        Tue, 14 May 2024 07:37:42 -0700 (PDT)
Received: from thinkpad ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35045583669sm12283626f8f.106.2024.05.14.07.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 07:37:42 -0700 (PDT)
Date: Tue, 14 May 2024 16:37:41 +0200
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@linaro.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: host: Add Foxconn SDX72 related support
Message-ID: <20240514143741.GA2306@thinkpad>
References: <20240510032657.789629-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240510032657.789629-1-slark_xiao@163.com>

On Fri, May 10, 2024 at 11:26:57AM +0800, Slark Xiao wrote:
> Align with Qcom SDX72, add ready timeout item for Foxconn SDX72.
> And also, add firehose support since SDX72.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/bus/mhi/host/pci_generic.c | 31 ++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 08844ee79654..0fd94c193fc6 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -399,6 +399,8 @@ static const struct mhi_channel_config mhi_foxconn_sdx55_channels[] = {
>  	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
>  	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
>  	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
> +	MHI_CHANNEL_CONFIG_UL_FP(34, "FIREHOSE", 32, 0),
> +	MHI_CHANNEL_CONFIG_DL_FP(35, "FIREHOSE", 32, 0),

This means SDX55 is also supporting FIREHOSE channels, which is not true I
believe.

>  	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 128, 2),
>  	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 128, 3),
>  };
> @@ -419,6 +421,16 @@ static const struct mhi_controller_config modem_foxconn_sdx55_config = {
>  	.event_cfg = mhi_foxconn_sdx55_events,
>  };
>  
> +static const struct mhi_controller_config modem_foxconn_sdx72_config = {
> +	.max_channels = 128,
> +	.timeout_ms = 20000,
> +	.ready_timeout_ms = 50000,
> +	.num_channels = ARRAY_SIZE(mhi_foxconn_sdx55_channels),
> +	.ch_cfg = mhi_foxconn_sdx55_channels,
> +	.num_events = ARRAY_SIZE(mhi_foxconn_sdx55_events),
> +	.event_cfg = mhi_foxconn_sdx55_events,
> +};
> +
>  static const struct mhi_pci_dev_info mhi_foxconn_sdx24_info = {
>  	.name = "foxconn-sdx24",
>  	.config = &modem_foxconn_sdx55_config,
> @@ -448,6 +460,16 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx65_info = {
>  	.sideband_wake = false,
>  };
>  
> +static const struct mhi_pci_dev_info mhi_foxconn_sdx72_info = {
> +	.name = "foxconn-sdx72",
> +	.edl = "qcom/sdx72m/xbl_s_devprg_ns.melf",

What is '.melf'? Is the firmware available somewhere? Did you plan to upstream
it to linux-firmware?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

