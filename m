Return-Path: <linux-kernel+bounces-283487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 768EC94F58E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940191C213AA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552C5187874;
	Mon, 12 Aug 2024 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i+yFibpp"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC0117C21B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482196; cv=none; b=YoBoyTIs07ihPL4o5lLR6oLihjVx8FSG8p5IsH11n60AMHasIEG52sFk3cynqCTFy2DIfNRYO04FuTVqzvoyExlmkzFf2H4aJlCtez3u1I+H+r0AkRfy6kJ+gGxfusK8d7oJSy+cMhDwGLSaxlSS3dLt0c2iRsjnHRtsmUAPJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482196; c=relaxed/simple;
	bh=IGwPcOdKLneQrDz3TxBBsgsLiAnDxtF3rxB3ridlEaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKAws4+S1VH78TCvRw+SD0eHYNd3eB/dPMOMOd5IWJK1oHQGxmXQOtGvy7NI9ZsOjNmR/m/b/67IjLWuMuMGXIMfeONhUW7kYN0Xeyrrmpfp7MfDyxGIQKF7fBCYnwygvJPgLsMjQlHC0QKr3m1xbGuD6QTTq+/D2O4nN/pNK/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=i+yFibpp; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d5f9d68805so2603446eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723482193; x=1724086993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bExiDSnFO33yD2L8BFcmTWpVw+fpt4LMBVVZpDIXrdw=;
        b=i+yFibppxIwoiUoZWODocUR1eUXFcM3AVJCovt+ax0M4iq4pmm+3aigJXzGemOEh/y
         DVOW+aPvtAFDJsQqu4aHxbZffQ0Osi9GS/NTUiI0v076g3sXmAHYvsHUCZukUTgBLA+L
         vEhCLLy92LbqZWucIK31H4Mpy16GHlGAP1Nc7azbqn9YUZ2888NqMzorsU4SBkNMk6Yo
         MM1XalKU5GqWgLMmE2Rp7wjer/avmVmtPrvCoXGUIbBXkL0g52NHu/jusT7mmzm7xKrS
         Yy8NmIml3JOcioRraZUBV8LxUzNHwCu3q4A4k8UxmjkG4dcBU3DuJ7rQ7NLbzmnMUEau
         92ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723482193; x=1724086993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bExiDSnFO33yD2L8BFcmTWpVw+fpt4LMBVVZpDIXrdw=;
        b=iNiZQ5+hSGGtgjH43HDg0dtZhovrdFVqqvb9GxUUBTK7uIDXpWIXxNHetzZaRdSL49
         woEjJmwyc+81/qEK3bqz7rXmyHro+9hu+ezLxBl9fGHIgrldiXGGFJ+jfNnTMy175cIr
         VYT8sYET8Xf+TLGsNEJqsEDWKQKTawC/ujBQrrAdZq/iITEizF5YemSiKSh98obj0+2i
         MMqIHLlpD6QWkO5W6dZHoHqlB4Soa62HpDM01BwddB5Sx9xR8Ds3Z9sGQtqfSNJUTH93
         IVQx+4FVrszGmqDX2f6cA4j882JQBl5Y2KsEjE0BBBBkOSvoXXzQNak5v6aqBmmL3FvW
         jPUA==
X-Forwarded-Encrypted: i=1; AJvYcCVWwAdjyk8GPiwJe4II4283DfSTEoweGBA19JGe3zTPIBY8W6ZJAHiVt2BFznN+ViZz4ecyAwPR3zDX6tiz8Mwh17IHs8Gj7hfI6p9Q
X-Gm-Message-State: AOJu0YwqjRZITcLwqiSI8pNCqItiud6SIOYZE/cg3DX4maJkqUoCF4eu
	BvQO5M3Uu9YsPC7YegCnP6/deO0a93Io0rtDIfsEfRgoJOWzQiYD3OqqaOTRl40=
X-Google-Smtp-Source: AGHT+IG/8cvwJl1su2L5alxvVPwGc2ZZozy1KozsXjsObxlu0fil/+H5vX6dIr/MUHIJ+7YaXv9Bpg==
X-Received: by 2002:a05:6820:169e:b0:5c4:68b8:e27f with SMTP id 006d021491bc7-5da68a0e743mr1122735eaf.6.1723482193390;
        Mon, 12 Aug 2024 10:03:13 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5da3e286b09sm1319918eaf.0.2024.08.12.10.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 10:03:12 -0700 (PDT)
Message-ID: <4bdb10c2-057f-4254-864b-99bb7ac1509d@baylibre.com>
Date: Mon, 12 Aug 2024 12:03:11 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: ad4695: implement triggered buffer
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240807-iio-adc-ad4695-buffered-read-v1-0-bdafc39b2283@baylibre.com>
 <20240807-iio-adc-ad4695-buffered-read-v1-1-bdafc39b2283@baylibre.com>
 <20240810103540.03e758a5@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240810103540.03e758a5@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/10/24 4:35 AM, Jonathan Cameron wrote:
> On Wed,  7 Aug 2024 15:02:10 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> This implements buffered reads for the ad4695 driver using the typical
>> triggered buffer implementation, including adding a soft timestamp
>> channel.
>>
>> The chip has 4 different modes for doing conversions. The driver is
>> using the advanced sequencer mode since that is the only mode that
>> allows individual configuration of all aspects each channel (e.g.
>> bipolar config currently and oversampling to be added in the future).
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> 
> Main thing in here is I think you can use available_scan_masks
> to avoid the need for the error path on just the temperature channel
> being enabled.
> 
I had not thought about doing it that way, but now that I am
thinking about it, it seems like we would need to have a scan
mask in the list for every possible combination of channels.
This would be 10s of thousands of possible scan masks for 16
channel chips so that doesn't seem like the best way to go.

But adding some special handling to make the temperature
channel just work should be easy enough to add.


