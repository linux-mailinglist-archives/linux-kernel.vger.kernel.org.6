Return-Path: <linux-kernel+bounces-404541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6899C454B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D2DFB23297
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7811A76DD;
	Mon, 11 Nov 2024 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ge+ZVc7q"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3CA1527B1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349462; cv=none; b=ZhTsp3cIEbZTwOHEnvFy7ctqO6Mp2oro3aawyPKzyMHQDZZ/uyz74iPtZSHB+Y10F1hctXf6Cxelo+kPzgxvN83wDB1qaPCJEsabtLhyMyi7vYGtSpmFCKT7zo0o/L7limHg2L7dejzZdwHb3Kmx32pG9IFEqd+sAFH2jHPFpDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349462; c=relaxed/simple;
	bh=nXQykHTezTZ7kJ6EJ8xc0i2v4UMZDUJHkI9nmNcbpis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guwbP3O6yGaVfQ3jLsuq8tTIBL7h5PRhEG0D4eo+Tey9NqzdooF/rePoPY+2haQWSXm70uAQQ0s9hLgPpQgTF6Y9FKfkebpLiH24tVppNIdiOUb+7enB2D5AE4XqH2Rk4Z2hXH8wsFT+IRPvQX/uzTNZyqttHd6REJZdU2wmcnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ge+ZVc7q; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2e88cb0bbso3709287a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731349460; x=1731954260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXQykHTezTZ7kJ6EJ8xc0i2v4UMZDUJHkI9nmNcbpis=;
        b=Ge+ZVc7quCjrHLDXthxDCEPAwpXx9QLeto1nDKLKJBXUcyQ3KXbU5TMX55/DZroApg
         R7ArtStBNdVhf55AYRaMwSV4L8otYrg0MdxdViFusbvOUbWkJbMdD+qonLHLLhPSXG1d
         veUy5XAYhMnta2+GwBBQOMr5aQ/0444eSO0qn0/1uGnJFDIhCuSn9zcwnOxybhHb6ozy
         Mlutm2kOCVom2LSG7qY/1Md0cpnJEeUmE12zlLgXf4euqzbhg5EUrWKAyxRxuQHPcyMA
         8k2ULJCPwbKVTONmEN2KDk8YMhNr6eT1Y5VR+/ZK+mCLvxhtt+QGmFv6dm2Gs95t9vQH
         V1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731349460; x=1731954260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXQykHTezTZ7kJ6EJ8xc0i2v4UMZDUJHkI9nmNcbpis=;
        b=Zh/kOgw3MasKQ4h3e9iQBgI7nb5bkHuaHj0swnUR/qCEUDxq+f9ioLf4Nc1x4Tc72r
         fp9lR0vjGpRcQiU0zyZcXmi/dz3U+yLkj+gxwbRlEXg6YAJb0+wsfDRqrCdYVcCxMykO
         VpISFUrHRC59EgJMmYY2jBAz8miTKsKO44+I2PgRjk1T1etbpA09dhXiy5Kbe9CXBV1o
         tPofbId/pMjdAK4RDDzP3MQCxd9BskwApy2JfdQIPMenYXeCc4LohfkddUygCM107uaF
         cUyZ+OIpQbMR++wbGfi8Fd6aX7bBFEOGlkBOHvnc+WVmZtMUTsUWnHd75rcVo7v+5nKQ
         YF4A==
X-Forwarded-Encrypted: i=1; AJvYcCWbu43/nXUyXfZSaq/JWxbyqFH70UJvAP2gRki1Ylvl1cBbyy/HFm1VFFzoPvb45P2AVvCVqWnjX2p286s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQU0ZTuSpVsPCsy1zs6cXVj6E4TLEMbOg4xvoYJpooxW45uUJv
	UL//4mWEK4Ilk+rQ4fd879T0bQRwkXuiQkdlPCb2fYDYIdUYSDK/bKjTsF0EDf9QZ++6h+BZGZJ
	Fk2efgW7xvRikW3DHJOj4o8qyQz1PIdTFwSwg
X-Google-Smtp-Source: AGHT+IFkderX9FsAkQ/eC/Ud17ckv4LSSzyIo4hQQMxFMAw9dvOZbg4S5RW9egfYju0Itb68L1146lsXTVMs6GhwThQ=
X-Received: by 2002:a17:90b:4b86:b0:2e2:991c:d796 with SMTP id
 98e67ed59e1d1-2e9b171ff6cmr18004783a91.9.1731349459673; Mon, 11 Nov 2024
 10:24:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGETcx830PZyr_oZAkghR=CLsThLUX1hZRxrNK_FNSLuF2TBAw@mail.gmail.com>
 <20241108083133.GD38786@noisy.programming.kicks-ass.net> <CAGETcx-CvWVc=TP5OmUL_iF7fSb1awJB1G8NghM1q_6dYKXkQQ@mail.gmail.com>
 <cc8831c7-8ea2-0ee7-061f-73352d7832ad@amd.com> <CAGETcx9qDK+QUiP8z1iNYXwjHz39oZzOZmhj4p=icU1BuVtcug@mail.gmail.com>
 <20241111104054.GE22801@noisy.programming.kicks-ass.net>
In-Reply-To: <20241111104054.GE22801@noisy.programming.kicks-ass.net>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 11 Nov 2024 10:23:40 -0800
Message-ID: <CAGETcx_1uyZ3M1LtSkZDHiTwDQj8M54V-=geRqJYkZXo9ZbU6w@mail.gmail.com>
Subject: Re: Very high scheduling delay with plenty of idle CPUs
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, 
	Thomas Gleixner <tglx@linutronix.de>, efault@gmx.de, John Stultz <jstultz@google.com>, 
	Vincent Palomares <paillon@google.com>, Tobias Huschle <huschle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 2:41=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sun, Nov 10, 2024 at 10:15:07PM -0800, Saravana Kannan wrote:
>
> > I actually quickly hacked up the cpu_overutilized() function to return
> > true during suspend/resume and the threads are nicely spread out and
> > running in parallel. That actually reduces the total of the
> > dpm_resume*() phases from 90ms to 75ms on my Pixel 6.
>
> Right, so that kills EAS and makes it fall through to the regular
> select_idle_sibling() thing.
>
> > Peter,
> >
> > Would you be open to the scheduler being aware of
> > dpm_suspend*()/dpm_resume*() phases and triggering the CPU
> > overutilized behavior during these phases? I know it's a very use case
> > specific behavior but how often do we NOT want to speed up
> > suspend/resume? We can make this a CONFIG or a kernel command line
> > option -- say, fast_suspend or something like that.
>
> Well, I don't mind if Vincent doesn't. It seems like a very
> specific/targeted thing and should not affect much else, so it is a
> relatively safe thing to do.
>
> Perhaps a more direct hack in is_rd_overutilized() would be even less
> invasive, changing cpu_overutilized() relies on that getting propagated
> to rd->overutilized, might as well skip that step, no?

is_rd_overutilized() sounds good to me. Outside of setting a flag in
sched.c that the suspend/resume code sets/clears, I can't think of an
interface that's better at avoiding abuse. Let me know if you have
any. Otherwise, I'll just go with the flag option. If Vincent gets the
scheduler to do the right thing without this, I'll happily drop this
targeted hack.

-Saravana

