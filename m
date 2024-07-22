Return-Path: <linux-kernel+bounces-258657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3441C938B47
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C1C1F21943
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B821B977;
	Mon, 22 Jul 2024 08:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B10sHpes"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC031B969
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721637272; cv=none; b=hjwmzz2DbxAR36FY3aiokILdkhjhS/laoYDJi5xF/N0Ozb0SYrSJ0FobgxI8w5k9W3YMTIwN3JpA32+eaQlEiVH7jYyG7hOH68cgya1i1QSpp+cLuK3dDEydNsKLw4RsKCeeucKVpUcMr6WE3ziI6IzDC2633Cua+eXjxpLHFu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721637272; c=relaxed/simple;
	bh=2ZQbY9JQ/mfWvOl9roX047V57W+yN1yEPWglQv7eP4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGes+BAT0iHxQrMaplM6Js6GVrDU5YZF5gw9oejEgtXpTtbYzcsHISuv6BaZv2KPrjepXXPz8Q55Hwo2AYZajpy9C32gzWpx/bDmVzhl4BRyvzIPdozSRPEIH0wQYQQoPcHC3JCgHdnVaVxIzdWtATFUtrERqwrpB4FgxVNrptk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B10sHpes; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a1c49632deso3279423a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721637269; x=1722242069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V8oJn59jfbFYWMkKFeZmEbr4eRDvEbsoSMjPpgzRAZE=;
        b=B10sHpesdo7e9pYk+uGcAwVQbbhw32obggPxfGldcaObNVUZ9FyKOwUB5SZfea/E7U
         TXof9y35HIBGGV8lT/ZrYG3PZsXvqA19Sig9EEUaUrtT7wqhNrcT3AhEeqs6AWswLplV
         YBHanvZ2ZpoG0oVMPaLdSLdH4BMuhMrrHoRBVB1pjWhi48FdfG7V6uzYrozWcG2bPmFP
         wpytBueXA3k+zN/tQDdxi3mJzc1406s2r3/iz9jKZzYd0wAUa4XSZV7fGcTmPK2Lq3sZ
         9jWuBBCHWacFVhELKAy2TNkNIoKu90wudArOiNr1HTwPE7UmFOds+4VUuUCESHyOCVZQ
         QA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721637269; x=1722242069;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8oJn59jfbFYWMkKFeZmEbr4eRDvEbsoSMjPpgzRAZE=;
        b=XmQx3ujnDk+FBwZ6tPlxTLnRTKxlrzG4gN67I99lmwe9icVxOmkmwovKnvp4HbnE8Q
         YxFzAgjweo/xEoMZASBrhNeRklQL0S3oSfyof86/pVwIWUB2Bu1b989KteWci3M3OrQg
         9b5soys0nZfJZPYeUYTgGHsq2qbmDoQoMcgJVXa1ClFPF7+i1xlDa44O2xJxr6gwpX8G
         Um3kAzMaMIUUXggyoeMCCB/3w2lHCXWOo2onYMyLBRlkBuselL1EfjKOQFBSuZN0jdwU
         88RDe5R4y383aDpiAaD1vemLdg6CvRPGZLaq/sh4AnR2BLD4N6vOVld52JVEhS4x/+yN
         1ncQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHpikIuSZQHND66v2qV5X8oOqPx66Egr9AstKJvC97HeUv8SUp6YfQFAT27RcYaeX9MUGrB1Qq5FTvZ500ZgcZS4moUVxjTPC+Dbw9
X-Gm-Message-State: AOJu0YxCaXVFl3syRSA5x0oORHOx+KK3U3UjdgCqJoXc3oXEAnVaU/td
	YiipQBUTSiWO8e9VA17g9hKTP3uCaB4uxSiRCJHW1fT8ODBzqt7PiMX7+IQlLdY=
X-Google-Smtp-Source: AGHT+IHT9MlCmtyjtw/ADxA/5DUnr1VfXWCAnrCAFZt/PuGLEdgkJzmdT6El78jCPieJQ/vPQepA6g==
X-Received: by 2002:a50:a6ce:0:b0:5a1:bda1:3e23 with SMTP id 4fb4d7f45d1cf-5a477e833e7mr3712520a12.14.1721637269049;
        Mon, 22 Jul 2024 01:34:29 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30aaa2c93sm5751295a12.25.2024.07.22.01.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 01:34:28 -0700 (PDT)
Message-ID: <a4a39e3c-9104-4954-a91a-bff4efe96a2d@linaro.org>
Date: Mon, 22 Jul 2024 10:34:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] arm64: dts: qcom: sm6115-pro1x: Add Hall Switch and
 Camera Button
To: Dang Huynh <danct12@riseup.net>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240722-qx1050-feature-expansion-v1-0-c4d486435b96@riseup.net>
 <20240722-qx1050-feature-expansion-v1-1-c4d486435b96@riseup.net>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240722-qx1050-feature-expansion-v1-1-c4d486435b96@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.07.2024 9:10 AM, Dang Huynh wrote:
> The Pro1X has a flip keyboard and a single-state camera button.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
>  arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts | 33 +++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
> index 4a30024aa48f..5b7dd54be6b6 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
> @@ -34,9 +34,24 @@ framebuffer0: framebuffer@5c000000 {
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> -
> -		pinctrl-0 = <&vol_up_n>;
>  		pinctrl-names = "default";
> +		pinctrl-0 = <&hall_sensor_n>, <&key_camera_n>, <&vol_up_n>;

Please don't reorder these

looks good otherwise

Konrad

