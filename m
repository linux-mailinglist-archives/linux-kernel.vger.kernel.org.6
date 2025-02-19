Return-Path: <linux-kernel+bounces-520668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFE1A3ACF7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6850F1890D40
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D437C4C91;
	Wed, 19 Feb 2025 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="CSaauxeo"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B7E8F5A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 00:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739923868; cv=none; b=QVTC9WL8O/C6I6PV0MVwbdfXMQwLw5wK9uELDRkyURSDdnuSUoh6h245z4KO3f1ShetnpSoi9VKitXkwtYSdWk3E9RsaH1758mFDmZ8D1hfrS56j2sho1O0RH4GUxVtDg/p8zyBCw3FjoGRMld1gWCSLwogyug8DXB7nNM1OS+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739923868; c=relaxed/simple;
	bh=GKth8OgfzFdg1eI08wTLXySe0/ivwrF4OJZlEoIUS3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwiTBQNX7LxeaxWMnysg8iHpK3aERTXr5WN7t1JysaX6jybqE6sSIlxbDSZ3aPxgg87/Gq/EJer/9X8WvjZdJ5GJuljAMpebzEnybGRzGhSkB8BsvuRvF60u/bWlzQgArAnW3OG16vCg/kLJ+ncAoKmwJ2sLPE8jaww1632e9sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=CSaauxeo; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2212a930001so71469235ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739923866; x=1740528666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wje+37OUw3EOY3E8DdGEm6PdRUyXBW2L3woHBy7T6PU=;
        b=CSaauxeosHvEhvX7OJSF9HR/qn2/ZC5RoSq5l5l69nbJreEo6zEzKaYQE1VeGlM8qO
         BfELA0Ur6tlUHqwaF766krLn+YOUDQ/GlfakF6txn0jRFi1F8p+8c9z0mVf9pruWe6MZ
         UPY9g/M3AB12EvW9Kvyu0zTwN/0miKCvrpWFwcDrW70deVgwZGcFCgbuugjQEheX9hxT
         OFLDofbRAdf3/gQOa3dVwQEzLaki2zusN6lYU5hSVD0NW3cwmKjnvhOEsiQnJxlipmmF
         ZlnXJE08/RCyjRIPQbSvLUsd7B09JYYVXS5qd0JM32xpph4fKoc6yKywmWvabmar+tEU
         2z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739923866; x=1740528666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wje+37OUw3EOY3E8DdGEm6PdRUyXBW2L3woHBy7T6PU=;
        b=NF1CPgbanIbTYJc72XqSzKRUeSZvWDqDojqIc+IpaPhgSaoprDz/V8jWdGBP+Wamyi
         9Kkz9Vgta65ofL9RJq2emTkRRhkDOHzorcrcCBLH+VTTRwdeqLUUhDlvBdmx8y18dGEX
         xPv6NQ7YhBk+Yjba8Ky/+cXaXpwDXGliY4ZwNp5Cnb0SH43mjxbK8Qk0vnBoJIR2PTC/
         ecW1ZfuPR3UI8zea4764OdgB6YhY/z0m8z0RVsYINJoW7A/08ay4tyCNN5UXQu6ViIr5
         ru12oAQ3Z4LAi+zjI3sYuRE3cijA16F/lPq4CW7FDvATeQYA1eR0QwqwMNQ88SBKxZth
         un6w==
X-Forwarded-Encrypted: i=1; AJvYcCUNGpbhNrwlGCDf3h/s4YLnWmb3hubAh0RhyoqSwqqb9tpJsYEB8O+iRV3wtW69jYXuXuDf3KVML3p7M9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq9rn+hT6lkHFBX7wVi/+ISTu5yE2D4+cdaPJciVNe3Ohj1c7+
	14kdbO0meW/NFatGcIA0Z4yzfN9AUdD1v0wGaPj2mAWC0zDMhh+YTaMrS4MlGNujcWpMmUTxSMc
	x
X-Gm-Gg: ASbGncvoHqbo2vARldbUe5c0ycB0veHua11y1F2ksOYLJiDDq2vrvopqKfjMBwXGg/f
	/rdtUz0Y4jrdvDhxw8ZdrVacLx5m1aIuFUQtLO3m9TQGxyGmSw5M0P6La39HAP+Vz8DiHNHO70e
	r5h1TYf111u6oVjJruvrjU8y9Xt4m5SZppRMyDJNtq4wknUh7But2gJzSya2yXbaOO+Nn7Tia8T
	y3TPzFQ6655MFJmVN0Z2fJCWAiloPvc4yhr0UZKb2aHdozpMRhjOot/WpXzc+H2M2mBofk907ms
	LhlQavlMXCOPSlV2a/IY8tDInWzmWFplIEC5qrqiHFONwWj+s+jcVRMU+1glkaOu/T8=
X-Google-Smtp-Source: AGHT+IGzNw9N6vIVHFFoSDN7U/7f25cr4Ncvov37jFAYdeOGbe9w5NFdAS1CNJKBD1dXb4wW4OuzXQ==
X-Received: by 2002:a05:6a00:3d42:b0:730:8d0c:1066 with SMTP id d2e1a72fcca58-73261911238mr28880688b3a.24.1739923865977;
        Tue, 18 Feb 2025 16:11:05 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73272a28fe5sm5802089b3a.101.2025.02.18.16.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 16:11:05 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tkXg7-0000000314I-00od;
	Wed, 19 Feb 2025 11:11:03 +1100
Date: Wed, 19 Feb 2025 11:11:02 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	brauner@kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH 2/2] mm/truncate: don't skip dirty page in
 folio_unmap_invalidate()
Message-ID: <Z7UhllvPUxVuYOqf@dread.disaster.area>
References: <20250218120209.88093-1-jefflexu@linux.alibaba.com>
 <20250218120209.88093-3-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218120209.88093-3-jefflexu@linux.alibaba.com>

On Tue, Feb 18, 2025 at 08:02:09PM +0800, Jingbo Xu wrote:
> ... otherwise this is a behavior change for the previous callers of
> invalidate_complete_folio2(), e.g. the page invalidation routine.
> 
> Fixes: 4a9e23159fd3 ("mm/truncate: add folio_unmap_invalidate() helper")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  mm/truncate.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index e2e115adfbc5..76d8fcd89bd0 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -548,8 +548,6 @@ int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
>  
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>  
> -	if (folio_test_dirty(folio))
> -		return 0;

Shouldn't that actually return -EBUSY because the folio could not be
invalidated?

Indeed, further down the function the folio gets locked and the
dirty test is repeated. If it fails there it returns -EBUSY....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

