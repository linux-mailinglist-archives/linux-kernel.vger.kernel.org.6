Return-Path: <linux-kernel+bounces-418928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BB09D6754
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 03:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3E82828B0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 02:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F77945008;
	Sat, 23 Nov 2024 02:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0Xqljy/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0696646BF
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732330040; cv=none; b=KL0/G1kJfgpOT+r6YTFNRko8N3M8dD426jGwn6cAuHi5A/KdgMzPi7CViJ4Z7xDq+b0DbZxCCe6DXC4Hkigurr3QVvvjtPeC1wX3gR7ZEEAs4bblGdF0GhVVN2OcFVBSqT3FUgo/AgeD5+bT8MSdmIqER5vi2CDxU96rIBJe8mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732330040; c=relaxed/simple;
	bh=/GuUBZbqHJgIKkuPyY3DKplJMCtcun5TDXxh9fwwt1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3BBD5ZLnLyPZJmMLwjPNL3ugam2GtEwFzkHL/cV5BpqRkX+yt4LfmEcvlACZFEuYb9KTdM7yNYoMJV42lLA00hBc4JBPgtA0ey4IbaSd91aUNkHRi7kPBEsjJmt5qOGzit1qSCZKIxj8mO5PJcOnOYbVbzAbt0SpwnqMVrCrX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0Xqljy/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E99C4CECE;
	Sat, 23 Nov 2024 02:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732330039;
	bh=/GuUBZbqHJgIKkuPyY3DKplJMCtcun5TDXxh9fwwt1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0Xqljy/XU5vwQ/SYXcqD5Zz1TiXDqGEJeZlzEZb5ViyPI9VdoNsRbDoO+NVKKDpL
	 qvb6/RoNGwnNbb/CrZ0onttcginuh4sCplBrjKkTbZopY3YSo4l4Pnw3u8KOF2cR5n
	 G8t0Mol5PyL5b3G57kvtuPYi/Q+9Q4PVpQNNuleuxOaokLKbeL+2LDgMkMU7AgWdjC
	 QOIleY/F2/ZAOrn5zGKoDsmOCzC5GeK+20n1teB8EJRcCfad1vR1tkVd00x34zsZIo
	 g4vAzDiUOsXzimi3sfwJN61KPqkxJI+pZCgX5sqXH1VsBLH5zIUIm5PrTAx6bufp50
	 EBNAh1fbH76LA==
Date: Fri, 22 Nov 2024 18:47:17 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: [PATCH] futex: improve user space accesses
Message-ID: <20241123024717.rvwcpfwh5frrw6nz@jpoimboe>
References: <20241122193305.7316-1-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122193305.7316-1-torvalds@linux-foundation.org>

On Fri, Nov 22, 2024 at 11:33:05AM -0800, Linus Torvalds wrote:
> Josh Poimboeuf reports that he got a "will-it-scale.per_process_ops 1.9%
> improvement" report for his patch that changed __get_user() to use
> pointer masking instead of the explicit speculation barrier.  However,
> that patch doesn't actually work in the general case, because some (very
> bad) architecture-specific code actually depends on __get_user() also
> working on kernel addresses.
> 
> A profile showed that the offending __get_user() was the futex code,
> which really should be fixed up to not use that horrid legacy case.
> Rewrite futex_get_value_locked() to use the modern user acccess helpers,
> and inline it so that the compiler not only avoids the function call for
> a few instructions, but can do CSE on the address masking.
> 
> It also turns out the x86 futex functions have unnecessary barriers in
> other places, so let's fix those up too.
> 
> Link: https://lore.kernel.org/all/20241115230653.hfvzyf3aqqntgp63@jpoimboe/
> Reported-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

I didn't get a chance to try to recreate the original benchmark, but
this looks obviously correct.

Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

