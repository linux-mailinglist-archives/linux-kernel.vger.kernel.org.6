Return-Path: <linux-kernel+bounces-533294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A46A457F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970703A4E20
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A9846426;
	Wed, 26 Feb 2025 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="369SjlpK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Ktl0LMK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36478258CEC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557839; cv=none; b=JPY+mJaBE53+zef9cx6mh5zXoILKlKHIKavrnqubB3zDTqUu/aCcoH20b6XE7HRdITsGZPgLI3eLVIv4TFUJdkpa9fSSPB4vLOKZTvfMsELxCYQcByVik2Q+EtDbQ2hCI+xUPaxFnrg+9zPSnOjvcGKUn1ma2TlZ9gm3GK8U3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557839; c=relaxed/simple;
	bh=K2ydaEZSDr8rkI4UAu6IVqEaQOP3phajqSxLnagdasU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dP4hwC5gVHg3KnNmwb2Hw7mM91Eg/EKl3EWhEoFQdVDV+vgNwIj43mEGpdUwa5BLzOf4dqt4hPDgM6SajBrcdXiV6c4JsUrjQr2J9nOko0keF3GHIJhBQHKzq3aGzeCxQfSG0g+IMHPJk2RwWSCjRRnboRbKp73Uq+7pLT9tUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=369SjlpK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Ktl0LMK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740557836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CwGly1HXxpkLn2OIFTuLqo8Hjh9s+VugzRiY7C5Net0=;
	b=369SjlpK95bYKlOkmpngB7zY8K9Jfke/9vgjImAghG3gqv/V+gGb3UErupD+nyuBl/JKG0
	PHxWZ3jbVnPU4o1SFqEmAX0MW9sljhgM0alpYlWf8kTeKn8RF1sIy+SWSLKjf7N0ZoLXdb
	R2iaM7AYyW2wex+d2GE90EcT2yO64s+moSZkVQke4c9NApgc2C1lx/djKRA8j8rx/9j12C
	03Tcn5SuuxysyVdTYkMGvnh0qU6XYgGATamr8ToKg9ZsBXSTBd3dYfKm/fm6WYBgzsKAnC
	2mZh21eCjk8mSFgvjEDPZ/CjbdAxDcel/UotB39tVNJHyjS+gi/LJ80y0QHPew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740557836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CwGly1HXxpkLn2OIFTuLqo8Hjh9s+VugzRiY7C5Net0=;
	b=1Ktl0LMKyHy4BkKMBSf3x66INzXy7o4SYncguCNaLCBULd5dhQWNiFAfaFuyGli5cWEvvX
	mNmV1bPrSvutsuAg==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>, Waiman
 Long <longman@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH v9 11/11] futex: Use a hashmask instead of hashsize.
In-Reply-To: <20250225170914.289358-12-bigeasy@linutronix.de>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
 <20250225170914.289358-12-bigeasy@linutronix.de>
Date: Wed, 26 Feb 2025 09:17:16 +0100
Message-ID: <875xkxf7cj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 25 2025 at 18:09, Sebastian Andrzej Siewior wrote:
> The global hash uses futex_hashsize to save the amount of the hash
> buckets that have been allocated during system boot. On each
> futex_hash() invocation this number is substracted by one to get the
> mask. This can be optimized by saving directly the mask avoiding the
> substraction on each futex_hash() invocation.

As this is true independent of the private hash muck, this should go to
the top of the series, so it can be applied right away. Aside of that it
spares the churn in the new code ....

Thanks,

        tglx

