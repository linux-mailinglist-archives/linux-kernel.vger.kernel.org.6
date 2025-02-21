Return-Path: <linux-kernel+bounces-525866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAD1A3F691
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820A6865976
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CE520E6E8;
	Fri, 21 Feb 2025 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DwI9jBqI"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6D20E320;
	Fri, 21 Feb 2025 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145961; cv=none; b=K2Lc4NJPqeO3Q7mpadgRu5wyEruSWIvfd7oM5sDJ9tVwvt7+L1AmqGFl7pEspMVKl1PFV6T3pEz/PPbV/WixJmE8KHQ7Sw3rYJJLXCdritxKIDTxSWMrhipdpORpzDIFuqYxkMZ0Hpnp5SKgbeEfabSMLLQo91s4vWczb7XeShs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145961; c=relaxed/simple;
	bh=9fP5/4Wv2mSWaArYXbd4ve+tctK0xVEfSpeCR2ix0D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4MITrJbrlSJIyUTkS82tPPj0/ew8b4Ez80HEvi8hHoSyw1AgF2DU8yPMuv+P98Zbz48LVGzszAMmX/PB1LGbx38doleLvacwSCylW9QiO4CSsqZNH69EdQAHHuIH8lpOkDP1d2cAL6uxZL2pVxOMmp7CrcgQxIyltQAKDvIwRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DwI9jBqI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SouJOz6R0+/LwOyZ8gKvoMSAtb+5pjH+kBne8Ec6EuY=; b=DwI9jBqIxvPf8+8RJxXBJAJkPu
	unguevvrJnIPDyTaBTTclTzrIfO/w1wt0vHMw0L5bpA4bE27s6VY/gxGgLnfo8a3PRxNDtn8H26c9
	TWNLyVnwx2EM3Dk2Ko120ccc4bsxczaxl8zM//CGbqMwj8nQpnFrozNjg7A2CmrE/iCkuwG61dVRi
	rd+IbjrNUhxWySQRcCisY3FFLLv0GFA8x+b4qvjUY79RiUG3Jiuxo9yHmk+hXgVzd5a+7HzUTgQdx
	u8J1VTkm2KOFjtDWu1NfE7Fe1z6/OSjX2IXvwpHmdXDKXkXLh+Vg/8mk3EDkSCQH3mVgqdi2FRt9V
	pWVrEFrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlTSA-0000000Dtpg-3mgR;
	Fri, 21 Feb 2025 13:52:30 +0000
Date: Fri, 21 Feb 2025 13:52:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: thomas.prescher@cyberus-technology.de
Cc: Jonathan Corbet <corbet@lwn.net>, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm: hugetlb: add hugetlb_alloc_threads cmdline option
Message-ID: <Z7iFHkybeT4v8Jbo@casper.infradead.org>
References: <20250221-hugepage-parameter-v1-0-fa49a77c87c8@cyberus-technology.de>
 <20250221-hugepage-parameter-v1-1-fa49a77c87c8@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-hugepage-parameter-v1-1-fa49a77c87c8@cyberus-technology.de>

On Fri, Feb 21, 2025 at 02:49:03PM +0100, Thomas Prescher via B4 Relay wrote:
> Add a command line option that enables control of how many
> threads per NUMA node should be used to allocate huge pages.

I don't think we should add a command line option (ie blame the sysadmin
for getting it wrong).  Instead, we should figure out the right number.
Is it half the number of threads per socket?  A quarter?  90%?  It's
bootup, the threads aren't really doing anything else.  But we
should figure it out, not the sysadmin.

