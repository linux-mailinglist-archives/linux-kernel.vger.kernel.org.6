Return-Path: <linux-kernel+bounces-399806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00049C0472
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52566282CA8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E857E20ADCE;
	Thu,  7 Nov 2024 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="baIei2VM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C755815B0F2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979958; cv=none; b=EcGnJcCmcq+YZ/YZy7P/asYDiMfmvMFlIRlTdWB1HqTCGMqcGaOIlJ5GqyEbfRwOPmHE3T17egovaZf6U4d+7JX63Ato/WMaIApe57nrJZMTqKiESXabMPstdN8pVsiAnEqHl6ht0wIWTJCyH+8LymBp0TiD8EwVmjNeh4rjk44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979958; c=relaxed/simple;
	bh=8o4ZlsbN/83dpA2r6AFMzSLTgFmivq5iT0OHld+yKi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEgCZa7t9zWv3VMHRvn2X0cgOn2fYDbiu3lYBNFEI/jE/M1qywtCVYu6mH5/siC47Nd9/q6cvTTHnf7EqZzQlIVrudBCGL2JoO8SD98YwAqiiFN6rULlgyR5Gdmb/jSvZpgeBk/zN2+mpA0NPCQhblmkaIUNTAURW1IkhtkrWdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=baIei2VM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730979955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bCnP9403Z99+tF9uquHAPYB7nlg8pf/oQAUghnzYyc=;
	b=baIei2VM3gne+xv8Cx1NbOwq4qFw8AJlGEbe0xEAN/sAYS5eOXRFIQBXhWlVVsY/RBv13H
	iBtgG5YwUAs+LLX895J7lIMlK9ASpgzsyLLyrK5YSXhffMdiaxCG/YpobLNfmFJnUGyUWN
	Xdt064Z+cYz0y6z8pqA2Pp6R4vWV9vg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-429bbWj7PG-RCzvpoViy1w-1; Thu, 07 Nov 2024 06:45:54 -0500
X-MC-Unique: 429bbWj7PG-RCzvpoViy1w-1
X-Mimecast-MFC-AGG-ID: 429bbWj7PG-RCzvpoViy1w
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a99fd71e777so75416966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 03:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730979951; x=1731584751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bCnP9403Z99+tF9uquHAPYB7nlg8pf/oQAUghnzYyc=;
        b=PvLuKBZsSJIkODy1T8VXKABuA32xs5q/GzTwkV/NyRt+LXbwhXIqAmJ+J7Tg/nOdbK
         Ac8HtGP/JA23bDSvbkNRlTpb3JBCvaxi2CCx/0p9zQJY6TiVHjCbxFoS6dwNNN23xRU/
         RYaWjxmSD6WwLgA6XxX1qu6uocKCRmhnAXozavWccJov8c7SbirdwoKzGZwnn0XxwH8j
         G0G2yf+NsOEa9u3fe+4/O+l5CrDLT2cWjbi6KdGsAldNL3j6V+Yww2OrkgCBH1V0gK73
         RzP/++0Kp5ognz8AvrAMfIJ5n1HjPQQsdIKJMPR69OeUqH5N1opN+p5jM78ouDKKPi4n
         p6vA==
X-Forwarded-Encrypted: i=1; AJvYcCVzVoJpdCo2FjTYFwDhRVZc5MI5VJUEnmn8dh8p9ME6dlCgIP1yWjI5BTa0TZC6NnpjveyND84JvZqVzno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1L29ZC2cZT4BygC2hK9kOIFUlcPwZT0CpeSN3X4+gKec/Ujfx
	12OIjvh+M7KGK0w4sosfiiODwQgXmAhNhA71jfgnvOd9nWTOTsGKwjrfT6G6Arj5G78Ouojz6Ep
	N3HEBtvn10s7mootmpCs02aGeP808Wq7XQQn+dRgx/lTLCu/LtTiuo615yb9aIQ==
X-Received: by 2002:a17:907:2cc2:b0:a99:f861:ebd with SMTP id a640c23a62f3a-a9ee74bbbd6mr71296566b.14.1730979951521;
        Thu, 07 Nov 2024 03:45:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjEa/cDXmsHFDdKP3G1NdW3oe41pc7rWH8MGIDNROSNf6aA07yr12W74sOrI2Q5jzUVRS7iA==
X-Received: by 2002:a17:907:2cc2:b0:a99:f861:ebd with SMTP id a640c23a62f3a-a9ee74bbbd6mr71292866b.14.1730979951055;
        Thu, 07 Nov 2024 03:45:51 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4b90esm83709066b.65.2024.11.07.03.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 03:45:50 -0800 (PST)
Message-ID: <028717bf-e10c-4876-9be4-1b41661c447c@redhat.com>
Date: Thu, 7 Nov 2024 12:45:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] media: atomisp: Remove License information
 boilerplate
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Jonathan Bergh <bergh.jonathan@gmail.com>,
 Roshan Khatri <topofeverest8848@gmail.com>,
 Dipendra Khadka <kdipendra88@gmail.com>,
 Sergio de Almeida Cipriano Junior <sergiosacj@riseup.net>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Kartik Kulkarni <kartik.koolks@gmail.com>,
 Kathara Sasikumar <katharasasikumar007@gmail.com>,
 Tchadel Icard <hello@tchadelicard.fr>, Kate Hsuan <hpa@redhat.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240923105539.3569110-1-andriy.shevchenko@linux.intel.com>
 <20241107123233.495dc548@foz.lan> <20241107124238.694fc4ef@foz.lan>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241107124238.694fc4ef@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7-Nov-24 12:42 PM, Mauro Carvalho Chehab wrote:
> Em Thu, 7 Nov 2024 12:32:33 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> 
>> Em Mon, 23 Sep 2024 13:53:06 +0300
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> escreveu:
>>
>>> We have the respective SPDX identifiers that are already being applied
>>> to the files in question. Remove the License information boilerplate.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> ---
>>>
>>> Here to fix one of the missed TODO item before moving from staging.
>>> This depends on 20240923085652.3457117-1-andriy.shevchenko@linux.intel.com.
>>> But can be applied before that (it's trivial to adjust).
>>>
>>>  drivers/staging/media/atomisp/i2c/atomisp-gc0310.c  | 10 ----------
>>>  drivers/staging/media/atomisp/i2c/atomisp-gc2235.c  | 10 ----------
>>>  .../media/atomisp/i2c/atomisp-libmsrlisthelper.c    | 11 -----------
>>>  drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c | 11 -----------
>>>  drivers/staging/media/atomisp/i2c/atomisp-ov2722.c  | 10 ----------
>>>  drivers/staging/media/atomisp/i2c/gc2235.h          | 13 -------------
>>>  drivers/staging/media/atomisp/i2c/mt9m114.h         | 11 -----------
>>>  drivers/staging/media/atomisp/i2c/ov2722.h          | 11 -----------
>>>  drivers/staging/media/atomisp/include/hmm/hmm.h     | 11 -----------  
>>
>> Hmm... there's no SPDX for hmm.h header. We need to ensure that all files
>> have SPDX license before removing the boilerplate.
>>
>>>  drivers/staging/media/atomisp/include/hmm/hmm_bo.h  | 11 -----------
>>>  .../staging/media/atomisp/include/hmm/hmm_common.h  | 11 -----------  
>>
>> Same for the above and for other header files.
> 
> Nevermind. I didn't show enough context while checking it. All files
> have SPDX. Patch LGTM.

That is good to hear.

Note I've included this + a bunch of other atomisp patches in an
atomisp pull-request for 6.13, see:

https://lore.kernel.org/linux-media/51e5e1cf-8aff-44fc-b40c-a0074a770a69@redhat.com/

(in case you have not seen that yet)

Regards,

Hans



