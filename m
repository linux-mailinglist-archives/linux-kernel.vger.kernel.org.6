Return-Path: <linux-kernel+bounces-323851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C738197443A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718AF1F259F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41C11A38EB;
	Tue, 10 Sep 2024 20:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QovPZO2H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CFE175D3F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001054; cv=none; b=cHQM/yXZDhp8E/2/sNi20MLHBdiqYRhZCXl7OTAT06jjzrzvzhtAWcZc9a3hkUylvtZtwW56eWF0f3/9d8hAU2lffbFuLz9gGys0fAMUBz22Ya44acY7Ne5G3/DsBI0elv8TCF3/a1nDvV75eYGoUyBKD6MmgQGTIa4LY1s5NwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001054; c=relaxed/simple;
	bh=vQbiKaGFECv1p30qesfjYFhq6XZ+Qub11C5vey4D4uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hf0R7QuacJMsX04ZRfQUIknCBwDfnVEKNgurL3mWyffTgl2LM+MDqhnnIwBBRp5ipiFPqXJ1gsmcOj3xo7KVP5+kkEhWyh4thWk0V5SO6ZIpU+FHUcehVKkpc7N6vLE8qMw48aCzUYJBiQcn9vbGggTIlfLKhUX8o1bubjXl6oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QovPZO2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A555EC4CEC3;
	Tue, 10 Sep 2024 20:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726001053;
	bh=vQbiKaGFECv1p30qesfjYFhq6XZ+Qub11C5vey4D4uU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QovPZO2HdOBnKzP4Fp1KYqi0LFL25Fcs9GFAp4ChMOGKjzMbyR1TqDRsjSva53T1f
	 noVw9vHLNSaC3T+WOKVAng4vGQs6CYDfNpdlKjsy4b+8Pt2CDT5jOrUP1wRTbHbvYZ
	 ACx8caMKr9zkpDvKKPC7sVxJ0R4/0BWO4Ql6tBSZz4bIlbDHZ5Ah+LHrGOGmMigzMU
	 T9/CKjqbZ4CKLbmS2OTNRvJ/FWtIQia0CKb/3t0NG8menrZSDyS5Bt4U54iq22y0BX
	 QFvsnzhlP1dTd7kfOa5/do2LAeFxSK4IPknKJEj/VMXehdKVRcIqwTT6r4bLDBjjhW
	 4rrnn2KAIjuSA==
Date: Tue, 10 Sep 2024 10:44:12 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 sched_ext/for-6.12] sched_ext: Synchronize bypass
 state changes with rq lock
Message-ID: <ZuCvnJWtu0EI6DKe@slm.duckdns.org>
References: <Zt9pIAw06q_TZBoY@slm.duckdns.org>
 <Zt-E5mwbfoJgcBtX@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt-E5mwbfoJgcBtX@slm.duckdns.org>

On Mon, Sep 09, 2024 at 01:29:42PM -1000, Tejun Heo wrote:
> While the BPF scheduler is being unloaded, the following warning messages
> trigger sometimes:
> 
>  NOHZ tick-stop error: local softirq work is pending, handler #80!!!
> 
> This is caused by the CPU entering idle while there are pending softirqs.
> The main culprit is the bypassing state assertion not being synchronized
> with rq operations. As the BPF scheduler cannot be trusted in the disable
> path, the first step is entering the bypass mode where the BPF scheduler is
> ignored and scheduling becomes global FIFO.
> 
> This is implemented by turning scx_ops_bypassing() true. However, the
> transition isn't synchronized against anything and it's possible for enqueue
> and dispatch paths to have different ideas on whether bypass mode is on.
> 
> Make each rq track its own bypass state with SCX_RQ_BYPASSING which is
> modified while rq is locked.
> 
> This removes most of the NOHZ tick-stop messages but not completely. I
> believe the stragglers are from the sched core bug where pick_task_scx() can
> be called without preceding balance_scx(). Once that bug is fixed, we should
> verify that all occurrences of this error message are gone too.
> 
> v2: scx_enabled() test moved inside the for_each_possible_cpu() loop so that
>     the per-cpu states are always synchronized with the global state.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: David Vernet <void@manifault.com>

Applied to sched_ext/for-6.12.

Thanks.

-- 
tejun

