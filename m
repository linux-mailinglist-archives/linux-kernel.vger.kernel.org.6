Return-Path: <linux-kernel+bounces-540427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3CBA4B07D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 09:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99A43B53C2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97581DDC1B;
	Sun,  2 Mar 2025 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lz9v8jlq"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E9B1DBB0C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740903621; cv=none; b=rOVqTUUAikJccQ4p4dY0NExXsl/5KpyLek9/aBhwRI/pHrDYd2DE6vHDb+mUVmaU/EyA2kFKGdqHzGGa4K1mdQUDPHDCesugWLI0u5wSxGyGzECQzLh19UZRTwPOVwhEQtyIb4QwbwC4zoKIXovzDRLYJ8ykHRsTtvqGenl/qPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740903621; c=relaxed/simple;
	bh=LqSAfv6sV6rOVtb/r74cZp8FOqhM2qtObtu/CEfkeyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXsNglkuoSoghGQL7nx3ypxQ1IX3zd7rt2Am1MPKmv8NDj5TSmg3CafLW6wYuq596WdgDuRzAi1Zj8g2Jphc6nCsoF8mvtYHcJ6fZo3ALX12HVogOTLjhXcmvURo5ItD1sSivF1QuQFc+xRO8X/GaGjo3c4GiCOShnUrOkAJw0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lz9v8jlq; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54965898051so129857e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 00:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740903617; x=1741508417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Fdu8h638dVfYIqAfQGe64knL8yNrxRQQc476mt3At4=;
        b=lz9v8jlqFKNLpkN3+3DeByaAdSD1jyd2FPKTdcgiXwyr/td5Sgfiu+pgMQZo001CMR
         4xuFB0sla7XaBVSc0OA8yW99b0yj5Ytkn5wQEZ4o/0mKODAh4o2Cri+f7t1V6qqaTotS
         cPAddTSpsEAczWifLh1bBOEUpUOCpQs7tAHPRyncflrLI2YPnAA9iBf7Kn/wuEZEkAXu
         EY16T3VONd12iHn5qOEZY3jPSRc5nwKG6X1w2FtWbYTtVuRsRRTzpV5dFM98si2CzI4u
         FhDJ816DeZLv7RvLMuNhxIPOejG1okjLyAvqWQ7qetLQGtz3hhqiwaCF/JVNfSLuFgxW
         Hh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740903617; x=1741508417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Fdu8h638dVfYIqAfQGe64knL8yNrxRQQc476mt3At4=;
        b=D62mHdFo6zKFfzb/55feDyBmuFEeJDbQiyOUXv/WjClBhl0R5jpS5tKxkglmmI6gmu
         RyLqLwjisLyKfl7VCzovdMxAHWDrnLPW25T5R6zfzjNwvMVEPjRk5ZkIZHl8GcwIlyQ0
         0kKnrm6n7XCZClcMms3zJcnNKF95Zb6SySpd1vQgOw2nQVDwFIDhvRcCE8jfGmX7qUsA
         eTAmPwbjGHl+bKd9f/haPzfwMlOoIhbayI1/n/k2ne6nX/a7hPBtCgecTs6HhzVTeVxB
         4cfY4DF4Q/jKffHiKfT3BIS4BV6NQzOXTbaboa8tkmoNVpbR7iItVTVb591sJWTrx9Ig
         pkHA==
X-Forwarded-Encrypted: i=1; AJvYcCX7GslOWEQVVzR2CFvRUyjrlkm8HEMcMcPG6OG0AccuLXrowJH8tNtowX6BcRuv1/SRrxJgYnF+fAlvEz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfRpGSgNm3nSVddcWekmMUK+dPwTkvFtYpsIjeNbPproeYbZ8y
	WazHQNi7vjNUJN46mt31x179aMcOqOIFM+k3t2V3rGiCAeUUX5MKHPmhp9udvM0=
X-Gm-Gg: ASbGncsmeJbXMh/BNiVh0qJTVw/jwRXimvyzkoS6F1UyqaaVXIRGfW9pcs6SRZuwYhX
	w+PUrFt7meUiu4QxAfWBVsfZcV/eAXgXM5j7RVfN6IGVIFI0VF8BMNuzPSvl1p8b6wGml37+B0P
	mxuXTarCESz/3POGA4yPupg5c9+ODjRk0Q/QWpD5UJi2eOwnxaouXpMXa1b1csBpIQPsgqEVpRY
	OF7Se8aOVv5am+qUbeQ7x4C6ZByYwaFruSM+qmBV3Vac7dbOR6GsCLlWj+PY/uMNBEa4EeKvCH9
	0rxWoHL2BOY2s2y1vsbYWSg5javEEBtNhX+haywFE92aagKC5kHaj7ekN4DhzNbSiR9gZp/7ZWE
	rNokm6FZ3qyVOOa9MRQ+4SZLW
X-Google-Smtp-Source: AGHT+IG6MwRyMAkP0lusijaUUwBA9N6GITEOtr/qCaV5/Ffw5je3hsGzZ5FfyJKo0ZYon/HXdKTf0Q==
X-Received: by 2002:a05:6512:3405:b0:545:746:f36a with SMTP id 2adb3069b0e04-5494c32fac4mr4044874e87.34.1740903617294;
        Sun, 02 Mar 2025 00:20:17 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495b8eb16asm317095e87.35.2025.03.02.00.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 00:20:15 -0800 (PST)
Date: Sun, 2 Mar 2025 10:20:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: sound: qcom,sm8250: add RB1 (QCM2290)
 soundcard
Message-ID: <l6itr3k7taiyiokaahcg2mwtaa5lynia4bimxridpsyymk5ml4@loii4h7lhjhz>
References: <20250302-rb1_hdmi_sound_first-v1-0-81a87ae1503c@linaro.org>
 <20250302-rb1_hdmi_sound_first-v1-2-81a87ae1503c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302-rb1_hdmi_sound_first-v1-2-81a87ae1503c@linaro.org>

On Sun, Mar 02, 2025 at 02:49:52AM +0000, Alexey Klimov wrote:
> Add soundcard compatible for the soundcard on QRB2210 RB1 platform,
> which at this point seems to be compatible with soundcard on
> QRB4210 RB2 platform.

Is it? The RB1 uses PM4125 for audio output, while RB2 uses WCD codec.

> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> index b9e33a7429b0c063dc5f5b806925cd541e546cf6..2493ed99268bf2ff8343020150c2c9aca4262514 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> @@ -21,6 +21,10 @@ properties:
>                - lenovo,yoga-c630-sndcard
>                - qcom,db845c-sndcard
>            - const: qcom,sdm845-sndcard
> +      - items:
> +          - enum:
> +              - qcom,qrb2210-rb1-sndcard
> +          - const: qcom,qrb4210-rb2-sndcard
>        - items:
>            - enum:
>                - qcom,sm8550-sndcard
> 
> -- 
> 2.47.2
> 

-- 
With best wishes
Dmitry

