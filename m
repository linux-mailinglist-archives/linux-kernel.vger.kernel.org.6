Return-Path: <linux-kernel+bounces-201056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3681C8FB8B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5ECE288B45
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AEF1487C4;
	Tue,  4 Jun 2024 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FKYE8zvq"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785BE12B17A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517979; cv=none; b=k4WnV5iV+Lccisv9RmWh85XOEYGQId/U+EIlAdz0B6BjPQ8bg5a9g5a55YZrHy9tGgOpVDXL1vSQ6ee8kltgYdGirfeXlgfxAFGLfwD2/CqeHNtXdFKOsIFrOve7ZI8F0wNM7XESHFauyNPgfBXYEFPmWAeQ1fFlRC2XcosXRGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517979; c=relaxed/simple;
	bh=UB5F7l+e1OXNoffNBrdmm83ZIeSjzCW3uwTD66TUo6U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=boELyDx30CoVYFSxUh7gkefOLxCj4lFKw6egrMwwOthZ5kkBLl3WnV3b8IOH9B/w/QHca8ZuD/uYUeGOwH13uGhKsT8/dsK+QQB0uvsCOW8s8I/OKeUQ02VkCr5ZH310qhewsd8qHFX5wCVihh9OkV1HZRgoF8g01+qd7GlaLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FKYE8zvq; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ad8243dba8so28990306d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717517974; x=1718122774; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CL5J75RKeSsjGaFERVr4h+iONwKJd6j+jNrY6jpR54Q=;
        b=FKYE8zvq7oc/vUcZbyKfCBsR/0nNTyocEnRSFLpHHg7iDVBTrmqtr91fBQ/kGARkYi
         EbWmPfsLcMfNAWKB6Y6hTSi0hbo3j8ku85kkiZCUAgOLJUPkYUHrOANniEVx5BtrSy4y
         XqmOjX5T0DK7AjQDeSBaGs4WQwusLYEofGewGWWKMQip4nMk/F+C65MB0ufBr/BtGLu9
         q/VRSYNcttxTaEQtMLGQ300fKj8HK6QUwb+qcN5qbgygwlZ5paQPlsymwZ+IGenZDOYu
         Fw4qdvuUjZug95qADbcgleWMkyEKdoGZE87JUmVbozSMEOb8WKG1MWgA0NL+RAwHb8Zl
         C7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717517974; x=1718122774;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CL5J75RKeSsjGaFERVr4h+iONwKJd6j+jNrY6jpR54Q=;
        b=XhZwirUIR+RmuFjNkYrNmLLZ5rAS1F7htxQMBXA25eLk7bTdUPU4VuRftNArQ6AYeX
         qi205zQk0DLNsONMMu4/MG+yeBFJx0d/6V++wqXB68bTQkRYtIGokh/lceP8Fs7JnR2P
         fYRumkHrdj+vzjkb8m4pn650q61C8YDEwpLhKsfszi2OTiusdPKkiSJ3N6T5IcaFgXcu
         8tDcUj5GQGpuFQhhyxnng7LggGhXzomxkZzxR1UhwA/+zIj600V0KlIS8SzGZnzAIfrP
         bcWns/6C9WMvFNTLl9j9kJD3chp0Xh529fdIrsZudX0Po+E2dwpOk/aVwi6Fix890q4+
         PIMg==
X-Forwarded-Encrypted: i=1; AJvYcCU5HPzqpybjeToNs1M9j/1lsI834vGwlPbu3OLp1R4JfmG/4Kn5yCyivE4gJlt+YNkcY4wWmK3UMbCfYh1SOsUpog98J5yM9tBFiU2C
X-Gm-Message-State: AOJu0Yy66qUR1gv3myf9gUsXuujRIfcJUp9MXErum01CpGM/aZaH9ZQM
	DFAzJRZP4XRVSja0bZblbDNXnArZdDrU1JWeeJq7AGTPskOQOwyglF2czHetKVk=
X-Google-Smtp-Source: AGHT+IFSAArPIaEjpMH4jgaXVYpVXpMimK68ul2RbeeR3lZN0wdr6tbhaKym2ezsrx+vrYGQeTnziQ==
X-Received: by 2002:a05:6214:3d05:b0:6ad:60d8:183c with SMTP id 6a1803df08f44-6aecd5a30b5mr139932906d6.20.1717517974480;
        Tue, 04 Jun 2024 09:19:34 -0700 (PDT)
Received: from xanadu (modemcable018.15-162-184.mc.videotron.ca. [184.162.15.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6afb70d56eesm23119596d6.132.2024.06.04.09.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:19:34 -0700 (PDT)
Date: Tue, 4 Jun 2024 12:19:32 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Julien Panis <jpanis@baylibre.com>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
    Matthias Brugger <matthias.bgg@gmail.com>, 
    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
    linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Return error in
 case of invalid efuse data
In-Reply-To: <20240603-mtk-thermal-calib-check-v1-1-5d6bf040414c@baylibre.com>
Message-ID: <345r636r-487s-75qq-07o5-4n022ppro11p@onlyvoer.pbz>
References: <20240603-mtk-thermal-calib-check-v1-1-5d6bf040414c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 3 Jun 2024, Julien Panis wrote:

> This patch prevents from registering thermal entries and letting the
> driver misbehave if efuse data is invalid. A device is not properly
> calibrated if the golden temperature is zero.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>

> ---
> Guard against invalid calibration data, following this discussion:
> https://lore.kernel.org/all/ad047631-16b8-42ce-8a8d-1429e6af4517@collabora.com/
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

