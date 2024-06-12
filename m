Return-Path: <linux-kernel+bounces-212304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F16CC905E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70871C214E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4267812A16D;
	Wed, 12 Jun 2024 22:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rxn08QA6"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E590B126F0D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 22:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718230004; cv=none; b=FC/nGLv8yUbjIP6nFziJWjSVDlfhHrKFJHVx4e3PMwfgQRBbXQ5DP+xu5ab+0Svtn085fYldvR1HLlzMY4vBE6BfiGn6KAtaQffB+ZXSIWrBQU1hkyCCsNw8PFKFkhTD5NiqaonaXpFx0jC40UNkI3G9BG/DX3Zcr/XrSDvoJaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718230004; c=relaxed/simple;
	bh=nWQB0cxwpb5Nyp9W2Aj2B6qiyQPIg/qKQY5yKA+03K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVd2NBVWw+wADE0B5Fq3w1SNSUAPLOnGrCZf89hBRNPeUd3Dw5jiCdb/8dceErp6vcIbFtVVz2Ry0y/5O6EmtJN13baEh7MvMztFmCeoXwObp7AXmn5pT5ryOouEAa7WlVpvQNDCOrMs6+okz5/DSrPpTPo0GS4/AiXWELNfPbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rxn08QA6; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52bc0236f04so52061e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718230001; x=1718834801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHMkWh1GJqApt9wvbkQjpRZMa0KcRsUTuqWe6P4okXg=;
        b=Rxn08QA6bw+Rp/CPNBTBe1zTm9vXDUWsV7Uby7e1oF4TyL17o/CeJV0ALs+/t7PeWv
         pwugLXNreBY8DyBo7jOcqWzqDVBmgXhlIFgZeUW0t2bMjv+iZmjTUzjwkAsHgVJnaX9p
         UL9DY7b7MxtWgrVIUntHyQq6dfSAFOsev3QSajDrozf111aWRJjatg70HNVZpTo/pyMZ
         9MfwthRMHWmgIi5exv5WiXdArtV+beTr9NurrBqA6bFF59SJuWpPnWMmkdnSfOmkpG0r
         tdhRnpR0+q7wroUVHQuy8uJBIS6Xk6MnuI3/WIO086mIYe2ByKuHaSdI1WN7TGWeJqnl
         pYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718230001; x=1718834801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHMkWh1GJqApt9wvbkQjpRZMa0KcRsUTuqWe6P4okXg=;
        b=cDDXyGqudHmI2xMzHNy/KgIHkS8a2BE1jvF3YNbYXnho+ttxsgA3ivharkrUtt+J9h
         r3ijaeKHd6JuA4AFRVmh0LdSksBVN1b9F6yVZB3oKBiO+CTfpBsAPNY3JvvAoPIngyIP
         wsBriahd6aAwOx1X0hV+WY9fNVQ5Vkdn94SfTOAMbsussihuKW4ybDr1aNbfV9H8S8FM
         ygtNO6bsG3S3Y6sqSeswuZy9KGp2oLmh5I3VAExA6RHTFoUZn+v7y4PQmbGdt4G/0E6h
         S5LoDA0mEYE2B0R0/SQIsIGCMdSsHAntuP61yaLTXZXmfrwFoXgx+u6lWQxzYi5uk0iB
         ydZg==
X-Forwarded-Encrypted: i=1; AJvYcCUhgEKHjMUv78g3cJZXsJYW4kYc/eHOvcAQm5DmPmnXqTr5M4HL1YnmPWDPgpb9uUMpflRPFXzpPFJ7Xg2owCTSPdd1B4d5eoAWZRhk
X-Gm-Message-State: AOJu0YzLuFzZom1v0zjS0owwgYXAqZ5+tR8JB/7y618CqDPkUInH7wl7
	fxZlWUMvRSEQbsSz3aWGaS4emxL32x7E+LvzePOlbCMQmzCh8vEe1D9lM3PovK4=
X-Google-Smtp-Source: AGHT+IFGBDcnsnGgnH57GdtLyI7Cp/okDgOWixyNLiELylSt9euObSqVLA0Bs7EZsFFRS0f0ffmkBA==
X-Received: by 2002:a2e:22c5:0:b0:2ec:2f8:f4b0 with SMTP id 38308e7fff4ca-2ec02f8f645mr4542301fa.0.1718230001010;
        Wed, 12 Jun 2024 15:06:41 -0700 (PDT)
Received: from [192.168.1.3] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c78556sm76301fa.85.2024.06.12.15.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 15:06:40 -0700 (PDT)
Message-ID: <e974477c-f451-4c9c-83d6-31437c52f1bd@linaro.org>
Date: Thu, 13 Jun 2024 01:06:39 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/8] dt-bindings: clock: qcom: Add SM8650 video clock
 controller
Content-Language: en-US
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240602114439.1611-1-quic_jkona@quicinc.com>
 <20240602114439.1611-3-quic_jkona@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20240602114439.1611-3-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jagadeesh,

On 6/2/24 14:44, Jagadeesh Kona wrote:
> SM8650 video clock controller has most clocks same as SM8450,
> but it also has few additional clocks and resets. Add device tree
> bindings for the video clock controller on Qualcomm SM8650 platform
> by defining these additional clocks and resets on top of SM8450.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

thank you for the change.

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir

