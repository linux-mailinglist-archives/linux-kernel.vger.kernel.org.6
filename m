Return-Path: <linux-kernel+bounces-540048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 603CCA4ACEA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 17:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61871188CBD7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 16:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CA81E47C5;
	Sat,  1 Mar 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeheIX70"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3321E2614
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740847414; cv=none; b=nmOPXOCy4kWpYUqWmDq800F0WdFTeM8H9nZ6pJ8t+bxCL+XVWSqX0c04/zsVr4vaJm3JcETiVyEJwb2+8gxGc4cbR8j0FeVNy5BxqVVB+Lak57v7LiI+9Esxelcey3YWvn+GLU6owcwHpoqYvXN3BrWJHJyhoweY6X0d107I5Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740847414; c=relaxed/simple;
	bh=lZ96GJX9ia7i9mFptcEs5uTXIcmD5xpmN6ZoMhTwglM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moXbYuFno8yIHS1rLXHrTSS76s5zCmh3sCwxjwYOEXhlj+AKR03wfSUhekHgMoU5JLdmPre2/2CZqNvW7ex1N8YKgzu5rpsw2NJOsAe6i3PPeWKSAn+F21YGiOP1IIPR6CwNDg7CYUm4C7dQghBGJsz7JfjCabaGfYkza9tpZB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeheIX70; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5fcd61e9bcdso1444014eaf.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 08:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740847412; x=1741452212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqpGN74uLKTndbE8y2sLFiJa3upmUlF+6EHmUj9p/O8=;
        b=YeheIX70Jyz8y1t95TGhXJ8M5hcKamuxWwjnoMnpqzxL+N/CHHxmydR0ai5wMnmHky
         JrEBCO+1RT+Zs5C8bFVsigZDjprP0KnxxxKkUJzHxR4ET5rKPMHQ75ePAqZ/jGlxhId+
         hjZB7AGcZqjFPdQdntgvdIcsus9bMJoQP+azoIr4oBL8PWx4+3laSUbifKXjr0o3NI3f
         EqYuNH5D93QqA14XydyblHhSAsMIr0oFkmu06US/KKzGRSid21rTPMnfQxCP/gnFsETB
         mDGpWjUak7ha+MegkKzlMBNWuKUj05osF+gDyJwgCsgFRGY5gv4NDXLUucF7gKzczuS/
         UYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740847412; x=1741452212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqpGN74uLKTndbE8y2sLFiJa3upmUlF+6EHmUj9p/O8=;
        b=fzga+cnHSkOd0Bt8OcIQiymjEgU0L402spoA6qPUJkVKskZ+SdzEMJKG875tbwVmKI
         t0+AD2TKIS0WVorfB7y0yFeknLDPVAz7JxuTM4tPAOv9Iahjo9eXuAU6Gy5gplwOV3x5
         u4G2SLy/958nd8pzos0h+c/4lICfZqdhdMhnjEWP5k96hAakmt577xt/BiEf42oerSu6
         HTBp9luKYfm4ZNdO5LyzKBWbZGKN6+ihDWepsNBFifrom5O75riCEv5J2zhBayY7wMxh
         w5ChUWzIfExrRmZJFBEYEdrHlLVE7XOWVhlByIxKXFZE8964GKVCgyZRFLmoN0+u75OY
         z2UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFt/mTV8wnNXVFak2FgBJdsYKom+xUnPWZJkxcWguPHhS4xwbxY3PQQgnNlHqZaC4qdX7nY9PYkzlMq7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYUCajZHEHj1zIAgICeJ+Z2h5EqFtAMZcjdhmR/RG3M6t5Fnbu
	RxpKVxjPtcPuu2KGwIciIRFVUfYYXV8E3Uqam4TG0GDKDkUr1sEXyAsrPTVlSSn+inL+qra4i1s
	MO+xbv4AOBvEnL7+nKJ04IYSoVAk=
X-Gm-Gg: ASbGncuysNpMrbWaB4l6ci/wv1pw+DvN2lYdQGPJRpPlPAQ8f/MHpP71wzi3IWMyM5e
	LMO8YFK4/M6MItpO4HWsEJxchSuQs3G+ZjeWoUSwOqSLiPNWmvqpDzjBYApqc1LjsKdM6kuzJS9
	D2XmoeEfB+FHTyNS2y2Q3nBxKKowg=
X-Google-Smtp-Source: AGHT+IFEQExXfd5nXjh/0Rhz6oKoJlsNk3ijzA2Q5b4qr9H97FeR3VAccRbbYLVFGb3V8C6bnV47Hski/JImmv6ywlQ=
X-Received: by 2002:a05:6870:f6aa:b0:2c1:9897:dd24 with SMTP id
 586e51a60fabf-2c19897e8f8mr1553238fac.35.1740847412185; Sat, 01 Mar 2025
 08:43:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738746904.git.namcao@linutronix.de> <b742f81b6acdaa604511834a06a8aac3e6e63ca3.1738746904.git.namcao@linutronix.de>
In-Reply-To: <b742f81b6acdaa604511834a06a8aac3e6e63ca3.1738746904.git.namcao@linutronix.de>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sat, 1 Mar 2025 10:43:21 -0600
X-Gm-Features: AQ5f1JrULmrEVqWUTI7qM3okQ3TJl4VBiyG0JJAjrn8R2rwCaJ6qmuLp625tGeo
Message-ID: <CABb+yY3tGBg=t1FV2diZKPa+dt3_9LZ6gqHFDJhMrhoRo2MzRw@mail.gmail.com>
Subject: Re: [PATCH v2 24/45] mailbox: Switch to use hrtimer_setup()
To: Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	Zack Rusin <zack.rusin@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 4:47=E2=80=AFAM Nam Cao <namcao@linutronix.de> wrote=
:
>
> hrtimer_setup() takes the callback function pointer as argument and
> initializes the timer completely.
>
> Replace hrtimer_init() and the open coded initialization of
> hrtimer::function with the new setup mechanism.
>
> Patch was created by using Coccinelle.
>
> Acked-by: Zack Rusin <zack.rusin@broadcom.com>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> ---
>  drivers/mailbox/mailbox.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index d3d26a2c9895..118beaf447aa 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -534,9 +534,7 @@ int mbox_controller_register(struct mbox_controller *=
mbox)
>                         return -EINVAL;
>                 }
>
> -               hrtimer_init(&mbox->poll_hrt, CLOCK_MONOTONIC,
> -                            HRTIMER_MODE_REL);
> -               mbox->poll_hrt.function =3D txdone_hrtimer;
> +               hrtimer_setup(&mbox->poll_hrt, txdone_hrtimer, CLOCK_MONO=
TONIC, HRTIMER_MODE_REL);
>                 spin_lock_init(&mbox->poll_hrt_lock);
>         }
>
Applied. Thanks.

