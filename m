Return-Path: <linux-kernel+bounces-332835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B86F97BF76
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B881F21F51
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9611C9DDD;
	Wed, 18 Sep 2024 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o5wvbk1e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97F1C8FD6;
	Wed, 18 Sep 2024 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726679367; cv=none; b=HZCdg/SOcJHc/qczCndzELFdWhWIZEERwInCdUULAOKimSxmoiwd75q2Pj9cDysgJXhKo+3xxJmyxUh+mHqODr+ZYU7Ai7LN0aX33uFl3c/CUX8vKF63GSzL5g1+dSjRqDrs6ku+dTtH0o6Gk5ikC840rd7zsesrG09/bbOBliA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726679367; c=relaxed/simple;
	bh=FjdzQixOrS4xco7SjipZFJ0Xmm9C+Bz6r1mwO7Pw+Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWIbNbjod4uMZHYsYKUsYZKKMS0ZzNc47qQf4ggF7MEgTT2rDrc1Nevx9wgzHrk/1hg36fjOCQeJEqBHLCDXPCnUgVGkz0ud/Z/3zSXFU+1T1iKPQwtpLaS8CED+O05ZAGiMuhtiI5QOqU0qyOFRs5Y1J8OQYTcqSEVyCL0qh50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o5wvbk1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474F1C4CEC6;
	Wed, 18 Sep 2024 17:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726679366;
	bh=FjdzQixOrS4xco7SjipZFJ0Xmm9C+Bz6r1mwO7Pw+Y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o5wvbk1e6XvoXZbaNeYLCwVF8Qvhzh9ijZpMWH+AZwcEQjZij5nPNvvzhwkMOps6O
	 GYz2q1lQ3VjgOnBXblrnX3k/FehTsRxafJw3DtNSZMwJpFpdvjlXzFrDaOnY0rE2dd
	 4x+Dhm8dUwaW5lF+MvCxiwZWZM6jVqE6WQt85ZHg=
Date: Wed, 18 Sep 2024 19:09:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: add untrusted data abstraction
Message-ID: <2024091858-surrender-broadcast-e11f@gregkh>
References: <20240913112643.542914-1-benno.lossin@proton.me>
 <20240913112643.542914-2-benno.lossin@proton.me>
 <ZuRbSxwlz1xWT1pG@phenom.ffwll.local>
 <cf0d6189-e81c-4b7c-ab50-7a297c69b132@proton.me>
 <ZuhTdwCqz61bQEgq@phenom.ffwll.local>
 <26534d80-989d-4b77-9720-84575275890f@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26534d80-989d-4b77-9720-84575275890f@proton.me>

On Wed, Sep 18, 2024 at 03:40:54PM +0000, Benno Lossin wrote:
> >> Yeah, we need more users of this to know the full way to express this
> >> correctly. I would like to avoid huge refactorings in the future.
> > 
> > I think adding it to the copy_*_user functions we already have in
> > upstream, and then asking Alice to rebase binder should be a really solid
> > real-world testcase. And I think currently for the things in-flight
> > copy*user is going to be the main source of untrusted data anyway, not so
> > much page cache folios.
> 
> Sure. I chose tarfs as the use-case, because Greg mentioned to me that
> it would benefit from adding this API. (I have no prior linux kernel
> experience, so you giving me some pointers where this will be useful is
> very helpful!)

I just had tarfs as an easy example where we were reading data off the
disk and acting on it, in a way just like C where if the data is
corrupted we can do "not normal" things.  Sorry it got tied up with
folios, that is not the normal way drivers work, they either get data
from userspace through a char device node (ioctls) or from hardware
(memory copies/reads/something) and for them the "untrusted data"
abstraction should be much simpler than dealing with a folio.

We don't really have any other good examples of drivers in rust yet that
I could find other than maybe binder, but Alice has already posted her
solution for how to handle untrusted data there (comes in through a char
device node and/or a filesystem entry point) but it's much more complex
and possibly harder to use as a simple example of the api ideas.

thanks,

greg k-h

