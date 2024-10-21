Return-Path: <linux-kernel+bounces-374164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1609B9A65D5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD8A1F240B3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED4D1E3DF9;
	Mon, 21 Oct 2024 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luDMM5Xy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA78B194A74
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508711; cv=none; b=VJJzj0eTht8eWA/xt0g2ZWovRm3FZ8ILcSmmwIfd8GLgMisJ4Tn1en8VvckaIV77vRUBm+XZcVEZF0pi1Z813M2cqFXbZK9HelRJwquRL9UhXpE4htvEm9rSJbYL3OVFFr/xeH9JwzryHuyXiiFKTd2qziCbQOC0iG9diy5gfN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508711; c=relaxed/simple;
	bh=UyGDgKoWVUUeci4R76dyiNyfcbtUjLfxbc7XEGATn5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZclSJz6MGljMhSkm6n0CtIJ9MR43wMucSNN7Cp8YdhZzkz7tvXc3uB8i0k/Rk5aNoIf7+7BQkR/d9g9h1Nbos72WYR04+q6bcSHWr2dw6/OOkUse15xDojw6kmxlGDp8XH1+ZZuvaM+dw8PTRTXGqPFONp9vCfdASTPzGNRcce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luDMM5Xy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA664C4CEC3;
	Mon, 21 Oct 2024 11:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729508711;
	bh=UyGDgKoWVUUeci4R76dyiNyfcbtUjLfxbc7XEGATn5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=luDMM5Xym6EOcsNYLar/9I3Qrc6uO6MdmV6nQrqt136eqtTpcyUvJaRNECHzFueBQ
	 MzJqUp4pxnwobwwx3yFoCf88OYCU7WocvZu0eKFySPRDE4Yh7mt0FEdRF9Q8qUAflX
	 8mNYQJQrg6XKwn/Yx/Nt6G+R8nK73RnIBWZ7Mo8WO6D96YM32kLgP803brZNWxppKs
	 ZY4M8ZB44xkxfZvO8hWazNd3NZ4VeQEE+1mxk9rBVDqXHSW9iiirkffmEvlOvdmsh+
	 qK9ZZQEE1MpYDc/AgAMxLiX7NXE4G6P6uS4jKj0uV2k5IZAr64dPToXJmdG5rRRkAD
	 Db5Ky7khstWIg==
Date: Mon, 21 Oct 2024 13:05:08 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 03/26] posix-timers: Cure si_sys_private race
Message-ID: <ZxY1ZOZe2FI6xoKX@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083835.434338954@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001083835.434338954@linutronix.de>

Le Tue, Oct 01, 2024 at 10:42:03AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The si_sys_private member of the siginfo which is embedded in the
> preallocated sigqueue is used by the posix timer code to decide whether a
> timer must be reprogrammed on signal delivery.
> 
> The handling of this is racy as a long standing comment in that code
> documents. It is modified with the timer lock held, but without sighand
> lock being held. The actual signal delivery code checks for it under
> sighand lock without holding the timer lock.
> 
> Hand the new value to send_sigqueue() as argument and store it with sighand
> lock held. This is an intermediate change to address this issue.
> 
> The arguments to this function will be cleanup in subsequent changes.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

