Return-Path: <linux-kernel+bounces-524955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4D0A3E91C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E1C3B4F02
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90141AD24;
	Fri, 21 Feb 2025 00:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tJhRzla2"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1EA5661
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740096999; cv=none; b=dFNn1FvKXP/XYeZhc7837phvzy5rPp/XMCLLogEH8HWiXcwhlDmI2xAiRkyqWdHZUu8cBLWsF4ryD4PBdwMgm9TTOHr2I/IhOZs6phcQ34mUyQFXEmD/cjFjR4HpjClb/xvM7NPEenokmAhPIPeirPToSubf+bFuM3tgTUO6jec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740096999; c=relaxed/simple;
	bh=5+JG17y1no+XiXasWAV4LNR09aAS3RPd/O1cju1aFmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cZrSnhzJMXftCGvD4Ifuy5HqI8l2jOpmEfofKbrRbD1w8IFhWUk/LvG+s9pvz8TlKMwWuL6eglzRZl22KnuTLo2p0q+7eyFpGb8iBOXs1sRXC/xHmG4VeJEWXuarqEoOBS62ATJJ7RRwnNXoWPzxpmZcc7ea4dWhJhtFg5wAkhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tJhRzla2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fc1843495eso2367590a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740096997; x=1740701797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gOXx46W220E6FZEq/MsCwDe+Yct3ZgJbNWYU+dT6cGI=;
        b=tJhRzla2blHL+NHDdKaLzNy30ya+1ihUk+F8um/vEmP8mt8SbpmfKUw8ej+bGgH7Vi
         gN21PVLbWNVmNdVf6104bvcguGYHEGqdQ9MKqZpkr1Y2iMoybGHJcO3O2qPYJ9nMd9ug
         N6jZ9HxvgL7u3MQh39EJxOVeHmvpr4Q6fUFkwhg56LcOwBzESl163obUcH0BI9sNzmkE
         ZUy6tqiYmpZyeERCK5458tLNFtoS6fwM93+FY056P05B7JmLP7M+IfXn6+vjPNXtIrS9
         i32YqnYVI2HKu++4n+mFkOKok6atsaEoAmzrOj0xkol9IT0ymUNbICDZ5byO6gYjxSFn
         GFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740096997; x=1740701797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOXx46W220E6FZEq/MsCwDe+Yct3ZgJbNWYU+dT6cGI=;
        b=nwonnB+ckKYPyNMujnwUTGrsSFL5zV97O+OM1wkJnOphLpuIVEB/qU4t53YXdftN5n
         +B8u+trJt0O/S8WQ5AihENhUknyzZsw6Oj4gt4ctr7UppO+C9D8TDTobj5g0G7UxCOmE
         OUgOhMrgnwZ7Jt6RWmE4m7pfvSIo8gPFsozw1PksgWKGOxRRMuv62vqu2RkEQYVogKK2
         CAH5I5jGuAltGSz6TuGztdPnpqDvYdc9EU7/oqWjrjnE60lJWtVtkoQRo1gxkysiRBQt
         n6WbKF6tv8NfyGhcd9Plry5FONQ80mK21nwRKCQ4r4cty3uE6g9V1yctC9Z14kI3VQWn
         AfLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRuJTiTVQT93pAkA6/jXE42lbZ9STGQYErWmQTSILefayww6R8/e2DORcovUiRQL9mXvnY8UbDRmb2rOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/7inIQBywbpLj9N/5M5Zrr7K/AusLUO8E3iy+z46Ifr6HPpnv
	GlHCX44q/vE3XtWSDwUJu1D1P/YD/D4zMUgNlaaM9/xUKa7z0MmcUYXI14gGcn6NsKpLjy8csKy
	VFApthS3G5fDaoXBG99JTSNd1fAFSNNh87HLP
X-Gm-Gg: ASbGncsUmn3wrwtBpuinaBueuVLxczzpadi1F5qaau7ZE2dBouWGsjPk8aEs0epJGWE
	ob4uLI1C0fOAFiF5VkM3l5mX3MUutQkeryEGFTjBACavi6zGMJQ4He7zeaaDo1tXukwCIndXl4M
	E31vRm0ZPMqrAJAoffRzGz9/83m/vO
X-Google-Smtp-Source: AGHT+IH300h5TwdZHkn4p/NdY4bFW5MIH3asYrmMXGsx9gCRIlN5VXz6gX2AUHtetV2+tubgqlPwXCwB1TZRnMvVO/A=
X-Received: by 2002:a17:90b:1d83:b0:2fc:3264:3666 with SMTP id
 98e67ed59e1d1-2fce7b221c3mr1828235a91.30.1740096996554; Thu, 20 Feb 2025
 16:16:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206181711.1902989-1-elver@google.com> <20250206181711.1902989-16-elver@google.com>
 <a1483cb1-13a5-4d6e-87b0-fda5f66b0817@paulmck-laptop> <CANpmjNOPiZ=h69V207AfcvWOB=Q+6QWzBKoKk1qTPVdfKsDQDw@mail.gmail.com>
 <3f255ebb-80ca-4073-9d15-fa814d0d7528@paulmck-laptop>
In-Reply-To: <3f255ebb-80ca-4073-9d15-fa814d0d7528@paulmck-laptop>
From: Marco Elver <elver@google.com>
Date: Fri, 21 Feb 2025 01:16:00 +0100
X-Gm-Features: AWEUYZmivm5bHZ6EpPSxW_3r18VidjaU61lIM_KUqGThNf6OIvndggmyl3l59og
Message-ID: <CANpmjNNHTg+uLOe-LaT-5OFP+bHaNxnKUskXqVricTbAppm-Dw@mail.gmail.com>
Subject: Re: [PATCH RFC 15/24] rcu: Support Clang's capability analysis
To: paulmck@kernel.org
Cc: Alexander Potapenko <glider@google.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 23:36, Paul E. McKenney <paulmck@kernel.org> wrote:
[...]
> Suppose that one function walks an RCU-protected list, calling some
> function from some other subsystem on each element.  Suppose that each
> element has another RCU protected list.
>
> It would be good if the two subsystems could just choose their desired
> flavor of RCU reader, without having to know about each other.

That's what I figured might be the case - thanks for clarifying.

> > Another problem was that if we want to indicate that "RCU" read lock
> > is held, then we should just be able to write
> > "__must_hold_shared(RCU)", and it shouldn't matter if rcu_read_lock()
> > or rcu_read_lock_bh() was used. Previously each of them acquired their
> > own capability "RCU" and "RCU_BH" respectively. But rather, we're
> > dealing with one acquiring a superset of the other, and expressing
> > that is also what I attempted to solve.
> > Let me rethink this...
>
> Would it work to have just one sort of RCU reader, relying on a separate
> BH-disable capability for the additional semantics of rcu_read_lock_bh()?

That's what I've tried with this patch (rcu_read_lock_bh() also
acquires "RCU", on top of "RCU_BH"). I need to add a re-entrancy test,
and make sure it doesn't complain about that. At a later stage we
might also want to add more general "BH" and "IRQ" capabilities to
denote they're disabled when held, but that'd overcomplicate the first
version of this series.

Thanks,
-- Marco

