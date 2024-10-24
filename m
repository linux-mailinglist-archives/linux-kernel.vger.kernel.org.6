Return-Path: <linux-kernel+bounces-380727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB6F9AF52C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C588E284907
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4158B21732D;
	Thu, 24 Oct 2024 22:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZ11TKYu"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8888E1C4A11
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729808223; cv=none; b=pZPpeU2cupT1CjpvfCKIADgJHk2VUi7VaCgqnPOCqbzRtsvRALfAJOeJ0deFMi5I/dyGHqY/qSlzmIm4MkjZVCyP+RGp8jHDpy5baSPJq16LuSI3xlK9le0s66dh2zotexwz6AwGeyqHLzw9YCQB5hUF2A/JecaXkAd0CF2lLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729808223; c=relaxed/simple;
	bh=+fdXlpqMk9lXjHG5hck/VmhWVDUIl/UM2AAo6ilLGQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcsXRySK+PZ9cIi1bVhyECdqiUnOGkDYfESM6k5GgXB4TAHY9626EiQcsFrZ8WvUMDzAjGH/Zuo8Qg7AgQXNOx8msErLnqxigNfTv5+su+zVO3J3A46CL991VqMl1m04cuVbGcIquIr/Uy6Qsrk9rw6mgZzjC5mIvYIWvt6G+Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pZ11TKYu; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso1807714a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729808220; x=1730413020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m82t+bGKWCHxJyqrbTnu2tP/AjOfVbnQoKLg9+UraA0=;
        b=pZ11TKYu5ffJzTQTOcqD/fjuaOzglfSiZkAlFepr3Hulv+Um55S/HpdGWh/2twSXiE
         ilGolCO7nLoR02/6J4oQdI7IKcDkhcTR4DUSu9RFX+rs2hKN/CAYMrIa7rEJkNQjSMuV
         4Gg0Cyb9WonToeombNMSnFqG4yAwLq+W53MZbvPhXxmttSJ10r0jiDb3mpLv6+TnFhbw
         TlIduHh7EHzmTDUD7J3E00mO5LKy7SLdntfoLfGJBJJUHB6EO1Dcqd0q1lSQS4Fx2so1
         CnlKkVGhN0Gau14cJ5Xg/5zAhEaBbLdWdmXFnHBmpwd68nO/Gk96YWhWGzTNngydLKGt
         kWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729808220; x=1730413020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m82t+bGKWCHxJyqrbTnu2tP/AjOfVbnQoKLg9+UraA0=;
        b=lE+R4fEY41E2fHdJd3PJaZ83QZBD32I8gyUkt0SYRXuN/Ujl2iP7cIOW/pL9PxsprB
         NyF3KGGv9eWT1l6I+fS3lOgy7XlzE2rVgTaPRFJvminY3EzbjUyboOcXviG70LriBigd
         ilEDW3zVwZhlv0dCCJd8jXlQtNC5k3H6WxdhLIQDW8GYXW2ObWFiZAAmPgcc1v08/YZw
         Ky4rTQdyHl6aE7TGWiwSPKhC/aGQO6TSMLzxoJIdsGkaD8JfnrJ2w5VRCQkALcqCIva6
         wBjOSzS6sZYXmXyzNmj1JFuA1O6QMcEwyzgUgz/5SoW8hfAY4MDzhLJeO1MUHQ1BOgly
         gZ+g==
X-Forwarded-Encrypted: i=1; AJvYcCWIg09Us7lZIdPW8paZF/kDj7LHW7dwOLGfywltS0s8tS8ZLzEgCinqU+l2Jk5jIsU+ztJEMPDpzPpScWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD/IPz8U/zQXIu/W632OYlD8PmTZmID9piLuTLazf+s9FDotrY
	LfmoxfNX5d4UJIunhUJ8v1zqToN8t2p/PvxNc1xVllRzSe9IMYf2YcuRod7nNCSRjWefnUnt/Ii
	AJEPCgPK1zLwYTKKSn3toT1uckyMAdTjJrB4=
X-Google-Smtp-Source: AGHT+IHvsd54q7H0Cux+j3inwm2+NVV934SOq1cxzzfsRzcUF0E/WQOyKHMMfrlhg4lPG5P7AftdSMSAQYm9bOQRohA=
X-Received: by 2002:a17:907:9453:b0:a9a:8ee:594f with SMTP id
 a640c23a62f3a-a9abf86eaeemr782033966b.21.1729808219583; Thu, 24 Oct 2024
 15:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
 <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-20-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-20-554456a44a15@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 24 Oct 2024 15:16:48 -0700
Message-ID: <CANDhNCr8rWc=1LMoW-fujpXVP2xbNH9HZ+7tbVU+tUSCYAUeow@mail.gmail.com>
Subject: Re: [PATCH v2 20/25] timekeeping: Rework timekeeping_inject_sleeptime64()
 to use shadow_timekeeper
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:29=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Anna-Maria Behnsen <anna-maria@linutronix.de>
>
> Updates of the timekeeper can be done by operating on the shadow timekeep=
er
> and afterwards copying the result into the real timekeeper. This has the
> advantage, that the sequence count write protected region is kept as smal=
l
> as possible.
>
> Convert timekeeping_inject_sleeptime64() to use this scheme.
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timekeeping.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index bb225534fee1..c1a2726a0d41 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1893,22 +1893,14 @@ bool timekeeping_rtc_skipsuspend(void)
>   */
>  void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
>  {
> -       struct timekeeper *tk =3D &tk_core.timekeeper;
> -       unsigned long flags;
> -
> -       raw_spin_lock_irqsave(&tk_core.lock, flags);
> -       write_seqcount_begin(&tk_core.seq);
> -
> -       suspend_timing_needed =3D false;
> -
> -       timekeeping_forward_now(tk);
> -
> -       __timekeeping_inject_sleeptime(tk, delta);
> -
> -       timekeeping_update(&tk_core, tk, TK_UPDATE_ALL | TK_MIRROR);
> +       scoped_guard(raw_spinlock_irqsave, &tk_core.lock) {
> +               struct timekeeper *tk =3D &tk_core.shadow_timekeeper;

Same nit as the rest, otherwise
Acked-by: John Stultz <jstultz@google.com>

