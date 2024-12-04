Return-Path: <linux-kernel+bounces-431944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9749E4542
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 21:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41DE7BE6647
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D0D1F543C;
	Wed,  4 Dec 2024 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ja6+pfNF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uolwrSlS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A8E1F542C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335392; cv=none; b=qKjfxP2uilEcahb/CpItdK8uhBoVeuW/Gat6mZtxkq3rcrU9eFDczatH+WvvZZAh9Bj+ni/goz9m2mw2WsNz4+N2dZubYzbKvVvBCWO6LN5OFEkwrj5DYHlff9rRdMaLkNDaqKKIiIfRuhj0QNlTq+GyHStDKmF/iShIhvCBjKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335392; c=relaxed/simple;
	bh=zFbkvESmiF6G63PnrSjsWpk4Nnnr/CB453GxVDp2Z58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EWYyKiq7yj+vYqVJ9VPKECaDwA+HwliziCxgTb+6dUSgsevUFCOr8oDAeYeux0mlvAC3v38DO3zXi20/WaYhB9HdeVYFCaC6NZ8zFjLbJJkJ0GWe9m2RHakT5gWEQBBlEpC1xEtxm5w+WkP7E7UdC7/WjeAndIZRF2zdp0TROjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ja6+pfNF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uolwrSlS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733335388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xv+UQGYrPPO4Z+df8iM+mZ+8XwnjjuMiYsr6QUKXyVU=;
	b=Ja6+pfNFngE4wCN1DCFCYMMsny4tDRe7zkRhVNPn8ZHE5eZcj4fJZ6E4fd6Ah0ODju9Du9
	wtuZm7uDXXcGmDkoSNwtasKuLMlJnqBq4ksnbCmd9NPM/ADQVnlVearJXmSX7jM5IIoJLs
	x+gm2KcR8COlsWQgBR8FUI7znt3HpcDlrlrIMqjsibkI9ic4zcnJm9X2l5NccBHVBptwhc
	/rUXv7q5oZWxHJxYoqmC+uUKGQjAi26ikYCq+XfJ5P4yA8iALQJAn3U9/XZwkLW7iqRtVG
	4HPv8ruY8WoWRSbxljiXeR79r46KiR8c/zdoFZ8jtnH+XBH7X0t3pfDqEJVn3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733335388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xv+UQGYrPPO4Z+df8iM+mZ+8XwnjjuMiYsr6QUKXyVU=;
	b=uolwrSlSEJshe0A26OlY6LEddbPEA231ftdDGLNlqFdQgSxvsdP+MBNUhaf4qwa97EzIvw
	wfBORAbrRwJbU5Cw==
To: Waiman Long <llong@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter
 Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>
Subject: Re: [PATCH v2] x86/nmi: Add an emergency handler in nmi_desc & use
 it in nmi_shootdown_cpus()
In-Reply-To: <7aa93137-4b5e-474f-a99c-47acffdf71a3@redhat.com>
References: <20241203150732.182065-1-longman@redhat.com>
 <87h67jsif0.ffs@tglx> <7aa93137-4b5e-474f-a99c-47acffdf71a3@redhat.com>
Date: Wed, 04 Dec 2024 19:03:08 +0100
Message-ID: <87zflbqqar.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Dec 04 2024 at 12:23, Waiman Long wrote:
> On 12/4/24 8:10 AM, Thomas Gleixner wrote:
>> On Tue, Dec 03 2024 at 10:07, Waiman Long wrote:
>>> +	/*
>>> +	 * Call the emergency handler first, if set
>>> +	 * Emergency handler is not traced or checked by nmi_check_duration().
>>> +	 */
>>> +	ehandler = READ_ONCE(desc->emerg_handler);
>>> +	if (ehandler)
>>> +		handled = ehandler(type, regs);
>> Shouldn't this just stop processing right here?
>
> Yes in the case of crash_nmi_callback(). I suppose it is a no-return 
> call. As the emergency handler is supposed to be a general mechanism in 
> design, I don't want to make too many assumptions of what will happen 
> when the handler is invoked.

I'm not convinced that this should be used as a general mechanism. It's
for emergency situations and that's where it stops. If the thing
returns, it's a bug IMO.

Thanks,

        tglx



