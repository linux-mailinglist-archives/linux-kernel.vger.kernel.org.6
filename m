Return-Path: <linux-kernel+bounces-226082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 884909139F8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 13:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2B8281BD7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 11:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFF612EBF3;
	Sun, 23 Jun 2024 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lrN6pUi4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6EqQR5r4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1B364D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719141844; cv=none; b=WBblblFUFJMJcEZkxkOI/L2Uvupp+HTPd8ma3pZrjF4bivuAfJwd1usH7JNVESxhjJoyiq3s/y473tGlStPzBBmXGaEZaoawiNS/XNqDYWEjN4a4RxPK2aW9aNf/07pxKQ3w2NPNjYpWwih531qU6oEzjzYI4FLsBYHdCjHuVkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719141844; c=relaxed/simple;
	bh=UYQIwztegm3GPLyi1hQoDaDZYjlZXTdmSuTvh1AEnDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N3GB8j3teLgUKOgz11mU7z9xvfzlC7nXbs+Avx4ArZdhCpRb0s/itEtmBMiD63LHZWaIMx7WpM2oFS+jDjgI5fYpXKqNc/RMhBTRwcjeGOx7TXKaXwtrvA2h1GCbzLB+dkr1LhHaZ6IROCHMtuuCopVy9kTCqo2yEbNdze3gTQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lrN6pUi4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6EqQR5r4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719141841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FBoUra/GyAeym75/LNPWqrCBSpEs3r36ctsPheHQLAI=;
	b=lrN6pUi47ScJqvQXi0gaIWsFLe4vTfcBSBAYCl+b38MZDgMcRPmp1RGPwjU2vCykn+zS5Z
	08EzelUi36Bt3/dGgku1Rsz5QBeEuj8XUAGOuF9GLhehEChsxHAm6Q79yXMkEsbLpV7g1d
	8uH0AW5EmetdJIxBubNbycpzBENOU7FimdmNDA0of9gr/V+9TIKzJxr1WhgwWDpzEnmDHh
	voKnCZLWNnNt1LjAOcTpIheGkTfeSDUHw0eRZymJIu2LZ+GH4TG/tmiB8aRE7Eyf8PKcFc
	hLSGQJfuZzJialrjSTZ2U/xEZ9T/yyZVa47Jgg1fo7eBU8dwxjRHaMzI5rqpXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719141841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FBoUra/GyAeym75/LNPWqrCBSpEs3r36ctsPheHQLAI=;
	b=6EqQR5r4UVYKPr45WuKKd1+wQPFwR5hs+yuxGJeT0Vwd4yr9/scoyQ6w/01qKDRDiTDH/l
	KPN77EvDntfcIVCg==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, John Stultz <jstultz@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen Boyd
 <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg Nesterov
 <oleg@redhat.com>
Subject: Re: [patch V3 00/51] posix-timers: Cure inconsistencies and the
 SIG_IGN mess
In-Reply-To: <87v82gufru.ffs@tglx>
References: <20240610163452.591699700@linutronix.de> <87v82gufru.ffs@tglx>
Date: Sun, 23 Jun 2024 13:24:01 +0200
Message-ID: <87o77ryka6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 11 2024 at 08:58, Thomas Gleixner wrote:

> On Mon, Jun 10 2024 at 18:42, Thomas Gleixner wrote:
>> The series is based on:
>>
>>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
>>
>> and is also available from git:
>>
>>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git posixt-v3
>
> Please use:
>
>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git posixt-v3-1
>
> There was a typo in patch 39 which I missed to bring back from the test
> box.

Updated to:

	git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git posixt-v3-2

