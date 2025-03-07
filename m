Return-Path: <linux-kernel+bounces-550911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 828DDA565A4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E7997A2FD6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAD71A239E;
	Fri,  7 Mar 2025 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbrUSoQk"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86392634EC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741344145; cv=none; b=ISEEWhCYZpptymXaSIKJ23IEqWQJ+lWz6VS+KmkmuAgh1jtQx3BM5JJv3G8pl3EX25rWsK2YAHL3WUxqPV1Jhjwt2mmtVyI3KpARXncWjAprpTBw4fLCNuhi1vsjvagv/LxVMOpwfK4CNbiB0/8INV5YSl3WLb7XipPuDtqO0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741344145; c=relaxed/simple;
	bh=lsavoPaGmfl7xBe3eGeyegwuQTehNQkXPIt3HPhhJAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYU0Ra4BYBR/ozRgAi8ReUrpwndu/1cUqK/TYZfIAMVWY2aUb9EQcQPmHIQxPDypQm5ZSsuAPr5nyvZMnNKTUFt1UFyucW21WMAASY71difSrf24nKaZNMrWSAJZBlHVVrfIeQxHDK23KABBEAVZQPEQ9YQ8ULTvzAja/INWDz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AbrUSoQk; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6fcf90d09c6so14933677b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 02:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741344142; x=1741948942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rT9XBL4gaIH5wTfFP7ZDqQbyPhjMUoycaEEEpfHomFE=;
        b=AbrUSoQk6nhlWFqO4asokVbEHik6sxhxTXBMehcD48PPi+kiZ+QoMj89UqyX7uGJqn
         rox/zaobznu8VGNUgQi8tX6lzq87JapVbrrWnYIpiUeq3DeNNmRy4rPbXtKk1stnx7/D
         lhol3BWGiEoTAW8u+58noZaHj3mP5ogjQ6/orsrCyR44hr28qd+7ay6ZffuRBMGpkteN
         TMrMU10f2+/CfUMCMQagngKpeN3BUixY3A6QIVGxvPOGNp4Ue6wJRJmZ9loaf8zPxQUo
         jTI2Cy0+qzSTynAPbIDpXqrQt9A2XV9xF8LbItcFpCbjdlj0skD37bgLAhgUNK3ZyGKQ
         fFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741344142; x=1741948942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rT9XBL4gaIH5wTfFP7ZDqQbyPhjMUoycaEEEpfHomFE=;
        b=WPFlWYmAB/qGdq/yUIiQSRbIaHbw6viBULQkWSAztRHQiiSTWBMZNZSAvsz8tkv+yI
         B3HDXX0s+glAR8mNlhjy7PU1VtI8xQKskzN9g9sez4YOr4K1LxjwcHGxiDjzPKmHBRAh
         GR3qFVL2iMv2ythujxwIMV+H8Ipog1GQXrDl3T+6M1TXUEB9oh9wn0JtYFBjFozi6ebk
         x3+69PKgcrlzKM9dap0aM4jXiA8rzGgViSBm3uld7HmdvxmkhRfYPMF+c3S9+tgCHKB7
         imRaC4uXtHcAks5aCtCaFP9J7GoinqfTnnCOBDwxGBEkVRGfbYrxHw6c9kzBTDPJRZwv
         532A==
X-Forwarded-Encrypted: i=1; AJvYcCULCWYNhKqiACubgBmqcYzf9nbOgK4BOcOxKO//k0h7lR41HsvRc4pGxTqx1fVs0QQlnd22t4oTUFNk1DE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzns+GyCeLvh1ezsz0SfwOG8uhAi9Hvfaj/esmzyKAP/oGTb85l
	F2yC4kFSI8/WK+z5LGLBd0S/3lMRznS0RNvTwkrhrpJZ1l2MFU7P2yK5y4m6oFerO/QhT6MyFKc
	hnYYvnANVDb+AYwEpIijL1OkwbX4tOFAT0JF7Ag==
X-Gm-Gg: ASbGncvto+NiK+rPmDIS53QvGKqtxKtNBggs5laqbOyNrW6d+6Z6fAv9AsfgQh9xhHb
	WXT88zHg8uIhXPSty4Oj4qq+gC5QTcbAeuEjaYR1o1alRFwt0d9fDNAKkRBn9aYgA8NOGcXWJ9I
	CpvQp462d7UPheZr44ZFW1KYn8GA==
X-Google-Smtp-Source: AGHT+IHXG/0/hShmRUvQAKC9AHfln9CojQ/qyZWB4omLmQIq0J2ete1izlY+85xW6NmBXSV/D95xXORrnvizdPCA3uM=
X-Received: by 2002:a05:690c:b15:b0:6f7:9f95:d916 with SMTP id
 00721157ae682-6febea564cfmr43081107b3.16.1741344142511; Fri, 07 Mar 2025
 02:42:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306113549.796524-1-ulf.hansson@linaro.org>
 <20250306113549.796524-3-ulf.hansson@linaro.org> <CAJZ5v0hF_am9DsuwEUmmgpUp=1ZuAG8fdjYfQ5XxFmS_Y1pMog@mail.gmail.com>
In-Reply-To: <CAJZ5v0hF_am9DsuwEUmmgpUp=1ZuAG8fdjYfQ5XxFmS_Y1pMog@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 7 Mar 2025 11:41:46 +0100
X-Gm-Features: AQ5f1JqZoOcwKfjkiNxmTrOdstASOHx5S-JbLRg16VovAosUluf6_t-OvA7HKso
Message-ID: <CAPDyKFphQS4x68f-rHHkhG8w7b6UJcE32v0u-XApicn1pPARXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: s2idle: Avoid holding the s2idle_lock when
 calling pm_wakeup_pending()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Mar 2025 at 14:18, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Mar 6, 2025 at 12:36=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > There's no reason to hold the s2idle_lock longer than necessary. Let's
> > instead acquire it when really needed in s2idle_enter().
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  kernel/power/suspend.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> > index e7aca4e40561..ca09f26cbf4e 100644
> > --- a/kernel/power/suspend.c
> > +++ b/kernel/power/suspend.c
> > @@ -91,10 +91,10 @@ static void s2idle_enter(void)
> >  {
> >         trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE=
, true);
> >
> > -       raw_spin_lock_irq(&s2idle_lock);
>
> This is to prevent missing a wakeup event when pm_system_wakeup() runs
> at this point on a different CPU.
>
> If you move the locking, it may run as a whole between the
> pm_wakeup_pending() check below and the s2idle_state update, so the
> wakeup event will be missed.

Of course, you are right! Thanks for clarifying!

>
> With the locking in place, the pm_abort_suspend update in
> pm_system_wakeup() may still happen at any time, but the code under
> the lock in s2idle_wake() after it can only run before the lock is
> acquired above or after it is released.
>
> If s2idle_wake() in pm_system_wakeup() runs before the
> raw_spin_lock_irq() above, the pm_wakeup_pending() check below will
> notice the pm_abort_suspend set and return true, so the suspend will
> be aborted (and the pm_abort_suspend update in pm_system_wakeup()
> cannot be reordered entirely after the s2idle_wake() call because of
> the locking there).
>
> Now, if s2idle_wake() in pm_system_wakeup() runs after the
> raw_spin_unlock_irq() below, it will notice the s2idle_state change
> and it will update it to S2IDLE_STATE_WAKE, so the suspend will be
> aborted.
>
> I guess it would have helped if there had been a comment describing this =
...

Yes, I can send a patch adding a small comment about it, if you think
it makes sense?

[...]

Kind regards
Uffe

