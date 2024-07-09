Return-Path: <linux-kernel+bounces-246143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DD192BE14
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1C11F267C0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D1519D070;
	Tue,  9 Jul 2024 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rHwlgYt6"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7B1158856
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538381; cv=none; b=Qy1B08gQqW5VbTEaAMFz+Z19Y+Qy3xlnuRxVzy4PFjTKFg00t7Y3xgWCjihK5fNNv3JSlEMrgISW9LaBULartA0wRAQ+4lSGEB13aszNIy0alfizZgKYNFdKtlU6cOCT0iIG/hspIm4vJvrreYn8GpoHAVkJQYnHSoRvgnTdsqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538381; c=relaxed/simple;
	bh=Za0iYoDZtXrhZkU6J0y11DQ0mZSHEd0squM3u4ZrClI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7j8Rtfm2nYC8sdigzPptj5cUknHaon/LkiDieHhJ2EoJ2GHyCxq7QfJNdfHMSi+63JKgavXBcmbEiYmYBnOLWok1c9XZK5pC0d9ihLUM09BFmUdBDN6b4u+yITkB+NtLDMeYQqOIPF6xiGTU9E43T1KqNHGaOqwrLzwVGsvvi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rHwlgYt6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vF850aqi5YOSbmlMGrkIhXYLdwCC0shPhL7R27Z0uxc=; b=rHwlgYt6u7CtB0due23iaApxNz
	JZFU5w9FsirOIRopgpNk5RiH6e2uvaxNHhaOqczSYR8pf7uDRlFLJfNTnhJF+Zo5UrW1p6c//OjVs
	vYEC/Qe6uqs90AOz4fG3YZhLafp2srML3T4AWVBrPKB2mQH1x7e8Fe0q+8RxYRfWoGTndMqxQlU3h
	cCIA3v1SrHTLJ54qNtOvWamRsLMGSiPc+G+utPGXQZ4aj4CiNi9W7uuuwXxLj1w1ioMEeKyVIJoRp
	GRIzv4NGU6YXJ5yq93lP5FvsGn1teewmRRj8eV3zy7fsavAI4IanfiESToPvAdqZE4o2kdjjHcXAy
	w1FGQD+g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRCct-00000000lPs-1Uiy;
	Tue, 09 Jul 2024 15:19:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5FB113006B7; Tue,  9 Jul 2024 17:19:30 +0200 (CEST)
Date: Tue, 9 Jul 2024 17:19:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 05/10] perf/uprobe: SRCU-ify uprobe->consumer list
Message-ID: <20240709151930.GP27299@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240708092415.695619684@infradead.org>
 <20240709120551.GK27299@noisy.programming.kicks-ass.net>
 <20240709133349.GC28495@redhat.com>
 <20240709143218.GM27299@noisy.programming.kicks-ass.net>
 <20240709150504.GF28495@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709150504.GF28495@redhat.com>

On Tue, Jul 09, 2024 at 05:05:04PM +0200, Oleg Nesterov wrote:


> To simplify, suppose we have a single consumer which is not interested
> in this task/mm, it returns UPROBE_HANDLER_REMOVE.
> 
> For example, event->hw.target != NULL and the current task is the forked
> child which hits the breakpoint copied by dup_mmap().
> 
> Now. We need to ensure that another (say system-wide) consumer can't come
> and call register_for_each_vma() before unapply_uprobe().
> 
> But perhaps I missed your point...

Ooh, I see. I failed to consider that particular case. This is
interleaving uprobe_register() and handler_chain(). Silly me only looked
at uprobe_unregister() and handler_chain().

Hmm, easiest would be to add a seqcount to register_mutex and simply
skip the remove case when odd.

Then the handler might get a few extra (unwanted) calls, but it should
be able to handle them, they're fundamentally not different from the
first one where it says REMOVE. Right?

