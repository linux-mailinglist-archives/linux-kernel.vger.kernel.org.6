Return-Path: <linux-kernel+bounces-558419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97054A5E5A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4683B0AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF121EE7BC;
	Wed, 12 Mar 2025 20:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eIkdQi1k"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAF13D81
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812749; cv=none; b=IidSptabzdoMyWi7ngvhaLOi82+Fi4p0cGsWs3aVxPE5nNt/g1cCmvbqNLdQ8g+qo7n5HXo1MpFeIlHoyTuYxPiYzFIjAvmVjpOKLifSW8bOIEzygPTODFFlyZ4JN4+9MC5YrrAIZQRGBIHu+Jqa8rdoLQylxAbG3n8aZnT86D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812749; c=relaxed/simple;
	bh=ir2UybPUqCKYV9t3MSFSJiPzuTBrAAz14LckMHOB4IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIRFP+SuvU5jNtrPFmQtZtR3taEA26gHYRmUjBhIziHYLG5XGkB2NSu6Z63XorBxwTroS3lY+WiucRGpDneqLL0q6KB6a7bB8tgpOVjQy9nzV6N9H0AStZtEPOpLLq8Z99DSDUSplTn/DY3tFheX9vdDH0Uz+T17s8UuhsEt3fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eIkdQi1k; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 12 Mar 2025 13:52:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741812744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U0xZZm/MliMhDloN5dyyQOH2WRuwx6QmF4AcEDs+rzY=;
	b=eIkdQi1kwcAGaEi9IHef/FQl3k+1zNdGSvIN0X/haUAVj7yGFrhN+HnstIuuspDmzDHo9C
	e8nJzDhVfbOy4cJXSmjtb/HL4sMs9XZ4kLCci8aAt5uBmbncpklHHUjQ9WaEAVVwTU2Rzr
	73DEzT8r2EX2yUjkYaI79skssXDyhjE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <howlett@gmail.com>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm/madvise: use is_memory_failure() from
 madvise_do_behavior()
Message-ID: <5mgpezzqrr6xzmp6w27ggmv4f2gydyeuhejwmnxsvcw43mcf5x@rxw2zcnjqfuc>
References: <20250312164750.59215-1-sj@kernel.org>
 <20250312164750.59215-2-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312164750.59215-2-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 12, 2025 at 09:47:47AM -0700, SeongJae Park wrote:
> To reduce redundant open-coded checks of CONFIG_MEMORY_FAILURE and
> MADV_{HWPOISON,SOFT_OFFLINE} in madvise_[un]lock(), is_memory_failure()
> is introduced.  madvise_do_behavior() is still doing the same open-coded
> check, though.  Use is_memory_failure() instead.
> 
> To avoid build failure on !CONFIG_MEMORY_FAILURE case, implement an
> empty madvise_inject_error() under the config.  Also move the definition
> of is_memory_failure() inside #ifdef CONFIG_MEMORY_FAILURE clause for
> madvise_inject_error() definition, to reduce duplicated ifdef clauses.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

