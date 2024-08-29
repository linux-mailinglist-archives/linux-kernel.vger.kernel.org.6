Return-Path: <linux-kernel+bounces-306538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E0F96403B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA41EB2630C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57B918DF8C;
	Thu, 29 Aug 2024 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asgLLTMd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2691D189F58
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924055; cv=none; b=h1qLorco0Z4FQpcC3Cbhmt2Yh+kM6dYC82tkJbeztNP11/X45njLpm1eOL2xCM5ZAbnfnEwgO/tfmvzIISGS+ASipgHzpKzkQUnG1FYFko4USDSYqj7yf7fm7ps3FpYeUU1HzzE1D77kfE468E/iw4VCE35F1T33xTA0L6psINg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924055; c=relaxed/simple;
	bh=LQhg4PoEpHeHBR+i7k1777fNdAXLDbRr3+E8Zxt0T7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NP89Gp8gsG0WJzc4LNZldri10bL3PL5SIQCe7XUr8fO8HG46nedA2Zshnd1gz6Fy2yGR1hpCjloMum1Yv2QGBP78XIqHla0du8plI+52hTbGgZ89Wy6MM7A1J83Vho+FXqqU3PWVVxYY9sxxsvAxRfZHemZ2MmswarXUjkxyLts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asgLLTMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A083FC4CEC1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724924054;
	bh=LQhg4PoEpHeHBR+i7k1777fNdAXLDbRr3+E8Zxt0T7g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=asgLLTMdE4rAV2gdc5L6rtywRT6QHtDjxrNDaw6NOk6JFikLXS/BIl4ht48YcQY0Y
	 Ttx4nD3QFa48uDLsyGVX4iU0puix1jT52CldlL4UDzr711piWTANLJlBpRMpr8TcsW
	 O2E9KEq9vXRw2xYgZ8CjjjETgcccTQhBPMywnh/3w9VRhQF7MkDuBymgDbIphwU/Ew
	 jGdt04ez+/0sBw6OC7epNugXyh2CTGoqgLrLp8vny/SOIc2FOQjFp/K7TjhOjwsIlL
	 OE+AIE5z12DJTMFJNIpLmWOLkkbj7r1osI33ogPxHXAMfn9jgM8tt5+IY05OghEnne
	 2MFsciMs8JAgw==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d5c7f24372so240649eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:34:14 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw7HEU/8siWxK0yLnEvOAYituunPa24ErpaTrHn6CKjubwzbvgT
	jSE4XfHoKGzG5ltMBitSkIQuIaBMJI4NZl7dwhHm97X2uHUtMaeDRb6Wvueu0qRsIcrEW/Q2Xxf
	bEgGrAD9TYFNagIhSDd7SIyUu/iA=
X-Google-Smtp-Source: AGHT+IFi03zJ+BOgWL48A5zc99C/ChPJM6rhDSihr84dL0peTAGJcdCIIltTUc5HeS5mOVkBbDJPrUIFdQ4ZhO+ErP4=
X-Received: by 2002:a05:6820:1609:b0:5c6:9293:ed8a with SMTP id
 006d021491bc7-5df98119381mr3075222eaf.6.1724924053940; Thu, 29 Aug 2024
 02:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829074133.4547-1-anna-maria@linutronix.de>
In-Reply-To: <20240829074133.4547-1-anna-maria@linutronix.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Aug 2024 11:34:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j286a-uc0xF-hkb+6qwrWruchCzABCUQJY1NaoLMY8MA@mail.gmail.com>
Message-ID: <CAJZ5v0j286a-uc0xF-hkb+6qwrWruchCzABCUQJY1NaoLMY8MA@mail.gmail.com>
Subject: Re: [PATCH] timers: Remove historical extra jiffie for timeout in msleep()
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 9:41=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> msleep() as well as msleep_interruptible() add a jiffie to the
> timeout. This extra jiffie was introduced in former days to ensure timeou=
t
> will not happen earlier than specified. But the timer wheel already takes
> care during enqueue that timers will not expire earlier than specified.
>
> Remove this extra jiffie in msleep() and msleep_interruptible().
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  kernel/time/timer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 64b0d8a0aa0f..18aa759c3cae 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -2730,7 +2730,7 @@ void __init init_timers(void)
>   */
>  void msleep(unsigned int msecs)
>  {
> -       unsigned long timeout =3D msecs_to_jiffies(msecs) + 1;
> +       unsigned long timeout =3D msecs_to_jiffies(msecs);
>
>         while (timeout)
>                 timeout =3D schedule_timeout_uninterruptible(timeout);
> @@ -2744,7 +2744,7 @@ EXPORT_SYMBOL(msleep);
>   */
>  unsigned long msleep_interruptible(unsigned int msecs)
>  {
> -       unsigned long timeout =3D msecs_to_jiffies(msecs) + 1;
> +       unsigned long timeout =3D msecs_to_jiffies(msecs);
>
>         while (timeout && !signal_pending(current))
>                 timeout =3D schedule_timeout_interruptible(timeout);
> --
> 2.39.2
>

