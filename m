Return-Path: <linux-kernel+bounces-388909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F39F9B65F8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D60AB24437
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E6D1F890C;
	Wed, 30 Oct 2024 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V3Jx+23/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EDbN/Gdf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131DA1F81B5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298658; cv=none; b=WGuPs3C7YQKeZtIvQ3q4ZRLHSrocuDaQIoZaXYo8j7RTBC9tXHLMoptyQj1sPX7ejTDVAb+X3LwC5jfll8UpKcQY7AhwryNuMGNoLe9Iw6XlPAOgroJgEUY686sMxBDC6LuEp2wHUIqiABZNNneF9hXAIV/FOi3vnNQuEBIPltg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298658; c=relaxed/simple;
	bh=cnZcQekVIesIcpH9eZrcEu75hrrmn3NaXLEwk6ncvLE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QCm2q/P2yU1e8pDQTCFlgsPNVyJVfu5plcsoXxDuZ0k+zfim3vIFMcAoBXikH8T7camg4TuShpL7eshJyUC4xBpp3ixnKq29bxlT8nXRgbLaCZeD86DHgNDK2BrucE9kQGlsFCOlDES4g/xcEQh1ESaHLGZft5alL673jXm317U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V3Jx+23/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EDbN/Gdf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730298655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ST1a5V1ZJZBTD9htK0r3oK86kykATwN8iJFtxFP2nU=;
	b=V3Jx+23/DTDdt/8l3Z0NdWU67Y3aVdbh4AHM7CL4lMsKFCu6nt8n0X5mB6hRMbXWq8ELWL
	4FLVrtNaRcTVfbQjRlJMFhVXMsahlKqeCe1LbpYa85AAbwAAp8qTkrzbuSqI+OVRE8zTL/
	P1otUlGm10LEJZtYzkfyvn4QafWIRMvZf/oxwWUopFiXYfUZtQt3F19a/f3Vv/NhYLfuGx
	pNTuXAdp1P+ALxoOmJtKe3QLzs/DOHiLoH1TmvxXGWQWzn+8z++PCoU+adHwgo2Sp+cdVo
	wIFZ2fYCKwS88xiTuna2JpEi0ehn0+MAgRlHgE3YiDuh7/RC+5qjVMjRqstrKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730298655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ST1a5V1ZJZBTD9htK0r3oK86kykATwN8iJFtxFP2nU=;
	b=EDbN/Gdf82rRXktbV8jqG68IbR+/rzI3LLL9nruutiE7TyJ2lYIGz+/vmh5I1ZDmvC3XVc
	Vm1klBAj8xl1nrAw==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 17/26] posix-timers: Embed sigqueue in struct k_itimer
In-Reply-To: <ZyI6zrXDmAQlvc-B@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.279523831@linutronix.de>
 <ZyI6zrXDmAQlvc-B@localhost.localdomain>
Date: Wed, 30 Oct 2024 15:30:54 +0100
Message-ID: <87wmhpy869.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30 2024 at 14:55, Frederic Weisbecker wrote:
> Le Tue, Oct 01, 2024 at 10:42:23AM +0200, Thomas Gleixner a =C3=A9crit :
>> -	if (timr->it_signal_seq !=3D info->si_sys_private)
>> +	/*
>> +	 * Check if the timer is still alive or whether it got modified
>> +	 * since the signal was queued. In either case, don't rearm and
>> +	 * drop the signal.
>> +	 */
>> +	if (!timr->it_signal || timr->it_signal_seq !=3D info->si_sys_private)
>>  		goto out_unlock;
>
> It could be:
>
> if (timr->it_signal_seq !=3D info->si_sys_private ||
>     WARN_ON_ONCE(!timr->it_signal))
>    goto out_unlock;
>
> Because if the timer has been deleted, the current seq should be differen=
t from
> the queued seq.

Indeed

