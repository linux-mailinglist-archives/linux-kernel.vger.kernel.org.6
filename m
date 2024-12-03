Return-Path: <linux-kernel+bounces-429513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 944F29E1F3B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7AC6B28448
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD3E1EE01F;
	Tue,  3 Dec 2024 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FugLlNpf"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E72F1E7648
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231365; cv=none; b=CY75X9zJPbs+cQtTeIshsnFsvCbyOTDTCf1eAawrBj1SgbxNSE88o8eh7AlqJUXzzPO9vOnbBlGv2XLic+e4el+9sP1jnwHk390kBA8D4vWAxSTGNfp/vaOAt4kWLkwccCz0IImUXP2MhaWaMbOwRN41iAh+MAZQldqfxk/JAKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231365; c=relaxed/simple;
	bh=YDR0YWnLKGpWYxX3gsPfp6VDfdpjHUDFZy8cOfRDBUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KG3RVFhMnyodmmgLlxOAqaWWGaQ48Ftnofwfy/5czROcV1fNy5A+7Ou4m2pcHGEQgrM1iY9wJEuZ6H7p4PtPmSa5m6tMg8ZArDI+uX9A/HCCVNg6tRPIGBUq5sI0WAf525b51ZMDdPUxutJPIjLyPVpy3gg2g4emeQe+BhUo7gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FugLlNpf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434acf1f9abso50713305e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733231362; x=1733836162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YDR0YWnLKGpWYxX3gsPfp6VDfdpjHUDFZy8cOfRDBUk=;
        b=FugLlNpf94Emlvnc5inyluRDnT9mo36guXpwbXFve/LZJGA2yJMsZFpdHVw95AAwQ/
         PuD6DrQRfLq5mMsElkn/snh1OsE7hEcKJMHbXmdUtViZJBRgehZz8nrUq5+ec9tTeEu3
         iGHUC6BZT4p+Uea7Gx8w57UsN88UuIaC+XUQItlvwq9Rp9c0MC2dmLYj3c51Vh39YvQE
         bSQl36K9/JTxqLmZYmQ5LrfrcFaTlOqWC6G6ShzQYpKf3hh1OCT2DM3v9Cp+1HFmh+AH
         xs3MSyP5swocQIcl0WI600vISb58q0B++zPk2VwOyMFYTNn/3imPUW/F8gZQkeSF5OFF
         /SnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733231362; x=1733836162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YDR0YWnLKGpWYxX3gsPfp6VDfdpjHUDFZy8cOfRDBUk=;
        b=F0d+I2EKU8QrwSt0DvWuYtxNgkb/l9JQ85XAP+m9Ft3LB6ieI4cdjtAgLTEnxnOfGs
         a5yQvZ7cPiVgrMinNlBbigCBc33ScCq21/vIOGUVkVrzHtsb2JIr/ZhOs0w+rcpp2v3U
         I2VOpEtKMcB2f778jAtWsOc2tC6y+jYaPV2e3HzTHKgScHiiHwap6w9zdWZMa4qnJnbG
         c5LHcsReLo2beb53XxE6KthZiGX8KIzqfAZsfKgyYjjqlZk7FJYwQzReN5QdM+gk/hdC
         ixZ9wZjFVsmoZR8QaY3/hxybipuMkms54RzvYWxVrmoe6v3UzVS2YVZSejVFtskw9JzW
         hNRQ==
X-Gm-Message-State: AOJu0YwZENd85k14RF3DtnUBKNzSNsSWmW1H8DgEXXx/4NTWOMmjhH2o
	r6gomDG1x0oO/vZ7t/2G8g9ox7E3ZrsJ6z8bGZ/crlQUFff61CO+G8p0FmFGR4Y=
X-Gm-Gg: ASbGncuELdMoU+cJzvgaBouzIsY0rhwIZIt6+R4+GftrEy/6zx3dC/J5LazgLD31AtS
	Ya1gLi9dRIeODtm2yEh/TSMy7EySaBZsH0lPAV7XtCdNll8xDXHn9ysXjCfi7xIV/tb97UhX8WV
	gc3tuNk8pH33ojdbHMS5WD9hCGdneq+jS+SgFMi2TesH4BX5qWBGT8Ti/zUXuZUWHyQzWwAaysK
	diYJHwLPK+oCwt0GTB8crhl2yn1kgbqpPl1rsSP9LeH5+993y2a5UQsQw==
X-Google-Smtp-Source: AGHT+IEgjZh4TC8j5dPhQityM39qffPlfEhObsWPGXvaJj36DpzimRcwsGyIcCWZhT//1+YJClpZ4Q==
X-Received: by 2002:a05:600c:4f87:b0:42c:b5f1:44ff with SMTP id 5b1f17b1804b1-434d0a07e55mr21049565e9.24.1733231362310;
        Tue, 03 Dec 2024 05:09:22 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f32589sm193447135e9.28.2024.12.03.05.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 05:09:21 -0800 (PST)
Message-ID: <dad1bbd4-0eee-480a-8a2a-08157dd609d8@linaro.org>
Date: Tue, 3 Dec 2024 13:09:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add myself and Tudor as reviewers for Google
 Tensor SoC
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20241203-gs101-maintainers-v1-1-f287036dbde5@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241203-gs101-maintainers-v1-1-f287036dbde5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 12/3/24 1:03 PM, André Draszik wrote:
> Add myself and Tudor as reviewers for the Google Tensor SoC alongside

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>

