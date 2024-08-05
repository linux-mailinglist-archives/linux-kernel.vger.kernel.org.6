Return-Path: <linux-kernel+bounces-275110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E532D9480B2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4619EB20A70
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8FC15ECEF;
	Mon,  5 Aug 2024 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1+YGheY3"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76542AE95
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880256; cv=none; b=tWM7zLAcmwG47tHGm+ssBV9K9fB5mw0gf0f0p768fggsedotO9U2QJAYrzrXjAQYOB836VBWH9mhH+qMRBxqpvtBgiHyHQtQMmwghyeB+mPSLyiBg9gZ8/Mg7EMAW6UqSKNuR7xSM5oLIB7TS86oYT0Or2wqJmw3XQawDemUaoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880256; c=relaxed/simple;
	bh=rwDvEWo7ML6XJ49bCQZF607D7ttE4gTKRlGFYbNiECU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uk472SowTHFzMckD08VmIDBXgNcztx/ybFA63pMhZ/TySGgQv3PH9eo+76saDtbB+ibrZt5MSTJ6+3QGxsvXRZHFUOfQGkBIw+lk1Wz+L8d0vYHVJJFLDQLNYbpSeCyhr/cewQg22hvOscgCejqqt2aUFM7HhelmT6eUMPdwNes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1+YGheY3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-427fc9834deso8105e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722880253; x=1723485053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocKj9GeQPG4a16a6G53jhVeGgNm4Y09k42rcl0bWbLE=;
        b=1+YGheY3c1qbKlOfAUC47mJfzM4/2f9t1OlBhLyBa1He7YmIr6mXNJAArk1UGKP0z7
         l6Lmf7L/DTn/zAfFyap8A5phpkjdlzjqHgeVfId+VezEwD0YZkrKpKq1VrOk3od917CR
         0SkxRQIpk/Ucep1ND7PgNfEu9B4v4FiK23sJ2D5CHr51XwXUkoO9Bu5lBkRC2j9vEML+
         gGZhE3kqJOGLmL57Vwt9ULFrIq+TCFZ5ncduu9cIvS78z6NsImLpaRklGfZuhEBS1UQI
         waYmUnB9pYkR9s+6XN2HpZzyVzxh9A4V266kdu4FzXB/yD6y45mY8nW9S4+/7gIXosnq
         oVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722880253; x=1723485053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocKj9GeQPG4a16a6G53jhVeGgNm4Y09k42rcl0bWbLE=;
        b=mibxxoYlpu1o/lrRAD1yHuKJeR3PVWf60PIJGBkSaZrOIMkd8VUAEXdhKkOkIWIgjo
         MM5phM/lj40KCz7BppNo1suA2cJuYDjgFujsowAemSIlkevwZk2Dt1iDJJhXJs3GyDWp
         qaQI3kT3JOLywI/Nlpj5sI3/EUI2RuxLM4YOrubYeVVeifVHKYTbRj7Y4UMKMYk5qaw6
         BX7PUtr4VuxvVEhpD5Ispi1rvoPxGL1YVBlYLUzwDKuUO2Nd7hFtZjm0eD0EAUK1m0si
         8sz7RmqnptFKBlCqHf23pv6TWu3+n9ERAhT0rHKJ9HX/nBfobifdfAokTpUCIoeNYcMD
         BbLw==
X-Gm-Message-State: AOJu0YxWzagGf/DVjEIvBwmbPWjNhDFUCWl1XV8Ji+W8w0hWXB3l7foa
	0nKcbhWAfFusSsDfqui0v3nvZrJexyx+WyUD+U8wKynV422xDe+/mQ4t7rAhvKMxI3qggJJ8l5E
	LxsaQ3rVSp9NroWyvevFwJCvHM6fijkuQArk=
X-Google-Smtp-Source: AGHT+IHZ19Hfnq8Ci62jRvdfHjYqnuNyEPhj1+QWMKcg7VwUVbkiuSSl7zHEk26K6KzWnCsjyXxDg4K6ReqirFvrtqE=
X-Received: by 2002:a05:600c:1da1:b0:426:6e95:6ea7 with SMTP id
 5b1f17b1804b1-428fd681a04mr51455e9.0.1722880252964; Mon, 05 Aug 2024 10:50:52
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <877ccx7igo.ffs@tglx>
In-Reply-To: <877ccx7igo.ffs@tglx>
From: John Stultz <jstultz@google.com>
Date: Mon, 5 Aug 2024 10:50:40 -0700
Message-ID: <CANDhNCpej847tOsbnDFBLV6GLdPGDoM5JJ7d1-UYed+2AEarVQ@mail.gmail.com>
Subject: Re: [PATCH] timekeeping: Fix bogus clock_was_set() invocation in do_adjtimex()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 8:07=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> The addition of the bases argument to clock_was_set() fixed up all call
> sites correctly except for do_adjtimex(). This uses CLOCK_REALTIME
> instead of CLOCK_SET_WALL as argument. CLOCK_REALTIME is 0.
>
> As a result the effect of that clock_was_set() notification is incomplete
> and might result in timers expiring late because the hrtimer code does
> not re-evaluate the affected clock bases.
>
> Use CLOCK_SET_WALL instead of CLOCK_REALTIME to tell the hrtimers code
> which clock bases need to be re-evaluated.

Acked-by: John Stultz <jstultz@google.com>

My only thought here is maybe renaming CLOCK_SET_WALL and
CLOCK_SET_BOOT to something like:
  BASEMASK_WALL_CLOCK_SET and BASEMASK_BOOT_CLOCK_SET

Just to avoid future naming mixups or confusion with clockids?

thanks
-john

