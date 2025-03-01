Return-Path: <linux-kernel+bounces-540087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E38EA4AD7F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 20:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB50170767
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 19:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8351C5D4B;
	Sat,  1 Mar 2025 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDEIiCpu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5788BF8
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740856634; cv=none; b=T8zgRDYvYqv3Y7IIjJ8tlT4gJSE80FzPKBNUaR8RpsIumO6yRhs7lUHP2iF3Tzt6kvelISV5pmXQpMKTTpaMZyahHaZLIbe+I3EOjlBUoNdhSgvksZvaFrvd/AwwyQrIFD1vOXJxh7zXnRlaeGZerdqSSmvf3fZ55SGpw5MDyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740856634; c=relaxed/simple;
	bh=arzCbGNqszby1mlrkHcUjFa92ub/YHZsCV5NG6ycC4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1ov+UUMPT4SgBOoRsXN+8DB5xwetAJEus5PJt5D9CQ00JOLWmzZnsYuyNiG7d2zUweIhNmQOCv1eiSjHbE6NwC2noaJ+8u1RVXcWjqyJ1B8v/1djna3w11iw8NKpyGOFQgRu7SvIL5EiraLt/KconGWIZdqhcpN1bb5j49P7s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDEIiCpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C7FC4CEDD;
	Sat,  1 Mar 2025 19:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740856633;
	bh=arzCbGNqszby1mlrkHcUjFa92ub/YHZsCV5NG6ycC4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LDEIiCpuivq8fM9KqJdcGrpA4HYZ22MBzule9kpsSUXK6lalF8xbfmBv/ZNPKXve/
	 /tkKNUqo5HImVHaSww7goQAX9TjJYFqs6sLu2auHr4Y1SgNMgq+UE5ucd9o2v531tj
	 KRaRI6yxmTWLyyjGC97i1SU2o5YA2uNfHcDQG66Ilvlzq+FbfUKIxAhUSixbdrkcxx
	 DgfOWXVrbW953vV23EZlbHIxhA/ChS/OkU00P6mJSiNFsDtXmhEcT6S2I2BhBS0HaX
	 EAQLSM3LTyNza6Ms23/+fdl1Boe/Ft+nTCvtVRWbbnDXKk8pxocx3S8uOorydGjbob
	 w6/tWHd4AyxuQ==
Date: Sat, 1 Mar 2025 20:17:02 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
	willy@infradead.org, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Subject: Re: [PATCH 15/19] perf: Fix perf_mmap() failure path
Message-ID: <Z8NdLn_04_7XU_w_@gmail.com>
References: <20241104133909.669111662@infradead.org>
 <20241104135519.248358497@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104135519.248358497@infradead.org>


* Peter Zijlstra <peterz@infradead.org> wrote:

> When f_ops->mmap() returns failure, m_ops->close() is *not* called.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6830,7 +6830,7 @@ static int perf_mmap(struct file *file,
>  	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
>  	vma->vm_ops = &perf_mmap_vmops;
>  
> -	if (event->pmu->event_mapped)
> +	if (!ret && event->pmu->event_mapped)
>  		event->pmu->event_mapped(event, vma->vm_mm);
>  
>  	return ret;

I'm wondering whether this fix is still relevant in context of this 
recent commit:

   b709eb872e19 perf: map pages in advance

Thanks,

	Ingo

