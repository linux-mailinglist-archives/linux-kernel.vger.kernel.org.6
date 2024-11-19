Return-Path: <linux-kernel+bounces-414518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AE49D298F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9D9DB30EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DC91D079E;
	Tue, 19 Nov 2024 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PaF7dWVh"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E11CFED1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029177; cv=none; b=N21c8eLmVC7KPqYw025mU5mGDI8hegVojdyyGT4DAR+HAqtchHLcZBOVFj6rq3h0f2XL4ZFV7J3iYo71PKSq4Kscl341JwqUxyxr7WRrRy5FS16K/IBj2yzjTWI/aD+/2WqVKxpJ3ynEJDxHtkHdtLw5PW66Na1s8KDOtd6X+aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029177; c=relaxed/simple;
	bh=mrd+ef5omKk4kmj9QBZVm/PCvmTVB8GvlJMDSSFnMTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OclVpqtR/Cv0lfoa96c9F6h05J88hVjjIyUcbWDSjE7U/F4Gn0jDNPy+aEnSneUrqdyTcY0bhJySMZaQ9GiA71/v6huK+IVN/BVTvPdSAyOgHQSnhTV/EpyS8dI+3s7fgcMB2TbJYOvO/INf8xg8HKwaYtzXmrhOyINUh+FrWN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PaF7dWVh; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa1f73966a5so659586566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732029174; x=1732633974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1njkv7AEQYLprfmPF/SUU/CkkayzBBsZYgpz9cUBCwU=;
        b=PaF7dWVhRUDFt0DBKnN8OIYMtbFvQsDtEp1Kh0WGPRITJKksB6PsoYctE9OxF5IqEw
         6olRM22/oXj+GCo7ANZNieMX2jvLKs2COEo91TbI0GTx82RjgUd39etotXPZi6KnD3Wa
         I4rA9tili4UprJnKZsC9L/CKPFuGhMVVZJAZ3MB+Q6D5Uc/s63uqncYM4nt2WzRMyjDU
         CF9wqiG95KMrKe1z215sVh+DC/WXg6rB5G2KyaPy8klkv3QFGCTATmu/FsVAY7pqnHV6
         +OHEiKKWOeZIPJ/ERY/H04rEfTBESRmGROEX0AmjY1DHq67XjCz4DxO5XoSNwWfCqJHD
         gPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732029174; x=1732633974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1njkv7AEQYLprfmPF/SUU/CkkayzBBsZYgpz9cUBCwU=;
        b=B+lPs3krZglmATBl93CYYhjJdloYvbdANFzFW9HBUUYQW0t9+eQJMK8XV4K1EyrZl3
         klweQ/paUiApVzaxc2ybMSTrDN/oMB2y+ELa1uPmRHiYUVwi3bQKH8Cul1mXEHIF9ZrK
         GwA2H9XDmn8XeXbYZsHXGKvAKu3Vu9Ll3srPwRbLM1VsTnIKPz0czYIvOeMpeXK4sawV
         Ut27N6QxHqvLxrq4PMxqF7/ddQ95zq0Ep5TvSdmNksV4E4Sq2uvk1Lmt9BPNggZjsegy
         Io3MDCep3fgNbRp6rxale7Vr5toH7lkT5y5FiDFOKbEZflavc3+SKkboMbY6o3AgO4VD
         /pNA==
X-Forwarded-Encrypted: i=1; AJvYcCVl2HPyPGkXYdl+N+TYnW9Y99uDAhP2cKniOXhRMtXj935am3J1AEA84xuzoryzvLQOPDAtX1LdS1tkWCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyQNzE6FO7Njdcw3wc11xZ9IxIXTXXLJGQfT+c2htenEX2hdfs
	R9IFqk6ry3WQ/5p5U/3SEiRwfnw/vLayXR7ngVET3h1CqZHk7TA9ZIuJg9G+mqQ=
X-Google-Smtp-Source: AGHT+IHpPhEpx8FCZtw2jo+T5uqwAc8vudJk7VsZfwZwUsidD+p95qcWn6QPKWI6Rv/z0jxfWiKNDg==
X-Received: by 2002:a17:907:a0e:b0:a9a:3da9:6a02 with SMTP id a640c23a62f3a-aa483553f62mr1583241066b.60.1732029174122;
        Tue, 19 Nov 2024 07:12:54 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df779afsm658092866b.85.2024.11.19.07.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 07:12:53 -0800 (PST)
Message-ID: <6b7bcf86-9bc4-4608-9f2e-b14c17e558d8@linaro.org>
Date: Tue, 19 Nov 2024 15:12:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: clock: qcom: Add second power-domain to
 CAMCC
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Loic Poulain <loic.poulain@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Jagadeesh Kona <quic_jkona@quicinc.com>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-clk@vger.kernel.org
References: <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-0-54075d75f654@linaro.org>
 <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-3-54075d75f654@linaro.org>
 <91592bff-4042-49c4-b884-8113d0759a3c@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <91592bff-4042-49c4-b884-8113d0759a3c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/11/2024 14:47, Vladimir Zapolskiy wrote:
>> +    maxItems: 2
>>       description:
>> -      A phandle and PM domain specifier for the MMCX power domain.
>> +      A phandle and PM domain specifier for the MMCX or MCX power 
>> domains.
> 
> It's a list of two phandles, not a one or another one. Can you please

Its two for x1e80100 or one for sm8450.

I'll find a way to express this more clearly.

---
bod

