Return-Path: <linux-kernel+bounces-291937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD077956918
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7A71C21E97
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629E4165F17;
	Mon, 19 Aug 2024 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bq7aDnes"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8A72209F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065975; cv=none; b=ZUdn5vEA1TPQb9enJAXs7g/ztT2Vq5JJFGpUTMygepLWUMkj2jsSJH7L/emn0cDFDWpUHBx+8euqJuR+o7QO3x7TJbT7HqoxgEU+HTZ6ywJOphA7MZEv0tulXn5IJn3IwmDzOmgHHi6Im+Taob4Xe9z70SW2+S/S668EOEIiF0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065975; c=relaxed/simple;
	bh=87XZViHStQDLFnNtKxn1mImGT6ZLikeTlD3cUrYEaKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isPFlUNiV3bb6eHlFAYLuRo98iiLuTMTUX95LBQ2CKmHoZrNOYSgNyquiZtrI98aq0JS6cJ9yRo5OItv0p2vOScUct1m63ERpXXdrsdGLGB/FGL03kfhcmZ1CAGq8Oe5+7TauXWhht9ZjR6xYD21dvXuYPaaEgSgLmgWYOiPhcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bq7aDnes; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f3ce5bc7d2so17893681fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724065972; x=1724670772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Lu4789HbHt8tQNAaq/ovvoea9zEhGohbWBt+m7mP7U=;
        b=Bq7aDnesBhip/nCxlOHJ+/PArKjsiQNBf6vV1q+cav6/2aMPmIBCRrqNnMwRQXtHyj
         jNrYtQJu6me3SzyaN/j7DDxXa3/vdcZP/YnF7YORgddr//WfL1teaTIrCXoZ0Mo/Tq3K
         B1RD58GIEiYUNdiZK2LZorTmMYa/tdMIXQIjT/CW2Vfg0kdBOanCgq8UUTqgVSSDavCc
         TWfaOS7C6cxNxosciX48VamYFUOxV6u88JGy6iHHr7XrXuGvdhZTA1TrXQCTwV/RCaQP
         ZwIC2V9mfsSHwaxt3vkGMsBX3q831hWwk22D66VxXCaLwvGEK/4SwgnCSt8rVW36DufZ
         b8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724065972; x=1724670772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Lu4789HbHt8tQNAaq/ovvoea9zEhGohbWBt+m7mP7U=;
        b=a6VPph246HmASgC+xTcW6yUrHuPUt1hhXe0/hU+lM8SnYp5jZP40ohGU1r8IhPNhvD
         Qy1kku42UGfGC6vhTKFrcIv8pOqIjwhheam6a0CGQPDbBL1C7AcMo3RpXlUSRWHWZFwp
         CkgVfN7JUpkmKAR1iXoezMBzKj+r5KIF8xoEB8dRdIsacFHFgEKinFkYKm5TxB7kt0ZI
         VUhIfUy0aHROyVxNwMyDcxLPy6WimCQAfsMMvTHVvONOdfIvPKPetFMHhoGhd0RmE8Gs
         sZ/aaGL8N8XoRTqEdJ0kQut6A43ZHzo113x2Ge9J6HCn7Tf4zDnn2nFGtenjKlveDq3L
         fa3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOUyvOYJ8IpfeKzcD4IKhrzlkTmQH0nRIMUkwejgIXE9rxux0hTt6UqxC1f5SVeZaUVvWNZoEDtZfUllednpqqu/B/JmyfWpGCdBxd
X-Gm-Message-State: AOJu0YznbduHFCDjzREJgjfpXHc8w2x0rQRNrWhJ38AQDu/jWrKU0Jnu
	Pu9vEknihxashBEfYmDF57u4upyHb+fPcGKw+PA+bPYUfxnlDMJHTg+VwIP5mikU4gF/pVStrvx
	7FKAzWHyNrz501E14pwF7VvpLzkoSB67sOqo=
X-Google-Smtp-Source: AGHT+IFuWqLPQ/2hlwFYXP4TLDjcb07sfoXU1KJ+Hfy1M7WFBY7Ml/pWExeSxV1WmLMAcCBrnvr7s6NFCjLiuQhDcyw=
X-Received: by 2002:a2e:2244:0:b0:2f2:90d4:55fb with SMTP id
 38308e7fff4ca-2f3be5e35e1mr69740771fa.30.1724065971693; Mon, 19 Aug 2024
 04:12:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819100335.2394751-1-daniel.lezcano@linaro.org>
In-Reply-To: <20240819100335.2394751-1-daniel.lezcano@linaro.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 19 Aug 2024 13:12:40 +0200
Message-ID: <CAFULd4bDjN1XcLx+Uy703Vkf89LMH=E__L8qtF-A7KW3VLFiBQ@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/timer-of: Remove percpu irq related code
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 12:03=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Found by GCC's named address space checks:
>
> timer-of.c:29:46: warning: incorrect type in argument 2 (different addres=
s spaces)
> timer-of.c:29:46:    expected void [noderef] __percpu *
> timer-of.c:29:46:    got struct clock_event_device *clkevt
> timer-of.c:74:51: warning: incorrect type in argument 4 (different addres=
s spaces)
> timer-of.c:74:51:    expected void [noderef] __percpu *percpu_dev_id
> timer-of.c:74:51:    got struct clock_event_device *clkevt

Actually, the above is what sparse reports. GCC's named address space
checks errors out with:

drivers/clocksource/timer-of.c: In function =E2=80=98timer_of_irq_exit=E2=
=80=99:
drivers/clocksource/timer-of.c:29:46: error: passing argument 2 of
=E2=80=98free_percpu_irq=E2=80=99 from pointer to non-enclosed address spac=
e
  29 |                 free_percpu_irq(of_irq->irq, clkevt);
     |                                              ^~~~~~
In file included from drivers/clocksource/timer-of.c:8:
./include/linux/interrupt.h:201:43: note: expected =E2=80=98__seg_gs void *=
=E2=80=99
but argument is of type =E2=80=98struct clock_event_device *=E2=80=99
 201 | extern void free_percpu_irq(unsigned int, void __percpu *);
     |                                           ^~~~~~~~~~~~~~~
drivers/clocksource/timer-of.c: In function =E2=80=98timer_of_irq_init=E2=
=80=99:
drivers/clocksource/timer-of.c:74:51: error: passing argument 4 of
=E2=80=98request_percpu_irq=E2=80=99 from pointer to non-enclosed address s=
pace
  74 |                                    np->full_name, clkevt) :
     |                                                   ^~~~~~
./include/linux/interrupt.h:190:56: note: expected =E2=80=98__seg_gs void *=
=E2=80=99
but argument is of type =E2=80=98struct clock_event_device *=E2=80=99
 190 |                    const char *devname, void __percpu *percpu_dev_id=
)
     |                                         ~~~~~~~~~~~~~~~^~~~~~~~~~~~~

Anyway, your patch fixes the above build errors, as well as sparse
checking warnings.

Tested-by: Uros Bizjak <ubizjak@gmail.com>

Thanks,
Uros.

