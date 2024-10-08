Return-Path: <linux-kernel+bounces-355211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E58994BA3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17E71F27D12
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 12:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EF71DE89D;
	Tue,  8 Oct 2024 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p/CjKDDQ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5512F1DEFE0
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391481; cv=none; b=bnYGZQrb2Drz32XOXcdG+m3are9tYS+7h0tCd4TI1acKJRM0Lkhs9MtJRL5qQ2OFNxCYMT3R36LBEo6nUjZfayHP1nQceS+4wpGOG5k3DwDXULChUE+N/HB/OfJ/zzbJ1s0KsUDaiiEDvsFD8pY8FvpmhOzcPsJygTgz4uPjRtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391481; c=relaxed/simple;
	bh=qSOpSf+YsWDnlVAfQYKdd58y+jL1GlvU2G/SV+Dza6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PKRUmDub+OTEZ9hseEMfyqXSI+UfsLxQmPRr/fusX1YX1eJFZoo7cqwIqtT42QIgpV3yUSUGY3HxQyh7PhxLLNFUCK/wQaZiiWYBHIFa4RkHlzLBKsHzQ1W06rWF5cjZCpNR+VXg1X1XiQJYVWVCaZsyKBCEf3URGTNvjfPlv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p/CjKDDQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so52147005e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 05:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728391478; x=1728996278; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7e4/3Ls3/aNu9dK/eI4vdsZOolZWQW7jGRlN4Q4ST1w=;
        b=p/CjKDDQffUUZoawcEzetWTaqM9zwFMqgqhg3QQbM8WqZH1OED1VwkDrgBXHSuyfWK
         OHpAUVMMSWm4gakTI9ncUIpcqxqqf3x16mKiTdtmcsKjE7EXKeHBZVRqftJ5aZ3otnJ0
         0ZRNnjoulywrSfykMvu24zs5AlS78MNCbqoHdOxS/ho/R8VDxoOniDSa/2+A9z6jCxIO
         OFogICgAPWNJRZqpiL8HFPDgFZc7j2SELAOBf4sNANiJN8mAXDLlNptN5mPCc+j+BNTK
         Co5ReAEwlsGqWmCDYkZUNgwf0yBAr62sw0FDEU1AgJFGE4dtDqr1FY1sbYxWNmP88CT5
         +9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728391478; x=1728996278;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7e4/3Ls3/aNu9dK/eI4vdsZOolZWQW7jGRlN4Q4ST1w=;
        b=vJp4jGGxTLSZJ6LxvmqWUJZ5goTgTmlkk2TnbQlmaatj0zvCLZnMMysFnpD1ZJMsFp
         gy4CyO0z74U1FNuwv8frGK8yLuakHv4WXILuQi2BNCvr6C0Cr472IJlUh6gr/cyibTvl
         eNs61VqCqiQgfm9oe97m0nlXz6fi1oi8BisaczWK+cFrMdNZ9K0KrU45ps99X/VwjMFl
         3yIU2pWZwFZrX+qZROlnqiTxcEpu8XAeBMIE9QZSPCAME4MD8euvP3c1Y38lCuRaXg+p
         SNVNipWDdvdq+7GI0LWZ8xa7x5+e0sd6lrkAsNvX57LZiMTamK5GtIqkKA0GinyOyK0c
         RQOA==
X-Forwarded-Encrypted: i=1; AJvYcCWqjDxE+WZoTEWkB4VxwN1vbw/GyAUTOVGy6OBBbA6Bw6pchgwrwhjTilYfP6l8JKtUeoPhP598vHJBeuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFWabz25EYpNqS4QE+3Ie+2LFU1n2i2yCLTjSGlu4XTOAUsnrk
	Nqwtp9paRjEvXw54qd3FSM+esWOme8ioguZn3EaTfTQ2YicxcoDjA3o/BEgNwSs=
X-Google-Smtp-Source: AGHT+IEsuASKpxtLN1FS9/ppE/nSGh27N+1yhlWxNalTb7cFM5CXlhMi6qIJJ4CYFTRupQZK+UJsOQ==
X-Received: by 2002:a05:600c:1907:b0:42c:bb96:340e with SMTP id 5b1f17b1804b1-42f85af89ebmr118622545e9.31.1728391477489;
        Tue, 08 Oct 2024 05:44:37 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:41f2:4244:ce34:c273])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89e832fesm109260625e9.8.2024.10.08.05.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:44:36 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Brown <broonie@kernel.org>,  Liam Girdwood <lgirdwood@gmail.com>,
  Jean Delvare <jdelvare@suse.com>,  Jonathan Corbet <corbet@lwn.net>,
  linux-kernel@vger.kernel.org,  linux-hwmon@vger.kernel.org,
  linux-doc@vger.kernel.org
Subject: Re: [PATCH 4/5] hwmon: (pmbus/core) improve handling of write
 protected regulators
In-Reply-To: <64c3f6c3-10b5-44c6-a1cd-c796b770c904@roeck-us.net> (Guenter
	Roeck's message of "Mon, 23 Sep 2024 09:44:11 -0700")
References: <20240920-pmbus-wp-v1-0-d679ef31c483@baylibre.com>
	<20240920-pmbus-wp-v1-4-d679ef31c483@baylibre.com>
	<ZvFrWDF6Pn9zOb23@finisterre.sirena.org.uk>
	<64c3f6c3-10b5-44c6-a1cd-c796b770c904@roeck-us.net>
Date: Tue, 08 Oct 2024 14:44:35 +0200
Message-ID: <1j5xq2sr0s.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 23 Sep 2024 at 09:44, Guenter Roeck <linux@roeck-us.net> wrote:

> On 9/23/24 06:21, Mark Brown wrote:
>> On Fri, Sep 20, 2024 at 06:47:05PM +0200, Jerome Brunet wrote:
>> 
>>> +int pmbus_regulator_init_cb(struct regulator_dev *rdev,
>>> +			    struct regulator_config *config)
>>> +{
>>> +	struct pmbus_data *data = config->driver_data;
>>> +	struct regulation_constraints *constraints = rdev->constraints;
>>> +
>>> +	if (data->flags & PMBUS_OP_PROTECTED)
>>> +		constraints->valid_ops_mask &= ~REGULATOR_CHANGE_STATUS;
>>> +
>>> +	if (data->flags & PMBUS_VOUT_PROTECTED)
>>> +		constraints->valid_ops_mask &= ~REGULATOR_CHANGE_VOLTAGE;
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(pmbus_regulator_init_cb, PMBUS);
>> I'm fairly comfortable with this from a regulator point of view, modulo
>> the suggestion I posted in the other message about registering separate
>> ops.  The fact that there's three combinations of ops is annoying but
>> doesn't feel too bad, though I didn't actually write it out so perhaps
>> it looks horrible.  In general removing permissions is safe, and without
>> separate steps to remove write protect (which I see in your patch 5) the
>> writes wouldn't actually work anyway.
>
>
> I still consider the callback to be unnecessary, but I don't really have time
> to implement a better solution myself. If you accept the regulator patches,
> I'll have another look at the series as-is.

I'll group the regulator patches and resend to Mark, adjusted as
requested.

Guenter, should I the resend the hwmon patches here grouped with the
tps25990 series ? Or is there something you'd like me change before ?

>
> Guenter

-- 
Jerome

