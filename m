Return-Path: <linux-kernel+bounces-446097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0814E9F1FD9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18CD11662E9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 16:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57731991C1;
	Sat, 14 Dec 2024 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IGfeNfO/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6CC522F;
	Sat, 14 Dec 2024 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734192218; cv=none; b=Egjuoxldot7Qf5a6XJo7Y20fW19kwnc2oR3NPZrn0P5AmjwGz3/9PQQ9wHMlQFRgiZWyBKsyNsLuDAcoRV1V4VLCNIRTODOyZJi4Gm7IN8F9UIPp7PcG3ap4MWz1qIsOVAzCSGFwx/re4z0Tbkv/hRpUFqwdAKrjFyjNN0+UuZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734192218; c=relaxed/simple;
	bh=xxXLyGOyZnGpaJ4mvshI9zCtsAP5miyU2OJKnkGTl/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8hmUvctRZu0W64PEFItcdE2RNphsVfVw6IgsCnPmpOImW7QvEm9t/FZIxU1xriGqnXwLrfKGHK26LvpSPTmQlgWQrfSaFBZLgIQGGDto+n1dMETeJ556lZF9cK1CF0hv7yimcZeVS+UG0nlZwIMkgiscOGTKbyp7OyiuByJqxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IGfeNfO/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T1A5Dyhd0EpXiTSnjGvcbnHEdmDZiOrAmCbzr/JLCnI=; b=IGfeNfO/3qoDbUQQYKjPvkjxLU
	1yHvQ52/YlqK1M5KJVUSL4qFTXj5/vO8qtpBp2QYTwrXPAeysrDYW9U8EWVyHSyivZgyDFgSm06V8
	C7vnSyKZjmALsfLPoQXvJFtlFnpPzRJApwvEQgdTdwgRS/7ChtNju5ZKY2p6Si9WoCzNckrmgMMIu
	XHAxY11W2HVz7w1zKsTf0+nPG1JZAk5Hm73ZC/+DpspbJ+218n54P+Y/73EwnHPlfNsPuipGne/BE
	79uyK9UtnDr4fyzJglMmXW2AYb0EefKCd5yniukpxZgNPL68r2FQw8lQb+cq2+BLxQU7bn6HTw1C4
	C24vAs0w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMUbx-00000003cyB-3EVu;
	Sat, 14 Dec 2024 16:03:21 +0000
Date: Sat, 14 Dec 2024 16:03:21 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Andy Whitcroft <apw@canonical.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@corigine.com>,
	Simon Horman <horms@kernel.org>, Conor Dooley <conor@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Increase minimum git commit ID abbreviation to 16
 characters
Message-ID: <Z12sScjRHpB1d0nO@casper.infradead.org>
References: <cover.1733421037.git.geert+renesas@glider.be>
 <46b320b91b8d86fade3c1b1c72ef94da85b45d0d.1733421037.git.geert+renesas@glider.be>
 <CAHk-=wiwAz3UgPOWK3RdGXDnTRHcwVbxpuxCQt_0SoAJC-oGXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiwAz3UgPOWK3RdGXDnTRHcwVbxpuxCQt_0SoAJC-oGXQ@mail.gmail.com>

On Thu, Dec 05, 2024 at 11:19:18AM -0800, Linus Torvalds wrote:
> Why do I care? Because long git commit IDs are actually detrimental to
> legibility. I try to make commit messages legible, and that very much
> is the *point* of the short format. It's for people, not machinery.
> 
> Yes, the basic git machinery doesn't do object type disambiguation
> (and if you do "git show", you can give it blob IDs etc, so git itself
> may not know about the proper type to use disambiguate at all). And
> git also doesn't know about the whole "we also put the first line of
> the commit message" thing.
> 
> But honestly, I'm claiming that something like
> 
>     Fixes: 48bcda684823 ("tracing: Remove definition of trace_*_rcuidle()")

I have wondered about using a different encoding for the sha1.
Classic Ascii85 encoding is no good; it uses characters like '"\<
which interact poorly with every shell.  RFC1924 is somewhat better,
but still uses characters that interact poorly with shell.

Base36 (ie 0-9a-z) would take 10 characters to represent as many bits
as 12 characters in base16.  Base62 (0-9a-zA-Z) gives us 8 characters
to represent _almost_ 48 bits.  We could do Base64 (RFC 4648) which
uses + and /, and is common enough.  Good enough to be worth the
additional complexity?


