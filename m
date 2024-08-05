Return-Path: <linux-kernel+bounces-275343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 022489483AF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11471F2405C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3107716B720;
	Mon,  5 Aug 2024 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CG63HGAT"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEDC14B078
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722890679; cv=none; b=XAo8BKRAIgKPT4QYx1WDWYbnVPpOD6AYXXQLh+0shqG1lX8xzAbMSWqk9+pub+srLDAWGH4M6NIQsWPbyy9Mji/XSXlG8wLMQ5mtI7/RkR5DGU/CgvCvGUx+/TDMcDpq/6U4y7TdIHleRFS+pfSlE3FR+ozbnAARr1lpCw2D3BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722890679; c=relaxed/simple;
	bh=S3+/yGDGoGuYOn547Y3RnmiiAX5VnYowfIsnCN7y5OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YB1LRzOzIV5gt+e1hNdUKCpR6+nu1VOByWQocY2aoO50Lf4IVRVZLSmcesAsXx4lMU6zPTZa6zoXTJfdjLH8tAWsLsNX1FVSeWz6u7qY6lT5Dw7Sg9GTsafxziGF8JxeKPQv0loOZtAZuAbeN4sh5kJygUtGSVYD2e08pODuc00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CG63HGAT; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44fdc70e695so124501cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 13:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722890677; x=1723495477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6wqt4kGYM7Zcf4b7kRydXxqCjvpgmcWCUmlWuhWPkA=;
        b=CG63HGATrA/Zx+sOubUK8RL42LqwpimFNdbx66WFxTTMKoUX8c/pIyfj9IUt2iZGOA
         XdUGRjbkwIr99yVvuUc413mpB//yYSTqwN0cpXOeVaunZaqN2VEcZf0KCU182pONEpMC
         PP/ByBhTVaFpKntDPR788nlmL1NsgMzZzy2n1EhpXlj8DjsIoydI9a+MmDb5m0Bk1mTN
         c5nxe3Cc/vvco18LZ3txLO4difF/n/dCdYqdkDUPzg3+xMkotfSoEqxgYi4KGqlm2YjG
         CxnbkiOx2Lf515x4gp9r38WIZ8vv+Cs5F7oewV8jyVuaUonvWutP098gQnuj+ZVcOUgS
         bcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722890677; x=1723495477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6wqt4kGYM7Zcf4b7kRydXxqCjvpgmcWCUmlWuhWPkA=;
        b=a3KIls7Huqp0QxfaPEEVjWhWe334soezzUnAixRjVFfsOKuYFKo7Uq8wWMfTh5Q8l/
         LQQL7OykneP92R0sqyUIrxJLQN831BFAIxfOsqLlvLk8b0/bWX6EIozIO+Mctu8cujPk
         2Owf5MU22o+gfXJLVOFJMgmAhGd3KEXW8eUEig78FeICRpaeJHhOHiarXjZ2uHsuE5iX
         J81uTkXr5yg6vYFGwVHknmOGx1Jd29t2VBPqJ//pwD4UAbMfy+L9BNfgJFsuJXMKTfH0
         YvEht5BT5zZNJyS/f47CUOrlKQLiHpiqdoXUedCKA174BWxTDyWuV4MAaNws9BbMxVrC
         QpIg==
X-Forwarded-Encrypted: i=1; AJvYcCX1ojdUwWQNzHH+W22HY8aCTTb9rjGL4dXrvEvXl98e847A9RwQ2Jlfz9FC2zaD6QFOhXYIDB6cGl48wjyVTZsK+rc1pNN4DXZD9bH7
X-Gm-Message-State: AOJu0Yy/CA9uq/fL75mgd0SbBEIVXuMROaCWY3XSNk+lQXKzf0b7YA7t
	SlKZHiUU+qf7HjUU5zbvKzvDdKdI5CYe5H0wzXP4TuLJu4AXlJqrg2NaxaIHgmJzBVgYsyKlV5Q
	D5VG3cqPsjcU22kbNSuWrWItMAC20psM7Sz9bVDK1KUzPckYs7g==
X-Google-Smtp-Source: AGHT+IEw7JjEW+m5DpwhJFyFx5H5/pf7x+UKgeaUDat/ic/VKSYE52o76EKN35RwUaI1gKHMFrzEC+iNjBo/lfDEKO0=
X-Received: by 2002:a05:622a:1491:b0:447:e8bd:2fbe with SMTP id
 d75a77b69052e-451bcea8b05mr70691cf.1.1722890676706; Mon, 05 Aug 2024 13:44:36
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625160718.v2.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <20240805165336.GA10196@willie-the-truck> <CAD=FV=WGfQeJr2CuA7J5XgytAVpVxZPpH4EY8e8y63wMOaHRwA@mail.gmail.com>
 <CAOUHufYWHECbnhfodCKzNp81YHCHomC2NhgZCtX3cHdzn48ROA@mail.gmail.com> <CAD=FV=VodEuhwaTh5ne0YCPkvxna0rkL9_mKN2tJzhWL3ToVEw@mail.gmail.com>
In-Reply-To: <CAD=FV=VodEuhwaTh5ne0YCPkvxna0rkL9_mKN2tJzhWL3ToVEw@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 5 Aug 2024 14:43:58 -0600
Message-ID: <CAOUHufZALU9==QxkczwdE6yE_FBgaJ3XmKLKrp=Yqot04GtOpQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
To: Doug Anderson <dianders@chromium.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Sumit Garg <sumit.garg@linaro.org>, 
	Misono Tomohiro <misono.tomohiro@fujitsu.com>, Stephen Boyd <swboyd@chromium.org>, 
	Chen-Yu Tsai <wens@csie.org>, Marc Zyngier <maz@kernel.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>, 
	D Scott Phillips <scott@os.amperecomputing.com>, Frederic Weisbecker <frederic@kernel.org>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, James Morse <james.morse@arm.com>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 2:29=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Mon, Aug 5, 2024 at 10:26=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote=
:
> >
> > > > > +     /*
> > > > > +      * Start with a normal IPI and wait up to one second for ot=
her CPUs to
> > > > > +      * stop. We do this first because it gives other processors=
 a chance
> > > > > +      * to exit critical sections / drop locks and makes the res=
t of the
> > > > > +      * stop process (especially console flush) more robust.
> > > > > +      */
> > > > > +     smp_cross_call(&mask, IPI_CPU_STOP);
> > > >
> > > > I realise you've moved this out of crash_smp_send_stop() and it loo=
ks
> > > > like we inherited the code from x86, but do you know how this seria=
lise
> > > > against CPU hotplug operations? I've spent the last 20m looking at =
the
> > > > code and I can't see what prevents other CPUs from coming and going
> > > > while we're trying to IPI a non-atomic copy of 'cpu_online_mask'.
> > >
> > > I don't think there is anything. ...and it's not just this code
> > > either.
> >
> > I agree -- I noticed this a while ago [1], and I added
> > cpus_read_lock/unlock() on the caller side, because having the locks
> > inside callees can be a problem for callers who can't sleep.
> >
> > [1] https://lore.kernel.org/linux-mm/ZnkGps-vQbiynNwP@google.com/
>
> Sounds reasonable. I'm happy to review a patch doing that.

Thanks.

> > Also, do the handlers always see `crash_stop` set by the sender? If
> > not, would it be a problem? (In the above link, it has to do extra
> > work to make sure that handlers eventually see any updated values.)
>
> I _think_ this is OK. It's been a while since I wrote the original
> patch but I seem to remember thinking that I didn't need to do
> anything special. Tracing through the code again, I see in
> gic_ipi_send_mask() the comment:
>
> /*
>  * Ensure that stores to Normal memory are visible to the
>  * other CPUs before they observe us issuing the IPI.
>  */
> dmb(ishst);
>
> ...so I think that means we're fine, right?

Nice -- I didn't know that.

