Return-Path: <linux-kernel+bounces-196064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10DA8D56C2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 02:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3BBC1C2434E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 00:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A44A50;
	Fri, 31 May 2024 00:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GKchJLAj"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A4115C0
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717114281; cv=none; b=aqwao9ZCnknIPeEzJbdL2I+56tRhHxxbX8Z5vzDBLx+vt7hdQxMZ4cRML23S7j+0R1yW5hJJuRxTTHzHmrnDkz8QWAoVajGJkA1eO+2zh1D6I4iwWqKk3ULQRgCA/xXVPM4QtSz9VRXBGeMWGRWFe4aijKj/aBV7H9avoTfTQc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717114281; c=relaxed/simple;
	bh=U0XJns+YNNmeMEASPduEJ9jHIdS9fQwGg1OuH4qRsww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4fupW1Ko8JH9p2DIWdVrxf/zww0b3gpWttfDyDJKu0nxrTNbTPtfLrgeCDZXhouhBbcahEAt/T13YdyCYQxujCaq1YEZnZdgsAp8EClaxS/3d3lUTw7D1cjLTAx/irFnwudXuOzvdughXAE1XKU3Osv0IrT3umsqglNkNjOzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GKchJLAj; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e72224c395so12969681fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 17:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717114277; x=1717719077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YHMYrW+TpQb5zcHr1paZFxtLcsiCfSjdSb93AnO8N4I=;
        b=GKchJLAj9vw4sKbRtxyZEpHnh1q49FIPluJHKYkljzG458HRJ+PkGJDeOuR6mqV3EQ
         BJDmyT0KkZVSpWHNhLVrH/gcJv64pMrezDpnvBm7wpdIyLMsslzJFSy3X71oDFko//Jk
         FbrTakHlClf8E+P5Zf9wUSXVsLaMfNw8Wg86I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717114277; x=1717719077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHMYrW+TpQb5zcHr1paZFxtLcsiCfSjdSb93AnO8N4I=;
        b=M4IBMpAKY85jxiP1XaKXO2/RNsZKkANWu8ANF+2whdaplWAlYeFb5vkurOIB/5NBEh
         IZeKETTHAa0PWxkf6s01xDFkDMl6HMLKLVO2vTUcfpDw1ViBBjrwBYd7/rK19YeykTi9
         CFIoBCYYPtQ9QMS/9XbfqvmJemVcB0hldKoo/f7MUEketvoTIuvna+LTekf+pAj1eE7Q
         JgNRPcSoFmqsuhEy87PpxSPDc7EZcYt772rpOzU/65Lr0Ui3VjIdXaSoAp22UctxXr9X
         NkH4X7Q/OVEfKi0WNrFy0FY4ENnIIo6qXufzTrn1jVXp7S/UNUmwp/wo4pr+cNEQv7G/
         SJNg==
X-Forwarded-Encrypted: i=1; AJvYcCW/aCAZjjx1yyCFsnzzydYzfYXN3HzcwzLJXdZmDg2EKBX7dCniaU0cUsGssgOHjBWynVP6d0wt54eJ2E/D1SoqcIeBNiftIZDVYhqk
X-Gm-Message-State: AOJu0YwBst1zqGJLOZZaNHIyE286tzI+DBHS4N9cAeshPzXS0hdrHvXx
	3H7rxJBSdzi60V4M7nRgmv/mv1bNbT05tW2Z19At6CvDe6Hykzmv1WTxhkeX3pZg1sEmb5pSufW
	56Y3mKA==
X-Google-Smtp-Source: AGHT+IFnCTAQeRpOnbb7BqVVlC91es8j5c3dSDf587TkLXIW+dNx+t0WqCIESOpdl97xxgzaB7B/6Q==
X-Received: by 2002:a2e:be1f:0:b0:2ea:7cc3:fd40 with SMTP id 38308e7fff4ca-2ea951d2403mr2319161fa.45.1717114277348;
        Thu, 30 May 2024 17:11:17 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31bb825esm353571a12.32.2024.05.30.17.11.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 17:11:15 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6858bdc9ddso502766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 17:11:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSGyIMfEFZkT1sXvILkk3tn39dxBmibSY7KLtrCH3Ly3PFv9f1SmIu8tNhvP2tH6jHz2xZQb2pvDGpsTO3S2z3cftB0GMegpRfUNxS
X-Received: by 2002:a17:906:258d:b0:a5c:dcd4:351b with SMTP id
 a640c23a62f3a-a6821982787mr20520766b.58.1717114275493; Thu, 30 May 2024
 17:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503081125.67990-1-arnd@kernel.org> <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de>
 <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk> <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk> <CAHk-=wi7WfDSfunEXmCqDnH+55gumjhDar-KO_=66ziuP33piw@mail.gmail.com>
 <alpine.DEB.2.21.2405302115130.23854@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2405302115130.23854@angie.orcam.me.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 May 2024 17:10:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiH6g+T7+YWSYgAhJ9HsJ2bUUDJfLLo_Yhbi8CVgkHDg@mail.gmail.com>
Message-ID: <CAHk-=whiH6g+T7+YWSYgAhJ9HsJ2bUUDJfLLo_Yhbi8CVgkHDg@mail.gmail.com>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Arnd Bergmann <arnd@kernel.org>, 
	linux-alpha@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
	Michael Cree <mcree@orcon.net.nz>, Frank Scheiner <frank.scheiner@web.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 May 2024 at 15:57, Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> On Wed, 29 May 2024, Linus Torvalds wrote:
> >
> > The 21064 actually did atomicity with an external pin on the bus, the
> > same way people used to do before caches even existed.
>
>  Umm, 8086's LOCK#, anyone?

Well, yes and no.

So yes, exactly like 8086 did before having caches.

But no, not like the alpha contemporary PPro that did have caches. The
PPro already did locked cycles in the caches.

Yes, the PPro still did have an external lock pin (and in fact current
much more modern x86 CPUs do too), but it's only used for locked IO
accesses or possibly cacheline crossing accesses.

So x86 has supported atomic accesses on IO - and it is very very slow,
to this day. So slow, and problematic, in fact, that Intel is only now
trying to remove it (look  up "split lock"

But the 21064 explicitly did not support locking on IO - and unaligned
LL/SC accesses obviously also did not work.

So I really feel the 21064 was broken.

It's probably related to the whole cache coherency being designed to
be external to the built-in caches - or even the Bcache. The caches
basically are write-through, and the weak memory ordering was designed
for allowing this horrible model.

> > In fact, it's worse than "not thread safe". It's not even safe on UP
> > with interrupts, or even signals in user space.
>
>  Ouch, I find it a surprising oversight.

The sad part is that it doesn't seem to have been an oversight. It
really was broken-as-designed.

Basically, the CPU was designed for single-threaded Spec benchmarks
and absolutely nothing else. Classic RISC where you recompile to fix
problems like the atomicity thing - "just use a 32-bit sig_atomic_t
and you're fine")

The original alpha architecture handbook makes a big deal of how
clever the lack of byte and word operations is. I also remember
reading an article by Dick Sites - one of the main designers - talking
a lot about how the lack of byte operations is great, and encourages
vectorizing byte accesses and doing string operations in whole words.

          Linus

