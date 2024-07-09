Return-Path: <linux-kernel+bounces-245771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6072392B903
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2A31C22B63
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BB815884F;
	Tue,  9 Jul 2024 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OPpH0wBX"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CBC15539D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720526765; cv=none; b=mmDJEVm2Biy8MnuKFLtMiZVYxWkQD4vathjy7Ju8V9hjP6R9kjKCO+DCLtTGX63/MyxaDpzftZVDQwtmOr+yxKnPOApFultDZ24HBHBebnJw2xo73VrI2RYCQQb40Q3dav1ltFCuI7+RB64CYCqgC5OA3gzc8tytMGVGYPOS9a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720526765; c=relaxed/simple;
	bh=Ff9YVr9ZTVfakG8RF30eXXxluy+MDVrqXRuR75X1UYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/odp/LBCRLjV3fhRKZ0Umthgdtwl7UABbb+XOWK/kB+jh69bSaW0ut7bH0cc1m1v7OmfYfpDsqZ0pzwx/zeQHyoytQcS7fj8XBMi4dAqXCyu1hPy91I6yZApv7Go81BEsKV47ypmAFsZxEGftB1O2jIj1Q4UyoJIHgQRZxfWBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OPpH0wBX; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=A1a6mNxjrXYiDUQ6xEVhwNwKyFuN05lEwZNVF8nC/nE=; b=OPpH0wBX7xJ/hMsVBrLZvMUq2W
	BbsKkwh891JansKX2xRgzaBAJMmWxbdx+UmgqNKA8Lrq5TXKw2RkJwbEo3syupY4//vbV7BAtu8Q5
	lA1VMvy/HsqX/y661Q43vvXD+rRxxnrOcgqTRuJfKXErgiV69d5jvaffYfmc6sXfyDm1wCCi7fuGj
	2rlV5aXqdJo9ySzrw+3jeko4v75eAJJoY8LIkuNUCFQgEnE12N0CN5ACgNhCwoO+k+AfuOkpd1Mdb
	SY6wsFIH38RJQcFetgVCVbPGF9oJydHt24CZW1LARqm44gDW1bMiEcdxInBdnTiAd67NzkHvK4nCp
	TblOiLaA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR9bU-00000000kLK-0sYX;
	Tue, 09 Jul 2024 12:05:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7440E300BAE; Tue,  9 Jul 2024 14:05:51 +0200 (CEST)
Date: Tue, 9 Jul 2024 14:05:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org, andrii@kernel.org
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
	oleg@redhat.com, jolsa@kernel.org, clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 05/10] perf/uprobe: SRCU-ify uprobe->consumer list
Message-ID: <20240709120551.GK27299@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240708092415.695619684@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708092415.695619684@infradead.org>

On Mon, Jul 08, 2024 at 11:12:46AM +0200, Peter Zijlstra wrote:
> @@ -2087,14 +2092,19 @@ static struct uprobe *find_active_uprobe
>  	return uprobe;
>  }
>  
> +#define for_each_consumer_rcu(pos, head) \
> +	for (pos = rcu_dereference_raw(head); pos; \
> +	     pos = rcu_dereference_raw(pos->next))
> +
>  static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
>  {
>  	struct uprobe_consumer *uc;
>  	int remove = UPROBE_HANDLER_REMOVE;
>  	bool need_prep = false; /* prepare return uprobe, when needed */
>  
> -	down_read(&uprobe->register_rwsem);
> -	for (uc = uprobe->consumers; uc; uc = uc->next) {
> +	guard(srcu)(&uprobes_srcu);
> +
> +	for_each_consumer_rcu(uc, uprobe->consumers) {
>  		int rc = 0;
>  
>  		if (uc->handler) {
> @@ -2116,7 +2126,6 @@ static void handler_chain(struct uprobe
>  		WARN_ON(!uprobe_is_active(uprobe));
>  		unapply_uprobe(uprobe, current->mm);

   ^^^ this remove case needs more thought.

>  	}
> -	up_read(&uprobe->register_rwsem);
>  }


