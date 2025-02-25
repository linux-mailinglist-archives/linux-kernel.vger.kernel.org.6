Return-Path: <linux-kernel+bounces-531049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B110A43B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15763B1372
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB3B267F5A;
	Tue, 25 Feb 2025 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQ+eArjQ"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F082676EB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478950; cv=none; b=CYT4AzQPlaxyffoBrCY66SeA/QlxxIrpvp47bPbJSANOPxsGzw8yYsZv46E+jbrBPnAfrmI/qJQzqSgmT9PZza3XPvsAwyFRzFsiu+RDVBRHXr2k/CfVsWA1ub8rSFVXFOiChjRjdk8BX/miG8Vx8NlEa3YjtGmM8FmsmOLWj+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478950; c=relaxed/simple;
	bh=U5zkt/oMGFqmvC1+SOvMTHXlaeCxYp1H/iVGRBn1FbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AL6Ann/bV6muk5Nh4aZIx/MTp+NFpHPC6CS44LjIlgN4VKJ4x6qG03ILESJ7pVWGyuCTDIb9LH1pI+DZnJ3AOY1BbqprmgB2ohDXq1RfUIbV251b++HFd5t2KoNojQYi/aG0S6DFV/S+pbNcXN/TzzGQlu8bs0zFEvb8VN1vkyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IQ+eArjQ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ded7cb613eso1073262a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740478947; x=1741083747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sNm9CF22nxSn0y6dAdKNE8VFXGgWPtm2tN0cbfkS55c=;
        b=IQ+eArjQAl+J8MhniyuafBycpo3z+gyEu6MYjuUTjmwUVJM/1KfAzMXRh3KQRHLHU2
         5d9cfClaplqoprvPXUWNb57xatazT5r7yM2+hdcKMzCn/6fniPaMiNcUkgMXYHzBrMI5
         YcaA/R9NgIf0d9mRg0w3blGtP2UQSISUI8xBkJdZ+o2wz85VnDfTmCU44H3mmajaNFh6
         XTHNwyUPsJTaFAUNW481XTeMnjaNtx8TEWgF7tMb+t5helP4FGE8Golu6adJJkh6WzX/
         s92GnSxJA9jkqmRCyZXnP89g8IppHvAx+j3tpcq3OfT9zJhw1RF0mFTGyBPH1adyFC9s
         tu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740478947; x=1741083747;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNm9CF22nxSn0y6dAdKNE8VFXGgWPtm2tN0cbfkS55c=;
        b=PZzodE/rhoQW1cG+N1BgG4fsXfzR5fxCj0uvjn8r/O+1x1+tTJDvyD3OVWvCbeG4Wz
         MbkFX7qEXLySPxChhzewk5l7VS51aixxLnZ67EjGDHzHGyZxX0rIeXJyzrHYyEVGV+CN
         Wi0HgVxGwC7ukUCwEY4M3E9LjkhqIrHK2Ste4nLXD2AxxlM6p1unQNX1ttxuBKKfT3uw
         lvrI0T5Osh4PSDZztWdDn56Qz4ehARE3x0zdomT2buLA9dTfZTRGea41c7iKnJEGE7YC
         h6GajRPTbz9I3XzTcpnS8yXPIxJmnSBkE4WbY+teCAPirKha5h5lZtI9aIG1Rxvj/6kC
         g9Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXhkNqSccAfUxblLcMqJmLZUNOUPuyLUekL3v7oW/iR3YBm2WZLERmNwkIFSt2z9sfIoQGkBDj2cn4nUZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Z3r3DMIquCxXrwLJkS1AR4EzhSDt2kfwdfiY6NFvchzPGMlb
	sSsiyQEMBxJaHAfXQiJyIJiZQ94t8GxOoIRKZBM2wmxFSWvk+y2crPePTKt4mRM=
X-Gm-Gg: ASbGnctaSRh5LogEzwQ9I+PI1xF1GdDXg/5LyHkx65eRrqGsMIBD+2XgKaqm8MMR/hB
	e3Ez7WZ1VGbOi46Fyb+/IOOhD9BkVcN6aWRicj6TZTgt3/HvsgX8mRJ86scj+gmIF9e1dLL76BH
	lNdDnFWfsF2aBG6wFw3in3bYrO2v85E0lj+Au1nPH8b79y8+TmWWwExCa+JpDBzQHNR5KTTO1Jl
	M+6xuQqTw4f439QzkvrgsAmuS9KsVhdGdLhISICsb6DHXiTxiNo9ql8zJsktCaHudUf+5wBNecj
	K1JzdAmgrcIxh8j/xGZ/7hfvd+Ejo2uT/Z6OMB57ZUQI71tkBFzVerM6NSdc2j4I4CcMqGT+xpZ
	4TGBF
X-Google-Smtp-Source: AGHT+IHtffeLLh1yLu7nCHYhcNqtippdudVEDeBKKKKJEXeyYUCZJ5Ybf+sLAGKVXPIbB1aDmboHMA==
X-Received: by 2002:a17:907:7e90:b0:abb:ebfe:d5e9 with SMTP id a640c23a62f3a-abc09becfd6mr572181266b.9.1740478947358;
        Tue, 25 Feb 2025 02:22:27 -0800 (PST)
Received: from [192.168.0.18] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20122b0sm117367966b.107.2025.02.25.02.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 02:22:26 -0800 (PST)
Message-ID: <7b54e965-3395-4349-8ae7-51a28c759235@linaro.org>
Date: Tue, 25 Feb 2025 11:22:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100-slim7x: Drop incorrect
 qcom,ath12k-calibration-variant
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jeff Johnson <jjohnson@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ath12k@lists.infradead.org
References: <20250225093051.58406-1-krzysztof.kozlowski@linaro.org>
 <sfhcmlz3x254fdowufeeuh4uiwxfgkphm4ch4laceivbrs3zir@qvqk6jxi6zhf>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <sfhcmlz3x254fdowufeeuh4uiwxfgkphm4ch4laceivbrs3zir@qvqk6jxi6zhf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/02/2025 10:50, Dmitry Baryshkov wrote:
> On Tue, Feb 25, 2025 at 10:30:51AM +0100, Krzysztof Kozlowski wrote:
>> There is no such property as qcom,ath12k-calibration-variant: neither in
>> the bindings nor in the driver.  See dtbs_check:
>>
>>   x1e80100-lenovo-yoga-slim7x.dtb: wifi@0: 'qcom,ath12k-calibration-variant' does not match any of the regexes: 'pinctrl-[0-9]+'
>>
> 
> Adding Jeff and ath12k@ to the cc list. Is the driver able to find the
> calibration variant in case it is not running on the ACPI system? I see
> that it uses dmi_walk. Does it work in the non-ACPI case?


But nothing parses such string as 'qcom,ath12k-calibration-variant' (see
git grep), so how would driver use it?


Best regards,
Krzysztof

