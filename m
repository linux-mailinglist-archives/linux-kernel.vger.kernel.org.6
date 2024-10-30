Return-Path: <linux-kernel+bounces-389733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9799B7090
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8061F21EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ABF21745E;
	Wed, 30 Oct 2024 23:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3UQ6Yjao";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3xANON6g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07EE19CC24
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 23:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730331310; cv=none; b=A2OuLcmKG7vUdJ9WdVCdDwfkO5xwvSTPIHCUbZhZaFAUB3DHB82VxCeDG3umXr1yzS7M3C7vRP0k/PRIdEAyp1IKvZem2ukCK4BsvbLiQS7CSaIVHGi/XasWdDiWAapeMolkzySCIFVqEr6xDFkNDneipGa1yxXdws/rPwo5xwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730331310; c=relaxed/simple;
	bh=B0JnH3fWtHBJBnRW7ir5jY7H0YifrHSjpk08aNHXnoU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YWcXQX9AlLAYsh6hzrnCr4P3+8woH6V1JIksAnZdYsLxuGNYrH0p73CnFlE8xsD/6TVUYrnpCHnebBWrceUzhzDkXdOMwSOnOTrWI26kadBz2kbDc+OKt5qmkTBU28f7m8qg8fnmIua80VGytlmaPfBs3LmkXf5osFtzqfuclko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3UQ6Yjao; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3xANON6g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730331307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JuEPjoZNp/DdkiPVGMh5c0Da91iH6+YMDl/HeYiaNwQ=;
	b=3UQ6Yjaox7wPu1msX1jA3Wz24igjDSImEaQFxsjRL1aWq4NtgXzfR/JduOrD8QpYMRzflk
	bfmPG+Q1Dw5idBNpU9UxPbJyfp8mWHJu0mxJE/dkhfY4dPPk2SOPaH418++elQenJklgEt
	1V9q2PB8ZNZS4lsId1bVjbpPwBDxxbYR6yzN3Mj2fZSrRUYDpQ0Wo4kuKifUTQbHKNQcSA
	tgVjWrMceTY03RqbOgP7xrWIK7HLEwzznrBzRAcBrYBwM8Mm1xcSRaeSvxx9k9/1PIo0kw
	DykSlKYwmU++x/HlQATtOaB7Op8bThSCnpCjVieacMK824DdJ+TvBLQpKK15Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730331307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JuEPjoZNp/DdkiPVGMh5c0Da91iH6+YMDl/HeYiaNwQ=;
	b=3xANON6gvXVCVph9OXyLP/3DwoA/njmqLLZvcMSHEV7vi24R3b/dF0CrD4xOHwxZ9ZrQDa
	dt2hb9Ym326Q81Bw==
To: John Stultz <jstultz@google.com>
Cc: kernel test robot <oliver.sang@intel.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
 linux-kernel@vger.kernel.org, x86@kernel.org, Marco Elver
 <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Stephen Boyd <sboyd@kernel.org>
Subject: Re: [tip:timers/core] [timekeeping] 5aa6c43eca:
 BUG:KCSAN:data-race_in_timekeeping_debug_get_ns/timekeeping_update_from_shadow
In-Reply-To: <CANDhNCoUyqvFa=mqrXra2KQ4ryeTnj-HkO4y8cxtQJyYZWz-2Q@mail.gmail.com>
References: <202410301316.e51421de-lkp@intel.com> <877c9qynxo.ffs@tglx>
 <CANDhNCoUyqvFa=mqrXra2KQ4ryeTnj-HkO4y8cxtQJyYZWz-2Q@mail.gmail.com>
Date: Thu, 31 Oct 2024 00:35:06 +0100
Message-ID: <875xp9xiz9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30 2024 at 15:16, John Stultz wrote:
> On Wed, Oct 30, 2024 at 1:50=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> But that aside, since 135225a363ae timekeeping_cycles_to_ns() is fully
>> overflow protected and unconditionally handles negative motion (before
>> it was x86 only), the value of timekeeping_debug_get_ns() becomes
>> questionable.
>>
>> I'm leaning towards removing it completely.
>>
>> John?
>
> Yeah. I could be wrong, but I'm not sure of anyone beyond myself that
> has really utilized the TIMEKEEPING_DEBUG logic (and I've not enabled
> it myself in a few years). I don't think we've had any problem reports
> from it either.
>
> So no objection from me.

The question is whether we want to preserve the remaining 'offset'
check.  I.e. either discard it or make it unconditional? It's cheep now.

Thanks,

        tglx

