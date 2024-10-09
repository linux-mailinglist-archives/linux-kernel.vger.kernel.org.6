Return-Path: <linux-kernel+bounces-356877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D076799680A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54B55B25DEB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F61191F75;
	Wed,  9 Oct 2024 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xF0hAUhe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+CECanei"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52F01917E7
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472058; cv=none; b=FDYIzwSc+RridAoi9gyjn2QvFGN0x7eMSVcJkx9vGzJtACka3mYfL0kIR3QWGzU5VW6U0vPnIAPID75Q5WNNLUe+KTtxvt6jO/ABHBR/hZ8C52l+Q1jx1c1rp3gLW8qsl2X67b/8CzO0zxpijVuG4Vyyk0Jx7t64GP9XT8fapa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472058; c=relaxed/simple;
	bh=/T1/prUaRinw1NyBTEwaKiizX4cdpQ5iiG8M9odEdzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phsocMfyNoCYk+et75B8rokNMEKgoGgstpic/ZHxm0DbZd9QBirjaheI6jxBJKuqYnP469i9AklhR0ZThZP96T1w86bPUR8Z9a6zfTXT2I5F/KZkdlBLnBeYHPQIx+qFhgWZ24qGxh2G/h1pQ12Mo9IbXLCV3qEkt/u88ex2D0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xF0hAUhe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+CECanei; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 9 Oct 2024 13:07:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728472054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wBJ1nMVsbBjwjAoNgMaxrTN1hrNjkxzeG8/grKDqJkU=;
	b=xF0hAUhe+lSQUUNlpkZetV5RQrK9+/OiWcLfeEKnVvFvQAaOtkK/MryhRphftSU3JXG2bV
	ZRWMGBPSUkdv/OAymQIcFRABNTUZ2iHAfrteZyDBtEw/kUctGmsVANs/mYjaBSlDzpndfm
	Tf9jD3qsyWY3RL1y3NW4EV9vG4DgrbyTLl9kdTorSPUI5noM3v8dgFIRZcHsv/6KV7dKlr
	qL5296U1yFB8wf4vjROGqa07fy0kMkFxBN8TKj+DjTM2N+R0K30nbkWI6YQfGpENFMkT/u
	JvPTtm/vJTmsDA4rBv8QJB6UCLaJiA+pOQJxqwCpQd8k3DeRdG4+OI8mAyPLmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728472054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wBJ1nMVsbBjwjAoNgMaxrTN1hrNjkxzeG8/grKDqJkU=;
	b=+CECaneiCMhTYrdsP2tsHoGP5DkPLA424Tqt8BjrrIR8DVQfmgKZ5KZNpycLcY9H2R+wqM
	4YACxop84PNKWvBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
	efault@gmx.de
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
Message-ID: <20241009110733.5S5z_mq0@linutronix.de>
References: <20241007074609.447006177@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007074609.447006177@infradead.org>

On 2024-10-07 09:46:09 [+0200], Peter Zijlstra wrote:
> Hi!
> 
> During LPC Thomas reminded me that the lazy preemption stuff was not there yet.
> 
> So here goes, robot says it builds, and I checked both a regular and PREEMPT_RT
> build boots and can change the mode.
> 
> Please have a poke.

I poked. Very happy. Can change mode as well.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

