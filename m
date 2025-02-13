Return-Path: <linux-kernel+bounces-514089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D99A3523D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 00:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32E1188D5C7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DFC1C84C1;
	Thu, 13 Feb 2025 23:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DT6cQfZp"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11E01C84A8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 23:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739489758; cv=none; b=rgfV7FulrdHEeakNT4droBDnUDd0gDQ9sKWH6KjzTeQNR/Y+szgqaqd1dzdOEV5M5cLtf8MHi4cDPl5oAFhb8knnw5h/uLTw+QvA/MJ3dI+gVDOcN/u6EpQ2GA46D8cp8TCtlCVpLEDYe/JnJdAeOExE0ubhwJEWid2UPEAuNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739489758; c=relaxed/simple;
	bh=lOAcTjwhKqo1NsvJDmUerGIYldSDWzpeMraUf4/CtFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WD7W6nThRpYCieyTEUT1/97+HGILqv6UETa/B9yisxD8m9ku9DNPAv4LVRsn+VieVh+SU7QSv0ZC5VPID5oc7wBZlRYotwmt6HG3GDFl6a5UJn+uf0ox3NTmEGhBrYwsS6ub/vactbICwy9b2Q7/OuyMPddWRSsmxsL3eWN/5S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DT6cQfZp; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Feb 2025 23:35:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739489751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVVBeRB4R/p/jAbEkhJ7/AqaFgJout4r3zmt9lw3r2Q=;
	b=DT6cQfZpCOxdnphDHwOkRLYR+GDquD4//LAN2QijU/f4luFyUCS9hBZ7XUOa6Y0BBUQXG9
	zQnCdCUawiz8hC7O9ddgJRs6qQ4YI8ZuRzL9xrsbw7/BFNUUukZW+UBvjVxRtzk9cf35fN
	Anz7mQz2JMvVOqgazBimlflbLZUsst8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: gaoxu <gaoxu2@honor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Barry Song <21cnbao@gmail.com>, yipengxiang <yipengxiang@honor.com>,
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIG1t?= =?utf-8?Q?=3A?= Fix
 possible NULL pointer dereference in __swap_duplicate
Message-ID: <Z66B0T125JhdWo1n@google.com>
References: <44655569e3a1419f800952004f07e714@honor.com>
 <20250212161820.4fda79a3333d2345b60cef72@linux-foundation.org>
 <da7e1ee115454cf8898b4bbe228a5a9c@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da7e1ee115454cf8898b4bbe228a5a9c@honor.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 13, 2025 at 01:08:54PM +0000, gaoxu wrote:
> > 
> > On Wed, 12 Feb 2025 03:13:46 +0000 gaoxu <gaoxu2@honor.com> wrote:
> > 
> > > swp_swap_info() may return null; it is necessary to check the return
> > > value to avoid NULL pointer dereference. The code for other calls to
> > > swp_swap_info() includes checks, and __swap_duplicate() should also
> > > include checks.
> > 
> > Actually very few of the swp_swap_info() callers check for a NULL return.
> The swapfile.c file contains three instances where the return value of
> swp_swap_info() is checked for a NULL return. In other files that call
> swp_swap_info(), I have confirmed that there are no such checks.
> The description in the patch is inaccurate, and I have made modifications
> in patch v2.
> > 
> > > The reason why swp_swap_info() returns NULL is unclear; it may be due
> > > to CPU cache issues or DDR bit flips.
> > 
> > Quite possibly it's a kernel bug.
> > 
> > > The probability of this issue is very
> > > small, and the stack info we encountered is as follows：
> > > Unable to handle kernel NULL pointer dereference at virtual address
> > > 0000000000000058
> > >
> > > ...
> > >
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -3521,6 +3521,8 @@ static int __swap_duplicate(swp_entry_t entry,
> > unsigned char usage, int nr)
> > >  	int err, i;
> > >
> > >  	si = swp_swap_info(entry);
> > > +	if (unlikely(!si))
> > > +		return -EINVAL;
> > >
> > >  	offset = swp_offset(entry);
> > >  	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
> > 
> > OK, I guess avoiding the crash is good.  But please let's include a WARN so that
> > we can perhaps fix the bug, if one is there.
> Good. I'll change it as mentioned and send a new patch.
> 	si = swp_swap_info(entry);
> +	if (unlikely(!si)) {
> +		WARN(1, KERN_ERR "%s: %s%08lx\n", __func__, Bad_file, entry.val);

WARN() already contains unlikely(). Also, no need to print the function
name it's already in the stack trace.

We should probably just do if (WARN_ON_ONCE(!si)).

> +		return -EINVAL;
> +	}
> 
> 

