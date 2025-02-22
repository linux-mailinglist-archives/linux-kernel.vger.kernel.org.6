Return-Path: <linux-kernel+bounces-527181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8AFA4082A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FEB9702BE7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB86207E0A;
	Sat, 22 Feb 2025 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgS0F/pr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ED12066D9
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740225797; cv=none; b=BUop6M0EYelz1JZptzJCk6S/UIW5+YGyUV0lXfcU8UAAa5YOSlp4CzZSa4ze2WxKGAKa6UnH9JW0WL3W9rHUodsQ4EORaNieD5OBGRIW17j+i1e3QYbG1fvZI4uiNi6x1sWk1DIrMadlE4kJw3+TQZaXsrjfEu+DxFhKv9VIK2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740225797; c=relaxed/simple;
	bh=JKuPKfP/+zE/C/l49mh6YZeCh+XMEiC/388ZHcb86Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmCSKXXhLzoMHSS4ikfJC0B7NTqHgXy+yqxmmEYZJFHjSoPKg2eyeNgPhEvA4civfOEniPEYa+yaq8lZkEEchIqSthPQv74fUF3PQ4kO4VRjFLg6+adUfqkB7UY4u8K3lGn015nj/XchdvTCittnD3wXRWOuwSHgCum19iQbqos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgS0F/pr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14366C4CED1;
	Sat, 22 Feb 2025 12:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740225796;
	bh=JKuPKfP/+zE/C/l49mh6YZeCh+XMEiC/388ZHcb86Og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TgS0F/prLCu/5Oq38bHZA14MZZsaJ/DPrALJr/HZ6fVxD9isTWho+/sxA56rIvzjg
	 aO4LFom9m5yOuTU8ecpHGxWFFohoU0c+6/ae76eO0G2m5fm1JTvPVPuU2s1KnZBV0a
	 NgN/o+UwG5zKIjFQ4GAh6vQbOOz9/zmXPx942l2Iy7F6k66NDnpBDcog+47k1cjaeS
	 SslV39c/juXRXZe0rdy56KH7CrsPKpoLu3ijNIHBfTNE4zi02cE//QokSRW/jrSx+2
	 svFz3UBQGtsLy8NUWXS081Y6q52mxUvd5pxOUvZRnxZhx42IBJ7sKBThTVIha34X6V
	 ufjdG5PrmUAtQ==
Date: Sat, 22 Feb 2025 13:03:07 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [RFC PATCH 1/2] x86/relocs: Improve diagnostic for rejected
 absolute references
Message-ID: <Z7m8-4X0DnPVn-SZ@gmail.com>
References: <20250127114334.1045857-4-ardb+git@google.com>
 <20250127114334.1045857-5-ardb+git@google.com>
 <CAHk-=wgD1TGxZPC0yoiVJb3qDN9vDpzNkcW1z17+6mk_Rh+iFg@mail.gmail.com>
 <CAMj1kXGfgxBM5DJ6vwwGvqPs9hH57h-G4w=-bF51+7cckayPGA@mail.gmail.com>
 <Z6CPFv_ye8aSf320@gmail.com>
 <CAMj1kXHi63vHS7EuZE-frb-nf8P9RV=dPyFR+UU9=NaCHvP=MA@mail.gmail.com>
 <Z7m8i8YC7Mltqcpz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7m8i8YC7Mltqcpz@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> So after another 2 weeks there's been no new upstream regressions I'm 
> aware of, so - knock on wood - it seems we can leave the die() in 
> place?
> 
> But could we perhaps make it more debuggable, should it trigger - 
> such as not removing the relevant object file and improving the 
> message? I.e. make the build failure experience Linus had somewhat 
> more palatable...

For example, the new message is far better, even when combined with a 
die() build failure:

-                       die("Absolute reference to symbol '%s' not permitted in .head.text\n",
-                           symname);
-                       break;
+                       fprintf(stderr,
+                               "Absolute reference to symbol '%s+0x%lx' detected in .head.text (0x%lx).\n"
+                               "This kernel might not boot.\n",
+                               symname, rel->r_addend, offset);

as it points out that the underlying bug might result in an unbootable 
kernel image. So the user at least knows what the pain is about ...

Thanks,

	Ingo

