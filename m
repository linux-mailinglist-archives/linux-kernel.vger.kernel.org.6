Return-Path: <linux-kernel+bounces-314368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B254C96B25E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FCE82832E1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8572146A7B;
	Wed,  4 Sep 2024 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w4m0O5OG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FHdtbjZ7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAC013B2A4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433690; cv=none; b=bZ43kOvMgyrSmZI0lJ3VnwMuQJuRkL1I0NMVmdKQg6TImrRvQ93mwNQv+B0rSP7S4jIL4OUT/d35yXtD1CTBxheYutgGYjdAUXb4D6WyFdE8/qxF732ZvgDDnIqk+FL1m7ZconqnNIGdvwXXwAgy9jXzFX4603uFjQKtjPpnsBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433690; c=relaxed/simple;
	bh=L1YWksA4Qgfkm5gADeSXuCFqq3stlYJHn6+4bcBeKug=;
	h=From:To:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=ntK4WcOqVpJY6QMB2TA4YsvrcOyDmbDs3LgnNPu6QjTCK00OVqz1vZcRQhXeSVyBgB6rcPIHhr/qE6L5RSmuBLdo/3jbIfSaEBQ7osFIGr8w4xoqUS+4pgbJCr6MFi5J90UGnYvbkKdnT4/Sp9vIhAa9m2dJKciiLBCNQz798d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w4m0O5OG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FHdtbjZ7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725433686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=NcwxqMiYAlJMq7og6JEgaOckC0nfrX/KtqBe3bdMiCM=;
	b=w4m0O5OGruYWceXKo8LM1GVgE/tvKn2Z/22S6ez+TTWCzNBZ6l/1Y3mDVNV4ObTBaiGU9L
	jxnASqMe/bkwkM8HwNMtnguft8PjFC8YMCmRzkbIGOh3vqhnRFudHXxCTY55a7ajEWNYYa
	pl3xEqowT6sY//2Wa0m9ZkFypL61HjhuREWolkLn2J0qZ+S0CbTPPB3d4ByOeeMXE1CfIn
	oRAgUJWdfP8qEKK8NmHkWpFupsFOl/GsBsPLCzzY6G+EwCy5J9OJ+sWStns5Mceu4C6DGG
	aWa6EiaX4M5CJriYravMGYRKabI/zytUWQmoIFQok5SVWYfLl+3d1KAbrPAavQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725433686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=NcwxqMiYAlJMq7og6JEgaOckC0nfrX/KtqBe3bdMiCM=;
	b=FHdtbjZ70CmAqtSvkmVzZemOW3LUU7ZKW1BPJkryWxDGI9VLr7Xr4AjbzriEy06jgm1K/B
	bbdom1eeSicjeCBw==
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH] static_call: Handle module init failure correctly in
 static_call_del_module()
In-Reply-To: <6295c921-7bfe-37d3-dcf6-28676a5b5e9e@huawei.com>
Date: Wed, 04 Sep 2024 09:08:06 +0200
Message-ID: <87cylj7v6x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 04 2024 at 11:32, Jinjie Ruan wrote:
> On 2024/9/4 6:58, Thomas Gleixner wrote:
>> +		/*
>> +		 * If the key was not updated due to a memory allocation
>> +		 * failure in __static_call_init() then treating key::sites
>> +		 * as key::mods in the code below would cause random memory
>> +		 * access and #GP. In that case all subsequent sites have
>> +		 * not been touched either, so stop iterating.
>> +		 */
>> +		if (static_call_key_sites(key))
>> +			break;
>> +
>
> Hi, Thomas,
>
> This patch seems not solve the issue, with this patch, the below problem
> also occurs when inject fault when modprobe amdgpu:

That's a different problem.

 Oops: general protection fault, probably for
 non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN NOPTI

It's dereferencing a NULL pointer at 0x1. That's odd because bit 0 is
set, which looks like a sites pointer. So static_call_key_sites() should
return true, but obviously does not. So how does that happen?

It can't be a built-in key, so it's a module local one with key::sites
== 0x1. So static_call_key_sites() sees bit 0 set, and then returns
key::sites & ~0x01, which is obviously NULL. So the condition is false
and the code below uses key::mods == 0x1....

So the check must be:

	if (!static_call_key_has_mods(key))
        	break;

I missed the module local case completely in my analysis. Can you please
modify the condition and retest?

Thanks,

        tglx






