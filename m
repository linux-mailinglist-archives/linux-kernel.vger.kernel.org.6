Return-Path: <linux-kernel+bounces-261904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 932DC93BDA6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78E01C219E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588B917335B;
	Thu, 25 Jul 2024 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eH7gIhZE"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DD7172784
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894647; cv=none; b=Zk+GmifbnWvgfqRMm/ixsOjIxczSYjoT4O8Q/qGPOzALSjEWYisYO8baFC2/YKVN5U6wqtWsDyMJ/oQ3uzs8SIEbu+1oOv0Hs9eIgR2pSqbmijilM+kZfsfMBrFmc+OCf7o7PPcnk2s8qBIUoSc5/08HTAZt/X9eUh9oMPPQ4/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894647; c=relaxed/simple;
	bh=HB+/3HZwkVgx4Fx4Fn15o4swYbODYb2pijccfGn3Ha0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwzDETePRIlHY9R70R6qgtLwgDRLIa4cW0HYKUp3edD7GeHyJIF8uahpAJzHVLf9iI9iOpjFL3sVyHnc6hgI7mIF4ESXQJfNyBpbPiLOl+gY5K5cqowT05pxqALeChmeA+WQu852YYS4PdrXMtjVCF3wxd8HefsrrW40nZRxnAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eH7gIhZE; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7093472356dso128072a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721894645; x=1722499445; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=necBe1FQYG1bSvKiOFwD6rYjId+HKb3qNM8q4gz+YAs=;
        b=eH7gIhZEDwf+6A7CDXn6XLVVm7NeGPdyAH+JSUb3BgCFKkMXO+rQy24wSQH/e1KRK2
         y1Vp+HVzawI5RWxAOsrZRCGivTAmHMCIMFjBkGfoULmAcQrA/wtc41Ay1FnWEFlZlM7A
         xsDCcYaSdbuJLp53pe52DNZRciZXtephBpF7RvSy9t9iMmEZv/rDxW64vxHa6bUL4fOi
         D5ZShejGCJtoEb1uDPu2maW55mPY3za/rSFNVAi1Q45Ki/Lj+IE5qAsdZ5VrJQkT8rmz
         p6rNmupTCMaXkH5mVpxN1rfUGSUrj3/Xo2spzGIhIsdDWGC+e2BB8Hg2QIqOJnHbEo+z
         oHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721894645; x=1722499445;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=necBe1FQYG1bSvKiOFwD6rYjId+HKb3qNM8q4gz+YAs=;
        b=n9WNb2qP7qcvzswclGLidcXOe10bjbGP5EvEZm1h/PXuRa6TnmsePFzf0FntWymjyo
         dYD4TteTPS1Ni3QSyNJEd/axEJuN0jJjvOdpyBO2kkrnE//V4uQrEE0dUKcgFAboE+PO
         cLd5NFAsY+h/0ZW/oHN4vHgpSbKtOYZEduopswQ/+key7cGwQebYpH/hwYOuLhulwrIe
         gJ7nsSSensv6OOBavEVRXBeeNqH4UQr6lEHdEO+241WCiN5dr1MHXzx9P7d/FsSwhxYt
         DX1qOQxs+0UsArBI5go4CUSjAsUiO2NT/Kj/+cF76JJKWWgJZPShvKgxYoXcLlD/3jzY
         DJHg==
X-Forwarded-Encrypted: i=1; AJvYcCVZP7aYaDWcUsLIjRqrE6own9eaQlgQBtKjn/c3Xi981bVSeA85oaF2qo3t0biQZWOPcTtbpjLEwfDdMg+9IbKea7djoqWtpiaDUP2+
X-Gm-Message-State: AOJu0Yxv8719ifUWgUeti4lCWA5CKCuv9iAy835pQB0oI1N6h6y3XlMN
	12Xrqodq0shF35Gnv5nWr71pFQwsB5Glvw/CNjtal0QOlCJBjlJWjhrcUJgpLQ==
X-Google-Smtp-Source: AGHT+IGGTG6HZwCC/u9XHZWkFjQAxNKStu0s8QZGvhGGQqa51jtbx9WsPhln3LLgr+DASgDHhXm//g==
X-Received: by 2002:a05:6830:2711:b0:703:68ff:c078 with SMTP id 46e09a7af769-7092e76e937mr2867212a34.30.1721894644564;
        Thu, 25 Jul 2024 01:04:04 -0700 (PDT)
Received: from thinkpad ([2409:40f4:1015:1102:1950:b07b:3704:5364])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e0f8fsm654491b3a.38.2024.07.25.01.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 01:04:04 -0700 (PDT)
Date: Thu, 25 Jul 2024 13:33:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: fancer.lancer@gmail.com, vkoul@kernel.org, quic_shazhuss@quicinc.com,
	quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, stable@vger.kernel.org,
	Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: dw-edma: Do not enable watermark
 interrupts for HDMA
Message-ID: <20240725080357.GD2770@thinkpad>
References: <1721740773-23181-1-git-send-email-quic_msarkar@quicinc.com>
 <1721740773-23181-3-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1721740773-23181-3-git-send-email-quic_msarkar@quicinc.com>

On Tue, Jul 23, 2024 at 06:49:32PM +0530, Mrinmay Sarkar wrote:
> DW_HDMA_V0_LIE and DW_HDMA_V0_RIE are initialized as BIT(3) and BIT(4)
> respectively in dw_hdma_control enum. But as per HDMA register these
> bits are corresponds to LWIE and RWIE bit i.e local watermark interrupt
> enable and remote watermarek interrupt enable. In linked list mode LWIE
> and RWIE bits only enable the local and remote watermark interrupt.
> 
> Since the watermark interrupts are not used but enabled, this leads to
> spurious interrupts getting generated. So remove the code that enables
> them to avoid generating spurious watermark interrupts.
> 
> And also rename DW_HDMA_V0_LIE to DW_HDMA_V0_LWIE and DW_HDMA_V0_RIE to
> DW_HDMA_V0_RWIE as there is no LIE and RIE bits in HDMA and those bits
> are corresponds to LWIE and RWIE bits.
> 
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> cc: stable@vger.kernel.org
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index fa89b3a..9ad2e28 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -17,8 +17,8 @@ enum dw_hdma_control {
>  	DW_HDMA_V0_CB					= BIT(0),
>  	DW_HDMA_V0_TCB					= BIT(1),
>  	DW_HDMA_V0_LLP					= BIT(2),
> -	DW_HDMA_V0_LIE					= BIT(3),
> -	DW_HDMA_V0_RIE					= BIT(4),
> +	DW_HDMA_V0_LWIE					= BIT(3),
> +	DW_HDMA_V0_RWIE					= BIT(4),
>  	DW_HDMA_V0_CCS					= BIT(8),
>  	DW_HDMA_V0_LLE					= BIT(9),
>  };
> @@ -195,25 +195,14 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
>  static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  {
>  	struct dw_edma_burst *child;
> -	struct dw_edma_chan *chan = chunk->chan;
>  	u32 control = 0, i = 0;
> -	int j;
>  
>  	if (chunk->cb)
>  		control = DW_HDMA_V0_CB;
>  
> -	j = chunk->bursts_alloc;
> -	list_for_each_entry(child, &chunk->burst->list, list) {
> -		j--;
> -		if (!j) {
> -			control |= DW_HDMA_V0_LIE;
> -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> -				control |= DW_HDMA_V0_RIE;
> -		}
> -
> +	list_for_each_entry(child, &chunk->burst->list, list)
>  		dw_hdma_v0_write_ll_data(chunk, i++, control, child->sz,
>  					 child->sar, child->dar);
> -	}
>  
>  	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
>  	if (!chunk->cb)
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

