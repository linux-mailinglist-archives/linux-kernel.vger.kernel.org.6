Return-Path: <linux-kernel+bounces-402223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853589C2528
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46DA4284C49
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925471AA1D0;
	Fri,  8 Nov 2024 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nzmO7JhZ"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D58A1C1F18
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091960; cv=none; b=S9DWPUMiIL3ewqzhbJAIjj8TbMIvBV02mtfddXACpBd34pxUaQbNVhwB21/6aHf9WzziwGAN8g5rQvt/p3HjVqYXd5Z/CimgC9fhdVu0w4iUcFRvleCpxGTTMKlaq6Oea5wsA6jjXe1aMG1APdQpQZ/PhNQxCELSRTV57Sm3qqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091960; c=relaxed/simple;
	bh=K41BlZGcmnvM4Q0mGkBK9NaLG31prveDrn3itXDZS+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxT6Oxa57xJ+f3S4KY75mcW87Rxw/9NeXe1cJSEMsOoeeDNGpVxNilCin0rN+aqXIzvNNNV9M8GDNsXVO6NpS3S/92EBnCwksCvzPxlpZQ5shWN/YpJQ5S6iDqP1GoYcTCjQcvJFkL8b+0A0UkQGKlcXYX+1W0OiBREXi23OEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nzmO7JhZ; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-718078c7f53so1187309a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 10:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731091956; x=1731696756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K41BlZGcmnvM4Q0mGkBK9NaLG31prveDrn3itXDZS+M=;
        b=nzmO7JhZLe/HW2EfIK3nEq3ImKTVysINMGbo4SPEKSXNwDM/NdBPd3rT1W3qvtZObO
         RbiI3UEIyWjj53yPdomCffFjDHRIGYb2Aoc0nIkzTM/hnGm/aROGnBI0zv0ZSx1dDYYN
         6InSEXDlGxeyRctLcSxT2+1S03g1HeWN17urbmM0yCuFAJ3DN+kGroe9etiefJgCA/gS
         hGO6U+9UNSDhXyVyg5xPdDW+M/yfGCp4E4mQvd+IGgtxtzK5/hyVMDYBajLUo07Nf20I
         wt/Nhtx7JM15DPCeSm0OP6qICKMv7jrGx4+ARhJfFj3tapofvpFKjB+nut+siAMOnVja
         1L6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731091956; x=1731696756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K41BlZGcmnvM4Q0mGkBK9NaLG31prveDrn3itXDZS+M=;
        b=pxaGl3c0gvNVV9KjlKsYlyIZ8yR10XAUEuz0VYE+oUmWLMf1RWIQdEWeQdknl6ZyqF
         HJ3zysag7cFtmnKMBmzAf+KfeXpyvgob+2P4msqAA3jsUA6ud7OMhOCibwW0ogaJ/g8T
         1HdSid2CDDGPvV74eIclp87OkHQhFlcYWraMEWrNegfj/CutOcqUA6f4hv4XZ+rLLSyB
         rzZ47AFSCOhVNMelWTxdt7PpvsMhLEz8HdwyYLIfH+brp1pF6hlsOEBFVICUJhgerkA9
         l+BwhSdPMS8sBzQsxBy3jrgg+leSFvwSbiYjLCsQ99EuCiw/beIlOdjAp/tFwIkLL5sb
         0acg==
X-Forwarded-Encrypted: i=1; AJvYcCUa/V3ovqUMzFrfylGEEWAb1qAZrS0I0lx1MJ41qkxOMZd1Q1qHLpzYuiklWBehMyjtdwqdWsT9BZI1wtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgH+08qLtJJ5FhHrIFOVcg2qXI4QCvKgMYn/zvcDCmoqpA0qWZ
	rFaJYowv+g0q3e9SMsNQ2FNZF/ipkE407K22mwNK/x63kHZD5y+pUAWWGlb6cuE=
X-Google-Smtp-Source: AGHT+IF0DH5w0O8qGmV7ItcTdtk3yqOpvqlRHr5o7hKhhog17Xm0CS/LMT+4ejr7iNhY4pRAQep4iw==
X-Received: by 2002:a05:6830:65c7:b0:710:f22b:c825 with SMTP id 46e09a7af769-71a1c9929eemr2746247a34.1.1731091956557;
        Fri, 08 Nov 2024 10:52:36 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a1080ecccsm855297a34.18.2024.11.08.10.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 10:52:36 -0800 (PST)
Message-ID: <c94271b1-924b-4de6-b3bb-77e16265bb0d@baylibre.com>
Date: Fri, 8 Nov 2024 12:52:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: ad7124: Don't create more channels than the
 hardware is capable of
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Mircea Caprioru <mircea.caprioru@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241108181813.272593-4-u.kleine-koenig@baylibre.com>
 <20241108181813.272593-5-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241108181813.272593-5-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/8/24 12:18 PM, Uwe Kleine-König wrote:
> The ad7124-4 and ad7124-8 both support 16 channel registers. Don't
> accept more (logical) channels from dt than that.

Why should the devicetree be limited by the number of channel
registers? Channel registers are a resource than can be
dynamically assigned, so it doesn't seem like the devicetree
should be specifying that assignment.

It's true we can't do a buffered read of more than 8 or 16
channels at the same time because it is limited by the number
of channel registers available on the chip.

But it seems reasonable that if there are more logical channels
than that, we could read 8 logical channels, then disable those
and enable a different 8 logical channels and read those by
reconfiguring the channel registers.



