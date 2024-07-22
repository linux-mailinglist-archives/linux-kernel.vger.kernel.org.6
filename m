Return-Path: <linux-kernel+bounces-258813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93A5938CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA6CAB24C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDD916D32D;
	Mon, 22 Jul 2024 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLsUOjUR"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8C616D31B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721642527; cv=none; b=WE2YOEnzh9Wmlg0KHsZAROSvs/i67B8qdaW8UEV4RRrM4SWcKvESpMwf6/X2F8+ha+1np7PUjjs3wug83PHWfPPoTPNuOlG6zcJBwEPTLHnT7/I/ELE6MB1Y17y/Y/Qen/270F16B69XWga1LgLou+u+LJKJNaPfKjt4dsgRQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721642527; c=relaxed/simple;
	bh=0whNdyK5dpTJ7KdmgtCvHNvW/sU9vlihHaRji166PnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUZL0epzJRqp/RhX5/L9yRV9a7rK8NUtW2gX+UCMtJreCHFS8vA2SzC3XxTe63lXjjYF8FaNPmHQlU3OGK7Bmg9ArlFR459fDaxvHhZLtQDw8NOFq+Gg1q1iDRk6XvlhJane1cfivf78pBjjEWzXELh5krB/JJ3j1urDlrRuMa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZLsUOjUR; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef32fea28dso6420531fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721642524; x=1722247324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RQuPEjyITICQBVFUREtP+m5ZW/c29YWFbZTmV+jS/hI=;
        b=ZLsUOjURg7kUENS5Ewsk6+ttZ9i2N0aPvu+6BUtnPfAOTtoEJOZOo9wcDBGL1OXJsl
         4xDm/QtAnLr6ANEqkVQ39iufu+5fyVjpYzpjS28+S00qiAA01/nYs75cwHlbuZpa4jl7
         iqT20dCSORW8YPvLlGo6oufEnnNqgwwImHZnwow9cg0fyPFQIL4Eego2ayDOSw6japsy
         5P1MigqY20IykEXBn+1+6miQOZ6mzi2DLIaUfxp1Vvhs7F3BvWQrSiVrLo6QPwAfcpy2
         cWIXvkzddF6HbvibDMmtpDNiidzC1HL5WlcAI3vTdTZ+xV73RbNGlHG7uD3BivDcvs3P
         lqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721642524; x=1722247324;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQuPEjyITICQBVFUREtP+m5ZW/c29YWFbZTmV+jS/hI=;
        b=PxLUq32RvPhLIKjMNCTFJEKOP4YKThU+ED482Kph2VTSzXGmvOJTHT7nIo1KyJl69T
         x5aWy75JCQLGmTL07zL8ZMrmVFM0whTTgXXJRlAOo9+9vXZg/HLlbN5D2dIJSyiXBeFJ
         iuyZR2i7whVPX1YfvINvJtAL8K4Jq09TOrcjG+yKourjuKXVjeQRqdtOP/7JC0FmgRoI
         H23rRK3G6kNKN1VD+uZLPTh90hZduIqLjvB6m1BpdrVEooZlNpHoQ6i45X2YPGITL8/+
         j/xjTZwzhcvkNPKwymzZqs2/p/DESTloZKSS0Zxl6Cc2RkE8FAihHEKDnyyxcrpe3tGr
         VPLg==
X-Forwarded-Encrypted: i=1; AJvYcCU/pU+pBPXzWTGKmH0IsZ8NTV0lGz5oWo0HReXk7dS5oRB7//IAKj+x/EDEMShaIBhXRf0USkcgfmEz+2Q+Emfqly+8aVKqU6v4ItRO
X-Gm-Message-State: AOJu0YwJCOxmVS/FgrrVUzmPD0bNcBKEASgTry/CgRj1jI1ONkeu5CPO
	OO90Ju68UPsAY6h26wTEQnb4Jal+t60cAyFAUmokNPE2Sl8xoxq1pzRueLHk4oQ=
X-Google-Smtp-Source: AGHT+IFCanFlPK/dilnYHrv6NEVa8E5OHTdJ0uaZIcf9JijUgjWQpE8ynIoj398+gvZvvZcRGahZ/g==
X-Received: by 2002:a2e:9081:0:b0:2ef:2b53:c77e with SMTP id 38308e7fff4ca-2ef2b53c9bamr23150851fa.7.1721642523781;
        Mon, 22 Jul 2024 03:02:03 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c2f87d1sm5917107a12.70.2024.07.22.03.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 03:02:03 -0700 (PDT)
Message-ID: <f990df94-31ad-4e20-8df1-2cd6d3572eca@linaro.org>
Date: Mon, 22 Jul 2024 12:02:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] arm64: dts: qcom: x1e80100-qcp: fix PCIe4 PHY
 supply
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Abel Vesa <abel.vesa@linaro.org>, Rajendra Nayak <quic_rjendra@quicinc.com>,
 Xilin Wu <wuxilin123@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240722095459.27437-1-johan+linaro@kernel.org>
 <20240722095459.27437-2-johan+linaro@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240722095459.27437-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.07.2024 11:54 AM, Johan Hovold wrote:
> The PCIe4 PHY is powered by vreg_l3i (not vreg_l3j) on the CRD so assume
> the same applies to the QCP.
> 
> Fixes: f9a9c11471da ("arm64: dts: qcom: x1e80100-qcp: Enable more support")
> Cc: stable@vger.kernel.org      # 6.9
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

