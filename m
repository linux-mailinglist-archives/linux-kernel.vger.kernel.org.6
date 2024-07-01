Return-Path: <linux-kernel+bounces-236833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 849F891E7A3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40379286068
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA89716F85D;
	Mon,  1 Jul 2024 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UyKA7YXj"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A1D16F0E7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858657; cv=none; b=d7UqN0WbhQA3DGSZ0M4iE36KZzaWUuOG0FkeRuiAiTO/wL4dHDfdlVsS2czNMyA99wnWQAYzhkMN5genb1glJ9fYJLlI0/ug74UDj1RSk49pKU+4FWRrxlUdMgz9hpxphEC8eJN8a1nCAEAyEULm3I3oJu8RNG9awpHem/a/XxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858657; c=relaxed/simple;
	bh=0iOo5cayNGx4g6/tnzEHTcEtMgyyP/qKsGpTDFnROBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFQccf/VXs9L2xxZsPflsozIjDCGvGh8nH1vqtKnZZiaGcTqbUGCam50LNoOmEGD/up0wMxoVQPR7PlxmhBipknpASE8ng+cvWAI4bW2WX+9bo1YtKKZ/fWR20JdM1LOi+t3zH+23AZkLFhkoA2zAUKGHNU30CnBcteQpXIaVh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UyKA7YXj; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52cdc4d221eso3658088e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 11:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719858653; x=1720463453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B1bORojp7LGodQMmR0GktDpziQrjk5mFTyAYpRSH12Y=;
        b=UyKA7YXjTojtp1ZxOkUeDIJvO2oRRyI2Nv3kMyZAXNizo8lhSHjpOZ6cGeitUGP74t
         Y66MGsyTix55v8gB6BwoFdaFSUsiQm7no6/K1FtOR7RBWqYCLIFLxCk3dbmdxfjPndp5
         Ip2H6a01ZoZW8ydNTUIblqnqTqUV+lxzVRW5yjIO5R/bqQI003syuX8sEEkHYD1sLECi
         nBUxcfHHmEcEEisWPGdBbGMCpw1YDYt7xpO1mHWi535dUd3XCRv8ZLj47sZpUu5WM/9+
         qrXngImhQVugLK4g7hl69+hkANjX/nXP5D5rDeHdwcER1hc3d4pqPgtk/x2XNHjy21dz
         uQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719858654; x=1720463454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1bORojp7LGodQMmR0GktDpziQrjk5mFTyAYpRSH12Y=;
        b=hYLuFpgHd7gNSE5RZFDZm0BsFn6+4wFrb1iO5k3eICU+M58pge3qRorAZtjXP8+eSs
         9MqHY90SaFiW54ip5f5Z4Ik+A4cOPwPhuWKGC3ZkYX+SlhyMDQiU+fy2bP4RC9+wNeSA
         qD5zRHWk6vyymY2vA3pMO+CaFzJJWWR/xGVeldwwoD20Vtd3pXaWitF7/cZSrrv57fAt
         9h2Hd8G07M4dEu5xKMxzwZsbrQuN1b+Yb4PxXMkkMhas53SZ6HRAwuaFEkviMbAqjbtE
         wJHNatsvln1ZuTggTv7LK1aO0wikuyle8aEXHuLL+G+qvhJhgDvh/eY4FaeODl2zVrx/
         0PfA==
X-Forwarded-Encrypted: i=1; AJvYcCVimyoTYZ6LlqfoD7Y3pWtKl3eO3o4YNns/GkepcxNUvBG8iZ2EKs3LfjzOMZNjn386y29pIMVMdMARhya0R23tk+foKTYgs+Tf90Jd
X-Gm-Message-State: AOJu0YxtiQTsoMB7mEPIB7lAyaqf4aRF776QGdPQr5My4hQYArZxpaC2
	QmlqRFRfl5cCh7ugZ+DNolJj0z36cU/L2MwtgT/jGSUFbx27jgTnqgJVEjlWpj8=
X-Google-Smtp-Source: AGHT+IGio8w2qPHnHjpAdv9Xq1wSVEaXIaQHK0Jse0W5DVm/JwaGTZCVvQ9Jvyo2ZGxv4pHSbq62yQ==
X-Received: by 2002:a05:6512:b8e:b0:52c:8210:13bc with SMTP id 2adb3069b0e04-52e8273e3acmr4380491e87.64.1719858652604;
        Mon, 01 Jul 2024 11:30:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab0b9f0sm1480819e87.12.2024.07.01.11.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:30:52 -0700 (PDT)
Date: Mon, 1 Jul 2024 21:30:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: codecs: lpass-wsa-macro: Fix using NULL
 pointer in probe() dev_err
Message-ID: <slpv56feowlalqd2olti5bnxluovcvjs4k7koszhukfxvgycz3@4mm2n27e372l>
References: <20240628095831.207942-1-krzysztof.kozlowski@linaro.org>
 <20240628095831.207942-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628095831.207942-2-krzysztof.kozlowski@linaro.org>

On Fri, Jun 28, 2024 at 11:58:31AM GMT, Krzysztof Kozlowski wrote:
> The 'wsa->dev' is assigned closer to the end of the probe() function, so
> the dev_err() must not use it - it is still NULL at this point.  Instead
> there is already a local 'dev' variable.
> 
> Fixes: 727de4fbc546 ("ASoC: codecs: lpass-wsa-macro: Correct support for newer v2.5 version")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  sound/soc/codecs/lpass-wsa-macro.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

