Return-Path: <linux-kernel+bounces-254087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA2B932E9C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6151C2204B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387F419EEAA;
	Tue, 16 Jul 2024 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VjQ9Ou7h"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79E41DFD1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721148549; cv=none; b=hpzFsUpNaMKpLUw666sXZvQ913N5tPQaRq5nCjRfA8r+R7Vnye+PNQOQg2O7iDf15gr2OwPI8KH+EsiqQfGf6Myvd7J/h9wIs0q6ntovc7UKQ3cp1da9U9A4tIgi0iZ9Fqx+5vjTIf3lcZcOm3cehIXlNhX2F3fj7IwD211HqfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721148549; c=relaxed/simple;
	bh=1SvrFrUwY0ssB2UFXaVjKnT3739nqui0AqyelNUF8f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjCmRGh0EzLYivZlACKQV2aJJH08U+osCZmh8/IGNYVo6e868+abVMJljDu2JzIcjjrnv4gyBnBC00OWNVIUayKIzFp3UWzIoGcjIVQGyUQTEqu5nchi2mZJsx/CxCBw5lf1orT/2PWymK0Ee19lquJhrcXmmYbm9iC5JPLp07Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VjQ9Ou7h; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ea952ce70so6115939e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721148546; x=1721753346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1S+7gwS1UwbWxt9zx0GhM0+f0sa2DWHmC5X67Dgdt8E=;
        b=VjQ9Ou7hERCrAzWoRPcRtrlBzM/qkKp91XviMfjTZGbSxrzB4sPqIj3zfcosLBYag/
         l9CZp+dZ3bsDmZnBju31s9RWd4jyPWuYoGqgRSTs8rRCmSQPDAuex/LmDvy4mZ2Joy/C
         zXMOEAFfkIkc1EuybntVFYijQDKHm5sJK6CufAh5nj7aXeqWtP12JRaECxom79z3VKVv
         epkxQ+Qv76KBYYBD5SzjoCyZDTkWlYBH14QVMc/gwFI8zChDcbKrIVnv2OYZEgNB9Qgs
         uTcERdC+0r4h4xnGxAoao3+/xXpsqHK2zqlH5NbpsVaBehI76u5+f7I0jAHwCmAmYBEa
         me1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721148546; x=1721753346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1S+7gwS1UwbWxt9zx0GhM0+f0sa2DWHmC5X67Dgdt8E=;
        b=H3T/mkVqmNXmvLrUkza/YtgbggP2crHfLVPg29tqpLY06LXm2Kx9eViACipmd7prlM
         W1nijrSCYdCR2nRfT0ST31FY0W/QpTEx6ZgpAaaMJF8PlP5piBanPT2b7Il7wTemw0a4
         IvmS9PsJwI9CNFdWwY8wZwDav0xW7kfVqSf/u77Of0TM+XUq11Yij4Zr5qefhjhMNM5d
         XH5gjFdOFgQtjwrBUu6qIiZjOUo2oseNEQN84Js0m2K6yjbG/BD3sZGZVRf97O9PWBgW
         zf+vUH9foSO+TUz01VFul9I1gd7Cu6wzW5Gf4NalD8RcD6VkKqsqPe+Bxhthd3J7dmVG
         QA4A==
X-Forwarded-Encrypted: i=1; AJvYcCUiYSr5vDPjZEmuuCo6PhgsG9xcBDkprjJcqouKVuEU0NghDHX6Qne9OSbH8KW9NpuoS5wyvONLzOIB8Bi0ln0iau6glwD1RzrG0ak1
X-Gm-Message-State: AOJu0YzN68F9L8vZHyt7rgwg7UMyJdL+0/3vczthj8Vp3yMFKYbS9jJ8
	sxqXQSSp33FUWc+tIsRAZ0d8JiTMLJL7c0i4M5M3mm3GBislgnWT1RR56XKgi2w=
X-Google-Smtp-Source: AGHT+IFfYwT3eFsB3BfCBMShxUS4iHT2qR8EKCoDrDdhlZUTVH1+b0uGU9S8rbJSVSVD0ci8YFztBg==
X-Received: by 2002:a05:6512:3d91:b0:52e:be0d:56dd with SMTP id 2adb3069b0e04-52edf03017fmr2122314e87.40.1721148545801;
        Tue, 16 Jul 2024 09:49:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed24e1f7csm1216331e87.48.2024.07.16.09.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 09:49:05 -0700 (PDT)
Date: Tue, 16 Jul 2024 19:49:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rayyan Ansari <rayyan.ansari@linaro.org>
Cc: devicetree@vger.kernel.org, Georgi Djakov <djakov@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Odelu Kukatla <quic_okukatla@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interconnect: qcom,rpmh: correct sm8150
 camnoc
Message-ID: <uvvczamt4vcl2tt4hjcmrc66rwrnd5fy5254lzshoeart6ytmm@3sqsbmqlojq5>
References: <20240716144738.109823-1-rayyan.ansari@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716144738.109823-1-rayyan.ansari@linaro.org>

On Tue, Jul 16, 2024 at 03:47:38PM GMT, Rayyan Ansari wrote:
> The sm8150 camnoc interconnect was mistakenly documented as
> "qcom,sm8150-camnoc-noc", for which there is no reference to in
> drivers or device tree.
> 
> Correct this to "qcom,sm8150-camnoc-virt".

Sadly enough, it's not a -virt, but a real -noc, but it's too late to
fix that.

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> index 9318b845ec35..0cb4f7154844 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> @@ -71,7 +71,7 @@ properties:
>        - qcom,sdx65-system-noc
>        - qcom,sm8150-aggre1-noc
>        - qcom,sm8150-aggre2-noc
> -      - qcom,sm8150-camnoc-noc
> +      - qcom,sm8150-camnoc-virt
>        - qcom,sm8150-compute-noc
>        - qcom,sm8150-config-noc
>        - qcom,sm8150-dc-noc
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

