Return-Path: <linux-kernel+bounces-436368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F1A9E8507
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 13:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0508C281663
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 12:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C4B1487C1;
	Sun,  8 Dec 2024 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQXdm3+z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108B0145B16
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733661605; cv=none; b=OVTltvcmO1osvKJg4HBRaZXO8s+TdYmJizb1mJgHB+VWxXbsg+sN7TwK94SIsPq/soZUU521i4KckbCWPC86UaErCoBBaBvQ3xsnl/ue/KGG87+mFmHkr0imqvMha2NVUVtFAGOngZoCTxElI32iuDu5DPUtTXjIL0yxy2Y1ptY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733661605; c=relaxed/simple;
	bh=1G0B02VSoGkWDXtIBDZj/zP6yBb1MBFc5EqSbXewlu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9bbsCbZqufzi9/YLPyVb0plY6R0K9983jgxu+0sv1pneAXLjcq1usTzwKAr6x28HGPlNzvyf8J7qX5XtWfKIzWnjR2qwjHTk/9Xc0nUbqdA/4ZJIMjPqlpvLkE0o3FVvekf6jRIaaZnepErVYCm+3mQyVfMhQZb3ZZ+lNHKtlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQXdm3+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CAEC4CEE1
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 12:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733661604;
	bh=1G0B02VSoGkWDXtIBDZj/zP6yBb1MBFc5EqSbXewlu8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iQXdm3+zw20iJe3pJV5Vb8Vx/+GrBAeEDoSItnR2Wk3sx37k0LkoTyC+MQ35Oo6OT
	 YMjP7aRGc7sMsKZybDUZKm4GuR8sdMhi+RVjjMcuFpOG2pn+H/SP3jYkg9ER9QFUEi
	 A8FFLVhQ3gJa3RUCniPtqDNtIdth3VrMhHx8IicOcUDrQexmk0bV7TbCNTmPmd6SvF
	 ktHWCb3tK0km8pzXRx5d42LSGOGCS/t4u0KgnZDPdxrdps1mjTeluHpgOoeg6/ed+b
	 Cv6+FSE1DQYg5tgZG3DkA1jgZCil7C/3xAY7ztwvaJ0IwP5CGSD5m4O7POWfZi116n
	 KGd34LABdzU4w==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so5494647a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 04:40:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWiflHVyODnmBimPp8DKeFQf1BMc7/ZGIr4PuZ/jQLpMoqQ19TSg0pSV+b5gkbyyD+VP747P1xzAFSikC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBRzYUlIvfuGKDwk/ARUm4zZFcqxlIhO/cd0dXYKj9aHgimt3Q
	EML3bbAA0p42BNQx3t+wOLkdyYdU2sVPyEMIkWJjBBocVfQ0QEt6Qyk3mu5ulpyB8sOVVmQc+Cv
	36bE5CXZ5reM6kDxjOVFptAU/kt4=
X-Google-Smtp-Source: AGHT+IGeaLx3f1Ac4EO/HPEAwItXWDi5rNg1fdgeBLLyBEtQj6/hZFg8rbokXWrth1F/IG9LztUHgNYrOeJryi1WhUU=
X-Received: by 2002:a05:6402:360a:b0:5d0:f81d:f555 with SMTP id
 4fb4d7f45d1cf-5d3be695eb7mr11026027a12.5.1733661603364; Sun, 08 Dec 2024
 04:40:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729864823.git.namcao@linutronix.de> <f32741a5ad67d4cee6323757f3b8108084127cd5.1729864823.git.namcao@linutronix.de>
In-Reply-To: <f32741a5ad67d4cee6323757f3b8108084127cd5.1729864823.git.namcao@linutronix.de>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Sun, 8 Dec 2024 21:39:21 +0900
X-Gmail-Original-Message-ID: <CAGTfZH3=3_VEDHfco-eLy9acipngN5KnJZh61k6+BqbS_M75Pg@mail.gmail.com>
Message-ID: <CAGTfZH3=3_VEDHfco-eLy9acipngN5KnJZh61k6+BqbS_M75Pg@mail.gmail.com>
Subject: Re: [PATCH 29/31] PM / devfreq: rockchip-dfi: Switch to use hrtimer_setup()
To: Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,

On Mon, Oct 28, 2024 at 4:42=E2=80=AFPM Nam Cao <namcao@linutronix.de> wrot=
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
> Cc: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/devfreq/event/rockchip-dfi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event=
/rockchip-dfi.c
> index e2a1e4463b6f..0470d7c175f4 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -642,8 +642,7 @@ static int rockchip_ddr_perf_init(struct rockchip_dfi=
 *dfi)
>         if (ret)
>                 return ret;
>
> -       hrtimer_init(&dfi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> -       dfi->timer.function =3D rockchip_dfi_timer;
> +       hrtimer_setup(&dfi->timer, rockchip_dfi_timer, CLOCK_MONOTONIC, H=
RTIMER_MODE_REL);
>
>         switch (dfi->ddr_type) {
>         case ROCKCHIP_DDRTYPE_LPDDR2:
> --
> 2.39.5
>
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

