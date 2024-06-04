Return-Path: <linux-kernel+bounces-201112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EACD8FB9BA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E5D1F22AE6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7D6147C98;
	Tue,  4 Jun 2024 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U7csEkel"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A973953BE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717520419; cv=none; b=eua1UJXFMKMhVNXKPEgKBOQf2YucJvBWvpot9KJHDoN4XAzVRzy7CuQwyqxRzoEMdappaadpqBrVQDd/Ax9qziYTngpaZD4C43eUKXm42Hgpv2/TQQJ9yGjk6TZ9Xjfx6yBpyCJGCwLfumH0r+TF1Qo8ZqD4aM9Ht/4ingdDNBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717520419; c=relaxed/simple;
	bh=fF0TXTSu9ZdxYplCWZn8PgJSYBNCY54cocf6M2ubMLI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rt+NBCUyz0ajsTc5l7NcoeRcL6oa07rmvPhIlJu8CmKZv1eXZfWxb5RkYbLxl93ColnTFC9cHiRAgpb/aWC8c5wmk6wNL5wNgihSIwC02BTW2oJczEYy593mbQ9W0XgcxcLuMmRLYYccTLUO/AxvH2f8wrA1J9D/PpxcbyZXmG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U7csEkel; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4401c9f5893so5932891cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717520416; x=1718125216; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0FXev4Iglq7vn8M9/xJrlzCWzECxyOY6UHQcKBzcM8E=;
        b=U7csEkelxllbgJ92PlXTAMf3YGNAAwLkrUFiGQBYuyVntZsVhLsomQh73YKvhraVg1
         uukir5ycPNgk5aMgcwWx5KzVa0o/BbKbnzmNDsWytQwi3jtZpTR/1NRl20XMD2dFx2JB
         JaLGAo5W/KGGgFnIbKklKs7RM3JZ7Q01OBaSV1diWtqjNsveUv3ef9IeFo32T/+CDBOQ
         JXdRDnjhE3y8aHm96CyweqF23oTHeVW2kLvjfDdCvi5+Dr3vKrJHtBJtonk5vKtvTyho
         ND4TE/kCL+/W0oq7r7u9Pj6VslMTvQE85ybrA2UHoRFeSyGAK0BOAszbg4oS1MLn3knU
         ylIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717520416; x=1718125216;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FXev4Iglq7vn8M9/xJrlzCWzECxyOY6UHQcKBzcM8E=;
        b=BxeHuV6YpHcYoAkffo2YNDmfhgaTcLed3wlhO0VUX/vhVoGhbxGcxtIA4NFBVLYbwx
         uMrSwu/jnj0W1yZ7MZxlfCdnxCnT8cdYUjvEpyZMBmZvOiktdSqcQhRx5hu89uApX9C3
         6ZyOivAGdsNl0I30XdFHCvhzSLsjHDwvSetmGEgHdkHpVQgp/zVdYqmWWn/bQCqUkjaM
         qlp6qNVS9pQHnt4ntoHpc2QrEXBe+0BxMuJEyT/uPPqHiQWNFxo4cIx1B5Yc4VZ7eat0
         mwIDaO6nslYW9E4X0fJic6wHXEErlxmfXptkhT4kqiUb12Ns8LOZhXtjiJPWitZEVt1C
         dRgA==
X-Forwarded-Encrypted: i=1; AJvYcCWd9k6zve7KRYVWXHADkotHpACMUJRIonsoRpLb56fkohzJLj6WuqdeN1fb56MsMZ80VM4ezSXQjxGzrBrmwbGIOQsHYZFB6CpCUwdn
X-Gm-Message-State: AOJu0YxaXMmlPKWYJVq4xWsf7aQc0YDUUpfSIcPftDBdXpSMVXeVSq7L
	ezpXhBf6ApvUKZd6MSEKRYmcrLjT+fYnNx3bS+7RWoRR18yVB41SeGsf0wqwVPY=
X-Google-Smtp-Source: AGHT+IEQ+mgjmHq05bdk7xACEVNcsSDNdul6POVLs6t8LHbGadcCJYvlJlevhDqW8d5ZOSNb/8F20Q==
X-Received: by 2002:a05:622a:20b:b0:43a:f89a:6631 with SMTP id d75a77b69052e-43ff5250db8mr133406231cf.8.1717520410432;
        Tue, 04 Jun 2024 10:00:10 -0700 (PDT)
Received: from xanadu (modemcable018.15-162-184.mc.videotron.ca. [184.162.15.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-440204b5420sm7471591cf.17.2024.06.04.10.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 10:00:10 -0700 (PDT)
Date: Tue, 4 Jun 2024 13:00:08 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Julien Panis <jpanis@baylibre.com>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
    Matthias Brugger <matthias.bgg@gmail.com>, 
    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
    linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] thermal/drivers/mediatek/lvts_thermal: Return error
 in case of invalid efuse data
In-Reply-To: <20240604-mtk-thermal-calib-check-v2-1-8f258254051d@baylibre.com>
Message-ID: <25528q8o-73p2-25s2-5o2q-on72no5s91qr@onlyvoer.pbz>
References: <20240604-mtk-thermal-calib-check-v2-1-8f258254051d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 4 Jun 2024, Julien Panis wrote:

> This patch prevents from registering thermal entries and letting the
> driver misbehave if efuse data is invalid. A device is not properly
> calibrated if the golden temperature is zero.
> 
> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>

> ---
> Guard against invalid calibration data, following this discussion:
> https://lore.kernel.org/all/ad047631-16b8-42ce-8a8d-1429e6af4517@collabora.com/
> ---
> Changes in v2:
> - Add Fixes tag.
> - Link to v1: https://lore.kernel.org/r/20240603-mtk-thermal-calib-check-v1-1-5d6bf040414c@baylibre.com
> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 0bb3a495b56e..185d5a32711f 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -769,7 +769,11 @@ static int lvts_golden_temp_init(struct device *dev, u8 *calib,
>  	 */
>  	gt = (((u32 *)calib)[0] >> lvts_data->gt_calib_bit_offset) & 0xff;
>  
> -	if (gt && gt < LVTS_GOLDEN_TEMP_MAX)
> +	/* A zero value for gt means that device has invalid efuse data */
> +	if (!gt)
> +		return -ENODATA;
> +
> +	if (gt < LVTS_GOLDEN_TEMP_MAX)
>  		golden_temp = gt;
>  
>  	golden_temp_offset = golden_temp * 500 + lvts_data->temp_offset;
> 
> ---
> base-commit: 632483ea8004edfadd035de36e1ab2c7c4f53158
> change-id: 20240603-mtk-thermal-calib-check-ba2ec24a1c32
> 
> Best regards,
> -- 
> Julien Panis <jpanis@baylibre.com>
> 
> 

