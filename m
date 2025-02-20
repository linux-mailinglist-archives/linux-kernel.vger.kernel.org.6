Return-Path: <linux-kernel+bounces-523862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE09A3DC2D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12F831884D48
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01441C3BF1;
	Thu, 20 Feb 2025 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sjg+d2AC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4GxV9z1F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D301C3308
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060621; cv=none; b=iCGGW7XcuCjTxT6VpzsJ2P7IgTzmx6jGcYYIynZBxDdC5OCtbgD54idmqPyFYKylXUF242Z+CjhYS9LsrMNXi0b8BY9v4Wp8tYnNyLVXFwRBAg1cjpYKuZXpUIWrKS9xqFs7XB57R01bP8ZiwcwtIKl0vBx7Fb9xgZDS5HffoVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060621; c=relaxed/simple;
	bh=9dEHr/TTjTJNoBY5JSuRcJDFEQhnKnZ5K5IN9S6bm4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mqfmDa86ckQdl6BrSJJVujpGf7vjwq9yXmqAg94fuzeQMNGISFzFXWL3nJyniciqRh6/6uzH7TPZJT8+tRPkXXrtD2q5tumJEAGY9PTVVNCx70ky9toyolHRjPM2+iLvEB2UXGoQFMs3cSlmVDnCE1PbcnbgMTlnPrBklhgcK/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sjg+d2AC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4GxV9z1F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740060618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GnG4GhnXhamhvoOCZluRg/ApRfd17yIiVA/KBH2t0lk=;
	b=sjg+d2ACbIN4j9tmJj0ozd0bIjbQFlIKLvZ7uPVGxjkKDDcmkLROlME+bAh0YNbgSDByRM
	5Ko2TJ/nNr+KrrjPMN+5Nbw7vn3b0s5fyt4kwVs0YtWoo3a6cNnv4bMmoS7vXiL/GumONh
	ZQneOXfMjgmfNEngdr7Oj4H38iVEKHJgHN7Wsfag/dA0tSFdmE11QCa5/He2QJPLycaly4
	HYKmwVltwkzX/GthIRnsm7k8dwrCcxLB3/oJLlk41nedCq8pydVnVwiPsOCfZ0tqZwZM8s
	60Awo6dgBfKgu9ysgTBYmKllYcmaFnURJs/zxSeleSLTpq4/289yyjN1ZESBtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740060618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GnG4GhnXhamhvoOCZluRg/ApRfd17yIiVA/KBH2t0lk=;
	b=4GxV9z1FxsMg6kP+aRJcssp+YBc3c1PUGiWmW6G74k7JI3ZJwWduJumumH+Vj3l4dbfBnX
	lmrZ2RZkJ4YCGgDQ==
To: Eric Dumazet <edumazet@google.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Benjamin Segall <bsegall@google.com>, Eric Dumazet
 <eric.dumazet@gmail.com>
Subject: Re: [PATCH V2 2/4] posix-timers: Initialise timer->it_id in
 posix_timer_add()
In-Reply-To: <CANn89iKQ2oVX6pzWxN1rEqHfrkDXkxEgcF6MHW-OiyGc2C=ybw@mail.gmail.com>
References: <20250219125522.2535263-1-edumazet@google.com>
 <20250219125522.2535263-3-edumazet@google.com> <87tt8phw61.ffs@tglx>
 <CANn89iKQ2oVX6pzWxN1rEqHfrkDXkxEgcF6MHW-OiyGc2C=ybw@mail.gmail.com>
Date: Thu, 20 Feb 2025 15:10:17 +0100
Message-ID: <87eczsiu5y.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20 2025 at 09:48, Eric Dumazet wrote:
> On Thu, Feb 20, 2025 at 9:12=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> On Wed, Feb 19 2025 at 12:55, Eric Dumazet wrote:
>> > A timer is visible only when both timer->signal and timer->i_id
>> > are set to their final values.
>> >
>> > We can initialize timer->it_id sooner.
>>
>> This changelog tells nothing. What is this fixing, why is it required to
>> initialize this sooner?
>
> Just  to make the series more readable and bisectable.

That's fine. But this changelog does not explain what the patch is about.

>> We can... We also can not ... Aside of that please write changelogs in
>> imperative mood as Documentation asks for.
>
> I do not understand.

What's so hard to understand?

What does "We can initialize timer->it_id sooner" tell me?

Yes, we can initialize it sooner, but what's the point? What's the
problem this is solving?

Also if you can't find the relevant documentation about imperative mood,
let me cite it to you:

 "Describe your changes in imperative mood, e.g. =E2=80=9Cmake xyzzy do fro=
tz=E2=80=9D
  instead of =E2=80=9C[This patch] makes xyzzy do frotz=E2=80=9D or =E2=80=
=9C[I] changed xyzzy to
  do frotz=E2=80=9D, as if you are giving orders to the codebase to change =
its
  behaviour."

> I wrote more than 5000 upstream linux patches, you  are trying to
> educate me in 2025 ?

No. I'm asking you to provide proper change logs which match what's
requested in documentation. I'm asking that from anyone independent of
patch count.

>> >       /*
>> >        * Add the timer to the hash table. The timer is not yet valid
>> > -      * because new_timer::it_signal is still NULL. The timer id is a=
lso
>> > -      * not yet visible to user space.
>>
>> Even with this change the timer ID is not yet visible to user space
>> because it has not yet been copied back ....
>>
> It is seen in concurrent lookups.

But still user space cannot observe it, right?

Thanks,

        tglx

