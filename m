Return-Path: <linux-kernel+bounces-227140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C419148FB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1E82844F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEB613A879;
	Mon, 24 Jun 2024 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1M/szUJ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126E113A25D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719229318; cv=none; b=uMlOnBwxf06lA78waJykgw39mQ9mYOQcfLtJMkjAUFqdFjuFWRNj8wlekz2uuw0lmNFpN+tqn+Y+E7iB5mVadohroqrMygb0WA2V9V8pPW41xQy7VQ7mD5/pCkmI79tj4XsBuwUNvB1+X02Mg5iAZXfTQfkZCEU3st3ZX/pL8ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719229318; c=relaxed/simple;
	bh=C028/nFsGE40ydlmB9BxdAJi/8hIWgLolYvN+o5rEZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBRFwFmKUM4/40VFmuRUZNDCiP3aoeXxryKpu4dCaLKcAZCxAXTadTxYiPxvZ+aKEbHDljKGOuB6eUX8QoF6vn4foheW8mTclH1ev+Es8ORjLiZoiSQbjq2q0cIOqu5DrNW1X/wCsT00I5ikDDvd4gd6R73s+hdwlcK9UusY11U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j1M/szUJ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-366dcd21604so1492971f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719229315; x=1719834115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+jjro0681AEOFwhkhNhmaTtx8v0fmEZR11zlZ878gA=;
        b=j1M/szUJ04JfmiXtzdUpbWOEGaymaHvffYUh0YgExeQe/9M5BcubEpewCPEuRVnJHy
         d4NKbBIZFZgxkllY1Ie/chYOeZ5I/9G1YhKZ65eInOnAlx+EI77AuDYC5EqV8Ux+TnlB
         /xyT5hHkn9nYwirYWVGZJQwikhxHQWkSBp0xaumLPdJjyxmfhHUnsecK6bEk+705gCcv
         d0gvnxECWQ8fwtRCjWnjwzFLL17ItksMD3VG8pLpDtJBv5+Pitd/M4/jqwgaAW8nClJb
         HAP9cNzgz8EROKUXAdwVpR6aKWusBVrH2qG/nK8ywxuDV2ZNTil55BWgf8Mah2lWHxVv
         +nyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719229315; x=1719834115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+jjro0681AEOFwhkhNhmaTtx8v0fmEZR11zlZ878gA=;
        b=efkTzn9PXsNFu4kt9Zx5gaLoCI02aiwKTFTkBynIMqea80WSX6n3AD8UkAHPxSg+tY
         nTs9VWPsYrTv0mUPDwXYjcNd++ZZ+gX174YllhGzELEJC+b3nRohGN3cM4RASb+3DRmS
         zSfY/tKfoOChhQFHuWmGJ9FUONASpKNS4kMbfodbNFjcHMKIukX45EQ5IYtpZLeBJ3Bu
         DWgk9+47ZfboDtAMChVPNm9dJHg5w+edVWw4KHW7zhGleSqs1vEcKj8XVgYdVVoN9Cq5
         LuCRA1y18y1Bzu1wkrFF+b+uet6fm5SQkSDSR1FDjtt4Q/+9JXtno/0c2TRFuX8E88BE
         k2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUR53i53CKXrna61JqcT7ICm2B7oNBBVN8+2Qk3V4t9u4cZ7qiDnBjip/e6elbDxGjeU4lOsVeZltpQobsM/tZ3+vl+2cV1xH5a6wIW
X-Gm-Message-State: AOJu0YwhgYGzFtizOE+RnM+Q+HYDJYKJqfsc46JxY35WtmsEJ8AtjAf3
	+K9Sgs02ETdw+xvAzSKX3wuatoQBcy2Pu6cZpDV0JyJe5vfYjI+9JmklCO86YiM=
X-Google-Smtp-Source: AGHT+IHoGgWxVHYl9o9oDPZVH7R7MNNhC1mYVS4z9J3EY4whsBbRpKDAVx2h9mKJ84IvNeAFF6eWqA==
X-Received: by 2002:a05:6000:1545:b0:366:e8cf:ef6d with SMTP id ffacd0b85a97d-366e8cff117mr4375611f8f.55.1719229315261;
        Mon, 24 Jun 2024 04:41:55 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c6esm9839416f8f.103.2024.06.24.04.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 04:41:54 -0700 (PDT)
Message-ID: <55bee27a-e4c8-4e4f-ac62-a581f46662ef@linaro.org>
Date: Mon, 24 Jun 2024 12:41:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: dts: qcom: x1e80100: Add soundwire controller
 resets
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240624-x1e-swr-reset-v1-0-da326d0733d4@linaro.org>
 <p6ooqgfwld7stzevozs7huztputc7vpc7652wx6rvg4cly5mj5@fwrzeu6alhgq>
 <ea57a3a1-1037-4d59-a384-50c98e1f9387@linaro.org>
 <mzcofsmnqkxgxarcbxh2gqtdusyzpxr4edjcpurerurzape7da@4dky45iy5iph>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <mzcofsmnqkxgxarcbxh2gqtdusyzpxr4edjcpurerurzape7da@4dky45iy5iph>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/06/2024 12:22, Dmitry Baryshkov wrote:
> On Mon, Jun 24, 2024 at 12:11:08PM GMT, Srinivas Kandagatla wrote:
>>
>>
>> On 24/06/2024 12:08, Dmitry Baryshkov wrote:
>>> On Mon, Jun 24, 2024 at 11:55:29AM GMT, Srinivas Kandagatla wrote:
>>>> Soundwire resets are missing in the existing dts, add resets for all the 4
>>>> instances of Soundwire controllers (WSA, WSA2, RX, TX).
>>>>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>
>>> Could you please point out the driver changes?
>> If you mean, soundwire controller driver, it already has the reset support.
> 
> No, I was looking for audiocc drivers.

drivers/clk/qcom/lpasscc-sc8280xp.c needs no changes, other then the 
dt-bindings changes that i will fix in v2.

--srini
> 

