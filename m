Return-Path: <linux-kernel+bounces-382514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3549B0F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61CA21F233C5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA5A20EA4F;
	Fri, 25 Oct 2024 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhSLkAMj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0BB18F2C3
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729885152; cv=none; b=NK2ncRUwaHD9cdAEUzgqEIEsbPhSrElI0ulBZTFBkb7aobWMoqbQIL/Bb78xzdBh4u6yyMDqysFsA8CLAMSlPt78c+kgWexTLskCX2bRW5FKOc8q/Rg0EMbcBqR7qyjQ1db5TPQXI7x6J02Vce2UjOd2rs0IAwXgwmen12IZgac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729885152; c=relaxed/simple;
	bh=5KKGz4yw9dGRnMnqC1INz+kjnWf0FBT1WE3Oy41SNes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsNue+ChGKM624TCAKu+L63wETVMljcmSv6bL1cqVkiWIcjHoM1UYufi6jBMxZXVulpvjs0i+m1O7BbtZCz1B+2xyW/DKZllQcSc8Q3rZlycXLbOy3oheufN2bohDF0oCjniLV3oOT0Q/uuigcRemqeHvd1KwgYm5QFiibwKL4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhSLkAMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71331C4CEC3;
	Fri, 25 Oct 2024 19:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729885151;
	bh=5KKGz4yw9dGRnMnqC1INz+kjnWf0FBT1WE3Oy41SNes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FhSLkAMjnrWfazHyNvrpkdLRnlvAlNbCyO1spS4ZBlYEj6Ik4ZwXKekcmtmELFWYM
	 iKUOHYjZMKG9wkZ6MI/jOeMibfPtopztpxSsVFUm+dok5ohHgZN95KcT23jjqebTKy
	 7e3D1lNldAb+XRpFHeG9fifqbAt1EiRP9YIZ/fHUK8SO1rexWN+gNER+5uFEmgrIfX
	 InZ9AKzuW8uBHQWXCsrqYSn2q2UID+FXxfDcBffRFRLpwgY1g0l6QRBCF2M5OtjmNy
	 gK41mof2BFIpn6VHamHyZX95a+vl1lf7PpSkSv5TMetOWP/Kg1OO6YLmwoEbpVis1h
	 +lLhDhBIFUnBQ==
Date: Fri, 25 Oct 2024 09:39:10 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: sched-ext@meta.com, kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] scx: Fix raciness in scx_ops_bypass()
Message-ID: <Zxvz3mlxRm-BxuJW@slm.duckdns.org>
References: <20241025054014.66631-1-void@manifault.com>
 <20241025054014.66631-2-void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025054014.66631-2-void@manifault.com>

On Fri, Oct 25, 2024 at 12:40:14AM -0500, David Vernet wrote:
> scx_ops_bypass() can currently race on the ops enable / disable path as
> follows:
> 
> 1. scx_ops_bypass(true) called on enable path, bypass depth is set to 1
> 2. An op on the init path exits, which schedules scx_ops_disable_workfn()
> 3. scx_ops_bypass(false) is called on the disable path, and bypass depth
>    is decremented to 0
> 4. kthread is scheduled to execute scx_ops_disable_workfn()
> 5. scx_ops_bypass(true) called, bypass depth set to 1
> 6. scx_ops_bypass() races when iterating over CPUs
> 
> Fixing this is difficult because we can't take any locks when enabling
> bypass due to us not being able to trust the BPF scheduler. This is

We can't use mutexes but can definitely use raw_spinlocks.

> problematic, because what we really need to do is coordinate between
> possible concurrent calls of scx_ops_bypass(true) and
> scx_ops_bypass(false), but the whole point of that code is that we can't
> use any locks to coordinate. Instead of taking a lock, however, we can
> instead just serialize the calls to enable and disable bypass by executing
> the calls on the scx_ops_helper kthread that's currently responsible for
> disabling a BPF scheduler.
> 
> This patch therefore adds a new schedule_scx_bypass_delta() function which
> schedules changes to scx_ops_bypass() to occur on the scx_ops_helper
> kthread (where necessary).

Can't we just add a static raw_spinlock to protect scx_ops_bypass() body and
maybe turn scx_ops_bypass_depth into a regular int while at it?

Thanks.

-- 
tejun

