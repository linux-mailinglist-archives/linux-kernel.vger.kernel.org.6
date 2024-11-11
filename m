Return-Path: <linux-kernel+bounces-404193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9031F9C4075
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8412824E2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18ACA19E97A;
	Mon, 11 Nov 2024 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNtyEaEl"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE652155CBF;
	Mon, 11 Nov 2024 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334453; cv=none; b=eFMGQFvW285bIsxNVcgAKNGDn30wKWNG9spUJYgEMGrAChXxDaysQk+yirwkriMIgOY7UNKGNRCKV/ES7wPJ/Wnr18j+5wD8kMD0m0wFcJ1QLULZtnF37RaoLHJmbf0ZQF9rouAqAbqRhUBnGgyI00+jwn3ZkB+RjLpV2elEk6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334453; c=relaxed/simple;
	bh=xGQ25APo1pmW8WG57GB3HGbTAoRBmkZTBps8h+sJlS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pVkCBsbRhjbXJYCtsq8hhr0yTuXmhEMZUDpyw3yFJ3buf1uV6ZVQhsui+j6xjqdfQEGrdOKNLllXT6f4VamLQF0gFsOPgNg8719bRTc1kTdFBwZhTSu8WdLPoPRUuOaozwp3zqMpoq2pK/BBazQAd6bzUBS307FPHd5Nr+D+U0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNtyEaEl; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e52582cf8so3556374b3a.2;
        Mon, 11 Nov 2024 06:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731334451; x=1731939251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8jh8QF7rmmzQyQcev1TztdNC8/1ytTeCqpc34ixJhxg=;
        b=LNtyEaElrerjp7dkxU/ErKKiFh8jgIgZhaTh1UteSgok53axqUdT3U4FiPc8u6sRsI
         uAh1KoqB5jsa2hVDoseQqR87gu6G7E8YdyVYWjdjFi9wQfI46DhOAyXTS6olL0usxr1F
         dd6pYdx8e9ybks0T4Yu+AgwCLFEH5FI2SCgppxz3UiyEhf4FBqXJjD9QiUMN8IFiYNJq
         JO3BK3CTvKG8HXK0cC5I/wtbvP5P5CZvXVuqSCB0ihsA9XbUMo2vJMJYjgIIVqpxtnuE
         +Y90SpIYlDmANBIRBu6NlKJ7ijjhheQxwutk0rbndzDYo8o1oLUsl9YWxbsuEBJ3Hspi
         udwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731334451; x=1731939251;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jh8QF7rmmzQyQcev1TztdNC8/1ytTeCqpc34ixJhxg=;
        b=pF/OFkE45UUBUqIWdnsgc/fR22vCHzwWemp+AbA/YyxbhXkGL3rEjkK1BZmB0JIqHb
         DMn5btXisEQwX2OiWqxqEkZ+AWjd/t0ClpMJ92jE+dE8uldNN8yiGDyeAtnhFwEciAPy
         LB1YrWrAKggfh4ep1SDIT1Uy0A6UGrAYGes8Nb1K6Nfh61ERAr5tNEUkFQqAtwU589zv
         X9QdtzBKzLVbqb5LFOXKOtFK/pnkgW/7SkDmYeCvRBUjHzrI+rYH2mQw3Af8utjeHNR6
         6zVgIL6euvQKn1TQLAAKSlIrLvigB+9OCdwTXkGjKjEZxG+1K/8JXtFsoX987BLXS9Vs
         cLzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYx9uGBHDpHWTpztMmTIO2DWgIaRW+fvFGkkP6l6dLpRhj8OnvkfkjiEIj1kA13LeUeAOMEz102Iryg64D@vger.kernel.org, AJvYcCWJgQYYCrtCAwkov7YFg814MAVTnlWA4eaCWROby3FFRXgaPVPttC8Bn5YyZwNznyLe0z9ddXNW0gPAMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeAFhbMJwYTcTv8l+cI/U3hH45FSMmk0/WxXtiOo5/AmM/NCD5
	6kYHbArY5nNZGorFA5khsaAUX5g/dHVis08aUVHyNYQpac1ApPCKiNTReQ==
X-Google-Smtp-Source: AGHT+IET+G0UaXITs9wG4Kj5nfiKyeTCptDdZ0V44/o1aJdALw0v9hcUL9uHHK7Cp2cmEWCye1/TeA==
X-Received: by 2002:a05:6a20:4c17:b0:1db:e9d8:be4f with SMTP id adf61e73a8af0-1dc22af3e51mr12261706637.29.1731334450902;
        Mon, 11 Nov 2024 06:14:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65bd78sm8663461a12.78.2024.11.11.06.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 06:14:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5ef20452-a38c-4c2f-b49d-3999b217f622@roeck-us.net>
Date: Mon, 11 Nov 2024 06:14:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] hwmon: (nct6775-core) Fix overflows seen when writing limit
 attributes
To: Pei Xiao <xiaopei01@kylinos.cn>, jdelvare@suse.com,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b09c4396-1578-45bb-b1fb-23c1f91cabe7@kylinos.cn>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <b09c4396-1578-45bb-b1fb-23c1f91cabe7@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/24 00:36, Pei Xiao wrote:
> hi Guenter Roeck,
>    Excuse me, may I ask a question?
>    When I see this commit (Fixes: 0403e10bf082 ("hwmon: (nct6775-core) Fix underflows seen when writing limit attributes")), I found an issue,
> DIV_ROUND_CLOSEST() after kstrtoul() results in an overflow if a large
> number such as 18446744073709551615 is provided by the user.
> Fix it by reordering clamp_val() and DIV_ROUND_CLOSEST() operations.
> 
> If the issue described above does indeed exist, I will send an formal patch.
> 

Yes, and good find, but please fix the calculations.

Thanks,
Guenter

> 
> diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
> index 934fed3dd586..12ee2ca4a6d6 100644
> --- a/drivers/hwmon/nct6775-core.c
> +++ b/drivers/hwmon/nct6775-core.c
> @@ -2878,8 +2878,7 @@ store_target_temp(struct device *dev, struct device_attribute *attr,
>          if (err < 0)
>                  return err;
> 
> -       val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0,
> -                       data->target_temp_mask);
> +       val = DIV_ROUND_CLOSEST(clamp_val(val, 0, data->tolerance_mask * 1000), 1000);
> 
                                                     data->target_temp_mask
>          mutex_lock(&data->update_lock);
>          data->target_temp[nr] = val;
> @@ -2959,7 +2958,7 @@ store_temp_tolerance(struct device *dev, struct device_attribute *attr,
>                  return err;
> 
>          /* Limit tolerance as needed */
> -       val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, data->tolerance_mask);
> +       val = DIV_ROUND_CLOSEST(clamp_val(val, 0, data->tolerance_mask * 1000), 1000);
> 
>          mutex_lock(&data->update_lock);
>          data->temp_tolerance[index][nr] = val;
> @@ -3085,7 +3084,7 @@ store_weight_temp(struct device *dev, struct device_attribute *attr,
>          if (err < 0)
>                  return err;
> 
> -       val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 255);
> +       val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 25500), 1000);
                                                     255000
> 
>          mutex_lock(&data->update_lock);
>          data->weight_temp[index][nr] = val;
> 
> Thanks!


