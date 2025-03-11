Return-Path: <linux-kernel+bounces-555781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28102A5BCA9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A34A16C5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63B822B5AB;
	Tue, 11 Mar 2025 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="COiNW8d+"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E953221D59F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686563; cv=none; b=CaqrMB/hhWLo150NrRtbQ4xsd4tplFFrmgU8k614EakwdcD/hfabcC2J1Ohby2gTvVW32rR3U2Q05XrZ/HKgzpHmKTj7K4w9sc7SDiMk2v3wvtBD5ttVihymaQaoqCKDLBcSZKyVdaB+Sty5bfGPWGRzHXKBMJO3nIMxiZe3I1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686563; c=relaxed/simple;
	bh=KV6VloN+Q45Gc0+a2tH993aFZT/8shI0EYvvt/qm3II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W+Ptq+vcMPjGOBYq6ctJ3B65nuApyeBtftcdelcLO942WORTgh1I2zQRBHKfKtIIA0qoHL9OJiCwZRBG1Pp5s6bodTG4/PVj3RKnS7sr/DTmbkuvaqDsYy3H5L4SBWTTjxCkpJVYmj7TDRw5ikg80QN2HlR7KXIxEHhdQWC01us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=COiNW8d+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab78e6edb99so791008666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 02:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741686559; x=1742291359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GyMmo00MijQvv1nIo9XATusemS0AEgh5wL246DTX9fw=;
        b=COiNW8d+IXRt4v4+eisTKawSg90sP+OEg1cN5/f+/8AUJQk9G8sOLQV1+csuymsrj/
         tNCY6lIw8dUQS5xRt6PNRIJhq6b5vvzWsHjyjF6aoPCXsfNDfIRD9KGjqOACVK8mUkLQ
         6fkHRc9nAZyi8dWLhGkFGj4kBKT2XibMnb5HBBAwZqd8mx7eneFCS/EkGM3gbmu0fPPq
         C6uKTOD6umPUQ7izZnRME4jDTj4ubWmdISqTi8rwLAKzw3De3qpGdA8jh1I/iu/COtEB
         cSBw3f/CIhqPIUfO/aanG5qYO81D/UXH3UOmSiB2bOYrra5UU0FG4MzjS0Ezae3Zy3ai
         xp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741686559; x=1742291359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GyMmo00MijQvv1nIo9XATusemS0AEgh5wL246DTX9fw=;
        b=Md4FHc8zyH+AtCtENLdAkvNu4t3cyEKnj7WB0DAKT0kU3opGSFN0V8ZYu0gfKSn4bJ
         3b1gllR6FM6xDjUSvHvTKwz+DPeBl+h05eiMp/zdrr2Ox3k+l53twhSmTSbaesrNrHyr
         9zqVIc0up5h8L56tuCb9uQ0ENYwJmEPkbgSb7rDzpZPm6Eo+BH5ci/JF3XPWGQAL8o/d
         EJwCvkijnUOH2uTn7X4UlYNcV65NiBZj6UyJm+lOWP2mXFZsIyY8w1DC0oedVbE8EEJg
         y9CYEz7VbUrA3Rk3hfvKB9/NDvJNLepAaBG0Xk52+3NYjP3iZw73RoZPUnbMsBxqT7Al
         31eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC3jiDe3FgskotX4Eb1vzB3KRnsyayiKYnUWUxZewc7GAlX9K7s7wA6/3d9rbPPD/CKunj5C231DS4avs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy49IRR6m62lF09etycvZ1fNAYUCUxnA8LjswYz06/++pRkhCPY
	SKct3nvVaizzHK3MDNA88p0MX1c66ejD+vmqM2G2LhZwxiO/xi2Cwi7q5bgSdnA=
X-Gm-Gg: ASbGncvniUptEvcaltB2//UQdF1IUpq4tQcdKRNN2k2lCVXHaVXBoR57cMaw7MTDBlA
	5nqgyFFZRBPo7iCn4skgetJOK2Zki16SE//ohul2UY9FQ/N9ufPFd8BGYI2JS8rYsYOQCv1vxFb
	rzY/UXqy8pOqXUlNBXKQ8XoSh6/9BO/53LM8SqZHYRGZMaLpJBOrVCclypy9Qiqpa5DbEz7LVMA
	9YayMwEdGIsU4JNNlbVR2mU1fNut7zGB+pJ/2IA9ACG3FFasrGZUOqMmOGqOJfeGUkA+KAoIGE0
	hsM/QOEf6LATqj5unuvdFZSQRerMuYhr4p+tAuis6lJSbHuhEU2HidcgUNluOkoeBarErEyHWHD
	r1rSWNvwi4g==
X-Google-Smtp-Source: AGHT+IHSU9UltopReIg2YEjALsfLf8gnqE6qARMGrK0Hc/6wePY9JUwYhUJuhkZKJ1tEBgXuDF7aVQ==
X-Received: by 2002:a17:907:3d9e:b0:ac2:cae8:e153 with SMTP id a640c23a62f3a-ac2cae8e645mr70428566b.4.1741686559193;
        Tue, 11 Mar 2025 02:49:19 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23973af6fsm899839366b.100.2025.03.11.02.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 02:49:18 -0700 (PDT)
Message-ID: <46b6dbf4-0d2d-4165-8657-7bd8a1329d61@linaro.org>
Date: Tue, 11 Mar 2025 09:49:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] dt-bindings: clock: qcom,sm8450-videocc: Add MXC
 power domain
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20250306-videocc-pll-multi-pd-voting-v2-0-0cd00612bc0e@quicinc.com>
 <lpuuYz9cjRQ3qc_0ZqUQk6SgCgfQ-lSt77HDAxGxNN9oGAQqORCJR2-DVUNcGjyeCqn7QKuLsElBbNDRjGQ1IA==@protonmail.internalid>
 <20250306-videocc-pll-multi-pd-voting-v2-1-0cd00612bc0e@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250306-videocc-pll-multi-pd-voting-v2-1-0cd00612bc0e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2025 08:55, Jagadeesh Kona wrote:
> To configure the video PLLs and enable the video GDSCs on SM8450,
> SM8475, SM8550 and SM8650 platforms, the MXC rail must be ON along
> with MMCX. Therefore, update the videocc bindings to include
> the MXC power domain on these platforms.
> 
> Fixes: 1e910b2ba0ed ("dt-bindings: clock: qcom: Add SM8450 video clock controller")
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> index 62714fa54db82491a7a108f7f18a253d737f8d61..737efc4b46564c1e475b02873d2dc124329fb775 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> @@ -32,9 +32,11 @@ properties:
>         - description: Video AHB clock from GCC
> 
>     power-domains:
> -    maxItems: 1
>       description:
> -      MMCX power domain.
> +      Power domains required for the clock controller to operate
> +    items:
> +      - description: MMCX power domain
> +      - description: MXC power domain
> 
>     required-opps:
>       maxItems: 1
> @@ -72,7 +74,8 @@ examples:
>         reg = <0x0aaf0000 0x10000>;
>         clocks = <&rpmhcc RPMH_CXO_CLK>,
>                  <&gcc GCC_VIDEO_AHB_CLK>;
> -      power-domains = <&rpmhpd RPMHPD_MMCX>;
> +      power-domains = <&rpmhpd RPMHPD_MMCX>,
> +                      <&rpmhpd RPMHPD_MXC>;
>         required-opps = <&rpmhpd_opp_low_svs>;
>         #clock-cells = <1>;
>         #reset-cells = <1>;
> 
> --
> 2.34.1
> 
> 

The ordering of these patches is a bit weird with this binding first and 
then the rest of the bindings later.

Also switched my linux-arm-msm email recently so only got the first 
patch with my RB in my Linaro inbox.

Suggest as standard practice when you get review feedback to CC previous 
reviewers on all patches in subsequent series, especially if you are 
picking up an RB on one of those patches.

TL;DR please cc me on V3.

---
bod

