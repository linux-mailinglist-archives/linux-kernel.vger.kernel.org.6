Return-Path: <linux-kernel+bounces-231949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA0A91A0BD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2741C21019
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820A36E61B;
	Thu, 27 Jun 2024 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lGziGwo0"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168DC6BFB5
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719474398; cv=none; b=cfTSvRCh2YBksz4poPfvMVnxVr2FqL4UF/mxjHg3xBMaWuqvFMYuhg8RBcnTrOqjGfquShXs1WmiyjBeXRVKOEAS0jayBrmCNBVcEHFK6y2EjjBV4tR5+bU18J04YpOzfVcaEhqBdZbIzHjXZXk9ARF5lNh0NgLe8geM4xan3Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719474398; c=relaxed/simple;
	bh=BuvD71Fm5avvNowlEzPzilZrwxjVi5dfYmvQRQGc2qU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wk2bzef0ScBZqim8iM0K6UEzv4zGq+IZyVBttm0ThpXocssFr69/MHQJyxWQIPtWcMxhyp0wbEDDIYTo4dOo2Q4Mc5HpJ44y8swvxtnk6M0lQiqJdDNWQC3z2jOzcQuqy5XxdnxK8YAA/Qf9oVsrtuJ4RwekPFaX+qBPA2ePz58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=lGziGwo0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00b97so1266775a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 00:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1719474395; x=1720079195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36vwLOKZuveqM3zMEra5hrjPPxMTRF7K2+z2HyelWyc=;
        b=lGziGwo0Zlu8lyc4vn1kKtDDgz+Vr7F/ueYjl1J8iAATczq4cRdVd3PY4ozcjg8NvL
         lcauMwwZ1uUpUcfgfyFg70RpQBBK/WEi//6jDnk6bAAk47dkLOwutvFUkbGJTxue5B4O
         KQdJ7/ny4vCZYuYRW+TWlKrbCUpsn+/k9kpuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719474395; x=1720079195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36vwLOKZuveqM3zMEra5hrjPPxMTRF7K2+z2HyelWyc=;
        b=gXpzIJnuATD7XNzCLH5xndBDMSjWMVswDr5AEqhMfT7DnW50J7cp72bKTMjC9zVwJo
         T5F2/Ix1gv+hJJgaYsDg5MRwOxWgBOcI+uAM3Ylc5KuxBdyDWQYiASR/SuJH2k96ljK0
         ie2nMl17Q2WU6RNQOGhHOsaLwNutCURBHg3kehHUrA3tFLyUb2bWdFcX0BagJjKgWmXI
         i/x9AYCBH0QuqV15dXZ0uVKQB2bvBk5O5J2SUo2Xe1pCBf/qAFMIpo7XOqx7xxpirEtR
         rEOA4XCbF95ciE0ZYP+BlFwOu/2UcZ4Oh4zWnwkS8nmMBhyFELUjWGpYoxURkxnJYDlS
         qOdw==
X-Forwarded-Encrypted: i=1; AJvYcCWZLIjYuvT0CYW1NDwX96ctH3pNjyy2HXDGJjJoVKjjzekOPDYyIPbVfbipQ75sNuSFHixITRKowDDvbGZCvMa4Jm79YY93ZEKl0KVl
X-Gm-Message-State: AOJu0Yw3m9CDhnVmx8xr1pi5cJiZC9FlQBuVilPCqVo+F2Dghb/6Tani
	uoS9iETPsDcgqizzSAAsib6eGM457GTVeOjaGL4YRP9rqbpLw4P/MEsxStwAaGQwWhwABUuybTk
	lyUTRQ4Sm7B/kEug5n5Tza/6Md+7DnHvLl79svA==
X-Google-Smtp-Source: AGHT+IF4QvA9OtmRLrKwo2Cra+HYMRi41YHuKkon7kVtS8vWKKWTl2KUd2TDtum+AMvzINHaOIuUg75ZsU7H8McLgJg=
X-Received: by 2002:a50:9501:0:b0:579:ca97:da1b with SMTP id
 4fb4d7f45d1cf-57d4bd56be9mr8784780a12.6.1719474395273; Thu, 27 Jun 2024
 00:46:35 -0700 (PDT)
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
 <87zg8ukd54.ffs@tglx> <87wn3ykbfa.ffs@tglx>
In-Reply-To: <87wn3ykbfa.ffs@tglx>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 27 Jun 2024 09:46:24 +0200
Message-ID: <CAOf5uwkR2TpXN=+D2Gz1M8MDfZn51g1Dqv6eFxSfciBSVA-f=A@mail.gmail.com>
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

On Thu, Mar 2, 2023 at 11:58=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Mar 02 2023 at 23:21, Thomas Gleixner wrote:
> > On Thu, Mar 02 2023 at 15:32, Rafael J. Wysocki wrote:
> >> On Mon, Feb 20, 2023 at 10:19 PM Thomas Gleixner <tglx@linutronix.de> =
wrote:
> >>> +static atomic_t alarmtimer_wakeup;
> >>>
> >>>  /**
> >>>   * alarmtimer_fired - Handles alarm hrtimer being fired.
> >>> @@ -194,6 +196,8 @@ static enum hrtimer_restart alarmtimer_f
> >>>         int ret =3D HRTIMER_NORESTART;
> >>>         int restart =3D ALARMTIMER_NORESTART;
> >>>
> >>> +       atomic_inc(&alarmtimer_wakeup);
> >>> +
> >>
> >> This appears to be still somewhat racy, because the notifier can run
> >> at this point AFAICS.
> >
> > Indeed it is. Let me think more about this.
>
> All of this is inherently racy as there is zero feedback whether the
> event has been consumed or not. Making this feedback based is not
> necessarily trivial, but let me stare into that.
>

Sorry to come back on this topic but I would like to know, if we can
find a way to be sure
to not lost wakeup or if you have already addressed in some series

Michael


> Thanks,
>
>         tglx
>


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

