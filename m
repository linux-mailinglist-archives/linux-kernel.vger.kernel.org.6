Return-Path: <linux-kernel+bounces-279539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA6C94BEB3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BB61C22350
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510AD18E03F;
	Thu,  8 Aug 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x/E+KQ7w"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2DE18E023
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124650; cv=none; b=MXPiy3cQ3gmGo098pbvVzFyucAQPj8GWR3zhhK0s60BznQbH8C1N0PcHv6/NCr5Ic+aW3+9JFinJDkZNtbQOi+x4hSAyPRaMa6MH1c8FB+Lkdx7YLZD10Lu5lgBP6vCl07z0agqiNunM+YjsQFyku8x5/c1DbB/ylpipQkcv4qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124650; c=relaxed/simple;
	bh=R7/BLh/7AgTftmRpxzhos6wh2yaWPPjP6+1XVFhcN3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1QUoaGhSz+MvnmelvQJYDMyVRVvyb9vn13pru3czsUWfvuB1UjleaIY5DEmxhsDho6VIrco/f7dZja6Ez+yXUtrTBYvdwJ3d9yf4xLuCgXUzoK0GenyOjquMHi7abtl66ALsMBFUnmF+58d8nljeKzE04m9PjPGp/j34jJbDls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x/E+KQ7w; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f183f4fa63so8485331fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723124647; x=1723729447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R7/BLh/7AgTftmRpxzhos6wh2yaWPPjP6+1XVFhcN3I=;
        b=x/E+KQ7wyRL2KJ+1CMPhCagmNPE12YdDh2DvBHADbFKufbDvehpWCiIKatFLzTpXei
         hrqlYu1lrE5j6LmcfXHknW0Z20ZzeZQB4eLezUX+DTYVmxT/X5uriUQ5S88eZ47lxkaC
         Noy1ugV9PT7xFVKc2ZtTqxe86kOfy6lA0iKSkgGIT3vT1sUI0WfGuJQ/UkTu2t/AAJAd
         4/TVDoa48Vm+zqoJHGca80UH4C0wML/tQvGJOAf0tIErAGau1oqGTPKmQAx9GQOVX9Z/
         8n0iHt39pzbIyvZ9jdhB3Fy5uO70bSy1xFFg3iYDFFdix+/k4fkE6GE2fzMmzqGSY0JW
         GIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723124647; x=1723729447;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7/BLh/7AgTftmRpxzhos6wh2yaWPPjP6+1XVFhcN3I=;
        b=HMA7uOuLxRAmBdpPAuyzd43xSGaYuRqGb8AIK5eEcSNA/YV6hEYowbBqAO0jH3kxhf
         KULJoIsZGnFoP45iYdbDk5MPf8ZpndrX2TVuw8KxSggZ4CuULeKAhIXTK51vFjFrag6F
         Ii5EYE2OxSIunbd30C3BHIww49foOFEimoi0PUK0thGTEyptVGuuh12ll2uhRnW62Fj4
         C74rhnNJRBhAzdd2xbdH8B7PK3EsR/U0dDaVmDLeYPJ5WyIako2Y5h2kDUyNSxVvf11R
         JaJX0JR+9Ok7FRPxHZ46hFux1LfXmmYlCGdWn7G8DsKKOEz4EKtFoIpbzQ34xiQ0OyLU
         rbpg==
X-Forwarded-Encrypted: i=1; AJvYcCXEtF+0JnT7pp6d0f7Cd3qvbLge8rUyDI/rQpFKQdlaVKT+NJabR8iX2518E0YE5seuT+EsohYBMPqFWKPZm2s5n/tlQVquIl5m49Ix
X-Gm-Message-State: AOJu0YzhB7GmT3RAhD6eosf5arL5zRxpr2i0jiXT9p90bJjGk5e2Ti1d
	b6xwJfAsbgCllPrIZYBmu6y++8JY6zLlx0Zp4fjP92Zd7y6VVuhETASL2FZ/6Sc=
X-Google-Smtp-Source: AGHT+IF1bqM/ENSyQ49Vxrn4iUGMS0ZtWbHAka03fObxFD2QtSz7p+m2mIvkQhkl5RberooJQ5RZ/w==
X-Received: by 2002:a2e:5159:0:b0:2ef:28f2:66ee with SMTP id 38308e7fff4ca-2f19e3ccc3amr4335031fa.21.1723124646622;
        Thu, 08 Aug 2024 06:44:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1ac61bsm22334221fa.30.2024.08.08.06.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 06:44:06 -0700 (PDT)
Message-ID: <ae828d2b-8288-48f8-8714-8b6de6ceee03@linaro.org>
Date: Thu, 8 Aug 2024 15:44:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] dt-bindings: media: s5p-mfc: Remove s5p-mfc.txt
 binding
To: Aakarsh Jain <aakarsh.jain@samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: m.szyprowski@samsung.com, hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-samsung-soc@vger.kernel.org, gost.dev@samsung.com,
 aswani.reddy@samsung.com, pankaj.dubey@samsung.com
References: <CGME20240808083027epcas5p153e64139a5e71448b1ea3f04af1df2bd@epcas5p1.samsung.com>
 <20240808081815.88711-1-aakarsh.jain@samsung.com>
 <4230387d-0413-4da8-b55a-ac708af05e34@linaro.org>
 <04fb01dae97b$52f88980$f8e99c80$@samsung.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <04fb01dae97b$52f88980$f8e99c80$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/08/2024 12:11, Aakarsh Jain wrote:
>>> Fixes: 538af6e5856b ("dt-bindings: media: s5p-mfc: convert bindings to
>>> json-schema")
>>> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
>>> changelog:
>>> v1->v2
>>> Add Fixes tag suggested by Krzysztof
>>> v2->v3
>>> Aligned Fixes tag in oneline and corrected commit message
>>> Link:
>>> https://patchwork.kernel.org/project/linux-media/patch/20240213045733.
>>> 63876-1-aakarsh.jain@samsung.com/
>>
>> Something got corrupted in your changelog.
>>
> I just realized that it would go as part of commit message.
> Do you want me to respin this patch or you will take care while applying?

Please send a new version. This won't be going through me.

Best regards,
Krzysztof


