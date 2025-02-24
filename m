Return-Path: <linux-kernel+bounces-529466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B22BA426BD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33783B8B89
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B94254875;
	Mon, 24 Feb 2025 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dGy0+c5q"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0C325485B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411490; cv=none; b=s3hbFRrD7vbP6QFwGDskluQKKVUrEJqhK8i1ffN4IGr6J6nk5OEhAbm2A5WevPHBn8naixfIhoTd6zJ9J6ahjJk/2y98ZY09QCvIsJBj9oqQ9SqX89Go7F3NWW3Vaxdg65ZP2JUNJM4PnPiyiD1qi4t19y3Nu+YDde/zxLgSASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411490; c=relaxed/simple;
	bh=j8o9GKbT57kAoPCJxDrkBqp6xzsOaxriQPBX4FclW50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPjv4Gy1KuqQ7Cx3vqChvtLR0Vm5gGXnPh5IuizvVzjdlzWNuKqRKIb9AxgPFJ88ApHwHEG/GwyvNq+9rmt0sRbtz4puvujZcPykcn5fyHeuN1SeQnrcGo9d1hWaUaeZNbDhyI+EfoAy7Dwx2uQaeNYhhbK7W2i4ceVZ/rX0cXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dGy0+c5q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Foq8I3JNlChaWlKQTvXhKnxEWV4W/FEAiOkbf1faxlw=; b=dGy0+c5qb/Ao3yXfO22EMIa740
	binkjYpxDp1zZL0363NCPW0EWT/+sRO6kB/Bmh7Q827os8SN3d3SNCsK4QZTZdkG3t3RNuN5VLvfS
	IpTbM2aysd6QNxGjpf2OG/bgmL6QvcqWnyUYaOtQjRF5DUqM4pqm78TK3TwgTZddGX1Xmyq0vx49y
	ZQnAjFDSswza/03nxku2ssEYXQk+H9ClENAumqvUKtBkqtPhfApeWSRanxNGgI+lKauJAlmNP+lG8
	uPe64Hwsu3gxYvylSMp+PvNM0o3RYI2v/dUxt4mT7+/cauxpsDe7hYypcT3SpQ/toTp5cUDos0ZqW
	k5xO3/jw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmaWp-00000007ehN-1QT3;
	Mon, 24 Feb 2025 15:37:55 +0000
Date: Mon, 24 Feb 2025 15:37:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: mawupeng <mawupeng1@huawei.com>, akpm@linux-foundation.org,
	david@redhat.com, kasong@tencent.com, ryan.roberts@arm.com,
	chrisl@kernel.org, huang.ying.caritas@gmail.com,
	schatzberg.dan@gmail.com, hanchuanhua@oppo.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: swap: Avoid infinite loop if no valid swap entry
 found during do_swap_page
Message-ID: <Z7ySUwdkXRsBjhLR@casper.infradead.org>
References: <20250222024617.2790609-1-mawupeng1@huawei.com>
 <Z7lIYzLSACbWxlEM@casper.infradead.org>
 <2c7dfa44-266a-4aa6-9401-7528368f171e@huawei.com>
 <Z7qK-NFJsqcV0rPw@casper.infradead.org>
 <CAGsJ_4xHaaf_DHsFZ_zEqEd3Nb9C=7JJjy5gGFo+RhEhQYX_tg@mail.gmail.com>
 <61566a74-04aa-44f1-9aa9-624644f06450@huawei.com>
 <CAGsJ_4zLw5+A+0gaeubBSLuL1EcaHgFa41dt+BG3VgmPsF=Ocw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zLw5+A+0gaeubBSLuL1EcaHgFa41dt+BG3VgmPsF=Ocw@mail.gmail.com>

On Mon, Feb 24, 2025 at 08:11:47PM +1300, Barry Song wrote:
> Please send a V2 and update your changelog to accurately describe the real
> issue. Additionally, clarify how frequently this occurs and why resolving
> the root cause is challenging. Gaoxu reported a similar case on the Android
> kernel 6.6, while you're reporting it on 5.10. He observed an occurrence
> rate of 1 in 500,000 over a week on customer devices but was unable to
> reproduce it in the lab.
> 
> BTW, your patch is incorrect, as normally we could have a case _swap_info_get()
> returns NULL:
> thread 1                                           thread2
> 
> 
> 1. page fault happens
> with entry points to
> swapfile;
>                                                        swapoff()
> 2. do_swap_page()
> 
> In this scenario, _swap_info_get() may return NULL, which is expected,
> and we should not return -ERRNO—the subsequent page fault  will
> detect that the PTE has changed. Since you have never enabled any
> swap, the appropriate action is to do the following:
> 
>         /* Prevent swapoff from happening to us. */
>         si = get_swap_device(entry);
> -       if (unlikely(!si))
> +       if unlikely(!si)) {
> +                      /*
>  +                     * Return VM_FAULT_SIGBUS if the swap entry points to
> +                      * a never-enabled swap file, caused by either hardware
> +                      * issues or a kernel bug. Return an error code to prevent
> +                      * an infinite page fault (#PF) loop.
> +               if (WARN_ON_ONCE(!swp_swap_info(entry)))
> +                       ret = VM_FAULT_SIGBUS;
>                 goto out;
> +       }

This is overly specific to the case that you're tracking down.
So it's entirely appropriate to apply to _your_ kernel while you work on
tracking it down, but completely inappropriate to upstream.

