Return-Path: <linux-kernel+bounces-362733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E98699B8C4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 09:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F252824B7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 07:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACC313AA35;
	Sun, 13 Oct 2024 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Iomn/F5+"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB49A13A86A
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728806184; cv=none; b=JNSgw6nKa+1hC25+dsGLMP0AgT/x0j6bkUznsQl1Z2dekm5L6EpsiBdxsdTYdPFyQH15BWguyPoXRN2ngFcmtiWSuG5mqIAdbfq811UBxS677LiH1RKJB/LV7NosQzmQ70tBAyQ4dfGFjX65dDX+dRXec6myJHeN+6QGTAZ7E6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728806184; c=relaxed/simple;
	bh=ygv6Rjo/akqa6GI3ENYC5nxH1I3ib6XgzTkksQA8OQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6CiAI3QOc/vQnNLlo7TEOiLK+dIxD6XoyEYtJulhHsQga95Mz/8wa2L16CJUfcesAfWuaiX4Evlky4Kv44/Z7/wYAodYK2jmXhbSCRdLnK3r7eM/YbeLtisz8pCng9p0cXP3JepCyhQAHyPkcY4gBheStX6DeWgKilmOaPwwFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Iomn/F5+; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 13 Oct 2024 00:56:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728806176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D0UXcPMAQT863fxE4oQ4MKBp1lB0tO0dk2FFTCPvlSg=;
	b=Iomn/F5+0IbVe9vPsCt6+XNegFm9DNq5lMEs2+zgyH9i5XOVeX7QKHF5n4be2iaQZPTtgx
	9mtfJmlXtGjkfSbxNFNZsYlW4VWzbMrugNJaow6+tl7D16Q32YKmL7VLxtlj98fYMdHCrh
	3BQtze4tvpI5QIqJthFZdCdYyOvSn6A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	akpm@linux-foundation.org, mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, 
	mhocko@kernel.org, vbabka@suse.cz, hannes@cmpxchg.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com
Subject: Re: [PATCH v3 tip/perf/core 1/4] mm: introduce
 mmap_lock_speculation_{start|end}
Message-ID: <haivdc546utidpbb626qsmuwsa3f3aorurqn5khwsqqxflpu3w@xbdqwoty4blv>
References: <20241010205644.3831427-1-andrii@kernel.org>
 <20241010205644.3831427-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010205644.3831427-2-andrii@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 10, 2024 at 01:56:41PM GMT, Andrii Nakryiko wrote:
> From: Suren Baghdasaryan <surenb@google.com>
> 
> Add helper functions to speculatively perform operations without
> read-locking mmap_lock, expecting that mmap_lock will not be
> write-locked and mm is not modified from under us.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Link: https://lore.kernel.org/bpf/20240912210222.186542-1-surenb@google.com

Looks good to me. mmap_lock_speculation_* functions could use kerneldoc
but that can be added later.

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>


