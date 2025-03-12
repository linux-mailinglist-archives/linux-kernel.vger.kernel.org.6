Return-Path: <linux-kernel+bounces-558513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23411A5E6F8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC5D3BB13B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C921EC00C;
	Wed, 12 Mar 2025 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uXL3LVAD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC284685
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741816928; cv=none; b=kgqW66atnNOeS5rmI7Dl8qcCfOG4k5Fr7YXCjruzVpH1zS8rY9vinetc//gDUT4CU2x/0WCu9YnVPZDqtCPQ/4VQOvfXKogMevG52b+6OZceAswmZOC0CK1siq457G3sbf2+V985oP40njBr/+OA9ktSvokfQ544ejzzVWn9jNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741816928; c=relaxed/simple;
	bh=Eo6Eu8e360fJQvkuNRFhWM189X1XwXkzKCdWrCxAZRw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KyfC6VreRFFaqYRlzMS0LTycMxhO84icEYp8msue9kqOidDcF3V1kfc3qHv8E5L4yPhvvvzsxlFxVUOC4xPBnaLs6hQalRzTGn3DmFRWhBXpCu6wYo4/jzYJybNSVJhTN8nstPi1Ch/+4Df71QwxhKAuKizsQLsGQagehKoKonk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uXL3LVAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A008C4CEDD;
	Wed, 12 Mar 2025 22:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741816928;
	bh=Eo6Eu8e360fJQvkuNRFhWM189X1XwXkzKCdWrCxAZRw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uXL3LVAD3+MFrG+nB/yBh+3wFqjzEIzbsU/6mRJrWe8wH29REn8yCGTrQ4F8jnEyE
	 VaGHdIAMHzzFmGEa1IftorEndl8I/j3XrbwbVTXRUu0A9fyCXtR/Nl+YWz9yd+S2/q
	 FK9x9TvIkjcTi+fe1dmicekWQaJhgyAcBSnjv8a8=
Date: Wed, 12 Mar 2025 15:02:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, =?ISO-8859-1?Q?Andr=E9?= Almeida
 <andrealmeid@igalia.com>, Darren Hart <dvhart@infradead.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>,
 Waiman Long <longman@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH v10 19/21] mm: Add vmalloc_huge_node()
Message-Id: <20250312150206.54afabcf993bbc55f0066886@linux-foundation.org>
In-Reply-To: <20250312151634.2183278-20-bigeasy@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
	<20250312151634.2183278-20-bigeasy@linutronix.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Mar 2025 16:16:32 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> To enable node specific hash-tables.

"... using huge pages if possible"?

> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3966,6 +3966,13 @@ void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL_GPL(vmalloc_huge_noprof);
>  
> +void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node)
> +{
> +	return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLOC_END,
> +					   gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
> +					   node, __builtin_return_address(0));
> +}
> +

kerneldoc please?


I suppose we can now simplify vmalloc_huge_noprof() to use this:

static inline void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask)
{
	return vmalloc_huge_node_noprof(size, gfp_mask, NUMA_NO_NODE);
}

