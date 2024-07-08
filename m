Return-Path: <linux-kernel+bounces-244891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFD992AAF3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284C51F22983
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161B714EC55;
	Mon,  8 Jul 2024 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hrz3z6OW"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C4E14372B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720473350; cv=none; b=cKvhZu7aEfaLZScJcp5dKOXHnOmoL+YSvUSJfH3rTXjntIC0cifJ2pZbY0LhxmlrjNst01c9ilocxXuFj+zNYhN4Er0hMQEoaanL5WddIM6rZMrEiirDivsRstmOokUEjbr9Gj6Bh+rl9H6AwyLd+8PAcNKqpYX7BKh8MdTORKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720473350; c=relaxed/simple;
	bh=rhLMzhnBr1fmJn4hsQMzNNrDyhSsV9+nyDHGBNMD9LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/xeIUU8C47YoyyRffERPr3qwAu/AAP0adUrfQSPJZvOMyAoicvLzHy26wQhLUl4N9ZfZsPbUkrPOWDkNnFRSou3fEiXhLRcbWL3tIlZtollcBtN8KQ75zMtcRXECgYRWRDr/k/ll01n+Dt8XxN7Gdj3gybI/5BksLmQsbIqnV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hrz3z6OW; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7035d5eec5aso1702067a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720473347; x=1721078147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0uy9ikK6i2ce0Lmsca9PL3vsPP0xYz4tW9STZ+9c+oE=;
        b=hrz3z6OW3ATt5CSB4mfO5xjFlxqwUs6Lo/q/HKft1Js9CilVhTs/Y4SGBf/dIqNMSq
         nsCYuBpZRNHDb9jyyrez8V/6qZMgIHz2EZn3ORg2SB17NxPMPKmWYhd66/LrCbQfbS+E
         /JVYjpIfQwnE3PxGZfvNddZSnCFoyOmFeiNfmcJVtvuV7tvADNdkJQraZfk3Xp/xBQyG
         F4HnMoaVRTkL7VchWJNgQq7VHxxTaG+AzgsI/xdwSLcod/x2s4UMHngt7frp2WjwytBm
         b0RcZTcQlbQ8eHGAHpLRaPEQeDkbh1UyP1KRIWQzf5hYlwyFA8RhR8e6gJcNd8KbmnMZ
         lxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720473347; x=1721078147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0uy9ikK6i2ce0Lmsca9PL3vsPP0xYz4tW9STZ+9c+oE=;
        b=V22VqTR+LmZW8bJMeftoNDGZVb2mg/5tyIVxBSKfKt6DqcwzB5OXGvoiA/82KuUFvp
         Yt/HwDq05Gj4xD7yv0AQNi4JEKSdv/tocwIE4Nzscqc1NwE+zW1gERiREhci2rbj7ZcR
         GxLb3VfdcesthyjfVFNi8ATjMdtX96D1/w4SkxDtmPdzeeXDeM2n23BV5Pfavb7kMAAu
         ayUfa435QqkNPyan3ouhy9qW2Qx2sjU3WWOlC4O/1flYpT7ojsOdpDksGl+qmRVv9pFv
         UNgsRObXf3dGSRr9PxS3HPyNAJhhc+CzSXuBz3UhIPtYYT3jaQ/Q8UQKqxn6iayDtdIL
         pDew==
X-Forwarded-Encrypted: i=1; AJvYcCUYeOOrbT8e+P3XqPJl0FHwpVb1Fb9FGufPaKr4zFnFFDveq044Bil+1koBnppxr3QSb09Qm9/y4a+aECGxHJRJ6hH0hdpzoFho2jGA
X-Gm-Message-State: AOJu0Yy4/ApKR5YvbT5n2yz0NKN5FQ/nMAuzn6jEW/fNmBPQ9UBCag/n
	zf1y2R1RaxdV1hBaFTqz/AWqP5p4mdzzJv+msBy5XHtsk8l9gdOxIwEyAupYq9c=
X-Google-Smtp-Source: AGHT+IFCFAiZRzRwOpzCyq4dZt7m1IKHP5ZbEcsTgsYyiNk5cHylYqzh4ru8zGjJ0H54yTk3AdBIWw==
X-Received: by 2002:a9d:6316:0:b0:703:64d4:8e12 with SMTP id 46e09a7af769-70375a06a12mr723275a34.2.1720473346891;
        Mon, 08 Jul 2024 14:15:46 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374fc0af5sm157297a34.62.2024.07.08.14.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 14:15:46 -0700 (PDT)
Message-ID: <bc88e0c7-516f-4eef-a9d9-ce0250d6a570@baylibre.com>
Date: Mon, 8 Jul 2024 16:15:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] spi: Enable controllers to extend the SPI protocol
 with MOSI idle configuration
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, corbet@lwn.net, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
 <7eb23146ad6bf6090183c6340e4d59cb269d83a7.1719686465.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <7eb23146ad6bf6090183c6340e4d59cb269d83a7.1719686465.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/24 2:04 PM, Marcelo Schmitt wrote:
> The behavior of an SPI controller data output line (SDO or MOSI or COPI
> (Controller Output Peripheral Input) for disambiguation) is usually not
> specified when the controller is not clocking out data on SCLK edges.
> However, there do exist SPI peripherals that require specific MOSI line
> state when data is not being clocked out of the controller.
> 
> Conventional SPI controllers may set the MOSI line on SCLK edges then bring
> it low when no data is going out or leave the line the state of the last
> transfer bit. More elaborated controllers are capable to set the MOSI idle
> state according to different configurable levels and thus are more suitable
> for interfacing with demanding peripherals.
> 
> Add SPI mode bits to allow peripherals to request explicit MOSI idle state
> when needed.
> 
> When supporting a particular MOSI idle configuration, the data output line
> state is expected to remain at the configured level when the controller is
> not clocking out data. When a device that needs a specific MOSI idle state
> is identified, its driver should request the MOSI idle configuration by
> setting the proper SPI mode bit.
> 
> Acked-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Tested both valid and invalid combinations of flags and saw expected
behavior/error messages in all cases.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Tested-by: David Lechner <dlechner@baylibre.com>


