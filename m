Return-Path: <linux-kernel+bounces-424775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D2F9DB939
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF0FB226E0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8D11AA786;
	Thu, 28 Nov 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2/C9GvZ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5451A38F9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732802833; cv=none; b=lkKLGo9EfRIXylGFl+2q4T77Kf+gBvkuLGPoSH6bv7UE9/3ITzKCiMsLqxdfztmt2p3KufbciyWZDYUR3a41agUP8J0+3zTFMmdUN9yuiaiVa+aa/gQzZnAs+zNX3HiRhCAFDJZTBeo7eBZYPZ2Cu37WcHKWVnNS6Z1eiG1Nozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732802833; c=relaxed/simple;
	bh=pT5jSZqDvkrdjh+q3rMAuuDFxNI3q0d0Yr08Mj3Z93g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stnHarMPGrOJoVbE2decnpBtryRkI7xPDBb8SDUoM6xaxvT+B++OMKOmQ7nSZXgL/B1LcRbOUN8Cys2XUin7IJW+UOXJf+1oE6TB1F/2IAFN0pHnZfWzsXbQTs/fOYRmvZ/5LGb88svLDZtc0xfAjOlV9NlEzLC+l6PVo/U3T8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m2/C9GvZ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53df6322ea7so1298409e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 06:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732802829; x=1733407629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fbeGv6UaRD4uMpdkGqweyQuTufuHdg0lb79N9dKK5ls=;
        b=m2/C9GvZGEPXfaJbaW20D7/LYiZMojhrSjdo9Vtz8FbnsPjsEJle2x4vuENLXPWw9r
         qRZUIEGrTqtLu6UqQlkKMEZdJAZ17iPxEbrDgt/AlRQ5EYEiBVXyHpR6vabY791h2HPp
         q8IdKxGJznCOwY9Wzn/+GKD7CUz5lJCxOrD+SbpzMwzu24z5u/VdY3QqBJVeXUUavkkL
         5y1UgZwFAeMNolh6lrPlip6Ecpj25Nr1NP9zBf1k06DisROq6u+sWXZnypr/i96/rvCW
         GK+KKhSmevYrsx4pBHztpbSSgOD9q4qwRt52QzECav377eyFDUR0yJO7XlY3OH64gFby
         sv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732802829; x=1733407629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbeGv6UaRD4uMpdkGqweyQuTufuHdg0lb79N9dKK5ls=;
        b=EZiNyvIJ5ojpWd80ly/MLYFIvqgVtWJV1VJSEzYZFc7aZdJefqkonUqHs0GWWTszTC
         3Puj0XXw6IoIr1CqlEJnzJ4FmBjZM1TbSl0KsZj+CoGcHEwi5Jeq0ZAGr6Hblfp0Bs+y
         rAeKYpU+gQQ4Ko1GW1ABWzLvAykvbsm0TCosgrljII6LRfIdYbmrpRfQPT3gd+2FxQ/p
         uHcCQp/GFcMTtMCBo3WatAvCGLOtAxczOlRYwnnEGT5UGC3yDW7juKdU031AlZk3PkfW
         ucjZOSBijBnaMPBJ0Kz/Aq/VvOkpExgYCFRKSnokCi2ZGntthYns1USNRqywjpQrrD2a
         j3vg==
X-Forwarded-Encrypted: i=1; AJvYcCVIZlzmIMxsY1vPJCJzgXAuJ7aQBSaL5taSxKV8vnRfXReKDkhZ1kHUf6W/WEPvRR0Malw39ZrQbMYtWtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jk0TrpFR5ZvDUhXQOwQoojxYf49FADKinkT6EZrZTAfIjVFn
	wz64OKXWdRd2aZndmwOCMlKqZ1BBPW+MSOFIw9E26HgevEs8Gk2zbGpIqzmreLA=
X-Gm-Gg: ASbGnct6WJoGq96FWx4Mbk5A5fI4p4zbaYfVGxN74xX6Fmlcun837VdxtKJdnTqzqk5
	FvMkVTGjDxN9ITMKYlTNxooMEx/R+hMBOXwjaxAoqySSM91IlTaEK0/JKNVhbKibMny7y2H+32l
	dFQZ2I1gonUWKHSggw1b34wFp2nDwu9uqHsWhI0BXq9uOY1tQia8u8HIk4CeNb9lyx0aqy8jaGJ
	oXzmWFR8TM0UGJz86Odaeci0nuqnywbZUJXDhOGEtAtczBK2AUm/x7ilaPLUSXN1NDn+/wqYGjU
	E1vZGMo30Pq0+U4b1A4RRuSBbT+DTQ==
X-Google-Smtp-Source: AGHT+IHudcPrxOXg52IUNG3JRLPxmA9gUb+mUF9hUF9mSvRpLmyJ6XAURRHhdJgDc0ZDHiHrd1Gg5w==
X-Received: by 2002:a05:6512:1249:b0:53d:ed47:3017 with SMTP id 2adb3069b0e04-53df00a9743mr6573311e87.12.1732802829171;
        Thu, 28 Nov 2024 06:07:09 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df649ffc8sm186022e87.260.2024.11.28.06.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 06:07:08 -0800 (PST)
Date: Thu, 28 Nov 2024 16:07:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com
Subject: Re: [PATCH v2 1/2] dmaengine: qcom: gpi: Add GPI immediate DMA
 support
Message-ID: <b2awih7g7wq2o7546qfpnf5ft27n6zzial7w35jvwpcjlrg5qm@tqrbl7wueiks>
References: <20241128133351.24593-1-quic_jseerapu@quicinc.com>
 <20241128133351.24593-2-quic_jseerapu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128133351.24593-2-quic_jseerapu@quicinc.com>

On Thu, Nov 28, 2024 at 07:03:50PM +0530, Jyothi Kumar Seerapu wrote:
> The DMA TRE(Transfer ring element) buffer contains the DMA
> buffer address. Accessing data from this address can cause
> significant delays in SPI transfers, which can be mitigated to
> some extent by utilizing immediate DMA support.
> 
> QCOM GPI DMA hardware supports an immediate DMA feature for data
> up to 8 bytes, storing the data directly in the DMA TRE buffer
> instead of the DMA buffer address. This enhancement enables faster
> SPI data transfers.
> 
> This optimization reduces the average transfer time from 25 us to
> 16 us for a single SPI transfer of 8 bytes length, with a clock
> frequency of 50 MHz.
> 
> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> ---
> v1 -> v2:
>    - Separated the patches to dmaengine and spi subsystems
>    - Removed the changes which are not required for this feature from
>      qcom-gpi-dma.h file.
>    - Removed the type conversions used in gpi_create_spi_tre.
> 
>  drivers/dma/qcom/gpi.c           | 32 +++++++++++++++++++++++++++-----
>  include/linux/dma/qcom-gpi-dma.h |  6 ++++++
>  2 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 52a7c8f2498f..4c5df696ddd8 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -27,6 +27,7 @@
>  #define TRE_FLAGS_IEOT		BIT(9)
>  #define TRE_FLAGS_BEI		BIT(10)
>  #define TRE_FLAGS_LINK		BIT(11)
> +#define TRE_FLAGS_IMMEDIATE_DMA	BIT(16)
>  #define TRE_FLAGS_TYPE		GENMASK(23, 16)
>  
>  /* SPI CONFIG0 WD0 */
> @@ -64,6 +65,7 @@
>  
>  /* DMA TRE */
>  #define TRE_DMA_LEN		GENMASK(23, 0)
> +#define TRE_DMA_IMMEDIATE_LEN	GENMASK(3, 0)
>  
>  /* Register offsets from gpi-top */
>  #define GPII_n_CH_k_CNTXT_0_OFFS(n, k)	(0x20000 + (0x4000 * (n)) + (0x80 * (k)))
> @@ -1711,6 +1713,8 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>  	dma_addr_t address;
>  	struct gpi_tre *tre;
>  	unsigned int i;
> +	u8 *buf;
> +	int len = 0;
>  
>  	/* first create config tre if applicable */
>  	if (direction == DMA_MEM_TO_DEV && spi->set_config) {
> @@ -1763,14 +1767,32 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>  	tre_idx++;
>  
>  	address = sg_dma_address(sgl);
> -	tre->dword[0] = lower_32_bits(address);
> -	tre->dword[1] = upper_32_bits(address);
> +	len = sg_dma_len(sgl);
>  
> -	tre->dword[2] = u32_encode_bits(sg_dma_len(sgl), TRE_DMA_LEN);
> +	/* Support Immediate dma for write transfers for data length up to 8 bytes */
> +	if ((spi->flags & QCOM_GPI_IMMEDIATE_DMA) && direction == DMA_MEM_TO_DEV) {

Please defer applying the patch until the discussion on v1 comes to
conclusion.

> +		buf = sg_virt(sgl);
>  
> -	tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
> -	if (direction == DMA_MEM_TO_DEV)
> +		/* memcpy may not always be length of 8, hence pre-fill both dword's with 0 */
> +		tre->dword[0] = 0;
> +		tre->dword[1] = 0;
> +		memcpy(&tre->dword[0], buf, len);
> +
> +		tre->dword[2] = u32_encode_bits(len, TRE_DMA_IMMEDIATE_LEN);
> +
> +		tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
>  		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
> +		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IMMEDIATE_DMA);
> +	} else {
> +		tre->dword[0] = lower_32_bits(address);
> +		tre->dword[1] = upper_32_bits(address);
> +
> +		tre->dword[2] = u32_encode_bits(len, TRE_DMA_LEN);
> +
> +		tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
> +		if (direction == DMA_MEM_TO_DEV)
> +			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
> +	}
>  
>  	for (i = 0; i < tre_idx; i++)
>  		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
> diff --git a/include/linux/dma/qcom-gpi-dma.h b/include/linux/dma/qcom-gpi-dma.h
> index 6680dd1a43c6..84598848d53a 100644
> --- a/include/linux/dma/qcom-gpi-dma.h
> +++ b/include/linux/dma/qcom-gpi-dma.h
> @@ -15,6 +15,10 @@ enum spi_transfer_cmd {
>  	SPI_DUPLEX,
>  };
>  
> +#define QCOM_GPI_IMMEDIATE_DMA		BIT(1)
> +
> +#define QCOM_GPI_IMMEDIATE_DMA_LEN	8
> +
>  /**
>   * struct gpi_spi_config - spi config for peripheral
>   *
> @@ -30,6 +34,7 @@ enum spi_transfer_cmd {
>   * @cs: chip select toggle
>   * @set_config: set peripheral config
>   * @rx_len: receive length for buffer
> + * @flags: true for immediate dma support
>   */
>  struct gpi_spi_config {
>  	u8 set_config;
> @@ -44,6 +49,7 @@ struct gpi_spi_config {
>  	u32 clk_src;
>  	enum spi_transfer_cmd cmd;
>  	u32 rx_len;
> +	u8 flags;
>  };
>  
>  enum i2c_op {
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

