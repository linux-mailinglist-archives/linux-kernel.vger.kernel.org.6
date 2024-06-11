Return-Path: <linux-kernel+bounces-209353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27580903320
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D126F1F27433
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB40171E5F;
	Tue, 11 Jun 2024 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="smA6jEIM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y18WsFSj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80B2171E4C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718089130; cv=none; b=IPrOjQwEqj/BOGA4ssOfXeHTj4bBPg6Vrv0oXx/R6OvOTY3uMkjhwUQm5n5XH00eok8gENxmGaxt4Ai90rsUQYnD9hUNnqYaWMmvGaObQzxaVoNWNMEYp+ClGNkqyadzu0mXIhlW9ejWyl1j+iXzcUWKS+I3F4/WshZwUSL+ZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718089130; c=relaxed/simple;
	bh=+Cj/3yfWuBoLJrMU5JREalUOns606jeCPCaTJjWVmX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hIQODKhYDpUnlAKqMQGcwgskM/g+ZiQ9RnUk0ZZD586+E3HEGZnlN/soUZyd+jaEx/Vd1aaiwxmgA6/v33FZ4qBOK1TclVPZiOSd9+z/wKEkd+zZ+dRt9THtEyySz98L2vIade7RR6HxNvcOjzKd/fkgu4mO6CtnMUVrKMtHv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=smA6jEIM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y18WsFSj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718089126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nLBEeFByelBUYWlUFHwCgvv0xx7/BDY4XkjNKYsCtmw=;
	b=smA6jEIMI4qnSqRTTq5f5iNLZZ9O8V6Vj4SYwf4Af5FALnynYg7PAKLNFDFS2FxPHOUWDT
	8bT6s3jpv3rposXSKtVCEqnJl20E/nQLI1p80pRlbpbks0mFxTPPBDHQ7lvv04N3l+iuZb
	EiFLTDhdaG3WgkZFLwU2Dbq7GjuSZQ2Vk+0m0Ybw74u0gzlQNHM6AVk7XudEjqfNa0qczZ
	nUl4fD5N5Z3EDeBnoSulGVLVvaIiUvKD88kCwYWMUu8P/c21JJGdfZJvNbRxOiQuizhh1w
	+ZxB47dHmLTswj5KCyeiaQ5FUQ0y6Jrt/tVjhZYQkXhASgd4LgUWPCmhQQuXoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718089126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nLBEeFByelBUYWlUFHwCgvv0xx7/BDY4XkjNKYsCtmw=;
	b=y18WsFSjt2tH0XhGjiTRHnpj/DJGLmNPluF8kdq9flH9trkFf4GqeFIBgxSOvIAWZAguRC
	BoJKH8k+tsbIweAA==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, John Stultz <jstultz@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen Boyd
 <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg Nesterov
 <oleg@redhat.com>
Subject: Re: [patch V3 00/51] posix-timers: Cure inconsistencies and the
 SIG_IGN mess
In-Reply-To: <20240610163452.591699700@linutronix.de>
References: <20240610163452.591699700@linutronix.de>
Date: Tue, 11 Jun 2024 08:58:45 +0200
Message-ID: <87v82gufru.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 10 2024 at 18:42, Thomas Gleixner wrote:
> The series is based on:
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
>
> and is also available from git:
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git posixt-v3

Please use:

     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git posixt-v3-1

There was a typo in patch 39 which I missed to bring back from the test
box.


