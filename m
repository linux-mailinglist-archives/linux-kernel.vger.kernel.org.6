Return-Path: <linux-kernel+bounces-225654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B52913352
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DFCBB214E7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFED2152789;
	Sat, 22 Jun 2024 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZQuClbl"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7836414D2B3
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719055311; cv=none; b=dD5B4PtR6pZu8HzlNBN/cgZ8Zku56I6gXSDMei6z0NakBlJnKzcdCSsFrvpCo50QsRlZIoLEHRh5jgi5LGIW/WldYQqkDCyjr7EOPmeTHA/TWJzlgeVzCVToGxhpIanRHc2tEJCx2JQa9/kGVl/50x5RmJ+OoKaquYdDdr0maW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719055311; c=relaxed/simple;
	bh=yNv9F/RG5xvLbcRU5VaoFHunK5D9b7jdpAxluannzVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cp9AetamhSMYuBpmjjuNTsSD1kNvBNI3nnR6s4lCz1DDXHenGQz3b5fwLt/kb5Z8J97lKrSyxcetGv8hghJ37OPgLj9O6Bwy+aOHFSshvd0s5FapGmJrY9FWwX8yIabdtjC4WHhsWBZObMnpusctB4AQJwU3Nh1KfnoVrdmjTIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UZQuClbl; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6fdd947967so59899266b.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 04:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719055308; x=1719660108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ONG6bKiTspIhEbA9YlGbgpEq1mAWMqyNj0AssfJTVR4=;
        b=UZQuClbl9zvoLtErS1rgY7VZR7P1R7sjjkQ3XMWWdALvnxTkc7IajfCfdAW0Y0TPtQ
         RnNpd0lWywDmWkc7COfBhk3VYrY0VDgxXM3bPiTCxIU5THC7A48/+Xmh0oQZb2RDxHfT
         pufRJcFZYBqPw75UHcTyH48QNFO6SFEnx0+GFe14gVyFxJ3K2FB6xSdjN/dP1eNuvs1x
         avgBXIeLQY90Dp5Mk13ygz4wA1F93S1TgrK8++i5BevMNQB0t4mu3p/Bk9g0ZCBfQumM
         ogzdKSakQF9EVxzrTAmgRNjDaEz67YmEmiYtwympnAVUs2uzEdfdElUHaA+lhSHI1zKH
         tRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719055308; x=1719660108;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONG6bKiTspIhEbA9YlGbgpEq1mAWMqyNj0AssfJTVR4=;
        b=mFSdb8jGZGxUHlK710Enm2unxUuPEWj9dTT/nghdR1KxQzCh8Cg9DQg1uxrgTknXy2
         tOfoMtdqQXJzlRrJCThDVLlFT2ixL4ngOrBSK0LeBTCiCg38YsOi+St0ZgBUaxZ2NZgb
         I5sIR9DSplktbNkYzbgKutbzT0E1rnG31ojaVgmm6jnRoZGYBcEwz32KVrrrvGDS/DB/
         RFZ4+nAIcSiw51a5MivpkB1pKGuaqwqLSQd9m9CAT70lkTYWSCj9vzKy7JUTBSKga68q
         YX0qXPcJbJ6O5lNn/RrB2E15BE4WIpgj3cU8JO66DEl1z1yBjSoWH5VAfClv+neJSH1t
         eDGg==
X-Forwarded-Encrypted: i=1; AJvYcCXm7r7UnKyKuzCNan+2xREhHLD2lIr4p1O/46q8f+EEVaQHkA14cCLZNhA6nZtUWgFQx7oSI/vIgFjhE+X9LFITSKx0r/Bm521/6Qv3
X-Gm-Message-State: AOJu0Yy2BsneMrV9jUN7v2WdZhQK0TgFaVtuW9fIlDiuSboYF40T4CID
	gCk7pZG4ROndt92gpDIYijNZ7VAqjc8OWTMMUeJu5/WTP6qd1NKZC70YLd2hBX4=
X-Google-Smtp-Source: AGHT+IGfzyz/0+o2tIp0n2wByuwnQjzt4pOamTr3vvZ9Zdc4a8xnYsWLCqrh2+ZmZ5QnfRnATMd8UQ==
X-Received: by 2002:a17:907:d502:b0:a68:fcc9:6c1c with SMTP id a640c23a62f3a-a6fab05c0edmr800424866b.0.1719055307670;
        Sat, 22 Jun 2024 04:21:47 -0700 (PDT)
Received: from [192.168.128.35] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf549075sm185474666b.98.2024.06.22.04.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 04:21:47 -0700 (PDT)
Message-ID: <f468e14f-7ba6-4717-abc8-fbf451c05030@linaro.org>
Date: Sat, 22 Jun 2024 13:21:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ARM: dts: qcom: msm8974-sony-shinano: increase
 load on l21 for sdhc2
To: Valeriy Klimin <vdos63@gmail.com>,
 ~postmarketos/upstreaming <~postmarketos/upstreaming@lists.sr.ht>,
 phone-devel <phone-devel@vger.kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240621-sony-aries-v2-0-dddf10722522@gmail.com>
 <20240621-sony-aries-v2-3-dddf10722522@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240621-sony-aries-v2-3-dddf10722522@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.06.2024 4:26 PM, Valeriy Klimin wrote:
> SD cards would exhibit errors similar to ones described in commit
> 27fe0fc05f35 ("ARM: dts: msm8974-FP2: Increase load on l20 for sdhci")
> 
> This patch applies the same change to the regulator for sdhc2.
> 
> Signed-off-by: Valeriy Klimin <vdos63@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

