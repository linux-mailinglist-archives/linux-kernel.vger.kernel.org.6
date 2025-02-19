Return-Path: <linux-kernel+bounces-522295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C026A3C865
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F90188EA6A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F1422A7F5;
	Wed, 19 Feb 2025 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMum0BFx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2306A22A4FD;
	Wed, 19 Feb 2025 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992684; cv=none; b=qALLJBc5gi0oEbF2HNZyi2qYHSg9aV1igeQe0Ld2dRyvwHi+T1vPL29y3A+Y2E/ULeiXZ3KLmrVMeA7/yasXWOdN7d091dqbtdi/WWvd+tHNsHHcQ0apouUP36QIGMuT71d5aNc2YTe714O6GG4zQRyHVNUXWc9xkzIgmiob3fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992684; c=relaxed/simple;
	bh=0MemmKcTBENd14a7+6S0ivb7jyEiGpQEAwEyWfgUxWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYC/KgSbURJ1MCgtA7EGPyqZXiJC5FRDtOwEHpTSN6pjKURjIgGC9DmD0wW5icReDajNBeG3qZsTBtmJp1uX8vSXFdAGBHWmwZJKQ4qhr836YVugGZHrPVd17n+OMtwzXHArKmGISOd94UuJD/+H54RjB8H3Y5fFdEyBAoZuskU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMum0BFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E39C4CED1;
	Wed, 19 Feb 2025 19:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739992683;
	bh=0MemmKcTBENd14a7+6S0ivb7jyEiGpQEAwEyWfgUxWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eMum0BFxJGnwQw6eIMd04M8gYYTzGu0tWVcjb+rlAeZkb5gjl27+bn02ebtih5nyf
	 W9ARz6UxQjzyI61kDopRz44av1HyMr9TXPgCNWflnUy+q73EhfG13bmkneGGN6Hcpl
	 +8c2eDSsgNA5KNcBBMP6Ju3LHj9FJJpEnzLZToBvgq0xJT5XYZfRUugHDeR+BQJBoU
	 ZGtVLm89W4E12AzonctfZ2LxawS9fIlH5AWggdSW8EOgsIDoUnkdQabTl1eZ1XMxQ6
	 obFa1YH9z1m250pGIsZN/wX3Fyw83JXetBXmYjKUUNebfTLvZ741uNIj5ZM6jqldln
	 xxoKoTzNX35Lw==
Date: Wed, 19 Feb 2025 11:17:59 -0800
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <202502191117.8E1BCD4615@keescook>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <202502191026.8B6FD47A1@keescook>
 <20250219140821.27fa1e8a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219140821.27fa1e8a@gandalf.local.home>

On Wed, Feb 19, 2025 at 02:08:21PM -0500, Steven Rostedt wrote:
> On Wed, 19 Feb 2025 10:52:37 -0800
> Kees Cook <kees@kernel.org> wrote:
> 
> > In other words, I don't see any reason to focus on replacing existing
> > code -- doing so would actually carry a lot of risk. But writing *new*
> > stuff in Rust is very effective. Old code is more stable and has fewer
> > bugs already, and yet, we're still going to continue the work of hardening
> > C, because we still need to shake those bugs out. But *new* code can be
> > written in Rust, and not have any of these classes of bugs at all from
> > day one.
> 
> I would say *new drivers* than say *new code*. A lot of new code is written
> in existing infrastructure that doesn't mean it needs to be converted over
> to rust.

Sorry, yes, I was more accurate in the first paragraph. :)

> But that does show why enhancements to C like the guard() code is still
> very important.

Absolutely!

-- 
Kees Cook

