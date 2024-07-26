Return-Path: <linux-kernel+bounces-263827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CFC93DB19
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 01:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16002816E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB0914A0AE;
	Fri, 26 Jul 2024 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="jGshJaLY"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06426FC1F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722035293; cv=none; b=t3ZXAacZ8Mo1BQtxr5aIs/UOt8AEYj5OjyCRUOQ0a3KDtlPXenGuBgTtAP63jXboDPvXowqTv0wRH7eU3QPFQTtEf5kSWZkhYNqqQU0k6HId6KcSfemOgzivujzbJgEClHbru42yZ2tcO3rcXQGEFWkYcBg5dtC/EgIvC4NpbKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722035293; c=relaxed/simple;
	bh=Gpo+qgq+Ddr97mmbexmguehJ0sLjSSxvqwDdcAgoiwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=um++4MVRq0Huiabgz8WVNCO/OfEaPZzB0FSnWJINpVTs1KoxLOTYydki5Oz8YJNMim8XFZzwW+gHpNQfAD9yJJT1dI/M1glSIAZfdyNBDiIPTGVWMQYAjFa7NusXxLl+zr7agAL869bHyav4UzuyvzR9ScUeX+DOo2ZmlJvNns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=jGshJaLY; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-79f19f19059so72760785a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1722035290; x=1722640090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XSaYzOa5POmQwT9zJXZdAuQLpg2xdRHWddGJ5wJg/4M=;
        b=jGshJaLY8Va8JZnLPtQH+QxIaGgnqsCiYzb2BheQlUXrVesVh3HefDjyyoiAapiX41
         QCYPwMq/SJefFbBBhLRp+v5JE2pAc2C6zWNzOrSGsbtTURh6QlLLNvhZl1FwrxTuvJ+Z
         f1x3WFKye0v7On4zjWW/19WqP2k70w0SEOGrv88gdasv/H9n3rSb0dbZTqrfPYZYDcmC
         y3UV1p5MrOCs4Na4L6AkEQTrjOLbKwJZS3zUoKDQEKeOnjN0IAIYyUiXhmnNyo8YA2NE
         GvMWSvgmInOT5iomigSrWH4NOYEzxxnpTRJIaZITfcF1mxzhPTfZBQ1XTZXweRrTAnhd
         2vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722035290; x=1722640090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSaYzOa5POmQwT9zJXZdAuQLpg2xdRHWddGJ5wJg/4M=;
        b=c0zczGlxlgeC+9Ybm5nQsx1rEi+qG9Qo5V8xmYUWEe1FamSozY8mJsIsH4QKomsVpw
         GD22robVZejwpCI9B5hkj1K2/Lctlr/6GMlCj3Nc4Xi/Uv/y+WU2R18SINmD2y+0xpOy
         09qigKgRqUypgQ6PTsCtligDkCM2oIMHIBH6+2tsvOD2v1aDxhafB8fm+nV9Be0tPUef
         oXnuPeDSHUmFy6+9o5+If5X22XdqYNIDw0AZqTiEPn7OiSpSPMRSmAufXXKvkDTnS43G
         UoWkUWqCqeziwR5TuHzBHhPIeYBT6xB4YDUrel9aBZxSqwGMauoZpRosK4JcQ4/oUVpM
         tdKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzns7IdtCJknQC+i24ccEStUYDwC0UuIDF0rrMB4p9oi+KFKrolyiMiY6kQhkLP+CEf2fqTdz6Wfhfz+uUKgUMpTlq7KyHR1SjZzOb
X-Gm-Message-State: AOJu0YwH1Kn8dK1T/g0IHeLYl1kI8FpTjp8barH42XtwLJDFkFg/e9Kc
	0IFuFhxFdW7F4OTNUyV5YmwEuFR8xD/EdmN1t3Nl7wnX3TtRc1Crxg/tNBG05mM=
X-Google-Smtp-Source: AGHT+IEjxjyck4ApqiiZqdFd4d9Hp90uhlrQwEC3C+q7nYeysVRvA1ovCvhDZ2YgLTQCoUj4UFK2JA==
X-Received: by 2002:a05:620a:472b:b0:79f:913:8109 with SMTP id af79cd13be357-7a1e525bac3mr165143985a.36.1722035289783;
        Fri, 26 Jul 2024 16:08:09 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7435582sm220426985a.85.2024.07.26.16.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 16:08:09 -0700 (PDT)
Date: Fri, 26 Jul 2024 19:08:08 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v3 1/3] mm: memcg: don't call propagate_protected_usage()
 needlessly
Message-ID: <20240726230808.GD1702603@cmpxchg.org>
References: <20240726203110.1577216-1-roman.gushchin@linux.dev>
 <20240726203110.1577216-2-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726203110.1577216-2-roman.gushchin@linux.dev>

On Fri, Jul 26, 2024 at 08:31:08PM +0000, Roman Gushchin wrote:
> Memory protection (min/low) requires a constant tracking of
> protected memory usage. propagate_protected_usage() is called
> on each page counters update and does a number of operations
> even in cases when the actual memory protection functionality
> is not supported (e.g. hugetlb cgroups or memcg swap counters).
> 
> It's obviously inefficient and leads to a waste of CPU cycles.
> It can be addressed by calling propagate_protected_usage() only
> for the counters which do support memory guarantees. As of now
> it's only memcg->memory - the unified memory memcg counter.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Makes perfect sense.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> @@ -13,6 +13,11 @@
>  #include <linux/bug.h>
>  #include <asm/page.h>
>  
> +static bool track_protection(struct page_counter *c)
> +{
> +	return c->protection_support;
> +}

IMO it's a bit easier to follow without this. page_counter.c should be
able to access struct page_counter members directly :)

