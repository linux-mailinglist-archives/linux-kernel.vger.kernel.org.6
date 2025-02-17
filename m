Return-Path: <linux-kernel+bounces-518118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A15A38A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5D33A88D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5EA22688C;
	Mon, 17 Feb 2025 16:59:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DED226882
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811582; cv=none; b=t/NWflYNjJsURAxj7qLRIjliKqR3PwzToaD9O2UpPsPSiF07QJq7pETFoSPAzQ8Ro73fWXp+KNw0zfLAhNsGPj66CZLvlXjBRk6C0gR5V77moBgIZkCGy3ntA3QnCP3S+Gn4OkEjdy4yUZLxoSxVY/+8ZkNVqF9IKt2FMTQ5sic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811582; c=relaxed/simple;
	bh=mWFyq31ip8vZjkXI5tJBClvfl+UKurfScpHgZJY2Tgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkUVFYf2TG9JPswmqBIsQxPxZnbBnmIR2JNs/N1/yfI1cvUIFnjnwsknFSfFFxSeiNCv6qn9O+vDjqcC7++V+ogk5G3dGw0DFHKuNzFMb8Vtg/ak3opxHYAND8ibc11mfMwjNCIn1hYG1/TRHbHTAVN65Y5u7PtiZFd6wScZMqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1BDC4CEE8;
	Mon, 17 Feb 2025 16:59:41 +0000 (UTC)
Date: Mon, 17 Feb 2025 12:00:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
 mathieu.desnoyers@efficios.com, tglx@linutronix.de
Subject: Re: [PATCH 0/2] Scheduler time extension
Message-ID: <20250217120000.5ae1201a@gandalf.local.home>
In-Reply-To: <20250215005414.224409-1-prakash.sangappa@oracle.com>
References: <20250215005414.224409-1-prakash.sangappa@oracle.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Feb 2025 00:54:12 +0000
Prakash Sangappa <prakash.sangappa@oracle.com> wrote:

> Follow up to discussion in [1], posting these patches.
> They are based on use of the restartable sequences(rseq) for API.
> 
> However, currently the discussion is on thread [2] in response to patch
> posted by Steven. Mainly about whether this feature should be applicable
> only to normal threads(SCHED_OTHER) under PREEMPT_LAZY preemption model
> or keep it independent of the preemption method.
> 
> [1] https://lore.kernel.org/all/20241113000126.967713-1-prakash.sangappa@oracle.com/
> [2] https://lore.kernel.org/all/20250131225837.972218232@goodmis.org/

I'm still 100% against this delaying any non SCHED_OTHER task.

-- Steve

