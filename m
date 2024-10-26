Return-Path: <linux-kernel+bounces-383120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C69219B1786
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A58A1F22813
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2181D4141;
	Sat, 26 Oct 2024 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSH9TFfK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B84038DD3
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729942965; cv=none; b=jh0AzQbGBfgEE5CC7nbcsCuAsmBdSIo70De66dLzXfg6Jz59r6fq9Gjd7+SzJDfGfqbZ0qJjhwPOlhkrwRg14/gLe3xS0V5Wq/yhpPEdf+iNVGR+L0R6OoNC7chaNHbGCwHSsjEoF8EYFIfZzlsIH/gY1wZx2zt8l3KdMr3ytUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729942965; c=relaxed/simple;
	bh=UXnwYNqnbA2f/5vBTTn3W2mCdqeP+9kY67aQu8EF9+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTNBSqUscM5ZFZlBnhSrDxiFNwiyyPO/fdIVL7BsKZGONv5WehiRztaKf/9j9sT8IsCv0KODCIbnSLWwHiC6KIb24Rvn2iWhZahMYiA0uQg/Ru0rwrpq8kzX5ACEgDcAhm+6rK07jmzMmRbZ1I4+niQmnxBGc3rlVBCltgzJwQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hSH9TFfK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729942962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YdLF7tRRqZiO64kQMK0GUfuU+omwTP3Miq5HRef8bJQ=;
	b=hSH9TFfKJzWYCbE0Yvq/trxUHlhuExsGfjAXqpPKsZiXqguGxri1+YWAG2TgnceSqoOb8a
	Knw+t7KbgOLIArejLKKzI2/R+n9UYd0EPzMj94O6cFVegFz+btC9tgnVwurW7imxw8Qlwd
	my2+E9RqYD7cRJULxoE5P1Ygk0/eNkQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-lmbLgYkcOSaYxLFj2qUVdQ-1; Sat, 26 Oct 2024 07:42:40 -0400
X-MC-Unique: lmbLgYkcOSaYxLFj2qUVdQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9a1b8d4563so96375466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 04:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729942959; x=1730547759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YdLF7tRRqZiO64kQMK0GUfuU+omwTP3Miq5HRef8bJQ=;
        b=v9mrK+AS8P+iciJxP9jv+ucYMaQvYmjskcOeJI+TQYpGXRrRmKrXP4yK+R6olRZr8R
         2pvyjM02hhfOyesgIA1chNjx9BdZZahQ/PDKAeGp0N2jpNlvMEH1T39UlUymwl6iWEGw
         bA85wO7LZd0g1brBaU7/b/rmtXTR/1pQaP4rNrLoUU9XEpb4P+6L4G86RMacLxn/FfAX
         YmS1gDNyMgPbMhAA7a3J9R/dQOF2S5Ll1t61x3oIP/znQiEyHFKFP/1Q7gXKoFcYZai5
         UbLaSTMU17TMa+uWbjOvd8eydloWJEQwSxVbS5b8POASimwrCg6FL5eQYriIfWqpxvbw
         bvWA==
X-Forwarded-Encrypted: i=1; AJvYcCX65cS3UdsJHfPk6xLK2aSJq0DD2WYhLyuzOzCYEQB+UCTkRDfkqJf+WE2wqHhgluiBokN7JrQSDGaFpX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfRkFlNIujnOS8EzymiOvDNkdjPOQKBSOG7a9O5nuuHB+XEgYs
	jYDEnOoQKJbDMT7DAMamdgzuAQ9XgtSQOFzOrGvIjqatm5ckb4VWM+fhhZdNx0Ds5GYHkREs7KH
	D1w+xESuNSvD+3Gi57GjdirhhYiCJKCoxhJ+Mwz7DTP0+h3caAUGbZqCkSVOODA==
X-Received: by 2002:a05:6402:234b:b0:5c9:4b8c:b92e with SMTP id 4fb4d7f45d1cf-5cbbfa72dc0mr2726501a12.26.1729942958788;
        Sat, 26 Oct 2024 04:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZmhEgesWlCkWYclOufnmQ0f+NWGqpydoGczFg74wbrI9DsaXLnORpdpOq7ITJyaZ2BtinVQ==
X-Received: by 2002:a05:6402:234b:b0:5c9:4b8c:b92e with SMTP id 4fb4d7f45d1cf-5cbbfa72dc0mr2726476a12.26.1729942958287;
        Sat, 26 Oct 2024 04:42:38 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb631a1d1sm1454796a12.64.2024.10.26.04.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 04:42:37 -0700 (PDT)
Message-ID: <56c4e49a-b729-4332-b7d2-d8d51edcbd2e@redhat.com>
Date: Sat, 26 Oct 2024 13:42:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: intel_soc_pmic_crc: Add support for non ACPI
 instantiated i2c_client
To: Andy Shevchenko <andy@kernel.org>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
References: <20241025083712.15070-1-hdegoede@redhat.com>
 <Zxuc1HWTIiUJ3Rwo@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Zxuc1HWTIiUJ3Rwo@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andy,

On 25-Oct-24 3:27 PM, Andy Shevchenko wrote:
> On Fri, Oct 25, 2024 at 10:37:12AM +0200, Hans de Goede wrote:
>> On some x86 Bay Trail tablets which shipped with Android as factory OS,
>> the DSDT is so broken that the PMIC needs to be manually instantiated by
>> the special x86-android-tablets.ko "fixup" driver for cases like this.
>>
>> Add an i2c_device_id table so that the driver can match on manually
>> instantiated i2c_client-s (which lack an ACPI fwnode to match on).
> 
> ...
> 
>> +static const struct i2c_device_id crystal_cove_i2c_match[] = {
>> +	{ "intel-crystal-cove" },
> 
> Why this can't be "crystal_cove_i2c"?

It can be any string as long as it is unique. Typically this will
be vendor-model-name though and having i2c in there is a bit weird
since this is used for the modalias, which gets prefixed with
"i2c:" already.

Therefor I would prefer to keep this as is. But if you have
a strong preference I can change this for v2.

Please let me know how you want to proceed with this patch.

Regards,

Hans



> 
>> +	{ }
>> +};
> 
> ...
> 
>>  	.driver = {
>>  		.name = "crystal_cove_i2c",
>>  		.pm = pm_sleep_ptr(&crystal_cove_pm_ops),
>>  		.acpi_match_table = crystal_cove_acpi_match,
>>  	},
> 


