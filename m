Return-Path: <linux-kernel+bounces-428467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4669E0EED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 624A9B27D35
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1B91DF97A;
	Mon,  2 Dec 2024 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Hf0VthXL"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8DE1DED48
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733178338; cv=none; b=qHZyMDtxEqyCOQcllm4dT40IPgO3TKIX9A5eFG1ojlIZJmxTbyMHbfIh6sA7cwZpIM14qluOerhv/Mfo2e7ZW88IZbmzwiWR12ExmSIgUc1T1Gw3Cp2GalzPjsu7KNbfTscOkO8QEVbvI9kttNdPTAHfF1mDDyuuQCMUnjC+7M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733178338; c=relaxed/simple;
	bh=5FeWdKTT/Kl2lGbJ06Y8tF42fvPEW7LRdGOqragRJJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4gquX5zH4SvCLFb5rqOECnGvLSLB5Tlrimz2jJOeMTuSJeoslFoJT4ErmmRXqxBGxNQgU5tIrftaJoKFfv9q9/s7/xwNa66xMuerx4uYgczMdlb7eHUyCURNoT6GzZHnUVwwkDsNxuM8KlScVcZdpWg8jmltsarZ6/zN8EWXp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Hf0VthXL; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-29e65257182so847152fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 14:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733178335; x=1733783135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yhe+Y9KpnQcbiwEqC2RxmdyO+5PB6oqbLiwhpO9OfcI=;
        b=Hf0VthXLc9QBN4a8b2b5I+YXjt/xP5FQSRDa5aBTtFS5fGHFIjAmMnn6Xjy2kvcFFC
         XezjwoYA+DdTOoOeKj2RYA0dRLl72oicP8a5eLD49iNvO5OGCUblssg+INtMOYzxzVDa
         JVtSRqzlKdo5L7cu/L1AHemMr2EiE5pP1qP45kkrt/QlifIAHx+KynzR62kuiX0RxVo8
         DCVN5PBqFycFa8me0nP6Mme21Bht1UUl0mZnORdgY8GhpTQkkoqxfMogwuKgcmBsvRkB
         koBEJtazWV9U5Ap1AIFFYFUgDFZXpE05RmqsmHGrMQQ4OLWfspmWXWZNDK6E4Jrj9EEW
         npTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733178335; x=1733783135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhe+Y9KpnQcbiwEqC2RxmdyO+5PB6oqbLiwhpO9OfcI=;
        b=oftgCBZUtgF4inOEyGPRAERVbqMmYIpEsWLQLP3MWnJxVCTBhuoN6CB2N2x5Oa4xcS
         VJ2qTFeflcfL+bdAtjZYMjr5YK+oy8K9F5xEeLc0nQAvAxwYnsBMvUFQ5lqNTBil1CVp
         X5kVyzBDX764rJwNR1eiyz96iAAYQij0S1gWQ3oVYYJCy3Hnso+00bwkp0bGCLytGF0L
         EOBruPDdTeLXJpx9a6WetYETUV6ryEpHdG96e4qodD6NwMjXWkpdfWpQpp+ljgHyGzYv
         IdhPHaLbMJ8Znz6MrGDUa1RK/6nr3w/ZK/qXP2yv8akE2rQbt9iNvbSo/cqjHvmxkDH2
         NQFA==
X-Forwarded-Encrypted: i=1; AJvYcCUhI5IwiFGEuZiSI9N17RmdqBoObpfnQ398UgZyTWXG+d2RGJVgqt9VomcHzks1BMKaEiRobZMcZ7V5LtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+8G3TJNT41ilVesiR4A5QiJUyfFHBD9Ihtb77QLr/JWtLA4m
	ybxPVABbdsVJXjnK4y5T+2dfXDgLFh1pH1CxDNKjkS5lZ4jZU04wYwTXreNA670=
X-Gm-Gg: ASbGnctVTamHrYK+jOppjhgl3lTf5mqkSOw/3dld4mF8YWjJqbxtyitr2AzLJmyHwvG
	rvAnrXKWplOYuVvFsBSUu7zhtXUDv+/9tmIKUTj+nCZDBc2ZhstR3wkbalwWL1yMC5Zks7XBrVQ
	jQpxXEAqfZW/KjgzMzPW8s4xrqJUxvGG8EaoO1eIbWOyoVDh5e6Txb0VPrkIterZgwor8rgzo8w
	UdIxUoIPYIhfAyb81VgU2Sv8eYmSwrS1JdhDpMrnAbkxQ75ttOP8dFdJfXUv2X1IlncQfNjljV3
	Sd7Yat01eoQ=
X-Google-Smtp-Source: AGHT+IFeuI/nJ53p25gQt3SeEy0W9rm5s/8s0AHvHNdnQS3wcS/sGrQgMgYd4xQgK7v8g31Y3F8t5g==
X-Received: by 2002:a05:6871:42ca:b0:29d:c624:7c3d with SMTP id 586e51a60fabf-29e88835d82mr88674fac.32.1733178334926;
        Mon, 02 Dec 2024 14:25:34 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29e6b1a71e5sm708382fac.32.2024.12.02.14.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 14:25:33 -0800 (PST)
Message-ID: <72a86649-7a83-430f-a47d-39f71f2e5f2f@baylibre.com>
Date: Mon, 2 Dec 2024 16:25:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] iio: adc: ad4000: Use device specific timing for
 SPI transfers
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com
References: <cover.1733147443.git.marcelo.schmitt@analog.com>
 <a36fcf44cc00b2a498170e2ae3f005829d516266.1733147444.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a36fcf44cc00b2a498170e2ae3f005829d516266.1733147444.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 8:08 AM, Marcelo Schmitt wrote:
> The SPI transfers for AD4020, AD4021, and AD4022 have slightly different
> timing specifications. Use device specific timing constraints to set SPI
> transfer parameters. While tweaking time constraints, remove time related
> defines including unused AD4000_TQUIET1_NS.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


