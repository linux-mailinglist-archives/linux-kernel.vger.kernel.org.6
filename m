Return-Path: <linux-kernel+bounces-317729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF9B96E2E9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173921C2346C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E22C18D62D;
	Thu,  5 Sep 2024 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z51uigw0"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B651A188595
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563682; cv=none; b=eJm/I/jcu5aL92v2t7CG9k8cUwQW0AE7AC9dtl/8Lk+XPBUcoW08qC4x55CNMftaKXvNVomMweGMXif532/t+HbTmU72WHykZv16+8svEwyhgztDwc+qgVjRg/UNLttrHHUQe9tpOrnoRPQPIcqyMnpoM3FZ14wMnKVoMHszN3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563682; c=relaxed/simple;
	bh=6UXCMrVmZNSbpGeVyKWnT29MRHVMts77X0nivhm7MT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDvU/3t8E/GoN/AmtakkOshqOAz9dwFM70ep27cJ37nExyZ9AYc3og11V1xRbh2eofd0805wMxmaMVnlWh8aF8TEUwjavK7cOo9kyFdLFqB/O4u5oEqLMI4kF3lNoE/35vIckV9I3DLAshjd0+ITbhGqdLuMwkKOebpaPsAdDRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z51uigw0; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5df998d7a44so732316eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725563679; x=1726168479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LkPKmV9GWSwhXE4yCA0T+DtSYxNC6pC4AoG3CAMJwrg=;
        b=z51uigw0DuWLG9oPgJ6X0TeHViaPYBvI9n6NKrGwIbRrDRybVPcw/m03mk6SP8b9k0
         FJHZMfBmc0agPNawAAAkt+g4/gyXCTZdnK+EKRIBvpm4EwOmapOlfCULO7hI8Y55p7Oe
         0Brg3ZOH7Ws62TuQWTygc89Aq4OyqzL3pCsQ7LCRDgG/k/aoZQsIRK2Ha3Seo0A08s7t
         UYexBbTbco3dy7Do6Ln1t90diwISoLRlEf5q+sWZCEgT65i5s6RgYwwhtMqfoTQxwwAb
         S0iqD8qZU9xWSbLRb4uwHq+Tg4TxxmMJyPvFj5vQ4jPMKzI1U3MJNzbDSAMRcxM90ia1
         YOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725563679; x=1726168479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkPKmV9GWSwhXE4yCA0T+DtSYxNC6pC4AoG3CAMJwrg=;
        b=nKLNIxGX7/ltXk5zsTG+Pd0fe9KcJC6zpt/u8IgdQsOkHDOuXOWn28LvOVul6qsL8x
         u3xQIz9GKIOV4aZZMNAGHVRRIZ8etBrj0WBtboBnhG1FsoaHrztTGdHMd6Fj9cz/1uxZ
         RD/D+zaT7iHkAFTvZq4nATuYtpEws1RLGHxSYNw2Zqdl8NtV2f8Iiu/FI6UeUW0JiF6i
         oVwLci8ZKyXJHXBcXhsk5qIu6IoKMJ6nBP8aLtI/UOKD+EEuHQTpgZQw3LqbrGseF9WR
         4tHKYJD14eoGs1Pc85DyXxdSXs+kUtsAjPVQySNQQvg3z7wkT9wDVQux9B5I3aGc3BLZ
         bc/A==
X-Forwarded-Encrypted: i=1; AJvYcCXmYqzfUh69nnBZFeTECDMiGaZuN7bJZpmi3V9YQ0OWF/bbi6uDAj4zMN29hnL7MfcjkvlPjzEHEy7G5io=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF6KRPCTlQs2pa4VL+LxAtfjymsBYCK3PMVTYAueM87HGb/tPq
	oG5TZukmgAqXJxG1xaqdLsk9UGzr4Qxa6xUYwGcd6Gpl7MM8eLPMlQ34FI8sW7n38QVtIgiRK88
	9
X-Google-Smtp-Source: AGHT+IGslQXMgujEyUkZAQLIGMlp0qbu63S5tJREUO7YqA63S/B92HI5uvFPA5zJNDJsVomUJHI3mQ==
X-Received: by 2002:a05:6808:e85:b0:3dd:43a0:88a9 with SMTP id 5614622812f47-3e02a03a9d8mr345427b6e.41.1725563678796;
        Thu, 05 Sep 2024 12:14:38 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df11866831sm3384597b6e.37.2024.09.05.12.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 12:14:38 -0700 (PDT)
Message-ID: <b70612bd-e61f-4286-9337-bca48768fbdd@baylibre.com>
Date: Thu, 5 Sep 2024 14:14:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] iio: ABI: add DAC sysfs synchronous_mode parameter
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-9-87d669674c00@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-9-87d669674c00@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/24 10:17 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Some DACs as ad3552r need a synchronous mode setting, adding
> this parameter for ad3552r and for future use on other DACs,
> if needed.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-dac | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac b/Documentation/ABI/testing/sysfs-bus-iio-dac
> index 810eaac5533c..2f4960c79385 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-dac
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-dac
> @@ -59,3 +59,19 @@ Description:
>  		multiple predefined symbols. Each symbol corresponds to a different
>  		output, denoted as out_voltageY_rawN, where N is the integer value
>  		of the symbol. Writing an integer value N will select out_voltageY_rawN.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_synchronous_mode
> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Arm or disarm a wait-for-synchronization flag. Arming this flag
> +		means the DAC will wait for a synchronizatiopn signal on a
> +		specific internal or external wired connection. I.e., there are
> +		cases where multiple DACs IP are built in the same chip or fpga
> +		design, and they need to start the data stream synchronized.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_synchronous_mode_available
> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		List of available values for synchronous_mode.
> 

Since this depends on how things are wired, it seems like this should be
something specified in the devicetree, not through sysfs attributes.


