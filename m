Return-Path: <linux-kernel+bounces-203375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11008FDA16
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39583285174
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1292A160793;
	Wed,  5 Jun 2024 22:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gydnjiFw"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98915FA60
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 22:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627952; cv=none; b=m+Up28SoJUwqKeuzslKQBegDZ6d6e1gzAtkINn2E1Iu8Xf9mLu9Ri/yOOnxJVhWo5Q1H7yIlZkjny3cJ0owW3XD/AVulqiOe3hmbdVAio9vFGITQIQeOwDx+s0SPK/6+aO8lERxKZVn6Z06XCI38aHqj9yG10Tokodo7pvDkAnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627952; c=relaxed/simple;
	bh=0cwXZcxCdrSifwf2gN5a3Jk2vxotO1McJQe9I4GT33w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA6ZKWuEz7PH7bhQWhp+3zVjBxMkNsoSpm61a/V5Nmpkz+k8jpFVx+NiNjMOQIl77OKsBit3jYCPmB9wSlFX0wWDLl5GLNdPfEDdPlLsN6NNdfaZrAtRf2Crn6MxjdqoRMwVTcXlEg21OeZTbs+opgIZqK4SnvB2YBJkor1qbmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gydnjiFw; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7eb3a84d7a9so18536839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 15:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717627948; x=1718232748; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YSDCArb6+iGdyUdtqqd9pStleb4MvKmGGngMGBUDMQA=;
        b=gydnjiFwWdWgI78Oan8/iFBzvGtUlt3FqdFHLwEzRYW1Oi6vguCOexG3qCoAh8a+au
         ANsFY0RGRLbjt0e3H3BKzTb1neJWsf8dK0LlevPhCKpdr0n+BBuFoLoCk55+nJzCemoe
         T4UQFghBvSrVKmoI+ID1I02OjHeD52VaSQ8HchFZc1kcc5MBA3jmU3rEPIO3FqvBcOA4
         mw7+9sGUVQ2UVPtFSdxZg0HSLYcU9bnyFLQBqe35ceDKOwwGYLH9nNIz0hxW1G8l/xmJ
         CfYSUGsZzBIlK5AEj2rHuD+oH3GSZNUKgU5tpXwL8JhnZmPZmzyuRyZL88W9M4/eSR6Q
         qZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717627949; x=1718232749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSDCArb6+iGdyUdtqqd9pStleb4MvKmGGngMGBUDMQA=;
        b=aVSKkhd15U1LTpIlKuXONvQxhzb+UmgUADRXTUX+fFRyqZrVFFkNPKNFyj5yEPEf2M
         kn5ezQpr8EVNdWV+HZItncsZpu9p4mIzKHMviP0PVekYbZqmuH2FVssJSk4aL7NFHMaB
         MgwHvBORVk7w6b9NrTQPuqabyJ6+MmINUCRB8V/5iAsp5VCWcj1oRp0O+dK7QfKUP1lQ
         HkH6v9lhjm+vf9BwS2OBOR6M7TYzguTi187wEUNqYtJJznr0imBqfN9jle4z/pB8arw2
         HW1lf0fh1I0Sz4yvrOXY6a8tM0Zx1i9IamAy4ffaRG5ZugQ3h2Ix19Tq3/rLZ/DrVA5u
         dwaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaR+D8gBkL9dSvCCHcHxaW2haJXWj1zKRo3dAfsFuoOrJwqYOpKeB4bW1GmkN8q6YDrfcyWbFHkaw5OJPB38sHmu/wOX+THJhVIEqY
X-Gm-Message-State: AOJu0YxHjVt2xXScJFY3nEM1TiFCZxHkI2ixUothPWWRpFfsQDDX3FdB
	SfSxBYGW6u251YVo8WcfkYZuq1swj6S7CQ019zBihelbxDPHYVx9hr9frtmWow==
X-Google-Smtp-Source: AGHT+IGzKiuu7Olg+ErkMrLVtXTStiQhWRPUfQmlopnZPzGP8VPYwj/Ku5f0IqDPhNz9a6uiFJwWyw==
X-Received: by 2002:a05:6e02:1fed:b0:374:9c23:a06a with SMTP id e9e14a558f8ab-374b1ee216fmr42265675ab.6.1717627948503;
        Wed, 05 Jun 2024 15:52:28 -0700 (PDT)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de28f37482sm47423a12.94.2024.06.05.15.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 15:52:28 -0700 (PDT)
Date: Wed, 5 Jun 2024 22:52:24 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, llvm@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v1 2/2] selftests/mm: Guard defines from shm
Message-ID: <ZmDsKBrkh43-Zn8H@google.com>
References: <20240605223637.1374969-1-edliaw@google.com>
 <20240605223637.1374969-3-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240605223637.1374969-3-edliaw@google.com>

On Wed, Jun 05, 2024 at 10:36:35PM +0000, Edward Liaw wrote:
> thuge-gen.c defines SHM_HUGE_* macros that are provided by the uapi
> since 4.14. These macros get redefined when compiling with Android's
> bionic because its sys/shm.h will import the uapi definitions.
> 
> However if linux/shm.h is included, with glibc, sys/shm.h will clash on
> some struct definitions:
> 
>   /usr/include/linux/shm.h:26:8: error: redefinition of ‘struct shmid_ds’
>      26 | struct shmid_ds {
>         |        ^~~~~~~~
>   In file included from /usr/include/x86_64-linux-gnu/bits/shm.h:45,
>                    from /usr/include/x86_64-linux-gnu/sys/shm.h:30:
>   /usr/include/x86_64-linux-gnu/bits/types/struct_shmid_ds.h:24:8: note: originally defined here
>      24 | struct shmid_ds
>         |        ^~~~~~~~

I also hit this issue while using bionic. I have a thread reporting this
issue here: https://lore.kernel.org/all/Zl4LC9lTNptB2xTJ@google.com/

According to Andi Kleen, glibc and others should add these defines in
their headers. So it make sense to me that we would need indefs to
prevent a redefine macro issue.

> 
> For now, guard the SHM_HUGE_* defines with ifndef to prevent
> redefinition warnings on Android bionic.
> 
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/mm/thuge-gen.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
> index 034635317935..d50dc71cac32 100644
> --- a/tools/testing/selftests/mm/thuge-gen.c
> +++ b/tools/testing/selftests/mm/thuge-gen.c
> @@ -34,10 +34,18 @@
>  #endif
>  
>  #define SHM_HUGETLB     04000   /* segment will use huge TLB pages */
> +#ifndef SHM_HUGE_SHIFT

nit: I see this file uses the form "#if !defined()" above for
MAP_HUGETLB. Perhaps it makes sense to use that and keep things
consistent? I'm fine either way.

Reviewed-by: Carlos Llamas <cmllamas@google.com>

>  #define SHM_HUGE_SHIFT  26
> +#endif
> +#ifndef SHM_HUGE_MASK
>  #define SHM_HUGE_MASK   0x3f
> +#endif
> +#ifndef SHM_HUGE_2MB
>  #define SHM_HUGE_2MB    (21 << SHM_HUGE_SHIFT)
> +#endif
> +#ifndef SHM_HUGE_1GB
>  #define SHM_HUGE_1GB    (30 << SHM_HUGE_SHIFT)
> +#endif
>  
>  #define NUM_PAGESIZES   5
>  #define NUM_PAGES 4
> -- 
> 2.45.1.467.gbab1589fc0-goog
> 


