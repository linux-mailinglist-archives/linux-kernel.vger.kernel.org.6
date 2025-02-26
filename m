Return-Path: <linux-kernel+bounces-534405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E8CA46659
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757653B0831
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D5C21D01B;
	Wed, 26 Feb 2025 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kpIGGbbm"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE18F21CC66
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586484; cv=none; b=dFbbkJZASq73wKk/+955z4Kf0d6Y8WsAnz8o4YMpSc5LxmquqRPQRpx1WyunV3cj7Ai6BH5afiXq11AeciqAmTC/usvGkrk7IsHv5Et6ou2Ukog0jGNytOkhiECYJYJsQuvMgq0Trfuu9QIXw4FvIZC/RSGVNkSAcgRPU/49MIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586484; c=relaxed/simple;
	bh=YUF09IcZrXY2wJ5Q8XSoqYhVJAYHJpb87FaMoFZMtBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YvfBq0mSks5TQndfTEerlAgKUkclqoFQXKokYfVDzLLtOh1pp/358Fz6HQw9S3p3k9o3e/YM5lRML8rhj/sKpj9+n7SsOe5u2FNiuiCs98UKkvt4NL7LMv47ej8QalgT5fLo4PItVDDesnBWwCoyoQgug4SUvV/oKjBO77Yw6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kpIGGbbm; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7272f9d216dso3778120a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740586481; x=1741191281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=drFcXyyb+twCj8LLQJ+8ciOWTD1LqQ7TVcLVAV9+OvM=;
        b=kpIGGbbmw4G3yS0Lic3Y1if8x85ykN5aT90HCXwNat6XYD2OUDfKtS+izRyO9khd3P
         GsUZPhBwK8AhnLmez5PF7xNhlho1lzw8hu45rOL82+dRZEkfqbDV/tlwKJWIdaFWUe0F
         ff7tDrZTk45VD12J1vi1KJ/uyH1ueZOfq/BAsZL47m7J0eTAAObGWGmLTwwZJwrvmAWq
         BdIvdFg3SQ8+EOaW7XTWS5aYTiLd0meNfDgZ0pAdBegtUQzi7OoC0vy8sBnVDwvbAoXi
         wgSOdvUoIYndW10mM9nsyBhflVlrI9gIAg2Zd3O6bSvxqEZyqqoMa1+3Jz0zgrgrVJkm
         Zhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740586481; x=1741191281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drFcXyyb+twCj8LLQJ+8ciOWTD1LqQ7TVcLVAV9+OvM=;
        b=AYf8qxQPDJR4O8A0qvV4Q3FcztwCcPQe6U4FxzyOusmjq7rf697Tzeb1gRNcld3Yux
         cRRtCJBTtrNaMTxEK+w82f78FT2WAWOkYdc4k6g0sHnZoTKeqO1Vi2s1lrbSViLgsQSU
         9UOXjTs7AKB5UPB8v5PWF/hTuiMG7JnHfRbmfNCcPieFs+/Ro3vgmPKvYrRt09aX8qKv
         dZt0JOS0SXhPNDVsDdK5YLEs9RE4SWv8Hu8b0x6W/6E0q1NjRGQz758+9ZJ/16P4UBlc
         /6pljsQucT7u31llEJzfBSJdHaZ0IOyQ+VjIazeOKwLgmHZlMQDstv713gYWEFJ+tXEx
         JnvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsAUXT8YZc679qYEnF4kSoncwQ6dA3GUrwSuBihoiuhP0fVJhGefzKJ3upXUjHOc6bTkPFhQTK232fxUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV66Ityfs4gJVv8stc1xzbwwTeXdndwoagJLcxPV1lyhgUfQ+x
	0CNTdxwsnBbTDFe76WDYwN42JhvX7cKP1dGASFZHAFO3SPmyEuUfB8POYG7vQfE=
X-Gm-Gg: ASbGnctpy70XhdFYGNSd2fEhG5cZ6MQxOaT6C9f+LNjAzGAJoqtGg1cfJknD37BXDaU
	Xz6mbUcSHlzpUamcYRfId/o5xpgfXKR84O0KV7ggF0cvs/ijX8o96rFNmZkhzJkpr/H0g1FRL+z
	PxsMxmvL/fKoEnLyRQEQ+pc3cY/D1FYRmsUC1vtmPb9NT0KggtAwrXbaVjzElcCdmecXOKnurKS
	TliNDTZINW/HNxYe/Nb2FqqqyjqX5wrtDg/1U/n3g7aoMKvwelIQQxGWCKCFmOD7xo+mIdksxeg
	CkynEu62oLCLMfDgcdxRl4+vgqL4IKv8sl+Anng9jvnbQk0q04xaBhVBAMcOicM=
X-Google-Smtp-Source: AGHT+IF8NI9+1TFgCQXZV07Lfd20oHa51d15isLN6a4AtwGJl5WnwIxcHmu8nhk4CUGmWxBUTRSMEg==
X-Received: by 2002:a05:6830:6706:b0:727:f9a:8aea with SMTP id 46e09a7af769-728a50c73bamr2345843a34.4.1740586481711;
        Wed, 26 Feb 2025 08:14:41 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7289ded6e56sm750702a34.8.2025.02.26.08.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 08:14:41 -0800 (PST)
Message-ID: <5ad1f95b-ef0b-4e65-9e31-a8166a8e90cd@baylibre.com>
Date: Wed, 26 Feb 2025 10:14:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ad7380: add adaq4381-4 support
To: Julien Stephan <jstephan@baylibre.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250226-ad7380-add-adaq4381-4-support-v1-0-f350ab872d37@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250226-ad7380-add-adaq4381-4-support-v1-0-f350ab872d37@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 8:50 AM, Julien Stephan wrote:
> ADAQ4381-4 is the 14 bits version of the ADAQ4380-4. It is compatible
> with the ad7380 driver, so add its support and documentation, in driver,
> doc, and bindings.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


