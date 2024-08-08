Return-Path: <linux-kernel+bounces-279369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEDA94BC5E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA441F22638
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B01A18B486;
	Thu,  8 Aug 2024 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ic87owmA"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435318B46F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117084; cv=none; b=IXUs/au5zLj5ZvTIPpUz4clYaaEXjWvEsqOQsQNZFtFJ+685Fdryk36+6GtOBB9NyE0lM3uK4Wru3Qy+yXnXkGyNeTIn2Hs9gH11z+N1DIT0t9cYfPFgH1PLmFsCfzlcc239kWuzQXIrOmtTyHh6gE6sobiZ3sHO/K1q9L5NTvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117084; c=relaxed/simple;
	bh=+dwr+DGgf+0YuXp31MYMDF30WY8nbqTnvkjcVriwSwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4ukgNTB7Vj4m5VSM4/23dczrYByA0Yj9yIVB5N4A6wx1glOSx4Uc7bj6JF/eX1HxtMa8meqDhkdZooPrdvPAKq0AL377D/uZ7/TITt4mtE7vxGGrmBgZF3Lk1RFHwe9W8r3zuAVL5gp40uv22aKmwvnPBU4ys0nX5xOY8ChApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ic87owmA; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f01613acbso2127952e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 04:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723117080; x=1723721880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4RYVOZDorjhiVwWLiQjhwLOB5M2EEGPW2lhhTwpepA=;
        b=ic87owmAizGKMwb7oTow8EUOWecJ3c8NQmFdWeeo3Rr5X+mpWvJ1TZoB0I/byLnFoK
         8lWgQ+/kdio2SJj2TndfuPgABSfOu3zu8kMwhKL7gZaAjxCYZhg7klNcJXDGIGWdtJ9l
         7YVPSqLsJjspLWK8R9HAxBI/nc6xEehvwTJq+YDeK+facsQ2+fbKUhDXienuOk5GrNOp
         VHZ82GUmFY5zH1RjXubixUpehFEJRE6DO4VwUD2Qo+4caZxzNtalTdnBgtXPXjIJMY8R
         VaWdSulP85OPb8/1aR+0K7PE1UP5mJLXd84c1o+r0osckAu2MalFYdPq/rcX2syJc6CE
         WqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723117080; x=1723721880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4RYVOZDorjhiVwWLiQjhwLOB5M2EEGPW2lhhTwpepA=;
        b=AoMKm10/nIBBT/0o6m6z7bOvXEl989r003OAMI8rhbpCnTQ7t/Utq8uHxg00npxk9D
         bXGAWLguTBE5tJhYuS+rIt1ScTbWrCnPZHQefJRW9z1iX6mffbHHPO0XYGdzwpyz9zTc
         jSIjGe8rDqDsNzUfNZACN6jFN7lAkULtSbBZOOpF80hu9RyT+Womhz+pddB3tfl8Vmh2
         haO1UNFR8r/0dP3ue96wqU5ZyQTBggIlExDcYNFVI2jgSI9gjaLnaSyTQhTf8cGuAZ7G
         HGGPGdBY5rf8rgQZbN4AoUATihLBfdAC2hoMmoTTQ1eAiS0sNszB+bY4n5/3CZCtYCWH
         54lw==
X-Forwarded-Encrypted: i=1; AJvYcCUh2su7UTe8WouEkNS5WwKmM3EH2OMY5QVJNZw+G+d2ICDSZQUw/vX1pYm4rvmKbz6ldJ1nqHp+Gcd7Cytf7ZHZ3rRBrRzftq/+VVMZ
X-Gm-Message-State: AOJu0Yy40IPhIJnEoMqPEd5L28HHbaVh4QNO95anE5TY8l1SP4NM/MRj
	Key72nVy5HaxsRgrN1/Dz/Mvj2NgdcFNbx9VMDPXuTQH0YncEwNwJU7ob3o7yieBZvr1SdVAQbp
	YdfbsecTlrIUH0jJndU+O6MeVJSrMwSK8F+72exmMFR7N/bGibb0=
X-Google-Smtp-Source: AGHT+IFA5CTIPhUdy3XUOHKtdMWX19Sn1vMQxMfwAIRT2acIXFlSX8/kWezxWMNLBS2ML2mSkcozlYFT/FZM/biui4s=
X-Received: by 2002:a05:6512:3b12:b0:52c:dbfe:9b11 with SMTP id
 2adb3069b0e04-530e5dc69afmr518118e87.21.1723117080137; Thu, 08 Aug 2024
 04:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808104118.430670-1-jirislaby@kernel.org>
In-Reply-To: <20240808104118.430670-1-jirislaby@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 8 Aug 2024 13:37:49 +0200
Message-ID: <CAMRc=MdrcX+UuU0Obubc0Rc36p8V_+dHpc+9jFf2sXNaLbR8SQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] genirq/irq_sim: Remove unused irq_sim_work_ctx::irq_base
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 12:41=E2=80=AFPM Jiri Slaby (SUSE) <jirislaby@kernel=
.org> wrote:
>
> Since commit 337cbeb2c13e ("genirq/irq_sim: Simplify the API"),
> irq_sim_work_ctx::irq_base is unused. Drop it.
>
> Found by https://github.com/jirislaby/clang-struct.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  kernel/irq/irq_sim.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> index 3d4036db15ac..1a3d483548e2 100644
> --- a/kernel/irq/irq_sim.c
> +++ b/kernel/irq/irq_sim.c
> @@ -13,7 +13,6 @@
>
>  struct irq_sim_work_ctx {
>         struct irq_work         work;
> -       int                     irq_base;
>         unsigned int            irq_count;
>         unsigned long           *pending;
>         struct irq_domain       *domain;
> --
> 2.46.0
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

