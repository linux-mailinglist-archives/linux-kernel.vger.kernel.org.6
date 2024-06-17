Return-Path: <linux-kernel+bounces-217104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1151390AA9C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFB3282972
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB025193077;
	Mon, 17 Jun 2024 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQZ6um2B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A95819047F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618595; cv=none; b=uXR9cj/HrWWXVMDVOb9Bh4n0WZHome4EVSljte/SXROQuwjrDsLvp/PBeV1rOmQ04YY4lmRowJmj1V9EnHhW2XzHRF0TBio0KycEJRf/W3B1tGv2ykRJegvTQUr56T8uwEhFyd1FyQOtHBe33g5GQUi3bxEYLwYXmZC/7XoICds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618595; c=relaxed/simple;
	bh=L5aKYq+K9LHs7OusAkwM8HVmwDPeNKVqgx5oq7ZSd/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXChRDN+8eZ6LA6FtIMSZ5i+BThhYAyVOz0XHdS6rl6isy4Qu4/h0gTHccJ32YS+pSJu/b//TRc0I02fJu6hVWkxgCv5n/5kOZUcLpJWOJGtRCpCAxee6NReVqPzJVmqul6l7sAtPRFbviKySqfY5qmLtgLtOVIgcu0khvhGPeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQZ6um2B; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718618593; x=1750154593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=L5aKYq+K9LHs7OusAkwM8HVmwDPeNKVqgx5oq7ZSd/E=;
  b=JQZ6um2Bhuhwabez/q/5ByvcGeDh0xQDwlXmbRv62BMb9123t+2n79cx
   dMtJ0HOTrdfVUnY/2Ed4p4+6dbXNTDUFqSsMoLdDmR7peYlBW/KGMLxMx
   UN6RxNgWKSOYzUZJFQD0KLSU5xYifK1dHOxi6qWmJWhCYw5wtzHMmQbFo
   StULRTV//NIZVZv9yURqqbSoAbYjCoSxF70jZcJSo1S1ZgD441vZx3NIT
   LZvK43C1vp5P/gQKyqnjfw0bYrJ/t6V4IEzmQLjoUMRMLD4QCUe9/cJa9
   mou6kiKATMWbNa72eKpEGzZSk7flvTloesE4xlDG1HMaRTC/Ht/skE4n9
   g==;
X-CSE-ConnectionGUID: a36284zdRoK4zRBUoEnLwQ==
X-CSE-MsgGUID: jKkbXvvXRkSUOjE78hfV0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="19223103"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="19223103"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 03:03:12 -0700
X-CSE-ConnectionGUID: H1Q/QF7GTbuFCkwxgUDDKg==
X-CSE-MsgGUID: jFDmWRUPSL+d49XjExrCZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41249743"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 17 Jun 2024 03:03:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 1A1AB18E; Mon, 17 Jun 2024 13:03:10 +0300 (EEST)
Date: Mon, 17 Jun 2024 13:03:10 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"lirongqing@baidu.com" <lirongqing@baidu.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH][v2] virt: tdx-guest: Don't free decrypted memory
Message-ID: <yfoowboa5qwcjkmjggfjx4hm2emhhlwvao3s5rync5anoiyuba@4ezmhhlnb3j7>
References: <20240614051452.14548-1-lirongqing@baidu.com>
 <c209517e42fa83cbc3f030293f89813a6c1cfce1.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c209517e42fa83cbc3f030293f89813a6c1cfce1.camel@intel.com>

On Fri, Jun 14, 2024 at 04:13:46PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2024-06-14 at 13:14 +0800, Li RongQing wrote:
> > In CoCo VMs it is possible for the untrusted host to cause
> > set_memory_decrypted() to fail such that an error is returned
> > and the resulting memory is shared. Callers need to take care
> > to handle these errors to avoid returning decrypted (shared)
> > memory to the page allocator, which could lead to functional
> > or security issues.
> > 
> > So when set_memory_decrypted fails, leak decrypted memory, and
> > print an error message
> > 
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > ---
> > diff with v1: leak the page, and print error
> > 
> >  drivers/virt/coco/tdx-guest/tdx-guest.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-
> > guest/tdx-guest.c
> > index 1253bf7..3a6e76c8 100644
> > --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> > +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> > @@ -125,7 +125,7 @@ static void *alloc_quote_buf(void)
> >                 return NULL;
> >  
> >         if (set_memory_decrypted((unsigned long)addr, count)) {
> > -               free_pages_exact(addr, len);
> > +               pr_err("Failed to set Quote buffer decrypted, leak the
> > buffer\n");
> >                 return NULL;
> >         }
> 
> I'm not sure we need the error message, because the set_memory() failure we are
> most worried about already has a WARN.

Yeah, I think we should just remove the pr_err(). It will be shadowed by
the stack trace and WARN() anyway.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

