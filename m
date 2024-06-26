Return-Path: <linux-kernel+bounces-231574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A716919A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 00:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22241B22AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036C3194094;
	Wed, 26 Jun 2024 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVsjVI6W"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D5D193079
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719439643; cv=none; b=HIl3toWGXuwQIo1HJp8jTRGJn4HDGtX0stojUMnhFKxmpjXdTdsN3fULAW1XBjO5E82m4L0l6l81J7vahlphUHOj+vsjxzZGIj5SJfx9QB0Z/b7uUrT0A283Pja1Q0c6cfKT2EE4ijAOmD77i/DE1v9XPJUIOsyWjlLrqRtM2VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719439643; c=relaxed/simple;
	bh=4U3VMUkALBqIEhx4v8cM5qE1xvtGw0tT5POUh/CfRgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjZL+4t6sVSlfqT1dhlygHPnYbQx/vAxrsV9U7jCUrh2p/KM/05TM3B4dPoEiq1DTyQXHorQwnetEsGe+4/vAlxcV+OYMupHzCJtq1RYB27WP6xELK3rIIhVGNt5Q/wBI9L313NmqFP/HHfTlBQm6SGqHeNmfA39A3o+2jt7CTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WVsjVI6W; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57d1782679fso1032326a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719439640; x=1720044440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yDXxqhHTPol9FiiLZTd7c4Xm/+nYe7cMrXn70uiUIys=;
        b=WVsjVI6WobIQ8NOFEjQ8fW0rFeeHtj+Jyi9bz+BMUqpU/1Pz0cfSyD03lBqKb2bgcs
         Mku5o/u0uItjpdrOuTnExYH/gfAXGof3egFZs3izFtfJSgX6djBulGOtMVwt8fPoLuC7
         Iy4wHzZ+Ma8eADbzeMU95sAc5/sVFgdODiZToO6cv3mnSxIUOEUVKbbeK4fc+O0/nOT4
         58tE5Aj/JWviQqpH+ABL30a19zPAs94jTZaIFVCD2hv1BqKroiWJxd7VF18LNr1Z9HzN
         oceSKarOmC+2hOqrcbTmRbtoBpW6wd38A7gG2+mRlgeCTus3sk/BSNDRxTjz/cRKCp7b
         X8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719439640; x=1720044440;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDXxqhHTPol9FiiLZTd7c4Xm/+nYe7cMrXn70uiUIys=;
        b=dYV29NgHbM0iiwiuTjU1hKIBTFDe8/lDBEqqXZuYY6AlLCSfwNkAA2S9rX17ZXrPck
         z/pdxUKTTt8jGsaHQuzth8APMPexd8x4tsrPBL5+9tid/8+skcfkQQ16XB/uNBXxZWjo
         VvNjp1pp86s3IGmBE8Bal1ybFzVESIF3PP6Fj+EmQmeT+KZrf0emJs6cAMcjmexnIF/Y
         70VsuCiFZI+Ha1EcjaYdPHYKuhPEZ+U9lzxNoDCyyVBX3ae/zgJuz1/typff2GQ97/a3
         ZzzuGnyl9Zokp5ZDsaTv5YPbLALNLZ9KOF4x5sHHlOZUR7CupECSFvW/SkWOATNOty43
         Q4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMZsC05lyYATuUWl+kyRh9C/BCxQ701683gDnPPPKx1bQJJD0WI4atxScoNCIKyznDyeNGzy59XGVrTQD6uwbeC1OGTjtfq+wSdxW5
X-Gm-Message-State: AOJu0YyRiZkX4i/4oLxsPkKmnr+MAWrgOlNSBTEaFek8Y7FeTFov1emi
	OPx8r753WBbMVh4+BCMYX/dKfU1DJGZM+Lvj2fI+abFJ+s6b2KeffMIZzj+X5j8U04hPPyqyrUg
	A77Y=
X-Google-Smtp-Source: AGHT+IEUcOjw5cIvesXJYkO6ZJ+0hOy8qhvOzq9IndigZu3dz7Wvg8DU6eCR/VhLUvXXBw3Ag9vaYg==
X-Received: by 2002:a50:fc15:0:b0:57d:55b5:3f3a with SMTP id 4fb4d7f45d1cf-57d55b53f8cmr7011278a12.37.1719439639745;
        Wed, 26 Jun 2024 15:07:19 -0700 (PDT)
Received: from [192.168.215.29] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d2781199sm33546a12.77.2024.06.26.15.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 15:07:19 -0700 (PDT)
Message-ID: <d0c4c119-2b82-47c0-b14e-45ee12a0af60@linaro.org>
Date: Thu, 27 Jun 2024 00:07:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: msm8916-lg-m216: Add initial device
 tree
To: Nikita Travkin <nikita@trvn.ru>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht,
 Cristian Cozzolino <cristian_ci@protonmail.com>
References: <20240623-msm8916-lg-initial-v1-0-6fbcf714d69b@trvn.ru>
 <20240623-msm8916-lg-initial-v1-2-6fbcf714d69b@trvn.ru>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240623-msm8916-lg-initial-v1-2-6fbcf714d69b@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.06.2024 11:26 AM, Nikita Travkin wrote:
> From: Cristian Cozzolino <cristian_ci@protonmail.com>
> 
> This commit adds initial support for the LG K10 smartphone.
> 
> Support for the following features is included:
> 
> - Serial
> - Keys
> - Battery and charger
> - Accelerometer, magnetometer
> - Touchscreen
> - Sound and modem
> - Haptic
> 
> Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
> [Nikita: Minor cleanup]
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---

That touchscreen binding could use some YAMLing 

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

