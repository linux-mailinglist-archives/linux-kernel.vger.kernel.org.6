Return-Path: <linux-kernel+bounces-518256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA26A38C57
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FCC1895B17
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F092D236A84;
	Mon, 17 Feb 2025 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AH5+aoas";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s0djRNZ0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80F023645F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739820345; cv=none; b=lgJ04d2PgTlhhWUXrR22RFof2KOT6y5tNAwdtvAsm0yC5Fu31x6t92C3bjpvBkRKfdiOlOdwH1UCLisCWkGHkbN5PND0dwAiigsmTWUAutkB/e5wWSzyWGX+c17Fg/8SQT9sujA/5Kz67nOTpdvayOkBaZtwgBQFtr52lGv1GpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739820345; c=relaxed/simple;
	bh=9Bg68HEW86azruEu9jxQkScZgv7ruvEJl4XBC4kp2KY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oLIi8oFNSXRYDIhN0u71Q0T/QkykuShBn52dgFW0aD9VpTH5QvLJ/vbUXEjPwwoNSBHyEqomgKtOtXXunR0gAdQSZ8WtTquk/83Br1G+jMGOTP6qLjR2qSR0jmVllkXbTZ7U2g+8fV/1Z7yEiADbn1KdKsPSYWr1Xy7C+Yz8gGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AH5+aoas; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s0djRNZ0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739820341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XcLIgubDyx112NcTEUntYR2RwFWy3FKFfJsT0gklaPA=;
	b=AH5+aoasjLdY8QEDhIjebV15DeVa10OY5H4Uwkb2f8xJHY41rrIR3ZbxQFbEhXHZG7YoN+
	oqVRLHlW5WAibaQnK9nhXdIzrm3AzXg3TxeF9EwQZZIaSU8TaK2V+8lNVzwLhmbN5o2WxL
	soVKggf4YF3TeqIVD6eRVcYJ7d00TAs9OCw9hRZxJVdChmuoM3sYTQQLqslHrMHYiQJf0p
	WsXEArfAjfFne/CtsSLIw9m+Bz/k4U5U+yr/6H+d5jxokDRu17WG6bSLArnvvno1KPw8Bc
	TejdAiCmrVrnfWOB7REGd/cV86oeaqNDXw7t+J8xzhqMKpr5OWGJybLn2w4bVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739820341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XcLIgubDyx112NcTEUntYR2RwFWy3FKFfJsT0gklaPA=;
	b=s0djRNZ0NE4Egs0oPS7OFU9lfMFnZslbnHO+zBWXlCD1qOUD2NDMCCHXUWCxqYeVgJ7DOw
	Tyxb3c+A32H62QCQ==
To: Eric Dumazet <edumazet@google.com>, David Laight
 <david.laight.linux@gmail.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Benjamin Segall <bsegall@google.com>, Eric Dumazet
 <eric.dumazet@gmail.com>
Subject: Re: [PATCH 2/2] posix-timers: Use RCU in posix_timer_add()
In-Reply-To: <CANn89iJjsCe+Yk6Kn8OUTqPEnSfbZv_gVhqByAYaY+pL2V36Qg@mail.gmail.com>
References: <20250214135911.2037402-1-edumazet@google.com>
 <20250214135911.2037402-3-edumazet@google.com>
 <20250214165904.33b73dc8@pumpkin>
 <CANn89iJjsCe+Yk6Kn8OUTqPEnSfbZv_gVhqByAYaY+pL2V36Qg@mail.gmail.com>
Date: Mon, 17 Feb 2025 20:25:41 +0100
Message-ID: <87ldu4jruy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 14 2025 at 18:48, Eric Dumazet wrote:
> I just noticed the rescan is racy anyway, because when the other threads add
> a timer, the timer->it_signal and timer->it_id are temporarily zero.

Ah, you noticed too, but that has nothing to do with the rescan. That's
broken already today.

Thanks,

        tglx

