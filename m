Return-Path: <linux-kernel+bounces-203365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 900258FD9FD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE3528522C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE51160790;
	Wed,  5 Jun 2024 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LmbIgzsB"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C8615FA60
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627520; cv=none; b=pl9FHDg5wvDZNZXwkHkgKZnnfN+y5FiINGQPBDsZ2/AidbInVy3eqRHNk/BJ+rX3CY2LO6VnDohqvYcDWarDPn5QYAuJwsOJdFciEvNlVlaYtnXjvFqyNJU/lY3uWtllwHaKqq1XTimPJHdrgtWUvuPZbG0PvW7DHMHOkdmAIa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627520; c=relaxed/simple;
	bh=j5XNJ7qUSi4GOebAuUL6hEQaPBtrzJwnimSGC15Ifv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOdySKOYDhG4ea1sgU6VITenLDDThNyFm+iFGX7rjlnnnmwdl9Rnd8+7rMJpjyANX8f/hzBf79q5C3dA4Lg30bNqdT159IEailWEqk9pC0iibSYncNfe8mZJcbvbcUpLTAautmGz0Tfsx/gatRPEmiJciQN9hiE44XVEBXhjvXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LmbIgzsB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f6a045d476so249432b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 15:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717627518; x=1718232318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WFSJCEy6u4uqWSm/uIbCw8MODebn4cqaARhTPhnxhUo=;
        b=LmbIgzsBJNEblNEe6FuXNqtPKXjbO538JrLAOO2zAU3F/mDYbBDThiDKp5yHsOGtPS
         TYm4c2ZFHRlU+DjsnWB1wgv4LBwBeGJceqjhUJHUNFTf48fhNPWbsRrX82upWtWzqo0w
         iKGlq9hZUbZCWdp74+zVCWaNSnjG1aMAkRZcAY9otjKiYcpfmloEX/o9eHWnFalaJzBv
         gWpan9KotgUllXmHRf4omzF4XCPXuEUxQYLpvZOFzj+Ml71Tv1MOiUMy8mYa2gJcJGjf
         E2xRN6jtdzRdJrAuLSTrLgvXVn7bALds85OYT6szZOpav4etxrG49/mdyKhsnmRuKvw9
         jr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717627518; x=1718232318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFSJCEy6u4uqWSm/uIbCw8MODebn4cqaARhTPhnxhUo=;
        b=Oo8VqnJ6PN1gRketuxWWFCNqgIOyHlr/kX25RA1AkwxDL28U4t2XSal4m9kJgKG0fz
         0izQey9mtqpI8XZqZaosZezRDAWg84rEVgzEBVnasFOsDS2BmkpMT861Eo1XPP33ovtI
         uTbI6Ycb3QQg1/804q850NvjG3fVX4RQH9DDGE9sIi8DMoBqE/hqreger9bN4C+cPx8q
         n69d1Q5h9+6Pjr/IgfI09ILbjyeJuSQDMMRPTQv/PiZQfKM3806nYomV1SPFARujs0b6
         fGjzO/xRSvbqGLYUiVDHmltYOuPfVKGGhvraZrvU3twNbr/txtYCPX5MyvdohN7Z28VT
         +qYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVorz0D1VT8cUie4pRNCztGwVcDTurDX+Ya9O/4GRPStFY8mzE3c45c0qtKBWF1WA0GHjs19zC5dTx+M9LIphaagCBPybVk3QL9uUHo
X-Gm-Message-State: AOJu0YwkfsJRVt14a9u3TeHvYul9oeYqXAtYQOrPjRaCYtb05f2Wj1ME
	mPpib4MvRSMYB5Mh4Sn3iaUlvteInCAOBDLxL+TMZqqx62xBkgoZGQhB7hCTYA==
X-Google-Smtp-Source: AGHT+IFjCDvYFFF2wgJdE13PmmXi1cL2xUEC6TiDuuPu1y0FqnGaQUW2DXAfSAA3tRUDfbCP/YT6+g==
X-Received: by 2002:a05:6a20:2590:b0:1af:d4dd:65e5 with SMTP id adf61e73a8af0-1b2b6f94b13mr4916867637.21.1717627517578;
        Wed, 05 Jun 2024 15:45:17 -0700 (PDT)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd4f8847sm16039b3a.171.2024.06.05.15.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 15:45:17 -0700 (PDT)
Date: Wed, 5 Jun 2024 22:45:13 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, llvm@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/2] selftests/mm: Include linux/mman.h
Message-ID: <ZmDqeakspyvpXpLh@google.com>
References: <20240605223637.1374969-1-edliaw@google.com>
 <20240605223637.1374969-2-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605223637.1374969-2-edliaw@google.com>

On Wed, Jun 05, 2024 at 10:36:34PM +0000, Edward Liaw wrote:
> thuge-gen defines MAP_HUGE_* macros that are provided by linux/mman.h
> since 4.15. Removes the macros and includes linux/mman.h instead.
> 
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  tools/testing/selftests/mm/thuge-gen.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
> index ea7fd8fe2876..034635317935 100644
> --- a/tools/testing/selftests/mm/thuge-gen.c
> +++ b/tools/testing/selftests/mm/thuge-gen.c
> @@ -15,6 +15,7 @@
>  
>  #define _GNU_SOURCE 1
>  #include <sys/mman.h>
> +#include <linux/mman.h>
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <sys/ipc.h>
> @@ -28,10 +29,6 @@
>  #include "vm_util.h"
>  #include "../kselftest.h"
>  
> -#define MAP_HUGE_2MB    (21 << MAP_HUGE_SHIFT)
> -#define MAP_HUGE_1GB    (30 << MAP_HUGE_SHIFT)
> -#define MAP_HUGE_SHIFT  26
> -#define MAP_HUGE_MASK   0x3f
>  #if !defined(MAP_HUGETLB)
>  #define MAP_HUGETLB	0x40000
>  #endif
> -- 
> 2.45.1.467.gbab1589fc0-goog
> 

This makes sense to me, particularly when other mm selftests are using
the same include pattern.

Reviewed-by: Carlos Llamas <cmllamas@google.com>

