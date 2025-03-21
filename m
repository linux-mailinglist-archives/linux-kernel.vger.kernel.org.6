Return-Path: <linux-kernel+bounces-571905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56061A6C423
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B614E3B7D43
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BCB22FF5F;
	Fri, 21 Mar 2025 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oR+exgYs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="90a12UMb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8DC4A00
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742588939; cv=none; b=j5YmZlmDIUZCje2PxUCH6EodErlw881OfLNMzfjToIbvZt8MynkYYZBRwCSrGApNtpcAklnsCX7rrkIvPOsa+zJc3LihDRlqDSbUvASemaMHdNKhxqTBJ/0innwyk959zCYihg8GqUcheuurrrucuWW5JcIGlkBKAodV0F+DgYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742588939; c=relaxed/simple;
	bh=MnMacZW/FLjev9kkv6FIEh8Gr4w3l2EixWuMgSkANF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q71BnqgPDUh8ePME9VQWdXIlHWLOWJE/n23O3ThIMmP4tg9auiOpDeWTTOYdISHfQkwTSKP6vs23Kr712DmjjEPLwFGKTWQZxtg+59QhFI0/19PV33qF3J6bezfQNsFc9wtI8lRfxXIlvaIWvtWIIkpDswFYNg/SkIfYGeEhFvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oR+exgYs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=90a12UMb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742588935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MnMacZW/FLjev9kkv6FIEh8Gr4w3l2EixWuMgSkANF8=;
	b=oR+exgYs9jNCN7sQhjPVIZFnxbVkbdDUie+IGVtNNvc48yVyYbJK6Kfr5Gs6D5iVx4+eRr
	zBupbIbvnaY5wQEk5fIH0yFyL0/rD8HqyJWXDKJsJyVDSf1v0IP2l0f9d3Rsb+/E/Tzuv8
	I4iTKgrdCz2pg/exU0nzDa9Nl5ZnTb4WCLv4ZWWgFLkY0wU528cc6igAf2cOZxONMptUWq
	OXB/Gsk9gv1STGcJKYRu6/1asySU2G3iC7ik0aISEPnbx6lvr2zMwZpGVjz5WgRmm4/5fD
	+PiS6fRRoP43e2APJuRvefZdHPXfYZa69AA6IjRByu10HtpR1BAR4DSBbvtUtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742588935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MnMacZW/FLjev9kkv6FIEh8Gr4w3l2EixWuMgSkANF8=;
	b=90a12UMbA+i3IzgisRP5ZFsRkmSD4dccKI3EILZFjtfInLS60Q2BbnTpPj+TDiz6myCgkK
	ZW6Yftg6e/3fsjAg==
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracing: Disable branch profiling in noinstr code
In-Reply-To: <20250321131248.02114dd7@batman.local.home>
References: <52a664ec9e14ef53c39c3d4fa400c2f1d29348c0.1742537096.git.jpoimboe@kernel.org>
 <871puq2uop.ffs@tglx> <20250321131248.02114dd7@batman.local.home>
Date: Fri, 21 Mar 2025 21:28:55 +0100
Message-ID: <87r02q162g.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 21 2025 at 13:12, Steven Rostedt wrote:

> On Fri, 21 Mar 2025 17:51:50 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> Though the real fix would be to rip out this likely/unlikely tracer
>> hackery all together.
>
> If you want, you could just disable it for all of arch/x86
>
> In my tests, I'm more interested in the generic code anyway.

Which is affected too as you can see from diffstat.

