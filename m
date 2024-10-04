Return-Path: <linux-kernel+bounces-351399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8750991063
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F151C22A14
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123001DE2A5;
	Fri,  4 Oct 2024 20:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPNPwFTX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BCE1DD9DA
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 20:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072861; cv=none; b=K1AA4tt7yRBPCYhXfl2VckHY1B8LCtsugFVTS7zrTysolGvHdkYwmdkxGP95k7tYxsTfrEfjACxcwWNOG4kQRObkUC5oDjnzvAmCy4Gz/F5yx+wkGWGbeZEVOeYw370jP5tZhaPuFVO3J0JbvM1y8D96YOhU6xH3pbVtu/kVAWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072861; c=relaxed/simple;
	bh=UVZ2vItyh4dbaOc5QgEB5KhIQD75bcee2IDNg9UnMno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVAoluV3f8+eQJh4eTijO01aWUsHjlqhwxP9Kw2tqvottqecqDtxJCUvR4a2BkmzGByNI+Sivz/cHvb6qwpE0dD9LWuhCZxe/+p9FcKt2/37ov0ITGUuNS5R6SH4SaIfsQ05a2HIRR6DmzsKFMXoAa4gHCCtRZmEhIpTOngG+xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPNPwFTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8D6C4CEC6;
	Fri,  4 Oct 2024 20:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728072861;
	bh=UVZ2vItyh4dbaOc5QgEB5KhIQD75bcee2IDNg9UnMno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uPNPwFTXrnlghqWIObn8RE1M+cVHl3NXqfU0T+s+G0nzJr6JxiXWEZ+Uz6pCYOs9T
	 0h0G7VqO5Rbl3zxrw00dSmcrk5VGlyLlfRlOIKhBSMoGGswcrGsUNPTZ8RwucDpp+Z
	 J9O/+NlLLegDLzXoqBkzfIrbrN67Q5fr55nux8Y7e1IRW5+XdUsJejxyaPlJxCCvR8
	 OOpK6Xf2iSArczixYgjz+OkDaNCc54kTTrP9aC68jamj7NhfRAVzD1kdXXougEj+9s
	 Xiffs4efQL4j84gzDEhM1WLUSXdEwggWPgQWoznIG/cxxtg9PrtYdjNA+owXxh/ZAL
	 JsSleluVFwm0g==
Date: Fri, 4 Oct 2024 10:14:20 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com, peterz@infradead.org, mingo@redhat.com
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 2/3] sched/core: Add ENQUEUE_RQ_SELECTED to indicate
 whether ->select_task_rq() was called
Message-ID: <ZwBMnL55W1qfcjwc@slm.duckdns.org>
References: <20240927234838.152112-1-tj@kernel.org>
 <20240927234838.152112-3-tj@kernel.org>
 <ZvxXxT8Lc0u9dTLo@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvxXxT8Lc0u9dTLo@slm.duckdns.org>

On Tue, Oct 01, 2024 at 10:12:53AM -1000, Tejun Heo wrote:
> On Fri, Sep 27, 2024 at 01:46:12PM -1000, Tejun Heo wrote:
> > During ttwu, ->select_task_rq() can be skipped if only one CPU is allowed or
> > migration is disabled. sched_ext schedulers may perform operations such as
> > direct dispatch from ->select_task_rq() path and it is useful for them to
> > know whether ->select_task_rq() was skipped in the ->enqueue_task() path.
> > 
> > Currently, sched_ext schedulers are using ENQUEUE_WAKEUP for this purpose
> > and end up assuming incorrectly that ->select_task_rq() was called for tasks
> > that are bound to a single CPU or migration disabled.
> > 
> > Make select_task_rq() indicate whether ->select_task_rq() was called by
> > setting WF_RQ_SELECTED in *wake_flags and make ttwu_do_activate() map that
> > to ENQUEUE_RQ_SELECTED for ->enqueue_task().
> > 
> > This will be used by sched_ext to fix ->select_task_rq() skip detection.
> 
> Peter, ping on patches 1-2. If they look okay, I can route them through
> sched_ext/for-6.12-fixes.

As the core changes are on the trivial side, I'll wait till early next week
and route them through sched_ext/for-6.12-fixes. Please holler for any
concerns.

Thanks.

-- 
tejun

