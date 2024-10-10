Return-Path: <linux-kernel+bounces-359792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA389990CE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C488B24718
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B5D20495D;
	Thu, 10 Oct 2024 18:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUuHVdyw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AEE204951
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584788; cv=none; b=jKdPCqLI2zXkuRDgrxqcc9WFaXg/19ycQs5eZn3iiA+oSDlQW0tysq1XldvIqEYAorpRfgb71aZqFHiWfoEwqRQQBnqPVkcrGFt2gO3a5WL6h+p821CbW3PgUPp/uSb4wevKof2rw14g0k6xgYN8Zip0HZ89c5wUb13W01LlFwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584788; c=relaxed/simple;
	bh=8M8suMv1958pZkk9AREkmQqkHJzo7PHONQFvywOHVYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5HHQrwH+BGvPtiP1EXyYeteJgmLJZwpuiKV+slF+pUN1G3C0m15hEZN7bd3OjIoVJOFOwwgnuoDZCpglVyXIBjD6nMxbOp9cfV4P5qCFrb6WIO6EuW9GHwscFUAZ2Nt0ACeXRGYSKLpRB3LH9+KnyfBVI/8cNJsiE5jSK3K0Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUuHVdyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26260C4CEC6;
	Thu, 10 Oct 2024 18:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728584788;
	bh=8M8suMv1958pZkk9AREkmQqkHJzo7PHONQFvywOHVYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUuHVdywg3hJb6yYRZAa5/0DN+aA9ZGoiVYuMWhywOkGCNLFltVpVj+i/r5km0VMS
	 /jq94AVki99QSowao/+jny823yW4DiKkoAxHCpGXldPivlMoNxDjpYYDDLXxB6849A
	 rUAnPTF+BM6YBeCoGYFYiIVq2m8oxJjLx+g143qCSF69fPW0njz+OtFOAWdPrscgaF
	 stMNoiobscg8xXNpPIRAlHlYQsu9iXc/fk58Zj5QL+9DqxXjEkGsAXtB0uueREpLik
	 oMC2XHcSgTtxFZFJ7gPwsVe30LgmMsZVYzsmmzzr0dY1prID0kOdNq6XIXyHTTQSvG
	 0gxqI/TV1Aadw==
Date: Thu, 10 Oct 2024 08:26:27 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 4/6] sched_ext: bypass mode shouldn't depend on
 ops.select_cpu()
Message-ID: <ZwgcU6PKOYMP83MC@slm.duckdns.org>
References: <20241009214411.681233-1-tj@kernel.org>
 <20241009214411.681233-5-tj@kernel.org>
 <20241010181517.GC28209@maniforge>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010181517.GC28209@maniforge>

Hello,

On Thu, Oct 10, 2024 at 01:15:17PM -0500, David Vernet wrote:
> On Wed, Oct 09, 2024 at 11:41:00AM -1000, Tejun Heo wrote:
> > Bypass mode was depending on ops.select_cpu() which can't be trusted as with
> > the rest of the BPF scheduler. Always enable and use scx_select_cpu_dfl() in
> > bypass mode.
> 
> Could you please clarify why we can't trust ops.select_cpu()? Even if it
> returns a bogus, offline, etc, CPU, shouldn't core.c take care of
> finding a valid CPU for us in select_fallback_rq()?

For example, if select_cpu() returns the same CPU for all threads on a
loaded system, that CPU can get very overloaded which can lead to RCU and
workqueue stalls which can then cascade to other failures.

> Assuming we really do require a valid CPU here in bypass mode, do we
> need to reset the state of the idle masks for the case of
> !scx_builtin_idle_enabled? The masks won't necessarily reflect the set
> of online CPUs if we haven't been updating it, right?

I think resched_cpu() after switching each CPU into bypass mode is enough.
That guarantees that the CPU leaves the idle state, clearing the idle state
if set, and if the CPU is idle, it goes back into idle, setting the bit, so
at the end, it ends up synchronized.

Thanks.

-- 
tejun

