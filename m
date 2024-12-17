Return-Path: <linux-kernel+bounces-449533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EFF9F5072
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED3F16E6D0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9691FAC34;
	Tue, 17 Dec 2024 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ieG6thxT"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4181B1FA8F2
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450960; cv=none; b=r7hDtoltHMJiFAMCG6wN6UBfZkwNRyyJUd1tryfRtgKkLmqHxDg1zE/l4I8A6Yhb0dBMBAcg4FQ2qyJtv+4xPnhZgwvMShT5/uwysLax7Kc1EAbvP7ohJJdov9vmi6EThDQTaUsBWGHqNDkeoFqF8+WhT893sIj/NVe6VVId98E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450960; c=relaxed/simple;
	bh=81eOhisOkkiYMuz5aDENJ0L07ifA4nDOqPEi7hjwfco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMbTchygtT3hSQ4+6Rp1u9qU83V/Y16L9eTa5Y311tDSqqMPjtUsmoHR/V/xoaQ2zkgUVtr6KTgFevx3TzQWmU8YwwwG+cTzWGYGHkf8dbQgxcURvX38/pht6gVsjo8pEMtJP7mN+RNPrHEkfb8xeqIJYLTCvWnfsUHwA21SiSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ieG6thxT; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-468f6b3a439so13121771cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 07:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1734450957; x=1735055757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZPTMFYjgagD9vXUB8hfJV4lWIxsKDKRvleZqrPiixs=;
        b=ieG6thxTe91rRrrk8R1JMmlny+ThVY7I3nP8nAWfKKi2ThlBaqBLsAkAXef3KEbDI1
         aBh88ljUjBaAIM1Y4kZfcxTwhLLH3AQwdm8RS+A16V6Nsqfx1Z/ICUYHw0UlFfS0JJig
         OEmexAy8+h/ZX3QqvaUriUX+GPkPUbmKNcLLG2CeFZePbrriC8VYdmkDXUbz1VZD8E7H
         RZlrTlgZyFWrDVQRMWzyL4Xf/awdgF9xXuGRSK5y1uhpCWlgD9lOxl+SBeBU8u2zvzeU
         CVzm3R9kC5iOWgNVIPWlmtTqcxpkTc5WNkewbvFrbzJgIFvJETXGewEwvacZLknZUg46
         t1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734450957; x=1735055757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZPTMFYjgagD9vXUB8hfJV4lWIxsKDKRvleZqrPiixs=;
        b=HvMRZkPEYP9wqYDlqaQXvkyxkDayJrMSEfsq9F4B3xMP1aH8SOXzmzOWopY2pTUthB
         iDH5Jwx5zMnxV+eUGgxn+0My3nX0FFObPMo6twDbmBZCZq0vdYBDdGtWZpWrabaIl78s
         DoUgk105ZA6WCYt6hb2UccuOOLtIb5i8zJk3oJAZzxQQWOiCJ5v960ngDMJXPUbPAxbx
         G2S9Kcyev3W7k+xlBao3ei7M+k6L+nf3Kr8XY56Tgjp6SNGeSaQHQUgUZUqX0PKcQeit
         VDz2d+FqukYnt1yREGWbOVtLyV+bNFAGmvpaoWUcbn1Vt8kN7b/hbQuYrbr9MvIv4mPe
         mvQg==
X-Forwarded-Encrypted: i=1; AJvYcCWq6flDqY2U1i7OglrXt090NWwSLiai4F9RYRMnEN0qhqHkVVp3GagjyalpRdxRSiD4Q1oDT0TNRoGTtG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8AzkgajsS+B0Aw4it1Az3Qi5uhZjaaIiuTyf9Qf5R8dBHfyRA
	cGQkAMDgcLyLokoOCc5YNW9pFXStWtybK2wtvD+qI9y/7L9cZLUk8b8GpkMJBSGPMDTiLn/o9/g
	z
X-Gm-Gg: ASbGncvkoX2uZ0RKRf0legIzVI83TZtfaIDYEgL6QyalCm0abv2VOTiHbLyvnY9W6FE
	NYpuPXpiwDZHJnWtux168alyy00z5LeBXnYOjzwrMvWOPqC5QPRkslz15bzCnZnhUNQr58Ftx9y
	XfZFV4l0ZPCQf207aMumC4S1G3Qv8IDDB0htyptxJ7FaSS6Ce/+sk/8zWXH8n4TNFUGCEaUbYzg
	LAs0dt4T0ab0JBqyQpa2wVStIQ391n+d2RVNggA9dfTQJZiOtvmJoI=
X-Google-Smtp-Source: AGHT+IEaT2Pv15sPRiFkxD6+c3DIkhwkYwdNFL+CjC45Xpa4bv6O8SA2c0O3In5fD1t0Mm3JFoucOw==
X-Received: by 2002:ac8:57c2:0:b0:467:7295:b75f with SMTP id d75a77b69052e-467a581ac95mr339540231cf.38.1734450957097;
        Tue, 17 Dec 2024 07:55:57 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2c69b10sm40454121cf.18.2024.12.17.07.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 07:55:56 -0800 (PST)
Date: Tue, 17 Dec 2024 10:55:51 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: yangge1116@126.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	21cnbao@gmail.com, david@redhat.com, baolin.wang@linux.alibaba.com,
	vbabka@suse.cz, liuzixing@hygon.cn
Subject: Re: [PATCH V7] mm, compaction: don't use ALLOC_CMA for unmovable
 allocations
Message-ID: <20241217155551.GA37530@cmpxchg.org>
References: <1734436004-1212-1-git-send-email-yangge1116@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1734436004-1212-1-git-send-email-yangge1116@126.com>

Hello Yangge,

On Tue, Dec 17, 2024 at 07:46:44PM +0800, yangge1116@126.com wrote:
> From: yangge <yangge1116@126.com>
> 
> Since commit 984fdba6a32e ("mm, compaction: use proper alloc_flags
> in __compaction_suitable()") allow compaction to proceed when free
> pages required for compaction reside in the CMA pageblocks, it's
> possible that __compaction_suitable() always returns true, and in
> some cases, it's not acceptable.
> 
> There are 4 NUMA nodes on my machine, and each NUMA node has 32GB
> of memory. I have configured 16GB of CMA memory on each NUMA node,
> and starting a 32GB virtual machine with device passthrough is
> extremely slow, taking almost an hour.
> 
> During the start-up of the virtual machine, it will call
> pin_user_pages_remote(..., FOLL_LONGTERM, ...) to allocate memory.
> Long term GUP cannot allocate memory from CMA area, so a maximum
> of 16 GB of no-CMA memory on a NUMA node can be used as virtual
> machine memory. Since there is 16G of free CMA memory on the NUMA
> node, watermark for order-0 always be met for compaction, so
> __compaction_suitable() always returns true, even if the node is
> unable to allocate non-CMA memory for the virtual machine.
> 
> For costly allocations, because __compaction_suitable() always
> returns true, __alloc_pages_slowpath() can't exit at the appropriate
> place, resulting in excessively long virtual machine startup times.
> Call trace:
> __alloc_pages_slowpath
>     if (compact_result == COMPACT_SKIPPED ||
>         compact_result == COMPACT_DEFERRED)
>         goto nopage; // should exit __alloc_pages_slowpath() from here
> 
> Other unmovable alloctions, like dma_buf, which can be large in a
> Linux system, are also unable to allocate memory from CMA, and these
> allocations suffer from the same problems described above. In order
> to quickly fall back to remote node, we should remove ALLOC_CMA both
> in __compaction_suitable() and __isolate_free_page() for unmovable
> alloctions. After this fix, starting a 32GB virtual machine with
> device passthrough takes only a few seconds.

The symptom is obviously bad, but I don't understand this fix.

The reason we do ALLOC_CMA is that, even for unmovable allocations,
you can create space in non-CMA space by moving migratable pages over
to CMA space. This is not a property we want to lose. But I also don't
see how it would interfere with your scenario.

There is the compaction_suitable() check in should_compact_retry(),
but that only applies when COMPACT_SKIPPED. IOW, it should only happen
when compaction_suitable() just now returned false. IOW, a race
condition. Which is why it's also not subject to limited retries.

What's the exact condition that traps the allocator inside the loop?

