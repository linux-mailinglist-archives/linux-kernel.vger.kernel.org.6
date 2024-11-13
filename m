Return-Path: <linux-kernel+bounces-407876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D192C9C76A6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AC81F22F28
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A281EF955;
	Wed, 13 Nov 2024 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="av6kxhkq"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB47167296
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511307; cv=none; b=CA1Hm7TxZTxm7SPE94B+aLCl08gZR7Ef2H3vVhTiZ92MJK/G9WHZzKj8d45h1dzEfyxJmSRJGGBd/dZc5pr3Hq1NzjYZl1387RwdHQuDcwKPwLiTxXID5GOgN4BvuqllJc4epdFzglRgSq/xm5lodWwXZysODHTD+y1KNKMUZwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511307; c=relaxed/simple;
	bh=4LiMDBZ2BaPjcm4lQLrzPw+4IHjcexyzPDS6D111VAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHHRdhL/zcrNgeXXWv9aeDvjVsGYGLV1dQOEyPYtHgVeiwOHCZZF4KRQn9cqJR/Os76QhpC2M8VxubxSRwudS5Fx0spEZOEV7y8JOC+vAM/bWLq/vh6IA0yKfgRMg2/UH4A2ltE/vXbLu5WW9wDck2f9FVYDN+JSt2HsOt55en8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=av6kxhkq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43159c9f617so56722995e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731511302; x=1732116102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLqCtJgmoEWkkcExSIoN42a3vq6u8JMDyejdpawvuLI=;
        b=av6kxhkquD5lNUzRIl2Q7dWCqz8TqW1Xk76y4g5PBwDlF88eseVChV8fSAf4PSJtCv
         VC9HBc+8Ts+QYOaw+FpRA/LLFkpcAP+9MtZUGUPfYwH3F9KZlPuSzWptcrE72iztK7MO
         smQIorFRn4vTKtKtaFa8nMCIu5njbW1U1HZ6oxoxZ6hrxCB+VHJrYOS/Z48QhsWuG8Q0
         ziLqD/kSQgeJ+T5RxibpCIyk2RZ0Cb2ei+M8ftHDbeme+VIrPWdBy569IZjxD3XktzG5
         noOIh0VF3DWjoyskH3yfXvOhRKl0tdeYlnjhtcCj3OZ7bZ7ueRf/ovZVdQaW3oFJUrv5
         8trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731511302; x=1732116102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLqCtJgmoEWkkcExSIoN42a3vq6u8JMDyejdpawvuLI=;
        b=E5FIyG0293FnTrnRQ3RXdQVjTOPv3KXv/FbGQvHCm9Cpa0xuNSc9vQfyjDzbfwNonn
         bni/HJ4JY1o5/FyeUOAxG7KRiklcJ39OC8YhIfwsv9s076tP1R6TT9ZjXzKIm3D4eKk7
         y+lvbCZyc7wzt2MyZafGFBalKJQ2S8BFTbWJBFkiKy0E6xikMHMCx9hwRrk5+yRndtQ6
         ZphFnm2z+x9c2DrNw8NgZvKKWV/0lp47ds2HZB/49yo7A3KXKBF2EI3ajROiSE4AkZQ3
         0DZkHu2llWB12CYN9tlQ1LkB2IyjPMIS5YSBzr8SGrWu/PKWuEcgKBP+Y83722tLaVmm
         9Hdw==
X-Forwarded-Encrypted: i=1; AJvYcCX9ucOd3c0i0ThGyQeZFyo8nD6mt6SdojC5vwAXmcrOsYVJetV+W1nUy9EJ9UGeoaj/jedq1tJwpJzg4IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLUGdz/Jq1tbyhjoKarRfKvS3YXtOk+pv0lYhf12FydVP+JRKM
	ypmrPMhm3cmU9TZ//x1anfVPMRY2RGIOb2cHeobheXOKb+6EXcW+T/Kchh52BMo=
X-Google-Smtp-Source: AGHT+IF0lRtjI2o7jj//l+xrcNOBKkeWPvh0yXKVaf2XDugcQj/I02Vc/Dy2jhxuVt1mr7E9yNfsxg==
X-Received: by 2002:a05:600c:4f4e:b0:430:5760:2fe with SMTP id 5b1f17b1804b1-432b75183d1mr175593615e9.22.1731511301811;
        Wed, 13 Nov 2024 07:21:41 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432d48bb442sm21749305e9.1.2024.11.13.07.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 07:21:41 -0800 (PST)
Message-ID: <3193901b-c006-4feb-af72-d8f74f2d6428@linaro.org>
Date: Wed, 13 Nov 2024 16:21:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/10] dt-bindings: thermal: tsens: Add MSM8937
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20241113-msm8917-v6-0-c348fb599fef@mainlining.org>
 <20241113-msm8917-v6-4-c348fb599fef@mainlining.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241113-msm8917-v6-4-c348fb599fef@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/11/2024 16:11, Barnabás Czémán wrote:
> Document the compatible string for tsens v1.4 block found in MSM8937.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---


Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

