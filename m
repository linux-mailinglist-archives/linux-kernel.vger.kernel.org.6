Return-Path: <linux-kernel+bounces-225651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CF5913347
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EB828501F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EB4155381;
	Sat, 22 Jun 2024 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOLihn5H"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B2D155353
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719054643; cv=none; b=UCP7H3zaXFemtVA6Ri4qEtQqMpsC9SJvbisysCexeLbM0IC3AHBoW9Q8IjklUzRxq8EYo+GJigtZC4Vc4NkOumPegpIzsVuKbsAQOeByjZ5an1knJqn8T6hmOXDP8aaIYqY7olW2cNBeChUCKi0qxmrhP3yQk7ko/tggug8xXqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719054643; c=relaxed/simple;
	bh=33t2+53znsyzLwt+Za4IlobN0ZG9pU4A3lqHnq/ojcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQECJVWs1u0V7F3ohf/C7SfH91CagPGA6o85Iqj6Jp9tzUkSSZXUh5R4M3usiZ6H8BxOFcsUUnQZ8qT0YY2Z72flOkqD3+i+cmzdHNe44hGmSdJ3+JWE5eboUITesFCYuibv9jkp66SkzqMza7hWTC9+EeZbWJ3v3ySCDew1GCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xOLihn5H; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6f8ebbd268so647441666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 04:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719054640; x=1719659440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iBZeZdfUAWpnWDhH3kUtvDr+DT4k3Dvr8whyjRJOFaE=;
        b=xOLihn5HyX9DvS5tLshiBxFFYiJVRY8sJMZRAgZ+jEakt9dXBXH+myIp5/nPhKP4HD
         o2hoxYjxiv6uXpZbhP3pICQvoCdWGmEvAM3kDiKQ6aItA2SP0CkgjcEBoc4+5Qqj7ET2
         LH+W9OGWokIAGrWMSidRTvnuuvBHAlfPUNoEhf+wQ3d4Km78xfBGzgBveqHMSiViVxwK
         0G/yfi0cP1y1aF1R00wdd6325QK1ub0pr/4f+vMvukQnaletP1yFGT3r0yIRHTH1dVNo
         l93cdx4hMKqWt40jjKFCptQg4HyP2x49OqRpxYr6BkrRAMhml55HKmfQ0foopEhTosXz
         WWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719054640; x=1719659440;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBZeZdfUAWpnWDhH3kUtvDr+DT4k3Dvr8whyjRJOFaE=;
        b=FOg5WlwakVZLiecGQOsRdjZwBtso7stsSRTdDHByMWLZJxpq75OtjhpgBShBBqTYYy
         ucXzefI60NWw0VlMYVGo6jZKOfgbxMsQ2GToD1o/SQ2m0ApkUThHmnt0LHG8X0bLLHrX
         16c9NnnNjCk0pSPTfH2hBXjma7HRkAkFyN6rHx+snjt/CIIylcdIlonxv5A2y5Gyq50v
         FL5yBc1sAyO4k/injrvalQjZAWNmxdZ/IqfzNJxOIAhmn4puDUhzUDP0XgO1bZju8dKo
         LcC8LlBaakH86qtvbIvXjzH2GXUKSMPzR9/TdZrhz8Mhfgh+641RIWxgjZ4bu3kAWyiK
         UT6g==
X-Forwarded-Encrypted: i=1; AJvYcCV6mkBA/vsnL2LEM3InLwoPEt/2M8m3SMTuXeVL5Pb+vqwaZkoRW1rZ09alsUl0q67siQUcjPRW079Sf9Ti13u1LJtb8CqAdvd7r7as
X-Gm-Message-State: AOJu0YwZVNI7QuxHTo8hGkQoZNIo46eymSGnICcamF/yIPT2JXs0oq3s
	sS9zNjEDGdOVI2RdPMOX1h41W0NVz46o/an9SkE2kaLFUE5ldvPXxjtPNqXgh8l5o4NnOqX4wEv
	KA4E=
X-Google-Smtp-Source: AGHT+IFc4K10XvEUFt442L4NeWoSGr4NiejUevDiqHJvU6cMnjOX60WCnHfV7UtbQJZAAGo/UxSrHg==
X-Received: by 2002:a17:907:c924:b0:a6f:1d4e:734f with SMTP id a640c23a62f3a-a7038608fddmr53171066b.36.1719054639493;
        Sat, 22 Jun 2024 04:10:39 -0700 (PDT)
Received: from [192.168.128.35] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf48b451sm183459666b.83.2024.06.22.04.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 04:10:39 -0700 (PDT)
Message-ID: <77c837c3-0d72-45e8-9f1a-bef43d7d4d51@linaro.org>
Date: Sat, 22 Jun 2024 13:10:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ARM: dts: qcom: Add Sony Xperia Z3 Compact
 smartphone
To: Valeriy Klimin <vdos63@gmail.com>,
 ~postmarketos/upstreaming <~postmarketos/upstreaming@lists.sr.ht>,
 phone-devel <phone-devel@vger.kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240621-sony-aries-v2-0-dddf10722522@gmail.com>
 <20240621-sony-aries-v2-2-dddf10722522@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240621-sony-aries-v2-2-dddf10722522@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.06.2024 4:26 PM, Valeriy Klimin wrote:
> Add the dts for the Z3 Compact. This is currently almost the same
> as the plain Z3 as they share almost the same hardware and
> nothing device-specific is currently supported.
> 
> Signed-off-by: Valeriy Klimin <vdos63@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

