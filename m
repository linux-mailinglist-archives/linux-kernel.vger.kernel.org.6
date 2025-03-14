Return-Path: <linux-kernel+bounces-560976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A97A60BE4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C7918907CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BA41D86C6;
	Fri, 14 Mar 2025 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpEVmwjc"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175591A5B93
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941456; cv=none; b=Ecw/qX4iojRc1711fV4cHA928eNITTomA1MDH0OKefMDoJ2S82RUnkVNG5rNHcmNdnQfWzTAnJblGJM49LCXLFMBkKgk/HNtcHXRCj4MtaoqYwfJveRq3a4OwHG1uxKWdoRiMUXnJc8aVi/3dZB4D++Ef8i44zsycD1r0TwqgMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941456; c=relaxed/simple;
	bh=dk+ejBCS3NH9te+aXnCnqbhIl0UgK8PkFWM4qXXJ5TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/Z7B/G52qvM5K8/Jt/O6ERALBKR6Wtb3cK3Z9pEh6Pk4WAjwzcg0wAoOOGWOFJycEK0L+GAQQTl7/dn6+b0iaWxgvHFTcIZ7j61Hom6zO0+g7pj4fcCeVkRBljRRMnkprYCPl2F6gmAJVDS4oHmjifT1W0FdxJlICVHQGPpVlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UpEVmwjc; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaeec07b705so292694966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 01:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741941451; x=1742546251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tdW92HTTZmGzjR6ChSxqLyGpU5fNUkYFaVmkq1y4xX4=;
        b=UpEVmwjchAI6nFe3+Vz4Cydv+26qouM/cxZsaP3CA171bf+Di/cVfMWDk4e4QbU6Ed
         umOIE/IBkq6glc2lBrDbEqBlwGEblFZqYTBNsEfphtDFIZFMMRH9UsesKeEgdY6fgNQN
         uCfxvoOIoOghh0T8gUtGR5gt98T+ej+y/AHKNxn3SVvFv/l+UjnzuC72BNyZM7PUPdVc
         lvtRzRHu/zplQ0Cpt1fCKAyV9emZOXBcAJ8xxgiDfHyojo8pqeLk0ewMDYT+qWj0AGmO
         1BKyqtIBLlruMzaqr3STVFgcVIVBblGSFJoEUPng8C8VWp6KM2YCqlc/EhlkPDtB0klx
         56og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741941451; x=1742546251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdW92HTTZmGzjR6ChSxqLyGpU5fNUkYFaVmkq1y4xX4=;
        b=YqPm9NNi08gEb3RZffMbn4AJEBegpRaEZ27zQMa2STjzC/sjbBhXW3X7VFyRzQugfD
         qb/7p0F8IOjJCR8Ltabn8Thd4c8vYeuskwGULYjw8PqXptSJsBLj0qEHjqs8nOxbPHlA
         DSaVhXh5hNhgDhWe/Web9eBqmtGx8WdRefT8HmBGO1Vee9t9j0aRNrQk9hy5dFFl3P6P
         EhbEsq2WNB6G0aoj6LBwd1ejDCc/WrcvoR+BiN+AkGc4gxQdPWsB5xgj/0M4UU111TWE
         3881MFJM6eXcEXUCj952HUuHdCK+j/AL34srRzpQa3+NTdscgurM+rsq8KT6R4Piw638
         mmFA==
X-Forwarded-Encrypted: i=1; AJvYcCXaqp9/BgxvpV7BXvu3sF7rjOOWqtlGIthUv6rqtu2WCTnQL0tCgc+mV0hcG8EdArk0kp0etM02Be/iAXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaIUoH0SNxb1av6yEvgjGFdxByzZ6inWrTQb2R9jUJgVa9zcs8
	V43KdBtUYyLzjkmyZSZFUoPBu0yzxi7G5MNJkwMiYXV3qecbjzw58C6Zcy34neU=
X-Gm-Gg: ASbGncuqqeovSrbhrw7mHIASVKYkrMqkRRhw04+GMNre+OlA8RYe4TDLQto9rklwJM1
	1vGk1WY9IEOsIvMdlBor4c/69zOkr/OksoWREZ2k3v1VYpyVxIEnSdWcolKqrESIZID2xuD+4QZ
	CJ6MEDGkqRNTNFpbLEQYlM92gjF6u4LYgagXE13zUvdyLpjrh0xxGVKz35MEeWl3TBJAPz41EJb
	CYliagKdFKF4hSDVgXUDnV3hhOZPVDfK4xKqHoFxniFk8HgGOJloWB3qCWvKIFLVbY0pX58ownJ
	gmXBfnSs7O22ULN8G6xV/iuvBbl9cujEldas2UYwOCch1vwQuJWkkFyu+zl/IeuY/AxkD5Le4by
	M9u9eBeAjfc4OOYFFg+QZ+oPKWjWHjgJMHTlh9NXjL6oXq237xOz0a5AdnfyMskhMdiO7g8bKb4
	NvXfX38HkLRwMQv/Xnv9JWSWBxyHrxYWg=
X-Google-Smtp-Source: AGHT+IFUOlHrTuzko/qUKZDoHX5T+vqpZFWSBwlhEPozEDwkhttO5RnwU44O1wIX8uDl5bdWFAV2Vg==
X-Received: by 2002:a17:907:6ea9:b0:ac2:64eb:d4e8 with SMTP id a640c23a62f3a-ac32fa44234mr197432866b.0.1741941451312;
        Fri, 14 Mar 2025 01:37:31 -0700 (PDT)
Received: from ?IPV6:2001:1c06:2302:5600:7555:cca3:bbc4:648b? (2001-1c06-2302-5600-7555-cca3-bbc4-648b.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:7555:cca3:bbc4:648b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cfbb3sm194289566b.101.2025.03.14.01.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 01:37:30 -0700 (PDT)
Message-ID: <9089c8e7-d38e-4c36-9b97-0f4a3039a29b@linaro.org>
Date: Fri, 14 Mar 2025 08:37:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] dt-bindings: clock: qcom,x1e80100-camcc: Fix the
 list of required-opps
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
References: <20250313-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v5-0-846c9a6493a8@linaro.org>
 <20250313-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v5-1-846c9a6493a8@linaro.org>
 <20250314-nimble-exuberant-ermine-8ceb43@krzk-bin>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250314-nimble-exuberant-ermine-8ceb43@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/03/2025 07:51, Krzysztof Kozlowski wrote:
> On Thu, Mar 13, 2025 at 09:43:13PM +0000, Bryan O'Donoghue wrote:
>> From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
>>
>> The switch to multiple power domains implies that the required-opps
>> property shall be updated accordingly, a record in one property
>> corresponds to a record in another one.
>>
>> Fixes: 7ec95ff9abf4 ("dt-bindings: clock: move qcom,x1e80100-camcc to its own file")
>> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> I do not see improvements:
> 
> https://lore.kernel.org/all/20250305-little-frigatebird-of-calibration-244f79@krzk-bin/
> 
> I expect both comments to be addressed in the file.
> 
> Best regards,
> Krzysztof
> 

Pardon me,

I missed you had left additional comments.

I will fix this up.

---
bod

