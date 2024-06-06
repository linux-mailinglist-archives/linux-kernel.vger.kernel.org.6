Return-Path: <linux-kernel+bounces-204119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C62B8FE46E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA6A2840E4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748FD194C88;
	Thu,  6 Jun 2024 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ThJVyJwX"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D9B13C673
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717670326; cv=none; b=VscGLFemcFw4J+3hsMzDqoCyE8hv1fDDESUTcfq2VF+/njHmu1WV6sG/jlEWYwqUh3fbHEbShaiu1tCIVBpLeFbc4UyYk9ybKpqsnS+p/xMf8eX2VHAeqzGTqYLNDNpAVW0238MGDVqN8hc78xhIGroJispWJA+K3rY65jh5yvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717670326; c=relaxed/simple;
	bh=avdIuF0V0C0iJkYjR7jtV7ubAqX+f6qQOGJkonzOpJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3GrAZl8slsiysmfKlE7zyYx7BiltVFpClfcp3/1xYZoSoAyquN0D9cZp3CHdvEf+VNxkEzEpxg+QEl5DYtwOmwAITUVS7z8VnrGhvMkZAqLxPiEliCsbZ/U3qUV/7OLSkOcArvYe15ZAlpExCQF6uutkE1xYE0dDfYFcCYW6LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ThJVyJwX; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a1fe6392eso923767a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 03:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717670323; x=1718275123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bq+ea6+Xyq0hd82zdQ8F39rdvv/mrNdoQoHk1nZdUt4=;
        b=ThJVyJwXY+UQim229/U1BcuIi3OkQHJUO+iRM0BzwQuxixpA63r0lAqZnmOHSRw4z8
         RdXj6WD4rrEXsY1Ki5UaDMJYs/erAFaEn7GIsd/Z5Fql7jjcCSQmieCLo2t8zz0aF2KC
         vdZbw3kQH4MByEPKVrOf2Obh1VF9gFC2lAqrqO36Gg+e5pzQwWDYo5qJNyhf34YIAuYC
         UJS+ZIHJ5wLq64k+J6il2gWlKD67N3g0t8tPx6mXL8Lh0TsYXogfnmn5DU2ejmQF6Pf8
         C4ylbqCPB1c4AVvHhEd4SPhAILpbWA2PFCpn402NffEkpuJm3MGkogJfq0tjGr0/KtHA
         ls/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717670323; x=1718275123;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq+ea6+Xyq0hd82zdQ8F39rdvv/mrNdoQoHk1nZdUt4=;
        b=T6PO9ZBIRGC8bsjn1/X6kBvAQNz+PgBNoWJhag7zeOY7g4ugzODzSt7g5ma9MKNV0K
         yVey2blEr9GuIE7/ow/OT9apUqJHS1l0zf5n6doPsjS9Xkc3Jpb5WIbo20V1Cx/ItOUB
         OWkQwsMWSgU0A6KknVHLH9A4D7W9se5MHeRmb8gbb3Yfg1yG/IO2iLf1jYKnZjFYT8lw
         bXzwAKN656a5i3Sw2DG+jU+cqsFNUNs38qW5GLndG4Y9T+Qvmurp0v/e/Tg2EvYCxtDx
         k7zeXSAQTEHCUmZOMXP9YOwdfhsjyE/5gA8BzhF3ZFci1ibtxkiTO30dC61zd1YAOevN
         wg1g==
X-Forwarded-Encrypted: i=1; AJvYcCWfyHkfwYu2jkX5iuACogScGByd7hGyUEhEawUqYjZrQHuF0w2fh1aG1bVk+n9AyDrUJJ9mGgVhc54zoqkI1ORyfzEFtx4WcMcQvOpS
X-Gm-Message-State: AOJu0Yyn7jBmyu2FRN42IqJSfQaRPrPgZpUVhBeY4sAUVpxl8NwUerje
	AQpC592XAE4yFgR1zlBc1KKXsDEMSvs2Oug6lbMO13tbbQwMGlTTIv2pVfhOFsk=
X-Google-Smtp-Source: AGHT+IGffyAJJEOu8Bve4fToXmECd6UGMQfM0mk1x8YtX2ObRb56733m1tjFzlXc3IvB2KF6yXr45w==
X-Received: by 2002:a17:906:2f92:b0:a5c:df6b:a9b5 with SMTP id a640c23a62f3a-a69a002e5e2mr338177266b.59.1717670323335;
        Thu, 06 Jun 2024 03:38:43 -0700 (PDT)
Received: from [192.168.128.139] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805c95adsm79261966b.49.2024.06.06.03.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 03:38:43 -0700 (PDT)
Message-ID: <2fa9d6e5-d301-4226-aef8-6d691cd392fa@linaro.org>
Date: Thu, 6 Jun 2024 12:38:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arch: arm64: dts: sm8650-hdk: add support for the
 Display Card overlay
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
References: <20240606-topic-sm8650-upstream-hdk-v5-1-5d878f3047e3@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240606-topic-sm8650-upstream-hdk-v5-1-5d878f3047e3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6.06.2024 10:16 AM, Neil Armstrong wrote:
> With the SM8650-HDK, a Display Card kit can be connected to provide
> a VTDR6130 display with Goodix Berlin Touch controller.
> 
> In order to route the DSI lanes to the connector for the Display
> Card kit, a switch must be changed on the board.
> 
> The HDMI nodes are disabled since the DSI lanes are shared with
> the DSI to HDMI transceiver.
> 
> Add support for this card as an overlay and apply it it at
> build-time to the sm8650-hdk dtb.
> 
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

[...]

> +

/* Disable HDMI bridge related nodes (mutually exclusive with the display card) */
> +&i2c6 {
> +	status = "disabled";
> +};
> +
> +&lt9611_1v2 {
> +	status = "disabled";
> +};
> +
> +&lt9611_3v3 {
> +	status = "disabled";
> +};
> +
> +&vreg_bob_3v3 {
> +	status = "disabled";
> +};
> +
> +&lt9611_codec {
> +	status = "disabled";
> +};
> +
> +&mdss_dsi0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	panel@0 {
> +		compatible = "visionox,vtdr6130";
> +		reg = <0>;
> +
> +		reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
> +
> +		vddio-supply = <&vreg_l12b_1p8>;
> +		vci-supply = <&vreg_l13b_3p0>;
> +		vdd-supply = <&vreg_l11b_1p2>;
> +
> +		pinctrl-0 = <&disp0_reset_n_active>, <&mdp_vsync>;
> +		pinctrl-1 = <&disp0_reset_n_suspend>, <&mdp_vsync>;
> +		pinctrl-names = "default", "sleep";
> +
> +		port {
> +			panel0_in: endpoint {
> +				remote-endpoint = <&mdss_dsi0_out>;
> +			};
> +		};
> +	};
> +
> +	/*
> +	 * DTC requires to have both endpoints when compiling the overlay
> +	 * and also requires the #address/size-cells + reg properties
> +	 */

[...]

> +	/* DTC requires the #address/size-cells to compile DTBO */

I think we can leave out such comments, if somebody tries to "clean it up",
dtc will scream

with that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

