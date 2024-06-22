Return-Path: <linux-kernel+bounces-225637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C496913329
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3751F231B7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B349015217E;
	Sat, 22 Jun 2024 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QCZYvMe/"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6041614D280
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719054409; cv=none; b=NTjKDxUBW6FZiT3gSlXWo8EHQrP3JI5pGVZyb+Z2ZZmxydYnOrZqXCYXqjUs7nDnLF9vYjXvJ+EdrvGf9+GW2ftM+jmzYmt8NHh4qT44zjuVSsK9y8Sl5mqPLAEa/Bnz99he72RgJQUm4G9QHf7ByQ0XeYYKlI92w2umD6dws2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719054409; c=relaxed/simple;
	bh=/mRxmo1vTPYeVkoEJks87leqjlAbNSmAkxjPy82Ed0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvrkhLN2FWUOzMy++aANNWPDVVD6GecjVhlLK8goAvyTLp8QA9X7be4N/j7S2DIZKkho2y+7uadfdtx5l0sJrAXome9KHnSnbIe94GftJJbC0O508N2Gn7jKosnbkfewSgXD73Gxt08p3bkrdEGJNQygWqHVn4gENT1CUSn2Gc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QCZYvMe/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso375566666b.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 04:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719054406; x=1719659206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GPgHR/S4LAzHFQwwe9apPiwe57nygnlV5oSiyYkLRRY=;
        b=QCZYvMe/VRh/pqyAarVoyMccPWfBAPoub0dKWWb+Pqqcp80Mqnwrf2hmthiezdhzQI
         ZQoQMBfSOaw2kJTA7wE6rQr50DHCb2lUPnQuXuGkT6WUxlukJZWu1Z7l+XS6byDC3Em9
         bDlqlbJA2MnTFkFiQaGM5B1pkEcTCLpe8HZeri93HyKeXelQ4BUmQpXMjgP4IYMI/fHI
         1/nRp01PHvtqmaPvep3zrWGNXB2/ul1sBSHyFlFzvHioxWfGKHEQYWCE36mwhq/am9+M
         TvEkYAGwP9JuCi5DrnoYonBoCzzz5dazqzIMUmZGCuXHmp9/tnHjwquGfHC24NJrJkhM
         T9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719054406; x=1719659206;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPgHR/S4LAzHFQwwe9apPiwe57nygnlV5oSiyYkLRRY=;
        b=eil9SsktxA+fq6PWYiWfxzc3LufiOrgRbzMB9tj24qStbgR1qjykMgQDgI9VW4YPG1
         qKMGng8OA/2QRA3qirvMBhim/1warUk78GmRtewdcYyE8h/CsqJoStHkRTm+hx06+HBZ
         39CDKuLdt4zosIYfKl4F6WE+YnHPZKcw1OD624vPp9gS/bS/YrBVysNtMQSTORotJM/L
         TdIHUKUviXRG1MLQeSOLPMkBH+2LS6i5udqje505waEIwt7UXSH0QHXz2Nukdwv7nvV2
         VdYdMlLC56PtRs/PGaRo823NReu0NvKGwmBKUJepFtDeaTDOLtLaE7DZEfXJZQuM1Gxe
         1IPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4ToXcESQYiGZrbclIq597/kRTJ6RCD57pVJBtyYTcWOA8i7/6UrSgjsfBMnU3x5C4ctbYHcPEsSwcRG/b9wBR5Gph5SkOzUefPQBe
X-Gm-Message-State: AOJu0YzKY40KSZSj2Xld6JBDE7hXxzxWUxKrp13j9ZsdXZKpCsmEMOj9
	TpqJ5DA/I5ZfXg7VrhFqA31QTYjPVNFDPMkbzUIG+of1pi/bos6hCXIMRQ0hJG0=
X-Google-Smtp-Source: AGHT+IHsvjtHZUtWWgN9jiP/A9QN29JwQCb021pukyGZ3effvpLiqeD1EV3bWY1Eh5mYfmadI8js8Q==
X-Received: by 2002:a17:906:ced9:b0:a6f:8265:8f2 with SMTP id a640c23a62f3a-a7242cb716emr8019566b.37.1719054405527;
        Sat, 22 Jun 2024 04:06:45 -0700 (PDT)
Received: from [192.168.128.35] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fe30e6a1esm70060766b.216.2024.06.22.04.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 04:06:45 -0700 (PDT)
Message-ID: <7df49549-0722-4b1f-a545-d18f80c99820@linaro.org>
Date: Sat, 22 Jun 2024 13:06:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-gplus-fl8005a: Add BMS
To: "Lin, Meng-Bo" <linmengbo06890@proton.me>, linux-kernel@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>,
 Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20240621141319.347088-1-linmengbo06890@proton.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240621141319.347088-1-linmengbo06890@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.06.2024 4:13 PM, Lin, Meng-Bo wrote:
> There is PM8916 Battery voltage monitor on GPLUS FL8005A.
> Add PM8916 BMS and the battery to the device tree.
> 
> Signed-off-by: "Lin, Meng-Bo" <linmengbo06890@proton.me>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

