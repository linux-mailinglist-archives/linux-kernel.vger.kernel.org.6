Return-Path: <linux-kernel+bounces-225669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAFD913382
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E1A1F22A7C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5316615531A;
	Sat, 22 Jun 2024 11:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sSBfdw8A"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE46314D283
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 11:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719056850; cv=none; b=evyKD3vb1K0Oi1uuDocKD+L9QfBWK3pzOSDNgVA1dAsuhLK4wIjiOUXi8QyMHYOb5B3g0wi+wxO6yctIQAi81BBXB3D/T5zVXTI6lucSJOk0DJcbpG+xyhwEPRzrYPyEyTNXS9V9BxCUamACL+kCyZTxy6l5Z6zKJRNi4OuKFzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719056850; c=relaxed/simple;
	bh=9HW0EKBjliMtQgcjh+Q6rnR7bvgYSXhkoyU8qURuBOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zq3WLR3JOfZHmrpKKGvUJbXIXV8omKNq0hWhqXRB4PVZjbgm7m2u9mKOdSmUkrW3iIHrqQzEZngIhHhXe6dyQXkAJOk/sG87E81ElB/Io4aZCxGHhDzSOZOtsChfMmmtitDbm7UsevZ5FDY0uUrnRBlB38Io1jRt0w5zzgK8BdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sSBfdw8A; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57cb9a370ddso3192601a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 04:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719056846; x=1719661646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GMNfILuks1dO8qewlx3Rln5wKJZKgfLBKJ/x00vmQuc=;
        b=sSBfdw8AfGuahRGAMbm8SXWucHf6auJA8XtkxFrh8Ms8oXdaeolW09cmmzS3KJqIcK
         xgeKiivaDJybl4x7nVb2qGOR6icCd5DiMpBNkD9aWqmFnvOeQi46OnjoB4sBTb3+yjHG
         CBNukBWrCtfNha1aKfQOUw/ajUQVSi13YC8LBYFruU6KAGTdErT1r78E4GDatbMoQzfJ
         HI1Jfo0A+EG0Rv7KIX13K6pdrlqOagOoCYKzo9AuzZf4Cl+UsvYy0ketu3SBA1Mfj14O
         ePSZHr8UAynQGnylLWg4/CZSWFLRDrRBEy1NMxwTrMUoD9D/8P2W/E9Seg0ZnKlliN8a
         jQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719056846; x=1719661646;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMNfILuks1dO8qewlx3Rln5wKJZKgfLBKJ/x00vmQuc=;
        b=bWR2t8ZDwHHNBHMDNPoB8zViWzVgajZAzfoZOh4mBZPOGF3K2YpUmuMbEyylUKiEs8
         XKytfd+1L4UyLhpApVH+EYU9IziF1Gs15HNomudrSrWklx4b+dqTW678keqLgrpGU6/w
         8D/yKBnqEffei1o4qFKJ5D5qBmReWF5GlkUc7OZuYxiMKzyY2ZSnCCycUHpYEfalHRUM
         +DxbSR8NiiifHbWgl2ZXMoFejnD2NlYwhat0TbUkZzTVhGs6xp4v7uayXduuDCxLcaNX
         //+l+lzoLyPEOGqCrsesxYUknLXV5SCESykt/SfYL/N6VmXA5iGCTICqV6Y3AJbtobRk
         rfqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZU+5VU5F5x1aIZS7ejNFwTF+PsH49RVwlErEIxad0nVjeAc2ilLWZ2tVscM/ZBvKjofKnILPzaKqplbyutHkT3ffn1b7CLDy+8rO0
X-Gm-Message-State: AOJu0YwGygZXjkXg0+7Dq94qCPrdHXZ+nWTGhIUXhJH57jNJqBTRBqre
	GlhWdRSVdyI858Fw2XoNgFKlS/IxS7mngQRU1/aiwR3rOaRPxjIfXCcYeeMI6xg=
X-Google-Smtp-Source: AGHT+IGPd0yRMno5iuHp123ccFoht9qSNa3r7/hf1JIr+3S3nQAB1NpSm/qpu9dnCIwbrVTmzCgpBg==
X-Received: by 2002:a50:c014:0:b0:57c:7ce3:6cd9 with SMTP id 4fb4d7f45d1cf-57d07e6b7d8mr6880465a12.23.1719056846039;
        Sat, 22 Jun 2024 04:47:26 -0700 (PDT)
Received: from [192.168.128.35] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d305616dfsm2243941a12.79.2024.06.22.04.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 04:47:25 -0700 (PDT)
Message-ID: <a7cd32a6-4689-4bb4-b211-b8dab5caa0a5@linaro.org>
Date: Sat, 22 Jun 2024 13:47:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] ARM: dts: qcom: msm8226: Hook up CPU cooling
To: Luca Weiss <luca@lucaweiss.eu>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org
References: <20240619-msm8226-cpufreq-v1-0-85143f5291d1@lucaweiss.eu>
 <20240619-msm8226-cpufreq-v1-6-85143f5291d1@lucaweiss.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240619-msm8226-cpufreq-v1-6-85143f5291d1@lucaweiss.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.06.2024 11:02 PM, Luca Weiss wrote:
> Add cooling-maps for the CPU thermal zones so the driver can actually do
> something when the CPU temperature rises too much.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---

Very cool, thanks

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

