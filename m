Return-Path: <linux-kernel+bounces-396370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC3B9BCC45
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3231F2221A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761C91D433C;
	Tue,  5 Nov 2024 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PRmP1Llc"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A321420A8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808109; cv=none; b=pemYut/WndVyXCc0pUz6O9htQDk0qOdPPzkalHagfn9f8sa+mXnWOVrR+YMTLvYuGA7lALnUzMGx+FQCXvV3+UEsXMnwVDPqZA0PAt1iHt0Vilcb2UDi/LtmJTenTO+d0K5eVf84Hve+u1qiNnDfobxVXJuoj2riSuKp9cGpL6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808109; c=relaxed/simple;
	bh=wc8L28J8ce+9ES6pYmXILBTcBDOi/xJ2iFmePZUWUqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbCYLpEoQK45vFYCKcAXyUyBsSafwBbMgtXZyu42B+uNx7Bi89h0krWhJKDQnDMm1Vh3bYciu54A0qXT65IThE+SDmTufWwUDlZjzfyKej3ZQ+UbPCQzWlAumQcsYXZR7TFOmOUS1UT5Y7zYlrcMEZGX8QqKRABZ8P0hJyp3U8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PRmP1Llc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ePK68Do9bSOsgDttsQBxob0Zqr35Orl6F6MvbMbi8IA=; b=PRmP1LlcZRJJ2VE6juGIkhmLNN
	OyGRLMYwByJt5QrgcSmzpbik+SVT7kd53zg84fLAOXvl5jTQ6sgzBp453SkoB8YrT8UXdt1Varl1q
	dv3lMa4qj2zhrUdhTlMFUxfKE6/q2F6D/GVM+tUBbguQjPFUCSjTgLBkhDIe4TP6j9D2LYcF4Ipy5
	fMV58clNilCDJrGYLiI/ZxkKRqOfIbahe+P9L8XTucOf7DZfNEjMKGrmZjEEOp3yP5uWITGmR//Js
	3bcKBQypoUCAwGAGrzFdJDq5IQir805RisiqV0uj+EADlOHRTyXfhjMqXamn896gMBh0LKDfWNsOB
	w5CFn7oQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8IFj-0000000BjrN-3kjB;
	Tue, 05 Nov 2024 12:01:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 85EA7300324; Tue,  5 Nov 2024 13:01:43 +0100 (CET)
Date: Tue, 5 Nov 2024 13:01:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: mingo@kernel.org, lucas.demarchi@intel.com,
	linux-kernel@vger.kernel.org, willy@infradead.org, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Subject: Re: [PATCH 03/19] perf: Fix perf_pmu_register() vs perf_init_event()
Message-ID: <20241105120143.GD10375@noisy.programming.kicks-ass.net>
References: <20241104133909.669111662@infradead.org>
 <20241104135517.858805880@infradead.org>
 <0dac9a18-e993-d60d-9b13-da2cd0c3bd4c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dac9a18-e993-d60d-9b13-da2cd0c3bd4c@gmail.com>

On Mon, Nov 04, 2024 at 04:36:26PM +0100, Uros Bizjak wrote:
> 
> 
> On 4. 11. 24 14:39, Peter Zijlstra wrote:
> > There is a fairly obvious race between perf_init_event() doing
> > idr_find() and perf_pmu_register() doing idr_alloc() with an
> > incompletely initialized pmu pointer.
> > 
> > Avoid by doing idr_alloc() on a NULL pointer to register the id, and
> > swizzling the real pmu pointer at the end using idr_replace().
> > 
> > Also making sure to not set pmu members after publishing the pmu, duh.
> > 
> > [ introduce idr_cmpxchg() in order to better handle the idr_replace()
> >    error case -- if it were to return an unexpected pointer, it will
> >    already have replaced the value and there is no going back. ]
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >   kernel/events/core.c |   28 ++++++++++++++++++++++++++--
> >   1 file changed, 26 insertions(+), 2 deletions(-)
> > 
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -11739,6 +11739,21 @@ static int pmu_dev_alloc(struct pmu *pmu
> >   static struct lock_class_key cpuctx_mutex;
> >   static struct lock_class_key cpuctx_lock;
> > +static bool idr_cmpxchg(struct idr *idr, unsigned long id, void *old, void *new)
> > +{
> > +	void *tmp, *val = idr_find(idr, id);
> > +
> > +	if (val != old)
> > +		return false;
> > +
> > +	tmp = idr_replace(idr, new, id);
> > +	if (IS_ERR(tmp))
> > +		return false;
> > +
> > +	WARN_ON_ONCE(tmp != val);
> > +	return true;
> > +}
> 
> Can the above function be named idr_try_cmpxchg?
> 
> cmpxchg family of functions return an old value from the location and one
> would expect that idr_cmpxchg() returns an old value from *idr, too.
> idr_cmpxchg() function however returns success/failure status, and this is
> also what functions from try_cmpxchg family return.

Fair enough -- OTOH, this function is very much not atomic. I considered
calling it idr_cas() as to distance itself from cmpxchg family.

Also, it is local to perf, and not placed in idr.h or similar.

While the usage here is somewhat spurious, it gets used later on in the
series to better effect.

