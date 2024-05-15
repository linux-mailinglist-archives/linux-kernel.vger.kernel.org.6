Return-Path: <linux-kernel+bounces-180155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368DD8C6ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9392284BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEE61BF53;
	Wed, 15 May 2024 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iShIHz4P"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95C823776
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791307; cv=none; b=dIQfGZVcIKRVrrDdw0Zx+mXK+T+1JiqGA8FtOWG9+NgRrLSyRXaTzrmSWXb+DNfJ1XzgUIZpHyxpL7vDmJ9ZGGKf7g2pi7Pgz+6VGSefbBPYURT5qnrSfaR2dqZ3mnVYwV2EoEL0bY84WBpgaht2erbAzeJBZPPZyaNS3jLk6Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791307; c=relaxed/simple;
	bh=epqSKX0tx62SmV+sXmr4kmPKa2bRIzghg2ir2HWmSG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5jWGBMHT2vtytGX0qwgtD1dKhsukUPmSk7YqwkGDyQ3+yJUqd1oKXHr/j1kwlbwx0jUxac6CXRR7760HjsHMgo+o+s9WnvrTAfGOU1uXYzYaJYpRhUJaAyc7BNkhxrZpuQhMyBdRX+I0B7A4XkIMqD1sIQWp9kvFDjv+k0fkeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iShIHz4P; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61b4cbb8834so71486737b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715791305; x=1716396105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwNT8ZL+ZrmeX5xZd+8ZhxRRmnXUR/OD21AGVm6ajjg=;
        b=iShIHz4P6DdCcCe3S6Qc751t3bircSWY8MgIwW2Rw0Qqy7O+K049zUVjKQUoa5bD22
         +a5KMw3vscIwUguAYGteOidpNqbvwClySo+P3FF24FMvs1094moHljbMcN0ax50zjeRa
         Y/AQLt1IscJA/pDDsFRWjIa+Ou2ObDnfY3gNzZXjXvoeM1+QxuQfgg2lNnlf5iGFcgC/
         tkq0hLoXj+0etXelnL7y+6ltSRFHHYX7+c45PTV0WmIH4ZWCxodrKOdKnBRgv1lhDhOB
         I7YWpAo0QIDIE4SrKy3ur8wuyF5NwWXUdKp7cApxkijPtpS7M/5ytAtjrB1oTmeTlu1H
         LSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715791305; x=1716396105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwNT8ZL+ZrmeX5xZd+8ZhxRRmnXUR/OD21AGVm6ajjg=;
        b=g1U4y1CHXS2Co/k7FusFXWrEj/MdI0grycQREI3Shfjo6qarebBCq8oAIie9jsJVVf
         bAs+67IuUdPwoRaNFq7MCcr8j6bcVUzVp8Ge1VvtYgz/8xoBbtFeT/97gNIHMXLsGpB7
         MVBBbYzJsOjniNtFUbEnIrK/mxNAmZ0ARDrrATKU2SNgR+V7NZNfmkaqrAEWHuWNMBOx
         DysIr4dSSUlLbijkVChujRpf/dHPmVlUvN5TgPIdpM8H3wtYqogHwIcdSWsvme448PkU
         gaVZauY6ozL9dBaNEUhgjaWKXVEBKgBg45/cZvf/FTDsCjaJIJ97Z1IwwDvUbz9qCC5A
         XD4A==
X-Gm-Message-State: AOJu0YwRQYkl197tfnRJvOaEnVAIIzJGTdDyRTJ20f5RlK3SCYzEKPb/
	jx7fdKC7al0CfDW/y7IYXyAGnnbpJxG+7aAFCrQRmqew5WEM4EbDbkLCqoajjDOB/CFUi/SbAWs
	UoZMeMxb+ExJXpn3MMeAkBbtJwmTEbA==
X-Google-Smtp-Source: AGHT+IGBSWNTuYrTLQYr3EHR41G3+3oxYomw36wRC/+aAhGaeuq/gY9B2ejH05/nB8AU4tkhnk3QeX7P+RLVaGkZKOM=
X-Received: by 2002:a81:ac21:0:b0:61b:16d9:47cd with SMTP id
 00721157ae682-622aff90091mr157557587b3.11.1715791304773; Wed, 15 May 2024
 09:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508172621.30069-1-ppbuk5246@gmail.com> <20240509092931.35209-2-ppbuk5246@gmail.com>
In-Reply-To: <20240509092931.35209-2-ppbuk5246@gmail.com>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Wed, 15 May 2024 17:41:33 +0100
Message-ID: <CAM7-yPRS7-6sQbpn0NxU0hqtvAWf4F=AF61oHGbcBV9U2eAhSA@mail.gmail.com>
Subject: Re: [PATCH v4] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
To: anna-maria@linutronix.de, frederic@kernel.org, mingo@kernel.org, 
	tglx@linutronix.de, Markus.Elfring@web.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping..?

Am I missing something?

Thanks.

On Thu, May 9, 2024 at 10:29=E2=80=AFAM Levi Yun <ppbuk5246@gmail.com> wrot=
e:
>
> When nohz_full CPU stops tick in tick_nohz_irq_exit(),
> It wouldn't be chosen to perform idle load balancing because it doesn't
> call nohz_balance_enter_idle() in tick_nohz_idle_stop_tick() when it
> becomes idle.
>
> Formerly, __tick_nohz_idle_enter() is called in both
> tick_nohz_irq_exit() and in do_idle().
> That's why commit a0db971e4eb6 ("nohz: Move idle balancer registration
> to the idle path") prevents nohz_full cpu which isn't yet
> idle state but tick is stopped from entering idle balance.
>
> However, this prevents nohz_full cpu which already stops tick from
> entering idle balacne when this cpu really becomes idle state.
>
> Currently, tick_nohz_idle_stop_tick() is only called in idle state and
> it calls nohz_balance_enter_idle(). this function tracks the CPU
> which is part of nohz.idle_cpus_mask with rq->nohz_tick_stopped properly.
>
> Therefore, Change tick_nohz_idle_stop_tick() to call nohz_balance_enter_i=
dle()
> without checking !was_stopped so that nohz_full cpu can be chosen to
> perform idle load balancing when it enters idle state.
>
> Fixes: a0db971e4eb6 ("nohz: Move idle balancer registration to the idle p=
ath")
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---
> v4:
>         - Add fixes tags.
>
> v3:
>         - Rewording commit message.
>
> v2:
>         - Fix typos in commit message.
>
>  kernel/time/tick-sched.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 71a792cd8936..31a4cd89782f 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1228,8 +1228,10 @@ void tick_nohz_idle_stop_tick(void)
>                 ts->idle_sleeps++;
>                 ts->idle_expires =3D expires;
>
> -               if (!was_stopped && tick_sched_flag_test(ts, TS_FLAG_STOP=
PED)) {
> -                       ts->idle_jiffies =3D ts->last_jiffies;
> +               if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
> +                       if (!was_stopped)
> +                               ts->idle_jiffies =3D ts->last_jiffies;
> +
>                         nohz_balance_enter_idle(cpu);
>                 }
>         } else {
> --
> 2.41.0

