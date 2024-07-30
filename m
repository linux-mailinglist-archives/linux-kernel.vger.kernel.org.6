Return-Path: <linux-kernel+bounces-267889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39479941950
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB4128873A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2D81898F4;
	Tue, 30 Jul 2024 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qeWQC7lG"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECAF148848
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357064; cv=none; b=E5I1IhnpOroxbvLBFTcyvF2KQ5Z6x8zt6dEuBV3ueZ+5BbaoZuSEoypm6ULE9vUvx+TokCYQ1IfmIUFxgrBrsRLDyTYO8uHz07STHqnWPGAVA2Wy5vHIgVn0ZILdAmhIc0Ew0ACGNdZGpJp+5mESl9THL8soEWIzhaMWshD3IUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357064; c=relaxed/simple;
	bh=+C0E1OanNPR6JWfsgQVFSr3T1t2R3zLqnhwmlGBvsGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCYJC5OuviAJM0LRDh6mMyHP/oiKuhL0WMVmLoO3yjnKmNrWAzmWzdRLMEuxydEIS5QWmc6O6ue3rRJik675EUXkkRRjAONX2MN/ouyzENAMpMkjvg0ATOolFmKrx5raile5kc+dgMjRiSKbak01Yi120qBPHDPrHyY8gHihsIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qeWQC7lG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N4r8fij+5bYAfmVEXguco28K5EokHtUd/W88ZrJncUY=; b=qeWQC7lGs9fCpnbeNdovZWG2IO
	YQmngMkI7RN3B6jmz3kwZeQ4HjCYuanpLQ3nWU478I87lU90puzIl1TkbFf2wjp3IOGXRtSSTfB0X
	iHCTeW82Ph+tjAWBfIhyOQzkiyf+Q5GLgoTYpX8UN++PzYJ7sfqhxdfEE/stM+5RYE+Glrh1O0CC5
	P1A5JqjLGjalpkEDJew8xUpEilkvicXaSDCSX8tW7ciZFGKeCPsg5E3vo3rEuV7MOI1IZ/unH3Mkn
	a4Bhvdp9hQmW7ObigGHIG2haniKb99l02AYoCemyOfFhi1tIPptj/t1GL7s8+HNg320t1YqFXAsf4
	NWmdnBJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYpkI-0000000Fs5L-0pMd;
	Tue, 30 Jul 2024 16:30:42 +0000
Date: Tue, 30 Jul 2024 09:30:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
	linux-mm@kvack.org, ying.huang@intel.com,
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com,
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com,
	senozhatsky@chromium.org, shakeel.butt@linux.dev,
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
	xiang@kernel.org, yosryahmed@google.com
Subject: Re: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
Message-ID: <ZqkVMpbl5pH35uOq@infradead.org>
References: <20240726094618.401593-1-21cnbao@gmail.com>
 <20240726094618.401593-5-21cnbao@gmail.com>
 <ZqcR_oZmVpi2TrHO@casper.infradead.org>
 <Zqe_Nab-Df1CN7iW@infradead.org>
 <CAGsJ_4wfWYGZVouK4JTj9DBDNPKTX_zrfU45iivaUy-Nq-P1bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4wfWYGZVouK4JTj9DBDNPKTX_zrfU45iivaUy-Nq-P1bA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 30, 2024 at 08:11:16AM +1200, Barry Song wrote:
> > We also really need to stop optimizing for this weird zram case and move
> > people to zswap instead after fixing the various issues.  A special
> > block device that isn't really a block device and needs various special
> > hooks isn't the right abstraction for different zwap strategies.
> 
> My understanding is zRAM is much more popularly used in embedded
> systems than zswap. I seldomly(or never) hear who is using zswap
> in Android. it seems pointless to force people to move to zswap, in
> embedded systems we don't have a backend real block disk device
> after zswap.

Well, that is the point.  zram is a horrible hack that abuses a block
device to implement a feature missing the VM layer.  Right now people
have a reason for it because zswap requires a "real" backing device
and that's fine for them and for now.  But instead of building VM
infrastructure around these kinds of hacks we need to fix the VM
infrastructure.  Chris Li has been talking about and working towards
a proper swap abstraction and that needs to happen.

