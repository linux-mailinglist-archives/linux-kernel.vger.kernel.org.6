Return-Path: <linux-kernel+bounces-247951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B27892D69D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC0B0B2C62B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B20198E93;
	Wed, 10 Jul 2024 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+5zVTK2"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857F2198E80
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629099; cv=none; b=XXUIQK/4doSgAv86pmNt5cJR/ic79FLqP6l1BEIN3lwc6PM39Bv6pgbB2HWnw+ixBqmQLl3W6S9CoL2UiCwN2rIWsimNp/MDEKF9iyq4DGpjsNKGq5P4v5nhC+6gud0Wnf9+aRYbO8V2TC40npJ9cf9PqLAzfCNT8n0OpPypkhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629099; c=relaxed/simple;
	bh=wMB6ffOH4zzKa3yoQT+9WAqc8SQ6K+qCARxI6+FuQgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXuuJ/RSkfpJOn4erFAWP6fJ6cVhMjhpcmzpxcPoJHmFSHcBjqCFKOmXy5/L1wPduL5zdsXGpRx9F2ozDeVgnULrfHeOJj8VdlLQCN0fW1/HPThyT0wDLxdvvrbeP8HJX0JbfSij56hgylbp6gH0koCxfWo3po4VLeb0/694n7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+5zVTK2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so1896694a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720629096; x=1721233896; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFxlOsMqy2T1bTm6nymFbY6yBbL0VdpobMbhBdfw3jM=;
        b=I+5zVTK2CbwN/kHIPsv+galqLLum0Y9F5JMdg7CX2/2e4txB7mS0CZxgJT/H/MsMLX
         LGWy7R39eQKTjEcBsSnVDVvxn5SQgDhTwTs/77kAMWDGAvxKgCuRpDGlLh+19MU600c3
         v4pCI1gEhjWldJpM3IMxnoommdzFOTKvLGEV8kFKzqwWbEunjYqGn6cxheGIFs8PJIDE
         xHIOU7EL5KtuYiv72iO9KgzwL1eKbKPA1v1sWYXJfhzFukFFGmWQNws/QlxTQVbE1Ul2
         6lAlNVZxvuuzls2qv11v5lw88iqyS8qfCstl7Hcv2hKsSUXhtqLeCvlgGbKIG37OtpBl
         GufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720629096; x=1721233896;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aFxlOsMqy2T1bTm6nymFbY6yBbL0VdpobMbhBdfw3jM=;
        b=phWqYoEQag02MES5XGzTueyCgHfdSTT356LBT8/cHNJET+OUsqLIjE7Q95hCoH3IVI
         PIrV0J6y9D5lFL8qJzWkh/5ZT2mpTxj+pkrXOgGvJarbYKxw+WDmhVXij0+GkArC/ydT
         GPt7g2lVG8VKCM8qLizFx3N5dnn0KC3aWHRnN5eHaFca9Av9GYjZJcVccwX3cHSlBmBO
         dLQs2IeVIj2WxX2fHtPCb4Slay54rKq0Z6gv+EBAkXkJYjo1PScwS7C+BYn1yekSMNy4
         tmaECNw3LhyKfEpMXvNjbSKV1TkWKQAYYeN/IxnRth9Tln348oek1g+rIsPecc0JHuOU
         6C5w==
X-Forwarded-Encrypted: i=1; AJvYcCUqmoFWDf4JidHj8npy0mVZZuym+cfeAOqOVosuTmDGKzK2GFr1nzB4Zr3yT8qoPWzUANvzfLuyuMWaGqQOFGQhGea3WbCEp4qTT08d
X-Gm-Message-State: AOJu0YxJSNokG6HEsWhB6ajzbuAUfBvXqmc5jyNWiFRZ5MfR23ua2kXI
	WuJKgu9X0HEmJVfNZMRzdnSH4qnFbglRneTmGjs++zEVD1xeqYgyI734FDJp
X-Google-Smtp-Source: AGHT+IGjXS/unGM247VI8FFw2SSzudpUQO77MxfYWHl3GuzqaKaUlZLaTbpxCAZjTadQ5zUdP0EWBA==
X-Received: by 2002:a17:906:c105:b0:a6f:20e0:1d1a with SMTP id a640c23a62f3a-a798a42f054mr15604866b.33.1720629095619;
        Wed, 10 Jul 2024 09:31:35 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bcc97sm172538066b.35.2024.07.10.09.31.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2024 09:31:34 -0700 (PDT)
Date: Wed, 10 Jul 2024 16:31:34 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux@rasmusvillemoes.dk,
	willy@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] radix tree test suite: put definition of bitmap_clear()
 into lib/bitmap.c
Message-ID: <20240710163134.a36xircnefbz5m6n@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240710095554.16725-1-richard.weiyang@gmail.com>
 <Zo6z_AuI6U8JBvfk@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo6z_AuI6U8JBvfk@yury-ThinkPad>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Jul 10, 2024 at 09:17:00AM -0700, Yury Norov wrote:
>On Wed, Jul 10, 2024 at 09:55:54AM +0000, Wei Yang wrote:
>> Instead of keeping a bitmap.c in radix-tree own directory, we can use
>> the common implementation in lib/ directory.
>> 
>> Just move the definition and link some related libs, no functional
>> change.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> CC: Matthew Wilcox <willy@infradead.org>
>
>Hi Wei,
>
>bitmap_clear() is not used in radix tests, and in fact not used
>anywhere in tools at all. Unless you have plans on it, it's
>better to drop bitmap_clear() from tools, instead of bloating
>the library.

I guess you didn't try to compile the test. After remove the bitmap_clear(),
we see this error.

cc -fsanitize=address -fsanitize=undefined  main.o xarray.o radix-tree.o idr.o linux.o test.o maple.o slab.o find_bit.o bitmap.o hweight.o vsprintf.o regression1.o regression2.o regression3.o regression4.o tag_check.o multiorder.o idr-test.o iteration_check.o iteration_check_2.o benchmark.o  -lpthread -lurcu -o main
/usr/bin/ld: xarray.o: in function `xas_squash_marks':
/home/richard/git/linux/tools/testing/radix-tree/../../../lib/xarray.c:139: undefined reference to `bitmap_clear'

>
>Thanks,
>Yury
>
>> ---
>>  tools/lib/bitmap.c                | 20 ++++++++++++++++++++
>>  tools/testing/radix-tree/Makefile |  4 ++--
>>  tools/testing/radix-tree/bitmap.c | 23 -----------------------
>>  3 files changed, 22 insertions(+), 25 deletions(-)
>>  delete mode 100644 tools/testing/radix-tree/bitmap.c
>> 
>> diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
>> index c3e4871967bc..a96dbf001244 100644
>> --- a/tools/lib/bitmap.c
>> +++ b/tools/lib/bitmap.c
>> @@ -100,3 +100,23 @@ bool __bitmap_intersects(const unsigned long *bitmap1,
>>  			return true;
>>  	return false;
>>  }
>> +
>> +void bitmap_clear(unsigned long *map, unsigned int start, int len)
>> +{
>> +	unsigned long *p = map + BIT_WORD(start);
>> +	const unsigned int size = start + len;
>> +	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
>> +	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
>> +
>> +	while (len - bits_to_clear >= 0) {
>> +		*p &= ~mask_to_clear;
>> +		len -= bits_to_clear;
>> +		bits_to_clear = BITS_PER_LONG;
>> +		mask_to_clear = ~0UL;
>> +		p++;
>> +	}
>> +	if (len) {
>> +		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
>> +		*p &= ~mask_to_clear;
>> +	}
>> +}
>> diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
>> index 7527f738b4a1..505cc24a8b9c 100644
>> --- a/tools/testing/radix-tree/Makefile
>> +++ b/tools/testing/radix-tree/Makefile
>> @@ -5,8 +5,8 @@ CFLAGS += -I. -I../../include -I../../../lib -g -Og -Wall \
>>  LDFLAGS += -fsanitize=address -fsanitize=undefined
>>  LDLIBS+= -lpthread -lurcu
>>  TARGETS = main idr-test multiorder xarray maple
>> -CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o \
>> -			 slab.o maple.o
>> +LIBS := find_bit.o bitmap.o hweight.o vsprintf.o
>> +CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o slab.o maple.o $(LIBS)
>>  OFILES = main.o $(CORE_OFILES) regression1.o regression2.o regression3.o \
>>  	 regression4.o tag_check.o multiorder.o idr-test.o iteration_check.o \
>>  	 iteration_check_2.o benchmark.o
>> diff --git a/tools/testing/radix-tree/bitmap.c b/tools/testing/radix-tree/bitmap.c
>> deleted file mode 100644
>> index 66ec4a24a203..000000000000
>> --- a/tools/testing/radix-tree/bitmap.c
>> +++ /dev/null
>> @@ -1,23 +0,0 @@
>> -/* lib/bitmap.c pulls in at least two other files. */
>> -
>> -#include <linux/bitmap.h>
>> -
>> -void bitmap_clear(unsigned long *map, unsigned int start, int len)
>> -{
>> -	unsigned long *p = map + BIT_WORD(start);
>> -	const unsigned int size = start + len;
>> -	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
>> -	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
>> -
>> -	while (len - bits_to_clear >= 0) {
>> -		*p &= ~mask_to_clear;
>> -		len -= bits_to_clear;
>> -		bits_to_clear = BITS_PER_LONG;
>> -		mask_to_clear = ~0UL;
>> -		p++;
>> -	}
>> -	if (len) {
>> -		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
>> -		*p &= ~mask_to_clear;
>> -	}
>> -}
>> -- 
>> 2.34.1

-- 
Wei Yang
Help you, Help me

