Return-Path: <linux-kernel+bounces-242608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD09928A66
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A88EB24D5D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325CF169AE4;
	Fri,  5 Jul 2024 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L5kfmgf1"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ACD166318
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720188669; cv=none; b=n5GJMpTcI57w/bgrnwA2gj3Dc3ZNz8bjWeGrU5vEIr9PGdeCURjb1Gr3Obrx7iHWVmgH7M0hdWm+785n69AVg3ZrXmnAeYtWJg2qw0hAmH2TYK+ubX86BVZEUv45kZ24F2RydZuryq6bdijJxeQaEUa8n+rDHGj+sf/ezeSf2Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720188669; c=relaxed/simple;
	bh=zuP+/htUq75qrtouhxbjufUQHe6tuVLRCfDQpICxGf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcVWXhtFtMMt9Fnx/HXG1nmSU/jIiLflUmp6Ho/RnODFJg9GwYtIb8JkEs5LI0H1nlhlRY1m1BYssk6hok2LmmTZ2+F1bXEcsPh56ex1LYVbxb2kteXk80l6hiiF4B20Vlx7fO0j7mapz76Pnesb/3du2aHLEGprr6CeV/cYxqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L5kfmgf1; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70b05260c39so959584b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720188666; x=1720793466; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XM4HbvawPCBny+Eeb2JRLz0OMBw/Ulb/Z2EqXlrBEew=;
        b=L5kfmgf1T6p1tliGIxtIvayFkEkqwf5KmcpHPN8yTPpstDizf8NCMGjAdzFXaw+Ktx
         5L8z6dm5eeQ5mS4q/Ixg4YOC5RuU1MJCZKPumetyekM61SJiaC19wr4D6+RAaHxSGYST
         ElFpXQO2z+MlvgmP25eT9mtfsLbLX8hNslAKUWiWjVAtxYmmzrdfvlU9Ee3fHz6WzTRm
         g6HMFh9rlPpn008Kk0EkU3fjUYzyiogH42v8PGBtItX7bXrdDAqBN/W6RS9bC2J/qrK4
         v4HF1FyzfFtMHmP+aHnKatgjYYRnHJ6oXScUEcYWd2CwN927URa9wwT3EMU0srAlr41H
         L8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720188666; x=1720793466;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XM4HbvawPCBny+Eeb2JRLz0OMBw/Ulb/Z2EqXlrBEew=;
        b=AHNLOA56wf4sVosHLpBlVnGWqlyZxcrMNoh5l9SEWFBl+YM4mVKs8gC6ZrL1gAWF5w
         SxwPmof2ObWmFp6KnSPqGIM9qLHUaTmHwPd1ChR19ztSDI+kBUAxHadlCiWcJdH0lhWF
         Wa0fXN0F4F8hdlm7ClGXDHyfKZmQioQaY82lGqY0Vo4Q7welkdMjxMRS9XykWwlDJrbx
         BAjlLfVBqww3zov5cDSVvMqHnoP+Y+W3psrerS3ck8eXqFI6o2m2LrfkVYDBsN15Wtn6
         8Hl/Z1mWbaCjYG2DeWaStiili4HJb1fdfvznKXuq5MMU4RnYy3SIZw2DGFNaCvS2xDzZ
         I1yA==
X-Forwarded-Encrypted: i=1; AJvYcCVhhQXx7RxrjFN/DxdH5TCppSaEmKKvq5yYXn1I+LxYzws55keDwq9DX3OHwIBu1JzKqYxTjG5mBt+zHUZ4uUuNY4pWOi3d7uBtyzNw
X-Gm-Message-State: AOJu0YxF+kURBLWmZJi32fZWsSJ6L4he3iEKmE043pedwtXRrpvnJaMW
	s3gHsmhdTvWwC9kGBAQOh1EUjyu1MJDToGdTwWn3uGGfVw2MaDcA+IGgdvbKD40/ok1axERyy9Y
	=
X-Google-Smtp-Source: AGHT+IFy25FHZc4IHUBbnmHPL1FZGIlfz/twkzh99J3sTQjp/rXEbOPYKNsKaz8hkfuePIxxixTx/w==
X-Received: by 2002:a05:6a00:6c98:b0:706:34f3:7b60 with SMTP id d2e1a72fcca58-70b00b62171mr5118719b3a.23.1720188666491;
        Fri, 05 Jul 2024 07:11:06 -0700 (PDT)
Received: from thinkpad ([220.158.156.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6afb8ef1sm11285704a12.40.2024.07.05.07.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 07:11:06 -0700 (PDT)
Date: Fri, 5 Jul 2024 19:41:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "zheng.dongxiong" <zheng.dongxiong@outlook.com>
Cc: fancer.lancer@gmail.com, vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] damengine: dw-edma: Add msi wartermark
 configuration
Message-ID: <20240705141101.GA57780@thinkpad>
References: <cover.1720176660.git.zheng.dongxiong@outlook.com>
 <SY4P282MB26243F37A69E54C2B469DFB2F9DF2@SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SY4P282MB26243F37A69E54C2B469DFB2F9DF2@SY4P282MB2624.AUSP282.PROD.OUTLOOK.COM>

On Fri, Jul 05, 2024 at 06:57:35PM +0800, zheng.dongxiong wrote:
> HDMA trigger wartermark interrupt, When use the RIE flag.
> PCIe RC will trigger AER, If msi wartermark addr is not configuration.
> This patch fix it by add msi wartermark configuration
> 
> Signed-off-by: zheng.dongxiong <zheng.dongxiong@outlook.com>

HDMA driver is not at all using watermark interrupts. So we should be disabling
them altogether.

See: https://lore.kernel.org/dmaengine/1720187733-5380-3-git-send-email-quic_msarkar@quicinc.com/

- Mani

> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index d77051d1e..c4d15a7a7 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -280,6 +280,9 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
>  	/* MSI done addr - low, high */
>  	SET_CH_32(dw, chan->dir, chan->id, msi_stop.lsb, chan->msi.address_lo);
>  	SET_CH_32(dw, chan->dir, chan->id, msi_stop.msb, chan->msi.address_hi);
> +	/* MSI watermark addr - low, high */
> +	SET_CH_32(dw, chan->dir, chan->id, msi_watermark.lsb, chan->msi.address_lo);
> +	SET_CH_32(dw, chan->dir, chan->id, msi_watermark.msb, chan->msi.address_hi);
>  	/* MSI abort addr - low, high */
>  	SET_CH_32(dw, chan->dir, chan->id, msi_abort.lsb, chan->msi.address_lo);
>  	SET_CH_32(dw, chan->dir, chan->id, msi_abort.msb, chan->msi.address_hi);
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

