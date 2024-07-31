Return-Path: <linux-kernel+bounces-268857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A82942A53
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587931C20F05
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19701AAE24;
	Wed, 31 Jul 2024 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ATBYfYWx"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F18D18CC19
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417821; cv=none; b=LpndAzlyH4utAqxBBzHMMqfqFI0mj+8rVY+kZ8FwJkAW0LFYidND2nO7QrEsKe36a9qgHEeGXJDtKoBJcYAnbiIfJPhhIv2WZwOcxlI6z6YN3uwhhwyPU6H+6S+5oHY4xDy6YDjEmLWRfwCBoqq2eBAknTH4SMf3r//wfnQ7mrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417821; c=relaxed/simple;
	bh=e+tfYvZsC+8g5p6N0v/yd3eGPrWPVk/1ugRaPBauMFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQZn+h1XrnR+RwsbSHvKxf+t0NNStzIzfxCq4qlbUAYj7P0g8ctKzOnNfTXxywRdNp7R8p/aL17uWomISryUIxQouWOTMimiY45FNoVuxqeHXvzhd+HjIAowlOmaF3top/VsiD1hxx5uymkh/213+jL6vEYkERzagFpcfKHqPlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ATBYfYWx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso33004015e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722417818; x=1723022618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OYwN5MjEBSeoQjDIzRVvPm6xDaGyWZF+RT3AaoJJAzw=;
        b=ATBYfYWxk2G8tCCJvny/W+l4d79+iIftIF1JBktCpknD6lQJLRu+qx4jw8IVOTOVzE
         GjU87aM+T0Y1sgjH76u4le8yek1JtnuZKR4jW3lwpVit5ccEVSq8K2mo5QbYUs0h1Eal
         fou1BIRyihIjvOqc4k1eMGvbTaknfCMZbpKYt00qSwQiOkhmKmfT9/S33YFWl6hJPnIQ
         lWKV8p/com8gEY/n+UkC4rQMSyYSL7s0niM8BGmCodezNWiesf2IVEHHxq0FBlz0cvI9
         HWhEIseHk0F117B4euOuIjOT7dJxaE/u/zckSYcFNGYQBPzOzXMLwb9siBoiuN7bCGhW
         LCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722417818; x=1723022618;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYwN5MjEBSeoQjDIzRVvPm6xDaGyWZF+RT3AaoJJAzw=;
        b=C1kj+d3K8/+vevj8J73X2j5RRc7cpVp92P2YlYRhQ7+/aopBX4DNbp9NzS6fIrsy8M
         E+oFSzx3XxW+8YfFqirpSVTgJPT6rfjUS3EzlVny23YCRzeRA9e2J1tjnOIPlVGTPbGf
         F0ckg2jSRrH+gHm3TBlX4j9nqUIiEo2BWx7jcm3tGN7sx1EGlxSUGIcGKprqfhq1jcl+
         y0bHSKEsm7Scaaj31IEN7HagigfYkzAENCzKhHiAcyVy/aA4csZsPZ6pEz2rnvXkB5OC
         7cqtPwPB/vabODq8dsE/qio7xGycKmIq+Dhpj14QwhkSh1lEQvEjek/TOppBZcFye0E2
         dIkw==
X-Forwarded-Encrypted: i=1; AJvYcCUJrOglxwR+2a1Ac+oIcBS1BKFYfPCCTTeoGw+/CB/yJxFGrvb2ZgF1h9FfQtUUdoxXRRePWDIgJbdA7HtTF5q+WOmkHsXXZNOpBDxt
X-Gm-Message-State: AOJu0Yx/MGMKIaysVUjHY8cu8+Aj2eJgHjyD756cEb+DE8QRRDvNeu7P
	J4IdInaGzQwQdyy5IHJxjn8/rJbAUlH0N3CwlYq2/6s0WrfDJJLLhnmS9mXjOVg=
X-Google-Smtp-Source: AGHT+IF4JHMSeZ8vkb1ZjOKA3fcDGdnkLPQWowPFjD5J3rmIrOpMw0hfjdzoP7xbv0nreqx7B8bGmQ==
X-Received: by 2002:a05:600c:4f8e:b0:426:6551:3174 with SMTP id 5b1f17b1804b1-42811dd480emr91381455e9.29.1722417817657;
        Wed, 31 Jul 2024 02:23:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282baf302asm15176045e9.33.2024.07.31.02.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 02:23:37 -0700 (PDT)
Message-ID: <1e78eeb9-3280-45ea-9d21-92efd939efe7@linaro.org>
Date: Wed, 31 Jul 2024 11:23:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom-bwmon: Document
 SA8775p bwmon compatibles
To: Tengfei Fan <quic_tengfan@quicinc.com>, Georgi Djakov
 <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240730-add_sa8775p_bwmon-v1-0-f4f878da29ae@quicinc.com>
 <20240730-add_sa8775p_bwmon-v1-1-f4f878da29ae@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240730-add_sa8775p_bwmon-v1-1-f4f878da29ae@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/07/2024 09:16, Tengfei Fan wrote:
> Document the compatibles used to describe the bwmons present on the
> SA8775p platform.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
>  1 file changed, 2 insertions(+)

I admit I don't know what to do with all these sa8775p patches. I am
afraid now you say these are valid but in half a year this will change.
If I give Ack, I feel like I am agreeing to such approach, which I do not.

Best regards,
Krzysztof


