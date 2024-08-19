Return-Path: <linux-kernel+bounces-293042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8432A95789F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED7E2845B3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8817D1E2100;
	Mon, 19 Aug 2024 23:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BDLcWASC"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179B01DD392
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724110164; cv=none; b=XSA1wMBIOCTcGYEkndXP430JfigFYnYACnDDXOaCjWPQJZPl5NtCvYeuj913WgExtzZBP8ax4wEGu9k1GiM++Q10tRI/jIVua2+NHLS+a3hPZIdbXd6bin5tVqlH1SOS3aE6+t1o0wFLLNduBYc5mLD/7Is7ZCR6HNX9+3KQtF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724110164; c=relaxed/simple;
	bh=ehS3W5Anq8T+k9VhYCmerd2UA39eahrRFFJh5celSG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDd7F79370096vaEn85ZRE3tfBg+05XwlkcN2bPuBGg44QBeruYluLNxq+4JXEBAA/Yn6ciFohtONHEFMI5YyPGy4Vhf7wZeO8GFN5HCdiLvrzGhUH0NjVQSX+S/l57GM9n3pd41JE+8tcPcMwlUOOf9e3NbQfWMkA6TW9Y0v1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BDLcWASC; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 19 Aug 2024 19:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724110161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3SRZ9gIrlzTqjNCQxFAiMxWIHnbIDWVrEQvz++bkefk=;
	b=BDLcWASCYQwEgC+ykz+8rwjp1z7YRf54B/OPWqvm+wr0bHjAksd4KYCfqFJMbIczmuBxKy
	UR3ArdKHUZiE13Sbt1xxoyhbreRH2hLOqA4QooW/nlIjgEoCdSJGKXgf00zVfRB41dxZ4/
	ANOo4q/MaChb3L6USk31cdvVCuyrZw4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] rcu_pending
Message-ID: <l4rk5pjlozhf6zhtmmrpigkyhjdnup66gxcmw4yj2dnxyu5o2e@wbgmmdravxut>
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
 <0e3c70d8-e2ac-4f71-b155-ef64e25fd415@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e3c70d8-e2ac-4f71-b155-ef64e25fd415@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 19, 2024 at 04:07:16PM GMT, Paul E. McKenney wrote:
> On Mon, Aug 19, 2024 at 12:59:26PM -0400, Kent Overstreet wrote:
> > New data structure for tracking objects waiting on an RCU grace period.
> > Supports regular RCU and SRCU, and possibly other RCU flavors in the
> > future. Uses radix trees for tracking pending objects, falling back to
> > linked lists on allocation failure.
> > 
> > This gets us a more general replacement for SLAB_TYPESAFE_BY_RCU, and a
> > cleaner and slightly faster backend for kvfree_call_rcu(), and
> > in the future a faster backend for call_rcu() as well.
> > 
> > There's still some small todo items, mentioned in the relevant patches.
> > 
> > Paul - I'm considering putting this into 6.11 for bcachefs (not the
> > patch that switches kvfree_rcu, of course), as I need it rather
> > pressingly. Thoughts? I can put it in fs/bcachefs/ if you hate it :)
> 
> I am having a hard time imagining it being ready for inclusion in
> kernel/rcu by the upcoming (v6.12) merge window, so if you need it then,
> you will need to pull it into fs/bcachefs.
> 
> Don't get me wrong, it has improved since the June version.  And we
> can always move it later, if/when appropriate.
> 
> And yes, the kvfree_rcu() changes would need some serious performance
> evaluation by the people who benefitted from the changes that make
> kvfree_rcu() what it is today.  So let's please defer that one.
> 
> Having the equivalent of SLAB_TYPESAFE_BY_SRCU could be attractive,
> but I suspect that there are smaller changes that get us that with the
> existing slab allocator.

I seriously doubt that - where are you going to stash the srcu_struct
pointer?

This is small and self contained, which is a _major_ win vs. dumping
more complex algorithmic stuff into slub.

