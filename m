Return-Path: <linux-kernel+bounces-526937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685C8A4055B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 04:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9F5700966
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 03:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55E91EA7C1;
	Sat, 22 Feb 2025 03:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k+X+VAFn"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DC12111
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 03:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740195968; cv=none; b=r3APyjsLLw86D5M0pr2f0Fko2JU5djh5G/zgZQ+Ozpn/XkP0VsIz941+p10z8LB31MQXCWGgJlWaGFMQans+i7zAQ6NiWpAhfq90TfWuOnGECj6xZcBgsbIhCLwUG+B86yA82VT2y+kM9wnkaBsRIwzEp5BEBVcm3ME73viqSc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740195968; c=relaxed/simple;
	bh=EJqk0UQEhOZmXQKWkQUinNzoojW8Gzj2QfhEYNkICwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPmpRFlhbN3EPgUDyy7eHghIW3yXzADYOkcgykHp3kmq5TZ7CmLLKwyRNcbDjdnco5gF/+tfYgt5Kusb103qycQRdTVhjCI3x+Hnhf75yB1yj/VgXA068+MuUsqAHI2aa28CxH35YlV/UBe7g+zX0K6Novu62XdReTfnGtu4MoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k+X+VAFn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EJqk0UQEhOZmXQKWkQUinNzoojW8Gzj2QfhEYNkICwA=; b=k+X+VAFnxQOr0Dvvy2QBtrlVhO
	DOkRSMw5NY23oSC5K+vYxLI2GhMd14KYTbprSqRI18zLq4XaERGG0ivu+7SMQMygYuOZPmvblEoGz
	Ctk+Gcn9Lh++OlAc4p8jd0EneFuE9Vtt8XbUkbe2L2hDKHguJRtci8ng7Rc3z5VlBgr1/a4oar8Ah
	ol9MsZbX/Un2NQH8aFf3xAQrcz+7nt7ZYg+irm2AvAK1CILqKJl6aqiu7Pgf9vC+gemCV0ItdwP+2
	c3uI/i/ihndayKujuNbP6yejazIpakkTv2U3nIMG706fBFbzxYJc2RRpzDV3JhM8zS7NWV7A/vNk7
	eKsgR+Ow==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlgSR-0000000G93v-126g;
	Sat, 22 Feb 2025 03:45:39 +0000
Date: Sat, 22 Feb 2025 03:45:39 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Wupeng Ma <mawupeng1@huawei.com>
Cc: akpm@linux-foundation.org, david@redhat.com, kasong@tencent.com,
	ryan.roberts@arm.com, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, schatzberg.dan@gmail.com,
	baohua@kernel.org, hanchuanhua@oppo.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: swap: Avoid infinite loop if no valid swap entry
 found during do_swap_page
Message-ID: <Z7lIYzLSACbWxlEM@casper.infradead.org>
References: <20250222024617.2790609-1-mawupeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222024617.2790609-1-mawupeng1@huawei.com>

On Sat, Feb 22, 2025 at 10:46:17AM +0800, Wupeng Ma wrote:
> Digging into the source, we found that the swap entry is invalid due to
> unknown reason, and this lead to invalid swap_info_struct. Excessive log
> printing can fill up the prioritized log space, leading to the purging of
> originally valid logs and hindering problem troubleshooting. To make this
> more robust, kill this task.

this seems like a very bad way to fix this problem

