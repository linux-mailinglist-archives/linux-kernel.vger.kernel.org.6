Return-Path: <linux-kernel+bounces-358560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EC49980DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 677A1B27C9D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C261C1AD8;
	Thu, 10 Oct 2024 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T+FQDj1w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sHOpdEmX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794D219D897
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549699; cv=none; b=XU/sO9xK3yDz+WVncSjWJKc29AgcoHp/L/l8EEwksb073ZaeTXny03Hh776tM4xQuPHRgK3r/Yqfnri20WvlKgBR3HGyED/LGa4di+2A9kwj5+kIT8JcyKSgj0863PUpBmitsWV86VlZejL6dsrx/Tg3b7jSdHgKufPTSNycdYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549699; c=relaxed/simple;
	bh=JTteMSK+ET3ICOQMjFYKsRCNreSTq53HvPrxRhJuF0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jr1yjCu+UuNQQyRC5i0JP55o//L50L2cf1BzF+81Bq7ahh44PptgbM2/4hm2KuWt2lxEFGy5DPT12XIaqa72che0TwaTNsjUJMsp8ZEJwxr8ZsSfWaldQs6XvYqvowkEFbLU8Cmu6CzNo1D35ahdBWJ/aPGsrXdUgOs6RIpTNkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T+FQDj1w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sHOpdEmX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728549695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ByBU59VtWq1byXCsNjesi1vvafe1ZDQDprVQPZ4R9cM=;
	b=T+FQDj1wJSS+CmmB5XRbfzKTPhKIaRADWnBPQDDVpbZhNo1yHR9EkUfgONcgcw7pN6PEJe
	2DcRM/byKRGHERMvN1lF6uSUp/CP4b7/K9zS3k2cVyDiKB60YtB9BTbFv+IgAaKcwkdlzW
	mdZOV8cnD60bwfvDFysYBRPtwpnSF6rceLr6iicuYe2KvLeN0zPt/M01O6Bpc7u63BBQ2E
	gSQQaXCwKf0edk0wSvRcq4GNqpjD/+7ucrldD6tcJuMvZjx4MWtlvjwYlmoU1PxNMIEsqs
	1ZlsAV32c1CVx9pNqOWSM80lZ8TdXR0CzUo8Q7F8u4Aoo0RF2Gd/JpTbgS+LWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728549695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ByBU59VtWq1byXCsNjesi1vvafe1ZDQDprVQPZ4R9cM=;
	b=sHOpdEmXJWyROdmmdvCZ0i2f24OYt0bMQ2QU8q4jWHzwlgqWofWSZoFLMbjGbpHJUykKL7
	NB/eTmetXwWkU/CA==
To: takakura@valinux.co.jp, pmladek@suse.com, rostedt@goodmis.org,
 senozhatsky@chromium.org
Cc: linux-kernel@vger.kernel.org, Ryo Takakura <takakura@valinux.co.jp>
Subject: Re: [PATCH] printk: Allow direct printing for PREEMPT_RT during panic
In-Reply-To: <20241010035511.289657-1-takakura@valinux.co.jp>
References: <20241010035511.289657-1-takakura@valinux.co.jp>
Date: Thu, 10 Oct 2024 10:47:34 +0206
Message-ID: <847cagmjsx.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-10-10, takakura@valinux.co.jp wrote:
> If PREEMPT_RT was enabled, printing for legacy consoles are deferred
> by default, including after printk_legacy_allow_panic_sync() during 
> panic which allows direct printing afterwards in case of !PREEMPT_RT.
> As a result, printing of messages during panic for PREEMPT_RT
> is handled by the console_flush_on_panic() called at the end.

This is on purpose because legacy consoles are not safe in many contexts
under PREEMPT_RT. console_flush_on_panic() is used as a final "hope and
pray" excercise even though it is not safe on PREEMPT_RT, which is why
it is at the end of panic(). printk_legacy_allow_panic_sync() only
exists for !PREEMPT_RT.

> In case if kexec was loaded, console_flush_on_panic() will not be
> called and starts booting into the second kernel without printing
> the messages.

If legacy printing is allowed before, the kexec may never happen because
the unsafe legacy printers can hang the system.

> Allow direct printing for PREEMPT_RT during panic so that messages
> before kexec gets printed.

Sorry, NACK. This goes against everything we have worked for with the
rework. The solution is to update your console drivers to NBCON.

John Ogness

