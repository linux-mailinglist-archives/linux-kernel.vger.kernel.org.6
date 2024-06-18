Return-Path: <linux-kernel+bounces-219588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CEF90D505
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91F11C24B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603EB17D89D;
	Tue, 18 Jun 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFwAN5yY"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF426158A37
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719588; cv=none; b=eGK3WnCYWLhXedNeU8slBGW/6sAzZRuLtM31Q+ZqLc6fB68V/Gc/ZjqJcnhWK4I4lDU4XKPlfUYKN6Mi6M5xAiAN0IVNDsU4II80/xgU1jyyFlPoT2y/4DLrmxLNLkCLw+TgWBE7j7ttqRAQmx1yUOtfo8J0GuFfsgDOFcpCQe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719588; c=relaxed/simple;
	bh=7hLqheXnE9W0qWhH3a25KKsYl8gJBb+w+/flsviwYBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nugzj1RoHm28aH9C+tvgvDUamUGTTtk1f8S/GGOGI9cxCqxeqXpZskmFHLaVgpd6bWQL7ZT44NJcBONqsxr1ahv4BPzIwMM7fpwre/1LBvam3a6lHzN27q2ckVOqQ4sEDncA56OHLboORaUiYghoDM4szVOeAqu5AITva1+by/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EFwAN5yY; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so6802395e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718719585; x=1719324385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+So+e4AIxy5W1wf2KjSmogFgzVVYZd75IixT8YReE44=;
        b=EFwAN5yYyJhTYqquwCQFoT7FoTKSIPshDUzjKX4BBNQGHPQwu8fqpsmhU84T+SUjHI
         2X49vhwE3FdWzXbDxomKY8gIGb+V2xwAmF4JEufHZZgA4ykjQHkDGysZ1qCtDxlMfmHt
         F0Abn1IkxmIMik328Vl7ffH7Sh2FBwx+oa5y9nxY4hrjD87KvxUtmPGxnfVSXPFENPAY
         pPd5dS4la1Kfr+e7h8Qy4hvSeoeUXvCre9rUBidSbYkWWL4lJv/vGaytoHMKrT/HWbUH
         p+m1yTRvaWzMGc3d7CyPsy/VUu9KaEQ7BIYioKtXHGiP2ZPUCvtQdQbdMfDXYms6D1e9
         Cu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719585; x=1719324385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+So+e4AIxy5W1wf2KjSmogFgzVVYZd75IixT8YReE44=;
        b=Y5X7ZTLS//t958XcnmGZM317AlUwxZlNBCsRlu1+CnF4WuRgqmuWLAm8eSwoKnzr/s
         ErY4QLEPOa3r/7TapebdYxkodckFMxFLAP1Jr0p9w3wG9Hp/vrVSPBl/CRdaHptbO8hz
         oGseM0esJFyruanQZufKqXHv4qYcDLfGx3cfN7nh3buqd7CZgcWyaSJsC7CyY3uRYE/O
         /4ap5KmtJx+jvNFQ2mJayxFgj+im0JosQFvuE1vdUpk/D734JH7CfRu8++SSVc7CUxNv
         YwzltkGOgrPj9ajLHbirTycKCwMc1XLpJ6tC4JTDobThGVD+86nGpbqhjm14guo/BS7G
         +GpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5ggQqDPZs78+jsE53SOnJHNAfj/Pib1dH+z9HBicqRt/V8OqZDSe/b9XKOQnYnH6HV6XLqAdKsT4gE8IIJQUEv3TN6ZFEDbCnzGdl
X-Gm-Message-State: AOJu0YztY6s0hIgkuvHr2E7eeYAmBZXS1qr5s/aHXDQQc3Tsf0JU6xuI
	Vuy1t8WeKf592J+LTfCg5ZzXft7aEx30CK+eYa5fKafNJobXHDPUPsBBgn9YcNU=
X-Google-Smtp-Source: AGHT+IGY5kISvhIt6rGqgfv/SlC1aIqmQbwMlMYxf3oPhg19EaPl7J618YwZRjbodQ1Ardwyi8neOw==
X-Received: by 2002:ac2:44a2:0:b0:52c:a5cc:27e7 with SMTP id 2adb3069b0e04-52ca6e9dafcmr9013751e87.66.1718719584220;
        Tue, 18 Jun 2024 07:06:24 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287ad4fsm1536033e87.201.2024.06.18.07.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 07:06:23 -0700 (PDT)
Message-ID: <31921e1d-da7f-4846-9d69-4e27d61cb464@linaro.org>
Date: Tue, 18 Jun 2024 16:06:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/23] arm64: dts: qcom: starqltechn: remove wifi
To: Dzmitry Sankouski <dsankouski@gmail.com>,
 Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 phone-devel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
 <20240618-starqltechn_integration_upstream-v3-20-e3f6662017ac@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240618-starqltechn_integration_upstream-v3-20-e3f6662017ac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/24 15:59, Dzmitry Sankouski wrote:
> Starqltechn has broadcom chip for wifi, so sdm845 wifi part
> can be disabled.
> 
> Fixes: d711b22eee55 ("arm64: dts: qcom: starqltechn: add initial device tree for starqltechn")
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

