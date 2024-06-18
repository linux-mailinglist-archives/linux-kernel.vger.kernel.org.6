Return-Path: <linux-kernel+bounces-219171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCD790CAD5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730B2291837
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D29A13D281;
	Tue, 18 Jun 2024 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6+qWmnw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D244613D513
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711535; cv=none; b=SQBGnMkdPE02ru1HKXpm5A1eAUwTytbdIqdGlPtU7/9uVEvJTdfkBQCZB1deAFRQgjpkq53wSlTH/8HOtIoK6QNXq3wQMr0eUVlbafllx7YLTu2tHZNC5XLW08Qz5DciZkcWeaMlCso0zJuJZuS5FXCedt8oqga+S4uBxW/7QZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711535; c=relaxed/simple;
	bh=OVuqINv5gFU6pixnH7ubEbf3PqOhtwcecn63nS9HWTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKQ4aWdOXKzHrXhf+K3uZfyqAxVX6CIrPZOpWt154P+Sbc+iuYNfvdsUUNddZLkRkVAcVSVL7yFbe1tHcamg61bFrMTol8sggAA5EwBHr4QUMHt9+nJWuJeD9OpTHGvZRWoekH4JkpwwatsAm4uF9UIRx2sXkVysQMGyKADljsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6+qWmnw; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718711533; x=1750247533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OVuqINv5gFU6pixnH7ubEbf3PqOhtwcecn63nS9HWTs=;
  b=m6+qWmnwSGlcMn33CU0489jeK4yYq4PQNA/YD0VF97AsQ2py3m2pM2MM
   iprL4XCiLmAyqYeC58PSOw3OHpkfgFwIEGVTEXZZOEf4k+1aC/Ra53KwV
   ntml+IX4r+rSKWTm3Ad5cQvvITxZezFmj1cjQ6XI7N+eQAV45I8lGZCQP
   Wm0X8/EETwAvCKDq5xy3YfztpGOskmDaavEpKC/wuKaFtvUuJWYD52nae
   n3wC9AFZMgHsOPR/2sbmkLZpzuIUG9Ffxy6nr8lFQpnabfdxY7D0gJZHz
   vn0rKlUDSqPekTamvGGWf4liu0khXQVEwPT6MfhuBbLPgKf/BjQyeVGL2
   w==;
X-CSE-ConnectionGUID: EHOpg9+FRZWi/EC9lrRkxQ==
X-CSE-MsgGUID: m5khjJLWS0O49EgoV88NNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="19444379"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="19444379"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 04:52:13 -0700
X-CSE-ConnectionGUID: vn6w0t7mT4CHxUN3tBVGtg==
X-CSE-MsgGUID: MGWREoeOR+GYUIuWVs+2Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41624185"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 04:52:11 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7690111F7E1;
	Tue, 18 Jun 2024 14:52:08 +0300 (EEST)
Date: Tue, 18 Jun 2024 11:52:08 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH 1/1] container_of: Document container_of_const() is
 preferred
Message-ID: <ZnF06GjogseJut9q@kekkonen.localdomain>
References: <20240617100825.2510728-1-sakari.ailus@linux.intel.com>
 <2024061702-vexingly-hypocrisy-d93d@gregkh>
 <ZnFOrziVMDwtu1NA@kekkonen.localdomain>
 <2024061827-revival-handwrite-5eb0@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061827-revival-handwrite-5eb0@gregkh>

Hi Greg,

On Tue, Jun 18, 2024 at 12:01:30PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 18, 2024 at 09:09:03AM +0000, Sakari Ailus wrote:
> > Hi Greg,
> > 
> > On Mon, Jun 17, 2024 at 12:44:55PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Jun 17, 2024 at 01:08:25PM +0300, Sakari Ailus wrote:
> > > > There is a warning in kerneldoc documentation of container_of() that
> > > > constness of @ptr is lost. While this is a suggestion container_of_const()
> > > > should be used instead, the vast majority of new code still uses
> > > > container_of():
> > > > 
> > > > $ git diff v6.8 v6.9|grep container_of\(|wc -l
> > > > 788
> > > > $ git diff v6.8 v6.9|grep container_of_const|wc -l
> > > > 11
> > > 
> > > That is because container_of_const is new, and you don't normally go
> > > back and change things unless you have to.  Which is what I am starting
> > > to do for some cases now in the driver core interactions, but generally
> > > it's rare to need this.
> > 
> > container_of_const() does provide a useful a useful sanity check and I
> > think we should encourage people to use it. I'm happy to see many macros
> > under include/ use container_of_const() already, but there seem to be more
> > than 1000 cases where the constness qualifier of a pointer is just
> > discarded just in the scope that got compiled with my current .config (not
> > allyesconfig). While the vast majority are probably benign, I wouldn't be
> > certain there aren't cases where the container of a const pointer ends up
> > being modified.
> > 
> > > 
> > > Also note that container_of_const does not work in an inline function,
> > > which is another reason people might not want to use it.
> > 
> > Does not work or is less useful (compared to a macro)? _Generic() would
> > need to be used if you'd like to have const and non-const variants of an
> > inline function but I guess in most cases macros are just fine.
> 
> I could not figure out a way to make this an inline function at all.
> Try it yourself and see, maybe I was wrong.

I didn't have any issues (apart from me misspelling function names ;)) with
GCC 12, neither in using container_of_const() in a static inline function
nor in using a static inline function as a _Generic() expression.

If other compilers have issues we can update the documentation I guess? Or
only make the check on compilers that properly support it? Or in the best
case, fix those compilers. This does tend to take a long time though.

> 
> > > > Make an explicit recommendation to use container_of_const(), unless @ptr
> > > > is const but its container isn't.
> > > > 
> > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > ---
> > > >  include/linux/container_of.h | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> > > > index 713890c867be..7563015ff165 100644
> > > > --- a/include/linux/container_of.h
> > > > +++ b/include/linux/container_of.h
> > > > @@ -13,7 +13,9 @@
> > > >   * @type:	the type of the container struct this is embedded in.
> > > >   * @member:	the name of the member within the struct.
> > > >   *
> > > > - * WARNING: any const qualifier of @ptr is lost.
> > > > + * WARNING: any const qualifier of @ptr is lost. container_of() should only be
> > > > + * used in cases where @ptr is const and its container is not and you know what
> > > > + * you're doing. Otherwise always use container_of_const().
> > > 
> > > I know of no cases where a @ptr would be const yet the container would
> > > not be, do you?  So why say that here?  That implies that it is a valid
> > > thing to actually do.
> > > 
> > > I don't understand the goal here, do you want to just not have new
> > > usages use container_of() at all?  Or are you trying to warn people of a
> > > common problem that they make?  Having a const @ptr is not normal in the
> > > kernel, so this should be ok.  If not, send patches to fix up those
> > > users please.
> > 
> > My immediate goal is to encourage people to use container_of_const() for
> > the added sanity check and stop adding technical debt (code that ignores
> > const qualifier). Currently people also do think they should be using
> > container_of() instead of container_of_const() because the pointer they
> > have is not const (at the time of writing the code at least).
> 
> That's fine, so for new things, use container_of_const(), but generally
> the need for a const is quite rare, outside of the driver core
> interactions.

Right, but I'm also looking to avoid drivers doing this inadvertly. Those
instances are just as much a blocker for turning container_of() const-aware
as anything else.

> 
> > Eventually (or hopefully?) adding that sanity check for container_of() may
> > be possible so we'd again have just one macro for the job.
> 
> That would be nice, try doing that and see what blows up.

Currently a lot of things but it can be done gradually, one instance at a
time.

How changing the container_of() documentation to this:

 * WARNING: any const qualifier of @ptr is lost. Use container_of_const()
 * instead.

-- 
Kind regards,

Sakari Ailus

