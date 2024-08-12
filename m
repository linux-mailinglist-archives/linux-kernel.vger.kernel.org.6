Return-Path: <linux-kernel+bounces-283013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A38B994EBEF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A0C1F2247F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756D2176FB2;
	Mon, 12 Aug 2024 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0Hghn9jO"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7986116FF4E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462750; cv=none; b=kjp6RJYou5uZprbPXma5tovziNsFtjwDabFtTlksB6X7ohvNW2w4KqQO/qpWMdeMi1/yR8mGxHcmIo8QO0CoMQJnTO83+200olbhWxg5RwdVSPCl8aIUH2SXYy9ku/PQ8XQTTAKw1qjAH7tIyCQajZWm2IPohF2azAoCD3t+GWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462750; c=relaxed/simple;
	bh=elN3CLvtzwfZNmM5sadFqSVbnngI0w/N9P5qApOD1jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ4BR0/O15rRCY4TxdsPxsIflg7ZCJpVkTx5iTHf+hdj3PI4WMe+Wm7awyGBKQAPmlASRrcgNBP2dLJTB+yfVK8mnYekGUZA2RMoy4AHVTpzJLLHEXNzG+3UhHv3xte/ZDxlpnfSwrIJyNiOMysSX0cl6SBvzuXVr6TghcHW2Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0Hghn9jO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=9QeBzfyt7uwo2634Q3bLzYTBJAAbSVcjEFRlDnwoGms=; b=0Hghn9jObIur5bYWdn9rRa58al
	DiH+aIR3oy2lZGsv766i210aOiNBl+qa4loPUpcwbJrMwmF1XmHd3fjy+r743Dt08yL3Jbd9Q0Au5
	tMTuRhymFJNZbjOjl+OG75qKaR7YXhbCe+rBVnT3vcZccf8YtB4jlXT0T/MhBfeSS0ih9ZLpZoF7P
	m7VSKCXiZBoIkLiY7IhHMTJ88Es6jXOzCgmrhKein9ySMDFURMbluW9gTKDJNQuHGH9hzCJZICXQ0
	xVbGOhErkfjC8FEP2nuuLHrD3h9/M/o6e3vxozngMxl0u7xgyJVAplMKudvkRbZrzqWeDuPQUU5Pv
	68Cs/U/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdTO1-000000009df-2f6F;
	Mon, 12 Aug 2024 11:38:53 +0000
Date: Mon, 12 Aug 2024 04:38:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
	linux-mm@kvack.org, baolin.wang@linux.alibaba.com,
	chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org,
	hughd@google.com, kaleshsingh@google.com, kasong@tencent.com,
	linux-kernel@vger.kernel.org, mhocko@suse.com, minchan@kernel.org,
	nphamcs@gmail.com, ryan.roberts@arm.com, senozhatsky@chromium.org,
	shakeel.butt@linux.dev, shy828301@gmail.com, surenb@google.com,
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
	ying.huang@intel.com, yosryahmed@google.com,
	Chuanhua Han <hanchuanhua@oppo.com>
Subject: Re: [PATCH v6 2/2] mm: support large folios swap-in for zRAM-like
 devices
Message-ID: <Zrn0TS9vyfbQW8Yq@infradead.org>
References: <20240726094618.401593-1-21cnbao@gmail.com>
 <20240802122031.117548-1-21cnbao@gmail.com>
 <20240802122031.117548-3-21cnbao@gmail.com>
 <ZrnHTpzp65iZqTJ5@infradead.org>
 <CAGsJ_4z-4mPNaGSuj6spfzms0sa-DtEcKSQwFDOXb6Rn5R_kSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4z-4mPNaGSuj6spfzms0sa-DtEcKSQwFDOXb6Rn5R_kSg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 12, 2024 at 08:53:06PM +1200, Barry Song wrote:
> On Mon, Aug 12, 2024 at 8:27 PM Christoph Hellwig <hch@infradead.org> wrote:
> I assume you mean the below?
> 
> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> {
> }
> #else
> static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> {
> }
> #endif

Yes.

> If so, this is fine to me. the only reason I am using the current
> pattern is that i am trying to follow the same pattern with
> 
> static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> {
>         struct vm_area_struct *vma = vmf->vma;
> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> #endif
>         ...
> }
> 
> Likely we also want to change that one?

It would be nice to fix that a well, probably noy in this series,
though.


