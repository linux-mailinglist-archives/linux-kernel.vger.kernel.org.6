Return-Path: <linux-kernel+bounces-226078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 245D69139EE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 13:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56AF71C20ACF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 11:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4F512FF9D;
	Sun, 23 Jun 2024 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYgGFcdh"
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5538464D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719141434; cv=none; b=VAOBAurqLOPUlkJU/KjLiSdBC+qMJWYqwWktcppSsHzbO+BK2/ZiPrr4zPZAwX3RUyHtklCoGm3DnsDQEccjQfolaRxGrBwsqoc8cuiIzmny++/SYUY/N/nMlcZJtljhZfx999Atuu6s2+AgSldVs9BiekuFPg69gE3g8FefgzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719141434; c=relaxed/simple;
	bh=TveO61+2iJeBP3GHqzB1IiVQDAe7GiLKVq2CCsJ05aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWc5NOWEG9xLCMJGlDbzJl5OvTA1PgEDngH6SO4COiLBQPyDK5wKKTLk1KyOz4Z76JibkiZ2ak7U6XcmmwzucF0QUtnbfrC8BxdU6iBB7L0uUwl3khct++vVmNjc6R/9XUQ+aTC/AmIgpPxFN5onPDnV/KUDyR8hSxvYF+90El8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wYgGFcdh; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-35f2c9e23d3so2735697f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 04:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719141431; x=1719746231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/uNYx9wbe1FVigGrWkz8ceaapK4umFwJkG/aUnu2ew=;
        b=wYgGFcdhBnpgmr+7Y82XhY7fJcMcYaWBIw3pDD1rHy7Emt1u6VHmifT7rfBN63dM/D
         dsyEgPB/Fn+z/n18Bev6aESs1nSVuIIp69f4t2NbBHr1udUgBbnWNpiiI/LChN4xi/v/
         9Dkm3BoCo+YKstf4HPzkOm6ifreNuWfwcQAnXY3s8T7iAzpmpmJmHXWkhtsdAXi8usq1
         0adDYhlKwI5xDOIGQUP18zWSp9+aNTHYE5qN4bcZkVA15170Iwuxg0dLGo/3IwIVNWAG
         50io+4PYHQgicSavdoRnwc6vWjeXI0WgMFFEp721cMgHgMYaJNQWcNbv74fUlomxyzqn
         sWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719141431; x=1719746231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/uNYx9wbe1FVigGrWkz8ceaapK4umFwJkG/aUnu2ew=;
        b=e3l6ZZaawkMjeIEdC1FjL6phUoLQvxj4Jn0iq1fvsP5nbe5eeXvaiCEC9Auz6kPt2c
         sAwFHd7tSIz1b0mb3plKf0BhJ7l8uFu9QXa728x+6jynwY723kLdAJvwIhPs64wjjxXG
         CTdU2nHuhfuH+ag49MtsdtO+0cC6v3J8YqS2Z4Nzf4YNCye47+H7jAV+P6xGidogEjoJ
         LRvfGaXJrC05ny3j8lAZ91xeI4N5zQdfm1B6PjUEl4c9+4sFV+deNJtpdERPhA2B3kKT
         Zc7vJrkqD5X4EiBaw7WfBKlMJGGLSUo/vR1trzXbiU0q0b8CPCVdNZpZGTSS3WxUUCDe
         rDzg==
X-Forwarded-Encrypted: i=1; AJvYcCVy8G6n6CCDRvb4t248THob81xXSnsxwCug2SkI7D0LO4u/hHNfPy0IWGDJxdvYJMqOJCWzgmha3TF/XnFjZwARfPJUW2aKyf2XUGdg
X-Gm-Message-State: AOJu0YycBdwgDi8um42VgT1cflvSpSlbgybSOjvD9J8g3kqSFrUHE6Lt
	FaJrGAjyAHxbikSPW98BvkgHNjooDZObSWk/3Dfepe19zofhomuQ5lOnWSpCg1E=
X-Google-Smtp-Source: AGHT+IEnfkf9A/OZy49Z4IWSRdfP/ZgKsbN5tn+lAqcp2I5TQtPFferklb1sn7FyT56zuDX0dt/E2Q==
X-Received: by 2002:a05:6000:1f8c:b0:360:727b:ab49 with SMTP id ffacd0b85a97d-366e36b0b77mr3050215f8f.22.1719141430585;
        Sun, 23 Jun 2024 04:17:10 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f6769sm7128327f8f.5.2024.06.23.04.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 04:17:10 -0700 (PDT)
Message-ID: <ef218f06-283a-4e7b-bafd-382c47248106@linaro.org>
Date: Sun, 23 Jun 2024 12:17:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] media: qcom: camss: csiphy-3ph: Add Gen2 v1.2.2
 two-phase MIPI CSI-2 DPHY init
To: george chan <gchan9527@gmail.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 Bjorn Andersson <andersson@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240621-b4-sc7180-camss-v1-0-14937929f30e@gmail.com>
 <20240621-b4-sc7180-camss-v1-3-14937929f30e@gmail.com>
 <cd9b5612-1160-4284-be7f-4efbcbbbe346@linaro.org>
 <b9deca88-8e1a-4017-a0fc-6a77672d684d@linaro.org>
 <CADgMGSs7owyvvvRTr4YvCdmMiJV86CjD5YLsJiBZZONDhfFisQ@mail.gmail.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CADgMGSs7owyvvvRTr4YvCdmMiJV86CjD5YLsJiBZZONDhfFisQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/06/2024 14:43, george chan wrote:
>     FWIW 1.2.2 seems to be the desired one: [1]
> 
>     Konrad
> 
>     [1]
>     https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/UC.UM.1.0.r1-02500-sa8155.0/arch/arm64/boot/dts/qcom/atoll-camera.dtsi#L22 <https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/blob/UC.UM.1.0.r1-02500-sa8155.0/arch/arm64/boot/dts/qcom/atoll-camera.dtsi#L22>
> 
> 
> Here is the log from sm7125 joyeuse phone, not sure if it helps or not.
> [  204.034767] qcom-camss acb3000.camss: CSIPHY 3PH HW Version = 0x01000000
> 
> I carefully looked into this csiphy_2ph_v1_2_2_reg of various trees, and 
> concluded below version:
> (1)atoll, sdm845[1]
> (2)surya[2], sa8155, factory-trogdor-13443.B-chromeos-5.4[3]
> 
> I was tempted to use (1)atoll one but it looked like (2) is newer. Is it 
> worthy to create CAMSS_7125 specially for SM7125. Please give me some 
> advice about it.

So, which have you tested with as verified and working ?

My assumption here is that this series has been tested and is proven to 
work.

Version 1.2.1 and version 1.2.2 don't indicate different versions of the 
init sequence but different versions of the PHY.

For example - the CSI decoder is "just" digital logic, the "source code" 
for the at logic can be "recompiled" for a different process node.

But the PHYs translate analogue signals into the digital domain and 
therefore will vary with different process nodes - 3nm v 4nm v 28nm.

So it is virtually impossible - or highly improbable that init sequence 
1.2.1 and init sequence 1.2.2 will work on the same piece of hardware.

So its not a question of choosing the newer version - only one version 
will work - the version that is specifically tuned to the PHY for the 
given process node and RTL version.

Err, so TL;DR you _have_ tested this and gotten data delivered to you in 
user-space - right ?

---
bod

