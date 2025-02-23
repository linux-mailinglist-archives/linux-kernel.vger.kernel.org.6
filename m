Return-Path: <linux-kernel+bounces-527554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E852A40C93
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 03:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5DD17DDD4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 02:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661351804A;
	Sun, 23 Feb 2025 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WSm0Ox81"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DE4134AB
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 02:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740278542; cv=none; b=gobZEPAxNjDIF+wFtQWF3E9U/J35iyZhkWYXdGuBAGLVEezTwYcX0i4N3s4yxT+wurLvlgvfJJqeF2KI8JzrQqf5qNlTIfrvyRECrQVSAuLKuptQN+3VLGiTioj89UBL1GVAb5dUouGC+gkK3H+ySEWh9Z19d9DBYnh23fgEsCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740278542; c=relaxed/simple;
	bh=ZM7T9L6xROb9kuSY2Eib4p4PiPmwdwxc8gfsecwdCqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUsZpoifIJ1co8aXfxluXZ9dGuE1gl8FlPa+e2xeFVPZYVUGB2WKcPBP+YJ1vhHfm555hnj108NLjIzrEmp1dikd4FsbK9C9cKie2sZezU3wy78odcst1UrtM8umLrsjiu5vMqRAFBtZWc07LqhboA8Sn0yQttUmzxPY3yjmVAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WSm0Ox81; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Wc7Z0C11VCJFYQ57krjgsaNwLdklCNggyK9O158fz1g=; b=WSm0Ox81k5GehJtP7NwLYMw+Av
	MJp1BllrBn3mRVssCWlxg1sl3FW0w3CFmGhV6LDRoAkv9d2e9aa53Sbv+a+IiYC0+/JKJ2sJ0pkdy
	QvOwxvLNPQedGP8KVcJBtO8zwrS25EzKGZKsza/w5+wxLPq684U4pOFDKCkb9fRj/nZmxrcD11Q/V
	VzKVJ7N3uDPkJM2VhXj+DjHpn1rTb8QMbUbopAUUFe1k009vlH4MbVdb24kPBdsFW6I0f4xM08iEi
	HmFDYXjoW1Ru0JSwL5Ge1l+TNB4Xql4vJkKsU0I8aXS6fpAKEBfog2+F0uClAw+5gU+9nXDy3M0gd
	caJxKFIw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tm1wO-000000023c5-1TKn;
	Sun, 23 Feb 2025 02:42:00 +0000
Date: Sun, 23 Feb 2025 02:42:00 +0000
From: Matthew Wilcox <willy@infradead.org>
To: mawupeng <mawupeng1@huawei.com>
Cc: akpm@linux-foundation.org, david@redhat.com, kasong@tencent.com,
	ryan.roberts@arm.com, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, schatzberg.dan@gmail.com,
	baohua@kernel.org, hanchuanhua@oppo.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: swap: Avoid infinite loop if no valid swap entry
 found during do_swap_page
Message-ID: <Z7qK-NFJsqcV0rPw@casper.infradead.org>
References: <20250222024617.2790609-1-mawupeng1@huawei.com>
 <Z7lIYzLSACbWxlEM@casper.infradead.org>
 <2c7dfa44-266a-4aa6-9401-7528368f171e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c7dfa44-266a-4aa6-9401-7528368f171e@huawei.com>

On Sat, Feb 22, 2025 at 11:59:53AM +0800, mawupeng wrote:
> 
> 
> On 2025/2/22 11:45, Matthew Wilcox wrote:
> > On Sat, Feb 22, 2025 at 10:46:17AM +0800, Wupeng Ma wrote:
> >> Digging into the source, we found that the swap entry is invalid due to
> >> unknown reason, and this lead to invalid swap_info_struct. Excessive log
> >> printing can fill up the prioritized log space, leading to the purging of
> >> originally valid logs and hindering problem troubleshooting. To make this
> >> more robust, kill this task.
> > 
> > this seems like a very bad way to fix this problem
> 
> Sure, It's a bad way to fix this. Just a proper way to make it more robust?
> Since it will produce lots of invalid and same log?

We have a mechanism to prevent flooding the log: <linux/ratelimit.h>.
If you grep for 'ratelimit' in include, you'll see a number of
convenience functions exist; not sure whether you'll need to use the raw
ratelilmit stuff, or if you can just use one of the prepared ones.

