Return-Path: <linux-kernel+bounces-511923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51304A3317D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A06167213
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B14D2036E0;
	Wed, 12 Feb 2025 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmxOk7fE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A893E202F90
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739395809; cv=none; b=Fe+liyC2hmU3CDkcoYSdmhpsiwJ6XwL0yv7RBYZUKwj3ykZdQo/rntUxrK+7YtxS3vGGgO4p7EqNPqi6kNzckGZ0fMMbKHoyZJqsMAzGnxUT+30X5R5MnVyd8SI1cnA3DlciWifAgurrvEgHFXD18BxyzawmQlkQFyxClTg8TbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739395809; c=relaxed/simple;
	bh=E11JdGdSryE4u0Zj75nD+BOOC9K1hxW6LuRwZCgPYLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0eRINQRciSZoyBvIZqk6cSVqxj4XkU+Wfug9UJ9j8++m0ViagLv3VnmK4HbH5mJ9CCv+HcW51lNJ3/0HEDMXYcxQuaCk2Zba3hvZ3GNV4LFyjU7Hc/9g/MvvXWRS0CwIjaDcMqwK4OWoQPLnUrH1fpOblDyCoksgOIIj1s3NbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmxOk7fE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B781C4CEDF;
	Wed, 12 Feb 2025 21:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739395809;
	bh=E11JdGdSryE4u0Zj75nD+BOOC9K1hxW6LuRwZCgPYLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmxOk7fEH6KfaykFBtirOyC0oMQup5NfTBne2E4szWsvNk7vMzgmFtSyvqsWpVvy7
	 Y5HOr7EU7Zm2Amp7eprapQ8NXhL2coJ3jvPCt/tOdDcsNjexyhgo6B+085ZqoXcmV9
	 eqaGE//C49gj1NWkwHw5gUbyGWKgrxKbymxkl3+84xdfRttir1OrzlQRZVnPBXW5aG
	 1kCyzw1uz1TtTeh3jQ6dfYY4mE8OHztmIUx8WFthQ3bFQEF7Dcry4PwcI5nGEht1tr
	 BJEQeovg3POnPoVJEIVrWbaxEYtxiJ9XP5s2i18ltnTs6xcZk0j5PCeUZEfHWhzpQO
	 Djm3OETH4cqGQ==
Date: Wed, 12 Feb 2025 11:30:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Dennis Zhou <dennis@kernel.org>, Filipe Manana <fdmanana@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, percpu: do not consider sleepable allocations atomic
Message-ID: <Z60S4NMUzzKbW5HY@slm.duckdns.org>
References: <20250206122633.167896-1-mhocko@kernel.org>
 <Z6u5OJIQBw8QLGe_@slm.duckdns.org>
 <Z6zS4Dtyway78Gif@tiehlicka>
 <Z6zlC3juT46dLHr9@slm.duckdns.org>
 <Z60KQCuPCueqRwzc@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z60KQCuPCueqRwzc@tiehlicka>

Hello,

On Wed, Feb 12, 2025 at 09:53:20PM +0100, Michal Hocko wrote:
...
> > Hmm... you'd a better judge on whether that'd be okay or not but it does
> > bother me that we might be increasing the chance of allocation failures for
> > GFP_KERNEL users at least under memory pressure.
> 
> Nope, this will not change the allocation failure mode. Reclaim
> constrains do not change the failure mode they just change how much the
> allocation might struggle to reclaim to succeed. 
>
> My undocumented assumption (another dept on my end) is that pcp
> allocations are no hot paths. So the worst case is that GFP_KERNEL
> pcp_allocation could have been satisfied _easier_ (i.e. faster) because
> it could have reclaimed fs/io caches and now it needs to rely on kswapd
> to do that on memory tight situations. On the other hand we have a
> situation when NOIO/FS allocations fail prematurely so there is
> certainly some pros and cons.

I'm having a hard time following. Are you saying that it won't increase the
likelihood of allocation failures even under memory pressure but that it
might just make allocations take longer to succeed?

NOFS/IO prevents allocation attempt from entering fs/io reclaim paths,
right? It would still trigger kswapd for reclaim but can the allocation
attempt wait for that to finish? If so, wouldn't that constitute a
dependency cycle all the same?

All in all, percpu allocations taking longer under memory pressure is fine.
Becoming more prone to allocation failures, especially for GFP_KERNEL
callers, probably isn't great.

> As I've said I am no pcp allocator expert so I cannot really make proper
> judgment calls. I can improve the changelog or move from scope to
> specific gfp flags but I do not feel like I am positioned to make deeper
> changes to the subsystem.

I don't think deciding whether always using NOIO/FS is a good idea requires
knowing the percpu allocator that well. It's just depending on the
underlying page allocator for that part.

Thanks.

-- 
tejun

