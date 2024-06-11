Return-Path: <linux-kernel+bounces-210614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3595B904642
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B8E289007
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848D814D2BF;
	Tue, 11 Jun 2024 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BiXB5q16"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1672033E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718141560; cv=none; b=LliGjgMY+ZqSdpcXXA9sr5vN3WfNpXITjItZTREBNjkDEH0pXjsmq3PiuUyYwQCnPfzB5qq4GmRdDHwKQXWlqR/2WdnfM/xO4TpwjsZ+7tAQvZBqcyowpaRYRUvNKY3ib2wVkipdnUhIP6723HxbB9c/acKXU/6uu2UKVUa561o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718141560; c=relaxed/simple;
	bh=hs/xJDgX5Umyh+Qy6+Duix9UmauZ5rTGoZyc5jWk3B8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=vC0IsHvjJsEjqq5v1dDq4/bsXZIbvhMgENBcGyv8gXFi94OTugMlEzQE7A5KajqMaxXrzNe/7BntMjkt91x822VldSjHjHnxYM1UBTU1+moqIHMCjhdQ4a5RieS38hNmnzLGEnz6+iQqtGRrODSOcXCHy+wuJUmv+0CEXTWmMGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BiXB5q16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B8EC2BD10;
	Tue, 11 Jun 2024 21:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718141560;
	bh=hs/xJDgX5Umyh+Qy6+Duix9UmauZ5rTGoZyc5jWk3B8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BiXB5q16pcYyYhxCW9vVON9Ezg7dUTItpbpNftCk8XI6Kh3aOvZzUUBVvMx65lzyU
	 Eu9YaQn+aLpIjeA77K+7JQCYp6dG/msTbOroq2YFd3PofPBVUcfLz4kTx082jqTu7w
	 O6+Ogo1t3jBQPyXoxvOcSCCDC3qtEkykvJoBdXSk=
Date: Tue, 11 Jun 2024 14:32:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Rafael Aquini <aquini@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Heiko
 Carstens <hca@linux.ibm.com>, Petr Mladek <pmladek@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Paul McKenney <paulmck@kernel.org>, Samuel Holland
 <samuel.holland@sifive.com>
Subject: Re: [PATCH v2] mm: mmap: allow for the maximum number of bits for
 randomizing mmap_base by default
Message-Id: <20240611143239.ab8e4d96289a748ae1f8a480@linux-foundation.org>
In-Reply-To: <ZmdJyK7Mm9rFCpv2@optiplex-fbsd>
References: <20240606170026.101839-1-aquini@redhat.com>
	<20240606180622.102099-1-aquini@redhat.com>
	<20240610111139.1e392360ffe847ea48ffebab@linux-foundation.org>
	<ZmdJyK7Mm9rFCpv2@optiplex-fbsd>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 14:45:28 -0400 Rafael Aquini <aquini@redhat.com> wrote:

> On Mon, Jun 10, 2024 at 11:11:39AM -0700, Andrew Morton wrote:
> > On Thu,  6 Jun 2024 14:06:22 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> > 
> > > An ASLR regression was noticed [1] and tracked down to file-mapped areas
> > > being backed by THP in recent kernels. The 21-bit alignment constraint
> > > for such mappings reduces the entropy for randomizing the placement of
> > > 64-bit library mappings and breaks ASLR completely for 32-bit libraries.
> > > 
> > > The reported issue is easily addressed by increasing vm.mmap_rnd_bits
> > > and vm.mmap_rnd_compat_bits. This patch just provides a simple way to
> > > set ARCH_MMAP_RND_BITS and ARCH_MMAP_RND_COMPAT_BITS to their maximum
> > > values allowed by the architecture at build time.
> > > 
> > > [1] https://zolutal.github.io/aslrnt/
> > 
> > Are we able to identify a Fixes: target for this?
> >
> 
> Sure, it would be:
> 
>  Fixes: 1854bc6e2420 ("mm/readahead: Align file mappings for non-DAX")
>  
> > I assume a cc:stable is appropriate?
> > 
> 
> Andrew, I admit I was somewhat hesitant on adding the Fixes: and the stable CC
> to this patch because I didn't really think of it as a "fix" for the given 
> commit, but just as a simple way to toggle ARCH_MMAP_RND{,_COMPAT}_BITS 
> to maximum allowed at build time.
> 
> I don't disagree with doing it, though, if you think it might be appropriate.

Well, "breaks completely" is motivational!

But does the patch fix this, by default?  Doesn't the user have to take
some action (set FORCE_MAX_MMAP_RND_BITS) to fix the breakage? 
Shouldn't we make this the default (at least for 32-bit) so the
regressed kernels are fixed simply by applying this patch?

> Lemme know if you want me refreshing the patch to amend these bits.

Is OK, I can update things.

