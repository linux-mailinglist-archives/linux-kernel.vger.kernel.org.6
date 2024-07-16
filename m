Return-Path: <linux-kernel+bounces-253213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57975931E36
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C6F1C218F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 00:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE90B33C5;
	Tue, 16 Jul 2024 00:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa7HPgLZ"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F643FD4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 00:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721091544; cv=none; b=r3pQ4bRpjeHAMkOaPGFZBUAwTZ+yjyXnBLAEsRqN0ryg5LGTMjCYM8UONoPLMP3PuZy1tqqK1tECGmNZJqIjvCL5aPwo2IpBR3Q5OuMtYgJH8aqJhYgWORpm9KRTIsMDgnaJzWxqaA0jTeXt6caoF2WaqqjwZuaZEKD/MXZT0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721091544; c=relaxed/simple;
	bh=5/3XMi0sWjH0usNMkH3l2OHbSJdTb8+mblQfHS6NEc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXQSCxI0VXEOP2W6ASk/LDysovRPToNHfRmH4Fo1jBsNQUojIqX9DNv65xQi7qP2PQleJ51XPGRQJ1zPVlQhE7SpSSD3yohkzgYUepbG1P5lLe6tmiFqSjV9kLw5jIHXxDGsFMAX6BynL8Nj10WYVLo7l0cTVHdR6LjFNUyzXSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fa7HPgLZ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa6b3so3260907a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721091540; x=1721696340; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUxVHzmi756PDihJ0U17OMpQG/MHUV3/or5nWPlSfz8=;
        b=fa7HPgLZVBeASbq6zoRXQI8R4VWsLi07ZZJgaLpPjYxdKhJ3OMl8dtEbQOzYo7JkYO
         n/eRmavks9nHcespwEIAB5IBWADwgvkaPsXi3K2WtM3N5Yc2siAoxfVP6qcrEO1NJBhE
         4+oVBgnxis2yoe1bPvcMr4mz1lU8qMDIwWpKqWCAdx5+EylP3tCXVBfk3zG/thDvJ0lt
         fT6G9yAw83CQRE4UIjvmufhV7KbB7S5FdSQ86ahAbqFwk+1vqVW1kucM+E+gRBAn0pky
         FvM/ePciv8n5XbbrpEdfG7amERRNn0WefOtEJeeqZ1du8NRM9L3TRnm+MUbtDjobC7up
         oz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721091540; x=1721696340;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VUxVHzmi756PDihJ0U17OMpQG/MHUV3/or5nWPlSfz8=;
        b=IjMHwnDgEYa9k9d+Htm45BnYW4xJeknfk1R9CvWS+GNMSxV5R9rA1IFX0hco9r1xZ7
         vja9KaHInd73BPQ+tWFwWznvJ+obHoVABFjDaAafr6iHr2LYjxOFJFGqHfIZQKx+qeU1
         YzEddmCi/ZKkisST2lEpjAVqbJZL4V5i4SkIhraVey3c9nzGcmpsoet40pzcBzMYnMZp
         GCw9/H6CgTxa2W6M6QATcfrhMva3EN22hYDcb2muNmEzie83hxXeSiDzOcYhH64d5KgL
         iG916YSP27U1QkHvyJqEv0JR9ZhnV8Dl8awDKjJF+KaYxewU/GUVmwJeoy90E0NwZckY
         6Urw==
X-Forwarded-Encrypted: i=1; AJvYcCV4jCboZCSlIOCFU1u88h3VUfOR8pNzOOQv6UnK/W92SBRGxWrRYCIdquWWQ+ss4uoZLOb0gRbnNRcX5BjajSDcaKd8Elfq08cnpZKE
X-Gm-Message-State: AOJu0YxyCNHkTHIBIHNvfkwSulZTM1GcJfdR9kashUrwzJqf5ChGdp0z
	dKVE6VggEbE1E4xdADmJ+ELkLi5mtJiAecPHhYrWV5PvJ6inKBg2UzNy3w==
X-Google-Smtp-Source: AGHT+IG7mai8zmLYQYE4GTwFAEr0+juBlGB0mKwmbkeqCqyoSvdPIHCUPdgX/PQOfRNOJQonzmug1Q==
X-Received: by 2002:a05:6402:34c5:b0:57d:1696:fd14 with SMTP id 4fb4d7f45d1cf-59eeda75044mr352917a12.8.1721091540170;
        Mon, 15 Jul 2024 17:59:00 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b24a76fc3sm4063121a12.9.2024.07.15.17.58.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jul 2024 17:58:59 -0700 (PDT)
Date: Tue, 16 Jul 2024 00:58:59 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/2] radix tree test suite: include kconfig.h with
 incomplete path
Message-ID: <20240716005859.ldmkuqutcail27in@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240712074151.27009-1-richard.weiyang@gmail.com>
 <lj3rlnhffccwunowrjvk7i6pq6gcpg6rzdmvspwhjdiqfmfvob@a45kjy2du77z>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lj3rlnhffccwunowrjvk7i6pq6gcpg6rzdmvspwhjdiqfmfvob@a45kjy2du77z>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Jul 15, 2024 at 12:17:44PM -0400, Liam R. Howlett wrote:
>* Wei Yang <richard.weiyang@gmail.com> [240712 03:42]:
>> The include path indicates it is the kconfig.h in tools/include/linux.
>> 
>> Let's use the same format as others for better reading.
>
>nack
>
>This change stops using tools/testing/radix-tree/generated/autoconf.h
>which is included from kconfig.h.
>
>If you add an #error to that generated/autoconf.h header, then you will
>see it will build with your change, but fails with the existing code.
>

Thanks for your review.

>So this is not equivalent.

BTW, if I am correct, the difference is introduced by patch #2. If I just apply
patch #1, the #error in generated/autoconf.h works.

Patch #1 looks good?

>
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> CC: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>> CC: Matthew Wilcox (Oracle) <willy@infradead.org>
>> ---
>>  tools/testing/radix-tree/linux/kernel.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-tree/linux/kernel.h
>> index c0a2bb785b92..fab6f47a9472 100644
>> --- a/tools/testing/radix-tree/linux/kernel.h
>> +++ b/tools/testing/radix-tree/linux/kernel.h
>> @@ -11,7 +11,7 @@
>>  #include <linux/err.h>
>>  #include <linux/bitops.h>
>>  #include <linux/log2.h>
>> -#include "../../../include/linux/kconfig.h"
>> +#include <linux/kconfig.h>
>>  
>>  #define printk printf
>>  #define pr_err printk
>> -- 
>> 2.34.1
>> 

-- 
Wei Yang
Help you, Help me

