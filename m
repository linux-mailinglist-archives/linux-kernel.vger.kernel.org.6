Return-Path: <linux-kernel+bounces-354125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3E9993815
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C63FB22286
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74911DE4DA;
	Mon,  7 Oct 2024 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6s72RTu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4842F81727
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332426; cv=none; b=Ltxjkal+FIPL7grSf1aHg6ViRivTRSegB/erai4o7ThJV4JVz53fhHWdc1Lp9s6NmbmB7iFjA49IxifMTD/fYuCATaLpeYM7WKHFfchSh9nr84yWlL7CWyLXFvY4t/ifDOFL1bKUdK1LAMa4XNEnC8DaeJYHLMssyEDkTOv/qjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332426; c=relaxed/simple;
	bh=EgSfqyvN9ek1mlSGDVahGdP3YsJgNByFt+mLCzx71V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAucSrgaWp9iNCAHv6jiddDNeGSAVTcTcsaqRJK/HaSjOQjwKym5zyRF71cjSVK9cdhdW7g8r2RYeYuQAhRRYgPgodCgxtToD+DKm8FZsctP1fZ9eek7iOcZwHKl1o4S0Rmf9Rk6wO6QgjUxneDRywl2/mS09IUNDL9WtSJziF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6s72RTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF184C4CEC6;
	Mon,  7 Oct 2024 20:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728332425;
	bh=EgSfqyvN9ek1mlSGDVahGdP3YsJgNByFt+mLCzx71V0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f6s72RTuMC+QkJePD6IBp+vWwmtlScA65hHx3XEHvGS9XnQlzNiHI8WkZ4/2pPz3+
	 FqLgeA2Ao/3jHLmN9tx2vzZ/rJWSPCQAMbFWzZ4TxeceRqJkty8MlfqkQKp32dgHW6
	 WhUp73xh5aa74avdGtqVeSMgSbEkvFzPVPkaqNDbXFfmbWJTqEiDcGgLW9AhzsHO5T
	 4jtMECqhcH2tdRG4qJjtyRG110lgho76TAd9bPq4DuJMsj5Ms0eVvAERkJ2g4trveJ
	 Z4Qn3KhyRkRksa9c8vUyeStwK8kEDSIhYzYxETrWPROK3Fl7LLPSdo3qIbWbzP4WO6
	 OkZ+A6/8abG1A==
Date: Mon, 7 Oct 2024 10:20:24 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com, peterz@infradead.org, mingo@redhat.com
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCHSET sched/urgent, sched_ext/for-6.12-fixes] sched/core,
 sched_ext: Add ENQUEUE_RQ_SELECTED to fix ->select_task_rq() skip detection
 in sched_ext schedulers
Message-ID: <ZwRCiCnaKWqgQyRz@slm.duckdns.org>
References: <20240927234838.152112-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927234838.152112-1-tj@kernel.org>

On Fri, Sep 27, 2024 at 01:46:10PM -1000, Tejun Heo wrote:
> During ttwu, ->select_task_rq() can be skipped if only one CPU is allowed or
> migration is disabled. sched_ext schedulers may perform operations such as
> direct dispatch from ->select_task_rq() path and it is useful for them to
> know whether ->select_task_rq() was skipped in the ->enqueue_task() path.
> 
> Currently, sched_ext schedulers are using ENQUEUE_WAKEUP for this purpose
> and end up assuming incorrectly that ->select_task_rq() was called for tasks
> that are bound to a single CPU or migration disabled.
> 
> This patchset adds ENQUEUE_RQ_SELECTED to indicate whether
> ->select_task_rq() was called to ->enqueue_task() and propagate that to
> sched_ext schedulers so that they can reliably detect whether
> ->select_task_rq() was skipped.
> 
> Peter, please let me know how 0001-0002 should be routed. If they get
> applied to sched/urgent (when it opens), I'll pull it into
> sched_ext/for-6.12-fixes and apply 0003 on top. If you'd prefer, I can take
> all three through sched_ext/for-6.12-fixes too.
> 
> This patchset contains the following patches:
> 
>  0001-sched-core-Make-select_task_rq-take-the-pointer-to-w.patch
>  0002-sched-core-Add-ENQUEUE_RQ_SELECTED-to-indicate-wheth.patch
>  0003-sched_ext-scx_qmap-Add-and-use-SCX_ENQ_CPU_SELECTED.patch
> 
>  0001-0002 are sched/core patches to add ENQUEUE_RQ_SELECTED.
> 
>  0003 makes sched_ext propagate the flag as SCX_ENQ_CPU_SELECTED and fix
>  scx_qmap using the new flag.

Applied 1-3 to sched_ext/for-6.12-fixes.

Thanks.

-- 
tejun

