Return-Path: <linux-kernel+bounces-376239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0049B9AA1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58C81F23B54
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A6419C558;
	Tue, 22 Oct 2024 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kloZQAUl"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EBE19D070
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729599367; cv=none; b=IkBUWc1N9sASdZY3o5UzzYfOFzmxcbsuNJ79YR9IXwgkprcwv2vs8Iq+erKT0/mDirX9GspmwV5XJqw/TFceqFktXUcUwzx5kaut0tIbXsYEgiVUkHJkfB9Rmk4fLqsKSr4qXVksIT0qmwcrO4KvErhzB+Z8ny/k6kbsAotWZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729599367; c=relaxed/simple;
	bh=i2pRW2ygeN/FOog6jwz69Ot9ym/zfv5klOhsjxxQmUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/COZCTjuFalT469DTVWcuSmp17ez7I9RecQvc18sAAHkwbaZthtiRfbx7ubho2zC5Ni4ZSLs1yd5ZE8U3wr+W2LRoyvHF7BftEpUOw//tarQIJhx4omodLIPhhAKlIZEnF3VEC2lR8UDWSWCvh95pz3lQnm5uVpXhY2GNIQ1eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kloZQAUl; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so1096609e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 05:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729599361; x=1730204161; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yNCDYsBPe0Jkk0AlmG4RiF9c3o5m1g4nrO6GN7rOBxQ=;
        b=kloZQAUlmYw7I1z4aw6iuszsvl666IIYCtyIuYQo5ifpEMT/3vT+aujiJoIlBBr2vy
         8C/YUeTrz0TQUg3nfYBsPsLrkvVbUlZ6Qa9Rk0vot0q9nCy9UqKnn7jjrMO/DFBRX3ob
         95J16d28HHzp8Iey5w9GHAHfOKqJReeItVSwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729599361; x=1730204161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNCDYsBPe0Jkk0AlmG4RiF9c3o5m1g4nrO6GN7rOBxQ=;
        b=DHXlkPuUCQ47QC1zpHIL8BmbWQ5LDsy2peS2CYz2MvcmAhHyzFhnHQILP/GOHtE9X5
         wD4vUOfvzVH4BP0QayurazP7js1RR3T0hfppEqNIZ6Et23XAyXnIls2s3+KRAbSpNziQ
         fn7s8Iy8bkhKoiLZqkX0ngnQlhjgABr/aswFy8f41Xh96zgTz2tVFhDTPZ59W0Y6JLaw
         Ko0VuL72mIVOvhEJU4U8JqbkMfeIc2fVnxywr7xBObWIVxHKaleQwk4gnH7Ovi4RU87o
         rkkohmrc/SMhAFLyjpOSimCF5xaMEXvkf3Tpa32MTRjlxQit+kD4MIdJXcV+itlrn0nJ
         ixEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs2Tbw/nxuGbjs0a/nf05U6DTn2ovK4kaR1V+h4vecvss0oDZ06UZaVc9QYNwgs8KmBn/bfcM7L/GxW/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKkqQr7I/tSpsi0C7nhWp+h7RwJgfRJpqC5aaQq5Zzp2xPqNKp
	hBlGdJnwuJEMjJbujJDgehhecX9q06NVMJgj3zxaLKaNPhcVf4caxjzKhAwSIDISQefNYLIACRz
	h1uG0u+tTglfTx97IbcQqxbYLYtBWlZNOnqkx
X-Google-Smtp-Source: AGHT+IElDEvTr104OzYQiSWYjXzFLqVLeDdR/85V9cjjpueIQo9urCLWHbsWR/6vbSQyYVLl0hGDT7qcmtUr6f+7NeM=
X-Received: by 2002:a05:6512:1091:b0:539:94f5:bf with SMTP id
 2adb3069b0e04-53a154eb367mr12340140e87.59.1729599361264; Tue, 22 Oct 2024
 05:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
 <20241016060523.888804-25-patrick.rudolph@9elements.com> <CAFLszTh4Z8p-8d8ASrpUTnNdDhmijDm8fcct-wDWR1nRFxs5JA@mail.gmail.com>
 <CALNFmy1=R4vp6S3H3a_3HTDjGufDxu+Heo-vk=GRjb0aj0z0Dg@mail.gmail.com>
 <CAFLszTjTA98Re5rWXHpMQZADXU7uLbCayxNTtugYRxHZaFUL_w@mail.gmail.com> <CALeDE9P04s7uX0Egq+seDbHyn_QXgz+NWPHtJ2W1CGKtATPLsw@mail.gmail.com>
In-Reply-To: <CALeDE9P04s7uX0Egq+seDbHyn_QXgz+NWPHtJ2W1CGKtATPLsw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Oct 2024 14:15:50 +0200
Message-ID: <CAFLszTgE+fjXGXFvJ0KWdw=q8CP_53kfWq0nrGZzJzyHJhdHFA@mail.gmail.com>
Subject: Re: [PATCH v9 24/37] common: Enable BLOBLIST_TABLES on arm
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
	linux-kernel@vger.kernel.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"

Hi Peter,

On Mon, 21 Oct 2024 at 19:57, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> > > > > Allow to use BLOBLIST_TABLES on arm to store ACPI or other tables.
> > > > >
> > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > ---
> > > > > Changelog v9:
> > > > > - default to BLOBLIST_ALLOC on arm
> > > > > - Move default for BLOBLIST_SIZE_RELOC up
> > > > > ---
> > > > >  common/Kconfig |  2 ++
> > > > >  lib/Kconfig    | 15 +++++++++------
> > > > >  2 files changed, 11 insertions(+), 6 deletions(-)
> > > > >
> > > >
> > > > This is fine, but please disable it for snow since it needs the FIXED
> > > > option for now.
> > >
> > > I cannot follow. What needs the FIXED option and what to disable?
> > > I run this patch on the CI and test_py_sandbox tests are still working.
> >
> > I mean that snow cannot use BLOBLIST_ALLOC and needs BLOBLIST_FIXED so
> > if you make ALLOC the default you need to change the default for snow.
>
> Simon by snow do you mean the device (configs/snow_defconfig) snow, I
> think Patrick doesn't know you're referring to what I believe to be a
> device config.

Oh OK, yes that is what I mean. If it is too confusing I can send a
fix-up patch after this series is applied.

Regards,
SImon

