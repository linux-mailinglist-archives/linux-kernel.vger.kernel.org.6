Return-Path: <linux-kernel+bounces-393428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF75D9BA071
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 14:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36C1281EF6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 13:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC6918A92A;
	Sat,  2 Nov 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="YMvA0ThG"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE2318A6BF
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730553682; cv=none; b=eDym+U4IvSUM920NNu9WGpbKhl9zRoAW6lf9cxxuU7cE8Lx4EKret/qRHisMwDWVSRrj6PNqvobK7jE6Je4bEBI+0TEAKbxfRuQU/kthw82sCF/OVIiOfAh9uxHwZdzzRT3wJYX36bRK7G/I/zo9lIhkSEv5AoS5tbuIoycmHWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730553682; c=relaxed/simple;
	bh=TYC9l1TDXilNXaG0BsW3CdCYdRUtd8+mZKCtV6EyLI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZuUiZHf9d1J9UzL7DEhDGOlfTvKP6WJpy2ug7qRSrgAjqfJPmLBO3GCyHP8+NTd2GnNmvxUbdVXM8QEtDN+lCsyMoe9RngqZ/xDKsWttA9JNLj2tSkHISj9YpqtkFcKJOh5xV92FOjoJomqSkQvH1/evEbTPuIk/MUmIOG5L78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=YMvA0ThG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20e6981ca77so30851695ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 06:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1730553680; x=1731158480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8P6J7CC2+ddqyvspzxGk9dhLYIMX+2ilpolCnOsNTNQ=;
        b=YMvA0ThGzwDEvA2IuhP4lRriPTdOWobAFEJbhzac/pd1uMhZqvVLnwD7kXEvBg5ElC
         6LTu9dRein+WbEw4ZfZqgzgNVFoFM5BvVhHB6lYBqB5GZtYIr++ASLDXNe6U0QlUUvaK
         7tvqGGpSLGrIL5zRJUpVZHs8oGgMw2AE70EqrA0a1NyzqHeVi+GVjhVSsIlvdYfYqy/M
         EY3fJimMR8d8RDkstPY2AMm96XYm7RyrviZYOlRf0rdKe7GzU6B2+KSfiAJ6Qh1R2KYI
         xdHDn/MYPGzIBGjbjgC4m0DeU5vSZV9dU6zJP0b5r0adhOqtm/ekpKMaz2EE2MLJvbC1
         c6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730553680; x=1731158480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8P6J7CC2+ddqyvspzxGk9dhLYIMX+2ilpolCnOsNTNQ=;
        b=dvfsKK76Pcrbfku0rYYpOJ9eqGtBS9jVLZc1DSvkDlwDH0SWda7zi0Ls4VM+nVF14s
         gw2GKCTJ5D9u/fT/Nr6sh+UeFiF9b7e3OkZfD2X/YZYXXg92BTFh258NqKA5zrG0dwbv
         WCx6roRAk3NG0ImFB1N/ArTu7nHUW0U7xcwcjr/C784HKkkt4AZ6jhgoKhZZzwuPMB4i
         SOXdWGbCf3Uo+k4GO/IedR69I6pd2wsBfbwWgMz5+iQpk3eQqezaxJFfImcq9ejOEnLW
         YzCaqoohSoEg9XKf/qGT7vj2RKxrb/FZlzb5lQfj/BjaR2d6ufK1LhDFCzidoMdnb3Z7
         ENAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV33HgnC4V+LZUBO8kbMGzQuMgHrOI3UHtA8J0BcM6dwex4jUoqQUjCXN7RnLnxsZ4v8Sac1muGoeEB0Ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLRAiL7JUwXTv3U+UiP8j9FG9T/MWAVMif2905sLj8sRFvmo8
	eaImyJ1j6UpfoZKam+J18N+IQc+YCUjon0RrPEMIksc+A9c8XxQQew+LEgwFp98=
X-Google-Smtp-Source: AGHT+IGq+i8a8MyrkZrVMk7tFGx4jYT5BKdNbeajY1pRzeXD9zZdCy+jANqzkpIEbDK9zAkNl1bK+w==
X-Received: by 2002:a17:902:d2c8:b0:20c:a055:9f07 with SMTP id d9443c01a7336-21103b1a5cfmr145523125ad.26.1730553678217;
        Sat, 02 Nov 2024 06:21:18 -0700 (PDT)
Received: from [192.168.50.161] ([180.150.112.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2110570b482sm33784505ad.71.2024.11.02.06.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 06:21:17 -0700 (PDT)
Message-ID: <4e4e5281-d489-42b5-b358-c44958cfa4f9@tweaklogic.com>
Date: Sat, 2 Nov 2024 23:51:05 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] iio: light: apds9306: simplifies if branch in
 apds9306_write_event_config
To: Jonathan Cameron <jic23@kernel.org>,
 Julien Stephan <jstephan@baylibre.com>
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Dan Robertson <dan@dlrobertson.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
 Michal Simek <michal.simek@amd.com>, Mariel Tinaco
 <Mariel.Tinaco@analog.com>, Jagath Jog J <jagathjog1996@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>,
 Linus Walleij <linus.walleij@linaro.org>, Benson Leung
 <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
 <20241031-iio-fix-write-event-config-signature-v2-13-2bcacbb517a2@baylibre.com>
 <20241101164118.687be624@jic23-huawei>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20241101164118.687be624@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/24 03:11, Jonathan Cameron wrote:
> On Thu, 31 Oct 2024 16:27:08 +0100
> Julien Stephan <jstephan@baylibre.com> wrote:
> 
>> Simplifies the regmap_wite if branch in apds9306_write_event_config.
> Applied.
>>
>> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>> ---
>>   drivers/iio/light/apds9306.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
>> index 8adc74040db2bddf93fbb773e3519abcc726b9a6..9c08e7c3ad0c17519689a630d42fe9b90438dfe8 100644
>> --- a/drivers/iio/light/apds9306.c
>> +++ b/drivers/iio/light/apds9306.c
>> @@ -1125,10 +1125,7 @@ static int apds9306_write_event_config(struct iio_dev *indio_dev,
>>   		}
>>   	}
>>   	case IIO_EV_TYPE_THRESH_ADAPTIVE:
>> -		if (state)
>> -			return regmap_field_write(rf->int_thresh_var_en, 1);
>> -		else
>> -			return regmap_field_write(rf->int_thresh_var_en, 0);
>> +		return regmap_field_write(rf->int_thresh_var_en, state);
>>   	default:
>>   		return -EINVAL;
>>   	}
>>
> 
Hi Julien,
Sorry for the delay.
"int_thresh_var_en" corresponds to APDS9306_INT_CFG_REG bit 3 (Datasheet: INT_CFG, Address: 0x19) which
is a single bit value only. If user does "echo 4 > /sys/bus/iio/devices/iio:device0/events/thresh_adaptive_either_en",
which trickles down to the "state" variable, do we really want to write any other value except "0" or "1"?
Correct me if I am wrong here.
Regards,
Subhajit Ghosh

