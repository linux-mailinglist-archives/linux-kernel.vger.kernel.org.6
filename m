Return-Path: <linux-kernel+bounces-321340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8EB9718FD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A828284FB0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC091B654D;
	Mon,  9 Sep 2024 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rycXDLLY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3kpz3Uu2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53DD172BCE
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725883897; cv=none; b=IN3bU6q0yURk0CtGmrXrEEsPE016Y8Y2XTV/500tDe23LmY6xNWzEJ4ugIl3V/0ssXRUhnX8PXz8keKM8GNAayFtz2z1gL98hnHMJlKW1bzCugsC7ckWJKxSGeYXOiyvISOCCZz0RGdT66mWvhnBeqJL+6nY0+CRaGrpRYOR/lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725883897; c=relaxed/simple;
	bh=3I/YkrkQvgYdjJsfIEoCKAECk08H8/S3f6PqAZZGja0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i6bzdhKl8oAzSIFRTqIfscwD15IodKgt2JEnB9/63C8q/H5T7OU/XGPkkgsBXOxOOn7oECvoZqLSjLN0ADpks33SuCjmhoORNPD+so0dokzZJZWlypLLJQzM9bCTWdDVChcP6lUqEDKTp49flVttqfuNgz9lKtekt2427z6c+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rycXDLLY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3kpz3Uu2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725883894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3I/YkrkQvgYdjJsfIEoCKAECk08H8/S3f6PqAZZGja0=;
	b=rycXDLLY8pOWyiUq/AaRuOmnRrhnu8R6HfQ85PV/enqf5+MH+B+IV54ag49p+hl81laNQ9
	RgpewCJBZJ7KNU1dobPnN/2sRnQKvjOnIQn6edOEaEJr6XQPfXn2iu54XlLdZvWLvpRcPv
	6QBE3tKAmQaqzs/IPwxuMFFSSNPeYcRV+HM2kqizadDwJftilrAQ0LGaXjKltO5G8w+iz8
	iOyGZki7RK7x8bAloYHBSUio/o+lY4SN++ELojGqZcW47zib0T3k9p/tfpX2YOh4ve1liQ
	H9PeSSkM2Geh8Pevun6VbI968LhwP/Bb1vrC4eTjy78ouvG2LwyR1vWA8GxuJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725883894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3I/YkrkQvgYdjJsfIEoCKAECk08H8/S3f6PqAZZGja0=;
	b=3kpz3Uu2WKnMPPmUcSI9RJDnhr8Skave2kXQ+eCUS56+cbkrQGiJzlSbOYCV3QgStFLM93
	rOzxDUi68nSRPjDg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, Len
 Brown <len.brown@intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 04/15] timers: Move *sleep*() and timeout functions into
 a separate file
In-Reply-To: <87h6ap1c47.fsf@somnus>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
 <20240904-devel-anna-maria-b4-timers-flseep-v1-4-e98760256370@linutronix.de>
 <ZtsGwgatGpFRQerw@pavilion.home> <87h6ap1c47.fsf@somnus>
Date: Mon, 09 Sep 2024 14:11:33 +0200
Message-ID: <878qw1c9hm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 09 2024 at 10:10, Anna-Maria Behnsen wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
>> I don't mind sometimes having several logical changes within a same
>> patch if that makes sense but the delay is MAINTAINERS is pretty off-topic
>> and should move to its own patch.
>
> Ack. But, I was too slow to provide a v2. It's already applied in
> tip. Should we change tip, or is ok for you?

Zapped it already

