Return-Path: <linux-kernel+bounces-382958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D639B1587
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 08:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB18B21D8F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 06:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C7E178CDE;
	Sat, 26 Oct 2024 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RzZ6/Zkd"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591F429CE5
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729925586; cv=none; b=aUckPNlzxeEmWstg4ejLjCafk/5f4nnm7HAy8kRdwQGMfqtlP1vzX5cBhLuj3cxZmU/W5Sl20mK0Acp9XBGs2Q5eu9Af8AxyGBJgy/SpVzWt0dUpTVI+ffgLoUjSJ+yh1ZNj7wtfyjUVwyVimOXuef0+2hPvpovs+A/l3FaQchM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729925586; c=relaxed/simple;
	bh=ZTIzSM+dpOCFgf5amgskOkbDlN9zAVYKRWXpObWLjno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqPGXA3Eldi9a7etaNwJkJn3y4F3Pvt5LnkCpZgG/UkEW1o4ZGOvywuAb6zigKsY3MVFVrSyj6OgZ8fH0tFYxf43Qi5/QDiyno5qo6QaEzKOEcUM7rPg49xEpsStTiQOpx4g2x0i5uR4pABjPpN0buzrea/6aKwB2pO4NvVdH0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RzZ6/Zkd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/OW7JKV1HD4IXGnfim+MowZqGhPTWggQ3xAZ0PJl0Pg=; b=RzZ6/ZkdhnoQqZwBxmKQkGtTar
	ARiL/gs2XopXjq+au47U9+lqp47g+RtMxD/sryR/xHEsxBauktSPPDo8IYS8xjLEaLiSrPhmKbkG6
	HHPCuUrZO6Am8A1y8j6YSHsjb8H7EnACz+oWZZdEsoim9IlorkDInzkTGqC0HlYGySKc1HmpqzzUo
	KV8mNJUJxu2fQ4ODTqDxNwHyiHI8w/QXSAgqmsp9c8a5Qpb5KZFr+r/umNYJ7XBzKENTIcd3DL05C
	TK5flVpyPP9XgcJLIchAmoNjLsaNMtgk5W2CSU3ExpEPinEWrifd2uu7eaGIvxZJhiOfmt+hyBzAj
	9uxM6rlQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4afI-00000009CQf-3mHX;
	Sat, 26 Oct 2024 06:52:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 12EE6300777; Sat, 26 Oct 2024 08:52:48 +0200 (CEST)
Date: Sat, 26 Oct 2024 08:52:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, void@manifault.com,
	vincent.guittot@linaro.org, juri.lelli@redhat.com, mingo@redhat.com,
	bsegall@google.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
	vschneid@redhat.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Pass correct scheduling policy to
 __setscheduler_class
Message-ID: <20241026065247.GG9767@noisy.programming.kicks-ass.net>
References: <20241025185020.277143-1-aboorvad@linux.ibm.com>
 <ZxvxR32TQ1UIVLtS@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxvxR32TQ1UIVLtS@slm.duckdns.org>

On Fri, Oct 25, 2024 at 09:28:07AM -1000, Tejun Heo wrote:
> On Sat, Oct 26, 2024 at 12:20:20AM +0530, Aboorva Devarajan wrote:
> > The function __setscheduler_class determines the appropriate
> > sched_class based on the scheduling policy and priority. Previously,
> > the function used the task's pointer to retrieve the scheduling policy,
> > which could lead to incorrect decisions if the task's struct had an
> > outdated policy. This behaviour where the task pointer may reference an
> > outdated policy when __setscheduler_class is called, was introduced in
> > commit 98442f0ccd82 ("sched: Fix delayed_dequeue vs switched_from_fair()")
> > 
> > To resolve this, corresponding scheduling policy is passed directly
> > to __setscheduler_class instead of relying on the task pointer's cached
> > policy. This ensures that the correct policy is always used when
> > determining the scheduling class.
> > 
> > -------------------------------------------------------
> > Before Patch:
> > -------------------------------------------------------
> > 
> > ```
> > sched_ext # ./runner -t init_enable_count
> > ===== START =====
> > TEST: init_enable_count
> > DESCRIPTION: Verify we do the correct amount of counting of init,
> >              enable, etc callbacks.
> > OUTPUT:
> > ERR: init_enable_count.c:132
> > Expected skel->bss->enable_cnt == num_children (3 == 5)
> > not ok 1 init_enable_count #
> > =====  END  =====
> > 
> > =============================
> > 
> > RESULTS:
> > 
> > PASSED:  0
> > SKIPPED: 0
> > FAILED:  1
> > ```
> > -------------------------------------------------------
> > After Patch:
> > -------------------------------------------------------
> > 
> > ```
> > sched-ext # ./runner -t init_enable_count
> > ===== START =====
> > TEST: init_enable_count
> > DESCRIPTION: Verify we do the correct amount of counting of init,
> >              enable, etc callbacks.
> > OUTPUT:
> > ok 1 init_enable_count #
> > =====  END  =====
> > 
> > =============================
> > 
> > RESULTS:
> > 
> > PASSED:  1
> > SKIPPED: 0
> > FAILED:  0
> > ```
> > 
> > Fixes: 98442f0ccd82 ("sched: Fix delayed_dequeue vs switched_from_fair()")
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Peter, do you want me to route this patch or would tip be better?

Once I've figured out what the word soup means and reverse engineerd
what it actually does I'll probably take it :/

That Changelog is horrible

