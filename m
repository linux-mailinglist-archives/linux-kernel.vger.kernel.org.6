Return-Path: <linux-kernel+bounces-191204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EAD8D07FE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7181F20622
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C1016A38E;
	Mon, 27 May 2024 16:06:46 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 8C93316A377
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826006; cv=none; b=Bfpf4wGyFy7jMxSo0XMGrGzED4VWGO3EKmaVPm1ChnC2YHip66b0Szv6r8mcrRmxmDFoHkaReo2AX6o2GIxc7F83fd9nxwcBmXFRoIeGroD0kXE6za9KxlBcUs2FGXokIwsIy6ZwaCfTSfGqK8E2AMWlw0Ukn2YeJ9HL21sbi3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826006; c=relaxed/simple;
	bh=I7GtLFFH2s6jsZ8vsF4KrRfJtl5AhAztTd9wbcIkg9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAxYmqMpUeLzrHO2Bz5omzyC5QXotkGBMhpR4Syok2B0Jp/L5NeOXy09B+PDtUwNbOnvSBt7m8bxe5VnMxU+MW2n+gEaKJTCM/ndXWP3mDWlmEk7E7LEvmXYt4ga847dei/G5SYKaoRg4WeG7AHll2ZkC2BKJBT8vTPe9qwLH1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 663563 invoked by uid 1000); 27 May 2024 12:06:43 -0400
Date: Mon, 27 May 2024 12:06:43 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
  peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
  dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
  urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 4/4] tools/memory-model: Distinguish between
 syntactic and semantic tags
Message-ID: <5ce0c8a3-bd9c-475a-9427-7edef47a90f2@rowland.harvard.edu>
References: <20240527152253.195956-1-jonas.oberhauser@huaweicloud.com>
 <20240527152253.195956-5-jonas.oberhauser@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527152253.195956-5-jonas.oberhauser@huaweicloud.com>

On Mon, May 27, 2024 at 05:22:53PM +0200, Jonas Oberhauser wrote:
> Not all tags that are always there syntactically also provide semantic
> membership in the corresponding set. For example, an 'acquire tag on a
> write does not imply that the write is finally in the Acquire set and
> provides acquire ordering.
> 
> To distinguish in those cases between the syntactic tags and actual
> sets, we capitalize the former, so 'ACQUIRE tags may be present on both
> reads and writes, but only reads will appear in the Acquire set.
> 
> For tags where the two concepts are the same we do not use specific
> capitalization to make this distinction.
> 
> Reported-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> ---
>  tools/memory-model/linux-kernel.bell |  22 ++--
>  tools/memory-model/linux-kernel.def  | 176 +++++++++++++--------------
>  2 files changed, 99 insertions(+), 99 deletions(-)
> 
> diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
> index 08fa1ccb1328..045d94a8eabf 100644
> --- a/tools/memory-model/linux-kernel.bell
> +++ b/tools/memory-model/linux-kernel.bell
> @@ -13,18 +13,18 @@
>  
>  "Linux-kernel memory consistency model"
>  
> -enum Accesses = 'once (*READ_ONCE,WRITE_ONCE*) ||
> -		'release (*smp_store_release*) ||
> -		'acquire (*smp_load_acquire*) ||
> -		'noreturn (* R of non-return RMW *) ||
> -		'mb (*xchg(),compare_exchange(),...*)
> +enum Accesses = 'ONCE (*READ_ONCE,WRITE_ONCE*) ||
> +		'RELEASE (*smp_store_release*) ||
> +		'ACQUIRE (*smp_load_acquire*) ||
> +		'NORETURN (* R of non-return RMW *) ||
> +		'MB (*xchg(),compare_exchange(),...*)
>  instructions R[Accesses]
>  instructions W[Accesses]
>  instructions RMW[Accesses]
>  
>  enum Barriers = 'wmb (*smp_wmb*) ||
>  		'rmb (*smp_rmb*) ||
> -		'mb (*smp_mb*) ||
> +		'MB (*smp_mb*) ||
>  		'barrier (*barrier*) ||
>  		'rcu-lock (*rcu_read_lock*)  ||
>  		'rcu-unlock (*rcu_read_unlock*) ||
> @@ -38,10 +38,10 @@ instructions F[Barriers]
>  
>  (* Remove impossible tags, such as Acquire on a store or failed RMW *)
>  let FailedRMW = RMW \ (domain(rmw) | range(rmw))
> -let Acquire = Acquire \ W \ FailedRMW
> -let Release = Release \ R \ FailedRMW
> -let Mb = Mb \ FailedRMW
> -let Noreturn = Noreturn \ W
> +let Acquire = ACQUIRE \ W \ FailedRMW
> +let Release = RELEASE \ R \ FailedRMW
> +let Mb = MB \ FailedRMW
> +let Noreturn = NORETURN \ W
>  
>  (* SRCU *)
>  enum SRCU = 'srcu-lock || 'srcu-unlock || 'sync-srcu
> @@ -81,7 +81,7 @@ flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
>  flag ~empty different-values(srcu-rscs) as srcu-bad-value-match
>  
>  (* Compute marked and plain memory accesses *)
> -let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
> +let Marked = (~M) | IW | ONCE | RELEASE | ACQUIRE | MB | domain(rmw) | range(rmw) |

The new MB term isn't needed, because MB tags on memory accesses are 
filtered out unless the access also belongs to domain(rmw) | range(rmw).

Alan

