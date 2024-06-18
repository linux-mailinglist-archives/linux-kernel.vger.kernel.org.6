Return-Path: <linux-kernel+bounces-219579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089A190D4F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B011C22580
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8821AC420;
	Tue, 18 Jun 2024 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yMMC1mPN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E701AB902
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719369; cv=none; b=AOTLwjoIJyX0gcKLg66SF//YLHNSX88yFWmDoB8M3UNoNuWi0ruD/5JCrnctIA76jn+y8vTMlvoTZgcq/E1JO1PRCrC71CozjJCgLFJtSqTMJAgVJz2cpvPJNA1m+54lmAbAadxVI4fmCZfUzo2eUqXKFv6Ejw8hjX+c/iAJykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719369; c=relaxed/simple;
	bh=eNsCJ8JVGhBTv+KWQ98pN8GAIUBYwRuFOtbjtyFPDnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McrmLLa+yl+mgg/xZ9GG45j7+mKLsi1So8KfCwQKTj7QA14OlBcgxd9WaF+XRL0CcBXQYPNyGZ6C2+JPajuPJg/P6gCcS699tpmdw/1RK7xfRT771JbXw5+Cav6NEpog4nzQ7nq4PpdVkHQCTX+Rd4Tsg4PPEnHa1h1JKmqRZiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yMMC1mPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE067C3277B;
	Tue, 18 Jun 2024 14:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718719369;
	bh=eNsCJ8JVGhBTv+KWQ98pN8GAIUBYwRuFOtbjtyFPDnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yMMC1mPNdklSfXV9NuuoZh+5U6pD6RRk6XBdNOkHRw+v8uLWrFOosbX09VRdHtkV5
	 3jR5ZCG1VXydV2lfkHGgp++BXN9B3gHVHZuboVFD6IgnbF9lyexa17Iuo5DphOum+o
	 hdJV/9Got6NnAf8+VhTHange83hB6w4SyVReGOz8=
Date: Tue, 18 Jun 2024 16:02:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH 1/1] container_of: Document container_of_const() is
 preferred
Message-ID: <2024061808-crane-palm-29ea@gregkh>
References: <20240617100825.2510728-1-sakari.ailus@linux.intel.com>
 <2024061702-vexingly-hypocrisy-d93d@gregkh>
 <ZnFOrziVMDwtu1NA@kekkonen.localdomain>
 <2024061827-revival-handwrite-5eb0@gregkh>
 <ZnF06GjogseJut9q@kekkonen.localdomain>
 <2024061820-scrambled-playback-a73a@gregkh>
 <ZnGSAfh70wdFQE3x@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnGSAfh70wdFQE3x@casper.infradead.org>

On Tue, Jun 18, 2024 at 02:56:17PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 18, 2024 at 02:54:53PM +0200, Greg Kroah-Hartman wrote:
> > > I didn't have any issues (apart from me misspelling function names ;)) with
> > > GCC 12, neither in using container_of_const() in a static inline function
> > > nor in using a static inline function as a _Generic() expression.
> > 
> > Really?  And how do you handle the pointer being either const or not,
> > and propagating that back out as the return type?  I'd like to see your
> > inline function please.
> 
> Here's how I did it for page_folio():
> 
> #define page_folio(p)           (_Generic((p),                          \
>         const struct page *:    (const struct folio *)_compound_head(p), \
>         struct page *:          (struct folio *)_compound_head(p)))
> 
> Is there something differently magic about container_of() that prevents
> this trick from working?

That's a #define, not an inline function, which is what I thought we
were talking about.

thanks,

greg k-h

