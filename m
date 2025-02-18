Return-Path: <linux-kernel+bounces-519470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C468AA39D41
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32A9170B21
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE792676E8;
	Tue, 18 Feb 2025 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sbe68vC1"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995C12405E6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884545; cv=none; b=e/YsxQFO5xTjqnAzZ7zQdk3VO5TbZoaMF7LC4NYfpX6HeKvTYavGpphhjl+ivnGAEVjS31IzDTXhNJjvKa6zESVRpoi+fPvfyLqmOZKSetu2F+GAw6FFoIi0Kqb5fQKEbavvqR/Hkg6Uog6vF8x7t9rcf8cPd1TdPk/nsaq2yDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884545; c=relaxed/simple;
	bh=T2JYe+LQSB/nygVTjyMcCXLEryVG9kuvcUDlAdCDWu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqMvRmmolac0DxS0gs53bV5gB5uGFlHxVgsKI7udS1sLUo2xHZvecm30Fce1S8527f9oTfC4arI4WbyqsJc2Inqg+UdOTl1QwWLBEnX7X3rUbumbjKJZkFgDCsI34EzSBMZe8LaqgVkYEHL687YSU6XmHQS4l9JdTbsQl4b/VYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sbe68vC1; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso453058966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739884541; x=1740489341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=seJOt702BxciOrZQGfbCE9NbiygJD+aaFMVx5CIWE5E=;
        b=Sbe68vC1CVmagAPRSL6NVbBprvMJPfh+v7MQiT+1pd6Q+8PdI+eODgVmFkgGZ5N0Qc
         HQazzI4xgzYr0FEDHQVM2NcSiSaZP2M9z2IhEIHU5+4zcKm60JLXvOhn54Wjh3/XQwZo
         LBLCUsF11fvM6b6qgetEIblMK6nnCKjhRf5Yv7gq/93Kk3gdJWVpuydfAOD0d3pHzJ3W
         AiVQhxTWDde9esDFPXmy0fBT5YeTzJ73Q9RX27OrlyifmlytMpK0QHmldP0ms+OETyae
         9kSUSXfubiSyd7HmLzwEIxtxc1CKB8mAw+W96za3Qsjuxn7KZExK/dHH4cKNFEtdaT3U
         FycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739884541; x=1740489341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seJOt702BxciOrZQGfbCE9NbiygJD+aaFMVx5CIWE5E=;
        b=GRZYHVQ4ueOXRoIJ/YuMOkUUlrKLQjQ61//YU6PbuRl1nlh/DOrdPM7Q1fGToJHb90
         FCH5DyZmLsmaRzaofGssDQ0a/QUKS1rupSGLkJowheiv3utM1Fbre1elxDcPm1AmlMhr
         bOBfy0WdsOy1cx8iUqCTbkC53hRuWyCApzzIe7GRpFQNC42CJaftl7+zjkYVVitDa1sG
         PG4Z4ZpXJJrYq1ExyVSjyok3IViWuxWS1jX5nbf384eomS3cRh8OudebLTcexAZ734iI
         KFpH16lMIisIXnPS7FXNxkGrWgeVjH1jmlbeXYSF+hw9Cn6c9LLlNQRJ2iPcBDPqx6mc
         1PWA==
X-Forwarded-Encrypted: i=1; AJvYcCWGj9mh2Wi9CBqZcOQyU0JflMoQLdZ9igGjVllhgOdVSwJbu8DhqqDJtUgp4qxqWXn/FlahLCybtuxWSeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO9EqtbhlT8lBL9Rvb706+HoQ+vJhxfGYS4Ggx5qeuorHn9vbE
	ABn5scmh3mQs122jqpknEA5YmMvjj3LRAG5j8jK5Mwx6VhsJrxCaR1RZESIp7/0=
X-Gm-Gg: ASbGncscYEce96Hm/TEkKFxPkRn/a/Bz848nHTuQMkmEjm+Z2+r1l3c2bnGvotJwPZa
	xR/sab9seLEKYUjVtwbve+WvZqRMcjtEiymLzpmWxyjsUKbrQf5UQ5FNC3Y7iYbIDtaTNIUeb2Y
	08D80Zpdwd/uaV67//xpt2mr9uIufsLTq4YMmkqPWypOqowfSi2Lw9OK3+JkStRjzCF7/8xErxc
	+p0LXWS9VYM4dX03aqFPBdMCGT9hEH17S7Eke+DGtcCtigYXEAwrefqTEhfcExShjpDRdkdK9c/
	7fHlCnYYeA9NrA6GdbNQ
X-Google-Smtp-Source: AGHT+IHnl+jBmdJsRUXRwBR/mH52YC23EuGVS0vmhx7dq14tgwuSG89//4yrt5azsXLFxS0+HMeVxw==
X-Received: by 2002:a17:906:e0c5:b0:abb:ac56:fcf8 with SMTP id a640c23a62f3a-abbac570080mr510173266b.57.1739884540816;
        Tue, 18 Feb 2025 05:15:40 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5dece288e38sm8604786a12.79.2025.02.18.05.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 05:15:40 -0800 (PST)
Date: Tue, 18 Feb 2025 16:15:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Deren Wu <deren.wu@mediatek.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] wifi: mt76: mt7925: fix error checking in
 mt7925_mcu_uni_rx/tx_ba()
Message-ID: <5e7bc52b-332d-475e-94ca-571864cb1a6a@stanley.mountain>
References: <063aafdf-3234-42ac-a4ea-3ff98e2835b6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <063aafdf-3234-42ac-a4ea-3ff98e2835b6@stanley.mountain>

Ping.

regards,
dan carpenter

On Mon, Jan 20, 2025 at 12:46:58PM +0300, Dan Carpenter wrote:
> The "ret" variable in mt7925_mcu_uni_[rx/tx]_ba() needs to be signed for
> the if (ret < 0) condition to be true.
> 
> Also the mt7925_mcu_sta_ba() function returns positive values on success.
> The code currently returns whatever non-negative value was returned on
> the last iteration.  It would be better to return zero on success.  This
> function is called from mt7925_ampdu_action() which does not check the
> return value so the return value doesn't affect runtime.  However, it
> still makes sense to return zero even though nothing is affected in the
> current code.
> 
> Fixes: eb2a9a12c609 ("wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> index 15815ad84713..b3a00964e802 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> @@ -617,7 +617,8 @@ int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
>  	struct mt792x_bss_conf *mconf;
>  	unsigned long usable_links = ieee80211_vif_usable_links(vif);
>  	struct mt76_wcid *wcid;
> -	u8 link_id, ret;
> +	u8 link_id;
> +	int ret;
>  
>  	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
>  		mconf = mt792x_vif_to_link(mvif, link_id);
> @@ -630,10 +631,10 @@ int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
>  		ret = mt7925_mcu_sta_ba(&dev->mt76, &mconf->mt76, wcid, params,
>  					enable, true);
>  		if (ret < 0)
> -			break;
> +			return ret;
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
> @@ -647,7 +648,8 @@ int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
>  	struct mt792x_bss_conf *mconf;
>  	unsigned long usable_links = ieee80211_vif_usable_links(vif);
>  	struct mt76_wcid *wcid;
> -	u8 link_id, ret;
> +	u8 link_id;
> +	int ret;
>  
>  	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
>  		mconf = mt792x_vif_to_link(mvif, link_id);
> @@ -657,10 +659,10 @@ int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
>  		ret = mt7925_mcu_sta_ba(&dev->mt76, &mconf->mt76, wcid, params,
>  					enable, false);
>  		if (ret < 0)
> -			break;
> +			return ret;
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
> -- 
> 2.45.2
> 

