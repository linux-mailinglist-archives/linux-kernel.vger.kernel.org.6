Return-Path: <linux-kernel+bounces-262065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF8293C043
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DA4282044
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE431991CA;
	Thu, 25 Jul 2024 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NAdTQYaj"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0366E1991B1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721904173; cv=none; b=nd9lRoP1mVSPv2vjN7xZ7SrBEN7uSsUNe/2QY2e7mBTRQi6WdHv0VdqK97ZCosswC0wrVFbEvdlbQKy9m/bHLU17beBb3Cw1Jngm/yjte8Y2BqzuGBV1TI45+k+XI5n7gdusiQ8lnzp022+ea65YldZIW+tzHITKQ2qoxTNKses=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721904173; c=relaxed/simple;
	bh=J3lIeUVMzKciFGpn3XO5YvbHmk8qNUMhRMFpZrd03Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQkon4M5dd4+OVkUgFlu8WF2ZkvOoW4oAptK2kW+sJaVLM0z5vtqSeJFa0GAvq/xeCiUHhsg5vl3eyj81+XgdwxPkGHBt6SAEy6x0VROAqVm2AhxGG1Zm/fZvk2Q4G9UCcwfrauttX77HM+pHIX009o08oabvsw+u1MwQwRTD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NAdTQYaj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7bcd0so983058a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 03:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721904170; x=1722508970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cPy08XzZmoGL8hzPtPNGeD/yGNQfo/0UcsrMmjVs8Ak=;
        b=NAdTQYajQ4V7V7kkG1vtyad9gE9RaX4arbeLNmmKUvZtl0bOG2h5K1hSkCkGt5an+H
         oD+DZwoNkBA0u6o6xsS3Q1VtMHSYU0QOYbJMsrk8waufBq4t5qLK+iR4qUcTQNV1OEPC
         Z57V5Q3GhuNLxWQCuYGEBqyKhUpIyjpqf8UP/zZDbDkeXywBPeqcGB/ueCw2dze9ponS
         yl398+MI+kUXH3GFRiVdBjM6HPtEAUUYef2X+L41elM6P9ndOCP39sArDQwHfFkgpWtZ
         k9n0iTVpFXrcC7r0E4Bo0Nk73WR7buYGlBnS0oqoo6tByS9lmw9D4TFHUx7999nDhUPF
         ZpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721904170; x=1722508970;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPy08XzZmoGL8hzPtPNGeD/yGNQfo/0UcsrMmjVs8Ak=;
        b=IYXGV7sqAdAyDN4RjEz7sCdqPgjFI8p1Rwhn2VguiyYUoSz37D9g3goH329wv2uF90
         NAtMgvDPqeNh5JYnlfYfDSGS4zilDn5aV6p5LufMhhdFWA2Cq4FUxkqxo+62qsgEeNG9
         ki6OXUdzmvpvP8+itCieaL/EFwtz7rq0lFBqwWfv9RWYEzJEthqOK7y9ciDeSHSNEe/c
         likpYez6qt2Kktj2AVE+6inWac9sfm8aztQZoOO4uSHC3nZn7xVqAylWTt0xe4KbSENI
         +PHldhfKaOoP19mBTtOc3rg4vGzLaB1cy61dNM9I+seW/MEDGaNU/LlmIG85i2F7X7zq
         JKrA==
X-Forwarded-Encrypted: i=1; AJvYcCW4Fo0/HcuPqq6oC620O/Foa8KGYhMRXm47Ev19dLfdQBqwDfQNVk/S+6eDqhdUEyIAGOdB1RHqFlR5d5gHtBCLMBjbO7YaiA8K6Hew
X-Gm-Message-State: AOJu0Yz1eFQ9OnTOSgClEivDTW8bAgNo2wfdaeASyI1/SOKSL0e2Bq+K
	zRTX0/GncD7eoC2DWkK4pMCg6CPMgxH25eJrUesCs3wgUpqLMmwGeurJXyb8avk=
X-Google-Smtp-Source: AGHT+IFjL0mEUBM9p25xe34AIWgcQoCp2d7Go8WtZKCIaQ5dGuRH52HRPCpmm0OLHIa191NKyCNKFA==
X-Received: by 2002:a50:d554:0:b0:5aa:32bb:161 with SMTP id 4fb4d7f45d1cf-5ac2ac8e773mr1324745a12.22.1721904170240;
        Thu, 25 Jul 2024 03:42:50 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac657836f9sm657144a12.90.2024.07.25.03.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 03:42:49 -0700 (PDT)
Message-ID: <e06c9a42-3630-4f36-9302-817aaa4fe000@linaro.org>
Date: Thu, 25 Jul 2024 12:42:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] arm64: dts: qcom: sm6115-pro1x: Enable MDSS and
 GPU
To: Dang Huynh <danct12@riseup.net>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240725-qx1050-feature-expansion-v2-0-5fac4bbd946f@riseup.net>
 <20240725-qx1050-feature-expansion-v2-6-5fac4bbd946f@riseup.net>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240725-qx1050-feature-expansion-v2-6-5fac4bbd946f@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.07.2024 3:42 AM, Dang Huynh wrote:
> Fxtec Pro1x uses the same display (BOE BF060Y8M-AJ0) as Pro1.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

