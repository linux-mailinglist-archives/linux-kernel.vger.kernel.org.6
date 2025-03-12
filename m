Return-Path: <linux-kernel+bounces-557575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 843A5A5DAF0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289661896515
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2322C23E34B;
	Wed, 12 Mar 2025 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEk6AtPF"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D2D23C8AF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776979; cv=none; b=KsJPt4qyOrZlbVUuFjyY7h3Dbg4+0kH/Kkce9a+G3ZXLkJFnbH/shpS5Pj6kqwpQLGGTJDannLgocEZBfHati0M3NnWZBJrp2CRBzqfV78oEh9Fo0NpuMNPnxwO78Uqd2XZ/Bdhmfo9NB99BMNSOF4RKwp297jadD5iicQoO2Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776979; c=relaxed/simple;
	bh=H2xL/DrdmdtNndSYeaBBoHFufXOzlBX9g5y0jWZrzCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWPD/RrdX+Cw1df2CbC3QQQX/jpMgEdf/DqUlgI3F069TgYVq/8ntaPl38/hoNTT4E8M2hYNLvjUVgbCdB7HhaRBTrk+/7oizWCf0netiuSEN2zPPAPVZIZzDF3GbGfhR9wTmOIaos8FDPyBhfbiudKbc15ZwCsCZ/LipEx7224=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEk6AtPF; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso6256177a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741776975; x=1742381775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=snvG7I/yxcNLJbo5TymkPopQ91uklMZuBR4ddw0uRDg=;
        b=IEk6AtPFzJzEGTZiFeT1gmNiTemhxb5tATpN9mYuoomtmPmHK5KViLIkavqP5a+beU
         5MYJb2iNX0A7vkjnWMg60UidPfP3I3kikIVrErHIxFoHErKAvgZz+edX9uY41jWiMRV0
         gzTfXSvO9q4NZIgxnQsXJ6lT+n8W/32D9ACwy7AJ8wptW7UZdZXMARWH9JygT/qHZEU4
         OADimTbdkkz1KaKyQc7vk9vrdkgt80kOsSXkhD7/MGtvwfqIYHxHuG4k4nVtJHI9JILc
         frR32MEfRjZZyvFLuh7oPbbPJF4Q8SCE1sVfvIzY1dgGMVTSpwaHo4FBLEAL1B+Y1p8v
         1o2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741776975; x=1742381775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snvG7I/yxcNLJbo5TymkPopQ91uklMZuBR4ddw0uRDg=;
        b=lKKLljxrOmX/DMXuWbOTe/aJbud8dhPEyAoV7WPt3JLFBfjojRlTBIFtBTCZRDySNu
         Rv+/3SlvUfPRf/F4oNZVokjdAWxoHiCV7rdgpmDB/XQaEFM441HyZgezPTfViDSTeHTX
         CFUVJOCHHXtQfYXLMAZ/5J1rOszDJ4/HbOpntx3YZDPa91tBKcRM7TFqCfkGobffnIoV
         AvsRy22FhIqPiz44JZW5iJepQ/P9zR7VjiNJ6/GZY2FWy548rzBngTjAY9LDs9NXvqcU
         tIAkwv/75/8LoTvwZr4R/5bPcgekhFnExWpSF58zw3lEsuJBQKitrxfJtR+yndRitOcn
         rkBg==
X-Forwarded-Encrypted: i=1; AJvYcCUjKfI3ki+26Ys44CumLSatApv2YTLdsv3hQD/bwvyFQeQ0qUAT+7e78TmOsBWsgwo9T3CmYQIcBGSjesc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqlnecdkL5DKy1Z4PCk9CSxW2OkhwOp4rf5ORh8Kz6tZTPPJI6
	SPgN0es0HticjccI9eNqQ+J3LQo3ZMWGhrkxysfOG6oKd3VRk0+I
X-Gm-Gg: ASbGncv5Mn4AeLI7SF/CIgVbD7G319eAgf6DKjxa+eUM/XzRhtzBbzWjBSRnSPZIR+B
	5ZZDUqIcfLlo9UETb5W1SNCjuN5o3lWh4NiHsZXZTe0/YqdOlWAGP2KU/NpU9oxldzmgWmh6JXj
	5zXxNYprMxab4dZOEnOFyA2NYTJpxBLGNmveCLLdD5gIwDKjOcxx4l17VL6A6OwT03hnh/GRiYH
	lEbDoeTt7hqR6Evw1vG0e+Yuqk/qJTeddS7RiaBLY1Z4I8tl3C20DFgy/W9U+TonNmuM6p9ZaJx
	HY15VYKXjcxGH89LnvtodJwuYr48+n28lMZgGPjw
X-Google-Smtp-Source: AGHT+IEggCYXkJhdsjo3s4+6397QaF8ywtamlavWlpZUsbKmH/epfuxy3n9O12rcC8hc/sGVoSs9DQ==
X-Received: by 2002:a05:6402:5248:b0:5e7:b081:8b2f with SMTP id 4fb4d7f45d1cf-5e7b0819420mr3910525a12.8.1741776975107;
        Wed, 12 Mar 2025 03:56:15 -0700 (PDT)
Received: from andrea ([31.189.82.201])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74a8f2fsm9802846a12.41.2025.03.12.03.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:56:14 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:56:10 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>, linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm: Add missing release barrier on
 PGDAT_RECLAIM_LOCKED unlock
Message-ID: <Z9FoSjoK3qCtJ6R5@andrea>
References: <20250307193047.66079-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307193047.66079-1-mathieu.desnoyers@efficios.com>

On Fri, Mar 07, 2025 at 02:30:47PM -0500, Mathieu Desnoyers wrote:
> The PGDAT_RECLAIM_LOCKED bit is used to provide mutual exclusion of
> node reclaim for struct pglist_data using a single bit.
> 
> It is "locked" with a test_and_set_bit (similarly to a try lock) which
> provides full ordering with respect to loads and stores done within
> __node_reclaim().
> 
> It is "unlocked" with clear_bit(), which does not provide any ordering
> with respect to loads and stores done before clearing the bit.
> 
> The lack of clear_bit() memory ordering with respect to stores within
> __node_reclaim() can cause a subsequent CPU to fail to observe stores
> from a prior node reclaim. This is not an issue in practice on TSO (e.g.
> x86), but it is an issue on weakly-ordered architectures (e.g. arm64).
> 
> Fix this with following changes:
> 
> A) Use clear_bit_unlock rather than clear_bit to clear PGDAT_RECLAIM_LOCKED
>    with a release memory ordering semantic.
> 
> This provides stronger memory ordering (release rather than relaxed).
> 
> B) Use test_and_set_bit_lock rather than test_and_set_bit to test-and-set
>    PGDAT_RECLAIM_LOCKED with an acquire memory ordering semantic.
> 
> This changes the "lock" acquisition from a full barrier to an acquire
> memory ordering, which is weaker. The acquire semi-permeable barrier
> paired with the release on unlock is sufficient for this mutual
> exclusion use-case.

FWIW, this aligns with my understanding.

Is (A) intended to be (submitted separately and) backported?

  Andrea


> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Andrea Parri <parri.andrea@gmail.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: linux-mm@kvack.org
> ---
>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c22175120f5d..021b25bdba91 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -7567,11 +7567,11 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
>  	if (node_state(pgdat->node_id, N_CPU) && pgdat->node_id != numa_node_id())
>  		return NODE_RECLAIM_NOSCAN;
>  
> -	if (test_and_set_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags))
> +	if (test_and_set_bit_lock(PGDAT_RECLAIM_LOCKED, &pgdat->flags))
>  		return NODE_RECLAIM_NOSCAN;
>  
>  	ret = __node_reclaim(pgdat, gfp_mask, order);
> -	clear_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
> +	clear_bit_unlock(PGDAT_RECLAIM_LOCKED, &pgdat->flags);
>  
>  	if (ret)
>  		count_vm_event(PGSCAN_ZONE_RECLAIM_SUCCESS);
> -- 
> 2.25.1
> 

