Return-Path: <linux-kernel+bounces-316734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6650696D344
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D97F5B25EA2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739591990A2;
	Thu,  5 Sep 2024 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aEbdxmlr"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA51198E91
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528543; cv=none; b=YFKtLBVTnvXlGGIwpNA6bsmK+Bv1dGGa4pj8M1lYPgFjhBQ7CuxCPyM1uExI5wY9ZHTy///UEpvo3uJpCQE//s/B7Pp4sIUYoJpSy3uLR1kCECg6QBcxCdtRPDvFG55oL/S6rzduN1igyZJb/r8RHrMQoVPPiDaut5IIW/VHBEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528543; c=relaxed/simple;
	bh=JUEHiWAdWwGQ/BL4x9cIBosFyMZfvhfRulXe0jwh2vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ser9M8buzfncOQAIcQsrypD6uRy6OqFM38Ij3uNXFbB5d3egwJgF4My5TFJGA+It+MegJc69s2jc70ZTSS4lbQ07VxHYNOSX1AiMVDSUZ54jNLijLb18GCP8dh9NVupBsF3JlMTQVQyk6T/XIR89kWX/dEUek4ABR0//bZDeRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aEbdxmlr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X3PxmwvCvMvj2EWHZbGP77zKm9yvhP6DBzRGCEwrf+A=; b=aEbdxmlr9gXuZFJh+Wo4zvkqBH
	3ZzIJpeQCiTRWO8fmwqEx6VEvYe5DLtv/IzGHs8IIixI2lGx7pK6BTDgUU24AlajKKVKaIYmcQRil
	RL5xgXf6p1W1Wf1/fNvMZu70x4F+OmK/t3WHYTtJ97HJVH+5OW8m49gFr/x/oM+fMtbUda3sXs8t/
	XrybFce+ktGDRvcN9s6LRrAGBW9eliQJLKrMrZ/x/9Lj87sFTQqthIjfs9zqHq6yF9DH3KeAdMz1H
	qquExdiw2hEQHUxPGQIWjbhnPaXBWKWtR8Lx0RGWI2GTZaaBSL/MtcAlG4uBJEoh1MMtmKGqe07lZ
	BTyvnlgw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sm8nS-00000002AQP-1Uzf;
	Thu, 05 Sep 2024 09:28:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3FE1F300599; Thu,  5 Sep 2024 11:28:58 +0200 (CEST)
Date: Thu, 5 Sep 2024 11:28:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.12] sched_ext: Handle cases where
 pick_task_scx() is called without preceding balance_scx()
Message-ID: <20240905092858.GA15400@noisy.programming.kicks-ass.net>
References: <Ztj_h5c2LYsdXYbA@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztj_h5c2LYsdXYbA@slm.duckdns.org>

On Wed, Sep 04, 2024 at 02:47:03PM -1000, Tejun Heo wrote:
> sched_ext dispatches tasks from the BPF scheduler from balance_scx() and
> thus every pick_task_scx() call must be preceded by balance_scx(). While
> this usually holds, there are rare cases where a higher sched class's
> balance() returns true indicating that it has tasks to run on the CPU and
> thus terminating balance() calls but fails to actually find the next task to
> run when pick_task() is called. 

Oh cute. Which class in particular did you see this do?

Looking at balance_fair() / sched_balance_newidle() I suppose we could
verify we actually have a runnable task once we've re-acquired the
rq-lock and have pulled_task > 0.


Tightening all that up would probably be better than trying to deal with
the fallout like this, hmm?

