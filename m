Return-Path: <linux-kernel+bounces-391848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D93B39B8C5B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE021F2239D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7585C61FF2;
	Fri,  1 Nov 2024 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQ68W6cf"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6AA15535B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730447448; cv=none; b=peVg81+i+7QsVn2hzzSW6PkHZjv94WtPueFFjy+eFFHM1IE3gs6dCRwW3b+bJe3z7B6jWhiJUCy/1R3SsGN0qHPh6GY8JuaSY+v6/5PvnCFXQlRMFDc/UN4jS1J6DA1Qs+xTdLe/6KGgX953ewroVWAFkYLmk45E+0N19Ik2VCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730447448; c=relaxed/simple;
	bh=IHPKXViuasdAnef90Ej3ekJWbONRaP9LTRdF74lt3ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWe0W1mT+voV2VbDBNnX2EvKUt8dut6uMW7iJDAW+nliCT74cYvfYbrBzYKpFY/Rzek4nvsmYJo5mnv4fjywrBFD/phV6SS/WFRkR1NTVNhdIMQN9RtPUvfUtGDkh7dQ1UytcEApSg3dqT8KZtRkEnnUm4DZZP/MlWy4jf+lqfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TQ68W6cf; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso26087351fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 00:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730447445; x=1731052245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hSsxsI/CZSnK3/q+aruvtqwxBEMmbI5p0pQaY2AQp0k=;
        b=TQ68W6cfuBeejEpWqv/nzx287zBaBURMdehFl0PJyZ57zeuNiYcGTYSOa40PWHTrcS
         7BbzRpqiA/kbWDopDwVftshdj/jVClAgY+ZYDSvd+Z0rZWUH2fIXQOK2Fuk0OeSs9Yfy
         0nBdbd/LN7fnXMX6/RrCO2giOOBfNOh1tb0JmhOQnFwOoch6Fmv/Ev3Vmrgpn2hsBVa7
         YEhIzvVoJPPSJUxUuR+p8JDqgNwH/KyfiRurAXhfQtRAipVEJJ5wpFeqyIMiSlr7H3oq
         GxJ3Ab4TCfjzI1cjQrikBzXx/E9Z4g1g7SQJryT3GmHM0VfHzgSVF7Y1s3Wf5aAtCG6O
         xEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730447445; x=1731052245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSsxsI/CZSnK3/q+aruvtqwxBEMmbI5p0pQaY2AQp0k=;
        b=o0HTlzUQC13GTshOI7ES+KRa3IO5O4u4IqQxhrhygqPUwQoFzNMZRiFvq5xIEFbYKT
         +D0h8hM238TLYjciMkE0wJcHu2DUYOzon1t3RGaXkhU1efiJbmTdw2Jc4Ch11+zxL8sq
         ChQRTQfcRKWEzpa3ZGJ/tB23pkH7MezZP5bHDMXaEN8KVGHqN+495siCTsshQNTS/vz+
         HQrMaO9dKTQp2WhKnNfyBfeC/eYfHqRT2OJbJyi9l7K5xPZZtIGhHta2vMmGkpaXVqcE
         KwbarqB4R/wBpjJYPwYN4GA5jYviCYRGeHXNgG/fTH1ClqHOqLbtIXsWJsDps8aooIn+
         ai0g==
X-Forwarded-Encrypted: i=1; AJvYcCV+JxGwILUJ2a44rVqwnkASx+dKlibOUagMmhM1FnovTmNw68HX8l5mjltKyIWcvrl6bZY1cISluDFdBlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKGWlkV+ASoOSIANJEotj6RtqXzSd9dnwgMRgDW357wGltu2/x
	Ha0CpZQRGrGp4ScV0v0ZMdLqLSfL36n297iydDwALuCDY9iOfco4fsuq9I2lKDQ=
X-Google-Smtp-Source: AGHT+IHAS25AvG/LpQk5ee1X6rpAdLY/HsFI+VOFJOIWGgnPbv+z9xuMoaPICWlErV+bSQ2bJdx9ew==
X-Received: by 2002:a05:651c:1148:b0:2fb:61c0:137 with SMTP id 38308e7fff4ca-2fedb82fc8fmr26609311fa.40.1730447444989;
        Fri, 01 Nov 2024 00:50:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8c3e76sm4872071fa.119.2024.11.01.00.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:50:43 -0700 (PDT)
Date: Fri, 1 Nov 2024 09:50:41 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: linux-sound@vger.kernel.org, srinivas.kandagatla@linaro.org, 
	broonie@kernel.org, lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org, perex@perex.cz, 
	tiwai@suse.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	krzysztof.kozlowski@linaro.org, caleb.connolly@linaro.org, linux-kernel@vger.kernel.org, 
	a39.skl@gmail.com
Subject: Re: [PATCH v4 3/5] arm64: dts: qcom: sm6115: add LPASS LPI pin
 controller
Message-ID: <ke6n7ljt4wzmugoxbuvoajfsdr2z7bwyl3f6l3cyoifgxk52r7@ls3pb6qwkejv>
References: <20241101005925.186696-1-alexey.klimov@linaro.org>
 <20241101005925.186696-4-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101005925.186696-4-alexey.klimov@linaro.org>

On Fri, Nov 01, 2024 at 12:59:23AM +0000, Alexey Klimov wrote:
> Add the Low Power Audio SubSystem Low Power Island (LPASS LPI) pin
> controller device node required for audio subsystem on Qualcomm
> QRB4210 RB2.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

