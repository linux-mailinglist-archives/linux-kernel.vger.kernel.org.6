Return-Path: <linux-kernel+bounces-336119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C02897EF71
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D054B21CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C496319F428;
	Mon, 23 Sep 2024 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G82segk6"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9813319F415;
	Mon, 23 Sep 2024 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109856; cv=none; b=cvlZWnKCfecnCF5QO+doNNBzcHARn0KC+VGQ3vvTEJ6hbTnulOH9u7O8OT/YmxJN+VJ/0umvXmsx2GHGZn4gLEWJcnwOlNhJ2UkfyMdMBRk8GKnIrenl8zjZWZA/X+AuY3wIoWbr2H30JHeobxcjdIYjNLo74kCY/Soaz2mRQys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109856; c=relaxed/simple;
	bh=TFvOt3HNoFPmVVuNgvDvNZJdcNu7LUe72278vUlSBJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrXZ6lE4JPnZ7TOtPpWsNY/qqem54BrwCym1lvIiN+CnAvzTKWM3Yi7230G6gEjodQmLrhw6h1ZhRPVSdS5JHoK7WFtkKBzfRMt3GXxl8ym88Ua3/8VRScwd1EKf608HirccaTxDCRyr/nI/c1cf8g0nrSAvoPC8jxX+rLqnB48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G82segk6; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-718da0821cbso3490824b3a.0;
        Mon, 23 Sep 2024 09:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727109854; x=1727714654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LE2icXy8k73aSjrza+jkChEXgPYFZ3BvwXphHOFJKgs=;
        b=G82segk6KKLMdag1JEkxdhmrxFufKklRJ4fccJf/078CEf9iudFclg4OIYJf3znrwY
         Z09tJSjcx1fht88Fq+LaUDYbI6Xv68cSzusDp2vTVkkPWkPQjTdStIaxGUz9eeHvEbx6
         Hqf1T1DvgSAJ/H4WBcqfzue6qDjGTIx1Wl6uTrQwFuhzXorgvZj+3pwFl9mYfjqp4KcC
         dyUj9814DUtXPz7+6Re9n/lZvTJDlOTHlbcZxiTiw2Mam1mkkD2v/MHOtCoYeakhLJuF
         VHFwpGaHo4/QfFzBfLAJ7hboM1vPKW0+eMOtoz20W8ULVWmpd6eaKD7Us/QEVmCi8zf2
         AIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727109854; x=1727714654;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LE2icXy8k73aSjrza+jkChEXgPYFZ3BvwXphHOFJKgs=;
        b=TuoqU5ynJIYZeXIclY/29fwROKi9J/x7qO6y3XNe925ZewiajFeivbLMHAQBcwMFkE
         NkVZOT/EVgCRXDyiK1THrcUX3pllqicIaTeTUOa7iqpV7ErUuczbMFbT9rG1KlikHoa4
         iSnFUTS+SK9OObt+Jm1sS9lnBRG2788Y9sAHiZr5TVPKXrBaW0NmnX43uidVAnQhYJsx
         LNiJG+yCRspbaRHckKCTwnJB1LVbQMI+hNDEaHSk2cvAO6T62JI2iWUlr6X54pW/jE2q
         9j8qwjcRMFoIcolM6f7auzCaU5pqNibUB6dvpEF+RtR78EYLOcrwt1QaikKYUWp6g3nr
         b91w==
X-Forwarded-Encrypted: i=1; AJvYcCWkpLznNeNxilprxgVFfB5YJ8D38FfjMiXk6blrrNn5Vg/eNvst3jIQ9/HaZfUeLGrMJKTx7o1i9yU=@vger.kernel.org, AJvYcCXOv3ef3Q7yXkZmlL8PgXnc2I6Iq9GsiNdM576mldfjg75IX0KaEO+mxk2PzfY1hjIa+BauMV4TZrXaYQXh@vger.kernel.org, AJvYcCXVUuKnAxA5yUC8zsfP60dPH89/cQepXlH+0Wtqwmtk3i5OYVQuozegaIrbK/BVXD1Jpz1VHMe/y7tftz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEpoXrMXqF1gaGZ+Bq4nG8zHJIGWIaD6yme4cv7TWG6tEAhwnt
	eRrTHtjVUc4zAHNuN1ho/4qfURlAaLFqCBooKD0qcebUvdmHXHBv
X-Google-Smtp-Source: AGHT+IGFkKeBqlPbwF8lTANmPR1IlCDV9Ofhr250qsjn3aBRkiCnIwM2GuAlJZCRXRbSEmjF9KKuIQ==
X-Received: by 2002:a05:6a20:c6c1:b0:1cf:4596:d486 with SMTP id adf61e73a8af0-1d30a9d6ac2mr15928045637.47.1727109853749;
        Mon, 23 Sep 2024 09:44:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b577sm14085247b3a.118.2024.09.23.09.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 09:44:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <64c3f6c3-10b5-44c6-a1cd-c796b770c904@roeck-us.net>
Date: Mon, 23 Sep 2024 09:44:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hwmon: (pmbus/core) improve handling of write
 protected regulators
To: Mark Brown <broonie@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240920-pmbus-wp-v1-0-d679ef31c483@baylibre.com>
 <20240920-pmbus-wp-v1-4-d679ef31c483@baylibre.com>
 <ZvFrWDF6Pn9zOb23@finisterre.sirena.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZvFrWDF6Pn9zOb23@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/24 06:21, Mark Brown wrote:
> On Fri, Sep 20, 2024 at 06:47:05PM +0200, Jerome Brunet wrote:
> 
>> +int pmbus_regulator_init_cb(struct regulator_dev *rdev,
>> +			    struct regulator_config *config)
>> +{
>> +	struct pmbus_data *data = config->driver_data;
>> +	struct regulation_constraints *constraints = rdev->constraints;
>> +
>> +	if (data->flags & PMBUS_OP_PROTECTED)
>> +		constraints->valid_ops_mask &= ~REGULATOR_CHANGE_STATUS;
>> +
>> +	if (data->flags & PMBUS_VOUT_PROTECTED)
>> +		constraints->valid_ops_mask &= ~REGULATOR_CHANGE_VOLTAGE;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(pmbus_regulator_init_cb, PMBUS);
> 
> I'm fairly comfortable with this from a regulator point of view, modulo
> the suggestion I posted in the other message about registering separate
> ops.  The fact that there's three combinations of ops is annoying but
> doesn't feel too bad, though I didn't actually write it out so perhaps
> it looks horrible.  In general removing permissions is safe, and without
> separate steps to remove write protect (which I see in your patch 5) the
> writes wouldn't actually work anyway.


I still consider the callback to be unnecessary, but I don't really have time
to implement a better solution myself. If you accept the regulator patches,
I'll have another look at the series as-is.

Guenter


