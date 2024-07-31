Return-Path: <linux-kernel+bounces-269553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3925294342E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C29D1C221EE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A6E1BBBF3;
	Wed, 31 Jul 2024 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LRecKFH3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hqlAcB+G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A36A1773A;
	Wed, 31 Jul 2024 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722443614; cv=none; b=uo0LEUca+3QiyYDnlqAR6JVOA7BS4Ytkxt3KkZpmed0dhSiiiEz6Lzv6iL1r7WbZ7SL778prdBBFgNDwAsP2R6QXYzAGnsdGOhGCNeeIt88qJmWrBZPFFcvTMinYyxVW+Jj4yZcTUghJx5ZS+EMJZAb8NKp84TMzxaFhhtdsPFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722443614; c=relaxed/simple;
	bh=o57cNR5ti4i4fzmDZpGvXRr0ZLTnwEv3gVMCdguFiog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V24AHvRKbyZVWtIwRn8Hm1R27NQ5oZB+Zl3rIhbDTzbKfDDqiCUWwivbBhq9y0tUW4caw5LokLZ71kZdlsjsFnXOG/VGzHEH9u1yCznVzFuBMrS9FAWKLJ2QoYT1wwED+Av1yhfJv58/wIFvVMItaRfsjfP8EcWHS8TRszvoh8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LRecKFH3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hqlAcB+G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722443611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RlAFzh33b9VSrJ2A7ge/uqdPM4bNaaWEd8D1hoHNneM=;
	b=LRecKFH3frU1Y8UxKX4QHH7B3N9DK4xDQGTtmqlwGekzL/sYnSed/21YFM4Vjcq0KGIugs
	MT4Vafvv2oJrZwX0RjVtPVgVM3SuoxW/UzkJ/7UIhyYUhZalZ68D529av1uxc3uOfl4VuX
	1dfcpLjzvjWrMqNN5znjUyI0O/Vz4S/jVpIqdyqcN+6tJq3QOf3lkCs+9f85Ue1C4aQhrr
	0cNo0GVM30lqVUMx4l7opHQ5O099TW8erVX/KgyaDtnql+9FBlL1mPJ8ROz4rGUpLLxQf7
	0C6kBT1p9NH2E5gGno7pZuNZUxxuj6y3kEgRRZWFxVE9CVZqSLqErVbc5WrJOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722443611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RlAFzh33b9VSrJ2A7ge/uqdPM4bNaaWEd8D1hoHNneM=;
	b=hqlAcB+GZY5+dICvjphzMwNgNJl9WN5bxwbSIeKi2x0zKb4DKBiRFeK/dH0iE6HLwm22M+
	lQoawFmvBDI0TBBw==
To: Marek =?utf-8?Q?Ma=C5=9Blanka?= <mmaslanka@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Rajneesh Bhardwaj
 <irenic.rajneesh@gmail.com>, David E Box <david.e.box@intel.com>, Hans de
 Goede <hdegoede@redhat.com>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86:intel/pmc: Enable the ACPI PM Timer to
 be turned off when suspended
In-Reply-To: <CAGcaFA1HJBYacvDAkZAO9HNhT2dZO7OdgcBYb59p7OJkVqQ6Fw@mail.gmail.com>
References: <CAGcaFA2sQNRo9UThN-C1NOLtGUJ3sKzc=pEC9wdDWMi501iLsA@mail.gmail.com>
 <20240730120546.1042515-1-mmaslanka@google.com> <87cymu7tgq.ffs@tglx>
 <CAGcaFA1HJBYacvDAkZAO9HNhT2dZO7OdgcBYb59p7OJkVqQ6Fw@mail.gmail.com>
Date: Wed, 31 Jul 2024 18:33:30 +0200
Message-ID: <87h6c55xnp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marek!

On Wed, Jul 31 2024 at 16:44, Marek Ma=C5=9Blanka wrote:
> On Tue, Jul 30, 2024 at 6:08=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> On Tue, Jul 30 2024 at 12:05, Marek Maslanka wrote:
>> +static void acpi_pm_disable(struct clocksource *cs)
>> +{
>> +       acpi_pm_enabled =3D false;
>> +       if (enable_callback)
>> +               enable_callback(false);
>> +}
>> +
>>  static struct clocksource clocksource_acpi_pm =3D {
>>         .name           =3D "acpi_pm",
>>         .rating         =3D 200,
>>         .read           =3D acpi_pm_read,
>>         .mask           =3D (u64)ACPI_PM_MASK,
>>         .flags          =3D CLOCK_SOURCE_IS_CONTINUOUS,
>> +       .enable         =3D acpi_pm_enable,
>> +       .disable        =3D acpi_pm_disable,
>>  };
>>
> Thanks. I'll try do this in that way. But I need to disable/enable
> ACPI PM timer only on suspend/resume, so I'll use suspend/resume
> callbacks.

Why? What's the point of keeping it running when nothing uses it?

Thanks,

        tglx

