Return-Path: <linux-kernel+bounces-197544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 626728D6C52
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 00:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029DC1F238F0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD067EF10;
	Fri, 31 May 2024 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YOAb47UN"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7F224B4A
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717193406; cv=none; b=pjoCSPZVDNCP3J85ZxcDo5G6xhNq/n9H9BV+HXeneqDQxgIUijDZjzCCrN5cCt48+f7qEPPIEUQ0zHzNFrBSfZjjgCcr7Mre/f7+3DXQK2OVzMSiN+nYHVz4xb8PAX+d2sRzg+1tkRSo+Df3X8TQdioGgH5RQ+yqNoLMMwkxiKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717193406; c=relaxed/simple;
	bh=neMthn+my1WAJWqEpUsCTbkhD0SCbK/9kqeYHZgSIWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXneCoUxFxVrYy23A8PpnDyXUoim80sOgL7v+c5+cI19wwEvftcM9ZTOIqfncMBoMao88K9WybOK0bl5PzC5rh/708igP8ixQzu3SacEKuix4l0bhg+v881p/QkKIzSM3Y+tA5R/YRJ/McIKB23FQTwXyA12BcuvlvnbUPmxU5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YOAb47UN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MkS6taIPYxq4oexTWP4Nym8gBT1BhbKY0UZv23zB09c=; b=YOAb47UNG4kr8fjujJxJLocaah
	gAD8nRmrJmfY16d/vHGhG/ULklZSzFjKDEQj5Jsvt6jNIBVa2xYYwK0g9e5tZ9eyi1BEkZQPMEUXu
	LYjXw/PsVwoiWXHEwmTlg6s8+eWAFGraVhRyXIB2rHlue3eyQU7efWdgwvMux7vX9jSJfw95vIuW0
	CDxs+adDaRuBRPjULIb1qHKNhi5q4CxrlWJAisHnMltsxKLWucQZ0ynCzb0VVxreZfGYyVDv8jxs8
	7Dl1Q8BGXCO/5sDZ/TqL9Q2dBpe+kPcp9lMyAsWeT25aYFO5bjLIyDsUTu3mN3M0FUC8EZqR/RFFA
	AyLcaXPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDARW-0000000C4jN-2aQL;
	Fri, 31 May 2024 22:09:46 +0000
Date: Fri, 31 May 2024 23:09:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Byungchul Park <lkml.byungchul.park@gmail.com>,
	Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com,
	akpm@linux-foundation.org, ying.huang@intel.com,
	vernhao@tencent.com, mgorman@techsingularity.net, hughd@google.com,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v11 09/12] mm: implement LUF(Lazy Unmap Flush) defering
 tlb flush when folios get unmapped
Message-ID: <ZlpKqrm7d57gmoG5@casper.infradead.org>
References: <20240531092001.30428-1-byungchul@sk.com>
 <20240531092001.30428-10-byungchul@sk.com>
 <fab1dd64-c652-4160-93b4-7b483a8874da@intel.com>
 <CAHyrMpxETdVewTH3MCS4qPyD6Xf1zRUfWZf-8SCdpCFj2Pj_Wg@mail.gmail.com>
 <f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f17f33e8-1c1f-460f-8c5a-713476f524a3@intel.com>

On Fri, May 31, 2024 at 02:46:23PM -0700, Dave Hansen wrote:
> On 5/31/24 11:04, Byungchul Park wrote:
> ...
> > I don't believe you do not agree with the concept itself.  Thing is
> > the current version is not good enough.  I will do my best by doing
> > what I can do.
> 
> More performance is good.  I agree with that.
> 
> But it has to be weighed against the risk and the complexity.  The more
> I look at this approach, the more I think this is not a good trade off.
> There's a lot of risk and a lot of complexity and we haven't seen the
> full complexity picture.  The gaps are being fixed by adding complexity
> in new subsystems (the VFS in this case).
> 
> There are going to be winners and losers, and this version for example
> makes file writes lose performance.
> 
> Just to be crystal clear: I disagree with the concept of leaving stale
> TLB entries in place in an attempt to gain performance.

FWIW, I agree with Dave.  This feels insanely dangerous and I don't
think you're paranoid enough about things that can go wrong.


