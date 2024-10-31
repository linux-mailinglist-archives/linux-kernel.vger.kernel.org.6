Return-Path: <linux-kernel+bounces-390376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D07239B7914
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56C48B2642C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868DF199FA7;
	Thu, 31 Oct 2024 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yTc3/1gd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/FLf/ib7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A0F19994A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371996; cv=none; b=Vtp8pSLooS2CkFHWBWF4/2ThL+arOBiJuBHvLVVLtOJraxEe83SD4akxGiztbzrxS56+T5yx8Hn8ZreBYr0LcEVQdMD6/PMEG2hWgsfd77zUHWXet2kcS5iPwKjOi1ygLjbwOsVx9MVI6hJF/cCGtb5NJkKcQaXHqpuQbB5Y0ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371996; c=relaxed/simple;
	bh=fXtDRJFCa3ldAEOUaaO0UUXdEZ5V5XpVqTmsvFPnvb8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qvd/Co5T8kZwPtjP2A1bPU6hROLKetwH2/4MuXGFT7gcNe0FHqMu3FenMr8JYGIQrw+Z/zJx5+I337yZI54V/4wCUWbujyZuxKGAGZEdis/F0P6AZTHcfLn9Tal8jc0oCZ7w/tv7XiO88FgGUYQZmUDCZn7Y+wye1J7fci7vTBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yTc3/1gd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/FLf/ib7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730371992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=reJzwqeCgUrSYV3R3kSWEuF48Zjhv6UwU1xGJaMqSxI=;
	b=yTc3/1gdE4c270Q2o3Mm2rN0c0onRcWa0Iqdj+NwRudUVOwT+HkcYrI61yGkdDvB9Xarrq
	Fs+onaHqG9t1AupnCoc/Ob1j6fAV/dNyEOHsLsLNkdXAemvy22SwnCAl/8jxK08s6dwA/i
	EJ1ncvmczQULBUJVU40YIn3qjtS1AxQSQIb0llVojvB/LenQYzYSZ6YjejHiutcl+FRLtk
	7PBpVKhDTaJG2Ml7LTmA+sVhDYIujrC3GQIh4+3ufFHI6qWaT7Ps6eGhGHQU0rbCMFkBdx
	OYVRpjTj8cXxjRu5z6sCtx1ycXv82/AilQDEyELgPeydXvpdRu1GNZRh7JknoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730371992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=reJzwqeCgUrSYV3R3kSWEuF48Zjhv6UwU1xGJaMqSxI=;
	b=/FLf/ib7lZo8YU4Jv1DjoHizEriYN6GzC3AjhXMMS/1wclI/x9JETPuu1v+nRYSBQjydj3
	VoqeahcKZWT6U8Dw==
To: John Stultz <jstultz@google.com>
Cc: kernel test robot <oliver.sang@intel.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
 linux-kernel@vger.kernel.org, x86@kernel.org, Marco Elver
 <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Stephen Boyd <sboyd@kernel.org>
Subject: Re: [tip:timers/core] [timekeeping] 5aa6c43eca:
 BUG:KCSAN:data-race_in_timekeeping_debug_get_ns/timekeeping_update_from_shadow
In-Reply-To: <875xp9xiz9.ffs@tglx>
References: <202410301316.e51421de-lkp@intel.com> <877c9qynxo.ffs@tglx>
 <CANDhNCoUyqvFa=mqrXra2KQ4ryeTnj-HkO4y8cxtQJyYZWz-2Q@mail.gmail.com>
 <875xp9xiz9.ffs@tglx>
Date: Thu, 31 Oct 2024 11:53:12 +0100
Message-ID: <87o730wnl3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31 2024 at 00:35, Thomas Gleixner wrote:

> On Wed, Oct 30 2024 at 15:16, John Stultz wrote:
>> On Wed, Oct 30, 2024 at 1:50=E2=80=AFAM Thomas Gleixner <tglx@linutronix=
.de> wrote:
>>> But that aside, since 135225a363ae timekeeping_cycles_to_ns() is fully
>>> overflow protected and unconditionally handles negative motion (before
>>> it was x86 only), the value of timekeeping_debug_get_ns() becomes
>>> questionable.
>>>
>>> I'm leaning towards removing it completely.
>>>
>>> John?
>>
>> Yeah. I could be wrong, but I'm not sure of anyone beyond myself that
>> has really utilized the TIMEKEEPING_DEBUG logic (and I've not enabled
>> it myself in a few years). I don't think we've had any problem reports
>> from it either.
>>
>> So no objection from me.
>
> The question is whether we want to preserve the remaining 'offset'
> check.  I.e. either discard it or make it unconditional? It's cheep now.

Nah. It's irrelevant now too. Before the time getters gained the math
overflow handling this definitely was a problem, but now it's just
noise. timekeeping_advance() can handle that case correctly.

Thanks,

        tglx


