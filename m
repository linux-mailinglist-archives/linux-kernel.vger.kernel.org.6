Return-Path: <linux-kernel+bounces-389022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 663569B67A9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A78B283288
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5493B2170B3;
	Wed, 30 Oct 2024 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xsdKOMns";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B7aFnaY2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4C522627D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301506; cv=none; b=pDj0E31+G3ZBy4tMu6MO4V5wKfHIj5sBSKN1HQurpNkXjGBdECiVXZKKYqC1IZF1PMksSmMwXgmifn3C9SsVEHBguAW9AtHTbU7fdClJO3ErUFWzjLqWN12dmYagymwj0uoHkebWScDZHn5+c7yUaQuSyiR6PbfnAI9KRx7NPAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301506; c=relaxed/simple;
	bh=afxAXwH2i3eW3OWh6zl8p8GtacOwPD6c7K4ha0dckU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b6L5K/oeTT8h2d7wQofLBpsn6BTaYzmrKehrgQ+eR3X9gP11a2IBAiMZ1fUrzJby7Tg6zVRGP9CqfR1fJ2w2MQh9Y/FlMeiHoJk1J/7p3ayL2/Owjan/gWuX6MUgrs1AknA3MnCSvHisfuKhKWsLgdTsKAWrqe/2YNzZHd4wVkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xsdKOMns; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B7aFnaY2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730301499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9REH1Ut/XPLUqnVJnFKVTRuMAQB5RMyBdd/Y1Bd9Ixc=;
	b=xsdKOMnslQaH8NevUi9l2AKfIt+ErslrSx3KeT5fIavpq1gmNuR2AM3ZF2Nzm4h8qkBBpE
	KjMCoAn1ghfWM2wxM+WTPd3DXA/EQ3V0qKQAw5YOucw4YG5tzcZpCfwMsNh3a/vlsyWQVF
	OSYW47RoZPUBOKQlejsrz0dV6/pVpT1wu1azABcOzsp2fTV+UKfFqetXZWkIeQDYITbtag
	4+Ai2FVbQvBwT3fVDb2qOYTHjeTJFY/51SXTXq3kQ9v2lokcVaQh9M6eqqOyuox+BROHkH
	Qa0Vbar5adig1SgpXhwNNszH4d0xnv6KVYQs8wkTRjTN6OdbVnXBn9N6SxO0Tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730301499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9REH1Ut/XPLUqnVJnFKVTRuMAQB5RMyBdd/Y1Bd9Ixc=;
	b=B7aFnaY2rPDPHBv7qyNhcZuqB81fmCLajDVpbln8Wf6YZ4njvrvOGe93jQ6Q+K8Kg/YqQf
	jQAh7T+4CA8pdCAQ==
To: Oliver Hartkopp <socketcan@hartkopp.net>, Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook
 <kees@kernel.org>, linux-kernel@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>
Subject: Re: [PATCH 05/21] can: bcm: Don't initialized an unused hrtimer
In-Reply-To: <09b130f2-740d-4e16-aaa2-8802d9c28277@hartkopp.net>
References: <cover.1729864615.git.namcao@linutronix.de>
 <4e7dc11aa9ffb116678574889cda35b3cd5b7385.1729864615.git.namcao@linutronix.de>
 <203a1560-76c9-4c47-b1b8-b44ddf40cd16@hartkopp.net>
 <20241030121533.ioTNvYpX@linutronix.de>
 <d6055bd1-c0c6-42ad-bb21-7ffad98c9882@hartkopp.net>
 <09b130f2-740d-4e16-aaa2-8802d9c28277@hartkopp.net>
Date: Wed, 30 Oct 2024 16:18:19 +0100
Message-ID: <87o731y5z8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 30 2024 at 16:01, Oliver Hartkopp wrote:

> Just an additional idea:
>
> Would it probably make sense to create a generic dummy function for all 
> those cases like in the referenced rt2x00 driver?
>
> E.g. as (inline?) function in hrtimer.h
>
> enum hrtimer_restart hrtimer_nop_callback(struct hrtimer *timer)
> {
> 	return HRTIMER_NORESTART;
> }

Yes.

