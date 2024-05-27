Return-Path: <linux-kernel+bounces-190660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CB28D0107
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20156288684
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A6B15E5D0;
	Mon, 27 May 2024 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bg34lXVZ"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C31015DBC1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716815719; cv=none; b=E6hdvxRXOYCXUsYJeJQUy+QWobn/de5UMA7DuwAOgBof6r4JgqTQC6R8185x0gt1m9ABJV8vknlxfY8XuwK5fBko36+rOtf2iUFynbAk7fB9NPvlbBCuEtMyIW/Gw5gaQjV/W6MUywjqW+HZeW4bEyeqDCogWJ6BDytQupHOm2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716815719; c=relaxed/simple;
	bh=0Edaju5pGvykmoU4M2lpA68ncguVXLIcSKHtJCJSkOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZHHZmRAmjSJIyRFtapkAfcQu42DR68z1RJLGoeQWi7W8C+BPlo60Jf+HkOT8tItW5gVyhogiLJOq/X4uswkJo0GWM7+0apd4qplTYWOtjtTeeSXgaTsf7Tm95+1sShMTGdtswLdzbzcDKczjpwKeOQmI8KcSoT4f6c1eH+5vos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bg34lXVZ; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vbabka@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716815714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fAbpqHYArlgEA4jndUz59wBOUYS1i0aiS/4KxphB4UI=;
	b=bg34lXVZhV597vXyWDG4RuvE8RbwP3Lwxz6YxhMDRmvdkRdQ9zgF/aLMSysVqr3vIk0XXR
	Gl7GlJa2JfxJLxT93Qf5EGxprVZuKjkPdnMvHnZdTW+x2+5yCkX/mTlIAoKjnOLWiYVP/N
	k1No0gau4uhxJvwiIcwpHCuAhrT+8SQ=
X-Envelope-To: cl@linux.com
X-Envelope-To: rientjes@google.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: surenb@google.com
X-Envelope-To: keescook@chromium.org
Date: Mon, 27 May 2024 09:15:10 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] mm, slab: don't wrap internal functions with
 alloc_hooks()
Message-ID: <gwbfutyz24pjzweivq7zhj6e3o3yngjcyk3zy4kletxskiizbg@nskn7qkayfig>
References: <20240527090127.21979-2-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527090127.21979-2-vbabka@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Mon, May 27, 2024 at 11:01:28AM +0200, Vlastimil Babka wrote:
> The functions __kmalloc_noprof(), kmalloc_large_noprof(),
> kmalloc_trace_noprof() and their _node variants are all internal to the
> implementations of kmalloc_noprof() and kmalloc_node_noprof() and are
> only declared in the "public" slab.h and exported so that those
> implementations can be static inline and distinguish the build-time
> constant size variants. The only other users for some of the internal
> functions are slub_kunit and fortify_kunit tests which make very
> short-lived allocations.
> 
> Therefore we can stop wrapping them with the alloc_hooks() macro.
> Instead add a __ prefix to all of them and a comment documenting these
> as internal. Also rename __kmalloc_trace() to __kmalloc_cache() which is
> more descriptive - it is a variant of __kmalloc() where the exact
> kmalloc cache has been already determined.
> 
> The usage in fortify_kunit can be removed completely, as the internal
> functions should be tested already through kmalloc() tests in the
> test variant that passes non-constant allocation size.
> 
> Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>

