Return-Path: <linux-kernel+bounces-441513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615AB9ECF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5038168BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C62246356;
	Wed, 11 Dec 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dfdnNB3z"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78957246340
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733930238; cv=none; b=oei9epZYFhl4HlMq3x4VOIsWdKHWrLI3ciZl5G6VvHqY3EbpDvTqUW0FZ1XXUw+75C+kztE7RbyJdKtjzWKz6Ew2UFtI8S18T7SaAKvBVqV9Bypg+P0v4z67AkHMlMKQAisJU2T/CpVGFZiFopGrr5pySO9+GQvCfwBXx46qgCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733930238; c=relaxed/simple;
	bh=dgj9faCqYqGCmdLBL99xPUxcjSu62deJACuD/zdilWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YenQ1U178BIJwAhIyHCSjynbZYlWWqj9wTFqgGyTOokfnc4Q00XL4Ir5hIEw2SHOr3GaECNqDLlb/uHZgGGIJLG6gB569R3IuEQeMB7H9dRRActLAaidLdnnkZZLnvZqJ4iiAemCs17qJKrUC3kojJkM/lIF2Ti1My4yO7MPeAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dfdnNB3z; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3862df95f92so3480255f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733930235; x=1734535035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pq/9/ykQt2mgUtsgGyizTWXxiGQlzsuGpXS0p7j6dlg=;
        b=dfdnNB3zvbi2YhQv15A+/fGnHQP93vRYOsf3jaTpa4SXm4O9WayRHXXxBgunbc7xKf
         E5vyvntmHowjQajV8ZDS0gxmUv95HdibJ6mML/LQpsEneq2UtrGwFG0aIcKWgd5BIRFb
         HNkzGZ22OPjW0p49hKIGyvtG+vCEd5Kp2DoxlYJ+LqBidWwcgepmWGRE917OSRtE17lW
         wrR8666H7WVkVCiDpx/6KgfSJzQQsKe0HdgeJTlydggO/snusEmJqc62/TxEmiU0mqze
         YqaSJPZ8yligTJzNe7F/eyyfsKknYH607XYaPRoUGJlRtE7F8FSs8o8OHb8ENbc5WuwD
         O29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733930235; x=1734535035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pq/9/ykQt2mgUtsgGyizTWXxiGQlzsuGpXS0p7j6dlg=;
        b=j5OVfK9H8kyiVCDgUUDrd2pKm23tNPBG7/gFopsWdKlWx94sTYcPYSF/f0hHoIgSZs
         rDIUT26jJynO0WQa2AHEoz88QwTVhiKNXp2oOaIJ4VKVGgX/D1/P/Hmmn9duGUTG1cn/
         ZBzDJoUEWsP4EMRjho4fqlzKVggEtlY+Ot4Ml1vw0F5PYDROQqfAbupaNcItZ7nT5ONj
         UuR34HCc5NEKaoM5whbJiUpEI01DrwjS1jXDH0M7a0oYqGZq1VsukawrvxcB2u066kdm
         K027C9zpQaUCbZTT5vyf1G1O1KDSMRD83IFTgadhX5Lil9lw+2KEiilbhtVd4pJpU4M3
         TgDA==
X-Forwarded-Encrypted: i=1; AJvYcCXLN4+sRxwDUunPdZ5tmhgjazRbuppX96CNfzNZ6O7b7UTuLbMvAHuZ3RUKl10Y5j0kSXvQgdAVbxZm3Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzSk80GenGcS/5+KGLafPr+8mzm9AspqfVvAy9W69wkfmEwjsl
	AB5zoZbOmZ9KsxeTgMgv25SWXCFvK4oLT2/2wb3vLzEvnNMA8SPz1bI/oub9N40=
X-Gm-Gg: ASbGncuwvw+6dkxcKIAzO9pLgl5BUvMIILGEzmo+fefh7MO7jz+2IA+IoAlyPeGPjbM
	sIpr1weOcGM5X02dk5ocREf0PFyTVpJyGfwgVcAj+2SMVUAEqR8tcYyXcZ6o7BCJPUsqARmd6jI
	DFHPR4NEv3Qv77Hwh4q2KEMaEEmoPaCS+l9fWg2Qsc2dR0THOLbE4jrho8ezJ+P97p2QjGAYnSX
	HmLvdrfGVopeMLIXeBXNCPyZqOZhTVpVqQSxxGiK31fhv9SP+skwZWACMZCx6cpL48=
X-Google-Smtp-Source: AGHT+IEt9zWV2LMhZsdWwndfOSZTj2c0JjzyKNLYN1YUNo5ne9QVKbZjRtTvm+taJQx35xtP4m34bQ==
X-Received: by 2002:a5d:47c9:0:b0:386:1ba1:37dc with SMTP id ffacd0b85a97d-3864cea39ebmr2355871f8f.47.1733930234776;
        Wed, 11 Dec 2024 07:17:14 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f8e1sm1502000f8f.18.2024.12.11.07.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 07:17:14 -0800 (PST)
Message-ID: <d8b73275-a52a-4cfb-91d7-948686d3a5f1@linaro.org>
Date: Wed, 11 Dec 2024 15:17:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] dt-bindings: media: camss: Add qcom,sm8550-camss
 binding
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, vladimir.zapolskiy@linaro.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com,
 Yongsheng Li <quic_yon@quicinc.com>
References: <20241211140738.3835588-1-quic_depengs@quicinc.com>
 <20241211140738.3835588-13-quic_depengs@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241211140738.3835588-13-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/2024 14:07, Depeng Shao wrote:
> +            interconnects = <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_CAMERA_CFG 0>,
> +                            <&mmss_noc MASTER_CAMNOC_HF 0 &mc_virt SLAVE_EBI1 0>,
> +                            <&mmss_noc MASTER_CAMNOC_ICP 0 &mc_virt SLAVE_EBI1 0>,
> +                            <&mmss_noc MASTER_CAMNOC_SF 0 &mc_virt SLAVE_EBI1 0>;

Have a look at 7280.

The parameters to the NOC should be named.

https://lore.kernel.org/all/20241206191900.2545069-2-quic_vikramsa@quicinc.com

---
bod

