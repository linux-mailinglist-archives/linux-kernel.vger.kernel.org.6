Return-Path: <linux-kernel+bounces-411625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B04F9CFCF8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 08:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33D3DB24F35
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 07:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7693F190679;
	Sat, 16 Nov 2024 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YsP/MTnf"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE52A47
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 07:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731742090; cv=none; b=E5c+Vf2xStkBvdWZj7qlSypIWH4rrSSoCRUqjq3vBCtQxVIojugGYHCuMNpQpQBIj9h3B77c5GOUawDLhicPxEr4K4Xw85Ay6/9jH85nezyAoKF3QPevSDLSO5BIH4vjUGRqtG70MjxaWYADtGOREyRA6OnhoTlAVReZmo9zGKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731742090; c=relaxed/simple;
	bh=o5eWXWLYMpJTVKCjMfNv9TyGZuhPdYESoko1vSrdSD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPA9L7Qx1dZuxEx7tZptAqfCtbrN+sd4XO/7GZGyS9+NJa/JE+AENmV2qtuyOAc/29q7ygaHoKXGXQFHmXrhZkmSsHYn/gLllAktaRx0ITZh0Qpa32FWMs065oSu1bQifwxezOWc9DqaT42QxRYFItOEdPgNjC+w6cVWXIGwIyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YsP/MTnf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H05ZAiY6HhFByBzVLRVfFdXnaGbuqCYcXB8WifcKMko=; b=YsP/MTnfNLp1YKZ8qqFYI58tFk
	ERJCr/k60pg08zy0EhrlrmDVC1b0Qfue3tDP50xaFlVGLsjp09fisKzpfdXYPYdldI2Rp89WSDBYP
	PpD3jyvXkGccqnvRBAD28gPdYpO6TG6cuoDrbyO73ItDsn21cH9NPjjFqB9BuPU6+s81W7VYSy2+9
	APQIg7XFeZYbMO5Y6aDbi5S19e3CG3fPuvlrMeY2XCxVOe+sY5TxTX8PlDclri+gj9N8ANjWB1RVf
	ZRayxQiEI/Grr2NOdM8mK02deicZjGufZ4MaOBmOlysQaYTF8EBLuT3UvDp6SX6zUVvlkFZAIq0dU
	rGj+f9pQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tCDDw-0000000FhBO-3LfJ;
	Sat, 16 Nov 2024 07:28:04 +0000
Date: Sat, 16 Nov 2024 07:28:04 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Nir Lichtman <nir@lichtman.org>
Cc: ebiederm@xmission.com, kees@kernel.org, brauner@kernel.org,
	jack@suse.cz, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] exec: make printable macro more concise
Message-ID: <20241116072804.GA3387508@ZenIV>
References: <20241116061258.GA216473@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116061258.GA216473@lichtman.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 16, 2024 at 06:12:58AM +0000, Nir Lichtman wrote:

> -#define printable(c) (((c)=='\t') || ((c)=='\n') || (0x20<=(c) && (c)<=0x7e))
> +#define printable(c) (isprint(c) || isspace(c))

cat >a.c <<'EOF'
#include <ctype.h>
#include <stdio.h>

#define printable(c) (((c)=='\t') || ((c)=='\n') || (0x20<=(c) && (c)<=0x7e))

int main()
{
        for (int i = 0; i < 255; i++)
		if (printable(i) != (isspace(i) || isprint(i)))
			printf("%02x\n", i);
	return 0;
}
EOF
cc a.c
LANG=C ./a.out

and watch the output.  Now, whether that logics makes sense is a separate story;
that's before my time (1.3.60), so...

AFAICS, it's a filter for autoloading a binfmt module by way of an alias;
we do _not_ want to step on a random text file (back then #! had been
handled directly, prior to that area; by the time when it was made a module,
everyone probably forgot about the entire mess - that was in 2013).

So it picked the 3rd and 4th bytes of the binary and tries to modprobe
binfmt-<number>.  Ho-hum...  AFAICS, there hadn't been such aliases
in any binfmt module back then (or now, for that matter), so it would
have to come from userland config...

OK, 1.3.61 is when fs/binfmt_aout.c got separated from fs/exec.c and became
modular, so that's almost certainly what it had been about.  Setups with
modular aout support wanting to autoload it when finally hitting an
aout binary...

These days aout support is gone.  And while that stuff might have been
useful once upon a time (e.g. for binfmt_java, back when it existed),
but these days anything of that sort would be handled by binfmt_misc-based
setups.

ISTR seeing a bunch of stale binfmt_aout aliases of that form way back,
but e.g. Debian had gotten rid of those quite a while ago...

<after a bit more software coproarchaeology>
Looks like module-init-tools used to put (completely useless by that time,
due to the printf format change from %hd to %04x) aliases for binfmt_aout
into /etc/modprobe.d/aliases.conf:
	alias binfmt-204 binfmt_aout
	alias binfmt-263 binfmt_aout
	alias binfmt-264 binfmt_aout
	alias binfmt-267 binfmt_aout
	alias binfmt-387 binfmt_aout
until 2011, when it had been put out of its misery.

Anyway, looks like nothing had been using that other than for aout,
aout32 and java.  All of those are gone, so... is there any point
keeping that crap around?

Linus, could we simply bury that request_module("binfmt-%04x",...) in
search_binary_handler(), along with 'retry' logics in there?  What
could possibly use it?

