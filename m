Return-Path: <linux-kernel+bounces-423249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA65D9DA4F8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7272855B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D98A193438;
	Wed, 27 Nov 2024 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7qLS9Wd"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D10C13A888
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732700600; cv=none; b=R+uyzAYa56zLi5ookFivxnqcVkv5lffKi4WSBOMxP+/PL0zbY/mGBIJsqCkF+DQGyYBmLmXJokm5AURk0nS3X41cIiNhguu6udS8xEbaWuXwtSD4zC7X4q7utRQLzt76J2n3nbUWBz6nFQ5BgizgDXX1drAzNqttgqOZwfGk8Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732700600; c=relaxed/simple;
	bh=CmAthmj+0BJ8BpGKq01sKwjy0zefg5xANEMM1ENWhsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIxd1DhOMwgFOLBkMwzNl8WZNttfasmKXGhiw3vJaXB3ZrPdkx7vE/5pWcPBeWasnSgCxDThxau1uFZmrR63iLoBclh/e9nqrQ4RVGk3k5CZ6pIrox5aCFtI2rJfRC5/h0kfAo2LidVJdcgwtN94knInK/CYBd8VAfvOYbGQs4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b7qLS9Wd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a12d106dso2841055e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 01:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732700597; x=1733305397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/x4E8wiXQgWWhk51Xz0Izn5wXZBkvHxtPMjLjyfmt78=;
        b=b7qLS9Wdb+kvTawNcU1o0NDsevixVLNv+sPn4kRIrkpEAgPfTsQZ5JQ4cnaxhPW9Yq
         1X/7RYByirzv8NhU99dCrwoXWKP9PhgCybaYrfoy0ItgsdWyvQ0TT2YE9+QfzIjPMliN
         brFv2MVJQh9aSMBhTYA6QqDvq0r9OsKlYcQZYuxZ0SDb0NtOqfnQdTEkyPvgI8R+A5jX
         RNejMp0gUItAIL3Zm2pnychwBRg5MCEgrAHB/iXnEVEVzRzC0C+WSg0ZdsVipBHdDaMT
         VzlQ9b7vxhKrAT9rbMn070biYc6VpaaknJ/LwGrNWJnylLz85ps1q6QvyAwvpYOUioX3
         Y5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732700597; x=1733305397;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/x4E8wiXQgWWhk51Xz0Izn5wXZBkvHxtPMjLjyfmt78=;
        b=lifv75vVXVOOOA0qMkhsUOsZh5ig0WVxwwPnq0n0EeusEawLNdy69GYVHY/pu6fI41
         A93ghKdgftyd2PxmkmbiR4kqwVakC4f2Wu0kU+qDuiyQWFGMjUjyybPsiKTj7V52XoU9
         uVb26Odfxohyh5AGbcXVnQvgXNgVowsqglGu8S/jN0SafTO82y3/ATkjtpAOjFaxLYoO
         xDy0n3l4FQLvSXu1J8x5pM8x+7iMrnUYcqSUZRO0skg1A455M+S1BU9DaEbcvzjSPR4h
         9ijCbruaMGIi1guRCFKaVbG6LLeQLE6eghRRFEr8vFEEAwxo0nffC51p2uME1WrB6/2W
         JBuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG5qkwkdNwA7eAq02D7dYCEPGTTL7rX7n4zY/siR1ZlP/HO4FDO99ZYArgdJ+A+VDjh2Os8ZoKyKFD3tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfE3oj/3ym17effoBxKfMDem8TtDL6DMAkEdA2JIKyQqMMAPsg
	W53WsP+X5MGh2ElxO3YQuwjFFrlhnjbc+vrHGArKowifDxGd24DYe0UZ+Wd6pgs=
X-Gm-Gg: ASbGncubwXYKNMXumMznKr89WYOWclayzG0O7EiTSeOykFGO5Rg3NM1JTK4mNJM1bwc
	ij52C4ql44+3q0onfJd3sojiMdG0PHJvH+FV2A+vJ37jRZLjak/HmYAF/wekSoiqWJy6MZtqHhS
	HD8IX2TtJt2o0tn4srdoB4mQPl6bc6GjsDgvvXeN0aC+agzrI7BHQ4hBfKvjjy3lb1M5dzMvWDO
	RzNK1s3bV5iU65dDSGNt8w344AhBAX0rqbbikdNFu2TYTn7V2eEe+X0AHJMw3Rc/5w/
X-Google-Smtp-Source: AGHT+IGW2kHkktj3j2eNCDXupvHHC0vvQtDZBn0LOqQ61CYdq4dYyGvDLQUw9Ne9ho7ByaeTK8Dqvw==
X-Received: by 2002:a05:600c:4447:b0:434:a0cb:6d24 with SMTP id 5b1f17b1804b1-434a9dc0c14mr7514325e9.3.1732700597439;
        Wed, 27 Nov 2024 01:43:17 -0800 (PST)
Received: from [192.168.1.20] ([178.197.219.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d29fbsm15165425e9.29.2024.11.27.01.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 01:43:16 -0800 (PST)
Message-ID: <3637deb7-3f64-4fbd-b492-f4642478c647@linaro.org>
Date: Wed, 27 Nov 2024 10:43:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: add initial support for QCS8300
 DTSI
To: Jingyi Wang <quic_jingyw@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Cong Zhang <quic_congzhan@quicinc.com>
Cc: quic_tengfan@quicinc.com, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, quic_tingweiz@quicinc.com,
 Conor Dooley <conor+dt@kernel.org>, quic_aiquny@quicinc.com,
 Catalin Marinas <catalin.marinas@arm.com>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>, Xin Liu
 <quic_liuxin@quicinc.com>, Kyle Deng <quic_chunkaid@quicinc.com>,
 Tingguo Cheng <quic_tingguoc@quicinc.com>,
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
References: <20240925-qcs8300_initial_dtsi-v2-0-494c40fa2a42@quicinc.com>
 <20240925-qcs8300_initial_dtsi-v2-3-494c40fa2a42@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240925-qcs8300_initial_dtsi-v2-3-494c40fa2a42@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/09/2024 12:43, Jingyi Wang wrote:
> +			glink-edge {
> +				interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
> +							     IPCC_MPROC_SIGNAL_GLINK_QMP
> +							     IRQ_TYPE_EDGE_RISING>;
> +				mboxes = <&ipcc IPCC_CLIENT_CDSP
> +						IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +				label = "cdsp";
> +				qcom,remote-pid = <5>;
> +			};
> +		};
> +	};
> +
> +	arch_timer: timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
I feel disappointed that instead of reviewing the code while it is still
on the lists, you prefer the bug to be merged and then post a patch on
top of it.

Best regards,
Krzysztof

