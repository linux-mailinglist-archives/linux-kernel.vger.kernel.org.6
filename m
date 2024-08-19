Return-Path: <linux-kernel+bounces-291694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E41D9565A4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B8F1C217C8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718D814D452;
	Mon, 19 Aug 2024 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieW34ZJj"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3969012FB34
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056277; cv=none; b=EuHOyQE5nHA7bHHyz3ZdNGAvvSQXhgUHNCqSNJxn01d/qpywsOgX/mgC8WY4VvB7/WRixCIKC5kN/eZJUlGyypygHIEdgSQBz5kfqyevhHifFkZGqpBDUlwj29Bok9OGbidvA6g0TKz5zPkO1ejnCjJqywxxDTXgu3yPMna/YIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056277; c=relaxed/simple;
	bh=xVvwYxbeS7TloS4Mo6w8Vgly/BAzHvY3Vu1nDo1zgvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghkuPXnim/BVSlfM+2gnHUzsjdHISY5Bv81Qw+/xzCzTE9zJ5oB/Re6flHGRon2bvtOs8J94t0K6uZFVyEiiMMizU7we9VDP4siJLaW4GS9/qRKXRKq1bVe+XpIKxJufU+EXlkC0cGZF0mUZa5xgL9YG4HaiGXJlcqNLkRmnrfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieW34ZJj; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f1a7faa4d4so39560831fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724056274; x=1724661074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+k8Bbokwfu0beELgxVuyxqVGtlkXzRN6o0yU5TWO2U=;
        b=ieW34ZJj61nS6f3FgPOzDG2+YFpreZA3wheKpOsSyC02CLYYzYob6Ym/nOJbWQpCbI
         75NrKH8NrCh0zj5nx4DLFpRXpMaSOXsZIEI4IJM3VLorncq9SLuDLQ6V/2QiUmdT8tbM
         hAg/76zP9TI0XE0AMoWKwjlFeV4JXk3oo6lsKJtkN9NF91y4LDM4LtGMfh6I9iE0B8X8
         sLemjMYJKQluYiW/BwA63vtRJ9MDkpIem/7J6w7HL2HfVYQWx2JqoeZNzQ9veiE9/gVI
         RKOMKUN/S1xlaX2JYo1kjOrvyJT2lmzrO54XoWhmH1/PWFBlqZmRycBrQePbPt3ttX6S
         1MNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724056274; x=1724661074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+k8Bbokwfu0beELgxVuyxqVGtlkXzRN6o0yU5TWO2U=;
        b=dY9jDa0xAXPIkbriFJNR9DH+Q9G0tsvOTqYMcK5AeOq5UP4F6aJnKDNMUDPssrhdvK
         lZ4ZNwN0h1Qzd/QrDdNaG8i9Ec1Yjg3vYcZfJqp+SMeWL37lA+z10Vqnqk46xUqx9Ogp
         syUAVOe5Ewbnzn6DweSxiLEg1lX4LkIoo8MoUE8UbkTnyDCHiBS8ryWr1PjIr7aom8yO
         dcc+6hEXvNJyV+MKAUbtBomaqxn8FJD2lh+8ia4tQS8mmyUoY6SMMmhp6K2K17vsYp26
         A896KJnRwgYYOzG+LfEtUUU/BqCdeXo9W+N1koGCbhUAvCBvO5IuDC3MgqR7837Q/Vgs
         Sk6g==
X-Gm-Message-State: AOJu0YxG7QIAtmPwa131cgf2Cemi1rKnqzuyr0NEWrlklwpsafrU9fiZ
	nsLELfNnLGJgHKaXm/N5SiyzAGrW7VtNrk9aezUHYfyHuHZjrWnG0n5+lW1tlCFD2yxnvSAffeJ
	Rg16POI624pykYqX0m0l6wVJMCo0=
X-Google-Smtp-Source: AGHT+IERajBJ68YUCkW2gkRyMh0J8YcDen/G4nEidnqysnUiJc+PHbApWIoxwRT2XvGFCcqtqL7VP1GgbykF0Rd/Jkk=
X-Received: by 2002:a2e:a584:0:b0:2f3:aac3:c2a5 with SMTP id
 38308e7fff4ca-2f3bf21838amr33613321fa.17.1724056273979; Mon, 19 Aug 2024
 01:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819061351.14782-1-ubizjak@gmail.com> <51e3c38c-42a3-49b6-ab19-50f4f37336aa@linaro.org>
In-Reply-To: <51e3c38c-42a3-49b6-ab19-50f4f37336aa@linaro.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 19 Aug 2024 10:31:01 +0200
Message-ID: <CAFULd4YMAG=9D5+YhHjGz91VzKte7qWKpYdoWLEtN6d+r7XwFw@mail.gmail.com>
Subject: Re: [PATCH] clocksource/timer-of: Add missing casts to percpu address space
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 10:18=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 19/08/2024 08:13, Uros Bizjak wrote:
> > Add missing casts to percpu address space to fix
> >
> > timer-of.c:29:46: warning: incorrect type in argument 2 (different addr=
ess spaces)
> > timer-of.c:29:46:    expected void [noderef] __percpu *
> > timer-of.c:29:46:    got struct clock_event_device *clkevt
> > timer-of.c:74:51: warning: incorrect type in argument 4 (different addr=
ess spaces)
> > timer-of.c:74:51:    expected void [noderef] __percpu *percpu_dev_id
> > timer-of.c:74:51:    got struct clock_event_device *clkevt
> >
> > sparse warnings.
> >
> > Found by GCC's named address space checks.
> >
> > There were no changes in the resulting object file.
>
> The warning may go away but the problem sparse is spotting is still there=
.
>
> IMO sparse is totally right and the code related to the percpu is
> broken. It seems the .percpu flag is never used in the drivers and we
> should be able to just remove the percpu related code in timer-of.c

This issue also breaks allyesconfig build on x86 when strict percpu
address space checker is enabled. However, I have little idea what the
code is doing, so I try to keep the proposed changes as non intrusive
as possible. The referred code is questionable as it tries to reuse
the clkevent pointer once as percpu pointer and once as generic
pointer, which should be avoided.

The only other issue flagged in clocksource drivers directory is
reported in [1] where generic request_irq() function apparently tries
to handle the percpu pointer.

[1] https://lore.kernel.org/lkml/20240730132015.8920-1-ubizjak@gmail.com/

Thanks,
Uros.

