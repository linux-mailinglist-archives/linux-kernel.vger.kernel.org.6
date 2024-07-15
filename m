Return-Path: <linux-kernel+bounces-252172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFA0930F75
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD0E1F21AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F1A13C682;
	Mon, 15 Jul 2024 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="d3Hqi/gs"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377C424B5B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721031649; cv=none; b=XphTYdM14O5nm4hA2NdkzIt8+9dzw1ZMb7hjhdNRak4ThIHhh5o/s20bbxdjZxhMlXWvv2ek487s8UkUUL6Ab7qG3D4nDLYhPFgt2HT4rWpMHlPRtQZ61NcHG1bnqIk6++xdquqITmHG8UH/OpPO3nJPOwH4tpDsaeA2QoqyNhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721031649; c=relaxed/simple;
	bh=0tgkYc8l8RcpXXx9q+ua0XGdjs2wrS2OwRu9uVHmG1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+9OuePL0mipmsY2lyrP/6GJyYu5VeT2nyLJlasRHgpXiSmhzjwWB9/JMR0u9EOFgIyugEWEG8rsImWXJvrFA189c6zv55S8NW+LArVI0Py4lAvldGlXo4zCR8PMXocu7a63ESNVduk6I2gLOl8FxwxOBaJe603B4Vp/uFrgr7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=d3Hqi/gs; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a77e7420697so519956166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 01:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1721031645; x=1721636445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xI6fm9F8l1yYe50CiLF5fRQC3uQfu1KIpGmxevOfyT0=;
        b=d3Hqi/gsshfgz/XcmT4hrvMqvSyxdC439ijQBVufe1S1BVQcbrDXtmRUYM1r465Wfi
         D8TTEGUsAeTql2XeFBlJlta4QlicOp/BrUxNrjbpgf+hDcDRXbIWWHhBLWpDntUX8DHS
         xPGg+HBoXV4VpXi7B+xRfPBq22lxGod2VXtjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721031645; x=1721636445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xI6fm9F8l1yYe50CiLF5fRQC3uQfu1KIpGmxevOfyT0=;
        b=G3WQugYBBjH7OPZLZZGMDrwPcfw/EU5tkGbwsGW+h5VclBzcZ4FqeCmtbsev6dC83t
         R5ZR7WmOyn7d3pZuXOTlUIfPDTGyH7y3a4m/emMQLJ1zBeDYP4k7AyQWI7aj02QyH7YE
         kidE6sgwdyTdkENM2i7wS6/S0T6HsILVZLCfmAdNowGKvGTlvJtViFFi2G+3W6DnLTSZ
         BeCwveabsekDyI4QA0El+fBNzEa8/5oYFcLQFPEoOWlkKILHlcWO+rHoP+LGK10zWnjt
         kYyjNkCYt9Ff+0VP6uPtu5M3yhYgDcrE4bt8iocMshR5eF8rhntcpuCUKk207k1cu0Wx
         AoCg==
X-Forwarded-Encrypted: i=1; AJvYcCVV+2tsyO3HkKkuE/cCw6gSaL4EzbxegGDRbyoaeRThKqQAQVWzNkvuenVUS+Bbp2iC4cxqnwiiaeELeFeo0QH2XWx3VqFvNMgjrNPk
X-Gm-Message-State: AOJu0YyxdRYXXrb65AMn5kG7BNhNfDVszZ78p+WZjjqFE7+qzu6x8Uiu
	BMSbSOuk/UEwqeCDw9QY2ErEoeEj894BCtlT9n2lyPXH7mtEdMxEFRvZUjwiDqbw3zk2K7Rqfw1
	YG/BVHpKG8qyJHstj3y9N2LG60k+4IFQaHO3scQ==
X-Google-Smtp-Source: AGHT+IHwt6TnSwEBMF0RSBNGxMulPOkZK73cGVHoopLcerqLArbRwy/l0k0vV95Xih3dXdDb1Yud2rnVQ6/0P4Y++cI=
X-Received: by 2002:a17:907:76d7:b0:a72:80b8:ba5b with SMTP id
 a640c23a62f3a-a780b881c8dmr1147999966b.56.1721031645321; Mon, 15 Jul 2024
 01:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx> <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
 <87a618qlcp.ffs@tglx> <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
 <87sff0ox1a.ffs@tglx> <CAJZ5v0iWZqAcbqdTuKbo35Gk6vNS0h9De20GDNZeZvqfhQiSWA@mail.gmail.com>
 <87zg8ukd54.ffs@tglx> <87wn3ykbfa.ffs@tglx> <CAOf5uwkR2TpXN=+D2Gz1M8MDfZn51g1Dqv6eFxSfciBSVA-f=A@mail.gmail.com>
 <87msmlsh41.ffs@tglx>
In-Reply-To: <87msmlsh41.ffs@tglx>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 15 Jul 2024 10:20:34 +0200
Message-ID: <CAOf5uw=3c33qXh+aa5V2OPktNBzvQHiAaLW56XAv1NG72d3q-A@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to cleanup
 freezer handling
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, John Stultz <jstultz@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Michael <michael@mipisi.de>, kernel-team@android.com, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas

On Sat, Jul 13, 2024 at 12:47=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> Michael!
>
> On Thu, Jun 27 2024 at 09:46, Michael Nazzareno Trimarchi wrote:
> > On Thu, Mar 2, 2023 at 11:58=E2=80=AFPM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >> >> This appears to be still somewhat racy, because the notifier can ru=
n
> >> >> at this point AFAICS.
> >> >
> >> > Indeed it is. Let me think more about this.
> >>
> >> All of this is inherently racy as there is zero feedback whether the
> >> event has been consumed or not. Making this feedback based is not
> >> necessarily trivial, but let me stare into that.
> >>
> > Sorry to come back on this topic but I would like to know, if we can
> > find a way to be sure
> > to not lost wakeup or if you have already addressed in some series
>
> No. I did not take care of it as I got distracted with other important
> stuff. Feel free to take up the loose ends of this thread and make it
> work. I'm happy to help discussing design choices.
>

I will pick it up this week, and see what I can do and propose some way.

Thank you for having time to reply

Michael

> Thanks,
>
>         tglx



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

