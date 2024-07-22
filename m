Return-Path: <linux-kernel+bounces-259470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BD19396B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 00:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1633B21770
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A1F1F5FD;
	Mon, 22 Jul 2024 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aXn2oU5h"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521782E403
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721688372; cv=none; b=cC+O9rz5GPEBSmaEdiU/jn5wxAubMk1Kf4M4EqsXtTlp4xxcScJO2lMFlznY9hRx5QNe5gm4NWbmUwlCFUmbbqtcs429UUfCgFZruzKJcWWoyQ9bWKQippeUhg8pezt7kbRLaMnIjgbjFGGaQ+tkxSj9ZCjEaeiTjDXLPHfspJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721688372; c=relaxed/simple;
	bh=jeUkwJoVi+hxWACBUHHjjYCAiSxQ9jFCgA7+jCPwTiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j2y3VoksJhaCGJfzJpa+hYzm0f5joxQVNrqJYrhp661JICrFeQNjgP+2cn2NyL6SGJeD19Ju2XMKmp2KTAqlQryyD9VjknJoztV7c6NeLiAuaVG+JSPnaBA+cYsSQa2ytpVssPM5hLzqZBvmaBcREhasF81Xz4dJB09ICfVhGL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aXn2oU5h; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f01993090so2369142e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721688369; x=1722293169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IcsB66rpufRlsnqGsvmQ5rQbzSBD7uft1vwDx5CNMOQ=;
        b=aXn2oU5hTQEiMwlwtTvZ9SkjtEXFsnzbrwI9cFm2ARls00nEB582w48kVzr2avvu3l
         Hcl3i2sW/INw4ncvcWqHMrjwz8XMqMQzPiltZDE795jFwYxCxCWCRla2bil6JZ0sT1nf
         SL+NFxl6Adznt5UBe46WyBbyxddZQNmk0ASXSTInVgLbGOmfHTujCggesUDXgsVkGW8i
         XBRQiAN1hwp7Ta+hEU7kyi7EsiFrzhWhMri1mtDUKepSyk+Ny4FO2XyuWnqTDWSPgOyS
         /UGIvgoKkbBHaO1nRWmIqNJCCsoXVJ1qXXrEHcBLr4g4HbaPm7cbPb/SaItMPF9tT52y
         v8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721688369; x=1722293169;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcsB66rpufRlsnqGsvmQ5rQbzSBD7uft1vwDx5CNMOQ=;
        b=g772fzHpC7AlrW/vpKiVk4Oqbk4YGhugT3/Xb4F5Kad3E+j4ew9TGgBhxs/mlDnhiW
         XEiqBFgW5VDP9okcdCRB6tY/7/y2rFM3wczC7wK6lmw+t1lHmTOaGssL8TaW4J8p+rJ1
         P7jX4lpvCX/sg1hJlDImcLtoZjUUeHbxNdaWk/pSw3oXeN0nrPnBaha7IfDXrqmzaXcc
         W7jeDt81/T+/uWe2FcKusTIBrjx6nBDQbi3/MLRYmcg2haVLS6Fb/POGJYyvyDmHN/RK
         vRYzH3IRnU5AMKzktuXqx72DUQfjMHuUFXHVO/JG4Q71eAZsaZIEhdRZnPcpG55JH73W
         hAEA==
X-Forwarded-Encrypted: i=1; AJvYcCWPZm5d1usrIxmk3v5m1Ig6TtEtez55GahvhHHcrI/O/kgoLEArrR9DJ/qAh0xxehLeEailnmFSVeAEGv16QFUZh9LTfwCy+JPVU3z7
X-Gm-Message-State: AOJu0YyhRyqC+iFPugDrRW31U7vMWxuQrSVOxbrSGcx8D47cURW4XkyY
	5kuKWAnT0/h/s2JbkhrTGRoeLwerOnGmiS+HliC4PMAZcwJHUy70+kzJG73AO6E=
X-Google-Smtp-Source: AGHT+IEDSNVou26dr24jGfioaPkcodir1wLDDRqua2yjiU3IRTfDC8P5Nrn31MAP6tkofEEWX2YcVA==
X-Received: by 2002:a05:6512:3e01:b0:52c:def3:44b with SMTP id 2adb3069b0e04-52efb771adbmr4518627e87.31.1721688369165;
        Mon, 22 Jul 2024 15:46:09 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef5577693sm1364869e87.256.2024.07.22.15.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 15:46:08 -0700 (PDT)
Message-ID: <86cf4781-ce66-48a4-b5a6-4b72ed76c65d@linaro.org>
Date: Tue, 23 Jul 2024 00:46:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: pmi8950: Remove address from lpg
 node
To: Rayyan Ansari <rayyan.ansari@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240722-pmic-bindings-v1-0-555942b3c4e1@linaro.org>
 <20240722-pmic-bindings-v1-2-555942b3c4e1@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240722-pmic-bindings-v1-2-555942b3c4e1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.07.2024 1:47 PM, Rayyan Ansari wrote:
> Remove the address in both the reg property and node name, as it is
> hardcoded in the driver, meaning it is unneeded.
> 
> Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
> ---

Well the bindings are opaque to the implementation, and the commit
message could reference adhering to those instead

The contents are fine

