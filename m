Return-Path: <linux-kernel+bounces-351279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8853990F47
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B06E1F26E66
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A098C1E9088;
	Fri,  4 Oct 2024 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="guHiP5w8"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAA41E9073
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067485; cv=none; b=oig28hjczc5dgaMdhZImbZ73qlRjiwQZrSAR60wFipDLhRk83DYsiI62fVNOVATO/9hmK1xcpcEjW72D2gdaaINHXfVcKDquB8j0yReR4zr81/2WUMGccc5K8f2CI0TO+3N8NftbyFDIzzZtZh8Qi+kfni4b7YgaJPEFRWiTt98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067485; c=relaxed/simple;
	bh=bUHNwO6BGL1y8estJEYUjfAuEzJQYsJ5I8lRBCd6wJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWjGQ9JlOwUB4YCQ8801XpgXHI+BJQhtbxtrvC7znfB5TXF57S4EQkru9S92Zaih7B8EVzW3Z++1OE4TyLZvRvRBeVcC0NZTsKbfk5S5sc6KAHzB+AwcHqDmYfpvaPken0YP/QFSwWU/HYl0KDm30GAwMpNeMp5+H3AzSJMlbug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=guHiP5w8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=9b14BEYfQ7v8D8dobaCLNHdmML5+zTXDssoAlmiHX9Y=; b=guHiP5w8fh1745JqPM1whQBjIY
	8OWhaesZDKljSFcCwQRBq5VTPetkzgWrPB2465jbSuB5lQVLwmELMoEqyZ8J2fmUvAujvi6b62Scl
	RRPVPREhgYgsm9Zjc1i1lKt9svZZdYv7iUBZXA/B69cAhDbr67u19IKEUtvZZoilb04rkREDgG8ze
	pVv+u/U+FzVqE3c2Q/y8VUeBumzqleAzUocp5vxoMPO0oFpSquf1fBJV8weaL5+yjvSl/AC1qLLj7
	ARvAE9Rb3RTFm09FAnkB4Fn2ksSckADKae8ponpLBsyrbINNfuNm3ogjJQ0kiuG3rnfiT7Etm0U4K
	H1THdjMw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swnI9-00000000qgy-06zP;
	Fri, 04 Oct 2024 18:44:41 +0000
Date: Fri, 4 Oct 2024 19:44:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Brahmajit Das <brahmajit.xyz@gmail.com>
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] fs/qnx6: Fix building with GCC 15
Message-ID: <20241004184440.GQ4017910@ZenIV>
References: <vch6gmzqaeo22c7473qyabrfwxlkdhx5vgvosjyp5l2nwgqnxl@5x3ny35qyfgx>
 <20241004094921.615688-1-brahmajit.xyz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004094921.615688-1-brahmajit.xyz@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 04, 2024 at 03:19:21PM +0530, Brahmajit Das wrote:
> GCC 15 enables -Werror=unterminated-string-initialization by default.
> This results in the following build error
> 
> fs/qnx6/inode.c: In function ‘qnx6_checkroot’:
> fs/qnx6/inode.c:182:41: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
>   182 |         static char match_root[2][3] = {".\0\0", "..\0"};
>       |                                         ^~~~~~~
> fs/qnx6/inode.c:182:50: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
>   182 |         static char match_root[2][3] = {".\0\0", "..\0"};
>       |                                                  ^~~~~~
> 
> Dropping to match_root array and drictly comparing dir_entry entries via
> memcmp provides a work aroud for the build error.

LGTM, except that I'd probably make the commit message less warning-centric -
something like

	qnx6_checkroot() had been using weirdly spelled initializer - it needed
	to initialize 3-element arrays of char and it used NUL-padded 3-character
	string literals (i.e. 4-element initializers, with completely pointless
	zeroes at the end).

	That had been spotted by gcc-15[*]; prior to that gcc quietly dropped
	the 4th element of initializers.

	However, none of that had been needed in the first place - all this array
	is used for is checking that the first directory entry in root directory
	is "." and the second - "..".  The check had been expressed as a loop,
	using that match_root[] array.  Since there is no chance that we ever
	want to extend that list of entries, the entire thing is much too fancy
	for its own good; what we need is just a couple of explicit memcmp()
	and that's it.

	[*] <quoted warnings>

would explain what was really going on - the point is not to make gcc STFU, it's
to make the code more straightforward.  The warning is basically "it smells
somewhat fishy around >here<, might be worth taking a look".  And yes, it turned
out to be fishy; minimal "make it STFU" would be to strip those NULs from
the initializers (i.e. just go for static char match_root[2][3] = {".", ".."}; -
an array initializer is zero-padded if it's shorter than the array), but that
wasn't the only, er, oddity in that code.

