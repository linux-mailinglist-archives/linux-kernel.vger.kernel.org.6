Return-Path: <linux-kernel+bounces-441617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 315FA9ED0C0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC23B1885D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AB61DA116;
	Wed, 11 Dec 2024 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kon1QaTR"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9217F1442F2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933012; cv=none; b=YlZgwU/iOCIZAtwtMeNYOH/BVjTZYQTkQjrlSbYc8gG7TaTD01m46VaAjCWrouhXVwYWCXrcUxcy3aZijIPAEV4kmp0YPjgNWD9CtUvLw5cmUq3mVHKcUwWYLOeagpufWOAMVZUUSs2bcOPXEctQBbtO17XkPmWnwxX2QvjgsTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933012; c=relaxed/simple;
	bh=o9NBCAJibBE7Cg/Mwi3++Bxz6puXmkfI8Fuw1rijxM0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PxA9u3IVT8UL5uWkT+ZkD79MLoBZCk49bkf2ouAX1sbrOgshi9y9wSdFQjwfMaLbwt4YGsspXHsCOv1Z/owK7og9LMzSz86Ky2DEEzFiFS/1qOP5ByXoZPcAimvHDzUCb1vmE1jbbwtkw03V6sGZ0X9dAsiBuyUqXuaFdV74CKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kon1QaTR; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so8342995a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733933009; x=1734537809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i5RH8KE9lwCw2dJZrNysrG24xTalE49KqC5ZdyyDDKk=;
        b=Kon1QaTR8FkOLe3+OHyisYBVCt0EH4Pz7D1+l321yNMl3xNtYW7+x5CwJr0b+ODpTo
         h4F8dxub+IUHhjV6hA2AUsCbPRthA/+E+TgTrgBidw771bMWc3/qCfsHIorPsL+iZed/
         1hCsX8HP6xPk92XC69mdd99mNN1LUqxE5IRb9RT9/8kbZqZq970SYs3lV4Q3DsOXWiu3
         pysiGBEHjXoBwy9/rz4bLW1wN6ROhrUUGE2kGZXgn6IgVzU+ed0LKC74zij05gGz4q8w
         7wNqUPc/bfbgeR7NXSrAOR6CS/qa3+XPRyPC6LFG5vz6OfGAlvbnRq6gcki1umR1aOcP
         7wTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933009; x=1734537809;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5RH8KE9lwCw2dJZrNysrG24xTalE49KqC5ZdyyDDKk=;
        b=X4PZqsOP74C5iR3xx+RQTA4iF1kvZ4Juw+mN8s0g0j/fj7+BcmaMX7emeMFuzWXCt2
         E/ur2DfnfWSYGuOy+bIBgs6yl6UxbFlEzlZco61DDeZQM8eQ64HI9EXypiFXAAw295aa
         zR2X468k/tsvzMhfv0/nUWUlQfSU7NLQiWjtBcgDHO9Y7mTnRIP9FE57BUr5dq0eZeYR
         XJQv3uceEdwhip5IGz/Qvc5cd2tX+kL8C07TWc5xaEu0bMS4hAgthuIWcMu2L2RlXDzf
         peNG0hToLH0KCK8Cpa/z60YJ9zHRjO0ZMpoq/wGST8ioiOfCAi/7HXyyTrlLXeDbdAfm
         1gCw==
X-Forwarded-Encrypted: i=1; AJvYcCUqPxEXnEUMkdYiwJQ4gLQIG+Pb2uAssLx+s8Z6OhGm1kRrA7RbHCffi6L/qQAVRozC/ODfazUYpEzzD7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx60EsgYtntVoGeyWpYEnWQ/PecOz3O3KG0vEoEETmPezY56OQj
	6AVHx/30VMLpO7AaQCaBWFtE7jfAnFi2yzh4uv+8pKp8o0KA2zT1g9+cE7Ntwfg=
X-Gm-Gg: ASbGncuiqqQc+OkP/XtbGampjTUFRo9Z+KsJHNPa9ysCeodkx6ZKP1TqFVIJ+PEUakC
	2SooEouPcWxCleI03iu1+AUfohrjvZS6/NHaNaNSlFoYLT2ONTa2Tmre2v3OTHIHYVW3UExy1rj
	MCcPbz3L0SH2C3dg0Ltkpc3AmJr21yxyVt17eI76Ke2VrZ/98pOJnZ6QE21F3l53cyBxDVB5Cc6
	qa6BOKJgNNmFma4p64LeUrqvCzBYVEXwZeeVDzcuf4fnPUocR5VggoEO4EssxeVJQA=
X-Google-Smtp-Source: AGHT+IG2FdkJPT94HQEtRGwYWaBTAxIlJjHQeKSD0iBM++VhPK90sU5ykr6gyv375oO439qmFde18Q==
X-Received: by 2002:a17:907:7712:b0:aa6:87e8:1cff with SMTP id a640c23a62f3a-aa6b11b33d2mr276373966b.24.1733933007333;
        Wed, 11 Dec 2024 08:03:27 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6b473e496sm107680366b.99.2024.12.11.08.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 08:03:26 -0800 (PST)
Message-ID: <63828150-ef52-49c4-bc60-72c1f6bff202@linaro.org>
Date: Wed, 11 Dec 2024 16:03:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/16] media: qcom: camss: Add sm8550 support
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, vladimir.zapolskiy@linaro.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20241211140738.3835588-1-quic_depengs@quicinc.com>
 <12704563-f2d5-4e2b-a6ad-53b8ab5c5df8@linaro.org>
Content-Language: en-US
In-Reply-To: <12704563-f2d5-4e2b-a6ad-53b8ab5c5df8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/2024 15:36, Bryan O'Donoghue wrote:
> @Depeng.
> 
> Some of the patches at the top of the stack here - won't apply once 
> Vikram's 7280 patches are applied.
> 
> Could you please rebase your series with Vikram's patches applied and in 
> v7 send a link in your cover-letter to highlight the dependency.
> 
> You can get fixed up shared patches from my x1e tree here:
> 
> https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/arm-laptop/wip/ 
> x1e80100-6.13-rc1+camss?ref_type=heads
> 
> ---
> bod
> 

https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/arm-laptop/wip/x1e80100-6.13-rc2+camss?ref_type=heads

Same patches on rc2.

---
bod

