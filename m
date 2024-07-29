Return-Path: <linux-kernel+bounces-265055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2011E93EBF7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 05:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE4D1C21871
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0E380C0C;
	Mon, 29 Jul 2024 03:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MuXV5vDz"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779081723
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 03:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722224637; cv=none; b=Qm688bcoFaw14BHXXpelhKT6kVqGorokSjwLVEmzYslcanjSNiaJNWP6DqI1pa9mUzwNjUdVgRE2xvQ6sRJcNZAUDWt1mlAbdEAUIWpt2H7t+eSXQfojrZAirr6lNByzMTXfjvQWZtr5ZO4jSz26bsyMRCHVKupo/JfvdtnR9YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722224637; c=relaxed/simple;
	bh=G58qs7uHqGpCN0Kip3Kda1+HdZmwd66TMVkqk4RIqLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZRhMoSoLWE4RoVkPi1Mo1UwDXdW/pTiVJ4zit5Qd4cPIctn6qzPftObPJjczEN0hOPqDTEZMaHKaypQVnVbfGieAY8u7Xr0Lpgfa3CzPHP9bhhmNdmCppmanSvs2aX6ealEB72txQV9W8WWOmeYn3GIUVZapYiDqgsJEL4P70A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MuXV5vDz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F8hJQKEke5IRYxPjZGrirscb0oTcHFcMOJmtf/7z7i4=; b=MuXV5vDzAruUH4R48u/nmPpAN0
	SVRXxX8B8kmAgoswA015IyX2l7Ffi/VbGKTBs1QzYyMjxV3p1rtiymARbWl7l2VYGW7wgw/8E5UHO
	yuMWp6rz0tfY/YS3g5CGyDg+k1jafe1aGYlQbPHo5ufRoJZ1f66yaUjt1AzoZumyzsSYzt4bT0Lgu
	CkAoWBrh6fDJry2ftDvbzC/mUT0bQk+rx7zcbBpGSvQgvaanTlqHheldnNf8Kk6sEaG2aOliFxSmq
	k/BbrEkxEy5xkONV8EUoibqBVLQkIvy02g6U8BhB+ARTu/weIBWBwBgH1D/1IOLRAwQfIxZP8DrKa
	zzt30kBA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYHIQ-0000000D7e1-1sbT;
	Mon, 29 Jul 2024 03:43:38 +0000
Date: Mon, 29 Jul 2024 04:43:38 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: yosryahmed@google.com, akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com,
	kasong@tencent.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, mhocko@suse.com, minchan@kernel.org,
	nphamcs@gmail.com, ryan.roberts@arm.com, senozhatsky@chromium.org,
	shakeel.butt@linux.dev, shy828301@gmail.com, surenb@google.com,
	v-songbaohua@oppo.com, xiang@kernel.org, ying.huang@intel.com
Subject: Re: [PATCH v5 2/4] mm: Introduce
 mem_cgroup_swapin_uncharge_swap_nr() helper for large folios swap-in
Message-ID: <ZqcP6ucX6yHA0l9i@casper.infradead.org>
References: <CAJD7tkbho1a6pwZq82aHBa8BpXijqVopde3k-RnageOtdO32pw@mail.gmail.com>
 <20240729020222.36389-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729020222.36389-1-21cnbao@gmail.com>

On Mon, Jul 29, 2024 at 02:02:22PM +1200, Barry Song wrote:
> -void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
> +
> +void mem_cgroup_swapin_uncharge_swap_nr(swp_entry_t entry, unsigned int nr_pages);
[...]
> +static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
> +{
> +	mem_cgroup_swapin_uncharge_swap_nr(entry, 1);
> +}

There are only two callers of mem_cgroup_swapin_uncharge_swap!  Just
add an argument to mem_cgroup_swapin_uncharge_swap() and change the two
callers.  It would be _less_ code than this extra wrapper, and certainly
less confusing.

