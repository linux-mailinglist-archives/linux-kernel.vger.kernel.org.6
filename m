Return-Path: <linux-kernel+bounces-428489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE6F9E0F38
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4FEB163F53
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4208D1DFD9E;
	Mon,  2 Dec 2024 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VdnCDlVV"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423D02EAF7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733180730; cv=none; b=DZ5qgmIoJMmi+3ojzwCCV1zApUHBh/v6kpplecm0yPmx9UjB8Yt005QQm353NBq6VfGZgFbJfU2gYmDUxlmVDNhqz1z1nYQzc5itngCv0GAMEPjoK6x2uUQPUbtReXwqnCi3nHV6vbd3o9WkMy/4BTKfpSILY3ZpyH39uIAkPzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733180730; c=relaxed/simple;
	bh=jPK3s7MvXUAv9tE+0zBLYxJdkSDpEVCvEn5z5oAuHKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8qQ8dQJxNkSWVitCmANYjS8XPCVGGtvVlIbhBm4IyykqH6TSiHF+bxhbzAYeciONrUFzODiCMMwZEN8I7nZLWIGvxR54UR5GhZV6a+rcYfiiZINbuteM8A8RRN+X0Kaf2+EemjyrgbdWPWhXCgweTceD3xzurIsE4pPuuDICgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VdnCDlVV; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29e644b3f6fso876472fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 15:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733180727; x=1733785527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGCPVYRn5OSGT6f5dVv/ceurIa62iRGC5aQpQ1hOOnk=;
        b=VdnCDlVVYedwyJdr0A1+c1E9refjiro0Eij3epn8cOxfhFpSCGms1e0Hbc10HjMm86
         Qe6KTI4l32JTplyPFp3b0HZaGO8OQjrYRpJd3gcMdLWXOSG/hJkIxYCjIh/uc6je+PHS
         3mYKndlbZc8krKZkapDybbbeiQ0n9EjpMe+7aLtdZ0BBVzmwvZU7lVMLbh1cO/ZmCXMQ
         tHTtEjLI+BfXmZK8nylrvJMMrAnjYMLep+LMbQLld7r+o5hvRDTa90HFd25aaDEteq7c
         McOdwVJmj0qqonZ+jhBsgmfD/pGJQcdz/jbX259DMEgBQEnF1lkD7iWqnjcVSg3PI9Fd
         V1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733180727; x=1733785527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGCPVYRn5OSGT6f5dVv/ceurIa62iRGC5aQpQ1hOOnk=;
        b=HYachRgN+yC3mqob3WF1l7cOotOXyn01bgY/Cd2Dvv/Oims4zW4rMACJTSflY5UF7O
         /oh2eoqkTEs6cKfHyayOjd3DHxt/CkneWoI6BmDhVQ+viDNbbnRc5wwLsThPojGRHRtb
         GR1+9gBmkWrIu/OqwbFLGasphOusZT0oKlEEs3CiAB6S/zoD1GZVfOT0u7V1DUuMDEbB
         FQTX8A6A6vpaaIaETVPrW7U5ouXGCaLWpnWjhFn6vdsoclx2dzpNuR8Rb/cExMNz271Z
         Ngo45HHo22QGa5aBKmaplVQDTPsTOvkFAPCFt0NGUoeiZRLbtf34a0hFWKoWFB0XenPd
         xeMw==
X-Forwarded-Encrypted: i=1; AJvYcCUK/3Bs1AUfCevkwREOvKoAP4CscCnvXk/HqWdLutUuMMgge3b9aJzmWfoa+bHfLVbKKt7P2rY/BqjpgNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyflhtWR++XjJK9xEDLvM9vxbJO0YxtPamPAW/IPp+KBS8KKBzL
	O2CP7epyVmwuTQm0ttP/BkOygRCT28LOibnt7OU1qq4Uh3ndyzvgfue1wIOsD2s=
X-Gm-Gg: ASbGnctoB2Eio+rTGCH6wDcDYjBJFVrT9ef/+zFUsO6cAf864MPcAWq7S4YkHItIwv6
	0D335MuNSm/8IU3DKkNAwgAGOGgJXq+IRk+VuXa1NKjgXVTeaVo0IN4FAaIohStjuNTC0DS7pM/
	xC+n1rBdlO+4PIMIP/sXLKmFiVF4vS5YEi9T0ZfpywEWODvEXFPQ4JIlQQAWT2+/DyCiMqld/Tr
	vOC6fqAYjwQpG6ewuwVgfBDzVh00fTCkNJ3XSm56BXGHcM4lp3Pk8CCHNHhgs4NmHzy+tovkkpJ
	yaktGe4aeNc=
X-Google-Smtp-Source: AGHT+IGi4VfwgKHUVkydn6ADMuAuaO1y9v+fPGdB0tYX90iGwS+zN1xd6HcGdq43J7pH2hZET2mb7Q==
X-Received: by 2002:a05:6870:d886:b0:29e:532d:8f3d with SMTP id 586e51a60fabf-29e8867f8b9mr256796fac.10.1733180727203;
        Mon, 02 Dec 2024 15:05:27 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29e3d3fb1c3sm2042449fac.8.2024.12.02.15.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 15:05:25 -0800 (PST)
Message-ID: <52513d34-8484-4c4b-8f87-29cbbdcefc06@baylibre.com>
Date: Mon, 2 Dec 2024 17:05:24 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Documentation: ABI: IIO: Re-add
 filter_type/filter_mode
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, marcelo.schmitt1@gmail.com,
 Guillaume Ranquet <granquet@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <b2132bd3ca1d64cdd8d5afab1f1f33c574718b50.1732901318.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <b2132bd3ca1d64cdd8d5afab1f1f33c574718b50.1732901318.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 12:22 PM, Marcelo Schmitt wrote:
> The ad4130 driver exports in_voltageY-voltageZ_filter_mode and
> in_voltage-voltage_filter_mode_available attributes to user space.
> The ad7779 driver exports filter_type and filter_type_available.
> Add (back again) documentation for filter_type/filter_mode attributes.
> 
> Fixes: 01bb12922b60 ("Documentation: ABI: added filter mode doc in sysfs-bus-iio")
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Digressing a bit away from the specific ABI used by ad4130 and ad7779,
> the sinc3/4/5 filters are called `filter_mode` in ad4130 driver while other
> drivers (ad7779, ad7124, ad7768-1) call sinc3/4/5 filters a `filter_type`.
> Datasheets use the term `filter type`.
> 
> Depending on the particular ADC chip/design, the sinc3/4/5 filter configuration
> may have an impact on the output data rate (ODR) (which is equivalent to the
> sampling frequency for SAR ADCs - `sampling_frequency` ABI), 3dB cutoff
> frequency of the filter (`_low_pass_3db_frequency` attributes), or settling
> time.
> 
> ad7768-1 sets sinc3/4/5 according to the sampling_frequency attribute. No
> filter_type attribute.
> 
> ad7173 sets the filter_type according to sampling_frequency too, though it
> looks like support for only one filter type is implemented.
> 
> ad7124 sets sinc3/4/5 filters according to a filter_low_pass_3db_frequency
> attribute so it doesn't export filter type attributes to user space.
> Missing `in_voltageY-voltageZ_filter_low_pass_3db_frequency` documentation?
> follow up patch?

cc: Guillaume and Uwe since they are working on these last two drivers
currently. Maybe something they could address?

> 
>  Documentation/ABI/testing/sysfs-bus-iio | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index f83bd6829285..704c9033cb5b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2268,6 +2268,20 @@ Description:
>  		An example format is 16-bytes, 2-digits-per-byte, HEX-string
>  		representing the sensor unique ID number.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/filter_type
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_mode
> +voltageY_filter_type_available
> +KernelVersion:	6.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Set the filter mode of the channel. When the filter mode
> +		changes, the in_voltageY-voltageZ_sampling_frequency and
> +		in_voltageY-voltageZ_sampling_frequency_available attributes
> +		might also change to accommodate the new filter mode.
> +		If the current sampling frequency is out of range for the new
> +		filter mode, the sampling frequency will be changed to the
> +		closest valid one.

I think it can be safely assumed that changing any IIO attribute can
cause any other to change, so we probably don't need to mention the
sampling frequency interaction here, especially since it doesn't apply
to every possible user of these attributes.

Some other useful things to add instead:
* Mention that the values are the same as the ones listed in the
  "..._available" attribute docs.
* We should deprecate one of the names and recommend the other for
  future drivers to use. Since "type" is used more than once and
  "mode" only once, it seems natural to keep using "type" going
  forward.

> +
>  What:		/sys/bus/iio/devices/iio:deviceX/filter_type_available
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
>  KernelVersion:	6.1
> 

