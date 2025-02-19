Return-Path: <linux-kernel+bounces-522077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACA4A3C595
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C58718844B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85223214221;
	Wed, 19 Feb 2025 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rv8czQMD"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2DA1AC88B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984550; cv=none; b=mDPxASclKA+2kWaMwGJY/rTSAldpix32RU4crl7d2nhK16dy5lD1xZrTI4OpAoVB7mdgyBU/q3MWCyXU8bfPDYsATjnU/qoEha8ievmo40RHzW0wL3XBt1yCMcp3j650bVteCUYKkSetZ6j57lXnQb2nUxpbHRyN6LaM37/U2tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984550; c=relaxed/simple;
	bh=QxtOwkajl6hH7/pEGXhsHbYvqnaO91BFc88oOREoqyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EY5mW5hhNMEjLYhOZBBTG5TGxIHnjo2kot/uSEVEto4xfuXWHYhTodo8gJKZSsu6R/7n0lEHQx8LjJs+hIbeSEVnDjEGRldxdJ7W8kOtikPfibCTi7rU+mhAVjsfeFS7sbNm9a8L9XImTslae+5OyV5wrlokQVMiDguhtgWRWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rv8czQMD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dc050e6a9dso1455921a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739984547; x=1740589347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0d5pqqN0Z8o3hwZnxZn3RZEZ0s3e/kci7dPdnavqqKI=;
        b=rv8czQMDlCddXJIgk0eWlmZbL9IUJ/xZCUYGG4NWYi79ZOVSFnPiK8547iLl1ljj8E
         NqX3cymCIYbD7JMNz8+A1QAB5hIN25FrONUbVVPemeSaNhq5GrMJKujdVgxzcp8aGcRs
         11mmwmd2X5segNglN+Uq92p/FPldQEFSnzxZzlZZtjNKu9G/PVuzxEIvgqZHQ0TiCjv6
         HZ7hfQaKfSBVmCkoY9fxYRnRjSlt6xnFNdsBqV1AHquyNysK4z7KRRbfwKTCYc1fC2uu
         7VMZRgGpmBTyodm5gJyyyKRiC2uYlQ4faI9vf1oN9oYoVT3qbw2FdkvWyz3+Pv7I0ED/
         GRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739984547; x=1740589347;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0d5pqqN0Z8o3hwZnxZn3RZEZ0s3e/kci7dPdnavqqKI=;
        b=T32Py9/cEX++zz1Cls5TXAmjnHbqpWmFDjiMqQ7Ht0JFsjdtEuNwH2GTTFuFnlSJXq
         Y2NTCwOjRHc3KMBkDN2lcPvevXVZx8yawg1nHnOiUJ56yflNo9u/I0Ya9JTs6VXrkZsv
         23EB9GHikewp3Z5JA05n+a9xORQHnEQTKqSpKvKukXj1KCAGMw5vkT8bk8A4A3T/sSg6
         SBQbnFL5yC80LXtkJa3AiXML67iRUlzb3tyPVx8kfjWJbhZYnbNZ2twKZt4XLdd8ekW7
         6gyAbgkT5ZYMIgqh6SSHyYi2Ax6SSWKN9EAULy+d6xY28khFEPJx+9CcJScjhsu+pbpN
         Yvwg==
X-Forwarded-Encrypted: i=1; AJvYcCVObq65low+4YRrvqGldqdTNXpjQePUFEKaT5x7hBh4XpXyVW8cEejoQPU0UkaVQDJ3ZiH0NAf0myiJZXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYKDZ5s06fclsHzOgGwUfw6aAYDU/6t8xzhj4Zm5MookqrbKoC
	V5wq3HIpXVc4tR5HdxsPTQSIcm4UX4uWdY3je1PHB74v3X9KRYa6OeIuat1x1/c=
X-Gm-Gg: ASbGnct2t0LnYf+QDWXCgDkJxd0qahFiBnojhc7vJZStSR3hHjr9VpMkU5c2MHFM6YR
	vP66dkW0gMMeiDZ4Wwk94Ibc45BaOfZYbAiwCK6JI5yJdryjSavhuWr9GDmIGx1mCxp7Fn4zNEK
	iC+jTQyCLPwZGCwAA2xXVv7PgykGkjX2QXWY1V2kZfmP+YWlIc/RpTqiA1iuGy4p2JxMo2TO5Pb
	vzLmxBGdgdGKcea8TsxrZ7Jx14GqAEGWPZz8obKQ2FvQeL/kT7i1CGaMwu/WgBqPi8No4qSRHt5
	lNgZRaxwZO5j+vH5/ZiciLHVJMMzyFyXb24=
X-Google-Smtp-Source: AGHT+IGMNGeUxobLczzfjsXrsUzCPQSf8SeShRohU3rVCmLL7Adrb3dgHVGFbZ9nRqq7UPcEGJNnkw==
X-Received: by 2002:a05:6402:5193:b0:5de:d986:417 with SMTP id 4fb4d7f45d1cf-5e03620ee42mr6390666a12.10.1739984545744;
        Wed, 19 Feb 2025 09:02:25 -0800 (PST)
Received: from [192.168.1.20] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dedc94688bsm9374660a12.50.2025.02.19.09.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 09:02:24 -0800 (PST)
Message-ID: <2dfe466c-ad94-4683-a2e9-a49e77a61f4f@linaro.org>
Date: Wed, 19 Feb 2025 18:02:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] dt-bindings: display/msm: dp-controller: Add
 SM8750
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar
 <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>
References: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
 <20250217-b4-sm8750-display-v2-5-d201dcdda6a4@linaro.org>
 <aqpuik4zitdfuk4pahn4wyzxdvxldy4dcqjs3mhr6fqtxpoxhf@ssfzzbfce2nu>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <aqpuik4zitdfuk4pahn4wyzxdvxldy4dcqjs3mhr6fqtxpoxhf@ssfzzbfce2nu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/02/2025 19:58, Dmitry Baryshkov wrote:
> On Mon, Feb 17, 2025 at 05:41:26PM +0100, Krzysztof Kozlowski wrote:
>> Add DisplayPort controller for Qualcomm SM8750 SoC which so far looks
>> fully compatible with earlier SM8650 variant.
> 
> As that became a question for QCS8300, does SM8750 also support exactly
> two MST streams?

v1.5 of DP (starting from SA8775p , then SM8650 and SM8750) support 4x
MST for DPTX0 and 2x MST for DPTX1.

The DP in SM8650 and SM8750 are identical, according to datasheet (v1.5.1).


Best regards,
Krzysztof

