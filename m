Return-Path: <linux-kernel+bounces-259865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE08939E6E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0752B1F22C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC14614D70C;
	Tue, 23 Jul 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxq0V/VJ"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6FF13D518
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721728830; cv=none; b=r3yViqwt84ApcKPK97sqnuB6c48geJQchZaiRpsqg7VqomwTwgfr5vDWZUqjml/DZXacYCyeuy2ae6mCnZxWh0h6w0r4JU3PkWr3lUKljuBOWS5URDRP1eRnscu6MTFoUs9b0OvTs8Ub5EZDrecpVU3m2+oeZ/tcK/EelAv09UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721728830; c=relaxed/simple;
	bh=o0+hQh7jEe5ffI6mHetdk9uJCG3LuW576cSpmxKAX8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VwqiTuDzZH/VuId9hiBf+4G13NffuHf2PfN0vGtmaZerusSaiXjYVdfRM2upupfwZw9JnhZ0np0sS4tTpx0w/mTXFXEAJiOoRFRwrbf+Q4bvxGVhEIXfSfAaF8ACG4FfM5dxi+VcF5KkC7Z69OC/ynQIv4GxLMwNEr5/iMMz/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jxq0V/VJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a8553db90so72287766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 03:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721728827; x=1722333627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AuETpAkS7dO1pVXt9IMoI+AKyQFXLNy7DvKlLNteMoo=;
        b=jxq0V/VJXG+IF8z/iwalEjteiMd1TKR54+zC7huVAMbyLR5+lOa6m0Pw2gblArSH0F
         vRODqcrlCQo7ixYWfHWi9Nmw05teG1JetglyvB9nUnNH6iC/17nIi2JMaaNmRRZMxMix
         3Bbb+N7c+0zrJlZ0/9T9r3dzqHb4ZT/U+o2BWnK/UjrK2ULnsgnSVOxlH1yyTyJU3Fbh
         o1IL8o3y/1TVT3WQWkHXxdHKm0UV04J0WK9q2/nNh9J1PmVVXwicUWDQRByoWemGFdAP
         4nPsDdl9W1i5bew3yXmEHBHgCLxebslR3GeW3VFYaRPGT6IlWqe1hc5aVhN8XcW1nmAh
         RrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721728827; x=1722333627;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuETpAkS7dO1pVXt9IMoI+AKyQFXLNy7DvKlLNteMoo=;
        b=sDFjgp+cYybIagladfHrPgCUdYT6BrUrfIlp+UW4tLUynaeh9i/3mIOnYI2VFeejBU
         ShZLd+7XkZwZWnsC0ouznq5iyN2x8BMcAOhKGjSOnkJa11zMKKtvXnUTHrPUdOkeLsAq
         1MamwgFTfcGyp4Vd3WkcjuZqeGqKOuXgvFewbJFwPaYbnp9WlEfsNMFFW4N9+y9EZj/j
         9B4jRv11r7S7O2Vxkqa24xc8Qk5jJ8RPASvvEPvnqctFSlQ2oc7aQtlw2I4/+zUgaefv
         wkE7t8a0iMoFcWRQ36gxBCgoaddP56+Ou1SJf9GGzUMtDA/fU11VJuakV/vH04c2Dx3I
         Vf0A==
X-Forwarded-Encrypted: i=1; AJvYcCURpEhMTSXpyG/IFpwdN2TeSizRhiX9PHmXSPQPeqacLzQfcw42oByZN2XfFsKeDyGELb3tHM+BGzNLF94mtQ8xD/9/5QpM55LQf7i+
X-Gm-Message-State: AOJu0YxmWiuDqyfv1kNx4Acw36ZT3gcdOSKh4hnmYS7BX2B/4nPv9wDp
	DPHRWznoLK0Qp/L6Prwi+h3S4rfK1IHFskxjoEUMQStsIvIe6KUE+OZXgjZwrzE=
X-Google-Smtp-Source: AGHT+IEt0r2EOmdTkoQfh8/SbBZtB7+hXOk2yRtr2EguKFj6+gn2QABQYbu9O5eRk+r7Yaz1k5dd2A==
X-Received: by 2002:a17:906:c142:b0:a72:6b08:ab27 with SMTP id a640c23a62f3a-a7a4c0f436dmr614822866b.36.1721728826475;
        Tue, 23 Jul 2024 03:00:26 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a8c3ee792sm84573666b.80.2024.07.23.03.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 03:00:25 -0700 (PDT)
Message-ID: <008d5544-94d3-4e53-bcce-25133fed36c3@linaro.org>
Date: Tue, 23 Jul 2024 12:00:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: pmi8950: Remove address from lpg
 node
To: Rayyan Ansari <rayyan.ansari@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240723-pmic-bindings-v2-0-e1cd614f8c4a@linaro.org>
 <20240723-pmic-bindings-v2-2-e1cd614f8c4a@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240723-pmic-bindings-v2-2-e1cd614f8c4a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.07.2024 11:38 AM, Rayyan Ansari wrote:
> Remove the address in both the reg property and node name to adhere to
> the bindings.
> 
> Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

