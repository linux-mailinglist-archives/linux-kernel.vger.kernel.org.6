Return-Path: <linux-kernel+bounces-420987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376BF9D8531
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE99163422
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769A519E819;
	Mon, 25 Nov 2024 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Km27Eue9"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA2199947
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732536899; cv=none; b=qTmO47J0aRpfFCB9R/4OL2qpJ3NLWQkwz8HF1/iUnrTbjwn4EQHJNUR20Jl8e0Bln9T4aylzsj279dSqCTaD9uJ9Tn5le6TnyV662LlhDvjnKRcqR/VGtdoANAb8KToaeEoHM7XHG0dIiT2MLp00uf7vWg2epGditdNPN5CPy6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732536899; c=relaxed/simple;
	bh=5+CH4sdSb4Czej5uXH8PynFRcfA8UNoarY82ZAm5vwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFvMCZ2L77i/jQzKHqV4apoZtUaDt9xu2SQQHfN0D1PYFK/iBRZnEHTPawwUZ/a/rDsuobzSEUV2yCakFSUH9eJe0qUcQ6WD0KjO3EiTD+b3+p0WCcDvHxx41ahOSRiSYoR/id3a+ahA1HPSyMsuhYoIDjrUSqJ0u1YwGJkabT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Km27Eue9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4349e4e252dso9618955e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 04:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732536896; x=1733141696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X6UVB80JNVzlmdkqfMX+y9fwa3r9eW7MOnFP/RliVH8=;
        b=Km27Eue9f+xnKzXMhunMfFzRbkQ38cPP596xux8urUzBxt+EGdSnIGTSDc8l+fNQJs
         59TckWYXVh5nGMMSKH+3EY9Q1TS2WXKnZTb29xLmv56a6BB7v25acmcSJrRdPIuY5EoP
         +q318zKzddV9bWKbl0b2+w97EmKWNNuBS/4raj7oojWHP4DDaDIhsUmYKjLPmByQerIq
         AU/FuJIyPHlplHOPAHkr3mPqv/hK4TnmHfV7IKVuIO0Tn7blZZLAHmIB2tj29qQhcWBv
         iGyNsJy5sXELgvzpLcekSjHU+O23DL+zLiTJX7bvNOGn76E45znbEqfjwGPyiZDpD0zQ
         h38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732536896; x=1733141696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6UVB80JNVzlmdkqfMX+y9fwa3r9eW7MOnFP/RliVH8=;
        b=ZaXtQf0QUDEDHUSC/tY6PEBD5Vpidbr49JcL8Kgas+pLXg1hkqusYGXKwYMJ/ArxFf
         WNirovTbaH2+/OU3I60Iac7/vwN6dcpauCwc3ej4T5t4Tedbs4EH39hzMHDNIUJzYKWZ
         NMhgQRZGv0U00dQ+RCMxDKjOkZDCalAzdJspJQ3KYgIkToZLrdb3uw9MWV3SsEE0K5bW
         8CwMfnDYQos/dsE8Z+ejsvym7CEackaiQRx0LVlgGj8/8AFZf4Ws/GydzggKmCw+hNYs
         8WSJldNTXZ1swK3CuhCyAfs8mWTPrf6pni1t1oAiWTUkSLd03vKSawz+t+mFCC2luJBH
         t+lw==
X-Forwarded-Encrypted: i=1; AJvYcCWS1DovtngsU5xwaFa7IEAfAHlok/+w0q5lWMnFX4BD9Zy/Cp1weXRPfT+gyM4/PuSyFXKSEFUtzQdoU6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YybDFYpAYRAcPaVGBCxSg4EncqPXlj9LxzdpsDAodbO/E0Rx1ah
	33l8n3/5wcTe2u1jbgvkMQhB7vRURKd7+h9cyld+5tuCo0TfoBeTbuEQE4i/Ydg=
X-Gm-Gg: ASbGnctyhZHqp6pk+jGl20if88/9BORiY3bH2XudM04+VUXe0umTUjoDnxQyKC+XW9y
	cu2E1CWGhR7xE0fRiX9NTq9kC9MACTRH+Cmg9Su4nstn/JxNlGRfZs5B8aF86pXRq/0icN3pnRr
	rcWzd5BNna6CGLUJGFqH397r50PWovvtrQtjXPoefmA/wGAxv8yDQMUzNVzArqRTnRAj0pSMTR+
	qyTXaA7tB0RuticgaPCp2toIiN6LFgbqO3qciwBn+SK2tJ7ZUOwpH+BblgxwOM=
X-Google-Smtp-Source: AGHT+IHL5n7/E+eTCV55LW/mwE4Unl+wX5kIFsw4BH4g92rF5oirei1LF7bH/yT5C4hccVwg6ZNDEg==
X-Received: by 2002:a5d:6d05:0:b0:37d:49a1:40c7 with SMTP id ffacd0b85a97d-38260b7843amr11618659f8f.28.1732536896598;
        Mon, 25 Nov 2024 04:14:56 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825faf9a5asm10212032f8f.23.2024.11.25.04.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 04:14:56 -0800 (PST)
Message-ID: <310ec20b-3fbd-4c0f-8705-cff96bb6e4d3@linaro.org>
Date: Mon, 25 Nov 2024 12:14:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] media: qcom: camss: Re-structure
 camss_link_entities
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com
References: <20241125103457.1970608-1-quic_vikramsa@quicinc.com>
 <b27fe267-c722-4133-ad7c-bdb1ff573ee7@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <b27fe267-c722-4133-ad7c-bdb1ff573ee7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/11/2024 11:57, Vladimir Zapolskiy wrote:
> Hi Vikram,
> 
> On 11/25/24 12:34, Vikram Sharma wrote:
>> Refactor the camss_link_entities function by breaking it down into
>> three distinct functions. Each function will handle the linking of
>> a specific entity separately, enhancing readability.
>>
>> Changes in V3:
>> - Broke down the change in 2 patches. first one to functionally
>> decompose link error message. second to restrcture the link
>> function.
>> - Removed the declarion of camss_link_error from header file.
>> - Link to v2: https://lore.kernel.org/linux-arm- 
>> msm/20241112133846.2397017-1-quic_vikramsa@quicinc.com/
> 
> as I said last time I don't see the value of these changes.
> 
> Since the changes are non-functional, then hopefully there should be
> no issues with them, however I really miss the point of adding 65
> lines of code for a questionable reason and at the price of increased
> complexity.
> 
> Is there a good reason not to drop the series?
I think there is value in both functional decomposition and tidying up 
code - for example removing circuitous if/elses in favour of more 
discreet and easy to read functions, so I'm inclined to accept this series.

---
bod

