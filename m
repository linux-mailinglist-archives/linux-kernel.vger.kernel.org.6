Return-Path: <linux-kernel+bounces-347348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482AE98D182
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5118F1C213DE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7771C6F62;
	Wed,  2 Oct 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFo09IWJ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8219473
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865934; cv=none; b=bWFjmC6W0mNzUMI/QYruu7EIbkpTuZrcsyQcQGPTrRkq5unQrVbKZ/cbKxzr3otIr8P+1uR7ZN2m6D6pCmKqAh/fo0Z3H4rJGqE6tJJlfaJBzNaT4U1bn+bF5CE8Vey8EuImK6YBVXNLPqnWUDkDTFwr6wcAbZIbNnuuo3zaplQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865934; c=relaxed/simple;
	bh=1d2KzsVkqXtziSLOXDc++SyoRW5Ljg+YC5107un2FAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LutG0f+4l3kXkyu80Qhd4RqE+HG0UAxXIDg7ratWjuLmb4wR0HdXQ4L8onLZWLGyrAtK7OcfurfsGzxDuVHECeH30oLq2Diies8wlQ2At9JwjfXG5SPUIIPhh8ch0aLnGJOx5CZP29RyiUN//Q2IrLAWasAbADar6BI4lHrIQU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EFo09IWJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cddc969daso9639745e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 03:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727865931; x=1728470731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TbScqx1wbfWROScF0OI5QB5kRUpp4dEAwnalCu6GYn8=;
        b=EFo09IWJO7nqEbpvYtsw031Cv2AZbMEUevCI+CCtgvps8eS+qVQTygwH0Ba05cY9sP
         nMtlK37u/kT1uuWXLOH+DxLfkRzhTsF+pD306A+L7i4m1LXNhgiof2QDo4xh25bMh+yg
         vhvDsjQoKBip5pCpIv6y//xnG37qvyq19+9n1iwytQ16h/6kv2C0Xvc4u3BDmCjHZppE
         vOKKW9i0URGrmJFoW4qqaaQiNzs2yV/rDQvHJTXXtkTuM8eR6UCug6oF+Q8YidWuEPOf
         hSqfX9VT1bOSDk9McdU4tbuYB/LdyKozUYalgEpNKqO9NbCa2Lj/l0JA20q/cn7V9cBM
         IPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727865931; x=1728470731;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbScqx1wbfWROScF0OI5QB5kRUpp4dEAwnalCu6GYn8=;
        b=sw37oQdDWK/Cba8XnUCfIca0Qu85IYP0jZ4IdFbwVk+5V2IGvvCjbakKUKkkEU5j4x
         /IzVBj1tt+qWigEjg+FPCMFoxyi7e9EOJCwxinxl5+eyyiPxObVIxbG3d6FRsNqR2Gt3
         yH2fNVgWg6D8UONsxGKWCvWLoSTePzXhSKSykMTYjEphxgTM+ZYcilv14CPHGZvh8KPn
         sunEhd5zAOQI0eK0bQ210JuvwPANlr+Cjhzr7daAMO8z8hGnax57MdXrc1Jr+8xwKYn3
         3zuf675ODADSxJIYU+9bXOkfCd1ivoPf93cUwk461zEVFsAO2vJ/A1HrgWwcv+KKKgre
         kETw==
X-Forwarded-Encrypted: i=1; AJvYcCVKuXNJhxxoa75rfLLwhQcPF08FysXBa8n7Dwp7WX0aCnKo6EZYNOXYKOnKJy6jaJNrLA1PRDRv0txQ2Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTMqRkEmXSIvSZ9Ho7HaMBgtLI87NWuesDOvh36186vlcs1hbJ
	SuFoeXNKtn/aUW7ySGTGKzqTKKAxe8VFsgaPEKpUeurLXcCoGy7pDhRCtasT8ao=
X-Google-Smtp-Source: AGHT+IGJ1tABFbLghbIPFDj9JuTETHmx8HmGrNMud3Ad4/30E+E/5uxDzHGW/EQ0MKu6Os1+Hsx+Tw==
X-Received: by 2002:a05:600c:46d5:b0:42c:aeee:e605 with SMTP id 5b1f17b1804b1-42f77900752mr8881125e9.9.1727865930688;
        Wed, 02 Oct 2024 03:45:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79eac781sm15316815e9.12.2024.10.02.03.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 03:45:30 -0700 (PDT)
Message-ID: <92837696-97d3-453e-979d-7a2550c9e63c@linaro.org>
Date: Wed, 2 Oct 2024 12:45:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH] arm64: defconfig: Enable PCF857X GPIO expander
To: Wadim Egorov <w.egorov@phytec.de>, catalin.marinas@arm.com,
 will@kernel.org, quic_bjorande@quicinc.com, geert+renesas@glider.be,
 dmitry.baryshkov@linaro.org, shawnguo@kernel.org, neil.armstrong@linaro.org,
 arnd@arndb.de, m.szyprowski@samsung.com, nfraprado@collabora.com,
 u-kumar1@ti.com
Cc: upstream@lists.phytec.de, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240718095239.922641-1-w.egorov@phytec.de>
 <4238b46e-58eb-41b8-863c-2c66e823f594@phytec.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <4238b46e-58eb-41b8-863c-2c66e823f594@phytec.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/10/2024 12:32, Wadim Egorov wrote:
> 
> 
> Am 18.07.24 um 11:52 schrieb Wadim Egorov:
>> Enable the PCF857X GPIO expander which is equipped on
>> the PHYTEC phyBOARD-Lyra AM625.
>>
>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> 
> Is there something wrong with this change?

Nothing, looks good, but you did not Cc your SoC maintainer, so
maintainer is not even aware that there is something to pick up.

Best regards,
Krzysztof


