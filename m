Return-Path: <linux-kernel+bounces-335318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5BA97E411
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 00:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E812811F8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 22:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520813FB30;
	Sun, 22 Sep 2024 22:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6Z6HN4M"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240827E1
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 22:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727044303; cv=none; b=tElIYbZlbNwLbt8lTtLEl0VY+K7TJ1SNWI1NQVpbVxE038kEF29IoVvam5h/wkaF3Cr+I5yUt5qd5xQgE4OE+6iBI4CEx49JxKteKvE8AFmJVwE7sluyQLUNmkUXnM8uAdjMIQapaucvwL3oGKOpazi2mU5fn9DmhgL36fqO1w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727044303; c=relaxed/simple;
	bh=rVBZ1WjmuGuaX1OQeGTCMX8p0y7S0vBZ8P9pqnxA/Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwOuwQKJJL2tMcoZmJgZR/BFM/QUM6uWFDPrV990qcvc74CZr2v/fM4shKMN/m2Vdyvk2ZBg21jqc/vEcTFWAIcs5GHxJxqRcWVRZiMXn8lZFAN+bSVMYBiKClBLgGsgX0F4+R4LmsPBmLwXhss5MyLiiFFhRpp/cmPvBBOniqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6Z6HN4M; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2054e22ce3fso36138645ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 15:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727044301; x=1727649101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iosSBOxdVVQ4mK6DB/zc+u9Plvd1a40t5nm6TmD7C8w=;
        b=N6Z6HN4Mz0uP9ifNTagW4az2fUSNefMJtOmBa9QIGSJaXNAAj2lZ09fgEm7rj5H26B
         Pzejsv8r/kPbrNlMxsr/yJLatApgX00xhfWrhHSNWJsjcGEq/X7aBaV0mHV5QmGCmUKt
         fkCw8qu6MIByIIt7EQxBU4hVgtR38SVHi/sJ+NJ1BX3lGJXGaniOblg3nWDalcbX7Tqj
         5yIoplUH3DgOkMOv605Yw5IJTrZ/xmVlZAcbuPSnx0KIB2awb/rRW/kwTSkf/QcRmU5h
         JRmT6RRyJlz/zBjykR/FauSss+hLr1f9V+612+cgAJQRqob0+RSk2A761VOeRLaxk6lA
         +szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727044301; x=1727649101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iosSBOxdVVQ4mK6DB/zc+u9Plvd1a40t5nm6TmD7C8w=;
        b=nulOJYLEDNyDqbGtTB0au+X02Y/+GBDLZ+9GzXQFbttENupsYcv7KeQDJOQ13uzCTm
         2yuoQ+YRIHNGtPxU78d/p86/ZA2Xa2aCJa53+KAa57fpbLydCUa+jpSZWP6ijTsQ8WRW
         VySgpDZFEYYpvrzoOMgjJ0SrfySnR5jBMXT+Au7e7m/I/ltpPVPVpBK/PAVfmKUdFNPx
         1CzI2Eeg1qM4wGgM8rcPotOdeDqz1pAtKcQZuJP06EWX9OjjGT5B/dWvjzyEBHK8yai9
         AZIBJJTVRPRWQsReDx6t+uSGIWCb840AjGIar4INSLm1rhhCBV0l6Q85QXEQHta/3Bg4
         vRnw==
X-Forwarded-Encrypted: i=1; AJvYcCUFD00XNm6pns9pWZQ2iiV0u9NA+qrnLyalJoQLUHQQ9N9hr1n2DEWcfVdV2XBEprE9U5NFaRrB6d60fus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcrfar4WGDqL22fPkltx+zDgetmvbEwrGaMGr4UlZCvztVzi7w
	5IAb+5GLAT3l3SSaa6iH4ZGzIJoC40nr6ZDehDO7oq1V+7wNDYyp
X-Google-Smtp-Source: AGHT+IH6y3pmDxDlvdRxDXRbteGA5cKCIeqeUHlworuXmyj3UJaAJfjTnnzkGbIT5+sFvcoYWePXZg==
X-Received: by 2002:a17:902:e844:b0:205:7574:3b79 with SMTP id d9443c01a7336-208d838449emr159710575ad.25.1727044301336;
        Sun, 22 Sep 2024 15:31:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794601017sm123102435ad.85.2024.09.22.15.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 15:31:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 22 Sep 2024 15:31:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alistair Popple <apopple@nvidia.com>, x86@kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	max8rr8@gmail.com, linux-kernel@vger.kernel.org,
	jhubbard@nvidia.com, Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linuxfoundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org
Subject: Re: x86/kaslr: Expose and use the end of the physical memory address
 space
Message-ID: <ee205448-5fdd-495e-9d7c-c8a2b59f9c9e@roeck-us.net>
References: <87seve4e37.fsf@nvdebian.thelocal>
 <66b59314b3d4_c1448294d3@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpks23v.ffs@tglx>
 <87o75y428z.fsf@nvdebian.thelocal>
 <87ikw6rrau.ffs@tglx>
 <87frr9swmw.ffs@tglx>
 <87bk1x42vk.fsf@nvdebian.thelocal>
 <87sev8rfyx.ffs@tglx>
 <87le10p3ak.ffs@tglx>
 <87ed6soy3z.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed6soy3z.ffs@tglx>

On Wed, Aug 14, 2024 at 12:29:36AM +0200, Thomas Gleixner wrote:
> iounmap() on x86 occasionally fails to unmap because the provided valid
> ioremap address is not below high_memory. It turned out that this
> happens due to KASLR.
> 
[ ... ]
>  
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1826,8 +1826,7 @@ static resource_size_t gfr_start(struct
>  	if (flags & GFR_DESCENDING) {
>  		resource_size_t end;
>  
> -		end = min_t(resource_size_t, base->end,
> -			    (1ULL << MAX_PHYSMEM_BITS) - 1);
> +		end = min_t(resource_size_t, base->end, PHYSMEM_END);
>  		return end - size + 1;
>  	}

When trying to build arm:allmodconfig or mips:allmodconfig (and probably
others):

Building arm:allmodconfig ... failed
--------------
Error log:
In file included from include/linux/ioport.h:15,
                 from kernel/resource.c:15:
kernel/resource.c: In function 'gfr_start':
include/linux/minmax.h:93:37: error: conversion from 'long long unsigned int' to 'resource_size_t' {aka 'unsigned int'} changes value from '18446744073709551615' to '4294967295' [-Werror=overflow]
   93 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
      |                                     ^
include/linux/minmax.h:96:9: note: in expansion of macro '__cmp_once_unique'
   96 |         __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
      |         ^~~~~~~~~~~~~~~~~
include/linux/minmax.h:213:27: note: in expansion of macro '__cmp_once'
  213 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
      |                           ^~~~~~~~~~
kernel/resource.c:1874:23: note: in expansion of macro 'min_t'
 1874 |                 end = min_t(resource_size_t, base->end, PHYSMEM_END);
      |                       ^~~~~
kernel/resource.c: In function 'gfr_continue':
include/linux/minmax.h:93:37: error: conversion from 'long long unsigned int' to 'resource_size_t' {aka 'unsigned int'} changes value from '18446744073709551615' to '4294967295' [-Werror=overflow]
   93 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
      |                                     ^
include/linux/minmax.h:96:9: note: in expansion of macro '__cmp_once_unique'
   96 |         __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
      |         ^~~~~~~~~~~~~~~~~
include/linux/minmax.h:213:27: note: in expansion of macro '__cmp_once'
  213 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
      |                           ^~~~~~~~~~
kernel/resource.c:1891:24: note: in expansion of macro 'min_t'
 1891 |                addr <= min_t(resource_size_t, base->end, PHYSMEM_END);
      |                        ^~~~~

Guenter

