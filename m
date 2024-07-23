Return-Path: <linux-kernel+bounces-260040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3027293A1E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63251F237C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984B6152794;
	Tue, 23 Jul 2024 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AW8jZL4C"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C858D1369B0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742487; cv=none; b=GzMwYib5zKRMB5RSu4BbNdUZ589vXcZm0la24inIXf0yjnz8E79MJbq2CqDC+qZeP/znTgh7asiKp8kZHbkceTpIbanhGbjp9Huaw6+KtHQmSGxj1ZFy5wo6/AttmVZWdV5I4vbCtTVlSHvp16QgBRn2D+b/wbRNlFeX/js118M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742487; c=relaxed/simple;
	bh=wLC84+drlWdwVKDEcyc2HQlpIn8JD+FRk2GS95CTUXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSLBO4ZuQZ7rh5zqTKCFtGXQZCwn9HLQfRjPSHLTCjBbHe3MYdURWwaGWIfGypB17Oe2S7RUQHFU72grYCQBwJ5duALCtdkh8exK7oH/PGYuaTMk/hAytbuYpto94CHqRBYa/lY/I6U+Sx8B81TeMpIqGJ01qCk9cfiOKJ4+xGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AW8jZL4C; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7036ab4a2acso2898211a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721742485; x=1722347285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0YXOXnrdhIFIRlCWz4PNo5db4DQk3/6vTvbcfzMZEg=;
        b=AW8jZL4CRAy6q8PAETfs5l3aj1yQtOdfTFu6RMMhg7r2rGThnkEuw3Lgf7n3sRVpAa
         j8my5q15/zzlAM0SWE5mNQZ+cNRH5H/1EHjUheKoro09owTJy09G/XaAzfW2Y5lUe4MT
         rOlEBPGFkmWHjE/Z2sbgxNqgMEo+lYOzGgtqZXRHNjOmAdrHUaT2E5GB+Vni6g5UTH/g
         qHJha5FpxABjSePzV1iID4uQHXv42PpvEst5uQl0txQmX8OT2rbWlOqVcVJR3G9xCF3t
         5jnf3ya/E/d9GuJNdFlCW+jTYTI16sDsg2Ub5JPUz/j7yY8vHKNxKNIDgnilLT/b9DDo
         dZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721742485; x=1722347285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0YXOXnrdhIFIRlCWz4PNo5db4DQk3/6vTvbcfzMZEg=;
        b=YbFxwRN9CxaLWj6baaY7z6xJfkDfvP1bA8qmt8z3dkkvXdHpFJdyxWq1Z9LU/tk6Vk
         nwm14N3886yWRN7j4+uLnpEGBwIjEiy1B/3D/FDwyw8Esp0ddgd8pzj3NOihi0X4AM/Q
         baqhZdel6MzjyyXzfh9qWU/NKb8J2CVxHTjV/U8FU96GBdUVp/JkYuaIfJp0P7V5XZBQ
         mCfwgUakb4PjMZjkjH76qD9umci1ZANEsJcciNV7pvjN5pSVsFnI5ITJF9REWDJhmhtP
         6/LOiQhW2eJxGREZ5bJtkxCtLr2C6lPz7SBIGuNsVd/SCch1mErxHXjGifcaSeVWMJi6
         bZ1g==
X-Forwarded-Encrypted: i=1; AJvYcCXSp2O8zFU1y5kKL9+JHBpgn6HwAhb0di1usHKDlSdKtkDXOXSoR5cZyuSWg1ETOEo6rLCIwbEHhS2p3Ni+eMrRAuAeZp+TfgkjLLGC
X-Gm-Message-State: AOJu0Yw/cS7R3ChZ1hf/1qMoAiXNck9qL76Sp36/4McurxcdsZBM3jj3
	mv6OVy2Job03iICLu9EqyxGHYcwQ9tT0paK8wlhepWqwzSe7QjfApQMeTFjOqKs=
X-Google-Smtp-Source: AGHT+IFeNUa8Q6yQYiY6Gp7Bcv69p6K29cfx+ZG9llkagfN1y1cWJYdttCHqcIKlE109ZY6nVmDZMg==
X-Received: by 2002:a05:6830:2801:b0:703:5ba3:581b with SMTP id 46e09a7af769-70918096ec3mr3152908a34.5.1721742484871;
        Tue, 23 Jul 2024 06:48:04 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f6174f6fsm2027023a34.58.2024.07.23.06.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 06:48:04 -0700 (PDT)
Message-ID: <9fd9ed71-4b2d-49a7-9432-1747ae2e9aef@baylibre.com>
Date: Tue, 23 Jul 2024 08:48:02 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 0/9] spi: axi-spi-engine: add offload support
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
 <75511e8371f7ffea1ed84a784231f3dc51363842.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <75511e8371f7ffea1ed84a784231f3dc51363842.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/23/24 2:35 AM, Nuno Sá wrote:
> Hi David,
> 
> 
> I think there are things that we need to better figure but things are improving
> IMO :)
> 
> I'm only doing a very superficial review since I need to better look at the
> patches...
> 
> But one thing that I do want to mention is a scenario (another funny one...)
> that I've discussing and that might be a reality. Something like:
> 
> +-------------------------------+    +------------------+
> |                               |    |                  |
> |  SOC/FPGA                     |    |   ADC            |
> |                               |    |                  |
> |       +---------------+       |    |                  |
> |       |  SPI PS Zynq  |============== SPI Bus         |
> |       +---------------+       |    |                  |
> |                               |    |                  |
> |  +---------------------+      |    |                  |
> |  | AXI SPI Engine      |      |    |                  |
> |  |                 v================ DATA Bus         |
> |  |                 v   |      |    |                  |
> |  |   +---------------+ |      |    |                  |
> |  |  | Offload 0     |  |      |    +------------------+
> |  |  |   RX DATA OUT |  |      |
> |  |  |    TRIGGER IN |  |      |
> |  |  +---------------+  |      |
> |                               |
> +-------------------------------+
> 
> From the above, the spi controller for typical register access/configuration is
> not the spi_enigine and the offload core is pretty much only used for streaming
> data. So I think your current approach would not work with this usecase. In your
> first RFC you had something overly complicated (IMHO) but you already had a
> concept that maybe it's worth looking at again. I mean having a spi_offload
> object that could describe it and more importantly have a provider/consumer
> logic where a spi consumer (or maybe even something else?) can get()/put() an
> offload object to stream data.

Although it isn't currently implemented this way in the core SPI code, I think
the DT bindings proposed in this version of the series would allow for this.
The offload provider is just the one with the #spi-offload-cells and doesn't
necessarily have to be the parent of the SPI peripheral.

> 
> I know, I did said that I did not liked for spi consumers to have to explicitly
> call something like spi_offload_get() but I guess I have been proved wrong :).
> We can also try to be smart about it as an explicit get is only needed (likely)
> in the above scenario (or maybe we can even do it directly in the spi core
> during spi_probe()). Or maybe it's not worth it to play smart and just let
> consumers do it (that's the typical pattern anyways).
> 
> Having said the above, I still think your current proposal for triggers and
> getting DMA streams is valid for the above usecase.
> 
> FWIW, I'm also trying to understand with the HW guys why the hell can't we just
> use the spi_engine controller for everything. But the whole discussion is
> already showing us that we may need more flexibility.
> 
> Thanks!
> - Nuno Sá


