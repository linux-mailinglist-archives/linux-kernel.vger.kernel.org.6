Return-Path: <linux-kernel+bounces-298259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC9195C4DD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D16A285D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5933C55894;
	Fri, 23 Aug 2024 05:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MB1FXToV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ih44hpdp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9849E537FF
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 05:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724390753; cv=none; b=PwAy6H8U4ecc4H6U2dkAzFaNmrQ9QIIOh5Bp1bIRvQDGg+3yUAMjUE6tSdjxSqzv0CKJrc1gIayEQyJw+GbMAriOxOFXeKH3bzahwaKII3Y4NbAd91Ycu3D5MOLQwrqAE/L87syGhH3JvIzDl0yBA5rfk5HCc+f6ZLpHqJs0hYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724390753; c=relaxed/simple;
	bh=RCstLFvZj+aN+REU2WycLBnkaxxobyrDUb7HKJ2P5W4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iMQ9xGUyIkcUfJFHtcutZF4GxL4zBoVhmNt4Hg2+bHOY0xJTCCx/59dXyU4GfFitShVQNbJDZn1HEBRLAUh/TQvgjxEb8zBz2oDzlpHn5tYdBTSusdilyfKhwgs48EW4uYmkvWnpADLsTDs74iJ00vM7JWMmum7ue8BfljItbXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MB1FXToV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ih44hpdp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724390743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCstLFvZj+aN+REU2WycLBnkaxxobyrDUb7HKJ2P5W4=;
	b=MB1FXToV2zVSc5j3IZKbOb2mkC3XAT/CQqm7A9nTrDgCzhy8SE66xekrg81w9f0QAFZakT
	ZJDzzGQ/JLJf6Il2fmaw+IhILLHcTgZsR66VrwZy3ZEzSScawjtsisxEszGB2OjvCjGK0T
	oouy9xeTHdkA7XCDeIijmjF80h41z8bv8PAzpYnUcQsDPy4MicXHR0ngINDDnEuEmUcij4
	zxUm0W1qjO1SN0bVV7hz6DzcDrAv/l2SPAcZERs3o0Pv5sH3NiU+Kq0l6HdlK96qgLYw+t
	vyAC14xx5CLyia3MbGy3eW0B8/XC1pYWcnTEGjq9nvaQ9lvYO39fDt3/0LY49Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724390743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCstLFvZj+aN+REU2WycLBnkaxxobyrDUb7HKJ2P5W4=;
	b=Ih44hpdpzHujoMxUG2sImKPeTU7aMhkjTVcJ3l7e8fq711hIkOZOySW9QbZg3FMor8eKRh
	KlIPlauxb4syfuAQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v8 30/35] printk: Add helper for flush type logic
In-Reply-To: <ZsWvRETyuh1Yq80j@pathway.suse.cz>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
 <20240820063001.36405-31-john.ogness@linutronix.de>
 <ZsWvRETyuh1Yq80j@pathway.suse.cz>
Date: Fri, 23 Aug 2024 07:31:43 +0206
Message-ID: <87le0nyfmw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2024-08-21, Petr Mladek <pmladek@suse.com> wrote:
> <proposal>
> Introduce a new internal struct console_flush_type that specifies which
> which console flushing methods should be used in the context of
> the caller.
> </proposal>
>
>> Introduce a helper function to fill out console_flush_type to
>> be used for flushing call sites.
>>=20
>> Replace the logic of all flushing call sites to use the new
>> helper.=20
>
> I would add:
>
> <proposal>
> This change standardizes behavior, leading to both fixes and optimizations
> across various call sites. For instance, in console_cpu_notify(), the new
> logic ensures that nbcon consoles are flushed when they aren=E2=80=99t ma=
naged
> by the legacy loop. Similarly, in console_flush_on_panic(), the system
> no longer needs to flush nbcon consoles if none are present.
> </proposal>

Sure. It is a nice addition of details. Thanks.

John

