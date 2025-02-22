Return-Path: <linux-kernel+bounces-527297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 621C4A4094E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 433037AB38D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6AC1D5AA7;
	Sat, 22 Feb 2025 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dDneDw4O"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB8019D084
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740236630; cv=none; b=qRWkv7wGaVQ5WgGB1SUT3+zQksft5/arlekHw2EQGQWnV6s2ynYUlzzPZs7BJV2CDyFrpHFBzwxmHOpLpiBseFmaRiiOvUx0ZXd/TDgMyjU6LRsM1Ogs81yOathuhmFrlkXY8E6/3ax5cQ8bwmywCPjOstyeVOzfsFK59FXH4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740236630; c=relaxed/simple;
	bh=kPNPLou+FgmzvO1cy0TDusxy2DcTdZeiwQPQcVKNWQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tP9EqYoOCCCibnuO0eY5VTZxfQiqU7j8C+gn2e+3OmZOcFio3iCseJaeeIeyPW+06QKPd32lrrVVeTkW346sWpvzznMf4ufzTz6iqY5Z3VjpnJrT4IFcT7O0rhWBM/7MA/DfhMrhYSbNou1+5kpx2YH/Hq3gI+v+0wL0GxXmhjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dDneDw4O; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 22 Feb 2025 10:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740236625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n2fx+V6MOFz4dl61jiVYfggTt1KOJsIBw37HV+8BuLk=;
	b=dDneDw4OLoPce16o1fWZ6PzClFRUnwADAvcfy9fvSbp+DD4HHKyPT1svcYNWWzTU4jO5Nr
	sI7S5hTinnI0qMRTASqeN6B91XCzOYYlclEdz2xSrSgo+8v6eSQLEZHmJvLiNAmi+NFDKi
	xnxTLR6OvmHX5Y/Q/KN2Xkht2zxt2wI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Christoph Hellwig <hch@infradead.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg KH <gregkh@linuxfoundation.org>, David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, 
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <2cbxfvvsau5sobm3zo5ds7u26jeiskxs6cavp5a7hbokjisobi@2ybqbl6iry6k>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
 <b0a8ee53b767b7684de91eeb6924ecdf5929d31e.camel@HansenPartnership.com>
 <CANiq72nnnOsGZDrPDm8iWxYn2FL=wJqx-P8aS63dFYez3_FEOg@mail.gmail.com>
 <a627845f73f2f7bedc7a820cfdf476be9993e30f.camel@HansenPartnership.com>
 <CANiq72m5KB-X1zck1E43yffXOTeD4xRmZgDx_oUiNwR941ce0w@mail.gmail.com>
 <20250219170623.GB1789203@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219170623.GB1789203@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 19, 2025 at 12:06:23PM -0500, Theodore Ts'o wrote:
> On Wed, Feb 19, 2025 at 05:44:16PM +0100, Miguel Ojeda wrote:
> > Hmm... I am not sure exactly what you mean here. Are you referring to
> > Wedson's FS slides from LSF/MM/BPF? i.e are you referring to Rust
> > signatures?
> > 
> > If yes, those signatures are manually written, they are not the
> > generated bindings. We typically refer to those as "abstractions", to
> > differentiate from the generated stuff.
> 
> The problem with the bindings in Wedson's FS slides is that it's
> really unreasonable to expect C programmers to understand them.  In my
> opinion, it was not necessarily a wise decision to use bindings as
> hyper-complex as a way to convince C developers that Rust was a net
> good thing.

You keep talking about how the problem was Wedson's talk, but really the
problem was you derailing because you were freaking out over something
you didn't understand.

The example was fine. It wasn't overly complicated.

You've been an engineer for decades, taking in and digesting new
information about complex systems is something we have to do on a
regular basis. A little new syntax shouldn't be giving you that much
trouble; come on.

> I do understand (now) what Wedson was trying to do, was to show off
> how expressive and powerful Rust can be, even in the face of a fairly
> complex interface.  It turns out there were some good reasons for why
> the VFS handles inode creation, but in general, I'd encourage us to
> consider whether there are ways to change the abstractions on the C
> side so that:

It wasn't a "gentle introduction to Rust" talk. You can get that
anywhere.

It was a talk _specific to the VFS_, so "how does Rust cope with core
VFS interfaces" was precisely the point of the talk.

If you wanted to take up that much time in our presentation, you
should've prepared a bit better by aquiring at least a bit of
familiarity with Rust syntax beforehand. You shouldn't need to be
spoonefed, the rest of us have done that on our own time.

Just please try to have some etiquette.

