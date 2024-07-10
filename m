Return-Path: <linux-kernel+bounces-247346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4789192CE48
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6AD31F24815
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329CD18FA14;
	Wed, 10 Jul 2024 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjcaJevg"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D771313777F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604232; cv=none; b=nG3SKxm++YKliW05PYa64E9Tj0S6iyUt8LpreaD8zl0NjiwwTALiL2GpZM53G6+oioi/8YTAFCtUdje4w6HD2JHyMUgVks1aSc3fgQ0bx6fgJQqC8DhVo8DbbEv/atszkkuGfkA3XZTtG6vP7cEvIBmP/3TjGcWbvIRsu2MdunU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604232; c=relaxed/simple;
	bh=8F2BZEtelH1YRhA6Wm+t9HzdIBcJwq9KxRLQvz5mRlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXQTBkb/96Wu+Ug7OdIAgS+fqHOOqYnXVc3zpfUCjbgbgVUX+KPJ8qfVd5+lfKR2SxjspZr3+vTvSjXKmfExU6RYQkb4sYNbVxaFsT3TgQ+lOWru7qQU9c02SX24VRG2izVy66VLjPvUqNuaKCg/W00YEibgZsqJSPFLkk1sPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jjcaJevg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3679f806223so339856f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 02:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720604229; x=1721209029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wqG1DgtHgtqvEXnRo9X5KIub1iOd484zwbLW/LaRBKk=;
        b=jjcaJevgdRJF343hGETTd5gfrCMOpfbz+6M9Qb74VvGUlp9WbybHUvNGyTJgTyQoyi
         BZAZ1uCWX2pNTaN8lBetaqYBQWjWVKW8VPzDPMHv4aoI4QSjiAHUcLL+FkFbxDOaWLSO
         BHObrQ1UH8Bx+KnJ9OdD27JXZ3dwVAZU7G2EccGvN7I6sS4Hmi1vTIgLtqEj1KK8mCpK
         IjvI+wUYwwlFjv3t3h5Yh+11rhLt/5PvWGgmK6rlzc1HWCK0EAyfN/Ac9F1N9ubhqc5t
         axKSgmViSrM5myfGbNXIxSlFsPZpBdG8m2HeP6ygKw7FvEorV7W7DPDUZpLtyzdEyiaN
         iI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720604229; x=1721209029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqG1DgtHgtqvEXnRo9X5KIub1iOd484zwbLW/LaRBKk=;
        b=bcvAUkzN7/ehZC3sTr4uKqMoRm/i8MbkR7ip5OR5x37ZUZ/1DuQW8/SCW+ms0OWnA+
         TuLJQX5YqozAI3cjyF0hCjb2HSTVxMpQ6tigkXxIo8/5/OgNRptErMZf02J07/LqyHAm
         YvQqBt3qRvMjD+rZyhdaBDfzzQNZPVkjaGBARUs9U/9KMwWRZYA7t0VQOz5IXozvHglr
         sULP1IEl9P/sbQ3Vig4DQxjkMUjSYb8B9wj7xIYazK13d4JuGBy+W1Q8XzsTsIUMnVVc
         uuF2lSS9YZyekF8c1SViQSCfcCdTs0DTAnNlguH4/RplWmFSIEElSDRi9pBFrLQYl2U3
         3hFw==
X-Forwarded-Encrypted: i=1; AJvYcCVu2AhHQuVCYYYvLKTE+WrbTuf0DVu2XE2ye5lipU7mktEmvIVLK+xZaIbXIso1wcdTK362tkNpYUHSBROmXmGNVWSOFKvmNu4TDY93
X-Gm-Message-State: AOJu0YxcC5TOvsRN5Il/2lLrcx0o2WPOeMZQW6UgEJICQV83MF6WZoXx
	N+waDQTSxxc61+UrOsC7ZGiOW7N0I5vOp1eSTuTgWr4ske1H+3V1pWJmzSXvv38=
X-Google-Smtp-Source: AGHT+IFAmsCV4oH91zKAd7jsHk7D1dhHBkbxQE+hkYJu7LpCPPsYKSAOfJDfcIyrxi1pbm7pbOdaaQ==
X-Received: by 2002:a5d:548b:0:b0:362:23d5:3928 with SMTP id ffacd0b85a97d-367d2b534c3mr4052608f8f.17.1720604229014;
        Wed, 10 Jul 2024 02:37:09 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab815sm4782884f8f.110.2024.07.10.02.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 02:37:08 -0700 (PDT)
Message-ID: <01f6c25a-5803-4986-b754-0a3661d435b0@linaro.org>
Date: Wed, 10 Jul 2024 10:37:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] dt-bindings: media: camss: Add qcom,sm8550-camss
 binding
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com,
 Yongsheng Li <quic_yon@quicinc.com>
References: <20240709160656.31146-1-quic_depengs@quicinc.com>
 <20240709160656.31146-8-quic_depengs@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240709160656.31146-8-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/07/2024 17:06, Depeng Shao wrote:
> Add bindings for qcom,sm8550-camss in order to support the camera
> subsystem for sm8550
> 
> Co-developed-by: Yongsheng Li <quic_yon@quicinc.com>
> Signed-off-by: Yongsheng Li <quic_yon@quicinc.com>
> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
> ---

Hey Depeng,

Thank you for your submission, looks good. I have a few comments below.

> +  clock-names:
> +    items:
> +      - const: cam_ahb_clk
> +      - const: cam_hf_axi
> +      - const: cam_sf_axi
> +      - const: camnoc_axi
> +      - const: camnoc_axi_src

These "_src" clocks are almost certainly not necessary. The CAMCC should 
have camnoc_axi_src as the parent clock of camnoc_axi, so you don't need 
ot list the "_src" clock.

Please go through this list in your yaml, dts and .c code and remove.

There may be an exception where a _src clock is required but my 
expectation is that all of those _src clocks can be removed.


> +  power-domains:
> +    items:
> +      - description: IFE0 GDSC - Image Front End, Global Distributed Switch Controller.
> +      - description: IFE1 GDSC - Image Front End, Global Distributed Switch Controller.
> +      - description: IFE2 GDSC - Image Front End, Global Distributed Switch Controller.
> +      - description: Titan GDSC - Titan ISP Block, Global Distributed Switch Controller.

Please name these power-domains in the next iteration of the series.

The dependency on the ordering of the power-domains is a bug which new 
SoC submissions won't be replicating.

https://lore.kernel.org/linux-arm-msm/fcdb072d-6099-4423-b4b5-21e9052b82cc@linaro.org/

> +
> +            interconnects =
> +                    <&gem_noc         MASTER_APPSS_PROC          0 &config_noc SLAVE_CAMERA_CFG  0>,
> +                    <&mmss_noc        MASTER_CAMNOC_HF           0 &mc_virt SLAVE_EBI1           0>,
> +                    <&mmss_noc        MASTER_CAMNOC_SF           0 &mc_virt SLAVE_EBI1           0>,
> +                    <&mmss_noc        MASTER_CAMNOC_ICP          0 &mc_virt SLAVE_EBI1           0>;

This tabbing looks weird, do none of the checking tools complain about it ?

See:
Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.yaml

---
bod

