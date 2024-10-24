Return-Path: <linux-kernel+bounces-379360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5479ADD9A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32EE11F2257D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53591A0714;
	Thu, 24 Oct 2024 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onCJJXW9"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E0619F13C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729754911; cv=none; b=roJKYeZAvJmt5ez4arw98HZ/kn1DeIjsIPeZJCIHNSQlyITNbDQNnsgHfe5sppumRpH6SFuo/DvZJksGLuStZdCjxRea+Yvm1ICR1gYCNJ+gsTeJ+tR27/2aLRPeLwfl3uCwhL4ydE03RU1OdMTxSO+QFjDqEA6Y3czKZn9XfUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729754911; c=relaxed/simple;
	bh=ZtJJpAbqMdpdoXmmBuRnIgoG9V/xCS2Vppl3tp08FS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAVGavgoG5qPCOhV1HgBNLMBPzpp+ttRx+FJzPsS0iF0+QXcpN5t1RNeQ+KX+87GmXfE+bvBnERN2dit+lYl4Mg5CLA6QF/IhqFKV41zpxAvEx8YDydStor0WIulji4Nl/8ZLHRAsrA54uBBfmacNBxvINYlNtiUQ7YfDi5ptis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=onCJJXW9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so364156f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729754907; x=1730359707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxOUrhJfsj2Yyo7Z+zyHQ67FbF1Rk6t8sl02neWyWkY=;
        b=onCJJXW9aIn4nQrq3Cj6n8Wu62VHDI6on3bnCdPDQ3g/DABKZeaPMI2aip91ge25kN
         6oGmSDmRGjtOIyfcn5VYhgEHZVySZhLM7ZWSFr4cv+8mnqg2j7i1n+6v39XyoXw2EOl+
         OGiMoOHocRTrcP4PTQqsFK03CEd7rmpJcQ3sVtIQAN8lN7KeLJFe0UebhiDjI+bFTdWy
         GehxzTAQmi5nzCKQL59/t3WpsX6vdaii+wLB/29IsyaCmT1vGzQhz0iUTX1iw2B4JdSy
         ayxlGMq2M0VG+fF8NCiGrlWB7aBIGLrrMZHSIsVchq7heIXqwR4OrvdROva+oTPPI6Gu
         OyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729754907; x=1730359707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxOUrhJfsj2Yyo7Z+zyHQ67FbF1Rk6t8sl02neWyWkY=;
        b=xNSfWCOHN/AVO8wSsTT1Pa+VMLtNNRsrea1ACDGez1c/0cBLhQcB1X7UUawJfPfznd
         sIS5oloYzZ31f7R23YDQf9f2ttYm/pDefetSRwta5DINANsPw5ulgCW605RL+s/HWiLS
         KZw47NC/HC00rCvuijupf0r3Sm5O7XFpkBcE317Jk5yTqBAXif9NHTnYmPsPU6yDeL6f
         nn+qer4vKxl+ArhTUYKp54ad1PnSYnZnzc9taVMK+zvdJwWgzC70rNcKvO/shjiFfHGe
         y3CesTZpnVcbQdPkrHxi+oGWrwiCAm1fWIi2KI3er0ndku8uHocB+CZIqBtvjWoityzy
         FLxw==
X-Forwarded-Encrypted: i=1; AJvYcCU2+z1/GJDR7ZXUsiCDgauWFAwtIsbISlpO/2yXBpiaiojIFPwCtG0lXWN5s920fcD0p/ehKWwvkCKD9Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmqyRu5Nry83u8NpzOIH5cp4xVlxMATG0ptvyhuDc4wIpxanvt
	ezO4zTBv6HStWnE1ImEH3z31do4RevGagggzCi8ie5o1XUHbcfBlJKdDEUap+e8=
X-Google-Smtp-Source: AGHT+IEkc14OXpDtF1URWR3t+XH91jps08DOypXXI/ENusMPhUEulRqck3KhgtV8dhuWSr0NvGRsZA==
X-Received: by 2002:a5d:45ca:0:b0:37c:ca01:98e9 with SMTP id ffacd0b85a97d-37efcf00572mr3479995f8f.6.1729754907152;
        Thu, 24 Oct 2024 00:28:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a5b98asm10668926f8f.61.2024.10.24.00.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 00:28:26 -0700 (PDT)
Date: Thu, 24 Oct 2024 10:28:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	~lkcamp/patches@lists.sr.ht, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: rtl8723bs: change remaining printk to proper
 api
Message-ID: <f61d8272-4af3-40d6-a333-e7731c3fc5ae@stanley.mountain>
References: <20241023231155.16940-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023231155.16940-1-rodrigo.gobbi.7@gmail.com>

On Wed, Oct 23, 2024 at 08:11:55PM -0300, Rodrigo Gobbi wrote:
> As part of TODO file for future work, use dyn debug api for
> remaining printk statements.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> I didn't use the netdev_dbg() over drivers/staging/rtl8723bs/hal/hal_com.c
> because I noticed now that rtw_dump_raw_rssi_info() and the hal file is a 
> little broken with -DDBG_RX_SIGNAL_DISPLAY_RAW_DATA, maybe we can 
> fix that in a next patch. 

How is it broken?

> diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
> index faa6ed2b320d..5994e574ae99 100644
> --- a/drivers/staging/rtl8723bs/hal/hal_com.c
> +++ b/drivers/staging/rtl8723bs/hal/hal_com.c
> @@ -909,10 +909,11 @@ void rtw_dump_raw_rssi_info(struct adapter *padapter)
>  
>  	for (rf_path = 0; rf_path < pHalData->NumTotalRFPath; rf_path++) {
>  		if (!isCCKrate) {
> -			printk(", rx_ofdm_pwr:%d(dBm), rx_ofdm_snr:%d(dB)\n",
> -			psample_pkt_rssi->ofdm_pwr[rf_path], psample_pkt_rssi->ofdm_snr[rf_path]);
> +			pr_debug(", rx_ofdm_pwr:%d(dBm), rx_ofdm_snr:%d(dB)\n",
> +				 psample_pkt_rssi->ofdm_pwr[rf_path],
> +				 psample_pkt_rssi->ofdm_snr[rf_path]);
>  		} else {
> -			printk("\n");
> +			pr_debug("\n");

Just delete this line.

>  		}
>  	}
>  }

> diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> index d18fde4e5d6c..b845089e8d8e 100644
> --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> @@ -72,7 +72,7 @@ static int sdio_alloc_irq(struct dvobj_priv *dvobj)
>  	err = sdio_claim_irq(func, &sd_sync_int_hdl);
>  	if (err) {
>  		dvobj->drv_dbg.dbg_sdio_alloc_irq_error_cnt++;
> -		printk(KERN_CRIT "%s: sdio_claim_irq FAIL(%d)!\n", __func__, err);
> +		pr_crit("%s: sdio_claim_irq FAIL(%d)!\n", __func__, err);
                ^^^^^^^?

regards,
dan carpenter


