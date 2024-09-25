Return-Path: <linux-kernel+bounces-338506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6596F98596A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 13:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D34C2809A6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4920185944;
	Wed, 25 Sep 2024 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmEOuLKj"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6493781AB4
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264335; cv=none; b=d1YTp5t1HbbfJa59QJsi1cRHsGUD2qK64D+G8scFIknIj0P5LHXST9mCmpI94mlOUxZ0seqWreCNBoO/XyygVtte3vF8Qg7oMITbuiZmUKDo0gHQr1cwBOfkjWeWfNG5uNc6SE9Q8tm50UOn91i1joP8KeiIHABLcW1NxZqnYVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264335; c=relaxed/simple;
	bh=1BfSW1k2s89ANjhol/Tq5QpLPP0g2Ap5phFj+MvDrDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZrshq2jjR5N9B9DIsldurWOm5pbdK5qEUcf+Eh8a/OosZKP5XsFAAOxlW6BDeAp51ontubnXxVyLIZr6Qlh03pjMMk13XsveTSDFeh+dmX68teeWwqzMqckNF+1VWOjvVMvGdQu1ckhpt30W3rn+Cjz5elNUMMHIRBkxeToJcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kmEOuLKj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-378c2f1d0f2so286856f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727264332; x=1727869132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YGzXQfdx6jMkDDPKh4718c8clBiJg+SXA1LyuAAM8bg=;
        b=kmEOuLKjB0hLwO/J3VFWakHtbrMSl45ncvfXqJyp30Oh7K1mjfwltnPcAAYD3Zx1Tw
         uviyvnsmaXODNXvHglORHQABUk9FpFe+Gnvq3AyNQmXX0pSBHP5ADZX6Kn7uJ+rE1mFJ
         6PeZZ745YvSOsxsz4ZBu6NciMh1+A87unGaHV8E+ChV0lt9ho5SJd5BdgpC7e1cT/2eJ
         7j5Xwc7u9BYRNhlTo4s8cbvjNzU/oEBJqTUA24f6smeFmIJSxBjo9EzkIeuV9xIJ2dbV
         URErcjOTjetU/4DQf789rGbdF0VdgYKG3YmzZqEfzubM/ugAkyCRWCqbfz17YHlrtApB
         6D7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727264332; x=1727869132;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGzXQfdx6jMkDDPKh4718c8clBiJg+SXA1LyuAAM8bg=;
        b=OmLEoP7xdKeaSqhj1qLoe8PDhhF2nqtHT7H0giR5TFaLfMnJwW0PfO7PofUKb+fUE/
         y3asgkj3SWIjHQk4yDPargomcC7dDs7C/QypHQwyEO4R4MQXX4Y6WeS7SDalCtIHjhVI
         NT0hV071zAelK0toeGn9dadHQTEe9HZXzI34jy63SnA2c7Cp9NOZCCDL4Olmi2W1vojW
         iuwxJYnc8FmA5FV1FCDTIhwfhpMmPZSpsCxuV0WDeyTlRCEm7b9Ycn4ZRJ6wn+9C19Qc
         OVgI5FeswFvJVqgjLlQFHiD0Lbaf7LD6yPu5+zFpMBqY2q6HVmbDO2NdjMLFfHTcWjeL
         hMcA==
X-Forwarded-Encrypted: i=1; AJvYcCVuBJNIwTXxxk21owUV5CKvk4WNpJ9v3L5aGcMS2PWOlpTk0anl3akcph4gSPvTv1GXVU6OgN2JKaa3hdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6jiL8cyxkaxMqCQqv0HipPMEa2qAwvFPPr8Z8mPeNrFBCMEmR
	ykoyiNoI1Dsg7GUSrP1qAecSVpgVMvbj7FMUXb3AEpZ2tJtqycakeSWpTyFbImk=
X-Google-Smtp-Source: AGHT+IF8ilTMRnMEFGwtWeHpmENejLSAHVhLI12mcNmG3DSNM/gr5/4oi6oLAErUaSuoa3zIBsDxKA==
X-Received: by 2002:a5d:5888:0:b0:378:9560:330 with SMTP id ffacd0b85a97d-37cc24d0103mr732394f8f.13.1727264331419;
        Wed, 25 Sep 2024 04:38:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ccc5c12b3sm444596f8f.99.2024.09.25.04.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 04:38:50 -0700 (PDT)
Message-ID: <f932e29e-ba23-4793-8c91-74665d2791ef@linaro.org>
Date: Wed, 25 Sep 2024 13:38:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: defconfig: Enable Ftrace and STM configs
To: Mao Jinlong <quic_jinlmao@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bjorn Andersson <quic_bjorande@quicinc.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?B?J07DrWNvbGFzIEYgLiBSIC4gQSAuIFByYWRvJw==?=
 <nfraprado@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240924092033.2626-1-quic_jinlmao@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240924092033.2626-1-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/09/2024 11:20, Mao Jinlong wrote:
> To make software trace sources go through STM(System Trace Module),
> need to enable STP (System Trace Protocol) protocols and stm sources.
> Refer to Documentation/trace/stm.rst. Then software trace logs can be
> captured by STM over TMC sink path. We can enable software trace(Ftrace,
> console) logs along with HW trace of coresight component. The timestamp
> of software trace logs and hw traces will be in sync which helps to
> debug.

You must answer to "why", not "what".

> 
> Changes in v3:
> - update commit message.


Changelog goes after ---



Best regards,
Krzysztof


