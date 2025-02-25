Return-Path: <linux-kernel+bounces-530590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD99A43585
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2960E189A458
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85D2256C9F;
	Tue, 25 Feb 2025 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSCOYChR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7272C2561CE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740465553; cv=none; b=fHfGqIy4TWWGQQ48bxNOHE8APJsgD2KX/VCXo58amzN8HC7Plx7Deyux99OaNGjaObUausG7h97/Jm82BbUQDhxiCQ5lv6K4wCc/QhuAFBdKnnZ/NTWppXfMi5HNFpgJjKpK+tTZuOcf0aL0GupwJ1YRFFkBU4yodGaL9wAkvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740465553; c=relaxed/simple;
	bh=/uYxiYj9nJ75Errf8E1k5krTDrqPqlOeMhK0x+rSLhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdrIwjruE4NFL4GdQgjNvNHAi1+F2FBBx0uQkZkuRBlOs7T3Gfkn8XdqKrqXAxnHt5+NFweVlDNVNF7cJ+T9tOUDfyk5W2qFeeM7BQnw/cF6KS0At18mHSHnPcv6CKnOElc61vBMldR845vVnzHWSFJ/rfsGF3+G2snnjDMNdeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSCOYChR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740465550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SI3pKJ/94/hKtKiM0+9f6j6EtNWcn8A+DJCrfNsIoTg=;
	b=dSCOYChR+aiAY0lyK/fx3UF/GlEQyItPmRpcAHtz75blLBlVBUfarTKslddni1Z/xHOVrZ
	e2+rCFknpwvFQUDAMn9niEwrStpyKUTdpTR5VUgqpHqFpfOn+1SRYea1R8xDsEzbJrR0Mt
	YC8DTlWRzn4iaH7ilKG7fF7mWnGz2og=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-8AG496qDMpaB4LZL90eTFQ-1; Tue,
 25 Feb 2025 01:39:03 -0500
X-MC-Unique: 8AG496qDMpaB4LZL90eTFQ-1
X-Mimecast-MFC-AGG-ID: 8AG496qDMpaB4LZL90eTFQ_1740465541
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC3A0180087B;
	Tue, 25 Feb 2025 06:39:00 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E8C51800359;
	Tue, 25 Feb 2025 06:38:57 +0000 (UTC)
Date: Tue, 25 Feb 2025 14:38:53 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] mm, swap: use percpu cluster as allocation fast
 path
Message-ID: <Z71lfU1HMRilvYCz@MiWiFi-R3L-srv>
References: <20250224180212.22802-1-ryncsn@gmail.com>
 <20250224180212.22802-6-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224180212.22802-6-ryncsn@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 02/25/25 at 02:02am, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Current allocation workflow first traverses the plist with a global lock
> held, after choosing a device, it uses the percpu cluster on that swap
> device. This commit moves the percpu cluster variable out of being tied
> to individual swap devices, making it a global percpu variable, and will
> be used directly for allocation as a fast path.
> 
> The global percpu cluster variable will never point to a HDD device, and
> allocations on a HDD device are still globally serialized.
> 
> This improves the allocator performance and prepares for removal of the
> slot cache in later commits. There shouldn't be much observable behavior
> change, except one thing: this changes how swap device allocation
> rotation works.
> 
> Currently, each allocation will rotate the plist, and because of the
> existence of slot cache (one order 0 allocation usually returns 64
> entries), swap devices of the same priority are rotated for every 64
> order 0 entries consumed. High order allocations are different, they
> will bypass the slot cache, and so swap device is rotated for every
> 16K, 32K, or up to 2M allocation.
> 
> The rotation rule was never clearly defined or documented, it was changed
> several times without mentioning.
> 
> After this commit, and once slot cache is gone in later commits, swap
> device rotation will happen for every consumed cluster. Ideally non-HDD
> devices will be rotated if 2M space has been consumed for each order.
> Fragmented clusters will rotate the device faster, which seems OK.
> HDD devices is rotated for every allocation regardless of the allocation
> order, which should be OK too and trivial.
> 
> This commit also slightly changes allocation behaviour for slot cache.
> The new added cluster allocation fast path may allocate entries from
> different device to the slot cache, this is not observable from user
> space, only impact performance very slightly, and slot cache will be
> just gone in next commit, so this can be ignored.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/swap.h |  11 ++--
>  mm/swapfile.c        | 136 +++++++++++++++++++++++++++++--------------
>  2 files changed, 95 insertions(+), 52 deletions(-)

Reviewed-by: Baoquan He <bhe@redhat.com>


