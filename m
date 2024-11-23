Return-Path: <linux-kernel+bounces-418883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 380589D66AE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 01:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6C5B21B4A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 00:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3479476;
	Sat, 23 Nov 2024 00:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Feo9+J+A"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5C61C32
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 00:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732321143; cv=none; b=f9kC+yvd8d0Iw4Rjv7P5AlF6RA5amfJFyboCYJbypbBcqZUgiegCvT3GLlI15pS7z+/WxSTnKzUTgoMDBDcaUM5yHsuOxnzC63ej+L3z/CxM5ezQL/lFRiZ10rEFXZFCgA3kyk+YATnD2Wu7hnkOGgkH9f3qC68XAYzVt7AM3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732321143; c=relaxed/simple;
	bh=gp6cmepa61xAyiqmA0aFpcdQ8xEtl56sKeMzfRIXE1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDSs3e6KDMR2d0T0Lpzx/qk7E5646fIyTzzP4XbOwNwg7U+CP89zQSM4aHRgeY3MU99DSG64Tz/K1W9DdQBRpS8MkYc8Y/PxX/xeX3a+VM8aaTKNqGMu4ScA5sR5EybU6MP6/BiNW1zsAyDuH9EaVi3hQn+mTyHgsiBECphvAyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Feo9+J+A; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315abed18aso23618815e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732321140; x=1732925940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CBar/yUBJZ7evAtJzqvt9icFhcSkyuHEJP8iZfvqHus=;
        b=Feo9+J+AR+AU+ahicpwF2PWcXN8I0qV2NdFn1o9kB4MN4DsZY1aPTb3TU6hhTJWUBZ
         tIiioKDGA2up5wrH4dGGfBzaC3Mpi/pwx/OPeZDmfjnOm/Bz+6eIxnbXB4OtOEfpBwGN
         WKqIejjb8qHFpdGcfO5KGg11Kdwag8d53soZNfbkNbbwHNlcXEKfcNT4E6YUEXz7lXrT
         RPqrl3kfirqo8OUcIcx9NHXwJjAQ3Oyy/YIa+StCpxvUY+SNRMhhSGJmJamLoupidY0T
         1RlzrH0Rx4hVoyH8B+lJjf+GP7gycsG4Y2c/zhAhLpWtCcR9MQdJAbyZGjD8vzdcRV2v
         bK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732321140; x=1732925940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBar/yUBJZ7evAtJzqvt9icFhcSkyuHEJP8iZfvqHus=;
        b=X7C7ubq31kSuhls1JnTbP/1kDa6gyVTkHDMBeex6T7HwTEoUctR1AmuLj434GNJrTV
         5MCiAzOvqDOAJMt3PsUkp2WXh+bEJk9TSQrayYELGp1nyDAU6ZE7AhInhwf657w2CVkS
         hXfBYIz2Vp0VC5ieNzzTqsv418SLnHeI+etQyz9g2ROHgkzuo2jdnGf33UetTyc4Ejr1
         brv97zkIXu5U4n6tDxV4HH6EgFLs4KgVA6rQpAQk5cWelADfKBGS/HvHUbA73jR5h0Ay
         SJobwg6w5QKN1yqWiGQ0KWTAMyJbcb/Q0QWx8zIcUm/YlvYAtxrdBP7H4ZV7qbfnCXNR
         Beug==
X-Forwarded-Encrypted: i=1; AJvYcCUy0z5BFT39qwx3a+dmsXDbT0d+c4YDCOlrYqLva3hFvdxX9uDmZB5/KOlSbFi0sNAM8RTAG8rg32y4T5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyilM4U85mVqkNvs5vV/uA/qnFi3I+Kd3nnMrfPCUm9AHUk38JC
	4FAqMiWVVamWqxZtGtDZs5pkoUBs7KNgmiQLw1sd4M9xkuh9w+bBzYgHiW9HqRw=
X-Gm-Gg: ASbGncsM0N2ieq6/R6ueKrwvzsGEYIccgyXft4SuEi9XwMkadAONeFQ6rmAaB/DHOVo
	XEK2Yg/sbpWvjC9m1Y6wiMpL8I9BE+Mpk8Dq8RjYgWpRKEb/hylzfJ0EyvZQ7qZ93S+pBfxlHkA
	A9KHWldOXcRe7YbGA8gkFvcqUCxAHRomSQjPUiUcO/m+oZ7ZaQfQhM3HCd55Gx82koiIidl9gQf
	bo7AjHbqihHStKzJO6aJpqBGVk0p/Ou7kdMMoD00RiJsBWJQnnuGT0TK7KCIyM=
X-Google-Smtp-Source: AGHT+IHlRoz6uk5MGmn7iew4+RptSPaqyvO51B4OHl+zcs4aSMhp1CyvOMHb1GlQZ23DFr2P1b8X8g==
X-Received: by 2002:a05:600c:3ac3:b0:431:6083:cd2a with SMTP id 5b1f17b1804b1-433ce42c78bmr45572455e9.15.1732321140029;
        Fri, 22 Nov 2024 16:19:00 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde10eabsm43567815e9.13.2024.11.22.16.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 16:18:59 -0800 (PST)
Message-ID: <f7c31279-8492-484c-94c4-893d98f53afb@linaro.org>
Date: Sat, 23 Nov 2024 00:18:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Use APIs in gdsc genpd to switch gdsc mode for venus
 v4 core
To: Renjiang Han <quic_renjiang@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 Taniya Das <quic_tdas@quicinc.com>
References: <20241122-switch_gdsc_mode-v1-0-365f097ecbb0@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241122-switch_gdsc_mode-v1-0-365f097ecbb0@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/11/2024 10:31, Renjiang Han wrote:
> The Venus driver requires vcodec GDSC to be ON in SW mode for clock
> operations and move it back to HW mode to gain power benefits. Earlier,
> as there is no interface to switch the GDSC mode from GenPD framework,
> the GDSC is moved to HW control mode as part of GDSC enable callback and
> venus driver is writing to its POWER_CONTROL register to keep the GDSC ON
> from SW whereever required. But the POWER_CONTROL register addresses are
> not constant and can vary across the variants.
> 
> Also as per the HW recommendation, the GDSC mode switching needs to be
> controlled from respective GDSC register and this is a uniform approach
> across all the targets. Hence use dev_pm_genpd_set_hwmode() API which
> controls GDSC mode switching using its respective GDSC register.
> 
> Signed-off-by: Renjiang Han <quic_renjiang@quicinc.com>
> ---
> Renjiang Han (1):
>        venus: pm_helpers: Use dev_pm_genpd_set_hwmode to switch GDSC mode on V4
> 
> Taniya Das (1):
>        clk: qcom: videocc: Use HW_CTRL_TRIGGER flag for video GDSC's
> 
>   drivers/clk/qcom/videocc-sc7180.c              |  2 +-
>   drivers/clk/qcom/videocc-sdm845.c              |  4 ++--
>   drivers/media/platform/qcom/venus/pm_helpers.c | 10 +++++-----
>   3 files changed, 8 insertions(+), 8 deletions(-)
> ---
> base-commit: 63b3ff03d91ae8f875fe8747c781a521f78cde17
> change-id: 20241122-switch_gdsc_mode-b658ea233c2a
> 
> Best regards,

What's your test strategy here ? What platforms have you tested this on ?

What help do you need ?

---
bod

