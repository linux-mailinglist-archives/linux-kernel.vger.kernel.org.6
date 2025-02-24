Return-Path: <linux-kernel+bounces-528169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87986A4147A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 05:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0893B2B14
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 04:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374441A317A;
	Mon, 24 Feb 2025 04:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vEXYWsVN"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D52726AF3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740370939; cv=none; b=jom8meDxksXbmDUS+p3vI6peR7sQ17lOP58x0L5OFL73X4epJwfYUV/Izsg6lCM+w+SmziKV4FG3OAizOrSloNpAwguCJ5976M+9MuxFUmDrram4yi5cLv+8iZfRaJHij8n7yUr1WSJbCU530W0wOA5H0ERDF0QbgUhauZXDgyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740370939; c=relaxed/simple;
	bh=N6SyPydiGOD/+ogCvmw7y2AhfQmq28mCwgAz4HdiQR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbuEfzkpnogRzDFDXQCsXWeucMeqeMfolR6u9Hk0kv1C8AXZj24qUuQ1j8AYxzAyU+kVk9bOtM9fJavPr1NZhLUCDvimZ6UjTZAvwQAqwX8ixv7R7PCnLmxXMkak9NyDeLN2XQOhejAtjSyEZiN+CwLQY5zq4D0l+1cX59oLiz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vEXYWsVN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=iaczR1coIXW0K2GHIHJRj7av80M15T1OEBjJcS+PABI=; b=vEXYWsVNZmSC6fJflbK4roRpzw
	COLzWOzK9Cu+LfmKoID6WpMtt7xfOUn0/Vo58r2NfQ7lkx69qtRCSwBpoXZK4wNgVmHM0x/iQO+12
	eEArtR/elg9oz3meMrPGoQN3A0fznJvC464+7SwjSIpPj/BThhBdNHkf6RXA5Iw47mCs7T2Ze0ARi
	PwqN0WJnk2/PQDp3AUXFvuxO4YczRKkBukMXuFPqA8bhzQ+CulUh7coT6TTMgi+z5kTqlA9TJ3VRg
	wcOlppGvFehzkQ1lNm823O3gSVpAFmOKVc8zXWFWNDFbMNtx4AxcnCAGzd898HuXhVvbhbpf2pp7+
	+qJb1K3w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmPyo-00000005nw2-2pFg;
	Mon, 24 Feb 2025 04:22:06 +0000
Date: Mon, 24 Feb 2025 04:22:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: mawupeng <mawupeng1@huawei.com>
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org, david@redhat.com,
	kasong@tencent.com, ryan.roberts@arm.com, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, schatzberg.dan@gmail.com,
	hanchuanhua@oppo.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: swap: Avoid infinite loop if no valid swap entry
 found during do_swap_page
Message-ID: <Z7vz7gBrbtE4foSI@casper.infradead.org>
References: <20250222024617.2790609-1-mawupeng1@huawei.com>
 <Z7lIYzLSACbWxlEM@casper.infradead.org>
 <2c7dfa44-266a-4aa6-9401-7528368f171e@huawei.com>
 <Z7qK-NFJsqcV0rPw@casper.infradead.org>
 <CAGsJ_4xHaaf_DHsFZ_zEqEd3Nb9C=7JJjy5gGFo+RhEhQYX_tg@mail.gmail.com>
 <61566a74-04aa-44f1-9aa9-624644f06450@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61566a74-04aa-44f1-9aa9-624644f06450@huawei.com>

On Mon, Feb 24, 2025 at 09:27:38AM +0800, mawupeng wrote:
> On 2025/2/23 14:18, Barry Song wrote:
> > On Sun, Feb 23, 2025 at 3:42 PM Matthew Wilcox <willy@infradead.org> wrote:
> >> On Sat, Feb 22, 2025 at 11:59:53AM +0800, mawupeng wrote:
> >>> On 2025/2/22 11:45, Matthew Wilcox wrote:
> >>>> On Sat, Feb 22, 2025 at 10:46:17AM +0800, Wupeng Ma wrote:
> >>>>> Digging into the source, we found that the swap entry is invalid due to
> >>>>> unknown reason, and this lead to invalid swap_info_struct. Excessive log
> >>>>> printing can fill up the prioritized log space, leading to the purging of
> >>>>> originally valid logs and hindering problem troubleshooting. To make this
> >>>>> more robust, kill this task.
> 
> Yes, log flooding is not the main issue here, endless #PF is rather a more serious
> problem.

Then don't write the report as if the log flooding is the real problem.

