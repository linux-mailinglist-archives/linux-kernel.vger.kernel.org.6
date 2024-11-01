Return-Path: <linux-kernel+bounces-392610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C55E9B9630
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA28A1F23670
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5492A14A09E;
	Fri,  1 Nov 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hV56xTkb"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13191A08C2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480579; cv=none; b=UbNtoGlhJtetgsQi5zC5SmSS1pDgws9KhJKLMO0A/hWdK1RTXw7xrq1FU68JVkgqxjJTCUaSyUbY5mZF4BL8fcP051rlVY96h4FEImL56Oqe5WqRKqyWWbQty7wmrPZDpl9PKIJuw8BDr4ozsmWcYzuARE854CX4A/taQ2xGX8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480579; c=relaxed/simple;
	bh=jz/1sTo7r/DlzfzZhPtdYBeVNJACI+uKBkG4JwZETCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYFeJJGAv/tCD72XpPblHpNmEkh1r5rE59393tcnwsQCHDOW0j6l4iR2uzVfPLsUnZpSFoPdrTrYFR4eguVvbouRbM7vubJi6UVMC1QEKaWOdbq6kzOsyTPlpJ0dDbDFHbDi9S7+F/n88lBWIeEY6phonQNTRKBtNAwFpyTcFnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hV56xTkb; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e59dadebso2643391e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 10:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730480576; x=1731085376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zYkXO/XDL3TpZ2crY0BjdWNlXjaLpkJj5MbF5rbI9xA=;
        b=hV56xTkb4S2JlTnDXaLwFYD4cc05YjNJLt9PCOrchpuj4LRzSGKFHrr2Qx/RDqk2ST
         nscWXa1lOi3/C8lpNMDluOxj0gvwehsq7KubRcXNHqz6Qb7XkUm5pkz6WFMWeU8jDxTQ
         /gYhAWaTkJ0Qr/pk/hJcNcIC8drkpxtbKRzYPSblbK8p5h+VlS/RX/rAStIkeItbxRfC
         /YsEIhL4ZUBWsjAK3eC2Aoo07oyUGPEKWvudBKmcrmLa2r/m2e42E1CPK/k93FruyEAZ
         ryO77FP8+/iY9WKo66Fll01XKNYcClHu+7yyASyBCZV5bNEgaCZXhPzxgL9BBf9q1/un
         zUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730480576; x=1731085376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zYkXO/XDL3TpZ2crY0BjdWNlXjaLpkJj5MbF5rbI9xA=;
        b=nsbQOCeukb+ufjedM1gkAzIdCAlYbaE2KQhYb2o3EJl1Rbc43G5JkrD99r6NgdEyfu
         o0s2OZ7HJW0O0Wy7fJmATFigxe/LJGzwHFJiWFLLtmhaT1t2v3gDPYEhFOAaaPQsSpbp
         M54ea1RYSvJk/DX9nBsMKB580ACN6VFNYtrtX+/SkvL/soLlhIY8LRSkNqUJJxAd0Ne9
         sSyZ7/LSYLTNC7Bikice+Wxa2cJKv1Zni6fYh1QAlW7+W6w1rsGxyoZDR0jDwnxMcGdF
         9hnYRDc4khcA8PtI3WzNIGCkkPG5uaZzxgdsNN+/4Z+skqByGOuFz9ZdNlWOrOx8KvHR
         WBgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbhTnvksSwUix70VhmLMFTj0FFIlS1hbgSYTbI61p7pci+xyFhjOqR7p4JM7c+ivVcj6AK5c62xZifUH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJJbuEFQSBV3EVRkkB4TVCL17WhnkLt3TfKrOOSrle+qRqeGHI
	8sr48dg1Cuqd+oQbSKEhVdTlxmxTOnB4XUk6uLTq0WsXK9fukYC3Zdek7F+ezwQ=
X-Google-Smtp-Source: AGHT+IE/Ua9zx43zJk4xmbucX85KVyWCVHqEWxwm+i9JWaukQssqyuDIKYu6mu5VP4JJgT1l9NVG3g==
X-Received: by 2002:a05:6512:1304:b0:53b:1f77:e95e with SMTP id 2adb3069b0e04-53b34c5f595mr11888025e87.44.1730480575428;
        Fri, 01 Nov 2024 10:02:55 -0700 (PDT)
Received: from [192.168.0.35] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6852c3sm67882345e9.38.2024.11.01.10.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 10:02:55 -0700 (PDT)
Message-ID: <c4479e37-4f61-42b5-b8f0-813c8a2532c7@linaro.org>
Date: Fri, 1 Nov 2024 17:02:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] media: qcom: camss: Add MSM8953 resources
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Vladimir Lypak <vladimir.lypak@gmail.com>
References: <20241101-camss-msm8953-v1-0-4012559fcbc2@mainlining.org>
 <20241101-camss-msm8953-v1-3-4012559fcbc2@mainlining.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241101-camss-msm8953-v1-3-4012559fcbc2@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/11/2024 13:47, Barnabás Czémán wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> This commit describes the hardware layout for the MSM8953/SDM450/SDM632
> for the following hardware blocks:
> 
> - 2 x VFE, 3 RDI per VFE
> - 3 x CSID
> - 3 x CSI PHY
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
resend @linaro

Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

