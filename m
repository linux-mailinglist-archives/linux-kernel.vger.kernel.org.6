Return-Path: <linux-kernel+bounces-173971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B30D8C087A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0121C20F81
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46734DF44;
	Thu,  9 May 2024 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HsVB4zK+"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C320433F7
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 00:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715214752; cv=none; b=H5a0OOAaefeetmSPEebvcp3J2phmcFRE350URdqjU5Z0GkJyRzSE1apAKOkMS2aYC9Td/mLru3AIkIyCrd0waBBrGiHNm53sTITolRkAF97Cb6fCHVjzA6+IPW/c3V1d8oocZGAzAS5Mf8hCz8EgkBXMcWjA0H4XJpFod4LS2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715214752; c=relaxed/simple;
	bh=T6DfjAKmCP4P7gljf1X/c/Is1kBU1uRxx+KhHzVTU74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqsQYEEppA3rW3MA+wTcQZBDjpvrTaYQZuEVbm8OKp0qJyw6qVSfrl7AgbsBYCg3vQ3o6AmN+fnMftZwpY1KRObztnK5y7Q/S6xqfOwpO8Ndgbt5l376qqdAtd8B37iOcyF9dYuuVVKy3f+506wo0Z8YfZrsjkEx6wMvW4jZh/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HsVB4zK+; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-41c7ac73fddso3608465e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 17:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715214749; x=1715819549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TKnK2bR4e/sf9zkj4k5cJS7AirdVOFFlSBIdz2Kq58o=;
        b=HsVB4zK+tH1ktr1XindumEfzY4b06bsIAr/vgjYGyiRM1f1JnYYZlQOTpoOnuNIq4g
         9NOH6sLEbmGHXKCz9xjbEfjpu2Ti6+5KVOADXEVKLSHwUaQsCkE2D176HbCiKFjbTnf9
         rj+ZW6pioHVnknBUFwEt2jHpcccFAF6UQFEaqSP9VT57YiWzIS6tRR5CXMvKwOYBVT29
         GePRRwdRoLLROqkYt8qHn5HAqDZi2q7J3JgRVjgOTtwxvf2uRmRCbLosO3DDxGLLfSaR
         2bZz354EolKkiv+Y7j3Vkx+048Qd7NT1qDQrIpFwBWhIX5eckOf3nuRmM1/CFGD96Hlx
         LcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715214749; x=1715819549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKnK2bR4e/sf9zkj4k5cJS7AirdVOFFlSBIdz2Kq58o=;
        b=oOY2a7sohsFTs4LCx0gZF6IXnlQxK+xF76uKmq4WIJcEktKF7klUmeE66J0RnOYUT7
         Lyt2tGuqsr8V8MnWBgNSw8kZ8wkxMOE0J6uzPJUP1dzymNtA4uqdATiDMu1tiatAmFq+
         uzeqZJZaufGKx2wwO4DIYZd5Hc+pGIOgh1CkVqXuC7gSbqpgZSMbZJngO0ruhzOWLxh+
         +vTL0JOjL/zAXz//0dbMfPGVkvjl1ZxNVPePg0pKN1080D5yABUd6IuWl+/yDEBzyIY1
         8kAZQznmd4TnwV2OedbN1jY3cBlrjy4p1Vf+axDCFgPx8rKaIXGv16fifjLsMoJ2qwkf
         OiwA==
X-Forwarded-Encrypted: i=1; AJvYcCXFO0bfT7UKea8jhyDqputeLyZ2+OWyCIh5Qn9/UyD8deq+9CLiavBfE66GTF+FUvVW6FAFWvgEsIGBWdk2ShJ1jBu41QT0p1nCNSS+
X-Gm-Message-State: AOJu0YzI2CVer+oMzOL1pY8+YalWr58JYCp+JoHtT3ZTQw4U7UFgE9CP
	s6CJl3HLRMvpFWldnX/TfqIBKZl0/MlLrMPJVb67JBSAWAjudpvOC0VCFUbGZDbYQxt/zhAfNjf
	OsXkzQ/kw
X-Google-Smtp-Source: AGHT+IFhTLFcY/Cs5a/adjpOOYnjYCfR6iOR9IpjqCZyWjXtTiOiFCPiJs0TbWvsU2EG6+KqWeTdUw==
X-Received: by 2002:a05:600c:46cf:b0:416:8efd:1645 with SMTP id 5b1f17b1804b1-41f71302d2amr37959545e9.7.1715214749152;
        Wed, 08 May 2024 17:32:29 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88208cb8sm39197045e9.47.2024.05.08.17.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 17:32:28 -0700 (PDT)
Message-ID: <cef4bf31-35d9-4304-804d-5384018c0900@linaro.org>
Date: Thu, 9 May 2024 01:32:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: i2c: Fix imx412 exposure control
To: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Paul J. Murphy" <paul.j.murphy@intel.com>,
 Martina Krasteva <quic_mkrastev@quicinc.com>,
 Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240506-b4-linux-next-camss-x13s-mmsol-integration-in-test-imx577-fix-v2-1-2e665f072f8f@linaro.org>
 <dvyed4grpazqk7a3tz6dqwpkd76ghtrt4euinxt3kycdeh63ez@ljgfjsfhypix>
 <20a0300a-ac16-456c-840a-e272f49050a8@linaro.org>
 <bppn2qglcya3xbfy7uey5cgybyanxthhweqv7foojwi5rvqwmk@temzdedvecfe>
 <CAPY8ntAJJu8RM66xFr4dGWtZJVhsjjXEecT5=YKBVr+0hVL9+w@mail.gmail.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CAPY8ntAJJu8RM66xFr4dGWtZJVhsjjXEecT5=YKBVr+0hVL9+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/05/2024 17:31, Dave Stevenson wrote:
> For reference certainly imx327/290/462 which are all siblings in the
> Sony Starvis family do calculate exposure as
> exposure = 1 frame period - (SHS1 + 1) * (1H period)
> So 0 = max exposure and bigger values are shorter exposure time.

ack

> I'm not saying that the imx412 driver is right in doing this as well,
> but it seems there is a trend with the Sony Starvis family to program
> exposure in this different manner. Don't discount it as wrong for all
> drivers!

Understood. For the record the rpi imx477 driver writes the CID value 
provided by user-space.

https://github.com/raspberrypi/linux/blob/rpi-6.6.y/drivers/media/i2c/imx477.c#L1376

With an exposure multiplier we don't support upstream at the moment. So, 
I think this patch is the right fix after all.

---
bod

