Return-Path: <linux-kernel+bounces-210910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DE7904A07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21352816B6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 04:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F492261F;
	Wed, 12 Jun 2024 04:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rts1nzaL"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D4163A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718166802; cv=none; b=D3/ib2TD0zMsxWuOXzEfXq8fBRFhYtXeIpJZTjqbcwbOOmTcs8y1Ya4oZPPuWhqSlUrBPrwhp8+txbYXtgzPxY7jt+LIT+6E/vdFC6MEwL//Fp4COcLI0BDu+ZfSw3GvKvU49XKuWDjAyjdPdYL+BRf4W9xCcSedquEoPqsV+kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718166802; c=relaxed/simple;
	bh=oKOMiTUMh2lH/esnQN6AZVJ8ULwr850HU8/bFBOc1G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1ajV1kBKfl6Cudrz6VZSHSH4h62FN0D1Eq0UbdzscIUSkGEW1HlsZCVfU/TC0ZMrWcIiJJx3S9Ggmh1N2fApI4VTx5oJ1IvL2fq/hnWOn9TYWV/gWUJfVfWxI/dhvcL+a8UAy1HHcwUuMyZSgBMvTAEp2XEDZF/chPN5vStwsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rts1nzaL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f4a5344ec7so4342345ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718166800; x=1718771600; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lFT573xAr2xtznmal0QSwzPFRJXGMmZiiu4vvGuLRvE=;
        b=rts1nzaLBTcuHma9FzL6zT0302Zo/xRoK3j+c+YQo95UvVzF5pVMkKDp408KuI6RPb
         oxswPss2uVooM/Hz2yyuesAkK+Vtre6DjNCCi2j11qo2ecT3KwogsEM28QAF25G0fmPC
         kKBX3WZJR/bQryVBYDEbtZsC7RrMJQQJEzDn8lCOhTMVh9w10VnJd4X28iYtyXta5B8+
         YQwZKd1D3oPLO6biHaiyFDyvs3LAdN3vqPvxBQpwliCbmkNCwrJ23SIPUqyffh2FfJgc
         ciUvYMBdsHbxyfac8vfPkhrD8GOXNn29Af6z7gi3kWwl8GFDDkOGJykwz7ukgEdTpTlA
         79SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718166800; x=1718771600;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFT573xAr2xtznmal0QSwzPFRJXGMmZiiu4vvGuLRvE=;
        b=Sf4QrF5qBiGf92BKCvq8SBMMFz0HAp1LKnqR5xWgG266nNxaYF/bua8ZiIdhGofiFD
         iOw56nP2uec4w9i57Z+ItEpybFwGAiBO+BY4OmZRu/7+91/i26/9mol7ooKgif27HKJc
         cglFEiVYs/L7x570mBzGPfO9hh7C/9P56jGU3GclYLmjWlMmlKe298Z71EGm6wA3N4vI
         DCTqSxSgB0OY3zTOXWFADmen2hp+bdFkaOYc6nqMzd6ikJNh/r+ovy4Rk+2L+RELTjpv
         gcW+yNYvEtaArUneb0YsdlOflLMXmytw+yf4cutVtM5y4LqimqUIwrO1mlHhw9RpBR2J
         v/6A==
X-Forwarded-Encrypted: i=1; AJvYcCXlqrmiOqLMckn8csudCotyGqeQmaa47GG8dGrQYpEWwF23eTN3JFFAuwIx9vSfOI4w6aXzL8ZA7snyuilO8eq5Hi0knjYEATJ9GPAb
X-Gm-Message-State: AOJu0YzrlZGcUWBd7d7OZDgPLrH1zJ4GbGz3Y0q71rF2TiIMH7JzcVYk
	pY8zwYGgdKJagJ6gkvpJOLWWxtygP7jMRDTZBvCtRGqwwNshk+cr9NioStKtzQ==
X-Google-Smtp-Source: AGHT+IGjgzQJMzZ2YsUlBKZq5nu9pQSdHRAY35QBtjOBYDL5ZoL+j3Fi8tpi16/g1dFdclnegZjxZQ==
X-Received: by 2002:a17:902:6f08:b0:1f6:e338:2a6 with SMTP id d9443c01a7336-1f83b19c24bmr9564885ad.23.1718166800089;
        Tue, 11 Jun 2024 21:33:20 -0700 (PDT)
Received: from thinkpad ([120.60.129.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6ee4ad6a5sm76284795ad.151.2024.06.11.21.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 21:33:19 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:03:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@linaro.org, quic_qianyu@quicinc.com, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] bus: mhi: host: Import link_id item
Message-ID: <20240612043314.GB2645@thinkpad>
References: <20240607100114.452979-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240607100114.452979-1-slark_xiao@163.com>

On Fri, Jun 07, 2024 at 06:01:14PM +0800, Slark Xiao wrote:
> For SDX72 MBIM mode, it starts data mux id from 112 instead of 0.
> This would lead to device can't ping outside successfully.
> Also MBIM side would report "bad packet session (112)".
> So we add a link id default value for SDX72.
> 

link_id is WWAN specific. But what you are passing is essentially 'mux_id', so
just use the actual name.

> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/bus/mhi/host/pci_generic.c | 3 +++
>  include/linux/mhi.h                | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 0b483c7c76a1..1f9de2730766 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -53,6 +53,7 @@ struct mhi_pci_dev_info {
>  	unsigned int dma_data_width;
>  	unsigned int mru_default;
>  	bool sideband_wake;
> +	unsigned int link_default;
>  };
>  
>  #define MHI_CHANNEL_CONFIG_UL(ch_num, ch_name, el_count, ev_ring) \
> @@ -469,6 +470,7 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx72_info = {
>  	.dma_data_width = 32,
>  	.mru_default = 32768,
>  	.sideband_wake = false,
> +	.link_default = 112,

Just use 'mux_id' here also.

>  };
>  
>  static const struct mhi_channel_config mhi_mv3x_channels[] = {
> @@ -1035,6 +1037,7 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	mhi_cntrl->runtime_get = mhi_pci_runtime_get;
>  	mhi_cntrl->runtime_put = mhi_pci_runtime_put;
>  	mhi_cntrl->mru = info->mru_default;
> +	mhi_cntrl->link_id = info->link_default;
>  
>  	if (info->edl_trigger)
>  		mhi_cntrl->edl_trigger = mhi_pci_generic_edl_trigger;
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index b573f15762f8..4da10b99c96e 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -445,6 +445,7 @@ struct mhi_controller {
>  	bool wake_set;
>  	unsigned long irq_flags;
>  	u32 mru;
> +	u32 link_id;

Add kdoc comment.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

