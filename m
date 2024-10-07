Return-Path: <linux-kernel+bounces-353680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D7299311C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C8B1F231F2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F91E1D8A0B;
	Mon,  7 Oct 2024 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="osPF7hge";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5fbwiP5p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435391D61B6
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314851; cv=none; b=dSD5K3A2atw3v4kSs9OABr8FozFnLn6nmktvIXC8YxCNIcDioMtRhuw/PC6Dvbfe4wUKW3jdIWNA2RvqWmfWFa/6FUpgHsQwXvzO9ewHJziEdL1Mstn65ENM8wtolCUF5SHMWm0AKIiZUGSBA75K2NEi5qsgitMaHtwlvZSZJ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314851; c=relaxed/simple;
	bh=5FYpAJqF/81LDAyVHprhogsXhjYNaFBWWZ3WL8B1v6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EmE3cOQ8bfAZInLLQltHQKMmd/QP2QGzHA1KuFYMKFpjxVbz0+63CMldpJU5WVEu2Rr3diSJRWk8RJE1rOyFSQ+LpyI8NeS6EfGoMZQIbIc2H9LZIuWx7Y9+hfJNb+j7nN3ose+/VE55S4t4OEijr8t42FPLeZh1AGtDaa5wyao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=osPF7hge; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5fbwiP5p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728314848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kII8SCzlGG9hmidK7VeJKeDDbOpwIQZ6bj8/kLXRMjM=;
	b=osPF7hgeBZ8lWe/9mNg3rQvZu+i4t6/Y80BpGZUJZVpUHCodxwh0KUT7HmqgB1N3diVhAO
	1uCOhv+pNZr0SrHeKvHMo8P8S4dTJ4WYvrtoWHxKMEPZ0DHsAe+GCTC3+iQj/q4377sE08
	+4I5FZxTa2pORCsfjHusUrDK6wRgQZuDiW3n2EBQYlonoTr7vgaZVxB9jy9W9Qsj3dTBp5
	bxhOZ6YR6mWYBpQWHOzCkQuO6Ev573TJjfJXRSDG5SgXtHIOzjZfIG1sflf7GGQxqnwB9A
	h1g/EPWCFso1In7DndSqOofAohOI8zgjBcDdDbWLAoJbzGIRNyAfaCufU0bHOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728314848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kII8SCzlGG9hmidK7VeJKeDDbOpwIQZ6bj8/kLXRMjM=;
	b=5fbwiP5pCuIZZA8AMNo99t1caJcUlNvZc4qvAuzTzl29dtFSaYPNYzkty36zVPoLxEd4vX
	W7NWXhISUDF+PICw==
To: David Laight <David.Laight@ACULAB.COM>, Bart Van Assche
 <bvanassche@acm.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King
 <linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Clemens Ladisch <clemens@ladisch.de>
Subject: RE: [PATCH 07/21] hpet: Switch to number_of_interrupts()
In-Reply-To: <18b139e4a0674892ba69d00e5f170b7f@AcuMS.aculab.com>
References: <20240930181600.1684198-1-bvanassche@acm.org>
 <20240930181600.1684198-8-bvanassche@acm.org>
 <b315cbe2e1264d98b57ce57fe5f66a23@AcuMS.aculab.com>
 <cb045717-5eb8-456f-aa50-667e9f8aabfd@acm.org> <874j5oun7x.ffs@tglx>
 <18b139e4a0674892ba69d00e5f170b7f@AcuMS.aculab.com>
Date: Mon, 07 Oct 2024 17:27:27 +0200
Message-ID: <87o73wszkw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 07 2024 at 13:00, David Laight wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> In any case 'accessor functions' just move the global symbol from
> being a data symbol to a code symbol while obfuscating the
> code and making it harder to find where values are set and used.

That's nonsense. The accessor functions can be as easily grepped for as
the variable. So that's not making it harder at all, but it encapsulates
stuff better. That's the whole point of the exercise.

Thanks,

        tglx



