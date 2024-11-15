Return-Path: <linux-kernel+bounces-410367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2C69CDA76
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8EB9283A07
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A939F18A6BC;
	Fri, 15 Nov 2024 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FVyeGEsm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y8YFeZlK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5CC18B494
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659404; cv=none; b=Jjc/tKgTNZcdh2/l1MtTUtgySnMRzKwjBF5JV/yCbkN7CQg/wYYAeWYOICZOodW+F9snEqwAICvL0QNVcPcA36+31uSH/j/ogyuwD4fy/zmTqkNarkQz8SNM3tISboNwN19e1GxgWij9Tu1kK/odj7Ie60CQABkqv0zGd+P/ubI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659404; c=relaxed/simple;
	bh=RuNLles28pVW+hFxugik2CIAIDNCMzXWLd8VEeqVkBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s6V73Do56qhGLMb+Ahiuz+teHGcRxsF5z7AhTX6dO0VFiJljSzmlqYM/sGNujsszvPg7EGiCSTKlLEwFwEfpFfCYb3ws6mmxpV1doNft1tMp+cCwJmI9NsaqIHZoaTV+MPppRljXy8NDL3WC4ENg75Sm8KzJYbO+vzs5avSsarQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FVyeGEsm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y8YFeZlK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731659400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=thZacfLR/FxCAsyvlozrWgv6ImpcoVI+yTUBmNI8psI=;
	b=FVyeGEsmT9fR7QEodNQrO2bTSI3+SLiZoIs8qqkWHID9dZxg+6h7wTegrCNbEmf3Auk9Eg
	rmFPm/EN2S0C+w9oZ68pWdIdpZVUN1Js/bqDPmJNdEwuDNEH9CCbiLw6cBsG1tGNE4PVhG
	ALSSgXr+PAofvxXK9ibUpAHaEjNM7ISCyFQZqB32Fx64t2vHA6UWNCtyqhQzek2WwS6pl5
	/d7GqTnJGO7vaAunTNTMRxWDsVL4AMfPMx+XzjKrK3M4JV3lTVcWx8q+OlBPWT3c4+4cAr
	uryEnuMQAjrGN6YA4ojrrfGQlnT3vmFruqMv08OWo3/BAVa4sv3I5S+TJVPtkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731659400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=thZacfLR/FxCAsyvlozrWgv6ImpcoVI+yTUBmNI8psI=;
	b=y8YFeZlKrdHpJNHVlXCna+EgrWJJDvJsgr0b/E2YV9ukE2MN2LyOtyrKdj6WBavJNrrmCh
	bcY5oEccm1ILFPBA==
To: Chris Down <chris@chrisdown.name>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Tony Lindgren
 <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 02/11] printk: Use struct console for suppression and
 extended console state
In-Reply-To: <ba47efbe432cf33cb358a027a2266296e2cfe89e.1730133890.git.chris@chrisdown.name>
References: <cover.1730133890.git.chris@chrisdown.name>
 <ba47efbe432cf33cb358a027a2266296e2cfe89e.1730133890.git.chris@chrisdown.name>
Date: Fri, 15 Nov 2024 09:36:00 +0106
Message-ID: <84plmw527r.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-10-28, Chris Down <chris@chrisdown.name> wrote:
> In preparation for supporting per-console loglevels, modify
> printk_get_next_message() to accept the console itself instead of
> individual arguments that mimic its fields.

Sorry, this is not allowed. printk_get_next_message() was created
specifically to locklessly retrieve and format arbitrary records. It
must never be tied to a console because it has nothing to do with
consoles (as can bee seen with the devkmsg_read() hack you added in the
function).

I recommend adding an extra argument specifying the level.

The extra argument would be redundant if may_suppress=false. So perhaps
as an alternative change "bool may_suppress" to "u32 supress_level". The
loglevels are only 3 bits. So you could easily define a special value
NO_SUPPRESS to represent the may_suppress=false case.

#define NO_SUPPRESS BIT(31)

bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
                             bool is_extended, u32 suppress_level);

Then in devkmsg_read():

printk_get_next_message(&pmsg, atomic64_read(&user->seq), true, NO_SUPRRESS)

John Ogness

