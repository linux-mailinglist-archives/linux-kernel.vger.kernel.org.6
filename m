Return-Path: <linux-kernel+bounces-572026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2BAA6C592
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE77188B028
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED026232373;
	Fri, 21 Mar 2025 21:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmnDSzR/"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944A61E51FF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742594327; cv=none; b=V4B8M4uWg5I4IUM0OCmD2UcI1maVl8fNrwWEf94LdWEYuIcchpS15YL3TwF8HxPcbBQwgWjYVYNTvSpSkcn7VV2JXcDRekvwQwVGi0Bpv8uCNR2i9IMlEjBl3V1rDFB00BT6S2F057nBlhn/5HmKIw9gtout1qCxm0gdc7bLJGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742594327; c=relaxed/simple;
	bh=MIySeDb+kreajrIhiKfxcsuyDCEoR7Qs/Ro0Lou5eIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DsshHKx0QYAtaRZdeP3oEfnMxpDukbkmvb+NDrJxJl6I8pEy1rn5alzmETwoK+p0HVyTN5tQTYHgNEVkyqqd4Qxmufz6diBA3X2kM7YGDlKpBPKBWDNY7slm8J+NY02LEOwYcUidyRPKvpx45qSIFV9ml+xYIYdyNWOJsYeIgWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmnDSzR/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so25680345e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742594324; x=1743199124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmVdno9JiW66EUzziccNjwwwsJPLYydEw+984DnsTqU=;
        b=MmnDSzR/Rp8OnHrUdd28FvtObKPf8vGbjQnEjfvBfHisShhnUC/T2kSkWoU9KE7A/W
         BuONqpVNN5FjTtM9Bzb/8XWh8L1EPhUUEg7w3zG4qoOE4CEBwykAVhY7zfbYGqL9p+U/
         ayzi5Ft08dg9hnDNZW6qq9FAT6Ru2XJZq6Z7huU/26KnFIpyd1UXR951MWpQ2SxugbeA
         TU84lkTM0BHgCAWOqFoftj/21A7tSLkfc78SQ+I2Z5OUQyB45XEnE79JNAr7wzCAkAZ6
         +qH7ENfe/AsfrIvBMoBox+KaLro/Gpov2hfZPLFt/l2Nb6TTb6KWsh37uoEAnynxUus5
         5cKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742594324; x=1743199124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmVdno9JiW66EUzziccNjwwwsJPLYydEw+984DnsTqU=;
        b=DVJaXn7GvWe/2Us5jvJQFQczIg/93pGP8jCiw+dc1LkI5PizIFeSGUdH1ozzQuAgL5
         MEfFjuGitk9UrorGvlPFfrzq87zehC8wbBeppc0kLIRHmohDzABW+rYkKmgNC2JRQslP
         SKu/Rmj7NMV+OXWFUp/LLqZSXR+Yf1LIufLAL4bnJM1wUpBS6kPPa00yalf84AZFuBaM
         2CAt9RmKRB9AKZ4JO4EbFN+YKMpXA2MOwETCmBe1rSs6ZdvpGFmakizCn3lScNikHZ7z
         5pfazPzbRQEqcvUHSRl+lJGWif5NVzTxmDuXb0ce06C7nWE103lnFs3Eho0STaOPgl5i
         dkvg==
X-Forwarded-Encrypted: i=1; AJvYcCWfYAzhUehWNjLal6PmxlvS87g30XEbYZ0RRkUUGmsN84tN53m4kLwo1aZ1cx+fX34PNzJdlhIQCH7Hx0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv5c+WP1eLiZ0afPkf+t+LZQan1GMIAH66Ffz1/8UQmiRBIH5T
	1LcN/jxUIuReLLDav4/JubsJzsHr/fDL8YEStosn/mB4gEQGhj8X
X-Gm-Gg: ASbGncvjfwQWHwkfF7MKdQa1LOg2Si+SlS5w/YwFGJNrXP98koXv93fLTaRSR5VoreU
	B9+IOPdOJksSpJBkPDa4JgIJ85rSyvaKYVovGbl/oeeOFote0icy0BkwH9rxM04BzIClK5Rk/9G
	uvxywG7vjoyuWwheA3MykgWKBQmANX0TkCQ/jo0unIU3TMwLv6vk81sPWTfl+WXufP32ENLehs6
	FSchVfZhxB2OwIoPo1jFGf6qjc7YFQn2Ohp0TAC4raABg75gS+C+gibp8TiFlWA5bu10eo2ooVO
	XkxU0kA0oFcqdSnYcN///69SHZtyGN75eMbiSIthJXFLJwBrK8Ej7j/98P1tzjCth69Dyvb7LOo
	3xkYZIWg=
X-Google-Smtp-Source: AGHT+IFeHoHB22UQipfl9400C+XWuP+arx3zZ+LkvJtYR63KKKHnv/Wd4J+oKhJ/M4esH4T5ibKoiw==
X-Received: by 2002:a05:600c:1d16:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-43d58db52e1mr6181575e9.21.1742594323421;
        Fri, 21 Mar 2025 14:58:43 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43fdeb79sm89798935e9.25.2025.03.21.14.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 14:58:42 -0700 (PDT)
Date: Fri, 21 Mar 2025 21:58:38 +0000
From: David Laight <david.laight.linux@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Huang Ying <ying.huang@intel.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: include/linux/minmax.h:93:30: warning: large integer implicitly
 truncated to unsigned type
Message-ID: <20250321215838.179be239@pumpkin>
In-Reply-To: <202503201231.VrUIFcq2-lkp@intel.com>
References: <202503201231.VrUIFcq2-lkp@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Mar 2025 12:16:57 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a7f2e10ecd8f18b83951b0bab47ddaf48f93bf47
> commit: 99185c10d5d9214d0d0c8b7866660203e344ee3b resource, kunit: add test case for region_intersects()
> date:   6 months ago
> config: arm-randconfig-r063-20250320 (https://download.01.org/0day-ci/archive/20250320/202503201231.VrUIFcq2-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250320/202503201231.VrUIFcq2-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503201231.VrUIFcq2-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/ioport.h:15:0,
>                     from kernel/resource.c:15:
>    kernel/resource.c: In function 'gfr_start':
> >> include/linux/minmax.h:93:30: warning: large integer implicitly truncated to unsigned type [-Woverflow]  
>      ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
>                                  ^
>    include/linux/minmax.h:96:2: note: in expansion of macro '__cmp_once_unique'
>      __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
>      ^~~~~~~~~~~~~~~~~
>    include/linux/minmax.h:213:27: note: in expansion of macro '__cmp_once'
>     #define min_t(type, x, y) __cmp_once(min, type, x, y)
>                               ^~~~~~~~~~
>    kernel/resource.c:1838:9: note: in expansion of macro 'min_t'
>       end = min_t(resource_size_t, base->end, MAX_PHYS_ADDR);


The error is because MAX_PHYS_ADDR is too large for resource_size_t.
The constant seems to have been changed several times.
But I don't see the patch that changes it from DIRECT_MAP_PHYSMEM_END to MAX_PHYS_ADDR.
I'd guess this is a 32bit build and resource_size_t is 32 bits but MAX_PHYS_ADDR is 64.

Who knows what the code is supposed to do, but it is another case of min_t()
discarding significant bits.

It might be that just using min() will fix the compilation and DTRT.

	David




>             ^~~~~
>    kernel/resource.c: In function 'gfr_continue':
> >> include/linux/minmax.h:93:30: warning: large integer implicitly truncated to unsigned type [-Woverflow]  
>      ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
>                                  ^
>    include/linux/minmax.h:96:2: note: in expansion of macro '__cmp_once_unique'
>      __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
>      ^~~~~~~~~~~~~~~~~
>    include/linux/minmax.h:213:27: note: in expansion of macro '__cmp_once'
>     #define min_t(type, x, y) __cmp_once(min, type, x, y)
>                               ^~~~~~~~~~
>    kernel/resource.c:1855:11: note: in expansion of macro 'min_t'
>       addr <= min_t(resource_size_t, base->end, MAX_PHYS_ADDR);
>               ^~~~~
> 
> 
> vim +93 include/linux/minmax.h
> 
> d03eba99f5bf7c David Laight   2023-09-18  91  
> 017fa3e8918784 Linus Torvalds 2024-07-28  92  #define __cmp_once_unique(op, type, x, y, ux, uy) \
> 017fa3e8918784 Linus Torvalds 2024-07-28 @93  	({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
> 017fa3e8918784 Linus Torvalds 2024-07-28  94  
> 
> :::::: The code at line 93 was first introduced by commit
> :::::: 017fa3e89187848fd056af757769c9e66ac3e93d minmax: simplify and clarify min_t()/max_t() implementation
> 
> :::::: TO: Linus Torvalds <torvalds@linux-foundation.org>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
> 


