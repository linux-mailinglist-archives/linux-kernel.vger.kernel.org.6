Return-Path: <linux-kernel+bounces-251471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78547930542
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 12:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6D71F22747
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 10:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7438D7344C;
	Sat, 13 Jul 2024 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c2ffxUM7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CRdsaUR3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688A15A4D5
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720867681; cv=none; b=eHSzHPOTXL2oNYH7dBu0qvYxgtR68oHTZO2xoyZvUH5oTsJtNCAstH/fk5DZZLMvX+l9EWHdbUNVp9DmTABrrFO68wmBIc3VoKciaQo9emyUvJr6UWBBdkv2u3ZxsxiH+HaENuq3jU8SkZgDawdoEkdQ8K3mMYTbAwyrpA0wxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720867681; c=relaxed/simple;
	bh=AqIlcLSOALay0HKiXe/4fbdiftxMK4fr5uT/Rg81I/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LYvEext5m9xZUV24jCU5RldrwWju6iVk66i10kwE3YCoN5MZLaNLfxhaDCJDGlzDtqLKPxx2czcIHQo5mGN46i0BX32qpnA3MmVfFEi8pa1D0BxLil5Fou3RNpFfGBFxWzgHQLcHqD6fueW+3A3T1g2Q26E4imKb0MIHRi6ISx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c2ffxUM7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CRdsaUR3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720867678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjLw0Ctbt6siUlh5Wx4jQc7ldtpLEGpqvbAxrNBgyhw=;
	b=c2ffxUM7LbsgUpn3KdsTBIrjCpNWP7GQu9m2RAv6PYHjyHfhuc8N3Bc3UtH24tOwrEciz5
	LYI8vIv6z26bwwU5Qz5iqJCXdZxW3UWFj3iTtFHlYMQsUlpG3IhXefKx3eVd1kOdc8m4vS
	0+l12K9tOYTWPBF9j0AedRMRAJbJdJxBSG8Lea+CZUQGhEO5AkioawJ3pbrgZV7y6jVDbn
	TlHcXnf6NnqcE11M7ihKVBmi5w1SeDJYwf8/Il4qVKurzphIoQBnvudb4KV/4Gv1P/+Hjk
	6Ka82k1T3mjIm1l/VQj01WvhyL5WCYrS0A09WQCc56ixuoB+KwkIz5oOfvSvKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720867678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjLw0Ctbt6siUlh5Wx4jQc7ldtpLEGpqvbAxrNBgyhw=;
	b=CRdsaUR3Pq+TBBaZp8J2flZABq/cazcX2MlSjWJYCUAsqmkWJ6iXdMR+0lHxF/dJQ+VgEe
	psNCTGCRE6FE0/AQ==
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, John Stultz
 <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>, Stephen Boyd
 <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michael
 <michael@mipisi.de>, kernel-team@android.com, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to
 cleanup freezer handling
In-Reply-To: <CAOf5uwkR2TpXN=+D2Gz1M8MDfZn51g1Dqv6eFxSfciBSVA-f=A@mail.gmail.com>
References: <20230211064527.3481754-1-jstultz@google.com>
 <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx>
 <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
 <87a618qlcp.ffs@tglx>
 <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
 <87sff0ox1a.ffs@tglx>
 <CAJZ5v0iWZqAcbqdTuKbo35Gk6vNS0h9De20GDNZeZvqfhQiSWA@mail.gmail.com>
 <87zg8ukd54.ffs@tglx> <87wn3ykbfa.ffs@tglx>
 <CAOf5uwkR2TpXN=+D2Gz1M8MDfZn51g1Dqv6eFxSfciBSVA-f=A@mail.gmail.com>
Date: Sat, 13 Jul 2024 12:47:58 +0200
Message-ID: <87msmlsh41.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michael!

On Thu, Jun 27 2024 at 09:46, Michael Nazzareno Trimarchi wrote:
> On Thu, Mar 2, 2023 at 11:58=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> >> This appears to be still somewhat racy, because the notifier can run
>> >> at this point AFAICS.
>> >
>> > Indeed it is. Let me think more about this.
>>
>> All of this is inherently racy as there is zero feedback whether the
>> event has been consumed or not. Making this feedback based is not
>> necessarily trivial, but let me stare into that.
>>
> Sorry to come back on this topic but I would like to know, if we can
> find a way to be sure
> to not lost wakeup or if you have already addressed in some series

No. I did not take care of it as I got distracted with other important
stuff. Feel free to take up the loose ends of this thread and make it
work. I'm happy to help discussing design choices.

Thanks,

        tglx

