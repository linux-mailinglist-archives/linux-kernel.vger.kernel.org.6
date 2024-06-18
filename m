Return-Path: <linux-kernel+bounces-220111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C0990DCCC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C601F25BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACAB178CE7;
	Tue, 18 Jun 2024 19:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C0hE81uU"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623091741FB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740060; cv=none; b=huIJwiQK/XGi/YxJ5FJJzlTgZjnVDKk4s9rIyusDnPlAWdIJ4qjNR8QPz17Qpx7IPiTIKVZJcTUeKKxerR1XTh2IJxw3JSL3zo8TAH/njUJnwupqiPnLHticab+pN+UwEuXUsUQgc6gEp9QX1JqcHBYTncrYIohhblch2ufawF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740060; c=relaxed/simple;
	bh=80bOpDur7f/VLqFOdk85Pc7ZTNvF+5oggXMjPZy+ow8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hG8YWDz6Ggz7gOqjz8MJ19VN05azJ2E5RSEzkXOytd/cZrYmYy5x92ytBtscCBr9C9FgFBdP/7wOm6hz77TgYmJw9xwZG4YzxTsLuM+ryLf8rk+Il2JN4uXOQh0jdZ1KHq7AIsl/SWEAY1lm2Y3SyjsqhcNGZOPRa1xucKipqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C0hE81uU; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d4430b8591so963019b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718740056; x=1719344856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8HJKNnvc8aggx0Ee52gIMjiePYGprFwsF/CuXFArkqE=;
        b=C0hE81uUdTeffw5oSge7mNrryhFeGmsy9ITK9gvX+9vrWpbr6St80ancopEYtsRQv9
         aZ6U9mrc6wRD43Py+NRrto2+0nJXxmuXfeWKU2KOaSTrq3CTLPZs7mKMGES7TB1+K4eh
         aDqxdZ2hz0U7ohZ5EY1YGBkeE3AT8JUXeV9wUA3ArzRELAGOjibmEb7cxw5Mh5PY6e+Q
         WfkiBaSa+952KaqPVb7fIieJXa11hMJpSLHNeNoIdddOfnPEHpf9uE4dHaLLxwTEhGqg
         5Qw59ida3/oHcpLaaqfga0++nC7TwViwUf04aT4D4FKypLmxBaXxKMvKt/X3FDtnq+y2
         JTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740056; x=1719344856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HJKNnvc8aggx0Ee52gIMjiePYGprFwsF/CuXFArkqE=;
        b=X2V2+8mal8I6pDfV7EaKrdul8u4tphbKXK7cGtFtSNvfnzbSaDttdiKSDK8uwV1t08
         4CQVJHugsepcWvIs4tFliFWJHwWGRlPbeG5f2hzFzqCVTz6c+VQUshhWyMfk8lB1lUWp
         pJXgxskVHUsl3dta6Sz4hfcLokeDApsETeWvl30U2dg1d9tPOv591KywSS4DuyFO2XAR
         JaK/TVYZ/uz6SDdPl5SOSuTDDU4KXw+YkbUTPv9W9G0KX6vaJGkQzTEx0xXWi/N8LMnu
         s4XxmTFFIHV8I23J3Oyaecro1U4A+gzKT+O8z1jg6msQfLTIcVSkveHvflv8FsivSE9i
         pCgg==
X-Forwarded-Encrypted: i=1; AJvYcCVZYmPOhADeS1OUcG9Yjk4lZUYh8lhtOT93Sr4PTIjZrsa62MK3svcoBdhrlbj4/GM5e7V5f6Y7OfIgnr1jOBoiDEnrv6c5xyl/qiVf
X-Gm-Message-State: AOJu0Yx3C52+iS9AbEtAfnMWJboNaE8Xv1hrI3BTwN7njhUREAkLEZys
	TCrUFsFS/mm1YAb6ueN7ErfoZsa2vTaLnaozm/T4TIfKIkzfXuixaVmqxC5eGvo=
X-Google-Smtp-Source: AGHT+IFoPn43lF+j3aRcMTC4F1x8qcmNWprQM/JcNVkz3sSPT6L3Dvzuqi3I5g9gcSivGrFlNsc0kw==
X-Received: by 2002:a05:6808:1705:b0:3d4:41b6:6c4e with SMTP id 5614622812f47-3d51b9b86a6mr867052b6e.16.1718740056313;
        Tue, 18 Jun 2024 12:47:36 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d24762b9a2sm1881135b6e.24.2024.06.18.12.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 12:47:35 -0700 (PDT)
Message-ID: <78dd5a21-911f-445f-95a0-4ece55b0721f@baylibre.com>
Date: Tue, 18 Jun 2024 14:47:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: add common-mode-channel
 dependency
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240617-iio-adc-ad4695-v2-0-63ef6583f25d@baylibre.com>
 <20240617-iio-adc-ad4695-v2-1-63ef6583f25d@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240617-iio-adc-ad4695-v2-1-63ef6583f25d@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/24 2:53 PM, David Lechner wrote:
> The common-mode-channel property is only used in conjunction with the
> single-channel property. This patch adds a dependency so that we will
> get a validation error if common-mode-channel is used without also
> specifying single-channel.

It turns out, this might not be a valid assumption.

See https://lore.kernel.org/linux-iio/20240617-iio-adc-ad4695-v2-1-63ef6583f25d@baylibre.com/T/#m7b921cf9a7deb4a4f02dd2f05668a3dd99232ee9

> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v2 changes:
> * New patch
> * Depends on recently applied patch [1]
> 
> [1]: https://lore.kernel.org/linux-iio/20240607-ad4111-v7-1-97e3855900a0@analog.com/
> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> index 8e7835cf36fd..5baef30104dd 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> @@ -80,4 +80,7 @@ anyOf:
>    - required:
>        - reg
>  
> +dependencies:
> +  common-mode-channel: [single-channel]
> +
>  additionalProperties: true
> 


