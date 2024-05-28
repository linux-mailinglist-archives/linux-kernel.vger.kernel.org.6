Return-Path: <linux-kernel+bounces-192731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3C98D215E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692F51C23779
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD65E172767;
	Tue, 28 May 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GU7BQRh1"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16A532C60
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912805; cv=none; b=Y9ipoSs9XGmZQ/vq9xqBLjBQNrqXGBym40r1zPTfYxnBYgf0yk8bvkoGWIXNZ3pjqcmjDIr1j/LSJE4MCam4xZmzu7YulrcPksdSC+1QyM/bYbgWNUA/MBMecd1NGKNmTGIHooxomJr/ZGMycAUBeQQ9nkOrQ9omS4b8Ho/3h4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912805; c=relaxed/simple;
	bh=Beqizfh+ua2mk6V35CBh2s+19I3GQaqRn9542pXZKUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYvZj16x4DMMfmKHIlmDyCThCmSKBgIa7OMdIiE9ETA5WxJKPJIlN+G8gGc7O8WDynzWW3+rIXelh+00xSDQsVXBIrsAq4/rue0Z1s4ClB+7frZKIJsRPseN5vbyvH/fP2SoqoGRXR1kTxpuPO0x6BstxXouJhrOrVio375egAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GU7BQRh1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1tiyrgoHY2F8Xs8GsHKmBGxrGOp7toPPdDjmM5tv3AI=; b=GU7BQRh1yiOCp2P7l7nM+KCvWL
	goan5eSXc2vUB6161vL9NLdjKN11wNo9rjh/hdxA5gXmvEXRHvjGPF+DFICYuO/filDFVpHcHPEzj
	LZoXKBYfKE+w7Dpyx9PHAzsrb0CnIzCSolNvsZhg5J1comgh2jiPKlN8LlWZgsUlT/RMe1czmm3+/
	rzB+ulm0mw5Eh3QVwflL100N/CMQbbrQBL8p2fwqxFRKXPJXWgD99cL99BF99datGJB8GgIrVfubL
	gA8Ys5ujperOHNnchaYdQMTookMY8qGsYGmazSkTjEbOOYoQ9K7wPuLoeZ0dkU0EJLQJ4+97Y6C+S
	trCwwMeg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBzRt-00000008oL1-09L4;
	Tue, 28 May 2024 16:13:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A7E2830058E; Tue, 28 May 2024 18:13:16 +0200 (CEST)
Date: Tue, 28 May 2024 18:13:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
	joel@joelfernandes.org, raghavendra.kt@amd.com,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 09/35] entry/kvm: handle lazy rescheduling at
 guest-entry
Message-ID: <20240528161316.GE26599@noisy.programming.kicks-ass.net>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-10-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528003521.979836-10-ankur.a.arora@oracle.com>

On Mon, May 27, 2024 at 05:34:55PM -0700, Ankur Arora wrote:
> Archs defining CONFIG_KVM_XFER_TO_GUEST_WORK call
> xfer_to_guest_mode_handle_work() from various KVM vcpu-run
> loops to check for any task work including rescheduling.
> 
> Handle TIF_NEED_RESCHED_LAZY alongside TIF_NEED_RESCHED.
> 
> Also, while at it, remove the explicit check for need_resched() in
> the exit condition as that is already covered in the loop condition.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  include/linux/entry-kvm.h | 2 +-
>  kernel/entry/kvm.c        | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
> index 6813171afccb..674a622c91be 100644
> --- a/include/linux/entry-kvm.h
> +++ b/include/linux/entry-kvm.h
> @@ -18,7 +18,7 @@
>  
>  #define XFER_TO_GUEST_MODE_WORK						\
>  	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL |	\
> -	 _TIF_NOTIFY_RESUME | ARCH_XFER_TO_GUEST_MODE_WORK)
> +	 _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED_LAZY | ARCH_XFER_TO_GUEST_MODE_WORK)

Same as last patch, it seems weird to have both RESCHED flags so far
apart.

