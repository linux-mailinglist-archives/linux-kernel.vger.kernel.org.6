Return-Path: <linux-kernel+bounces-200557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39A08FB1B2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798E3281CBC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED35145B13;
	Tue,  4 Jun 2024 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dueXGwna"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A991DFE1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502480; cv=none; b=KM5Akjnb/F5Arfr3e5RNLkbEwXCtkttK90kOFcJ3KzFNkDPtoM4d/uCszCHN4WZqX0oXNHBlHqeLSvtSTssIHHQiGENnkeFua357rwdxBU3GiCKQET7vEoRftfrRjzmT21VzQqmtrWV5XvRXUStBL1Xy8Zin4Xgs7j0bRXOfbO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502480; c=relaxed/simple;
	bh=aqnSFG+sYc0/RHxsrKrsG7o29UpbZ3oTecXD37lxYT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oS84uEiPOvi26n7aJ3N4PY3CYpdQoEbOt5dunEv0eRx9FVV1scQp/KHCJY09GN47uZkfKmFKszVt3JEGSOl5xttMzKmRMSpTi/0laTb8ncf1YiYXE6hNKadaGvijTgpeHFxVd+ErLhgc9g4kEmYjx+XezPLHUnooB+XokjnWs94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dueXGwna; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-579fa270e53so6132803a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717502477; x=1718107277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i3/Vuq7S2WG8oNel0jOUvOm+4hHdWaPfXg39TcdwYqA=;
        b=dueXGwna6qBV2UCgTKhhlwpXMjEn7Kx4IAGv/h6Wa+6DXaV1wTfmMhbrU2U+HBqe61
         mQLvGLh4PGVG+OaqSGGYdA2c2MTQD7aprsXh+hJqPzHPz2nMC5id8Ay/LNX+gxi+W9x3
         8AfXDE/IuHcq5X2HNq5rbAviu+qy2GMgv8+k9EUGbSzSN0odYl18NH8hIv0LOjTelThf
         wny8w2Whq5QFnkqPn+oL8hrb0zXaZ8HCed/r7YwFKb1gKPOHgkEdSspOzuk8B2SbHo+9
         y44o/E7Fm72iOvaE5N9CzTPXdzggC6Bx/1X623VuwgE2vTySKTROYfbMIvjhZOLYGrr1
         MrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717502477; x=1718107277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3/Vuq7S2WG8oNel0jOUvOm+4hHdWaPfXg39TcdwYqA=;
        b=ihrMkLR8fEBgqQZFKCiPKerr1TbUoxec8UakV8q855j6UqmsVFZ2DYNegK+FsCM93E
         udSIJ6ivjYe/JUy3NVP8JhdDzkhK//jSVqmTb3Js0a4JuMaFeSKUoiz7saLh+ap9xoqE
         TZoBwKnTsmxdB5DaN8cWVZLiF4OBAml2U0lvJRtnF7cL/DOpern+CJPQJBLrlNQDyWSE
         ZXoykijCVMSe2PvZ11zBuaV6ULIjJo++HZC8dbOjbOd7nanST/rVPydMUf5W3pZ9sntg
         B8c2AlMyvWVhSRa5TAd3mKARAu3Iw4jaX/r4IH/a1W/BIorIIX2Mfa2/cfFHAzXDbn1K
         9N3Q==
X-Forwarded-Encrypted: i=1; AJvYcCULWISQ0B9+DC6FR1y+muHzlNF6/B8H5FJRs1CpPTm74xk6e7wP660AoZGpW+ABHM4jo3kV6LSr9xNlH8WtQRobMtQjaxKIAdGISV7n
X-Gm-Message-State: AOJu0YwsaQI5seFspWwABQpiNuGVXVK9mvnYLMmjQbKmWghfUL3Ai5Zv
	yNzKKjSHKNyt8OkP2/5LfnvI7P4CJZ7jMERjoPxjuejVulaokgpmFlUtmuA65Yw=
X-Google-Smtp-Source: AGHT+IGzxD9Hi80rZQQwWRuOwlSpf9vOWUJP2t47hbgEFwS+tvPJIcBrnUEo5052eKF7zfgJR3kWAg==
X-Received: by 2002:a17:906:2f05:b0:a63:3e99:6565 with SMTP id a640c23a62f3a-a682022f671mr922154266b.23.1717502477281;
        Tue, 04 Jun 2024 05:01:17 -0700 (PDT)
Received: from ?IPV6:2a00:f41:909a:a11e:a035:2af2:8d85:1f72? ([2a00:f41:909a:a11e:a035:2af2:8d85:1f72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fbebec36sm338287166b.162.2024.06.04.05.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 05:01:16 -0700 (PDT)
Message-ID: <4c1d77e3-3fe7-4ee6-8872-3924a1b2ef9f@linaro.org>
Date: Tue, 4 Jun 2024 14:01:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: x1e80100: Disable the SMB2360 4th
 instance by default
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240603-x1e80100-dts-pmics-drop-4th-smb2360-from-crd-v2-1-fb63973cc07d@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240603-x1e80100-dts-pmics-drop-4th-smb2360-from-crd-v2-1-fb63973cc07d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/3/24 10:17, Abel Vesa wrote:
> The CRD board doesn't have the 4th SMB2360 PMIC populated while the QCP
> does. So enable it on QCP only. This fixes the warning for the missing
> PMIC on CRD as well.
> 
> Fixes: 2559e61e7ef4 ("arm64: dts: qcom: x1e80100-pmics: Add the missing PMICs")
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> Changes in v2:
> - Fetched all R-b and T-b tags

Almost..

gotta do it twice to make sure it's posted

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

