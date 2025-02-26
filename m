Return-Path: <linux-kernel+bounces-533292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D12A457EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44418188CA19
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111C9258CFA;
	Wed, 26 Feb 2025 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G3vZTLI4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QzUwmqI1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E15C1624EA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557707; cv=none; b=eHF9o7ox2GhdD1uu368LMs7HR5GX4mRVRNGYOjF4lXk7nNdLGSgZwPOW8qsF4cYI2H8PHpWB/TEJumbecrWNLelkHnn88s3n/ABlryc22quNoadfyOuDGn7TUNVWuFy/SRqEx9RZvreiBLlpk10U3EsBE3H++abSkfyrTjqKEJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557707; c=relaxed/simple;
	bh=QBioUh+5ar2IMYsyHFiRhFqP9iliCkPTQcG5+LT+TOc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kIo1YaqdFemWP+gxbR/vw40vTpoEZFCCZPXzSt7iHbO3bmK6S7o6/tPJAdXgXQAOOa9njlfimH1hdT1EBVz58nlT3qDPwj0RWZCXa4Q/LAt4Kz1VLrzd0D4F+2h+CfQOs6/hV3m1/kM+00pONe0ziBL42E1/Cid3kCqi1VZ5CmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G3vZTLI4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QzUwmqI1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740557703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kiuMsq8B6x/9dbWlu6OuXV+fQwySnuyp6H+0glY8vgs=;
	b=G3vZTLI45el49Y5XwY9GqNmqgGVIuJdKDR9+8KRNIFCmAxo7IkH3J2JtWrAidaJc/QzPMe
	IA7zlnpOdY5v21bvNlPSa4GPIqE5jkTIceTcb3riT0ALmIUxBVBKAPCG/yRB64mHGJwf94
	jI5ia5BjrBY8u4oWtHZ0BXu01VccvV2Q6k4QPC6BKfIzEvwZ9j5v6lUMGfS0g3XDj0+V70
	op476HU71ohqpGhMQhLCXYACTdRYYAhmaO48nnE2f6en8cZnnZN6zJfw4Lpzepih2YHDCO
	h2a3HEBX6Cfhq/TDceY4FgeXSQQfpO6KGu6wwBPBbl0zmvXJHDaLQD9HCdlCmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740557703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kiuMsq8B6x/9dbWlu6OuXV+fQwySnuyp6H+0glY8vgs=;
	b=QzUwmqI1v1f66+dI47NPXqkxxW3iYBEXE5J+PXEw7wtbjkS+6GqczKFLbXSPcN3c6gpcpW
	06k/CUzRaP+rmzAg==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>, Waiman
 Long <longman@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH v9 01/11] futex: fixup futex_wait_setup [fold futex:
 Move futex_queue() into futex_wait_setup()]
In-Reply-To: <20250225170914.289358-2-bigeasy@linutronix.de>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
 <20250225170914.289358-2-bigeasy@linutronix.de>
Date: Wed, 26 Feb 2025 09:15:02 +0100
Message-ID: <878qptf7g9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 25 2025 at 18:09, Sebastian Andrzej Siewior wrote:

> we could also make @task a bool signaling it is either NULL or current.

I have no idea what this change log is trying to tell me. It gives zero
information what this patch is about and the subject line is confusing
at best.

Thanks,

        tglx

