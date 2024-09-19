Return-Path: <linux-kernel+bounces-333543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F29E97CA88
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DB8286200
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A169019F109;
	Thu, 19 Sep 2024 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VIKqDXP6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D9rLwBP6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FEC19E7E2
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754071; cv=none; b=oOLe4YzTDbH/0Z/NyclheGfCRw8J1o4adPW2uxZ2FhMPzkPUyrFOm+zWErfFRbX0WkAg70NgzionE+r2clJd5TC8v5nJyI6gwoZjAeCwIDKYTSkqvm0sXACcZY3Sa22U9fAsBtIHd0o2hnkPsB2bw7fBt2EMfAQvU8Y9XaXl67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754071; c=relaxed/simple;
	bh=ia0ngBUwc6fmjQwbnDeweGZkc27XCnOboAFpj/p4Bkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RzMSDoJ+B9Qu9fkwEDqlb43xlhtAY6UoTMeiPQapZsJd6l9ZjeiNcEByx4utGLBXs/++5HhCfpqq/Tf8/Clkvee97/WIZDK56qItKf2n7ORW69EvTPpVl67vA0+Qk+jQf6Aa7HP+pfCTEpYsmn66PdmaEo2MD+WjO/xg5ktvtVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VIKqDXP6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D9rLwBP6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726754061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ohVVn3aA4aEJO5AuHdkFWokqHkCnfqG33+4YiyTZOR8=;
	b=VIKqDXP6D+x9BPqQBDRqfowc9jlpHc4vEuBSryrW5PQYHYDyHYr+BDqySzvZN+IraD2qmE
	5FO8hHm/lBg5IzyljVyyNsZaiJCNhZg574pr44kdITr85i4Id9aW4LrrvNpp0XAWYY5Nq7
	yb2fqa7qYqknY2RwYW0joHp6Fx/GR+RmCnmZmxbkSuHKyWodc5H4ZXZDpwAVZA2WZm4Qwu
	Ksmu6QOf5OFN76jFhfkIMipQdlWCn/P0eaxeWbcLik1/visMnl11QycPUSaTBpLw1VszOq
	o0Ju+00kHtftqnHffIxarb4/gN4R4Y49B7IYWgcKtk7hCfFXwSbpHQOuXIkO4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726754061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ohVVn3aA4aEJO5AuHdkFWokqHkCnfqG33+4YiyTZOR8=;
	b=D9rLwBP6po2JoFr6qcgdMbdSa1f4W0lsObWINpLkpVPSVXecWgJ4rmwwYN4/JiBIbIoRJj
	DTa4BONICbfkETCQ==
To: Steven Davis <goldside000@outlook.com>, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Steven Davis <goldside000@outlook.com>,
 Peter Zijlstra <peterz@infradead.org>, Ankur Arora
 <ankur.a.arora@oracle.com>, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] irq_work: Improve CPU Responsiveness in irq_work_sync
 with cond_resched()
In-Reply-To: <SJ2P223MB10263844181902531B671FB6F7622@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
References: <SJ2P223MB10263844181902531B671FB6F7622@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
Date: Thu, 19 Sep 2024 15:54:21 +0200
Message-ID: <87frpv21gy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 18 2024 at 11:23, Steven Davis wrote:
> Add cond_resched() to the busy-wait loop in irq_work_sync to improve
> CPU responsiveness and prevent starvation of other tasks.
>
> Previously, the busy-wait loop used cpu_relax() alone, which, while
> reducing power consumption, could still lead to excessive CPU
> monopolization in scenarios where IRQ work remains busy for extended
> periods. By incorporating cond_resched(), the CPU is periodically yielded
> to the scheduler, allowing other tasks to execute and enhancing overall
> system responsiveness.
>  
> -	while (irq_work_is_busy(work))
> +	int retry_count = 0;
> +
> +	while (irq_work_is_busy(work)) {
>  		cpu_relax();
> +
> +	if (retry_count++ > 1000) {
> +		cond_resched();
> +		retry_count = 0;
> +	}

Did you verify that all callers are actually calling from preemptible
context?

If so, then we should just get rid of the loop waiting completely and
use the rcu_wait mechanism which RT uses.

Thanks,

        tglx

