Return-Path: <linux-kernel+bounces-547736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8579DA50CE4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8233A7E8E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A139192D6B;
	Wed,  5 Mar 2025 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="owCJQQxZ"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDFE42AAF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 21:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741208544; cv=none; b=XKUzK0JW+YpLKxzcTt0eAYo+7mU8vmIpsENfhG0W6d/iDpWMQm6PCD0JqbYDxLESERihdBHo2mMKos7ocUfFyGhefbefVY4hP+8gyItIfIN+BfbrWiBUZ62SGOhVfFiJiAKd/nV25IEhzMTC6MtJnuhBlitCmJ2ExvnJhpeOvs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741208544; c=relaxed/simple;
	bh=KzpBkIC90rgL8dLcLczNmaMeOLzIH/ER6zijQgVvX4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOg17tJogsUN10z74jkULlinpnN00OYwmY7ytWe20jLQ9QiiLgdk52IzEU4Tirys6lBTaCA05j+u/EBJuqkSe2UvrVnp3EcgFkd2Xba10HR/1/fxtNpWAe1+KQKOfu3Jq6oV2W5+otSBwsRcmV1TgTJBsT6eSGDacZ+YyhVQoCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=owCJQQxZ; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 5 Mar 2025 13:02:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741208539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XSbL5BTlBryknrie6rGMy93ptcUDNtuaohyluRdJqMk=;
	b=owCJQQxZHdGWT16SwifzDuZzpTExYSMi/D6Ehs51ZWHDaAlZ24Cb4Yc24yMsIv5OiQuVo7
	dQvAuU22U6jRtCvFid2XdpgSRF7CjdmpItoVpDvFEr5nkbpHk5ffnZuNAdkJRw9WaMnOSt
	d54tlvfzbBBEhiS2OOiUQFVUsLiek+M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <howlett@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 05/16] mm/madvise: define and use madvise_behavior
 struct for madvise_do_behavior()
Message-ID: <yv3k2tpeloyqsncwicjq5yl7rd6ao3a6bd22bwh74bf5nbfocb@xnaurkrxq64k>
References: <20250305181611.54484-1-sj@kernel.org>
 <20250305181611.54484-6-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305181611.54484-6-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 05, 2025 at 10:16:00AM -0800, SeongJae Park wrote:
> To implement batched tlb flushes for MADV_DONTNEED[_LOCKED] and
> MADV_FREE, an mmu_gather object in addition to the behavior integer need
> to be passed to the internal logics.  Define a struct for passing such
> information together with the behavior value without increasing number
> of parameters of all code paths towards the internal logic.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/madvise.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index c5e1a4d1df72..3346e593e07d 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1665,9 +1665,15 @@ static bool is_memory_populate(int behavior)
>  	}
>  }
>  
> +struct madvise_behavior {
> +	int behavior;
> +};

I think the patch 5 to 8 are just causing churn and will be much better
to be a single patch. Also why not make the above struct a general
madvise visit param struct which can be used by both
madvise_vma_anon_name() and madvise_vma_behavior()?

