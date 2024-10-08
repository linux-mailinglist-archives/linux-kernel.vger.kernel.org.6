Return-Path: <linux-kernel+bounces-355378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B483995179
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2631C25310
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A864A1DFDA2;
	Tue,  8 Oct 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ej63UH4y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rED4tQKz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DFA1DF96B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397420; cv=none; b=JZ5H+PRUPftxmcW7nHPAw9Z3JmeQ4j1LRtPU4zcBujemjJSEpTQWPlTqzd2H+Z3t5rWXE3kDHEoJcV5xAPoofKkfi51Vx1tagrWO6rQMI2/fXIkhAJ9SlmpkDLV1MJqb9H6/dKDBpRkTHhFLxnp23YppJwAA+hsKEPRFOG3gup8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397420; c=relaxed/simple;
	bh=Zsuy3Ib1SYKnVAxaweBx1p7blIUnhZsEq32oM/AA+cw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D8tl90FSoKAaiQc9NlTDXO6nOcNIry6RqPcbUw8wPwQGMG1k5/G7gt7CvHZlpk4FKJvgnzDjKf3wdlKdL7mO9shKSwutlKLXHob42bKy0rZdnD3fUFG879u1YHXThdS677LsmS0D22g7C1VlpZE9iWYLMchlR+dC/FNoBFDs2ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ej63UH4y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rED4tQKz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728397416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zxvs7vvQKE7vJg0n2V30aaYrQ64jJaSHDMBGCEyoW+0=;
	b=Ej63UH4yhoH4Oi5aIFkO4GsWBonLhydqXjWxZlzdnHe1iixvCYeU+tUd7n3nCngWRnQzG/
	N+7xouFbNPpIagR498F/DSMbDsCdaFjiY9QxQwU57AQarsPrhV8YVfgHpXK2C5zA3dQQlv
	NSKzRhB9kytLXPYLC7p52woLiuc2wd8wSbYNIA3rDR2TBhhfwzjurRmbeBiUuTUC81BkWc
	Y/MkUfFg61Pm3yRa5u8/2H25gfwxRjncPIQvShYkHE+Ym4PHE5s0ZGaaMVK7Xmujnm6+4i
	ELThT0/KUOVwbObRkQ/mqKYuZnIVV45SClZwLoPqmeu3ksmC2xSdLuuuaUmGfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728397416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zxvs7vvQKE7vJg0n2V30aaYrQ64jJaSHDMBGCEyoW+0=;
	b=rED4tQKzHml2SFIVJHCVersKw4HB8ke8RCRX76Aj6Xje5vcXvZFKJ2d/S4+ymDpw/OUeZn
	CvyeZGOISwbs3tBA==
To: Peter Zijlstra <peterz@infradead.org>, bigeasy@linutronix.de,
 mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
 efault@gmx.de
Subject: Re: [PATCH 5/5] sched: Add laziest preempt model
In-Reply-To: <20241007075055.671722644@infradead.org>
References: <20241007074609.447006177@infradead.org>
 <20241007075055.671722644@infradead.org>
Date: Tue, 08 Oct 2024 16:23:36 +0200
Message-ID: <87ed4qu107.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 07 2024 at 09:46, Peter Zijlstra wrote:
> Much like LAZY, except lazier still. It will not promote LAZY to full
> preempt on tick and compete with None for suckage.
>
> (do we really wants this?)

Just to prove how bad NONE is without cond_resched() ?

I'm sure we can do without that experiment.

Thanks,

        tglx

