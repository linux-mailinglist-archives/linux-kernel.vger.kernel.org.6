Return-Path: <linux-kernel+bounces-329423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCC2979122
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 15:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9315C1F22DB1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C6C1CF7BF;
	Sat, 14 Sep 2024 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mt2McpUL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEE51DDF5
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726321648; cv=none; b=Gq3f5YNFkuwuWMf8yEto/rBvDODRb7COBaMKosXyacwR3CcjUbZu4cfXWZ3x0FIK3xwBnjSU2XDZYwLgnH7xoLMpKUzAncyz5n3C8VL0OegZva5rBvINuByIT8NnhLzB6VSm3PmjA8PQt+pg5OdLTzMWl2ASPdTTuLX46TGnB+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726321648; c=relaxed/simple;
	bh=2aUSAWq9PMKnd3bXhMP4hf8KrWEx1Z33mDmimkWdq1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6N8PLhuE0oj6E+XI/oW1t8EDCZhGQKAuFh7nI+FAmN0ukwlnzVWU0pZOJcjDwMr25V//04KjH31guKXm1OFX1SiIogNnNl5FTYnyTgdINza6c6b6uspTurf+MQZf2Uzmo+ZJpMNZ/c+AJfdYF0Q3x9+/3+6UBZ1snzBlV/e1u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mt2McpUL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726321645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9UrBWJboZVlP+TK6YL/vAFOG1Z7ivRqSHOs6x+zzkZE=;
	b=Mt2McpULDcEn7wje8l61Hq1J7oT42CW/mR3a+89DSd+d08D8ZW58s9OJXk6n/bupog5dGH
	nkRzPovgKwu3JnKqOnUkz9mIlIXCrgSK/toKYM45rj2Gpvp/iE48jcQML5LegEPw04U/6S
	pt4sn7FisrNHGCxoP5ZmfaLFISdOLBY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-yjophCiYOcOFiG8WdAXWKg-1; Sat, 14 Sep 2024 09:47:24 -0400
X-MC-Unique: yjophCiYOcOFiG8WdAXWKg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8d13a9cc7aso172193866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 06:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726321643; x=1726926443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UrBWJboZVlP+TK6YL/vAFOG1Z7ivRqSHOs6x+zzkZE=;
        b=HsXSHCWKMZ/4J7zc5ymQJcN8kxh9QEB0qi9SaMi1y5MPtjB0DpJBge3ZxrLoqWBu8p
         p9AThYU4G0zhCnqmlvvJrDqPiKTFli8axSvAw18+BxKUBnkC8n8iqOlXcC4c5TnVCrjj
         HQS388Lf7fNBSUD1Emh7n0RQ8+aPE0Vrv1riXUnWJD7yaUNGjjWq0BX1yieQIgksQ+U7
         xb53ttJQ+FBlfhL2zeINV6lokNrkXS4lo8VpJsbm8sx6MPKgSiFqszBc0a6YtBobpvbk
         xO+OGArjp4qqUIMdl4IV9qsTvonzXLzn0ZJ+h+tWMIo8OyxIi7xLF5lYKVZX2YSIceXg
         vD5g==
X-Forwarded-Encrypted: i=1; AJvYcCUVEDLFhoWLGUhkutARammiKmkARPLeKRn415sDNwceSvNp6JhhxS6jmttgEFe17QDHHzoyT94MP8gDKrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDFSCu04fXclXcFbvWev1kkuMnxwcO9n4VVTG5OCztnCIZPuZI
	mq/50uzg1+YLjpSS2cL34X6ESQjKGHdkNuCDdVbLOyR1MJLeHY5gFHjApwHqiFSh4Q9uczbSf1u
	/t7WxzKaWf8qdvm8qskbSNOV0rq9/okxk+/12msaI6Etx9ByE4z2rYpGRsSWiPw==
X-Received: by 2002:a17:907:97c8:b0:a7a:8c55:6b2 with SMTP id a640c23a62f3a-a902946e6b8mr992195866b.14.1726321642867;
        Sat, 14 Sep 2024 06:47:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeVtEl540QCdPDElJLsU+3E7gzfPsv+l59/grcOEsHW8pUQY8YIvfpkxUhpKZYk2He3o8c3A==
X-Received: by 2002:a17:907:97c8:b0:a7a:8c55:6b2 with SMTP id a640c23a62f3a-a902946e6b8mr992193366b.14.1726321642300;
        Sat, 14 Sep 2024 06:47:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610968adsm82960966b.7.2024.09.14.06.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 06:47:21 -0700 (PDT)
Message-ID: <aac0e587-3770-43c5-a9b1-4da4890c979a@redhat.com>
Date: Sat, 14 Sep 2024 15:47:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] iio: imu: kmx61: Drop most likely fake ACPI ID
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240911213110.2893562-1-andriy.shevchenko@linux.intel.com>
 <2b847413-f8ee-436c-a635-f5a36253e953@redhat.com>
 <ZuQGnqgdkJhyIiLK@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZuQGnqgdkJhyIiLK@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/13/24 11:32 AM, Andy Shevchenko wrote:
> On Thu, Sep 12, 2024 at 03:52:34PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 9/11/24 11:31 PM, Andy Shevchenko wrote:
>>> The commit in question does not proove that ACPI ID exists.
>>> Quite likely it was a cargo cult addition while doint that
>>> for DT-based enumeration.  Drop most likely fake ACPI ID.
>>>
>>> Googling for KMX61021L gives no useful results in regard to DSDT.
>>> Moreover, the official vendor ID in the registry for Kionix is KIOX.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Thanks, patch looks good to me:
> 
> Same Q here.

Yes I did look for KMX61021 in my DSDT collection and I did
not find anything, neither does:

https://www.catalog.update.microsoft.com/Search.aspx?q=kmx61021

find anything.

So I believe that this one can really be dropped.

Regards,

Hans



