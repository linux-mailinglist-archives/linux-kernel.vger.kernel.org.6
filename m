Return-Path: <linux-kernel+bounces-534606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31585A468FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1FB7A9ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA88D235BE1;
	Wed, 26 Feb 2025 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="UrJrdFZ2"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128EE2356B8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593350; cv=none; b=SLW3icjYKAI0p51HDKME51ksFA1JZmNUSoLKp9xt87br5tTaTBWBPbiziWkmSrTCxC+Wu5O+gCkqHdCRUaY+9ZV/rgcKiswGlgZmu7Y84dm6jkev/7woIrC7ZtPQXxf7mIfgfWuP7vVW7sZssUSTKw3u5fhPUoAkbp/Sy3iVxcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593350; c=relaxed/simple;
	bh=T2SA+pg0bRmwlXid24W7ZSx4II5qwR+GHJySiTPBiGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIOsCkFYNTlIOtZNf5km7z63uLsBo3eDGB5f1WIjCawumHq8meGrURay2kgsg5AKDlLVXomJdTji/31VB6Yw4HKJGdEuE0Aj83vpbPqV9PqKHvwZk42+qv+DuZ77jjMaHNn3vVK1qdv/Lo2KR/hZNHdyD35y1XYhHvo63CzEyhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=UrJrdFZ2; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47210ab1283so1061691cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740593345; x=1741198145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H/7exkgH4g2x/dtLhxxn2qMV78539G6TDhDmqsnwXgE=;
        b=UrJrdFZ26jrnP9pEpshQ13+slB2GCJ8Rp9pNA97S8KB+Xy6VB+jKeTTV7iFnNF4+2G
         vCzIEgYJW0X8hIEn08awROe7SVDZNkzzh9rxQGPpFWzbq4d4G0UI2FuxaiL4pyN9fgG0
         PtmLesmwONOglphLTufxCo7hH9TP9NgWZ+CAcsblJ8Vc+4kB6eQeFLyQq/5qwQxFCACl
         nWf1AeVqIpV/+2B3Llw1gzmLly4TVCwNkYxvNIIxap/+zTOlFpasqVWucLOHYsOumuvF
         T8dzS0ItFtiBp8Tyy8WP4sudngYuWh573KOXcBCRvF5/GyDUJoZa2APR2fN3wIgo+CK+
         Xwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593345; x=1741198145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/7exkgH4g2x/dtLhxxn2qMV78539G6TDhDmqsnwXgE=;
        b=dbU0T9014TM0Wvzaor+ZafGQnawVy7xwTMSZL44eR7hK7Am/d/nfKgZm9GCnV220lE
         F2HzKnV21m0oktgmsljqZE7UlqyaBUCEr9qPy657EDqSVCj3ZZGFFQy9s2iWHlhn4PWE
         PzJxuI6Na5aece5ss/vR2+WWfNbRc4GrjHJdoohNVAsLBolwcq5j8uwkDUx+1L6TPOiM
         XvPr8MOoxEHioSopekoQUh1O6SDAVatfkrTnqez6eAWxKnsO7LDY2b9nlHENAH0LhLnF
         7LImUhBzheNvVdibK++Sf5bFK+xAZtATs5A8jf/ZFe8wbiewOhfz4lqQ1gRWmKn2nwWM
         UGxw==
X-Forwarded-Encrypted: i=1; AJvYcCWyimz+LvbadpipzX+IwIuZUo4GklEp+0v7QyrPH3TcWpcdN1Nveh/JaYxSK7Ng8o+rwTkw8/Rq4mcPzdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIXq9Ay8UYuTW+NyeKrCNJ0UsoHT7Z90UzLHqrrC8i64L95HUU
	xECuwcwM05gqyWmVOtBP5lgoEPBdkgx/yZVERTKCiDzno6V8zP1BCkFMQS9PXHA=
X-Gm-Gg: ASbGncsXvgmQNlkIlQgOS/wl3FoQNnnSIgfS+hzF9MZ2UmIZo96h6oOEdoxzYXloY36
	qfvoNQ5sz5HxsaVZ7hMj2fh9NrertC9usk1I80gtWlENXXFJQQwcb4xD+JkRhojcZiVQfhyKLHG
	y0ZM+TQS81Ev1gpcG9gJaaToJECl1gJpwvjQoh4VT6RvB3lb0eVTYF12FIFrinEVcPp0Pgi6m3x
	xSXsB1Gw8c8x1h338SOVfWEr+D77/6EAdsBx/o4bwhKBXw/Kusc2UzCx8Cgn+KYUeZUjhM6hLXK
	GzrAMDKH14p57WC6LZX1ontd
X-Google-Smtp-Source: AGHT+IF90AECSXNM4fQh5CRjihnPl+s38MBa+LIXp9G1MfvE3ridbCOzXicO+oBmrzugy71KdRVjqQ==
X-Received: by 2002:a05:622a:2c6:b0:472:1573:faaf with SMTP id d75a77b69052e-4737721d0d5mr90215941cf.22.1740593345535;
        Wed, 26 Feb 2025 10:09:05 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47378084535sm27034581cf.68.2025.02.26.10.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:09:04 -0800 (PST)
Date: Wed, 26 Feb 2025 13:09:00 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Frank van der Linden <fvdl@google.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, joao.m.martins@oracle.com,
	roman.gushchin@linux.dev
Subject: Re: [PATCH v4 10/27] mm/sparse: allow for alternate vmemmap section
 init at boot
Message-ID: <20250226180900.GA1042@cmpxchg.org>
References: <20250218181656.207178-1-fvdl@google.com>
 <20250218181656.207178-11-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218181656.207178-11-fvdl@google.com>

On Tue, Feb 18, 2025 at 06:16:38PM +0000, Frank van der Linden wrote:
> @@ -489,6 +489,14 @@ config SPARSEMEM_VMEMMAP
>  	  SPARSEMEM_VMEMMAP uses a virtually mapped memmap to optimise
>  	  pfn_to_page and page_to_pfn operations.  This is the most
>  	  efficient option when sufficient kernel resources are available.
> +
> +config ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT
> +	bool
> +
> +config SPARSEMEM_VMEMMAP_PREINIT
> +	bool "Early init of sparse memory virtual memmap"
> +	depends on SPARSEMEM_VMEMMAP && ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT
> +	default y

oldconfig just prompted me on this, but it's not clear to me what it
does. Not even after skimming the changelog of the patch to be honest.

Can you please add a help text that explains the user-visible effects
of the toggle, as well as guidance as to who might care to change it?

