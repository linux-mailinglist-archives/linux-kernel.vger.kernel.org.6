Return-Path: <linux-kernel+bounces-327334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC8E97744F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59EB91F25298
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0233C19E98B;
	Thu, 12 Sep 2024 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="DLDSueZI"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817CD20DF4
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726180223; cv=none; b=afSpHHA7aIIiNYwCaW6u0/EW1Yf2IjYBbPtcHhu9x4+7Cg6K8+5UqZmKDjnqTQxygaBjFE4h8/3rGdT0NR0MdgfRpYJcMpu4rpWZ39KqSaRsN3Sp92+T02kUoF+15EFYqYr4OL93P0hWZDTAcNj/J5gEf46rupYtFn+d9x9+tik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726180223; c=relaxed/simple;
	bh=l78uYYUDdPq8NYE6gjoHUQJq/YK7wZojSJ0RQKOF0aw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ac3zBCgXJPtKTKCTjS6w9H7SYIkMZIt5MNETwX6M+rHRs6SQIEj3wqCjsQ/M0xoIRZrr2hXHbqxt5ps4E3135z+vpIiv7I1u3HxRRq5Bcg2ityppRZ60i1a79GIU/Ywrxc943ywoJ2mnvXiBk9k0TuIqCu8bCAdjG+7u8GgIjho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=DLDSueZI; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1726179662;
	bh=l78uYYUDdPq8NYE6gjoHUQJq/YK7wZojSJ0RQKOF0aw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=DLDSueZIc9xylIWaSQCWxbKxnRD/+z5nSSQhuanrh0lVcivSVWajubmOwVpR+qE3S
	 ciT/0JUTH2P0byafBd9FRq0ke3OntwIkYLn4SSVp7Y4JM1o9Po3/wEpRRsl0507v3w
	 jtXpwHVegSlGjJn4ujk/SAuokCuXLyarJVwuYEbw=
Received: by gentwo.org (Postfix, from userid 1003)
	id 538E94027D; Thu, 12 Sep 2024 15:21:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 51A73401CB;
	Thu, 12 Sep 2024 15:21:02 -0700 (PDT)
Date: Thu, 12 Sep 2024 15:21:02 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Matthew Wilcox <willy@infradead.org>
cc: kernel test robot <lkp@intel.com>, 
    Christoph Lameter via B4 Relay <devnull+cl.gentwo.org@kernel.org>, 
    Vlastimil Babka <vbabka@suse.cz>, Pekka Enberg <penberg@kernel.org>, 
    David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, Yang Shi <shy828301@gmail.com>, 
    oe-kbuild-all@lists.linux.dev, 
    Linux Memory Management List <linux-mm@kvack.org>, 
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    Huang Shijie <shijie@os.amperecomputing.com>
Subject: Re: [PATCH v2] SLUB: Add support for per object memory policies
In-Reply-To: <ZuMk2Yc7i-JMiHpA@casper.infradead.org>
Message-ID: <5f9e2cbd-a7a6-53c1-8272-6f91fb525571@gentwo.org>
References: <20240906-strict_numa-v2-1-f104e6de6d1e@gentwo.org> <202409080304.haF25cFZ-lkp@intel.com> <2011fcea-b4f3-a7ec-e747-6ee0195452e1@gentwo.org> <ZuMk2Yc7i-JMiHpA@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 12 Sep 2024, Matthew Wilcox wrote:

> On Thu, Sep 12, 2024 at 09:15:34AM -0700, Christoph Lameter (Ampere) wrote:
> > > sparse warnings: (new ones prefixed by >>)
> > > >> mm/slub.c:222:1: sparse: sparse: symbol 'strict_numa' was not declared. Should it be static?
> >
> >
> > Ummm.. This code declares strict_numa. Whats wrong with sparc64 / sparse ?
> >
> > > vim +/strict_numa +222 mm/slub.c
> > >
> > >    220
> > >    221	#ifdef CONFIG_NUMA
> > >  > 222	DEFINE_STATIC_KEY_FALSE(strict_numa);
>
> maybe this should be:
>
> static DEFINE_STATIC_KEY_FALSE(strict_numa);

Ah double staticity. Thanks.




From b239f4f26094845af74b091682f0bdcae56b5123 Mon Sep 17 00:00:00 2001
From: Christoph Lameter <cl@gentwo.org>
Date: Thu, 12 Sep 2024 15:15:07 -0700
Subject: [PATCH 3/3] [SLUB] Make strict_numa static

strict_numa is only used in mm/slub.c so it can be static.

Signed-off-by: Christoph Lameter <cl@linux.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2fa7c35e076a..56e320082c09 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -219,7 +219,7 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
 #endif		/* CONFIG_SLUB_DEBUG */

 #ifdef CONFIG_NUMA
-DEFINE_STATIC_KEY_FALSE(strict_numa);
+static DEFINE_STATIC_KEY_FALSE(strict_numa);
 #endif

 /* Structure holding parameters for get_partial() call chain */
-- 
2.39.2


