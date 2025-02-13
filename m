Return-Path: <linux-kernel+bounces-513478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E701EA34B00
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF533BE7E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8D02661AD;
	Thu, 13 Feb 2025 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9UOxC17"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CE826619D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464854; cv=none; b=gIu04pVsu2hBu8ea6Yr+7zmLCRe7UzIwDJmR8O3Mpzx9d1c2HXB2dH8mYBvhzwl21zhU5mnBT/Ch68XBPv7E8/WZV6qIa20ZZ6QHgFpPtVIZn7nTGyZTVA984caewN+8Qxob+qQ9wNQsEkaX+B/D5QnIxwtoQhQYwTU3M1b1/sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464854; c=relaxed/simple;
	bh=SDJ9xPx+V/kUYuCd1lfpdiNdJdkLWVzRtwki/MC6fQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmUIpa/0nRMFdMgcaeoHLA6QhnZq5xV5L0/xlvBhvIq2D1bxZEaPRqjXd0R07sNh39fae+YYE0FTP9CWOXfMUsWHXe7iwcoJ/+kM9NI7XVPWTZpKP2hoTxjGzKnZWlxDPlTi6+qr3oFXM+J7ZQBLksLRHFJe2hJObryOVxTBvow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9UOxC17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22E4C4CED1;
	Thu, 13 Feb 2025 16:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739464853;
	bh=SDJ9xPx+V/kUYuCd1lfpdiNdJdkLWVzRtwki/MC6fQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S9UOxC175AtipJQE4sLG6QW53cPJbHCMIJQnzSXjuo2JAHnhghALsN2C70ykL2S0L
	 OCty/aXyKS+GYgGdzwGUTuRS7/Gzf9u/68frrvwzxvygWX7SFu7mMp4FRjl7+Kg/E3
	 RM5aVSTFfI5lj3gzZALBPQCfh78DrDgg/ecWTH7O6+9hTDbPv/9XZn9pD3KJ7Na4la
	 WM7D/S+Li1FbzNyO/Y+u9cVhi2ac34LRYDpv+OMsIenOzFmHsAkQr5gmqAWkpJRzl1
	 /ZTQAk8oEGAZ9odoLnW7Za7xrevSAAL/4Uv+3OihxCfCtV+K9BOPhxZB9yqwyKOZ1Z
	 srxJRI4uBdtKg==
Date: Thu, 13 Feb 2025 06:40:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Neel Natu <neelnatu@google.com>, Barret Rhoden <brho@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	sched-ext@meta.com
Subject: Re: [PATCH sched_ext/for-6.15] sched_ext: Implement
 SCX_OPS_ALLOW_QUEUED_WAKEUP
Message-ID: <Z64glOKTNBMLD0ca@slm.duckdns.org>
References: <Z60p755gE1aDiimC@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z60p755gE1aDiimC@slm.duckdns.org>

On Wed, Feb 12, 2025 at 01:08:31PM -1000, Tejun Heo wrote:
> A task wakeup can be either processed on the waker's CPU or bounced to the
> wakee's previous CPU using an IPI (ttwu_queue). Bouncing to the wakee's CPU
> avoids the waker's CPU locking and accessing the wakee's rq which can be
> expensive across cache and node boundaries.
> 
> When ttwu_queue path is taken, select_task_rq() and thus ops.select_cpu()
> are skipped. As this confused some BPF schedulers, there wasn't a good way
> for a BPF scheduler to tell whether idle CPU selection has been skipped,
> ops.enqueue() couldn't insert tasks into foreign local DSQs, and the
> performance difference on machines with simple toplogies were minimal,
> sched_ext disabled ttwu_queue.
> 
> However, this optimization makes noticeable difference on more complex
> topologies and a BPF scheduler now has an easy way tell whether
> ops.select_cpu() was skipped since 9b671793c7d9 ("sched_ext, scx_qmap: Add
> and use SCX_ENQ_CPU_SELECTED") and can insert tasks into foreign local DSQs
> since 5b26f7b920f7 ("sched_ext: Allow SCX_DSQ_LOCAL_ON for direct
> dispatches").
> 
> Implement SCX_OPS_ALLOW_QUEUED_WAKEUP which allows BPF schedulers to choose
> to enable ttwu_queue optimization.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Neel Natu <neelnatu@google.com>
> Reported-by: Barret Rhoden <brho@google.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>

Applying to sched_ext/for-6.15. Peter, the core side change is trivial but
please holler for any concerns.

Thanks.

-- 
tejun

