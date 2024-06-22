Return-Path: <linux-kernel+bounces-225726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE5C913474
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 16:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DD62827A1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 14:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD4A16F85F;
	Sat, 22 Jun 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tke/RUH9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15D99449
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719066513; cv=none; b=VpFUylmnRDufuLKhEougZrv/QD52hRpY9LRUIk5bYqJ0x1qLZSQPfcAXEetjsBGHglX2swwURCpL/JIF6+98r3IltW6mZjgjfpLeDVLwy29SIeBy7QemLMOpJFLx+3r6ZimWoDvK11c4ciGtaz6zzNPjMearh3j3Ng365y1Hx/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719066513; c=relaxed/simple;
	bh=KLXnVjUI6RkuXoR9g2wfUGEQaGHF7OLnWXplDDSze34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKNQ1STGLTsbIf6iEHNwT5YS25K+sQ94fZVg1vmItU5n/QAlOW9RsigOEWZwkd7ka+SxDK/YOxp3GGvPEIyUmenGszOzuwc5b5onN6sjQiZDTNvCZVPD/LzPrmlpprCTJBRasgcu5eckYYAX/miE9p5h33DG+pCsB6c7uq1NVPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tke/RUH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5016C3277B;
	Sat, 22 Jun 2024 14:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719066513;
	bh=KLXnVjUI6RkuXoR9g2wfUGEQaGHF7OLnWXplDDSze34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tke/RUH9Y+VrYJvRg69+CU5tGMhz2tl1zvu2b9qNCIWNgDwmSbvudPOagaH8KDvna
	 vF8UEvijWp5OvZhL7ZtYIvKzp9hLiZUlh3scQDEg1n3+HhuHslDux9KEdDtt5lyaE+
	 8DqAuabIWPi2MQcVrKA7Nld/wB3TtiK+LIWlmXC9rYe94O4kFG2EiapY8PA7QEmWHy
	 GPXFVKdEb1iQLHqILIeLTmnb8dVQOQ7qALrwbggWIb51HUyQLPrcNsbBpakT8TmEk8
	 aujSoyetfDI78C6DGq9wEC5fvdMnZ5s1Hpkad6w7sIftvBy8J4O+wlMJRVlhr5ibNy
	 yp+vams7k6FRA==
Date: Sat, 22 Jun 2024 16:28:30 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V3 10/51] posix-cpu-timers: Handle SIGEV_NONE timers
 correctly in timer_get()
Message-ID: <ZnbfjgGV6cqT3ILm@pavilion.home>
References: <20240610163452.591699700@linutronix.de>
 <20240610164026.099214180@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610164026.099214180@linutronix.de>

Le Mon, Jun 10, 2024 at 06:42:17PM +0200, Thomas Gleixner a écrit :
> Expired SIGEV_NONE oneshot timers must return 0 nsec for the expiry time in
> timer_get(), but the posix CPU timer implementation returns 1 nsec.
> 
> Add the missing conditional.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

