Return-Path: <linux-kernel+bounces-414075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8319D22B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121E328342F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71A71C1F08;
	Tue, 19 Nov 2024 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D3jEhbYT"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0F714AD24
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009573; cv=none; b=Crzsp7wLbwSN4U8qcGFdE33GcvdKoheBlhxGfR1kiUGNUA88d0tsAeWAgMoG627TJnYF7yybmNafGMpP7Z8tRh1//l5S4SAJr3vmzpZMGTkyjBqbImvEUZM11oRUMLfZkauPDacO4oh4i1ihMAcd6thD3i+V+WoeQ7DOdPvnw38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009573; c=relaxed/simple;
	bh=ve4mTfja6XZIEAPB66fNc2JLJByQxXnjYLnW16rs0uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LN4PwhGXWMF1s/nFoEKaaCyl1Vh5uWytZV7gp4ENIyDWUEDHaA6oGbkVxLYU2VptCsENQm5Jmavv0Krp+e2JsUxdDlwcCc4IGTmaXVdB2pTfPdWRiyiFK1CEkZ3HDiqwnI8If2o8UZ71ACeXo/TcYnhZDmdr1rRdtb6ulGUhxYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D3jEhbYT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43152b79d25so34249875e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732009570; x=1732614370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uW/Lrt7vQtMqvBoYmRgnoHpbirDah5r4yqywUagnRFg=;
        b=D3jEhbYTRrh8F90tSFroNByt1iwlpr6C7frhjAL77UvKSozWW1bbEJPN8fV00CyxS9
         oD7k9hf1Pp78AWdS0uhmO7X5E+uyJgKB+oAzpW5I4mKGPSpyQSS6ySQo0RBixmeTElci
         KxdQJPPK0BrXk90ZVhT29TEbqZoHODxTLT1wL3HXJ5poxyFGHtjIEIqgq14wBR1/eyUT
         W4+FwVSsLi8Am14lGMd/72+xNMFXdqQHjIKjH38lPuHsYraeiW3kgBSZ9UtjD4FPQQJS
         fSE9aAKzxCTZr4G7k25PdU3kmi9sAMyILBksecHXFnH3aDchrqpRxNfqDeFk2zMTTy5R
         YkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732009570; x=1732614370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uW/Lrt7vQtMqvBoYmRgnoHpbirDah5r4yqywUagnRFg=;
        b=lnSVSU07yBkAxTVT5rZjQsrWXP9DxmVH3rRtENXvmXGYhP+OSRPjOG+i4OmLQEEHxp
         9amLKul+pGf9//8IQB/8S/tG3Q8TYuRknbJaxvrP81qsSIWZRDHqrukqKt4gbZJE3m5h
         uVqmfu3OI4csDWY6phV9wbPUxVttuCOizfbYXS01FazS4SAmYiSrxg9Lx6jBQprjzKAy
         zte4xhU1NabD4F1Pxn+nNnxsaHogCUUC1FHWGuZAxLjFPS4bhAci8aC9OIxqu5oO/4CW
         n3YY7XTuUx/kMJ/ohB3qekyTg+jdO90m9oJNx6bF69GNtdTFXxsGubf5iy8lMZfC8Io1
         kBsg==
X-Forwarded-Encrypted: i=1; AJvYcCWSmpJpahpa3vgcGHgY3NjDuBGP1d0nDISy9zG+fy287hxme+MsKghEcWm3mfX/o3wKMks3T/VzaCF1znA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/mcPTRbvjzERhcX5+ahwj0jHtO4x5tKQO9FSBO49SM4zObsaO
	zcQOd84uu8gPO8dNMRvB558Ebe2DxhAK1BXATmIKqs5MuMGjSN1Mfgb7kqU0IhetRMG9AKesDcG
	tBAw=
X-Google-Smtp-Source: AGHT+IG7ogy4qzTkt9UfxSsrDtJHiZVKufG5KQETrDc6UaR8utEe0hQYbj3RdkOsqApJp3Nvq6UZSA==
X-Received: by 2002:a05:600c:1d9e:b0:431:5ce4:bcf0 with SMTP id 5b1f17b1804b1-432df74d88bmr147004725e9.15.1732009569697;
        Tue, 19 Nov 2024 01:46:09 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab721d7sm190627805e9.9.2024.11.19.01.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 01:46:09 -0800 (PST)
Message-ID: <bad60452-41b3-42fb-acba-5b7226226d2d@linaro.org>
Date: Tue, 19 Nov 2024 09:46:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] clk: qcom: Add support for multiple power-domains for
 a clock controller.
To: Taniya Das <quic_tdas@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-0-b7a2bd82ba37@linaro.org>
 <1898ad2e-a6ea-43ef-af1a-25229b4771db@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1898ad2e-a6ea-43ef-af1a-25229b4771db@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/11/2024 06:08, Taniya Das wrote:
> 
> Bryan, as we were already in discussion with Bjorn to post the patches 
> which take care of Multi GDSC and PLL requirements, I would request to 
> kindly hold this series posting. I am in the final discussions with 
> Bjorn to handle it gracefully to post the series.

Is this not 'graceful' ?

Hmm. What specifically don't you like about this series ?

---
bod

