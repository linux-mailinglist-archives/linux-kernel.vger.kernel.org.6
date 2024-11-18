Return-Path: <linux-kernel+bounces-413496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5AA9D19DC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0D51F23094
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46881E0DD4;
	Mon, 18 Nov 2024 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fNqL/akK"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E9C1487F6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731962889; cv=none; b=EsqBadGCFia7J5X9ZpfD2AaHOr5lq2oB+FHJpszAJcxj+GFj8Jf9hLItPeO0rbq++q68ZVfTWhGxXTMgB1qwXH+FGBDaj5LVauC5tSQdi7j4+VvISzdGnvsncYp1dvb009YpfyCo0R/+vYbnJ1ED56E6D57SQE4c6wWxll+fZlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731962889; c=relaxed/simple;
	bh=ewt5rJFrb2PczIbA7CRaAPtPfqvfDkdOKYNyeNpSJxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekPHcB+5P5t+TMJkUluaWK/Gafo8NZjCwFT01w25zmWgifZaDYc/ygN7ipW01TAUvb1gDErL4whn1aJAiRVeFKHTXp2/neAcZDj+v98rlwwlagSxsZfRJuxoUk3bYH586HFVuLv2FpGjX+p8cbKPKfYK0IOh9m2T/9lQdm1u01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fNqL/akK; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ebc4e89240so828318eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731962885; x=1732567685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s3NX4CqYzFbD4W9x/5neCum/lsR8s0Xk5YK42Mhzu2s=;
        b=fNqL/akKX1bPNXpPKiFAbajXJzsK+hg1m19O3z6In660lHdl2CNFVQf/Mmn1KEChBk
         UTdw00yUO5NVfmAWvinHW/LpQ8C+UiaAvio7Np007a0Ba5VG4V6L1/lxMeYr1Huu4tAq
         NAZUdYHxpGsCzEGArIahRmcYsFNYHe6+8FKbumB1kF/hbOKqtF5AfgnXfZip/mnQCDxG
         z1eP7WH+g4AhSX5HQ2wamSp1rtTXtiTgsICfbaJxKDdCRIQrKv0dU1qwxucMcwFLm8P3
         SyTfWF/OX8+N7d6YwPh03iQ8jSrQuOk17GXfYjXyGMFjus+fkfa00JOzIPGIjfKkobj5
         BoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731962885; x=1732567685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3NX4CqYzFbD4W9x/5neCum/lsR8s0Xk5YK42Mhzu2s=;
        b=cDF3NX5KxqMM3ymzK7JJoDjTGPuzF7fnVEmg36QT46/l7Zzq0+XMkVx0AHFQdpNNnh
         IVD4oyWAbOMJsyvOXS8bmTPJxsgnkFy01mMDDVGhXwQI7JK0pvzZiphc5xRgB3i8yMd7
         u6ypv+3+STUuI+iXvz4EATZp6OCOeCw3SnGsOm/LZPLqTP1dDrnIKNwLWLIF73BdRthA
         y/3bUo/kgfvOW5Ki385z++2JQLzW9y8CBuHzdJLkXx5zrLFpisHmctBQJkgrKj4T76to
         hCTrjGsRP32D7I8FCISEQGhl+Ufou4Uok+a4ifsFxNJV12UBvo6FIAt60IJv8DY32agk
         l7sw==
X-Forwarded-Encrypted: i=1; AJvYcCVN0vJ2jvCaQbpTwqsNOib3bdDG8jZ4KOSke8hGk8ln6XLDZRMcMtQM2YYR0YnfUvlTv3Ehtu4aY1GKjIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO75IbJJFeIwdVEKAzAgQJQhA8exaEywZl4dQ9LRg5W72NEUP7
	4bt5XADqsgoLGyBAP5y3HWveTdVmyA3Y7rQhVhQ6FYEhdIvmcMfBUZNHhEUPzxc=
X-Google-Smtp-Source: AGHT+IFQMUjCRk8/5H5HabAhGt8VwRvx4UoJQUDc2dxsboC81OzNcr9+ZSOGYGwT+IkT0YFcX5+FEg==
X-Received: by 2002:a05:6870:7009:b0:295:eb52:87e1 with SMTP id 586e51a60fabf-2962dd8ba31mr9965984fac.12.1731962885567;
        Mon, 18 Nov 2024 12:48:05 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29690223767sm1185050fac.47.2024.11.18.12.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 12:48:04 -0800 (PST)
Message-ID: <b296a23d-bc65-481c-a194-cb16535d8c24@baylibre.com>
Date: Mon, 18 Nov 2024 14:48:02 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] iio: adc: ad7173: add openwire detection support for
 single conversions
To: Guillaume Ranquet <granquet@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241115-ad4111_openwire-v1-1-db97ac8bf250@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241115-ad4111_openwire-v1-1-db97ac8bf250@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/24 4:34 AM, Guillaume Ranquet wrote:
> Some chips of the ad7173 family supports open wire detection.
> 
> Generate a threshold event whenever an external source is disconnected
> from the system input on single conversions.
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
> Hi.
> 
> This patch adds the openwire detection support for the ad4111 chip.
> 
> The openwire detection is done in software and relies on comparing the
> results of two conversions on different channels.
> 
> As presented here, the code sends a THRESH Rising event tied to the
> in_voltageX_raw channel on which it happened.
> 
> We think this is not correct but we can't seem to find an implementation
> that would be elegant.
> 
> The main idea would be to add a specific channel for openwire detection
> but we still would need to have the openwire enablement and threshold
> tied to the voltage channel.
> 
> Any thought on this?
> 
Just to spell this out in a bit more detail, my understanding is that
the procedure works like this...

To detect an open wire on a single-ended input, we measure the voltage
on pin VIN0 using channel register 15, the we read the voltage on the
same pin again using channel register 0. The datasheet isn't clear on
the details, but on one or the other or both of these, the ADC chip is
applying some kind of pull up or pull down on the input pin so that
each measurement will be nearly the same if there is a wire attached
with a 0-10V signal on it. Or if the wire is detached and the pins are
left floating, the two measurements will be different (> 300 mV).

So this threshold value (the 300 mV) is measured in terms of the
difference between two voltage measurements, but of the same input pin.

My suggestion is to create extra differential channels like
in_voltage0-involtage100_* where 100 is an arbitrary number. These
channels would be defined as the difference between the two measurements
on the same pin. The event attributes would use these channels since they
are triggered by exceeding the threshold value according to this difference
measurement.

To complicate matters, these chips can also be configured so that two
input pins can be configured as a fully differential pair. And we can
also do open wire detection on these differential pairs. In this case
we would configure input pins VIN0 and VIN1 as a differential pair, then
read the difference of those two pins using channel register 1, then
read again using channel register 2. The we see if the difference of the
two differences exceeds the threshold.

In this case, we can't have in_(voltage0-voltage1)-(voltage100-voltage101)_*
attributes. So I guess we would have to do something like
in_voltage200-voltage300 to handle this case? (voltage200 would represent
the first measurement of voltage0-voltage1 and voltage300 would represent
the 2nd measurement of the same).



