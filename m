Return-Path: <linux-kernel+bounces-522355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 736E9A3C909
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B31217810F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE69221C9E5;
	Wed, 19 Feb 2025 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wuJVi0Zo"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79937249F9
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739994403; cv=none; b=pVO1ldkSXnfrzGfi9dcdw+pytliGoMsgvRi+QdxAzYrCg2ImenZ4SzOzKEeCoA+4FNfwqXQdLcpuzeHsGxxObEL0T1cnBmidXHXJg4SvTfJvJYDwsS9RTfPYrP999T30ViSmeY3SwMnNbAMQ1kMEXbpcBbG2C/DU9iFphLfZZ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739994403; c=relaxed/simple;
	bh=9f9gAWvoDC9b9XU6tkT2l01eqQ60dVKAYDxlJhxwrEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZbVMuusZDd/RxWVHTBQ5k6ralNvaB9zzISNUtAz0uqz/Q10YXxwTtGdDlCsaTxsxHyxiAUWwKLs7QTM3CF9r+6Ct70vJop+yWrsTjOubZHcKfmP3VrMzihVAyE3NcyJRH8mhcZK8icg3PD9IdPOSOnbIzSBYqrtotWu53f5Yo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wuJVi0Zo; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5df07041c24so160037a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739994400; x=1740599200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9f9gAWvoDC9b9XU6tkT2l01eqQ60dVKAYDxlJhxwrEU=;
        b=wuJVi0ZoN6Ium6WzTyrY794BniGdAd86GYGy6BhcP6pM90rMtoaAUP5N+suInrBtAo
         ZvzrrPoXJoVJDT3S83LR6kY3bzjkknlhUYGvKmTQZLaXEqWo3MftmONKeiRB1bITK7RQ
         FoMI2rvs50WKAQQakiJ6PcjmjatnAUf3QKTrYYJCygVdfRsbx3/9pEA439Hpj1oDrZxy
         oxxXUZUDT2H/zfDzQdd2X4c+tCbqBUzX2uOMc7k1h0ZLf7zAPwcPLMd0HDYja9StnZd4
         Yeij2KPjiT8roi32hfFDuajKWKcPf/sZy6Km4oL7wtfGL6lDb5CbiWnEj9IKAzY0yC+I
         0vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739994400; x=1740599200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9f9gAWvoDC9b9XU6tkT2l01eqQ60dVKAYDxlJhxwrEU=;
        b=mUi9qApY0m7XDX643RwoPiGtOOgBUTynyU5i/J+VBUSRSKw8O7+lcaLk3XaWP6mOLq
         LioGHtr93OBSIkxbsRNd85zLXKvBJx3fltIpcKMsrCv7DC90IkKGuD5AsrHixRdUcJoC
         xu2+eDGFdv7xnlrxJQiPBA1x/M897NW3x7FU72B8iNjVeT5umsQVY2GVZbYn41A0c1fa
         1tULSzll/Zbe0c3pxeoJIV10SpzfidQHGtDpOKyD2NitbdeD8ozmP185OlRsAGenMxky
         rXV5PkYVckEe5dNNKFJZ5BAEzWq54JymBnCTgEnCZX7kra10aKR9z3EmSHAO+a5kDxdD
         bF7A==
X-Forwarded-Encrypted: i=1; AJvYcCWfV/wsMEISRC4H/8Lf+9Dk6EqNB/1suWfFTLz3k2HscF/SmEhKSLI7Bf9lYYbg0Q27n4tEaBsyXqI7F3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiaqb/2LM6vgrx8PByS3bMYxv0spSpSfrWncGZpT9DEZ/RppVM
	DEPFppk7lrfBc1m+ScmiHRhOE/dP80oSL3XqDCOX3kJuVEO0yJ/a8cUHeUWOD59uOvHHkl6ooQT
	eiUNrGId1HwORp77RV6PhrjDt0TVt9ZMQErcp
X-Gm-Gg: ASbGncvgHYf/3Epveh7v3PUVh9TZQPC1NOSavikktSxLwB7goGewB3MbcDUTyO0nhuB
	kW/luY78X8Lia6TIWj3tL7GAdcoLGOzFqVTxq9ICO92wQQpYnfhfEnrcu86hDxZfRJCAv4MYavg
	==
X-Google-Smtp-Source: AGHT+IFTToWNtb9+soBp3+BZN5PquDKOz71JOHNOup4nG3AT5qok8CLavY1jgCAEdBdhoN4tUFlczu2S8Gf4h91J/Qc=
X-Received: by 2002:a05:6402:348b:b0:5e0:8064:b42e with SMTP id
 4fb4d7f45d1cf-5e08064b595mr6241794a12.25.1739994399175; Wed, 19 Feb 2025
 11:46:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219125522.2535263-1-edumazet@google.com> <20250219125522.2535263-5-edumazet@google.com>
 <20250219193832.6c3fa40f@pumpkin>
In-Reply-To: <20250219193832.6c3fa40f@pumpkin>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Feb 2025 20:46:27 +0100
X-Gm-Features: AWEUYZkGz0X_CP5IZaW_ZvtMQw5lpMlhzeud51Gxi96-OKXt8Id1wEnrrCw4rY4
Message-ID: <CANn89iJH1RGKxwBDGLjY8XowSXwuoAwSO2NXtcJxUMgvyEBn6w@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] posix-timers: Use RCU in posix_timer_add()
To: David Laight <david.laight.linux@gmail.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Benjamin Segall <bsegall@google.com>, Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 8:38=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 19 Feb 2025 12:55:22 +0000
> Eric Dumazet <edumazet@google.com> wrote:
>
> > If many posix timers are hashed in posix_timers_hashtable,
> > hash_lock can be held for long durations.
> >
> > This can be really bad in some cases as Thomas
> > explained in https://lore.kernel.org/all/87ednpyyeo.ffs@tglx/
> >
> > We can perform all searches under RCU, then acquire
> > the lock only when there is a good chance to need it,
> > and after cpu caches were populated.
> >
> > Also add a cond_resched() in the possible long loop.
>
> Since this code fragment has a 'free choice' of the timer id, why not
> select an empty table slot and then pick a value that maps to it?
>
> You can run a free-list through the empty table slots so the allocate
> is (almost always) fixed cost and trivial.
> The only complexity arises when the table is full and needs to be
> reallocated twice as large.
>
> The high bits of the 'id' can be incremented every time the id is allocat=
ed
> so stale ids can be detected (until a quite large number of allocate/free=
).

We have to understand the RCU lookup can only fail after 2^31 timer
allocations for a given processus,
I am not sure why we would bother.

CRIU wants predictable timer_id sequences.

We have to try N, N+1, N+2 ... until we find a suitable id.

Alternative would be to add a new system call I guess.

