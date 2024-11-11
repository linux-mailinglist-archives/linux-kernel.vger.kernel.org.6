Return-Path: <linux-kernel+bounces-404864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3F99C4955
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2FB1F23ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7D61B0F2B;
	Mon, 11 Nov 2024 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XlKi6OPw"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722928468
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731365467; cv=none; b=qsd/+zijsCyQ9H73/fg254ewZw9qeGibOpB0UeIYBdPCalF9HXurJEVweIU2HFZZxVaLkmw0BmfHVwxWRdlIpodaHyWl7odMlhEFyDQKelcFWKGX7KEPjpm3uqrDaxRAAq8xtq0ugeq46c5CAUKrRtaHdjqhUMpV0/Y6ZgY89UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731365467; c=relaxed/simple;
	bh=NyhDWCmh/e17XfKVoxY6SLJ29UtaIpJ+DelPVZzkvOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxTNdWVAxchN8I7M7x19thxHIEw4VsRotEiCp3SiwC0Q7fOgZUmIargYjOmZvaUScDNRCFXSzY7p0qdA054Y4/p9xF/gSlWe1keMgueXv6aWuyssQ4kUARCBV2Yd4CvIj1XN8HY4LJrMvf1BxM0nqStKXUsHIoDP5iC6K4qrfPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XlKi6OPw; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a6bcbd23c9so19397345ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731365464; x=1731970264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fTdDzCYRBRhSLyboKtTQOLAFBt9x0DbQTEdRVM6MA34=;
        b=XlKi6OPwcW9nXsDNMSE4muia2f7TOxnVD3xkPskrqUopCq7c44hXwbtcFRE3aU90kN
         UJKpk4p8XGScesk1Iwd8P8vBaCv8C198CE+qZwqnV1GQ8RCJmKxbzydtokRLuveST+Ul
         A/JC7USaQW6I+yh//1t/rhyHvhAlrJQnXPyz4eZKND51jWSIOysx8ut58oVccl9rZDFh
         3ptN7YKOGHTGCjE1roZsvgBY59GdaV2vBGnESQ3CEAf4EEiimzPGJpIoYNRhAIz+x8cs
         hVmtr4WyYfrBuHGXZzSyzisSj6juLyJ8P2+0UwIGwOsz8MnHI3BlKK085g4QAL9iZVSH
         xexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731365464; x=1731970264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fTdDzCYRBRhSLyboKtTQOLAFBt9x0DbQTEdRVM6MA34=;
        b=BCbEO9WpFLQr+20AaJdaDXa2clEaj1rp+or+3W9m81WvHsmpvPv4/Emjl8y/bnO2qM
         +aX8h6XAjJa+FT5ADV3pAZtMzVW7EaFweFqPBMdYLoK+698ciuCuoJCwV8JjtChoagO9
         2Cfxd6w/T1bl9E87KIa7IOxnTAX5B5oad8t0I6Iofj6q3f57qVp4T3pxRswQA8/O90vC
         HOOHLBjssnKoxeFBvmVYjnrqK+4bIdJJdovLqqVIboiX9b3PVl7/h7CvcYJZvEjplK1g
         eg3EPPVpDT9bhLcNcL0vDCJxn0C4+0mjnV/jNb98x/LCQd5E9PAA+NHoTk1kQxCnvquA
         MnUA==
X-Forwarded-Encrypted: i=1; AJvYcCVk61Hg55jfGpXCeicTlZejdS08vRvprY3W1QzsiwzTNsA7+sAT8PxGpfeziXwZbgexlR5E2aXJHF7E9k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzdGZU5AMoU0cxZPd+mev1WJShUaenql6EKQKa3oQFSV0FAkyy
	w42CHpKnynLiXxuVDqjGkLYTR2Am0tnmWmIIeEyvyhZj0vfsoD43FHyv00SsN9Y=
X-Google-Smtp-Source: AGHT+IEtIUyvJdzpK4c4ujWrQA/hnBETNtlG/7l6hYXi6h+y3fgZDr4h4pUhVLK64ZeQM/TV6wduHw==
X-Received: by 2002:a05:6e02:19ce:b0:3a6:c1ad:3a02 with SMTP id e9e14a558f8ab-3a70c8990e2mr4057645ab.24.1731365464197;
        Mon, 11 Nov 2024 14:51:04 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6f987e20asm16884155ab.56.2024.11.11.14.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 14:51:03 -0800 (PST)
Message-ID: <b15fd3d7-6add-4220-8c24-afb725177466@baylibre.com>
Date: Mon, 11 Nov 2024 17:51:02 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: adc: ad4695: add custom regmap bus callbacks
To: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241111-tgamblin-ad4695_improvements-v1-0-698af4512635@baylibre.com>
 <20241111-tgamblin-ad4695_improvements-v1-3-698af4512635@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20241111-tgamblin-ad4695_improvements-v1-3-698af4512635@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-11-11 10:59, Trevor Gamblin wrote:
> Add a custom implementation of regmap read/write callbacks using the SPI
> bus. This allows them to be performed at a lower SCLK rate than data
> reads. Previously, all SPI transfers were being performed at a lower
> speed, but with this change sample data is read at the max bus speed
> while the register reads/writes remain at the lower rate.
>
> Also remove .can_multi_write from the AD4695 driver's regmap_configs, as
> this isn't implemented or needed.
>
> For some background context, see:
>
> https://lore.kernel.org/linux-iio/20241028163907.00007e12@Huawei.com/
>
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Found a couple more bugs after some testing. I'll wait until EOD on 
Wednesday to send a v2, in case there are any other review comments.

