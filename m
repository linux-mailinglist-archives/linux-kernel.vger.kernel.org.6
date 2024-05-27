Return-Path: <linux-kernel+bounces-190287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 853CB8CFC71
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8C228389B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A7E6A33D;
	Mon, 27 May 2024 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hkt8MkHA"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE77217BCD
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800771; cv=none; b=l8rrYD1KOT77rAP9MVx+/LwjidLUeaJNHXQq49cpoSNCq6aSyZlkgdc/qBXIrmx+yoTizwTpYdf//NpuAR2LxG5MtV8crIiIcyn7BD8EIzjr83cwmOv/jFJF7EUmdAP1SqCXcDQz/ery6W0ctT6l0Wt1qJbDup24VptVGZemJXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800771; c=relaxed/simple;
	bh=Gs4PX66nrFGoxLlu5z968DmwNa+4mZ+YwkgGi250oy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hreEZZcriG7SS9WjaKnvyKT1PfdfwkTiWqm/5QJpAC7zaF0GyFUdA8ehuSNV4Q41v3Sl2Twm6gBgekOn1A5ov8oWCg/S+hoc1jEEvwVvtdPrzYpk1IpBt5gCTYNsh6oPgAqCQI8rmp4ehb/DA4bN2zfMwcrWp5jRjj9/0Rz88Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hkt8MkHA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5238fe0cfc9so4821898e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716800768; x=1717405568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OMLd7p+Que1meif8YHCemGbLRtR9KifnLNtA/LHS/So=;
        b=Hkt8MkHAk1d45BmNwbMsdwtXlebkiFs81+EeljLvnILN6eB3gE2SMGHG/DYfUxyItq
         8xeskweSVGjXe5/x8jCSzFV7yORPZSZJHRN7EgXZDh7aU6SsNjje7O/Cy3ATy/bgQSZi
         RiDrtPO3SohkgL81APvhcTjqR7jBfawE0EYQGYxtqns0k3wDLzlzmcU8/VNmFIQBGPXw
         sXChAgjEDuQF2lRfw8kJRpvIxnqqINPqERix9UdQ4CdHR3R4oX/qaTiCpSVEqpCXM4Zm
         bGnONnNAd+Nh1Lrc98Z0W2/4PBvxjZg8M+ey5XV/l+Jvha/5awsk7KNtEvwiSu0K1O8L
         TYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716800768; x=1717405568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMLd7p+Que1meif8YHCemGbLRtR9KifnLNtA/LHS/So=;
        b=OHe9ezOmjOlLBLkWookxsY6BqcPD6UX/aSEVhF6N+rZZNIC98MpSaZLoi7exQiVo8D
         CtWBufkyorc+5k2NDdDi3K2/ydbUfM3TUxkZVh5P1GW+efFTDm1jGAMxPeO4y3K7t6eh
         JDYqqLNBfjdYoIdvAYRSNLAZm/z0Cr3XyULBJhAw+HmWTrMSWiCETDcDGLXtPUBz3yEe
         6Ots8UTGX8l6GNKV8+iS22PAY5ke8GNnnPwsTBdAq03Bx4l1WGkBDEDy3eJW10W5E9bM
         9x/xVh3mm9slGUTYFVSijfnRQ1s0Ddo6ao7tnrXgvvlgrCiyCGNhs8ESre46Q8zkgNZH
         27Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVSxU5dbA/pgVpzfOF3jrfhd1jFbJrw87TeLQO8E/vJxEvE4HZS0WPKIu3nnOfsrZYJ+qGRASJp8UfEdfdcpiCZMld5yw0dBbUgPXSO
X-Gm-Message-State: AOJu0Yx3mV9fjwkoDSK3EsguBX+9DwBmzxNZnPlevYaSONwxd48VfeH9
	FhcOr5k3hiMtJf0/qURe20P6oIQrMmk23E+VGF3JSnatx8xZGv9zjxOFVoLWZXdu27PYTcrECoJ
	O
X-Google-Smtp-Source: AGHT+IGkXmvrRQ6mpRufYwk/kC/26tyDgDsA5Ckg6RIN8jvh3T/HBnhZA8lPzBaM6D4S85WI+aZuVw==
X-Received: by 2002:a05:6512:b14:b0:529:aa43:4522 with SMTP id 2adb3069b0e04-529aa434af7mr1409251e87.24.1716800767878;
        Mon, 27 May 2024 02:06:07 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066b8b3sm492168e87.174.2024.05.27.02.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:06:07 -0700 (PDT)
Date: Mon, 27 May 2024 12:06:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pmic_glink: Increase max ports to 3
Message-ID: <3xiwtl3m2eujg677r3ipjkprhtsviv5cscowsle2seitzkhh7o@scxobcbxp5hf>
References: <20240527-x1e80100-soc-qcom-pmic-glink-v1-1-e5c4cda2f745@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-x1e80100-soc-qcom-pmic-glink-v1-1-e5c4cda2f745@linaro.org>

On Mon, May 27, 2024 at 11:16:01AM +0300, Abel Vesa wrote:
> Up until now, all Qualcomm platforms only had maximum 2 ports. The X Elite
> (x1e80100) adds a third one. Increase the maximum allowed to 3.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/soc/qcom/pmic_glink_altmode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

