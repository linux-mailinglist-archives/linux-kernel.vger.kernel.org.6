Return-Path: <linux-kernel+bounces-219640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D267390D702
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD40B35988
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535A7155A56;
	Tue, 18 Jun 2024 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VTRothG8"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F4F1553A0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721590; cv=none; b=QccE5gq5ouVCxcOKWl5IYHcLsWM95nxLLGbINuiLJcea4YOQLwGU6fWziiZuqAynxR+M+5BnWhQVy04QMoU3Czl27oW/hJM+uQ4j+Q5Euetb+TGq4ZGyvSGoyNFRl0ida79wU/dJEL62WRNTKDAHYSsWh3YHGgfGSCO1Wa33tss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721590; c=relaxed/simple;
	bh=LlbZznX9y6lL19O6CIWVKkviVlaTfPg4BWkTJswayts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSGrcCIrzw3adwQtY+uzMilYbtx+Vz0Rk+shspLmWfSCZHuoSjmmUcoC0ixJ2rsXJzWcu3c5bXOF9OvX8lwJ1KvbQc+cluZRU7T3w/aO6W1Up7Upv1MTkk7GAQfMl1LpsDRCoXHhCTjj7bPwPb7F2Q3DqPSv7YmBmzpJPAu/sbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VTRothG8; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso68757781fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718721587; x=1719326387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhNeJnFIpKcMB1xsWo5K5A6vNF/FKcCi+sTOJve9a1Y=;
        b=VTRothG8l3Fx9W2KoaJYhdLrzlT8IQIknXKAFvC5GvyefBb6fan4u1mpYQ7ZFUeWm2
         u03y0ZztbxDWn51g21GzqN/ItR5CCa6htPrxWwia0ey+/qGKvl9D0b8b/WHdSD4mLFYn
         IIeGUjXnzhqqBQos9aU5I/egJooteR3qe7lQKcPBGjDNHR3Kl/PvWeRpbgT/xoc8/7Dv
         FTVbURm6X9Kh/N0JbTqyac3Y8kk9M7NHmPf6YmXDczCNlgGnkyteSLwBIb8ExBY25OmA
         6p/tdByCAKnEDR4ztgqju8wq+YBxy56nw6Q0Otgg362u82T71tsVAo39p0uJxRBpMHs7
         La8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718721587; x=1719326387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhNeJnFIpKcMB1xsWo5K5A6vNF/FKcCi+sTOJve9a1Y=;
        b=ig00DWEnpelZ5ml6bO4T9QsS6ItaE0pqw1JkkTP16b4gMqXEzk6U8HezibfafzQiH1
         Q27ijz7aJWn9EvlInt7gaIEHLQXLvxyuNsk1KT9lRD/87tWNRxKuG0vaPmh2S8YXyeTS
         WHNvAAmDcuXX3Rk/Ahs0mnMJjdQMflcSrZqzwO4jt1M6/cc/YwcNfCBSesyIqyHNV2Tw
         tWcagVxJ7XEiUuceKawaIcDRg8kwaYSx5ALVKxRKlOGHXUZ3R734UstuU95Vs6whOBvr
         gmD/M3U+BJDYR2Q3XJCRptXOFxhSvHa1hSIhJ4pgWCesIrq9T53IJgbrETvx6f3ECnIx
         WgkA==
X-Forwarded-Encrypted: i=1; AJvYcCUneEglhngFL9fQ45B9Oes3Tck6RzNDo6OyAPhGC8JTasj70p+NRJEyZHm5qAGFsZXD3aJ6Ng4ky+2kOMapHPYn3rJS2n+oa6/3omxz
X-Gm-Message-State: AOJu0YyXPdh+3T1eUHuddZ3SIEIhut1ux5q2ib9NOOmzVsXwljx5YLxr
	oJvaTfLzfEJtixgIMpXoV1V08GJaodtuMQMvIYC4AeW3SeN6yToD5VrxIFXIrMY=
X-Google-Smtp-Source: AGHT+IEtUHXeRnHeDkSwwwTyi8cQv08pAIrgsIOFAWmu/k3nYB82ZVQbcr6BJrpdxbGGpPA4+n32aA==
X-Received: by 2002:a2e:9510:0:b0:2ec:eee:f19d with SMTP id 38308e7fff4ca-2ec3cfe89e8mr303011fa.37.1718721587363;
        Tue, 18 Jun 2024 07:39:47 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec0e600712sm15104691fa.88.2024.06.18.07.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 07:39:47 -0700 (PDT)
Message-ID: <a03d415c-02c8-4eeb-9e16-122e61d333f6@linaro.org>
Date: Tue, 18 Jun 2024 16:39:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: Disable pwmleds node
 where unused
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 cros-qcom-dts-watchers@chromium.org, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Clark <robdclark@chromium.org>,
 Douglas Anderson <dianders@chromium.org>, Stephen Boyd <swboyd@chromium.org>
Cc: kernel@collabora.com, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240614-sc7180-pwmleds-probe-v1-1-e2c3f1b42a43@collabora.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240614-sc7180-pwmleds-probe-v1-1-e2c3f1b42a43@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/14/24 22:59, Nícolas F. R. A. Prado wrote:
> Currently the keyboard backlight is described in the common
> sc7180-trogdor dtsi as an led node below a pwmleds node, and the led
> node is set to disabled. Only the boards that have a keyboard backlight
> enable it.
> 
> However, since the parent pwmleds node is still enabled everywhere, even
> on boards that don't have keyboard backlight it is probed and fails,
> resulting in an error:
> 
>    leds_pwm pwmleds: probe with driver leds_pwm failed with error -22
> 
> as well as a failure in the DT kselftest:
> 
>    not ok 45 /pwmleds
> 
> Fix this by controlling the status of the parent pwmleds node instead of
> the child led, based on the presence of keyboard backlight. This is what
> is done on sc7280 already.
> 
> While at it add a missing blank line before the child node to follow the
> coding style.
> 
> Fixes: 7ec3e67307f8 ("arm64: dts: qcom: sc7180-trogdor: add initial trogdor and lazor dt")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

