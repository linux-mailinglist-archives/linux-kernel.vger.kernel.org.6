Return-Path: <linux-kernel+bounces-417727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A849D5864
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECA31F233F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6561531D8;
	Fri, 22 Nov 2024 02:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WO7XrMR3"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9501C69D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732242990; cv=none; b=kMOdt8MG+CW5CnM92ao2carn8/mVSVMYtFrsqU1HCMrhvqj67BemzPSn/U+4rBKYKPBidcXLIallUJ8/BaOgRjeYFajUzyuc1aisKNXbpk5THKC3rOjUCVcpufA8Sk4W58cy1oIbCwbmmw0/jw94yexpqDKAgxSCb+5COmgO6r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732242990; c=relaxed/simple;
	bh=kNZsTWOCUGeXzUUlUp6ekbBy/pNDYV/8nwOWEdQK5a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6VoqGaIMfjMxzvBCFy4p99qLKk4mBrf7SpraYghENf/plqtR21DuI0+opLHWNLwGB0X/DTbtk/3jy0Pkcwgp5FGfgVZzeVAEWP7Y/CYaY6xyxT4/vAFtsOh7/DeRiSR+0dv3YKxhcwj92hk3y6msFabtgqzH9oepKQcdYemQfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WO7XrMR3; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53dd1829b56so1150939e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732242985; x=1732847785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w58mpTdLCyM76KOVFOa5hEFbjg7oBG1TqdCvT/1gms8=;
        b=WO7XrMR3mR/Ixs3fi5HyF2nwjVUOR0yg9FNQfEo+JypUWDiezuL9iQCnOsmIkcki71
         9IRAALZfsfudMVct2qQubnYJ0d0e3o5KW+kHcEkUJKlVqB73GuzLNTwZB8zu3LYE+UYt
         wZ6V297qnhg+HuZLgqj2rGsp1LvJCOb7EaKi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732242985; x=1732847785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w58mpTdLCyM76KOVFOa5hEFbjg7oBG1TqdCvT/1gms8=;
        b=h4pSGJoV5TH/hv3q6vpLdzGlPf3lq764jMlsx9n37AwnY5cVc9bTME7hvvuv00Br75
         ryw1G59beVoZTvdxfKjJDZc6NaGdpbJbfSF3mKGiB5qWBsCyKAHiE8276UHjtqjkF3Gx
         CkkuSWR02pB3oqa+5Eea3EQB82rljKWOT/cXISuRftU05WiWU7lmb1oyhbdf1Gg9zRJL
         yYU7JAFRa1AeApEBjAijejMBqGKz20rDln1JdjujtYmhv8aG8JEJ9jo+o+ePNh/b/9Rk
         b0vm9hbeaLuAwfPkJLKnLOQD/SPquKOOzLfY4qjQWwT4lFRs8/hDtzC8JG6pBiO+k0ju
         d+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnWpGvIV6Ni3/sL2NagbHXcBUbzpWjRaFZJzpWKW9bigCVzsDJEwUu4tuGG1Y7zEQ13WGCUFhTyk0mTuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS7Xx403vEJujiOni3GLIQxEoMtaeEXKiTvxFDWoANQPcr5DR8
	trhRvfIzZbdndEVKVih18IIaV/TEXcUztOCS5TYvmPg/yEgGf9+mjm9rxvxGraR7BxVAklwsdUw
	fl11s+GXgopKuWXvQ6XH3t8QvuT1GKZnkRlcv
X-Gm-Gg: ASbGncuOzw0ORio0zuXXaJ+Vc1uQudddrwHiDLgGKK2BNZ6w4rXSaqgiyrt56R0kJLv
	KN4s43eF5caXLbkZ1S6lQ2L65tLEHC5Z4AmvtWp5y8tKmYmj05PEtsDUVQQ==
X-Google-Smtp-Source: AGHT+IHv/1QmF+gjCpmGYzT7ut+STnNpVA5KQSryGBND2mlguVqBI1n74mDe76EIOb4qOgxv69lpEC6BjzzDg+jqaDc=
X-Received: by 2002:a05:6512:1247:b0:53d:d17f:9c82 with SMTP id
 2adb3069b0e04-53dd39a549bmr521859e87.41.1732242985261; Thu, 21 Nov 2024
 18:36:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121152931.51884-1-frederic@kernel.org>
In-Reply-To: <20241121152931.51884-1-frederic@kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 22 Nov 2024 10:36:14 +0800
Message-ID: <CAGXv+5HtG+6D8245DFAeSKfGL75zVkEGLu74=hqtjX=-Dpj70Q@mail.gmail.com>
Subject: Re: [PATCH] delay: Fix ndelay() spuriously treated as udelay()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 11:30=E2=80=AFPM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> A recent rework on delay functions wrongly ended up calling __udelay()
> instead of __ndelay() for nanosecond delays, increasing those by 1000.
>
> As a result hangs have been observed on boot
>
> Restore the right function calls.
>
> Fixes: 19e2d91d8cb1 ("delay: Rework udelay and ndelay")
> Reported-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Thank you for the quick response! This fixed things for me.

> ---
>  include/asm-generic/delay.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/delay.h b/include/asm-generic/delay.h
> index 76cf237b6e4c..03b0ec7afca6 100644
> --- a/include/asm-generic/delay.h
> +++ b/include/asm-generic/delay.h
> @@ -75,11 +75,11 @@ static __always_inline void ndelay(unsigned long nsec=
)
>  {
>         if (__builtin_constant_p(nsec)) {
>                 if (nsec >=3D DELAY_CONST_MAX)
> -                       __bad_udelay();
> +                       __bad_ndelay();
>                 else
>                         __const_udelay(nsec * NDELAY_CONST_MULT);
>         } else {
> -               __udelay(nsec);
> +               __ndelay(nsec);
>         }
>  }
>  #define ndelay(x) ndelay(x)
> --
> 2.46.0
>

