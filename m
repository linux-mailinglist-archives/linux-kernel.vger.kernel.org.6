Return-Path: <linux-kernel+bounces-369855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DADB9A2385
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3061C263EF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88D91DDC0F;
	Thu, 17 Oct 2024 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DmDNsh1b"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41F71D414F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171221; cv=none; b=Q/TDkCXOWxQtCkNIowtBo0vngzFp2TvjujlBGBp2OqbzUy14bieyhxTAPc9dv0e0iZLJGjCTIVDAnuWBSfz7jzKeJBq7U5cSK+TbRSPrV+112O1mjNfZY4DWw35fl9Gbj5QkIETvGKLlCkR3KQlUkHBLwoIO5UOspp0tuKmKzVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171221; c=relaxed/simple;
	bh=ZpDVjRfDT3v4gGde+BNomr2zDPLrAaOnyp+dW02/tyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuX91Unx037Bxrj1z8S0LN12K4Og7j1wM5P35x75EeDSnjoYrfNrYf37VcASyV2gmTYDwGu/PqjVQ/8Sq1C1nGqNWXcSKlKD+WLFt8tfpxWUVaCZYDe9ZEhvqU6BUkR4Ti2CiL/x79ucqbcASSAyNSMiqKtKf3YK865rxnSUzsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DmDNsh1b; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TXjymKZ9DjXZaZx40OTQFObVGnGDKMspsu7LkpNUe7w=; b=DmDNsh1boDpSvRs8Wb5/b0qbOO
	94J/+hTVVa5CJhwKBEx9Y0L9u1sM9Rjd9vnRgaScLsH7KL+VHx6Vo16niUDR5dAfinbFhvtcQMDjx
	eJf+zNDBUlbrosODL7gT5NRuSQgB28zeOP7abw0dxNVqmUh2QMuW4jXenzGBJf2lZDfSMGXFVo4ea
	phlh/c4GuNwg5xV6C4W1EjuSuJgNCsWJJw8WoF+Zgo6mext2fr1Rv82he/Dbv+irqBIieAVSvzJpx
	/iwYk1hzrl1mcA+edgAWnif20Vicg4Bq9ImALTkr1jxNJnhf459v9W1e165zVZ7EUHNYcLY4mHfva
	I2xz7eng==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1QQG-0000000B8OA-2MSF;
	Thu, 17 Oct 2024 13:20:12 +0000
Date: Thu, 17 Oct 2024 14:20:12 +0100
From: Matthew Wilcox <willy@infradead.org>
To: lizhe.67@bytedance.com
Cc: akpm@linux-foundation.org, boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	longman@redhat.com, mingo@redhat.com, peterz@infradead.org,
	will@kernel.org
Subject: Re: [RFC 2/2] khugepaged: use upgrade_read() to optimize
 collapse_huge_page
Message-ID: <ZxEPDMUnYlAy3r3_@casper.infradead.org>
References: <Zw-pK_4wCvJHKfSi@casper.infradead.org>
 <20241017061841.81240-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017061841.81240-1-lizhe.67@bytedance.com>

On Thu, Oct 17, 2024 at 02:18:41PM +0800, lizhe.67@bytedance.com wrote:
> On Wed, 16 Oct 2024 12:53:15 +0100, willy@infradead.org wrote:
> 
> >On Wed, Oct 16, 2024 at 12:36:00PM +0800, lizhe.67@bytedance.com wrote:
> >> From: Li Zhe <lizhe.67@bytedance.com>
> >> 
> >> In function collapse_huge_page(), we drop mmap read lock and get
> >> mmap write lock to prevent most accesses to pagetables. There is
> >> a small time window to allow other tasks to acquire the mmap lock.
> >> With the use of upgrade_read(), we don't need to check vma and pmd
> >> again in most cases.
> >
> >This is clearly a performance optimisation.  So you must have some
> >numebrs that justify this, please include them.
> 
> Yes, I will add the relevant data to v2 patch.

How about telling us all now so we know whether to continue discussing
this?

