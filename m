Return-Path: <linux-kernel+bounces-446282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B104C9F2226
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351111886DEE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 04:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79DDBE46;
	Sun, 15 Dec 2024 04:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VuSBGmaj"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CEF1FDD
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 04:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734235933; cv=none; b=AT9ZAUn2ckC0re7QPPzaAXjEU2FHD1rTmIsRIzs/rCi1roiLkvwd+ZBsQx2tpKG6ivUZlYfEufmaKuqS8hf6wbnVhJxWFSJe6RT7mZ846qk6WQJo0PT06vYb1ZIhkq7wFqM29wwG+2zs11mvwUIXaO3YRge90+J8EVtvT/QV3kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734235933; c=relaxed/simple;
	bh=Ml66fngZ/Ii90qEbY8Ic3yR13fSVyotKChJ01wQVmnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esUNPhyBUrS4lybjVojLumoJyOh6qeyk0EkVk1MG7+BiCnGDq4sKtFpxqDdrz/nOH+1CuZMs4wIug8pM4DK7qFcU94cPMLQyV3Va5I77oONnHwAXx5dBy9CB24y4t7oZLErM94GErnMY8grJb5XIjUVVDe27K9luqx408gZ933g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VuSBGmaj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa67f31a858so559826366b.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 20:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734235929; x=1734840729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0u+PGplY6kNcEdvH0mg1zZZuMNp6NaM5HQJJMrcW6yY=;
        b=VuSBGmajulwgfh5fGwHUXlzEQ5PUFw1cGXNUQrCjHD7aKVEAvhKCxYLfFCakRyQ2ia
         EZ06/Oob78IaR8h8wDf1i4lFJiF1DqsL0NUf8rap3v62hd4pwNrHnY8TpxAXooSPBYEH
         S2Ow4PjHeqp54ZP2E1UfmjStxKpae6vQkRZ+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734235929; x=1734840729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0u+PGplY6kNcEdvH0mg1zZZuMNp6NaM5HQJJMrcW6yY=;
        b=lHY9GjPreRUIeFAStkg80Bx4jUes2lAZUBTR9tXqrdqALvM0WC+7ojbMCPW+RJDhwz
         8aZx0j7ic5K7ihLZElU4nVmec6GPAxt2NlIJWa2HtHBTvXNgzQxXf4rI4JIR3NcZZBwF
         qjWsMwg6zFWE4FHm3TsNk4sCzoVhr4xHA4fHtMIZhZbAw162Rz00XFTMtWxPP67E+CNa
         7T4WewjwLg8Rj9G3wqmzVe87T8jSBeZPHzTuFz+muIjwbHurSJ9hmETsub6vAY2N3eA3
         CCU6TGt4I2KqqlwERN20TAIxNk29C8B36qY1d6W29BkDSjGoeERnP4+mfXHkPsSlnK+N
         NfeQ==
X-Gm-Message-State: AOJu0YxzZVYH5Nvq6sFL39d2Ie3NsqzApTqGV/UElnQVtARo0Ew4O3rB
	QvAsdetxWTLWFOTdQq4g7KkgVg6Idymcs/Hd/XiQGtvljsG44fKcdhXXiIAxWzxoiEptF4aEGoS
	6R4U=
X-Gm-Gg: ASbGncsPeh9an+znWCH/hFo8K9e2sTwZtZRh4kBmLu5oGyi2xZgsftrNfDJ48ZC3iqe
	RIqrJgSJm+6+scPWpBwesxLkMPQMfMw0andEm3X3192Ou3UWyRtPQAFAEG8SAbRa7biMJxMfoGu
	p4QH/48mrjGWrFVZ5vZsPKgQeIdsm5+Mc2WmN3eG860uRWbOP2NF/7n19KgRGi7GDCMEq9IPlo/
	aKovGKtVdCD0Rd2nje9zuY8T9unFEYYHpN6NCo32XYg7+dsvrT5H8RJfJvrKPYLkkqOUs0EcD8J
	UqvM9PUjQgQIx6RhkOTvxLKhV1woQ6g=
X-Google-Smtp-Source: AGHT+IGaRHVnFzQpyJpfQs9DKDwTCoQrN69t3Bq8HDgquN4DlJMsqiF89AYdQM40GFxV9UhZvRLSMw==
X-Received: by 2002:a17:906:3152:b0:aa6:8160:8495 with SMTP id a640c23a62f3a-aab77e9705emr710436266b.42.1734235929254;
        Sat, 14 Dec 2024 20:12:09 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9606897dsm163672866b.46.2024.12.14.20.12.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 20:12:07 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so5033374a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 20:12:06 -0800 (PST)
X-Received: by 2002:a17:907:a088:b0:aa6:87e8:1cff with SMTP id
 a640c23a62f3a-aab7797f9c0mr709886366b.24.1734235926700; Sat, 14 Dec 2024
 20:12:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214182138.4e7984a2@batman.local.home> <CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
 <20241214220403.03a8f5d0@gandalf.local.home> <20241214221212.38cc22c3@gandalf.local.home>
 <CAHk-=wiSdtNvq_wUtq7f3oO7S7BYCeXh7a707HKvK9nVkxR=jQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiSdtNvq_wUtq7f3oO7S7BYCeXh7a707HKvK9nVkxR=jQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Dec 2024 20:11:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh3cUC2a=yJv42HTjDLCp6VM+GTky+q65vV_Q33BeoxAg@mail.gmail.com>
Message-ID: <CAHk-=wh3cUC2a=yJv42HTjDLCp6VM+GTky+q65vV_Q33BeoxAg@mail.gmail.com>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Dec 2024 at 20:06, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And I think test_event_printk() could probably be expanded to handle
> at least some cases of '%s' (because, as you say, pointers to various
> static allocations are fine for it).

.. and I think we can at least protect against kernel faults in the
generic '%s' handling. We already do some of that in
check_pointer_msg, and it could be expanded upon with something like

  --- a/lib/vsprintf.c
  +++ b/lib/vsprintf.c
  @@ -695,13 +695,22 @@ static char *error_string(char *buf, ...
    */
   static const char *check_pointer_msg(const void *ptr)
   {
  +       unsigned char val;
  +
          if (!ptr)
                  return "(null)";

          if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
                  return "(efault)";

  +       pagefault_disable();
  +       __get_kernel_nofault(&val, (const char *)ptr, u8, Efault);
  +       pagefault_enable();
          return NULL;
  +
  +Efault:
  +       pagefault_enable();
  +       return "(bad address)";
   }

which is admittedly

 (a) ENTIRELY UNTESTED
 (b) not exactly pretty
 (c) only handles the first byte of the string

but it's at least very simple and cheap and fits in with the checks we
already do.

No, that vsprintf code wouldn't deal with any tracing-specific sanity
checks that say "the pointer is in the trace ring buffer", but as
mentioned, *that* code is entirely separate from the thing I'm
objecting to anyway.

               Linus

