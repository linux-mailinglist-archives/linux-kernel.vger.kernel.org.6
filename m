Return-Path: <linux-kernel+bounces-384838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CF39B2F13
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8AF81C2142B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F391D61A4;
	Mon, 28 Oct 2024 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqD5m+iK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339F11BDA8C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115835; cv=none; b=X9DlVjiGq5bYt0wgA12PtvzDm5BVwoM81hBb7/34VqDp8OiYBDEsa+LtG9Dxt7fMw6X9aNiRZlplGTs+E71ucZTtXlDOG2hB2gKaQ5MjCKw7CIxpFBgHSekOCGHSZDbbfKbxcRvEc6T9sO1PzuKVA9GWLczGaRwIvpy8Qw0DXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115835; c=relaxed/simple;
	bh=rgVgboYVSnjOLzjBPqxu85PHqPpYSHKfnGtVE2I4UIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0gB4BjnNu7+wxPQasog6gKKIjckYj1I8IZ4KlmIICAgh174G2sVWWVCBd/7x7CGpFAYRWLxnwRBSZhZN9xMkCc+RMiTfthAEbPx1kmcD2r7nIx1eciTmzJLK/ccEw+atH3fw9WMv5QHZNF0c9K/mk5ppFgQ/gWTCuMXOX/rB7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqD5m+iK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9961C4CEC3
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730115834;
	bh=rgVgboYVSnjOLzjBPqxu85PHqPpYSHKfnGtVE2I4UIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LqD5m+iKpDWCt7N7wCufgxSM6ceVp58JT9SIVFmnEUggGAe/FR9fUfpcoKlozh5na
	 8+n9D9f2aZ9N1glwqW70c2aEdSKFAOosqwBI3Q6LceZC2WJWI0CrgOGVgOfiqOlbZ2
	 IWE7eJWYAwJrD/2xm2Cca8heQsWEVQKXvhVNLpykhCKh3+Mh2bTYWGtknJsZOnSKBG
	 Ps6M+6hppp3IMvAcGaBueA1sE09odVCTh9rnA+NkHu00iCDY5oELzPOIiQbdQAVQPi
	 4hJBLjgCqR2b3CYWqkLERmnw0HpR6d3L0O76NOAFQcqwH73fasi/9rOF8jHMMuj/kP
	 bkmMVjapzt5UA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-28c654c9e79so2954142fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 04:43:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjhUbaJGONer6b6uzKReI46riQjICtjgYsS0QGXS/72gXWQaSzUVWfxC3r8f5nufygWlVk+h6QWq0N5ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT+uWcfZJFycWv5MCOonhjYHyHlSvhvI3ttr3+q7VpTkIg40EI
	C5NXQB5VONg50cKpwYY8QJWKDs1DkP2c97K6lG2RNUJqKd5lwfQi1hbIgqMpTksRG7hHmv5oc4O
	90ucEA+rn0vv/NlTcSWAnxFzg6Vc=
X-Google-Smtp-Source: AGHT+IHDnKfzmHrHKpl46OnK0h+UYLFpHjOlJLTlQrtfub5KDHSvHMxdZxJEbaQMkGRpGGQSCJjReC+A4t1zHssGh94=
X-Received: by 2002:a05:6870:d10b:b0:259:8858:a330 with SMTP id
 586e51a60fabf-29051300151mr4793203fac.22.1730115834224; Mon, 28 Oct 2024
 04:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729864823.git.namcao@linutronix.de> <d4c90402b2e9a5b60b0c836e4aeb9329436f80ba.1729864823.git.namcao@linutronix.de>
In-Reply-To: <d4c90402b2e9a5b60b0c836e4aeb9329436f80ba.1729864823.git.namcao@linutronix.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 28 Oct 2024 12:43:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hWX3RrRRkKNCb-Ms3_gYAs_2vE1EaM91FFZqp2_NOkOA@mail.gmail.com>
Message-ID: <CAJZ5v0hWX3RrRRkKNCb-Ms3_gYAs_2vE1EaM91FFZqp2_NOkOA@mail.gmail.com>
Subject: Re: [PATCH 28/31] PM: runtime: Switch to use hrtimer_setup()
To: Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 8:32=E2=80=AFAM Nam Cao <namcao@linutronix.de> wrot=
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
>  drivers/base/power/runtime.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 2ee45841486b..425c43b2d478 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1764,8 +1764,8 @@ void pm_runtime_init(struct device *dev)
>         INIT_WORK(&dev->power.work, pm_runtime_work);
>
>         dev->power.timer_expires =3D 0;
> -       hrtimer_init(&dev->power.suspend_timer, CLOCK_MONOTONIC, HRTIMER_=
MODE_ABS);
> -       dev->power.suspend_timer.function =3D pm_suspend_timer_fn;
> +       hrtimer_setup(&dev->power.suspend_timer, pm_suspend_timer_fn, CLO=
CK_MONOTONIC,
> +                     HRTIMER_MODE_ABS);
>
>         init_waitqueue_head(&dev->power.wait_queue);
>  }
> --
> 2.39.5
>

