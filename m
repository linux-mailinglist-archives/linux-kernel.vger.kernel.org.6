Return-Path: <linux-kernel+bounces-349093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B13198F0B2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD7C1F21AA6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD6D19CC23;
	Thu,  3 Oct 2024 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5VW5QUd"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8003719C566
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963100; cv=none; b=SHjNJFIhtRjsttfnsJVe49blS/lKtcwRp1RLO4qC+cDSIxms+N+3my8IkRGGXr8xNOrbP1S1BnkGWyBQWZCHQoADkbkOCEaUTCQ1zYgn4XmASciatGIqN6Y5oGacfodhGYf4V6q5JrX1yRjz+SUYioGxfge/XebVFceoKqW+Nhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963100; c=relaxed/simple;
	bh=nhyVS9b4SbGqRALtLaX4iPiyHwuqlg8OQLC5pgDZt3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRnd/L4SNDjHxvc45yqECXza6O5ERJFCfbcin6Mc1C21roOs7+A4br244TYgWsmc2c9bh9XcDXR8ILAH5/hYLsOfZVQf+UolsS14/Fjhr4IVmQJf9BPj30PvY3Ff1E7mCv0N16B89PLR0rWaeiIUjbNVIJ66OnSCpw9eXDZMU+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5VW5QUd; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fabfc06c26so9909121fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727963095; x=1728567895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkhSm9or3Ix+rgdrErnrddrJRV7bOWPOueBTaiThJFg=;
        b=h5VW5QUdCqj7gNZrArST/pdDNVXK35Ca93XRXprgsMoC7icdlLEYb6L27c1LAQNH/F
         EHqIRiAaLpeJyajoaVc6+DOkV9qnKtboFxgRGaOde3WTx4bR4T0HuBKNpwlCOX7nMICf
         l9RFXGZuPFVTDvmikFC3+AXl+epwAQTpnh64lpl+vslfyZqdzA1xYhn4a0mcHahpd44R
         bUu53XN0hvKYHt1GlCkBd0PH2cOddx2DgF3XrZ63jnzmctnaV+qVQ9OKfZ939I+RUM3C
         CVq7lCymBZ6XYnAIIo7USahm3k/7SOHAD2TjLtlOyepO5fDDvqz7Ot1MagA9EDJVLbgK
         BAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727963095; x=1728567895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkhSm9or3Ix+rgdrErnrddrJRV7bOWPOueBTaiThJFg=;
        b=vb8c9rcHJcbU5CLb+sCNXN/DW/95mHkclpXgyol77VP7v4grcJjzn7DE+C2f53SWLI
         sBCDU9CmRHaS6IsVJHrMnOkeM8rOiwAAk1+6pemX8+kUOh6Sv/KUXKgT5Mp34UwjjyjQ
         CqFgSkQX/ZHLtF/x/pa67qfjZrHRjfFbqj40i5K2zuzr7o8VpbkFrvavEbgi4ZlPBBgz
         7XdyaqmNlGuPW+UpVO7UBGMACKBJXhT3T93LMbZfODhIk61moK5evRozw1qhLuhtzeD4
         Q7z4dqjo1WTe96HUi48kpbT0j4NCfkkKsLckKVi4LzkV3F5aKKRWcixs0lcncTNbrSeL
         M15w==
X-Forwarded-Encrypted: i=1; AJvYcCU0qwlANUXkMLQ5OQS7eW5F7l0GVF06dIfqCaYgOiDt6Wlr/hd8E3tpyGf/yPdDhJCAuHglQTfzpOqKPhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLfGCtnDv8PzqBPGe4O4xj6oRG+3HKjw1ipaJATrW2mmj4a7/y
	S2OAPezcrugurtwTQfWo/c+JHYcdW2HLVOnVr47QwhfCF1mI8PRqrmJatTN/yKZfgirHsLzeCAh
	xrpMz47FqxPKVvx9r0Z5dzCYKHvE=
X-Google-Smtp-Source: AGHT+IG5ypBZi/ZZaMWfY3MOJ3mSHN9+V6BldBB2p4wx48AL1aR5zVsGj7GtfDvxP1C6TapWmQIa9MDOm2wpOgcIo1Q=
X-Received: by 2002:a05:651c:19a3:b0:2fa:d9db:7bac with SMTP id
 38308e7fff4ca-2fae1024d32mr43349761fa.3.1727963095212; Thu, 03 Oct 2024
 06:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003121921.922394-1-ubizjak@gmail.com> <390874e9-eddd-494d-9bc0-62b34a9bb29b@igalia.com>
In-Reply-To: <390874e9-eddd-494d-9bc0-62b34a9bb29b@igalia.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 3 Oct 2024 15:44:43 +0200
Message-ID: <CAFULd4ZxrkbmUbzD52_HQJcounWQNsDkC0vHCKjSvMrBh0wmPw@mail.gmail.com>
Subject: Re: [PATCH] futex: Improve get_inode_sequence_number()
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 3:29=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@igal=
ia.com> wrote:
>
> Hi Uros,
>
> Em 03/10/2024 09:18, Uros Bizjak escreveu:
> > Rewrite FOR loop to a DO-WHILE loop where returns are moved out of
> > the loop. Use atomic64_inc_return() instead of atomic64_add_return().
> >
> > Use !atomic64_try_cmpxchg_relaxed(*ptr, &old, new) instead of
> > atomic64_cmpxchg_relaxed (*ptr, old, new) !=3D old.  x86 CMPXCHG
> > instruction returns success in ZF flag, so this change saves
> > a compare after CMPXCHG..
> >
> > Note that due to early return, "old" equals to 0 before
> > atomic64_cmpxchg_relaxed(), so initialization of variable to 0
> > is not needed.
> >
>
> Despite the implicitly `old =3D 0`, I think it makes people life easier t=
o
> know explicitly that `old =3D 0` in the cmpxchg() call.

No problem; in this place the compiler is smart enough that explicit
initialization doesn't make a difference.

> Also, please state in the commit message the motivation of doing this
> change. Is to make the code simpler or to try to save some instructions?

I tried to modernize the usage of cmpxchg with try_cmpxchg, but then I
noticed the opportunity to make the code simpler (please see the
"continue" in the for loop that creates some kind of degenerated for
loop). So, the motivation is to simplify and modernize the code.

> The compiler might be already saving such instructions for us :)

That would be nice, but unfortunately, the case of cmpxchg() vs.
try_cmpxchg() is too hard for the compiler to optimize.

I will prepare a v2 that incorporates all your suggestions.

Thanks,
Uros.

