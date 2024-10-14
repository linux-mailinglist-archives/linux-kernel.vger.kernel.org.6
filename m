Return-Path: <linux-kernel+bounces-364677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC3C99D7CA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59EEDB21662
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06501CDFCD;
	Mon, 14 Oct 2024 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GwhEfiuP"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6461CC8B1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728935987; cv=none; b=cKK9wsiOxJ52T37qYBPLRyyGSnOZuoHZjJ/p88ku3IQEcENkd1kTOayz4AkuPS94qvuXaIGHIhJAYBwcannKp+0c2WTsG7yuZvoSBYp+3IL1BNXZas8usI88Q9qVrcoFgAyTwb93t8FhfamlnxaO5Op3mg6rmEbAwxc6UaQMf54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728935987; c=relaxed/simple;
	bh=JdCTqCwU3Cc894g9U5z8iuvDwFeRIG0ImgHGr8z69RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uF+8c/qYmJGaIbfRkulNGBnuwy7DwhRKolnZvwACHryfJ0JtWVAa4gkfytsgnfTbI6JBvHfg6FyEBrW+ZUgi3QGSBJU0xQWsoFgN0F8q3TlE+p5N0fApLFVa9mAzPPZNO/PVNyKfVitOr8S/FR8JTxkXZc81CokXXdSK8hIjFLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GwhEfiuP; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 14 Oct 2024 12:59:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728935982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTE7/S0xDM06pUJ9VNa5Wo36gDyiHFav6hHVDX9r4m4=;
	b=GwhEfiuPp6MoGGp1Aioj+7ur6yEcn+ocYBzCb30EQRLtAKMNNE8nxgFs4uK6/sg8culqeY
	L0aZ3xtr/LgxeGCJYsNXYUqxVlpHbHM0ncBUeyS3nntD4DBW+/OqgbBVP9xZpvFKLuiKMb
	rWMZp2AKBj8kGxEMWDnqJz6Dcqu9m+U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>, 
	Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Kalesh Singh <kaleshsingh@google.com>, 
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Matthias Brugger <mbrugger@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Miroslav Benes <mbenes@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 03/57] mm/memcontrol: Fix seq_buf size to save
 memory when PAGE_SIZE is large
Message-ID: <ghebtxz4xazx57nnujk6dw2qmskyc5fffaxuqk2oip7k2w2wuf@grnsquoevact>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-3-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014105912.3207374-3-ryan.roberts@arm.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 14, 2024 at 11:58:10AM GMT, Ryan Roberts wrote:
> Previously the seq_buf used for accumulating the memory.stat output was
> sized at PAGE_SIZE. But the amount of output is invariant to PAGE_SIZE;
> If 4K is enough on a 4K page system, then it should also be enough on a
> 64K page system, so we can save 60K om the static buffer used in
> mem_cgroup_print_oom_meminfo(). Let's make it so.
> 
> This also has the beneficial side effect of removing a place in the code
> that assumed PAGE_SIZE is a compile-time constant. So this helps our
> quest towards supporting boot-time page size selection.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

