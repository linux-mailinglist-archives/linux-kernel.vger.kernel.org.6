Return-Path: <linux-kernel+bounces-384841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3379B2F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD119B2264C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D1D1D7982;
	Mon, 28 Oct 2024 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQdZnccB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435001D79A4
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115876; cv=none; b=lUM/kzXI7wauLbt60fmUW16PUjRu9QwRD19oCU4SoCAoU69RY8eKoXkkKpqssPIdUl+4RyA2uA7VFdgDq+LTHxQfyRnvazJKcdMKdLbjJm+OdicZD2HSBmodnQsfFDxENhxZfgRd9YOFYmPUrIQmWUxPUsIDt8BHXJITdl2OPAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115876; c=relaxed/simple;
	bh=FWvU9xXcN5UuemLvA1Ow59vdVby8+v74r0oODyYL7sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6fpnub6yoikstbOejOJiwW4RyrIh94gVrngDAc0f+5mTkWFgahTmPHGMe5SGcwyUqme1SVzEns/EFxdg7EYHthkoThicK26CnA1/KJ/X8c5u5dkv2rUaR42CrrnaFSbnGreQ/slfesU2VD/9DO+CXe70MwIdhbUIAS+iJ6pkIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQdZnccB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA06FC4CEE7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730115874;
	bh=FWvU9xXcN5UuemLvA1Ow59vdVby8+v74r0oODyYL7sI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EQdZnccBstB0/5aa58za0aEajPvjOFcd5gU9VnXUvSMVbHLzCniiHbdenGpjzrToG
	 Xsy0IqVYDADxnu62Y7rYoRBWEszvIjtoAVEmvRJJ6c5DaBGa5pJgJUrJ6RN7GJ+uJy
	 QxOIcrpT6rmZ/0fDmVm+pM5ETZWCoQaTofK0O1BHk3IT8EX9fsfS8S/Jm5LIMoyh6T
	 ncQrjQqmg70s1+XpsOWLAIMy2QR9T9QJ9QDjKuk39IS7D2OTJeOTAFD15cNB4BU177
	 8W2Hjg4SCmvwp1urIPQY4/OqhJJpl6ZlbRFennLNsLsElPDhZFvmnPVrTd2QyNb99X
	 t07SRogtwBSfA==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e600add5dcso1847451b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:44:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeZvs0q3L+Nd01g7JF3ozWVIp8R4Y7YuruwVRmNjqmrSwitBgsDiTIhahMjW1IAjh+xnRpOYakfgjRGaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7xrnMyvf/PYMgaavdcBmJkqq7lPvf4puaHEU7dY4oEE/KlfVf
	+XoPhrON+6tRcVGoYc/lk0ybX7LudJUho+W+QhaJfK3zap000aJaylKhUSRuKENLC0CFC04yDmd
	djElV1IJLf6MtfIDf/E2dAOQAnzA=
X-Google-Smtp-Source: AGHT+IH8YepdTxeUQo9hV23BXTJEowPuxk/AyZofwmxXSP3KSPcoTeILd+xVoEWejQCfK11aegXIlCAJrKk7dwQyFtI=
X-Received: by 2002:a05:6870:46a4:b0:286:f74a:93cc with SMTP id
 586e51a60fabf-29051af0066mr6157384fac.2.1730115874158; Mon, 28 Oct 2024
 04:44:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729865485.git.namcao@linutronix.de> <d607a13a16b0e3c5b5d58b73869c83c0740214e4.1729865485.git.namcao@linutronix.de>
In-Reply-To: <d607a13a16b0e3c5b5d58b73869c83c0740214e4.1729865485.git.namcao@linutronix.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 28 Oct 2024 12:44:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hGYV2PT_Ws-nF7zy1scmp=x5EMV-xvGzks=j4t=BhTBQ@mail.gmail.com>
Message-ID: <CAJZ5v0hGYV2PT_Ws-nF7zy1scmp=x5EMV-xvGzks=j4t=BhTBQ@mail.gmail.com>
Subject: Re: [PATCH 15/44] powercap: Switch to use hrtimer_setup()
To: Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 8:35=E2=80=AFAM Nam Cao <namcao@linutronix.de> wrot=
e:
>
> There is a newly introduced hrtimer_setup() which will replace
> hrtimer_init(). This new function is similar to the old one, except that =
it
> also sanity-checks and initializes the timer's callback function.
>
> Switch to use this new function.
>
> Patch was created by using Coccinelle.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>

Fine by me.

Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>

> ---
>  drivers/powercap/idle_inject.c       | 3 +--
>  drivers/powercap/intel_rapl_common.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_injec=
t.c
> index bafc59904ed3..29f9f452d445 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -339,8 +339,7 @@ struct idle_inject_device *idle_inject_register_full(=
struct cpumask *cpumask,
>                 return NULL;
>
>         cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
> -       hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> -       ii_dev->timer.function =3D idle_inject_timer_fn;
> +       hrtimer_setup(&ii_dev->timer, idle_inject_timer_fn, CLOCK_MONOTON=
IC, HRTIMER_MODE_REL);
>         ii_dev->latency_us =3D UINT_MAX;
>         ii_dev->update =3D update;
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index 5e793b80fd6b..e675d4240d9f 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -2063,8 +2063,7 @@ int rapl_package_add_pmu(struct rapl_package *rp)
>         raw_spin_lock_init(&data->lock);
>         INIT_LIST_HEAD(&data->active_list);
>         data->timer_interval =3D ms_to_ktime(rapl_pmu.timer_ms);
> -       hrtimer_init(&data->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> -       data->hrtimer.function =3D rapl_hrtimer_handle;
> +       hrtimer_setup(&data->hrtimer, rapl_hrtimer_handle, CLOCK_MONOTONI=
C, HRTIMER_MODE_REL);
>
>         return rapl_pmu_update(rp);
>  }
> --
> 2.39.5
>

