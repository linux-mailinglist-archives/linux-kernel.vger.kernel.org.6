Return-Path: <linux-kernel+bounces-231279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0672918A20
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10AFCB24D09
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D76019004F;
	Wed, 26 Jun 2024 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6MHgkGn"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D501317E8EE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719423011; cv=none; b=J6HUNOpnSiJYg+LOwMbVhqmkDjgyeKUanIwhX9Ug/JE5pFvbTnlN61CWZtNvYWtO3JCu+bN6D+xQ1JYqWoRFhON8MGYtXzrEI9gvsL2wa1lX9exFS448S0XCioDGO3ZuOKaC8GSZE407wjOnHhh2RSbzUzvJSG3roQfxdljbJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719423011; c=relaxed/simple;
	bh=8sXyupVnGH4Qtqm8zwEM1lKR41kejqbIjZNf3OjwrB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TS+Fa325KIWBdJblzxYxDz9CS1M//lzN9ji8G0jR8AnuYoG7vLTgwpK2FPZtgFHYBCNLYm79L25/kmNWSIyFjFti9O5dar60rtpo0Z6ZGG6IGwLj07iLnjX/i4CPpI923FJRRw+BkHnEAuCdbGfc0Q/nhxTGEcRDjrCMaaeslN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g6MHgkGn; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a725a918edaso305866566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719423008; x=1720027808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WCgWzUpyWlRjMO4dTBVp6mnu22NxWEBxaahLaEKuteU=;
        b=g6MHgkGnhweEPh4jft8CD6H9/D9llSvCcPPg9wGkUrn2UY8ap0gUvd/tJiP/N9Sfx9
         CUvtU7t/0yLNay8NEJW7YV1I8MKTpDj6vC1xf4XuisMQuekiIHei9mG0pJXp1vzYDRwE
         5k+kHEYlVoF15BdM2zU+ktKXHPNkh/iEaapccW88LfQ+6jNa4cww5I9GzdFC2l63kg86
         igMEJ4qBSrVwjo3lg0a8ovkzeHOJ+z63qIMSmlq/TrULy7/khtmiz4u0KNIFWNpAkccQ
         H4hv66Fpx5aVyTxNT7FurwglznF96J/0Kl8+wodDkL+tommg479rlUjDlyNI7T3eDnuu
         7PAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719423008; x=1720027808;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCgWzUpyWlRjMO4dTBVp6mnu22NxWEBxaahLaEKuteU=;
        b=p/YozVAqPoFQ5tTxx10HOUM7WHIMDQZmaW03NsShFDvXYxg1Crj5FwLQihPpLbRGFS
         cA+3+axKPy90tTY/pHI203jjfyQzmTFtU+17e6+HJUO5K2Q3h/OTRGohTpXhiVsxauwv
         evbJ4TsXaUfxqpQZoOvSg/Gwr4EtiHe8O50N+e1JP0+kvjH+4TEIZT5UWCKGeGrnzo0s
         mwXW4p2WQqIUzkMHhEzmj/fTQBQPYRuiraecPtimXajFO+WApsvECVd0jNItqiYB3QmC
         fnBGOsagJRHgN5pKQDvFewhR/WCti88Cz6perDQerldFSJQhrvA2IAPnm8RNi53Ck1h2
         KRRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWULwE2+1M9H3svdG3ToLlryOoHO4tVzUQ26P2/PuF+L2lJ8a5qQFmhIlTXkIwyqrvXVWJwUaTvMgCCii1J8eREOIztLFHDy/Kxr9AE
X-Gm-Message-State: AOJu0YzNPzg6r/D4ZejAZlclMNxp75Mc17cx/LhArg/dL6AGE0Xxfg7f
	1Bq6AYlfBJzHtL1c5CslMRGvL8kZuU7Y6Gq9zmDD7QLPJv7NHhWkLcSM3CWoeBs=
X-Google-Smtp-Source: AGHT+IEPOdKJSLTaOk1Lz7Q6vRdgL/e1q63ekUHDJ6Nj4SBln6eqPEfJtlq8mZ3XKgraXpiS4DaqMQ==
X-Received: by 2002:a17:906:278d:b0:a72:4160:105 with SMTP id a640c23a62f3a-a7245c8094emr863873866b.61.1719423008060;
        Wed, 26 Jun 2024 10:30:08 -0700 (PDT)
Received: from [192.168.215.29] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a725a6f7217sm296313166b.69.2024.06.26.10.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 10:30:07 -0700 (PDT)
Message-ID: <fa0ad0eb-6f5e-47bf-b8b6-233521f84ad2@linaro.org>
Date: Wed, 26 Jun 2024 19:30:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: msm8916-lg-c50: add initial dts for
 LG Leon LTE
To: Nikita Travkin <nikita@trvn.ru>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht,
 Anton Bambura <jenneron@postmarketos.org>
References: <20240623-msm8916-lg-initial-v1-0-6fbcf714d69b@trvn.ru>
 <20240623-msm8916-lg-initial-v1-3-6fbcf714d69b@trvn.ru>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240623-msm8916-lg-initial-v1-3-6fbcf714d69b@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.06.2024 11:26 AM, Nikita Travkin wrote:
> From: Anton Bambura <jenneron@postmarketos.org>
> 
> Add initial device-tree for LG Leon LTE (lg-c50), currently supported
> features:
> - eMMC;
> - MicroSD;
> - usb in peripheral mode;
> - WiFi/BT;
> - vibration;
> - keys.
> 
> Signed-off-by: Anton Bambura <jenneron@postmarketos.org>
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

