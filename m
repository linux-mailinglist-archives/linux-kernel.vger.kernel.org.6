Return-Path: <linux-kernel+bounces-448937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C31749F4765
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73D716E688
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72831E260A;
	Tue, 17 Dec 2024 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noWqvvFz"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A29018FDAF
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734427266; cv=none; b=bmGp08N/3YhJJOPEM4+dOluUUXtxv5xn3QJ126/fQbctTdDzryfnrRlKyLdkHj7mJVVll0GLueWYmje2NMA2TIX6OVzROd/R8L8mikqHXsfHHryif8vB10S4V60arEqbo7wC7u+3D3BxP80xZ2FjIdgeMcSQeIwACry8f337RdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734427266; c=relaxed/simple;
	bh=t95rHfBoG712lhVuvEOKjrG0vkTo2OZG+gOOLtuNzC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDsxYtyN8uYKLzWShejxWpg4oByeao/Kd4biASwAUbtcItK0Vp6rGEQRTWn73aeqbebxMC7Z/QhkN+F1flw5fsyOZ+WU82xYopIFq1Hg/wbPSsNEuG3xNEzquOOp306aS0RJDuHCFre7XZo0URtgCmY1+gSQGk1gDcxp4xDfqF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=noWqvvFz; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so8314048a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734427262; x=1735032062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkfQWZ2A+B+M90RMveSSOud4hRqEbLnpul/TBC9hJ84=;
        b=noWqvvFzakFO1+dHbGcILEtHcGn/1ru3IQ04FU/Z85ehApRyx1ZTS313P/4O9Ts25Y
         VZuei4R12UUxww1iw32mOPh6urYSCugMDeR18iGE2pBUW7Lvi074e8nDap0VH16jVn27
         6uPLQoAB1sr5wG/vOF0r+XGpphRHfvp/amFyCxuPZBdz4jNxoQwsIrOKtAnDJjs1sU5n
         cWRAw67lxxOqzuV3bHHuaZxsDIfp1lhW8ue3YOgVIZVYDyo1HSxfcYT+okJIRoXH1yv4
         1yoBPd0pbeizMsaJCdAY31w+YWCbvepUdm1k3iOXNQ2M/pTxdUsPbhUJpp7IM3Zym9YX
         AjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734427262; x=1735032062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkfQWZ2A+B+M90RMveSSOud4hRqEbLnpul/TBC9hJ84=;
        b=NYFEt2gEmG3v0xABm7CAfDGyd++izVAIc8QPLr4U/+UyUEWZZzn+xUL77USLoC7qWq
         Y3bpwnWt/LG85ySJnuSykZhvvUe2UuNKikKOCHveIO5AjYwMpCWwJtNYwRJwbwbC4Rcs
         TIBAIJULM1b4Y0uy0q/Sf3Ixc1ojULUQolgiq+STiClNEbMCLOAe1/g6/0eJjVtNuyNI
         alrMiczvVXA016iL73hbLn6VEgvDJ73WDcPUiJf2gINLjx25WOjPT81Ohh7KCazLCELe
         dfp8/09/XPALZ5VhJse/oJrMhbasvQyckxMLuL16RCXxFRUF3lgIQxHcyDUvEEyz37yv
         CcDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ31MmKH1tz+H5Trx1uwvibuU4V+wzeMwaLTrHcG159jyuc5htUxBrnrAzY9NpDQQkdYNsDhVNF43bBVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjUw/qWcftLd4GSR1GNqTv//4uG05IIDaLlDB/pKyrNTURI3mX
	RS9pLy0ydlY6XHbhJ316XBvqEpmabIH/y8jRtYL9dOrsBw8l6+mMDTzM2iQIufjInTeAkpkugzR
	Xp3UVXTKTW4LCLpefRAVb+axQMrS4VZhOKEGS
X-Gm-Gg: ASbGncuZQNqvRqdvqmWJly4MDWzUmwrHTYnGBPW2jmwEL0Qv5BX0f9BJ3BoW5Z46Z7B
	/ilDfolx16y6HcV668yPokTmjGqhkdHZB40saRnatQHwZv8QrLOx2iWbARJ9mBN3vW2Z7BTE6
X-Google-Smtp-Source: AGHT+IF/CdW9ViljvnRf0V0yJni5gZ2km+ucDcJFxsY9gWlL/D2lMY97rfUXFt7mMAncy9aoOyyLlBOnGFKJdekZQ5o=
X-Received: by 2002:a05:6402:5242:b0:5d0:f904:c23d with SMTP id
 4fb4d7f45d1cf-5d63c3c16femr13921679a12.28.1734427262393; Tue, 17 Dec 2024
 01:21:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d416a14ec38c7ba463341b83a7a9ec6ccc435246.1734419614.git.christophe.leroy@csgroup.eu>
 <CANn89iK1+oLktXjHXs0U3Wo4zRZEqimoSgfPVzGGycH7R_HxnA@mail.gmail.com> <49a43774-bf97-4b20-8382-4fb921f34c66@csgroup.eu>
In-Reply-To: <49a43774-bf97-4b20-8382-4fb921f34c66@csgroup.eu>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Dec 2024 10:20:51 +0100
Message-ID: <CANn89iLKPx+=gHaM_V77iwUwzqQe_zyUc0Dm1KkPo3GuE40SRw@mail.gmail.com>
Subject: Re: [PATCH net] net: sysfs: Fix deadlock situation in sysfs accesses
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	TRINH THAI Florent <florent.trinh-thai@cs-soprasteria.com>, 
	CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 9:59=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 17/12/2024 =C3=A0 09:16, Eric Dumazet a =C3=A9crit :
> > On Tue, Dec 17, 2024 at 8:18=E2=80=AFAM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >>
> >> The following problem is encountered on kernel built with
> >> CONFIG_PREEMPT. An snmp daemon running with normal priority is
> >> regularly calling ioctl(SIOCGMIIPHY). Another process running with
> >> SCHED_FIFO policy is regularly reading /sys/class/net/eth0/carrier.
> >>
> >> After some random time, the snmp daemon gets preempted while holding
> >> the RTNL mutex then the high priority process is busy looping into
> >> carrier_show which bails out early due to a non-successfull
> >> rtnl_trylock() which implies restart_syscall(). Because the snmp
> >> daemon has a lower priority, it never gets the chances to release
> >> the RTNL mutex and the high-priority task continues to loop forever.
> >>
> >> Replace the trylock by lock_interruptible. This will increase the
> >> priority of the task holding the lock so that it can release it and
> >> allow the reader of /sys/class/net/eth0/carrier to actually perform
> >> its read.
> >>
>
> ...
>
> >>
> >> Fixes: 336ca57c3b4e ("net-sysfs: Use rtnl_trylock in sysfs methods.")
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> ---
> >
> > At a first glance, this might resurface the deadlock issue Eric W. Bied=
erman
> > was trying to fix in 336ca57c3b4e ("net-sysfs: Use rtnl_trylock in
> > sysfs methods.")
>
> Are you talking about the deadlock fixed (incompletely) by 5a5990d3090b
> ("net: Avoid race between network down and sysfs"), or the complement
> provided by 336ca57c3b4e ?
>
> My understanding is that mutex_lock() will return EINTR only if a signal
> is pending so there is no need to set signal_pending like it was when
> using mutex_trylock() which does nothing when the mutex is already locked=
.
>
> And an EINTR return is expected and documented for a read() or a
> write(), I can't see why we want ERESTARTNOINTR instead of ERSTARTSYS.
> Isn't it the responsibility of the user app to call again read or write
> if it has decided to not install the necessary sigaction for an
> automatic restart ?
>
> Do you think I should instead use rtnl_lock_killable() and return
> ERESTARTNOINTR in case of failure ? In that case, is it still possible
> to interrupt a blocked 'cat /sys/class/net/eth0/carrier' which CTRL+C ?

Issue is when no signal is pending, we have a typical deadlock situation :

One process A is :

Holding sysfs lock, then attempts to grab rtnl.

Another one (B) is :

Holding rtnl, then attempts to grab sysfs lock.

Using rtnl_lock_interruptible()  in A will still block A and B, until
a CTRL+C is sent by another thread.

