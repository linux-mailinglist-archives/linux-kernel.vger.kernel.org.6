Return-Path: <linux-kernel+bounces-398955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3279BF871
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34CD1F22FA0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AB120CCE6;
	Wed,  6 Nov 2024 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OfICV+9E"
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EEF13A26F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730928220; cv=none; b=EH/J5icD+JnLz6uyp7lPy1Yg58EmGLrspbpcM+35epdVzFTthrw4xzR/TthvXmm5uVwKgOSfdUc1vGAEKYInMqLV/5T7nXl2Iw94m79YhRD98Guk3D4RTDzcAX8uJyK02MPmgMvivROWTI6vOAwPah76oEtLP5JBTeRgKkHRp/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730928220; c=relaxed/simple;
	bh=eOg3UTpoMlNoZSpIq8wxKCC/tuOyRAlcg7MeJxRBCJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUzBjW20vEZKykKwBxWWaAwRciNpBq7jweW9sJhuq0LSvTOAKu7U1b4zJXSyumG+p6/bnmInVBOjwn6jwqgJRX6IB3bMcGvse6CQmiOHPEA8xQp6OPu7P+hrBRiDU+m3ahncQFf/zrGxFtrlUED9p9nyeKx3AGXNM6tHtMSGD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OfICV+9E; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15453 invoked by uid 109); 6 Nov 2024 21:23:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eOg3UTpoMlNoZSpIq8wxKCC/tuOyRAlcg7MeJxRBCJk=; b=OfICV+9Ejwif7uFCKFCTXV/oWMG9wlHkuoKroZ694GjDgvVm99gLCYfjobG2wnP1upRdSidXH2PXpEJOdjb51q6BzR5631GddBqEOOABMdSi8MyY7OZMMUKtUOVPIMwZhc8EoCuug0N3/7j9mdztnBmWkXmN0uYOzCVmgiTCMSdyeX1RqlVayKW8bEIPD7pqB39rjpPEQ9unauQk80jO93PgM/6i923tr1l1CQBZqWZHKzLOOaUnbnUffkvRvX/n/9q1Ushkg8lktyQ7zLVnfUccTOEMMd5EI6yh0h/Hks4rgPgz4zxuX12L9weMBGKJyr14D9E6G2+5kcpSGG4OGQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Nov 2024 21:23:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8243 invoked by uid 111); 6 Nov 2024 21:23:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Nov 2024 16:23:37 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Nov 2024 16:23:37 -0500
From: Jeff King <peff@peff.net>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] setlocalversion: work around "git describe" performance
Message-ID: <20241106212337.GA956489@coredump.intra.peff.net>
References: <20241106012838.435040-1-linux@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106012838.435040-1-linux@rasmusvillemoes.dk>

On Wed, Nov 06, 2024 at 02:28:38AM +0100, Rasmus Villemoes wrote:

> This has been acknowledged as a performance bug in git [1]. However,
> no solution is yet in git.git, and even when one lands, it will take
> quite a while before it finds its way to a release and for
> $random_kernel_developer to pick that up.

I just posted patches in:

  https://lore.kernel.org/git/20241106192236.GC880133@coredump.intra.peff.net/

but I agree it is worth dealing with in the interim. And also, I really
suspect that this new code may end up faster than git-describe in some
cases anyway.

> +try_tag() {
> +	tag="$1"
> +
> +	# Is $tag an annotated tag?
> +	[ "$(git cat-file -t "$tag" 2> /dev/null)" = "tag" ] || return 1
> +
> +	# Is it an ancestor of HEAD, and if so, how many commits are in $tag..HEAD?
> +	read left right <<EOF || return 1
> +$(git rev-list --count --left-right "$tag"...HEAD 2> /dev/null)
> +EOF
> +
> +	# $left is 0 if and only if $tag is an ancestor of HEAD
> +	[ "$left" -eq 0 ] || return 1
> +
> +	# $right is the number of commits in the range $tag..HEAD, possibly 0.
> +	count="$right"
> +
> +	return 0
> +}

The git parts all look good to me here (and not knowing much about the
kernel's scripts I'll refrain from even looking closely at the other
parts).

The use of the here-doc is a little funny, but I guess you can't just
pipe to read since that would put it in a subshell. But I do note that
your "|| return 1" won't catch a failure from "rev-list", if that was
the intent. I think you'd have to use a real tempfile to catch it, or
play horrid tricks with echoing $? into the "read" stream. I guess the
explicit check for "$left -eq 0" will catch most failures anyway.

If you use "<<-" you can get rid of the awkward indentation.

-Peff

