Return-Path: <linux-kernel+bounces-224935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A009128DC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33331C2688D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F1F482E2;
	Fri, 21 Jun 2024 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMHQnM99"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CD257CBB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982302; cv=none; b=SLcgWc9vOf4gcunt4KNFQYRDprr7ppODOXnj6/MsTIbxrD/5coFbkFmEQTAThy9vpaEwi+6ACSVv/jkyjXoHUUvI7PH40KaeJCY6haV3uyVnXgeWLknOUlSBROMCOwB+m6rz93nVeI5jlf55xuOOFAJppJGdmdM8B+wv5F9PPUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982302; c=relaxed/simple;
	bh=DgLQ+IeB2sPH8dA5pdrtGV2KKq8Gz4mIWxEBjeL8XZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwDNTuCXbAksNGOoamqdDfbeyyh3Wj3fRnKKICe/BjySmO0Lakn00U9gLhMvl36boBCJDTl5X9s3a+R4DzkVpnUK8+2MaEW8I1fYkT2oiLOI3JsuuAuujg3oWjAZ/d+A+f2qruoB+zWLmxPpHTTtlOd2NQrOskWMetFqAiuEJ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aMHQnM99; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42172ed3597so12920805e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718982299; x=1719587099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQKKgfZEnpGv7BDuZ4upLWGUb0nT84TylDrfXWTJUgE=;
        b=aMHQnM99x58jnO3YWXDmVwQnKQlTgVRgfESx8KlLbuntZ/Nncaii0dzXrX21RFYsFy
         sPok4C1gk6uTqnrpeFIjulYBj8svLa81oJ/pH6Fp+NiqaN/JhdM6YdN2ZV1iMEL6+IGr
         4vUL9GAA/QSgx2liCTgQbUdumI8YnfvPztFqf0GNE1m1dbLE3uMHzgZIV3fO1fu5z7bP
         o10XPRrGhfkqtyH4Cuf2N6Y8/IKsbbfDLOb2cRxClQbNrakah+cI+5QfU5QYMRStVdK6
         ZZiZHcbnTjb53o8YntRqB9njj9iLQyiOH7vPjLoY+PrZu0b9DyaR6/WCZ0m1cjbVQNNj
         Ci7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718982299; x=1719587099;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JQKKgfZEnpGv7BDuZ4upLWGUb0nT84TylDrfXWTJUgE=;
        b=QrJe1RZliOcd3In3vBIWlK2BtBNca/H/FDCAOElUf/70LiRp1mumUCffCdjU7nMgru
         13ZdACNJjXaEfnJCZYw6fIZH015hMcuFO5dF/uxfFx0zIEz+wTBpLy8yvkkQN1rcYx4j
         Cu43a3+qKzuAvmLwHlbokJwlg/iT1dbUKjGdSEsmLrTfPgWLdL1vp7aJRtIYm/5W8Ser
         UFXSg7prgQOgrhe663LQ5oX5+32VE9XT9qCWluR4YtWuBsKW/3HqTRbNiYQKj/P2KRD3
         mqFICQspms8BlltKI5yrxCbQHQkDV7B06qiL/fxQrN2P+BKpg6sGtkiDn6GAcRl3QJ7O
         irKw==
X-Forwarded-Encrypted: i=1; AJvYcCU43MYA6YdgeTj+cVXDVnlEt4e5NWXFzk6KWQxwDSDt8rPKyOev5eSG4VBT/NHuyIR7FEr95c2ZBADQqkug81MR/KFFvv9sUbyVt1Vs
X-Gm-Message-State: AOJu0Yx9m1DCUsKsarYXn/ylHRZB+kL7Y0pY41ntoXSkfNW2m6/7fUdP
	ND4A8GQSiwWF++k6xSTcnfXBswvbYMTtD1Ff0LEW17zAU2AGId5poNl0WU8jtBw=
X-Google-Smtp-Source: AGHT+IFUIyImB0ZIrSXlC2Xd7dkKSDKHkd6AgtGypmfqBt61RUjyNyfJCXz6eJvy6Ju/rOHPAvsPTg==
X-Received: by 2002:a05:600c:3510:b0:424:84fb:9fd2 with SMTP id 5b1f17b1804b1-4248635993bmr773405e9.19.1718982298919;
        Fri, 21 Jun 2024 08:04:58 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f6af9sm2009054f8f.73.2024.06.21.08.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 08:04:58 -0700 (PDT)
Message-ID: <8d0b4878-a29a-4e96-8885-232aeb2627d0@linaro.org>
Date: Fri, 21 Jun 2024 16:04:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] media: qcom: camss: Attach formats to CSID
 resources
To: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, andersson@kernel.org, konrad.dybcio@linaro.org,
 mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
 hverkuil-cisco@xs4all.nl, quic_hariramp@quicinc.com
References: <20240522154659.510-1-quic_grosikop@quicinc.com>
 <20240522154659.510-4-quic_grosikop@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240522154659.510-4-quic_grosikop@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/05/2024 16:46, Gjorgji Rosikopulos wrote:
> From: Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>
> 
> Following the example of VFE, move all formats of the decoder
> to camss-csid.c and attach them to the subdevices resources.
> 
> Signed-off-by: Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>
> Signed-off-by: Gjorgji Rosikopulos <quic_grosikop@quicinc.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # sc8280xp/sm8250/sdm845/apq8016
> ---

Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>


