Return-Path: <linux-kernel+bounces-170352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9399A8BD58B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F67F283CC2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CD515ADA1;
	Mon,  6 May 2024 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="NF5FoZQV"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506995FDA5
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024565; cv=none; b=IRkjqEIVuTScxDXwVYrzthGiNKbE6NKoeUOo/qw3pL8qUmsbYZiMj77+HkQoElRv0MdFooYhD9EYPKKfUAdUFiHC87GGj3c8bLtPG3ZluKsk9uOex9qkpxmYiABIGHf7TH+JJFQMW2IULUOa+Md5EOo515pl2yh92jl4QxspB7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024565; c=relaxed/simple;
	bh=tQoz9dS6MzicSe5+SQbJSgBGuPARlB9lb/KxszWyE/U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f+96BeeIBUgpKST1obUDlicB6wxcmBTquBtWL3m9xmDZ8G4Qm81MhtDLl0SSSRAYqwchO2UlWCHoiBKot6J2hIu14SS/JkAPgu3v+UpD4acOQGWqSxmVHIts0hqPTBTCB/pxbFEDxsrQqdflb2FNdr2v3gI1dZUBa9F2QG9EaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=NF5FoZQV; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=y4WGMO9bryRqHzdvXqX8JHN1xbU3NgS8boIGtDt6Syk=;
  b=NF5FoZQVHSBu6L3rCTziShyF9iRcUDtTfIWq+LXu/shPNICSD5DSS5yn
   pTYwl7j9gea38muYWE0OsMjL9UjQUT4g+OsU/4yuY4hWSK9lQoeSCRW+y
   cp9zMvgA+IUXB5jvVA7Wiv0rTvpYv2sRPoThdddqav5LEcU/+MTDj+AIj
   0=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,259,1708383600"; 
   d="scan'208";a="86505903"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 21:42:34 +0200
Date: Mon, 6 May 2024 21:42:33 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Lukas Wunner <lukas@wunner.de>
cc: Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
Subject: Re: coccinelle matching of identifiers
In-Reply-To: <ZjkZBvuXlZAodPAU@wunner.de>
Message-ID: <alpine.DEB.2.22.394.2405062136410.3284@hadrien>
References: <ZjkZBvuXlZAodPAU@wunner.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 6 May 2024, Lukas Wunner wrote:

> Dear coccinelle maintainers,
>
> Linux kernel commit 5c6ca9d93665 ("X.509: Introduce scope-based
> x509_certificate allocation"), which is queued for v6.10 in this repo ...
>
>     https://git.kernel.org/herbert/cryptodev-2.6/c/5c6ca9d93665
>
> ... triggers scripts/coccinelle/null/eno.cocci:
>
>     ./crypto/asymmetric_keys/x509_cert_parser.c:69:9-15: ERROR: allocation function on line 68 returns NULL not ERR_PTR on failure
>     ./fs/gfs2/inode.c:1850:6-12: ERROR: allocation function on line 1842 returns NULL not ERR_PTR on failure
>     ./fs/smb/client/cifsfs.c:1186:6-12: ERROR: allocation function on line 1173 returns NULL not ERR_PTR on failure
>
> The first of these three errors is newly introduced by the above-linked
> commit, the other two already existed before.  All are false-positives.
>
> I would like to silence the newly-introduced false-positive and have
> attempted to do so using the small patch below.
>
> However the result is that *only* the newly-introduced false-positive is
> found and the other two are no longer found.  So the other way round than
> what I'm aiming for.
>
> I find this bewildering.  What am I doing wrong?
>
> FWIW, coccinelle version is 1.1.1.
>
> The newly introduced false-positive is triggered by the statement:
>
>     assume(!IS_ERR(cert));
>
> Which is a macro that expands to:
>
>     do { if (!!IS_ERR(cert)) __builtin_unreachable(); } while(0);
>
> The macro gives the compiler a hint that variable "cert" is not an error
> pointer, which prevents the compiler from adding an unnecessary check
> for that condition.
>
> Thanks!
>
> Lukas
>
> -- >8 --
>
> diff --git a/scripts/coccinelle/null/eno.cocci b/scripts/coccinelle/null/eno.cocci
> index 7107d6c8db9e..79112d51bee8 100644
> --- a/scripts/coccinelle/null/eno.cocci
> +++ b/scripts/coccinelle/null/eno.cocci
> @@ -26,10 +26,12 @@ x = \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|kmem_cache
>  @r depends on !patch exists@
>  expression x,E;
>  position p1,p2;
> +identifier assume;
>  @@
>
>  *x = \(kmalloc@p1\|kzalloc@p1\|kcalloc@p1\|kmem_cache_alloc@p1\|kmem_cache_zalloc@p1\|kmem_cache_alloc_node@p1\|kmalloc_node@p1\|kzalloc_node@p1\)(...)
>  ... when != x = E
> +    when != assume
>  * IS_ERR@p2(x)

The problem is that ... is searching along control-flow paths, and
Coccinelle only considers control-flow at the statement level, not within
expressions.

Maybe a reasonable solution would be just to consider that we really just
want to protect against if tests?  So

*x = \(kmalloc@p1\|kzalloc@p1\|kcalloc@p1\|kmem_cache_alloc@p1\|kmem_cache_zalloc@p1\|kmem_cache_alloc_node@p1\|kmalloc_node@p1\|kzalloc_node@p1\)(...)
.. when != x = E
* if ( <+... IS_ERR@p2(x) ... +> )
  S1 else S2

where S1 and S2 are declared as statement metavariables.

Another option is:

x = \(kmalloc@p1\|kzalloc@p1\|kcalloc@p1\|kmem_cache_alloc@p1\|kmem_cache_zalloc@p1\|kmem_cache_alloc_node@p1\|kmalloc_node@p1\|kzalloc_node@p1\)(...)
.. when != x = E
(
assume(!IS_ERR(x));
|
* IS_ERR(x)
)

In this case, only the IS_ERR is marked with a *, because if we also
marked the initial assignment, that would get highlighted regardless of
which branch of the disjunction was matched.

julia


