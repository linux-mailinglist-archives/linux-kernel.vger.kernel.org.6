Return-Path: <linux-kernel+bounces-436573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C059E87CE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 21:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A4CC2819EC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 20:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E5E18A93E;
	Sun,  8 Dec 2024 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ahNZXvo9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="POCqzvJu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C128467
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733690081; cv=none; b=miGC2we+PE7kk6w3MExJXr8insqD89gzttZGoNrApfZ05u5GOvbf/M7qrkfPR5p5GYjB3BjNbjvFNblnSVk43YvC3qBxb1nDkCND1dZsQ3NnnTp1WaCTJjGfJBDn48kI7CSuTxP7l3u5aI1mXTFQuF7L4h6FxVlRH8YcIvE8WgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733690081; c=relaxed/simple;
	bh=mA7MYT6V7f41DM+h77dleWZsrRUyPfxDYfu4gi3tIjg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IYKXLeKIjiZ2UQb1lb+nSBH2a2n3JtO5/pkD/ao82HCUO82AnXgdBfP9XwhrJmP7nd5mcqxC3RoIFni0KOwtRYXehpUc6duVyJDucUPFcWJOJt0yNWohD5w45xO0zrxQwKNXA9cDZprA5v3NYzO1c8wD6Sw3KmH74tNBugU2AjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ahNZXvo9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=POCqzvJu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733690078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=47hsj/apPRuzZL/Ce8mm9aV4rw3BIH3sQ4UY5tXpuhQ=;
	b=ahNZXvo9Dq6j5ipCJI3fkbAoUzrJ4pjFQR8wguVxljX/JFPq1h6bMhA2BDa5XVDWONn4n1
	4aRxkM9ZbN0FQ2ZWYSBEzvV6l7TB/Pa+xSGUHGP/9YlydhN5Z5tCLHOEdLQ/AiSKhJpe4/
	tzdl9eGsssS9aH3YB5skHo4/y/diTyTGxDV8Ep+oh2WLs3MGmNEf44Fb2n7cDxPs3S7Gj9
	oi72HyPbpAOqLaMFQP4NcU5bZesEV3jWMNkLDriNepvo3UCzD/8QL+52IOL95zi7cGwxr7
	CzpVAa+NxhfBh39xVWJSs9bcVZ2fbiPNoH7lDteY9nzbOqULQ0EaNwWgd96C5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733690078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=47hsj/apPRuzZL/Ce8mm9aV4rw3BIH3sQ4UY5tXpuhQ=;
	b=POCqzvJuNKwOvh/UsMbPTGkZPUmBmobvGnFqvmB74BfyBtAnRCh9D8oaNaNoQ9yPmeCVr3
	yxh8JnSMJmDxn8Aw==
To: Koichiro Den <koichiro.den@canonical.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org
Subject: Re: [PATCH] cpu/hotplug: ensure the starting section runs fully
 regardless of target
In-Reply-To: <20241207144721.2828390-1-koichiro.den@canonical.com>
References: <20241207144721.2828390-1-koichiro.den@canonical.com>
Date: Sun, 08 Dec 2024 21:34:37 +0100
Message-ID: <87zfl5q5gi.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Dec 07 2024 at 23:47, Koichiro Den wrote:
>  static int take_cpu_down(void *_param)
>  {
>  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
> -	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
>  	int err, cpu = smp_processor_id();
>  
>  	/* Ensure this CPU doesn't handle any more interrupts. */
> @@ -1285,8 +1284,9 @@ static int take_cpu_down(void *_param)
>  
>  	/*
>  	 * Invoke the former CPU_DYING callbacks. DYING must not fail!
> +	 * Regardless of st->target, it must run through to CPUHP_AP_OFFLINE.
>  	 */
> -	cpuhp_invoke_callback_range_nofail(false, cpu, st, target);
> +	cpuhp_invoke_callback_range_nofail(false, cpu, st, CPUHP_AP_OFFLINE);

This is really the wrong place. This want's to be enforced at the sysfs
interface already and reject writes which are between AP_OFFLINE and
AP_ONLINE.
  
It's utterly confusing to write a particular target and then magically
end up at some other state.

Thanks,

        tglx

