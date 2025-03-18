Return-Path: <linux-kernel+bounces-565217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E0FA66380
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406E1189FF26
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209D54C83;
	Tue, 18 Mar 2025 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ei0ygVdT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA84A0F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742256893; cv=none; b=V6D8GPhVikIa4O445K6dh70Jf9fSErOZ/tafwHkIE752k6NS6Yo13fOvWzWLl7iT0dfVRqJx2fye9tvNn1p5/zRUCkyJ0la2gSpysg92J2L9581k7lFWYvS1TrS8CLDpfuKorUSouzmhmyuSzAOy+v/PUodKtv245uLxws+8Rpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742256893; c=relaxed/simple;
	bh=tUNzi0RCn6yGzZRiFcxsD3qbSKdqAzvcr2XZm4pvu2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXiS9Sg6s9y7LFDKNqkyg4BD2it9mMw6ytBbooHcucO8lpBU3MAybZX11iWTT9FQSwAdGgpZnA7P+q0FTYiatAVVTlC1hniz+CKxCOooD6bzPykkqZVYNiURi/KDYoC++lkCoRHk+FocBvMuP94dH4QVwj2w0mYDExHB8UGW0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ei0ygVdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55EBC4CEE3;
	Tue, 18 Mar 2025 00:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742256893;
	bh=tUNzi0RCn6yGzZRiFcxsD3qbSKdqAzvcr2XZm4pvu2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ei0ygVdTWhdBoUF3/iBDld2BTF6Ag3UkjYztm++DS2DZV7Qh2enCwFOVGdHo9IlyE
	 4vkSTtdXVrAL+q5zq7UtED72N6Hqdpv0niwMmf2KkMj26QAgeELR+wBj671meFDXVT
	 PqIK6r3F4Gb59DVicRSAe9Npo3/7m9U91oS2v3soqqBmi5bPoOuvqJkHCnqTuN03vm
	 HyW5DzfoOdf6iKZCTS3IbAEsFTb/LNt7IPQHbtespcNfJoqsll+AdUWX8mgI9I8wD/
	 54cGXZ7+CUiNwK6EDuLAiKS7/0quSUeEc+700xkS5XGgJpBBiwYFBKKWCBo/5jnYWb
	 DagkznOLFPORg==
Date: Mon, 17 Mar 2025 14:14:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Libo Chen <libo.chen@oracle.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH RFC] sched_ext: Choose prev_cpu if idle and cache affine
 without WF_SYNC
Message-ID: <Z9i6-_R_LLqt8mq4@slm.duckdns.org>
References: <20250317082803.3071809-1-joelagnelf@nvidia.com>
 <Z9hW_3cPN8u7VURV@slm.duckdns.org>
 <e93710b9-4ae3-4d68-8e3f-65439e2cf9fd@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e93710b9-4ae3-4d68-8e3f-65439e2cf9fd@oracle.com>

On Mon, Mar 17, 2025 at 05:12:25PM -0700, Libo Chen wrote:
> Just as Peter said, this is whole wake affinity thing is highly workload
> dependent. We have seen cases where even if there are idle cores in the
> prev node, it's still beneficial to cross the NUMA boundary. Will it make
> more sense to have the BPF scheduler implement/alter some of logic here so
> it can fit to different workload?

Oh yeah, multiple SCX schedulers already implement their own select_cpu().
This discussion is just around the default implementation which can be used
if a BPF scheduler doesn't want to implement its own.

Thanks.

-- 
tejun

