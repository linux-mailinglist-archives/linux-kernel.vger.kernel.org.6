Return-Path: <linux-kernel+bounces-326988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07112976F86
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98284B22A85
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADE61BF7F2;
	Thu, 12 Sep 2024 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OmIhGJHD"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B475915098A;
	Thu, 12 Sep 2024 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162149; cv=none; b=cNPCh3Qp1x6lBIbQ8ncQW0+14GNiyYn701Z4t4CJzpq8HR7qgKowlTPWPmkH2Loc4bn4YQmWMOYJnkY50smcXsZdHj1QOf9hDmHfQ98sboNc/ru5vmmSDaGVsTsWjUXqhrv0HSvsp4DYe2Lkm8SFcl4trylpJQnd/QktbOq8gcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162149; c=relaxed/simple;
	bh=guV6px4hm7u/hDlbH2Sr/0p9i7DHvYTiDy8RWrWppJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZ2xXZdYF8U7XsnOjZOQ9bSC4+6YURZpTnuoReREZ4bf8asDvTKNFhaKRwCqDjzcA0wlBCEcEVhEXGctWNwkD/yO9R3BGxQ//dXyuuJ8DTqCgji5MiWvl+nwYHDxZ9t9dld3snRPELo+h+KY8Ca1yO02CU4+paCNCgLQ6Vxyaf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OmIhGJHD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hrVMC21P1xrwM4QIBFAh+bX10ttuPrl/vASIkrjY7Uk=; b=OmIhGJHDI9el35L+OmDEXjnF/h
	RlnjuEeE73Syq/02eEZ1ZQecSLbo0X6xYvbS8Jjs5YhBjKjzTpuFzSPhOZKtwCvpzxSgd4BL0doGv
	2o1XChB6joqcbuAHR/7dyodu6qdXG9zGJYOg5Y9ScmqEtsKoKLPNhbZU0JwPM9q9+z2Q4GedxqlfD
	JGMITVn6h3zdE0+CXIPFlB5m2XkZtj2vskcaNj1SwDvUE59C/U19r0ASZmfPo+1pIPPPE8ka0cVJX
	OcYajPFaC8OcjTaD5OURqQRVSg7I2/yPC++da75/36LTifKkHQjL2hSQi6q8rGabA8FAsam6xocmd
	11Cf/J5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1soncn-00000009kTn-1hkJ;
	Thu, 12 Sep 2024 17:28:57 +0000
Date: Thu, 12 Sep 2024 18:28:57 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: kernel test robot <lkp@intel.com>,
	Christoph Lameter via B4 Relay <devnull+cl.gentwo.org@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Yang Shi <shy828301@gmail.com>,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: Re: [PATCH v2] SLUB: Add support for per object memory policies
Message-ID: <ZuMk2Yc7i-JMiHpA@casper.infradead.org>
References: <20240906-strict_numa-v2-1-f104e6de6d1e@gentwo.org>
 <202409080304.haF25cFZ-lkp@intel.com>
 <2011fcea-b4f3-a7ec-e747-6ee0195452e1@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2011fcea-b4f3-a7ec-e747-6ee0195452e1@gentwo.org>

On Thu, Sep 12, 2024 at 09:15:34AM -0700, Christoph Lameter (Ampere) wrote:
> > sparse warnings: (new ones prefixed by >>)
> > >> mm/slub.c:222:1: sparse: sparse: symbol 'strict_numa' was not declared. Should it be static?
> 
> 
> Ummm.. This code declares strict_numa. Whats wrong with sparc64 / sparse ?
> 
> > vim +/strict_numa +222 mm/slub.c
> >
> >    220
> >    221	#ifdef CONFIG_NUMA
> >  > 222	DEFINE_STATIC_KEY_FALSE(strict_numa);

maybe this should be:

static DEFINE_STATIC_KEY_FALSE(strict_numa);

if it's only used within mm/slub.c?  Or it needs to be declared in a
header file if it is used outside mm/slub.c.

> >    223	#endif
> >    224
> >
> 
> 

