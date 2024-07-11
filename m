Return-Path: <linux-kernel+bounces-249303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAEC92E9B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F422AB20A22
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BED215F3E2;
	Thu, 11 Jul 2024 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldMwUvr7"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA814C5A4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704993; cv=none; b=cYss0y5na4sJ3b9NJi9WZ97yUViN3pOAA/Iig5ghGijRmLZwpzm38EfAXAhbwWE+jSHhLxXBrTIQO4QKkC/f4vWOZKHEAJcGhaMn3O0M6sqe5TWazGL9dX7f2Ce1kjs6P3AejvVBdecSTTsIgOhAvt+MWfyWMhUop17FsIz98u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704993; c=relaxed/simple;
	bh=ZJBtzydDNvnzwNjEXYE/Z8NIvItAF0eOwb6jFiFqgd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RaHmmOBbR6RWZr2/GINob7xQ7px0xGahpfpAfNXcWsk+kPw0Gk5/chdjBY1o4RcJsaxImBeDSgFG0Z/brFmjZqbQkF6lEXbYzYVNSPppiSf+BgdeI3jEHXtuN0ORNq/coNTTdfuUhmqp0b0YaH6Yi1itFtLKI6iz6MfQZ8xZEqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ldMwUvr7; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ec61eeed8eso10774871fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720704990; x=1721309790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DVLJo0/MBfbDMXoMGmbxkF4EVNMrx/VG4OOfR+Do5os=;
        b=ldMwUvr7K0mLW7Pabrb54oRls71XDYGeMkO2WSdBQESubbUUoACQQB3LT3W87fDnAn
         GX83XU84qg3YtFvo5a0xGtFpeHk8SpABlYqFXiqTHrh+WjfsToPQvp14mASu9RXkaVQl
         jBBQAK8LYW12TswA2/oJryXMMaTX0SsT0naJqV0+Z5K4CqabrhIFWxHQGoQ2ymDPZ2ZT
         EA48tEqIS2eBdH9Tta9JmFNIbR2V2ZVM03wELFrmSivDNGs2pEMlGNpo0CKenUsnv9dh
         x3VEK+Am+VJHmaySn0lSQS2b7Qgu+RcTsXTc/HJvtKfxNY/3xETWb69jzIqDTyg2q4nd
         qMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720704990; x=1721309790;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVLJo0/MBfbDMXoMGmbxkF4EVNMrx/VG4OOfR+Do5os=;
        b=SUWrvMKnC9UaToU2EEn7jZCidd2C+psBhX5/hMwamgyn9eOj0Keg1nOUeiMohbWnnU
         wIUq1VD/Q5l948kUn58UWh3JaQn/7M82e5ODgNL/fOEARdhpLWU/MEcKLosPT7wQTtim
         TEZafPoK0NEwztt0kRUMVsn5SW/gclwkHwqK3qoChyw5BSCD6Dxf8hdp45KUbtLRqU/q
         fVstX639mb99d9ItWWakHdnbuhYsbSjFbFaXuTj8gKov/XioYGcmSCLEi5vKdZYy0NZi
         Z7YkbmDxbIaHiR/Kb5Jiyz5CSc+nMAAJxcgpVvMba5A/DoKQ5wSZNlirhwfUBPZG2N/F
         6n1w==
X-Forwarded-Encrypted: i=1; AJvYcCVqP5+JE6yzsa2hcgNdrGm8F5fAj5IPHeNt78zISbu+sZnxddtPtn3CozqbwAzeGjILufjDTZVnTkeR8sZPZ/TZOsphXvGSgkZvyuSF
X-Gm-Message-State: AOJu0YzsG3vgpOEjxcaN/vvAPHMExaHjykpYhLnccHVjdWo0KD3HZa0c
	3UBXAZ9kBFF5g1U1Ss8zOg4HEQSAbFlhS6gTO4xtmSlCHVkGepwJkEZAuR8xDMM=
X-Google-Smtp-Source: AGHT+IGW1LfxEoPM8hrXbZlHQULLyAdwEerywPN0lSOYfjGLLYcyS8HeP866p3l1Hln9aIe3MLhEGg==
X-Received: by 2002:a2e:b0d8:0:b0:2ec:419b:429e with SMTP id 38308e7fff4ca-2eeb30bbb7bmr52639441fa.2.1720704989535;
        Thu, 11 Jul 2024 06:36:29 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bbe2d006sm3433632a12.31.2024.07.11.06.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 06:36:28 -0700 (PDT)
Message-ID: <b61f7707-8b9d-49b9-a5d8-62e0cca37dd8@linaro.org>
Date: Thu, 11 Jul 2024 15:36:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] ARM: dts: qcom: apq8064-pins: correct error in
 drive-strength property
To: Rayyan Ansari <rayyan.ansari@linaro.org>, linux-arm-msm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>
References: <20240711110545.31641-2-rayyan.ansari@linaro.org>
 <20240711110545.31641-3-rayyan.ansari@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240711110545.31641-3-rayyan.ansari@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.07.2024 1:01 PM, Rayyan Ansari wrote:
> The "drive-strength" property was incorrectly spelt as "drive-strengh".
> Correct this.
> 
> Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

