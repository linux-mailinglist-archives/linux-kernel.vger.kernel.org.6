Return-Path: <linux-kernel+bounces-352631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CD39921B6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 23:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3460F2816E6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 21:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B6518A952;
	Sun,  6 Oct 2024 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGfD7xRo"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE8318BB8A
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 21:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728250402; cv=none; b=n5yJ4ZGf7Vr26U7bvn0+X+zG8BuyUyWZYvnWmFpqNq6sl5AiwBAKyw1Ft6LgfPUZWDH/4JVfOSr3aAEHdxZ3vfXBMuobIN2yD/F0a3tSmkOml/5SN+7ZPhkJErH89/1i98eAFDySfOiM+rOSsCUD8SWQPtsWdrbuBqyNZe9zfEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728250402; c=relaxed/simple;
	bh=ut1+6i+zJwmm87jy+4/lyo775vWQfB4cMBczH1N930g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dA4Tk5p7r3w3MNwDabIRP02fPCV+wg6wqHRWAoPm4piTEb55sYx3wSuZ9bMCJdz+nmXgPb6xBR3Y20x2KpDjVzOKC9INqfAGOnS/pK5ay8MAG1MvgpuE2afpwSgdCcwGfFpY/pFKE5uQ4YEMRhp0lyKOYqIXwRkGDSlhSmDzLgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGfD7xRo; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6dbc5db8a31so28371607b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 14:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728250400; x=1728855200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ut1+6i+zJwmm87jy+4/lyo775vWQfB4cMBczH1N930g=;
        b=QGfD7xRoiTtDV8KGCTv/AT/g9LUcAAgcEEZqgOIxHGoBLgOQsxy+28S2rz2VtYmhjG
         2DplpIkR6tZJPeGKtqNxdAyaeNsaaQM37C0hjss1SusdtQ8V4IUl9JhF825Oe0rSGqxL
         VIWBMGdEwzxOd6MOOJcDBDQEVFw/5WQGuDRMZUz5GRN1LDycv90XPPwRR4GT9zxoad+y
         cNkkvz4ap8G1Zqp2Q4sp30gIS69FpxUA6+TK+iLfQ/7ydHDiEdMFcUTz1WtUzy8s4jbu
         Q8jEqqrrlC3CyENqjfsOBSHNevkV5KROpDLfq4/sqrAIIiuWuhUcP4xXTCbbJURHM8CA
         FB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728250400; x=1728855200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ut1+6i+zJwmm87jy+4/lyo775vWQfB4cMBczH1N930g=;
        b=n2QwnDRtsM8doG28mUnHbzJmJ3BVNaW150rL3evGTfUH67I+LbGIeaUDy0y/DzODMp
         H4qprQuyGPAMizQ45XoFcHyeX2V76AjmFi6QQFnDE4Pwgz/b7A2o39Ty5r2IFm5PH13i
         LBiDdagRcRTBACzv09ki2Dw8a4lrSJrPZ0qsHb7dQBBbRJ0fjbBxoEPpzbDZyh0/Wg3p
         fu0sWLhv6DmY5/UI26lt412F0gQXZKP0ixY6+u/VgpWwSNmFv87wgocaR80lakEgM/7w
         90eQXA19qmOz1ZaN/7o8JpD20dk+LsiwLthCyKR1GSfAYO1DqvxSyFcg3Og4huA/qUSF
         2x9g==
X-Gm-Message-State: AOJu0YxsHUYU9/cDgzNaa0WC75z2fxHnDCAmUrapLSMempvRnRVGValQ
	Up7ftKtVWOpCUGiNtEysMkHO5MQ8F8LJ0Sr1qMvK+9svJuJxGy0CONkgv9dPp5rUoAxJEDrdE9c
	+3qpvmbR2prZPX1UkiFITJdNZaWA=
X-Google-Smtp-Source: AGHT+IEfFcWHtVvaLPMSTYSi00oioIO1chqwnAVtYjOYUzm8woz6NgKkWI5LFiLZ6dmeWPXwsUBwKrOuStzI8XHnB8A=
X-Received: by 2002:a05:690c:6101:b0:6e2:451c:df02 with SMTP id
 00721157ae682-6e2c7c9ebbemr67886877b3.16.1728250400351; Sun, 06 Oct 2024
 14:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006145727.291401-1-luca.boccassi@gmail.com>
 <20241006172158.GA10213@redhat.com> <CAMw=ZnS1GTC9RGQCeTqB8g2b78mFXi4zLfg6bumrp+zmgx0VXg@mail.gmail.com>
 <20241006185537.GC10213@redhat.com>
In-Reply-To: <20241006185537.GC10213@redhat.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Sun, 6 Oct 2024 22:33:08 +0100
Message-ID: <CAMw=ZnQUfCy2RBHdkBJ9r-tK5OBidQd=zCKHeJGcfprj4+ELJg@mail.gmail.com>
Subject: Re: [PATCH v5] pidfd: add ioctl to retrieve pid info
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, christian@brauner.io
Content-Type: text/plain; charset="UTF-8"

On Sun, 6 Oct 2024 at 19:56, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 10/06, Luca Boccassi wrote:
> >
> > I see, so what should I do here then? Check both? Or none?
>
> I don't know, because I don't know how are you going to use this API.
>
> > The caller
> > needs to verify that the data is still valid at the point they use it
> > anyway,
>
> So "none" should work fine? Just it should be documented that, say,
> kinfo.pid can be 0 if we race with the exiting task.
>
> Just in case, you can also use lock_task_sighand() || return -ESRCH,
> this way kinfo.*pid can't be zero. But I don't think this will buy too
> much, the task can exit right after pidfd_info() returns.
>
> Oleg.

I think what we should do is check if any of those fields was set to
0, and return ESRCH in that case. This way either we return a full set
of metadata that was correct at the time it was taken, or we provide
nothing and a clear error. We cannot solve the race as you mentioned,
but I think it is important to avoid providing incomplete information,
so that either the data is complete or nothing is given back. If the
information is complete but becomes stale later, that can happen and
it's ok.

