Return-Path: <linux-kernel+bounces-433644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1B29E5B1D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7D818854BA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F343221465;
	Thu,  5 Dec 2024 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w3lwyvht"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5221C221473
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415320; cv=none; b=hoDsb3nZU1UNv19lVDH0uWr8orwFEt7VHxlBPD19u82Av8JP81iRAX/UGk00iysANbUt2FgCRE9Fh34dBvntGYS3FjTSaDHJmobORBmmpa8SgvE+1OaC4YtHh8py2r49sRXGu2UsEBjjZcldEGwyA0m2gi8eAqyl/bXDhoBvGvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415320; c=relaxed/simple;
	bh=+3gG4uJcVlIlPvsLI7IW3b/75AREOrmUQVixXgnblsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMIBsBO3/uotD9jnlplOZvyvglK7urxOxckGfn4L2Q4Nkfk5vwASq6TovWylKeeRzAOgPLp+GHeYyyoN48waUy2H7RrUofB+3B//0T+97B9b3ABgH3UgKw6kmwYU8qqAMXMTzLSWeuYP7BrrZAWu9NNCtKrPP3OzoCyo+MFTnFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w3lwyvht; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a14d6bf4so11543665e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733415317; x=1734020117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+4sz3zUp9yAyBKceZM/QXuubslWEL7HdKcdLFSmW0E=;
        b=w3lwyvhtO1pjEyuF7+RCa07bfIDjKpD0CrUI38Hlab/rZnqp6e5LTBu6WY74hOwJ5+
         ep0fp7rarwiDxyod8Q/c1K73vijnVZ9EJSVPdfWD9xtxBObEOy8l16MFeddgsmwkLgz8
         BEtkm2I4hfsO3/7XSAs2Ki5C9EzkxfyACz1zsTrbk/GscfOhjItB5MQ2EnI70/LphnXL
         83xxN+3YbRVT0Vqdq0dtvHcI16vcdseBn07pm0xXXMh+iLj/5JivyRmIEeOQkdzIqlYT
         mwYDe5gojD18uTHE8E7pxoO+mDCh9Pu6ZwT8ArWkD5KW0iYdXZ0uMwl2ddDIosXtb7+G
         nSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733415317; x=1734020117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+4sz3zUp9yAyBKceZM/QXuubslWEL7HdKcdLFSmW0E=;
        b=wSYMlDWfL0f/cn4F9Jc8PXGApUtmKrYrd37O+peytMIx3MoYK6eOKDks6vK+hiJGns
         3TxbZpmK6KXXvJdZ05xcyWrpQk6RRqCTAboaqTLMqMZF+jyHrtEPpsvCXvk1WSziFOYV
         S+oYT3dzFze3OdjqI/r48OuaQ3s7v6Fdln0LwzwU6T/ODqP2yGC0+5AKX5TITLggzPs/
         OgmCXipJHger2jBwZk4dcnc4GOPBXv2/dqhzT5bDUKaxYOIlpWLFBnusaM3E8hb0TmHP
         WKoqDq4L8TkE1jf1uvE+8tPuPOd5hmP8CAUDrer4nqt04zaz+7rGBMZhCT9IFmmyHiJT
         E9XA==
X-Forwarded-Encrypted: i=1; AJvYcCXv7tm0pXCNgxjn69te4z2p0eL1DLWaj9kA5A1u6ml8P5CIa08b7Mm/aAD6eYHyYHxS4l2Oz//WtlZx+WA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtAviDzToAbvPkp55p16d13xPlsKKI0zQTXxHKKUv+bGnyw1b8
	UQ3nA6RzKV0uAuhJZwukzHyYt2x8X2T0gimxPR1/Y4XoGny6jGASSo62AY1qTWE=
X-Gm-Gg: ASbGnctT8DD21M9821uIlJWt8RuJFM6tmp80oHCeKX7TJoEuZqClDdl68gnm7CSZ9Xg
	AzT5Apgkzja+YlvVvlKuu1RMIAYoM4eb3VGrCmiEo/GhLOWyCY170p19kP4Fqw4gyqjb1sSr0EP
	ynvc93YVYwr4Y4gglPphraEtIOeZT7kCJALkNF+/sBaK0fxbAIAApMamstJcDc94YrZe+iSD6xM
	is3Vxe3eMqP/53xJfLYa02GjiH4xbMXT8LT9Jodt9+mWKqRiwjhEtzFarA4uiQ=
X-Google-Smtp-Source: AGHT+IGn7Hvj07Cs0jWrqjLNAu3oDpw3AlP4WiWdrNwS4OjjHvXSuA/a+BBjhbpaScxT9yE28vtaZg==
X-Received: by 2002:a05:600c:3550:b0:42c:b1ee:4b04 with SMTP id 5b1f17b1804b1-434d0a0ece4mr77886305e9.28.1733415316729;
        Thu, 05 Dec 2024 08:15:16 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d26a3sm28879855e9.1.2024.12.05.08.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 08:15:16 -0800 (PST)
Message-ID: <85166c63-1e8f-4f80-abb7-5426383b4641@linaro.org>
Date: Thu, 5 Dec 2024 16:15:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] media: qcom: camss: csiphy-3ph: Add Gen2 v2.1.2
 two-phase MIPI CSI-2 DPHY support
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, vladimir.zapolskiy@linaro.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20241205155538.250743-1-quic_depengs@quicinc.com>
 <20241205155538.250743-15-quic_depengs@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241205155538.250743-15-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/12/2024 15:55, Depeng Shao wrote:
> +	{0x0E90, 0x0f, 0x00, CSIPHY_DEFAULT_PARAMS},

Please uppercase your hex.

---
bod

