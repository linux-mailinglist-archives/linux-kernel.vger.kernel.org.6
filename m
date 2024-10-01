Return-Path: <linux-kernel+bounces-345747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E74F98BAAC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC822828A2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F741BF33A;
	Tue,  1 Oct 2024 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="UnVeX8FS"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66A41BF339
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781056; cv=none; b=NVnKYCZjplz6RCTd2AhiasijmfxL6Akl+9qVluJw3757cAmMJorJZFcUDpFcC+nhu9gG35driX2T+QmromLI5Gk4VsmBlBwnqqB/dbuXt+NcVoeS8FvFvyqmGRWTdexeYCH/VI58jwaSeMna3TDgvPBfjosAx1iSkYqCSfoEU4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781056; c=relaxed/simple;
	bh=H4hCpW9yXKhir7s6sTIB/IyjakI5P7OS0MD0XZXvBwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TswafpezJwTISDmrmhNmLCtfGIEy4JrNukSTfSivr8NqwD3xd/o3QNtGmQvYqLECpppQFcMJggbX8vhfpUjKWHCX5Kk6W29EUCJdzMLELBwtf1nJc1PdtCRhsUh5+gdzdCJPp0DuOq0VlyCyXs5ndi0eh2WEazK0ZCOn6eUXcu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=UnVeX8FS; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6cb2c5128d5so39016606d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 04:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727781051; x=1728385851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ei0uOAWODI7rivHUvR7VbMuZJo7IP6byy4Y7xrN2xFM=;
        b=UnVeX8FSnPHkLd4PJb2chG3uxFwFpT3QUtsZYxvas6l5MqOYL68ZLtFWh9cVugHerf
         vQxQsfze844CvzItZCd42eZG/1Owy69jMyqa//33n4XiLxqC5jZx3R3H4Iu6GsUg6r64
         iV+ZOdFqsnVmcA2Iv3YpSSJ6tIxLsJxZTp9JCCv7IE+E9ouw/Hn5gRsXZeF6GLeSCUzk
         4NjJanaITrXGMXRr1pCGmuDSXV2NRi9gey2qLBdSM+UCQwtDto9CHDMpVTdICKo71Xhq
         yzRMT5wKwjLh0I3iUBN4MJYoNKkUSKHhHIeItkAFyMkHqzQBkvYYD/tju/rOVlNHo9DP
         2XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727781051; x=1728385851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ei0uOAWODI7rivHUvR7VbMuZJo7IP6byy4Y7xrN2xFM=;
        b=PvNL7ENPN5EtqubgCLItNvGSYnYd2ijg5rba8prXhndEYQHeywDjf5SNtVNLJxYbNl
         xBTh/VBCMrJP7RQCg78L75mzOtzctmCBW929QVfz1rM8i/49qKaeU6LGgx5FPH7evmR6
         a2kLn1W9tNWXSA5lq0gtyCSQl+LYcEs5AmiJtUzC2oVROlAT/6C+OELgCwSiI6WBhLmI
         x62EuIsHqb+6ij3Bv5+21t+ib99nVdPuMpwS59pMbEbl9kMxXkUKlInyaLQV0f/wZCQ9
         2gb/Pn/GoTi8O1yqEJR80gJSykbtF8C8D+TRT48sLe8PgXNmq+7ThzQJsbiU1NVuCDK9
         J8Pg==
X-Gm-Message-State: AOJu0YweuQAml30sarrcFeRbRgQIcPnFYVEnIvggP5T8nsY8q85gnnnL
	EnXvwchSHDJwHoGcolvbdAQCBfh0U9Mho35VzwaLqpAx7f5lXMwCioFFloJDmWk=
X-Google-Smtp-Source: AGHT+IEpqmT0ehhjUVL5E//EDthlcBWbj8TPOM351PMmoL6R1x+iKCurX+Ok4oJGekJgXjg2bFjT9A==
X-Received: by 2002:a05:6214:4885:b0:6cb:4713:9dee with SMTP id 6a1803df08f44-6cb47139f80mr195731456d6.4.1727781051350;
        Tue, 01 Oct 2024 04:10:51 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b600f32sm48342036d6.22.2024.10.01.04.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:10:49 -0700 (PDT)
Date: Tue, 1 Oct 2024 07:10:45 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, yosryahmed@google.com,
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com,
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
	21cnbao@gmail.com, akpm@linux-foundation.org, willy@infradead.org,
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com
Subject: Re: [PATCH v10 6/7] mm: zswap: Support large folios in zswap_store().
Message-ID: <20241001111045.GA1003400@cmpxchg.org>
References: <20241001053222.6944-1-kanchana.p.sridhar@intel.com>
 <20241001053222.6944-7-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001053222.6944-7-kanchana.p.sridhar@intel.com>

On Mon, Sep 30, 2024 at 10:32:21PM -0700, Kanchana P Sridhar wrote:
> zswap_store() will store large folios by compressing them page by page.
> 
> This patch provides a sequential implementation of storing a large folio
> in zswap_store() by iterating through each page in the folio to compress
> and store it in the zswap zpool.
> 
> zswap_store() calls the newly added zswap_store_page() function for each
> page in the folio. zswap_store_page() handles compressing and storing each
> page.
> 
> We check the global and per-cgroup limits once at the beginning of
> zswap_store(), and only check that the limit is not reached yet. This is
> racy and inaccurate, but it should be sufficient for now. We also obtain
> initial references to the relevant objcg and pool to guarantee that
> subsequent references can be acquired by zswap_store_page(). A new function
> zswap_pool_get() is added to facilitate this.
> 
> If these one-time checks pass, we compress the pages of the folio, while
> maintaining a running count of compressed bytes for all the folio's pages.
> If all pages are successfully compressed and stored, we do the cgroup
> zswap charging with the total compressed bytes, and batch update the
> zswap_stored_pages atomic/zswpout event stats with folio_nr_pages() once,
> before returning from zswap_store().
> 
> If an error is encountered during the store of any page in the folio,
> all pages in that folio currently stored in zswap will be invalidated.
> Thus, a folio is either entirely stored in zswap, or entirely not stored
> in zswap.
> 
> The most important value provided by this patch is it enables swapping out
> large folios to zswap without splitting them. Furthermore, it batches some
> operations while doing so (cgroup charging, stats updates).
> 
> This patch also forms the basis for building compress batching of pages in
> a large folio in zswap_store() by compressing up to say, 8 pages of the
> folio in parallel in hardware using the Intel In-Memory Analytics
> Accelerator (Intel IAA).
> 
> This change reuses and adapts the functionality in Ryan Roberts' RFC
> patch [1]:
> 
>   "[RFC,v1] mm: zswap: Store large folios without splitting"
> 
>   [1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.roberts@arm.com/T/#u
> 
> Co-developed-by: Ryan Roberts

I would change that to

Originally-by: Ryan Roberts <ryan.roberts@arm.com>

> Signed-off-by:

and drop this for now.

> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

