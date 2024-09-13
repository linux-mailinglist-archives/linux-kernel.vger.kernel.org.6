Return-Path: <linux-kernel+bounces-328464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54E69784A8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A09A1C20CCF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4204D558B6;
	Fri, 13 Sep 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mPHbH+u9"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149612629F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240619; cv=none; b=CNggc2fIEc+vN7pbWiZdQQjfqj3nqVL9XHPe4BPxDydofO0Ro0L7Pj6QzyqHxuQhT5ltZ5dYftMxpj7Hdlk6nbI+ErI+r2MZ+2MR11Fn1q4sZmaWbGMzreCIaj4cNFkLphny+gZcKj4k+s1ZoERuyZIioM6NmlQIH5sVvcGCSCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240619; c=relaxed/simple;
	bh=xAWkEscfYbcgnPVZ4edFBthl8XXEGTFdPUlCpw8X+X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5fZnKYW54TLSPMhlUkwtBtn45spRa5Pp8k1EcZ+qqRKdSEDoxh+sQou3Sgyl5ADHPFuZbDc+w/NBJUpr2So9jP5uOzV6p7TLzQIh2oDscNogWD7gNr7udYa/fCoegGLki6nr9PHDglEWZ6ox4gOzJ9VcqI6WakeQFgVhPXm4L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mPHbH+u9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so549533566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726240616; x=1726845416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YdprUc1vPVqWZrJP7Xy0uhlo+IsxLQcTd7Jlyz7yzs=;
        b=mPHbH+u98l781NDodvWjfVZRVyryKrkfh4bEfOpjuEzLcvTVrqtXui5zZ2m03BFsoH
         nRi95L/QBbG+xm/gZajtDB8riwMBVPngfybSQNOYWAGbBZ3MltWBSx5rrdc3NhQWaQL6
         0/aQluiBXLmNnEfxhFXDKa94Eb08BRkAr2G6EmcqZvwOsR6pwN0OLL8eqLUqr5ppl/I9
         l8kMZtg1JFmZyi+1BBZCI/SS6L5ZI3TURwXZUv8i6pT5Go6OKRyrvV+pPr+Pjd8Q2dJ8
         LALkIIHshGrsVqO5W8k2ynODB0sEjEczDoZ93qeqE1rJcY/r1Tdc3zplIK3/6idbdc1X
         MdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240616; x=1726845416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YdprUc1vPVqWZrJP7Xy0uhlo+IsxLQcTd7Jlyz7yzs=;
        b=SLTbfB5enJift5nOxd3ZDjCpY2EXnDz0yO0QRB4E2Yfbx6NIO3WkLYdChJZhtPqf5v
         YK7k5xjwoGJsUD9GKo6qTTMYVuc5ntSLw0o6ljh/bg1si7JMNqM+xPnUff9JHblKl0nX
         aP0hVQR9IPYFCH9dWqQDCavFgkdexpyxFvDJpF+fabvB7HA/8+b2rB6LR5JQVoeRvUXT
         /mW2G1rlG6OvvfrMYIzS7BoVQ8JsEhytftwc6h4qLEmBm0PAODCLheEVsU97/+TzZ7nr
         zu6OD4ElTVnTippNn8gZ6FPTztnLiqZKuIZnpvojR5472qBisckKVXdbyI9CaO0z+QYx
         2cpg==
X-Forwarded-Encrypted: i=1; AJvYcCV4xqamKhmgfz0/I8lj8x3HW7hyZ0i8prE/3zvC3eaQsMadC+2/MDIMSTuWvTlc1XNhuB5EvwHMysboHx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6xF8UiyPQd19/U/6Oq5FDwHvAL02d37Y/UTXiQZAksDis4Ods
	dECn1mjIHiE7raEMUTK9TSz8xrA+tkJYsaoJwi1a4Q29qrCK7FmaW41fb7qHuTYeQ5sCuwiiSSS
	Lu6jvuoFiQw2dlN4ZazO6DMf9gNYfhddf/FLg
X-Google-Smtp-Source: AGHT+IH64JnbnKqlgjuwZ2poHsHnkRBQt2ZGALlB0BUTFCR5X3gE/MmjgeDfm+uKTA7o3vUfN5CtY78gFaFyWIBw5kc=
X-Received: by 2002:a17:907:9723:b0:a8d:2bc7:6331 with SMTP id
 a640c23a62f3a-a8ffae3a217mr1348205966b.27.1726240615882; Fri, 13 Sep 2024
 08:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913150954.2287196-1-sean.anderson@linux.dev>
In-Reply-To: <20240913150954.2287196-1-sean.anderson@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Sep 2024 17:16:45 +0200
Message-ID: <CANn89iL-fgyZo=NbyDFA5ebSn4nqvNASFyXq2GVGpCpH049+Lg@mail.gmail.com>
Subject: Re: [PATCH] net: Handle threadirqs in __napi_schedule_irqoff
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Juri Lelli <juri.lelli@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 5:10=E2=80=AFPM Sean Anderson <sean.anderson@linux.=
dev> wrote:
>
> The threadirqs kernel parameter can be used to force threaded IRQs even
> on non-PREEMPT_RT kernels. Use force_irqthreads to determine if we can
> skip disabling local interrupts. This defaults to false on regular
> kernels, and is always true on PREEMPT_RT kernels.
>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>
>  net/core/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1e740faf9e78..112e871bc2b0 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6202,7 +6202,7 @@ EXPORT_SYMBOL(napi_schedule_prep);
>   */
>  void __napi_schedule_irqoff(struct napi_struct *n)
>  {
> -       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +       if (!force_irqthreads())
>                 ____napi_schedule(this_cpu_ptr(&softnet_data), n);
>         else
>                 __napi_schedule(n);
> --
> 2.35.1.1320.gc452695387.dirty
>

Seems reasonable, can you update the comment (kdoc) as well ?

It says :

 * On PREEMPT_RT enabled kernels this maps to __napi_schedule()
 * because the interrupt disabled assumption might not be true
 * due to force-threaded interrupts and spinlock substitution.

Also always specify net or net-next for networking patches.

Thanks.

