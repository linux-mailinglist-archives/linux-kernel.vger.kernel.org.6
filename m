Return-Path: <linux-kernel+bounces-203605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC19D8FDDBF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 06:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CCA0B239B4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 04:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166F72E646;
	Thu,  6 Jun 2024 04:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MQKrR6b6"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54E19D8A1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 04:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717648325; cv=none; b=i/nP3rJFvH9A1wX2kceJRv2KdDV6dNbY6mVBeVboR98jPT6js1fVP914xJjK0PVGd9qxhTMNpZxiSWbo45QCO0lhsR0XMqT7RTZZMLzwxyDIxtLNgyZYcNPSGkT6Bb0gNKZwUh27eWccsOzFgr+tYNLidRCvi4OmAuvQFTkhHAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717648325; c=relaxed/simple;
	bh=pHWeRAxcZ7IS6JPFDrNVwngcp1RhwnwXjC/BzxNRSQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nREMqubQ5LYA+Hg0js8h2QWDnHyv+4UHgwgU+8aa8h/YXozE/6ZPdeAtep/ih/lZpchdYLvtwQ3eSw8MQGk28gDA8GnMBLSDiMNY28dlbXOolOBvEPhi2KMVQF5MU7/Iy9c0x+A0qVdNqNG/w1nOxy+3Uqw0XoopwAvYwIYeG2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MQKrR6b6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c24115469bso1226755a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 21:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717648323; x=1718253123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e5O/KPBawU1WK3EGBuiDZMDOrb6/M6TI7wnGL7CoNe4=;
        b=MQKrR6b6w9LlaDIMsQsEFUjAs0TnAkfsF+KT9YB20hHqfh+Q8wPn8SZJx1j7Pq5CQo
         lglofiXdM98cTUq7L+BzRtG+GZ/4Jt2knfGjYgj14Vwxe7Ws2BfOUTDMc2M9bLp4KIQF
         ryQERXtgJsPYar2UTE49EymvU3qigfRon8g10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717648323; x=1718253123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5O/KPBawU1WK3EGBuiDZMDOrb6/M6TI7wnGL7CoNe4=;
        b=CrYbKyRQUtx6F9pNkrWepwycKBz55NnC53JJImZALCbYDSEkZ7cUIqdesAoVbawOtB
         UhnssNmRPCe5V2HvFfqJl44IBPLiTD33pQRnFi6HtJHBjQwwNKjNH79REE/hDTEPTlqf
         DJpglBampUnK9jjw+NXWoIrstLkvxPfo4Rqx4H72EuY/4qLyVlQQoiPg0l8UhuQV1GC8
         6DWfdNtoWAwiZYPQ+0OaEeiKR7f0RA/W4gCizgZuqQrut38vWSAmhQ6ujLfpWW5GqPo3
         3HMYz4w3xC8uiJjpqg9CG6t1uf857IQHEBF0E6bnvWpOpTLcsPqBSlVoq0bPd9EUZAZI
         4TlA==
X-Forwarded-Encrypted: i=1; AJvYcCUykRBEwWGS1KbcymlEPrSljXf8BET+R295AbrjsxvHs55LD5BVv4bXSAFNdHT4wBNuIn7eCMmC/Piy3lbXFBg+AynyFZgHulHH8EKy
X-Gm-Message-State: AOJu0Yy9Ve0Ql1SgCvC+JORRUi49yeEVWp16ErLNEcATczE7vPH/5oGd
	XqVSKsTyR7Xw9z/w2y0zIYsAG9mS0Npq6XBR69zUyGv1iE0OI3Q2jdVIwXLjIA==
X-Google-Smtp-Source: AGHT+IGeGRNGy0Xw3Akts/lPFVIgXije/S+Ayuxc+gSupT7N6SirKbQGyrs2QN0KZ/uVluqHP+feAg==
X-Received: by 2002:a17:90a:ea8f:b0:2b4:329e:eabd with SMTP id 98e67ed59e1d1-2c29997370cmr2096719a91.2.1717648322998;
        Wed, 05 Jun 2024 21:32:02 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:22f8:8e4a:7027:de56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c28063a7fcsm2418151a91.7.2024.06.05.21.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 21:32:02 -0700 (PDT)
Date: Thu, 6 Jun 2024 13:31:56 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	Erhard Furtner <erhard_f@mailbox.org>, Yu Zhao <yuzhao@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: kswapd0: page allocation failure: order:0,
 mode:0x820(GFP_ATOMIC), nodemask=(null),cpuset=/,mems_allowed=0 (Kernel
 v6.5.9, 32bit ppc)
Message-ID: <20240606043156.GC11718@google.com>
References: <CAJD7tkYjJJGthQ_8NukGw6Q9EYbLA=8sAH_7=B90KXEL6HWdSw@mail.gmail.com>
 <CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com>
 <CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com>
 <CAOUHufb6zXr14Wm3T-4-OJh7iAq+vzDKwVYfHLhMMt96SpiZXg@mail.gmail.com>
 <CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
 <20240604231019.18e2f373@yea>
 <CAJD7tkYq5u7B+0UH2XKpeWJnUxoO2kJ1_XZ2JOgYpyNEVR7u0g@mail.gmail.com>
 <20240606010431.2b33318c@yea>
 <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
 <e68bcc6a-25b1-42aa-83b3-5d457b254cbe@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e68bcc6a-25b1-42aa-83b3-5d457b254cbe@linux.dev>

On (24/06/06 10:49), Chengming Zhou wrote:
> > Thanks for trying this out. This is interesting, so even two zpools is
> > too much fragmentation for your use case.
> > 
> > I think there are multiple ways to go forward here:
> > (a) Make the number of zpools a config option, leave the default as
> > 32, but allow special use cases to set it to 1 or similar. This is
> > probably not preferable because it is not clear to users how to set
> > it, but the idea is that no one will have to set it except special use
> > cases such as Erhard's (who will want to set it to 1 in this case).
> > 
> > (b) Make the number of zpools scale linearly with the number of CPUs.
> > Maybe something like nr_cpus/4 or nr_cpus/8. The problem with this
> > approach is that with a large number of CPUs, too many zpools will
> > start having diminishing returns. Fragmentation will keep increasing,
> > while the scalability/concurrency gains will diminish.
> > 
> > (c) Make the number of zpools scale logarithmically with the number of
> > CPUs. Maybe something like 4log2(nr_cpus). This will keep the number
> > of zpools from increasing too much and close to the status quo. The
> > problem is that at a small number of CPUs (e.g. 2), 4log2(nr_cpus)
> > will actually give a nr_zpools > nr_cpus. So we will need to come up
> > with a more fancy magic equation (e.g. 4log2(nr_cpus/4)).
> > 
> > (d) Make the number of zpools scale linearly with memory. This makes
> > more sense than scaling with CPUs because increasing the number of
> > zpools increases fragmentation, so it makes sense to limit it by the
> > available memory. This is also more consistent with other magic
> > numbers we have (e.g. SWAP_ADDRESS_SPACE_SHIFT).
> > 
> > The problem is that unlike zswap trees, the zswap pool is not
> > connected to the swapfile size, so we don't have an indication for how
> > much memory will be in the zswap pool. We can scale the number of
> > zpools with the entire memory on the machine during boot, but this
> > seems like it would be difficult to figure out, and will not take into
> > consideration memory hotplugging and the zswap global limit changing.
> > 
> > (e) A creative mix of the above.
> > 
> > (f) Something else (probably simpler).
> > 
> > I am personally leaning toward (c), but I want to hear the opinions of
> > other people here. Yu, Vlastimil, Johannes, Nhat? Anyone else?
> > 
> > In the long-term, I think we may want to address the lock contention
> > in zsmalloc itself instead of zswap spawning multiple zpools.

Sorry, I'm sure I'm not following this discussion closely enough,
has the lock contention been demonstrated/proved somehow? lock-stats?

> Agree, I think we should try to improve locking scalability of zsmalloc.
> I have some thoughts to share, no code or test data yet:
> 
> 1. First, we can change the pool global lock to per-class lock, which
>    is more fine-grained.

Commit c0547d0b6a4b6 "zsmalloc: consolidate zs_pool's migrate_lock
and size_class's locks" [1] claimed no significant difference
between class->lock and pool->lock.

[1] https://lkml.kernel.org/r/20221128191616.1261026-4-nphamcs@gmail.com

