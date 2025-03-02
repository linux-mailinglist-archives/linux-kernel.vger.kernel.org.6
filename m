Return-Path: <linux-kernel+bounces-540428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E454CA4B080
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 09:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF59C3B54EA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1CDA944;
	Sun,  2 Mar 2025 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VlRRSIX1"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9A01D7984
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740903651; cv=none; b=G3n7sC1o80ZRnGSUuLO7rfgs1MI9I3RKmejjy2Z2eoKePN3dSG/d6fbJK0OQAXu90oM/AlEWG3917C38rsvfdbbZA8KvXPlamtDwNPSjqp2qkAtNOrXkRf+eS8N3lSe9pzijldUJYcJMrNFKEnlIatkwa71QJstYYNXkRfrHEsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740903651; c=relaxed/simple;
	bh=dDu98QeMjbKfxBR7tJUCWsuZcwKiTkC6WMI4ZnynukA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgrCVO8JL8kXuvlRPmDNFmJBaRzdmCgT/30p89Na9j7nUKWJ4WFjvtZH1NH9XYZhj9MWlzABdua1LAE9iOGlcDc6gXFJLCB23KkX8FbabstnsPHI+xdvtGKP2mLsZo8ff5GieuFdaQu5LCa/PZYNKCyifW5HJi+XwJkAa1HqqI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VlRRSIX1; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3061513d353so36215121fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 00:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740903648; x=1741508448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NfKdwYcU8DQiF6AXOruyp9oIUgOHdVpgmFqLr+oBxX8=;
        b=VlRRSIX1MmRT6tvkrkKsR0kUqGvXsBo0Eu/wUoCL0J3T9XyylYOK6SLbcAUhlSXKYo
         SA8OV1PUytzEsKGnjk/DHdoPjyXWq5++qWaz4dAG/5bf4eApWh96s8cg1DvNFOIYbJUh
         kulELKBTTnUV/YGc50Mmp2Vu7faUnvIGXj8OoYr0iTvdG9CwyoQazIloltTaJkFKUCPo
         zWND4F2h9nC9AXnSCGUErsvRIDiwqJWNyXU8gszJVKl/8cVGVGTbOfNgTdWlwLVXhwt8
         0bygA1BlJ4fX9CY7I1DaUfG2eGKU3F0pdt5XxuCIiaqb0h0VZkLHyETrVQksjVUfXoDn
         UarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740903648; x=1741508448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfKdwYcU8DQiF6AXOruyp9oIUgOHdVpgmFqLr+oBxX8=;
        b=q7XPp7jnt9UZlSDF1VnDoQ+xVTGt+sjiWsN/uT08sU5ZlWmw1WIJpd5wvAAeo1aetH
         xAey+cCIw8+TuzTwla2inlOG3u/YBlokR3b7zRQLCjl4vGy7MFUOzXdkABBbdofl0/1u
         XpRcQNgNtVq6i54VqIqwRZPTVYMIrMR/YZ/ZytImIIBHDRZdBveypYm1obAs4kJqlUkQ
         c0/My1zocK/oknzhU2Mug7XgvmdQJJPnCH2QMWI46XjnmGt8GRwhTc1Z3oD9ap0M+ayx
         X9zvLv8MrC+fQ/dHkCRdR5gPQNUw6QQvgcoGKEUenDdmDlazZLV8Y1he4nFXWFjkOCMD
         0zLg==
X-Forwarded-Encrypted: i=1; AJvYcCX22q4qoJtEawqQXBFaba+AqmWWbYlKoboFgQ/s2E1uNQTjbF4b2KACb53/bHcoZZ+5ZaYyuD1ZwTs1obw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLFeeATT7mXXQlvk49jPMPew8PHWbq+VJSRoQfmBlhVe3M5tpd
	oYTdLO/lUTLif3QLXazTu11XNL/H6rHZsoI8l87vJQAJoHdmVNo9KUshNPZXNxg=
X-Gm-Gg: ASbGncu0IqnCcf9z7VcFB6IRPQlghoavN9kJtzJUficRVjqd5YC+gr1jnqSGk8oy2jV
	ZTXwGmD26IDnFgEjWKNhlV/fdBU7T190ZAxyMUL9ZbOkQj9Zcw4TwRNc/RsmVyeC7vL8YFGUjt6
	GWnUgvQsWq3dVtvVhRbszaUu6LNA1IxVS+BlCrI1YvC/ysW0p73ezVplVB8lqliqZmVaeCAhiAf
	1iMVLpqr/yxDStpH0r7kUzAfKSXjxH/8CsyUnohamFCCePErISEgAjpxynUWHpSUn/a8eFK7dWJ
	4wn1kC+HJFr41ZDufiHHP7x28+J84KQZUBaXmMePw5qO6tyP8pY2W0x89mmhOznByt4FLjb7niO
	WP4VthI5/0CvPxhmG0Rj6Hy5b
X-Google-Smtp-Source: AGHT+IHg+KAzyy0IsIZM7j3wFAcOrBBOIer88JW2kHinXd24Lajckl9FIBe+oKIlI8/bfiroAOYlRQ==
X-Received: by 2002:a2e:bea7:0:b0:30b:b852:2f77 with SMTP id 38308e7fff4ca-30bb85235a4mr2172901fa.6.1740903648125;
        Sun, 02 Mar 2025 00:20:48 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b8de780a5sm8800941fa.4.2025.03.02.00.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 00:20:46 -0800 (PST)
Date: Sun, 2 Mar 2025 10:20:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 3/5] arm64: dts: qcom: qcm2290: add apr and its services
Message-ID: <zh2hpp73bzylw5aomljqs62k2tay5cmltvgczo7bi4flmvgd6h@g5hzcax2aqd7>
References: <20250302-rb1_hdmi_sound_first-v1-0-81a87ae1503c@linaro.org>
 <20250302-rb1_hdmi_sound_first-v1-3-81a87ae1503c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302-rb1_hdmi_sound_first-v1-3-81a87ae1503c@linaro.org>

On Sun, Mar 02, 2025 at 02:49:53AM +0000, Alexey Klimov wrote:
> Add apr (asynchronous packet router) node and its associated services

Nit: APR?

> required to enable audio on QRB2210 RB1 board.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi | 72 +++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> index f0746123e594d5ce5cc314c956eaca11556a9211..2c90047f7dd867580836284721c60ed5983f3f34 100644
> --- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> @@ -16,6 +16,8 @@
>  #include <dt-bindings/interconnect/qcom,qcm2290.h>
>  #include <dt-bindings/interconnect/qcom,rpm-icc.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/soc/qcom,apr.h>
> +#include <dt-bindings/sound/qcom,q6asm.h>
>  
>  / {
>  	interrupt-parent = <&intc>;

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

