Return-Path: <linux-kernel+bounces-548395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FFEA54444
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026513AA3AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0851FCF7C;
	Thu,  6 Mar 2025 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F4M+35nL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N7CEoUMz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9511B1FC103
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741248614; cv=none; b=UHn5pqwwU53E3WFOSjl1/7B5CYuwDd3q9k3835NbSho7Gocmiw1d3tY8dtw8DUVhZrH8EBadPiM1TzWbT0TXGDePO09xDhUDBpMP0x+HOay6vDXrrRgNUKFbHHXuzfLWleOqHV8KAGGHj29mY9UZWQ0+XGNkvboaW6CBUhS6HvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741248614; c=relaxed/simple;
	bh=t5i41aTPSu2X8IHa0yeNUP4630Oc/G7SoR3xy5EMZeY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d9re3/fKUkQK747iNctRKxss+KSZLKHatzppoFf5hmHGVOU6yhMd+IX/jHPBtXhzLvLfvY57UWirZvgQnIcvwFatBmcWfWCID4TyrUGjz3xG4vCPucY/HsKSyT1756DgJJl9/p68gTaq3ZuV9Fq2neUVSgTiq6aFF0bhr2A1PqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F4M+35nL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N7CEoUMz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741248610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FCw0HXhg+OcR5bTQZOtf1N65af8vNWr6z4Mmvv6sC1E=;
	b=F4M+35nLES0vVjhJgYIuelEf/gFETU2F75kxQOAJ6lMNZveAjDDzsmoG6n6MDDA1r31HTi
	U/Xk8o7SReTgwH53nBlMc0eJs8Y0sYFSiY0J75Muck08uQgBcw/uprBUa5Bt0XQdrKek5H
	tRygrcK6OVw6ljWRjJYyrwlTCxBMp7zZM41Hz/vkEeG71youZBeXbJcTc4MUFD9jmJSIxz
	TrzdNDgWR3XQZzU9DB4c5U9hqeyn6sj8IEadYDDAuWhe2W6ngYDpO1x7T0qOMloglhR/hy
	P/a4Hm2lB4pxaOdWXkW3NqYi0cwTpvQfzr/GipnU9oA87nLb7awoXM/m50uL6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741248610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FCw0HXhg+OcR5bTQZOtf1N65af8vNWr6z4Mmvv6sC1E=;
	b=N7CEoUMzM5WNwADfgQQiczj2wLr0P6R+TM+V0gH8xxjyxigS+ML9Ovn873rihhIltGTOkc
	7bDJbslqu21scyDQ==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Benjamin Segall <bsegall@google.com>, Eric
 Dumazet <edumazet@google.com>, Andrey Vagin <avagin@openvz.org>, Pavel
 Tikhomirov <ptikhomirov@virtuozzo.com>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [patch V2 01/17] posix-timers: Initialise timer before adding
 it to the hash table
In-Reply-To: <Z8iJBXFQLUkcndsI@localhost.localdomain>
References: <20250302185753.311903554@linutronix.de>
 <20250302193626.974094734@linutronix.de>
 <Z8iJBXFQLUkcndsI@localhost.localdomain>
Date: Thu, 06 Mar 2025 09:10:09 +0100
Message-ID: <875xkm60m6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05 2025 at 18:25, Frederic Weisbecker wrote:
> Le Sun, Mar 02, 2025 at 08:36:44PM +0100, Thomas Gleixner a =C3=A9crit :
> Looking at this more or less lockless whole thing again, is the
> ordering between creation and subsequent operations sufficiently guarante=
ed?
>
>     T0                                                T1
> ---------                                             -----------
> do_timer_create()
>     posix_timer_add()
>         spin_lock(hash_lock)
>         // A
>         timer->it_id =3D ...
>         spin_unlock(hash_lock)
>     // Initialize timer fields
>     // B
>     new_timer->.... =3D ....
>     common_timer_create()
>         // C
>         hrtimer_init()
>     spin_lock(current->sighand)
>     // D
>     WRITE_ONCE(new_timer->it_signal, current->signal)
>     spin_unlock(current->sighand)
>                                                       do_timer_settime()
>                                                           lock_timer()
>                                                               // observes=
 A && D
>                                                               posix_timer=
_by_id()
>                                                               spin_lock_i=
rqsave(&timr->it_lock)
>                                                               // recheck =
ok
>                                                               if (timr->i=
t_signal =3D=3D current->signal)
>                                                                   return =
timr
>                                                               common_time=
r_get()
>                                                                   // fidd=
le with timer fields
>                                                                   // but =
doesn't observe B
>                                                                   // for =
example doesn't observe SIGEV_NONE
>                                                                   sig_non=
e =3D timr->it_sigev_notify =3D=3D SIGEV_NONE;
>                                                                   ...
>                                                                   // does=
n't observe C
>                                                                   // hrti=
mer_init() isn't visible yet
>                                                                   // It m=
ight mess up after the hrtimer_start()
>                                                                   hrtimer=
_start()

Pretty far fetched and I did not think it fully through whether it can
really happen. But that's trivial enough to solve without this
hlist_hashed() indirection:

+      spin_lock(new_timer->lock);
       spin_lock(current->sighand);
       WRITE_ONCE(new_timer->it_signal, current->signal);
       spin_unlock(current->sighand);
+      spin_unlock(new_timer->lock);

Simply because the release of timer::lock guarantees that the memory
operations before the release have been completed before the release
completes.

Consequently the other CPU must observe a consistent set A - D after it
acquired the lock.

No?

Thanks,

        tglx

