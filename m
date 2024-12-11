Return-Path: <linux-kernel+bounces-442183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB1C9ED918
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDAEF163BD1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEF41DDC28;
	Wed, 11 Dec 2024 21:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGB3pCl4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6E1A2872
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954031; cv=none; b=nHUX3uA3R7AkqG7hQioy2NGlAk2+QPLB41V9UEoIl1i9Nq56/fxzL58gsyWQt03BXW/NPgbpVhf/2VYI56XXDDn5egXO5m7xObsiHxgTYs0WmLSuxFSDXKs1HK9Flkn+gWr2G/KxUlP3uhFh5sPKFkC1VQjLA1t7/SWw4LewQ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954031; c=relaxed/simple;
	bh=lB6jsDaaKUcqh5VcoGPwqJA2g5xDE4qtcrOYdCF2vas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jb5L6HXNxYtqIKPlgW2mALyHs93N7xxiIu1hQg6ucezgPe2nyADfDNAdfcox1jVBMORR5SrXOhfHd1jQjM/SdTcSMRPlT76KpGR77oYKShdI5wX3AhmXh4WQITKnj/iAfgw9NTLllTsLzeTnp1fNIWwQ/iP/vwbI4Ms9saFaLIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGB3pCl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97571C4CED2;
	Wed, 11 Dec 2024 21:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733954030;
	bh=lB6jsDaaKUcqh5VcoGPwqJA2g5xDE4qtcrOYdCF2vas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGB3pCl49yg3tqJQDoP6KApHmi8bsmyDI2FJLZdrTUF5oB4vzzq1fp3tMCHoPRNDE
	 qKag1x3MukKfNXUb8yDgSc3L+Mynf5Wt+wOREbcJgMpBYReR6zwujgEVnU7/x+tKh/
	 FcjChxWvc5uNVIHkFpMcnro0EEhM9a2yAZ5vCRy9Ivdx63WZkTQ7kNs6sA1DYx6hwA
	 JFY7euyo4EeZlT3TpiXMOdolTnzS4u24R0RdWSq6HdAiFAwPZ9ySTQSXVzIK7YMeTL
	 JMm27ljn64KY8EIY8jtJ5Lxib7HXWoFx2XiyuVz/8lg6R3ZgGxzYG1W3CSogg7Yeet
	 0D/J9a8beNc+g==
Date: Wed, 11 Dec 2024 21:53:48 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"hanqi@vivo.com" <hanqi@vivo.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: Unicode conversion issue
Message-ID: <Z1oJ7PgRvLyctn0X@google.com>
References: <Z1mzu4Eg6CPURra3@google.com>
 <87v7vqyzh4.fsf@mailhost.krisman.be>
 <Z1nG-PSEe6tPOZIG@google.com>
 <87cyhyuhow.fsf@mailhost.krisman.be>
 <CAHk-=wice8YV5N1jjyz42uNi-eZTvG-G2M46qaN7T9VsSaCP_Q@mail.gmail.com>
 <CAHk-=wiC3evUXq8QTcOBFTMu1wsUR_dYiS8eGxy0Hh7VbL55yA@mail.gmail.com>
 <875xnqudr1.fsf@mailhost.krisman.be>
 <CAHk-=wi+ZB4fNiMTHOYo2__-NnBXryQwxJ_bHN+cUDsfBBt_MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi+ZB4fNiMTHOYo2__-NnBXryQwxJ_bHN+cUDsfBBt_MA@mail.gmail.com>

On 12/11, Linus Torvalds wrote:
> On Wed, 11 Dec 2024 at 13:11, Gabriel Krisman Bertazi <krisman@suse.de> wrote:
> >
> > This solves it for directories with inlined dirents
> > (FI_INLINE_DENTRY). but for large directories, we use fname->hash to
> > find the right block to start the search.
> 
> Grr. Dammit, the hash should always have been the original hash of the
> original actual case-preserving entry.
> 
> Oh well. I'll continue to just absolutely hate case-folding, because
> while I suspect that it *could* be done correctly, I have yet to ever
> actually see any filesystem that did so.

Casefolding supports f2fs and ext4 per Android request, and only f2fs
constructs hash-based directory structure. If we use hash of the
case-preserving entry, we had no easy solution to distinguish file_A and file_a.

One possible way might be searching only filename sequentially through
the entire dentry list, if we fail to find the new encoded entry. But, it may
need a huge surgery to make it work.

> 
>             Linus

