Return-Path: <linux-kernel+bounces-404932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCE49C4A99
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC8D2885A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624DF1CCEF8;
	Tue, 12 Nov 2024 00:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wc68EVxw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87FF1CC89F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731370969; cv=none; b=VuL2VSIZYiK3x5BhuvxFV1kEJT/htI7W7/Wch6RjAW8wMfU2F7QPI1KCSJNxMtLxGctngNHL1SDD7003T65+z3gFOjkk21T2mXdGV4n9mjm++xDn95KZekjyDJMqa4ZchJRMIJhXWBRS8FV/ENRV9hlUtnXWYT96Fd8Slh8ymJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731370969; c=relaxed/simple;
	bh=Gak206jprJzht+wVQSXZ65xZetRhwpUjUYhF1HfBU9k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tj+LBGBjiJP68E4mUQQmBShjgWGp8zVjL5ivOQSekK/7ILkJIj+V79tpvVXCJkWSWt2jVODz/BQn5VAoM18OM5xRkV228JaFQzHyFKEtJD4YPec+UmVJEUtoN8WNmEQjyRAnfqNCkuoGxqj0b7ooMA/h7xQaFXFKmrELx7DFpzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wc68EVxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25096C4CECF;
	Tue, 12 Nov 2024 00:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1731370969;
	bh=Gak206jprJzht+wVQSXZ65xZetRhwpUjUYhF1HfBU9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wc68EVxw+hOZ8e92jgXhUlSL14mhN5WkRk6ZkQDEfeOX7LGKxyCqnW2vESpvqdias
	 auylJ8y5QPvO1sWnlAg/PiTCrqJPzyIkqwK/ABTdProIIhKVprmQMlFAweP7bGl15n
	 u2ftMGGTRtcZSRjYWB6lyRdC3Wyq+rxkbgkvKdQo=
Date: Mon, 11 Nov 2024 16:22:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qiang Liu <liuq131@chinatelecom.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mel Gorman
 <mgorman@techsingularity.net>, Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH] mm/compaction: fix the total_isolated in strict mode
Message-Id: <20241111162248.7af77e56c1ff4017d1ed4106@linux-foundation.org>
In-Reply-To: <20241102201621.95291-1-liuq131@chinatelecom.cn>
References: <20241102201621.95291-1-liuq131@chinatelecom.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat,  2 Nov 2024 20:16:21 +0000 Qiang Liu <liuq131@chinatelecom.cn> wrote:

> If the last cycle reads bogus compound_order() and blockpfn > end_pfn occurs,
> it is possible that total_isolated will be less than nr_scanned. In this case,
> strict mode should return 0, but the “if (strict && blockpfn < end_pfn)”
> statement cannot recognize this situation
> 
> ...
>
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -699,7 +699,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>  	 * pages requested were isolated. If there were any failures, 0 is
>  	 * returned and CMA will fail.
>  	 */
> -	if (strict && blockpfn < end_pfn)
> +	if (strict && (blockpfn < end_pfn || total_isolated != nr_scanned))
>  		total_isolated = 0;
>  
>  	cc->total_free_scanned += nr_scanned;

That's really old code.  What userspace-visible effects might this
have?  Is this from code inspection, or was some misbehaviour observed?

Thanks.

