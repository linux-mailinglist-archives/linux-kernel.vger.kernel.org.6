Return-Path: <linux-kernel+bounces-174139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB788C0AB3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A83B284360
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD61149006;
	Thu,  9 May 2024 04:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1OW70ydo"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481A1D26D
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 04:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715230358; cv=none; b=jmCioPeapVPs9Hsd8kXR0kOFI0l8OZo38k4hG6eNQbvVsy0TjmKrsIiebgighw6wSlxM+9aUl8Lr+PjioXR4cuCDVDLuuFHgvEFFqPaj60j2JOgSLs6k4gZUdvoV2GghhBzG4C9plFZqaa3njEfH/yFvnZPSNYDUaI4aWR9ot8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715230358; c=relaxed/simple;
	bh=fYnFG2PrP95ZslKYekACDfFg/PRLLfiLU16BTpA/irI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCdScoGZdDonQAQs76nbBa3vD+2z3Hob7XVEAsoQXht7bPHLk+lShvulUWMsaKIrbL1BnH9xbtkFUewzvdMR3UUltDBF/HOCvUHfkSaUHGWmgBqke/0zh7EwLOMnXd42Ln9xvYU7d1U8Xv1U0C+NhSYxFBwCvOKvni9iGoshIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1OW70ydo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GK8skucNd3RCC7HoRVlzYUTm9Wu/E1K3l93ozVZHIl4=; b=1OW70ydophlQncbAq89LV4LOpR
	RK1UsHgA2PsqhlFa2fOeQA930u3Tf5bjmO7rPHIZ7dFjFa3oVfeOA2hVTSSYphpFF0A9EG/C+qpJ+
	E+/H0mlJP2aQijinCkU4GLG7D+TFQesTkEskQQHwpO4Addc0W14z7MRxOUPn3N1Ndzwkd1D76BWSZ
	loDlz6ZS0wrmRnEf71ZYAGZEq2Zb0CVTxieMj16/gDXI+KcIAaYVzSbLyZ7WhI+7cIC6MkpczAXXF
	5xgOkE3yG26chVjNbKmVXoCVz7eqDRSjv3qsP4XaCousiMdcxVHO6dUNCm0K4qhNbq3nY3rgAy3t5
	+dRjscYg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4vli-00000000M7q-3CR3;
	Thu, 09 May 2024 04:52:34 +0000
Date: Wed, 8 May 2024 21:52:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: hailong.liu@oppo.com, akpm@linux-foundation.org, urezki@gmail.com,
	hch@infradead.org, lstoakes@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, xiang@kernel.org, chao@kernel.org,
	Oven <liyangouwen1@oppo.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
Message-ID: <ZjxWkleEdk5iUxI8@infradead.org>
References: <20240508125808.28882-1-hailong.liu@oppo.com>
 <CAGsJ_4xN0MBz_73wUvMp74upd9SaQ+TCRJufEj26Y619Rtr7Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xN0MBz_73wUvMp74upd9SaQ+TCRJufEj26Y619Rtr7Zw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 09, 2024 at 02:20:03PM +1200, Barry Song wrote:
> reverting the fix intended to address the OOM-killer issue in commit
> dd544141b9eb.
> Should we indeed permit the NOFAIL flag for large kvmalloc allocations?

What is large?  When you don't allow actually use cases people will
just reimplement it poorly.  E.g. we'd probably have to add back the
XFS kmem_ wrappers.


