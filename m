Return-Path: <linux-kernel+bounces-309559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E57966CC7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 01:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47C35B22153
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED27C17CA14;
	Fri, 30 Aug 2024 23:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVo0U5vU"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3341531D0
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725058959; cv=none; b=tqBA6nWJ6UK4O4NUnotsz6uXXF5epze6Bu3rUraU/JOWUaCtsC7tTPyE6mYzp5DePUSBeDxNAUYV9zWi9Wa74NsIxu5jT7NgynVrnkwCJ5I8QzNTFedLwvVn16+WDXvKhYqK/DMw+UDRGVbfjEMseGJ4yWjQPzYZmg8xh4BuI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725058959; c=relaxed/simple;
	bh=fRvS+lq0R9YOGooLahX9HxKcTZg16bwlh2VtOKEhWkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bw9oo99mkkNeWSb4p4xVkA5YU7jFT9ATG0IMjhEZ4JaLLvqzFnWMEhIaI0rKo1I69GCNcfA1Gc6eB4DWLCw21CUv86/Vc8TuVQJ0zy01ws5Vb/hmGM1nBRe/tdF+ZlS2xs9BZKpmFmsr55N4kjsIGsCfPcxcNHwSQlc8eL2t20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVo0U5vU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-714302e7285so2110795b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 16:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725058957; x=1725663757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8j0SGRQ7zHB0oX79fcQnd92byGFUDEuNaSls8i7ZVc=;
        b=EVo0U5vUTwDNDKhrdPvova+zWYolvzpkLmU0MSwicbcsFQz7ciU+tmP9ZlioHzfoxL
         FByU6Yf4xSCWJ1uarB3Rat2iQSH0cazCZd/KhHEM6qs2mJNBd2/vdvGz5C4JrstDC6aD
         reDCLfO2j2mZNyUKos4zcdZB1NzFFIO5hSPvnnvNh8wSJVpweUtIqqNR35GWYyyT4imh
         4EOV0gGb/W/YYNjUu6yOu/lnPb8RYfN7c4aezl3ius93PNXbI7C/08lCbYIgr2mRIiFe
         znyI0G0NsE8qThNi6yU0mz+TriWiDlmAQ207rsguQtmACOD0oNEPiA9SIskhkqSWr0mX
         sLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725058957; x=1725663757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8j0SGRQ7zHB0oX79fcQnd92byGFUDEuNaSls8i7ZVc=;
        b=JYeb0CyDtv7oKQ8yA1CZ20mFaKegOLRauBUyHDVKLml5q9WzNsXBpfJ1zMPEbt1UN3
         bW+ew4BbMu6OmdZI0LHYYf+/ynZAv53TcibIO39lw4xnZ9M3wFjI+Q2ai952QVPwdKaN
         E/jrWHJBjfjkWJO3H//oGPHBJBZ9V/8PTbYcEBlXp9ZZNHIWAs7OKjyV/3f6KJwVbtqN
         kYYSGgoa41SbRFIKcFw+MzapSsRMBrnrWCE6LFJFQoYssFhaa1pohRHMzTTvt51Ga8cf
         5prkiVtVAHp5PrpM8oBoje2od4RqDxipbrWPvVfLKR0k//iK00Y1QkY/+b2/o024cj0U
         IsSw==
X-Forwarded-Encrypted: i=1; AJvYcCV/XEVt8PPAPSa4MKOh2XD+nqjxj85rYwC1c7FOQDUv/2JMqeRCXjcQjsBgRehpKIzi1NK/3d9FRLjbfbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wUvWoFkesvtjCT+g231uFSkpZTrvq8LSEGw+6ISJhBTYayQh
	9vh3ng9eB8C0SmHnrg2udPyqAhpq/LOzazwqS2PhrdVLX7yNdnnCsU5zoePI
X-Google-Smtp-Source: AGHT+IFbmvf6ueNdSCUm2IUJcbeC4a2XvbGn0xjKaqMakqjF76pmbtCDzEaaMoaiBAv3ImAkIapVvw==
X-Received: by 2002:a05:6a00:882:b0:70d:2e24:af66 with SMTP id d2e1a72fcca58-715dfcca595mr10975297b3a.20.1725058957067;
        Fri, 30 Aug 2024 16:02:37 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d8075sm3251349b3a.159.2024.08.30.16.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 16:02:36 -0700 (PDT)
Date: Fri, 30 Aug 2024 16:02:34 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] lib: Extend bitmap find binary operations
Message-ID: <ZtJPis2WKGgk9hvz@yury-ThinkPad>
References: <20240830191043.1028827-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830191043.1028827-1-mathieu.desnoyers@efficios.com>

On Fri, Aug 30, 2024 at 03:10:37PM -0400, Mathieu Desnoyers wrote:
> Extend bitmap find.h and cpumask.h with additional binary operations
> such as "nor".
> 
> Also extend the testing and benchmark coverage of those bitmap find with
> binary operations.
> 
> This is useful for NUMA-aware rseq concurrency IDs which depend on this
> series. The series can be found at:
> 
> https://lore.kernel.org/lkml/20240823185946.418340-1-mathieu.desnoyers@efficios.com/
> 

Added in bitmap-for-next for testing.

Thanks,
Yury

> 
> Mathieu Desnoyers (6):
>   lib: Clarify comment on top of find_next_andnot_bit
>   lib: Implement find_{first,next,nth}_nor_bit, for_each_nor_bit,
>     find_first_andnot_bit
>   lib: test bitmap sets binary operation iterators
>   lib: Fix test_find_first_and_bit and test_find_next_and_bit benchmark
>   lib: benchmark bitmap sets binary operation find
>   cpumask: Implement cpumask_{first,next}_{nor,andnot}
> 
>  include/linux/cpumask.h  |  60 ++++++++++++++++
>  include/linux/find.h     | 124 +++++++++++++++++++++++++++++++--
>  lib/find_bit.c           |  36 ++++++++++
>  lib/find_bit_benchmark.c | 143 +++++++++++++++++++++++++++++++++------
>  lib/test_bitmap.c        |  81 ++++++++++++++++++++++
>  5 files changed, 418 insertions(+), 26 deletions(-)
> 
> -- 
> 2.39.2

