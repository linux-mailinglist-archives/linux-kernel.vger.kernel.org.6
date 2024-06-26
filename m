Return-Path: <linux-kernel+bounces-230305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8B9917B11
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934701F232C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828AD161904;
	Wed, 26 Jun 2024 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FqrN5GCD"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF96144D1D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390967; cv=none; b=UNTV7lH61SiT5KjtlZFdI65c8QOtsAgIfhlka1xjd8GEqVf7mlnRNCZ50vHoOw4H8DmeutG1/PN23eJsWnwRbVxD8ldl9zgcEtWhXmr7NnmBrpHu0SSWtBiMdzMqL32+H+0tWLK6HPXMtGJbjvfFEgGhEtMAXPpPNm7vmXwyP3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390967; c=relaxed/simple;
	bh=wX/3eNlv4pSj8hA264JHx8pY0K5oIemXUUhlMCxrH8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLgsqCqlyicKOaMMKdBZoFl4Sn02UHruoxSBDeZSPkRbjMmLxKQyasaRTE06jAwRhqhojgguD2Fb9svlJaMIm6ak8/f8B9m1VfGNLdFDmcNA9EK8HSxQZx6mer2SLv91hv3zWXYsaKmyzTcLt9fVZfv6A8FLCT2A7arWfqVSgEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FqrN5GCD; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b4ff803ef2so28126776d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719390965; x=1719995765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6fPnNtBvpnTerhI3bBMQd3FP8HRZAvOd3Sy7HCVoG8=;
        b=FqrN5GCDFUnJLVfoHI5w2V+RYBblHthhU6LOy2hMG/+IsVhyke/CDUN7bowul5BYxc
         mI88atRNjqQunvtovIS+RWPHzQVtu4i/PcjQtZOP+hsBK7jCTbdHyx3MdM3JoNx8BV4B
         nt8IIfUoAEsSgq0BggI35xEN8QwlEAT0apE0MBjvk/SvRGKZ8uajKFOwnBFFbqazYa4Y
         up6X9VbOvVTPJOK5s93rjEVv148GeKwDT9FzWomb36tgTJqaRdbfOEqk20ipy2cBswOD
         HCRDBfS9nZmp7QIMlK3rj9NmBHsRxofc22iPBRXuLo9bNiGJ/Brtb8v9Lg12Ala4GqpQ
         Bisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719390965; x=1719995765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6fPnNtBvpnTerhI3bBMQd3FP8HRZAvOd3Sy7HCVoG8=;
        b=IlqERKRDxb4Qa+DAwl8mXw5w+3aMwRCFopip/gpUKn8o1pDmR+JEyQgORvkjzXgKV1
         6ZLuDoctexrTN4Qh0KB83hmqYzYL0Ipg1MZ6PeqY88pqCSK1F9kE+OxAA8DUj+UTf514
         9LkungCEEEOTeghiBUv43NWwBpaxbYp7RG5AZx6VJQq2UpzjFJI1TY+BtYt/wp5+Ipy9
         DbBa7WAneW2lxIOIlDhCwjeOxSEbuX50smcWGT75nQePw3KtkLmKS+LDSco8sB4VHfrH
         38ZkhQpgHrR1zoDIJjaqqgG9Zyijuj6xKgj8aJ9NpDLeDhAS5dbP1GV5LeP0P3QhDsmu
         O3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWHjxwuGXLpzSkIaOBv54g0UT5S7/GbnE9xlcO8+cvmf4zz74/6iDNbEa0cjucH/AKKGI8UXDoCVgv/Y0AylDHMy3oqtQ1gIfnbZmA9
X-Gm-Message-State: AOJu0YzzgXnSXH865C3y3N89wec/kSOURfXbikPzy4QnjfZf9d+VliVV
	qn6BLP4vFRFlWK6gUdTyVI3KUVQIJMbRdDv2NjwuD067i/c7EoNje+0Kd5mhxLYOr7RDCSLOqqx
	2s28q//nW/+qrunNYcv3TTesxJ+OD4qaAUvGe
X-Google-Smtp-Source: AGHT+IEY2qGzs3eefVpH1eqwqrjPitN3YZKD+2oF225ZMXD6dZBX9n7O3a9qk77dlfiaQfv7fi2X6XxAmRNMZPXnh2M=
X-Received: by 2002:a05:6214:29e1:b0:6b4:7910:2b60 with SMTP id
 6a1803df08f44-6b5409a5064mr122854286d6.6.1719390965051; Wed, 26 Jun 2024
 01:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621094901.1360454-1-glider@google.com> <20240621094901.1360454-2-glider@google.com>
 <5a38bded-9723-4811-83b5-14e2312ee75d@intel.com> <ZnsRq7RNLMnZsr6S@boqun-archlinux>
 <3748b5db-6f92-41f8-a86d-ed0e73221028@paulmck-laptop> <Znscgx8ssMlYUF5R@boqun-archlinux>
In-Reply-To: <Znscgx8ssMlYUF5R@boqun-archlinux>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 26 Jun 2024 10:35:25 +0200
Message-ID: <CAG_fn=U699fy+zQtEE2wiTD2meyYe+DWrvk7PV_=T1xW+Md+pw@mail.gmail.com>
Subject: Re: [PATCH 2/3] lib/Kconfig.debug: disable LOCK_DEBUGGING_SUPPORT
 under KMSAN
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Dave Hansen <dave.hansen@intel.com>, elver@google.com, 
	dvyukov@google.com, dave.hansen@linux.intel.com, peterz@infradead.org, 
	akpm@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 9:38=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Tue, Jun 25, 2024 at 12:06:52PM -0700, Paul E. McKenney wrote:
> > On Tue, Jun 25, 2024 at 11:51:23AM -0700, Boqun Feng wrote:
> > > On Fri, Jun 21, 2024 at 09:23:25AM -0700, Dave Hansen wrote:
> > > > On 6/21/24 02:49, Alexander Potapenko wrote:
> > > > >  config LOCK_DEBUGGING_SUPPORT
> > > > >         bool
> > > > > -       depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT &=
& LOCKDEP_SUPPORT
> > > > > +       depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT &=
& LOCKDEP_SUPPORT && !KMSAN
> > > > >         default y
> > > >
> > > > This kinda stinks.  Practically, it'll mean that anyone turning on =
KMSAN
> > > > will accidentally turn off lockdep.  That's really nasty, especiall=
y for
> > > > folks who are turning on debug options left and right to track down
> > > > nasty bugs.
> > > >
> > > > I'd *MUCH* rather hide KMSAN:
> > > >
> > > > config KMSAN
> > > >         bool "KMSAN: detector of uninitialized values use"
> > > >         depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
> > > >         depends on DEBUG_KERNEL && !KASAN && !KCSAN
> > > >         depends on !PREEMPT_RT
> > > > + depends on !LOCKDEP
> > > >
> > > > Because, frankly, lockdep is way more important than KMSAN.
> > > >
> > > > But ideally, we'd allow them to coexist somehow.  Have we even disc=
ussed
> > > > the problem with the lockdep folks?  For instance, I'd much rather =
have
> > > > a relaxed lockdep with no checking in pfn_valid() than no lockdep a=
t all.
> > >
> > > The only locks used in pfn_valid() are rcu_read_lock_sched(), right? =
If
> > > so, could you try (don't tell Paul ;-)) replace rcu_read_lock_sched()
> > > with preempt_disable() and rcu_read_unlock_sched() with
> > > preempt_enable()? That would avoid calling into lockdep. If that work=
s
> > > for KMSAN, we can either have a special rcu_read_lock_sched() or call
> > > lockdep_recursion_inc() in instrumented pfn_valid() to disable lockde=
p
> > > temporarily.
> > >
> > > [Cc Paul]
> >
> > Don't tell me what?  ;-)
> >
>
> Turn out that telling you is a good idea ;-)
>
> > An alternative is to use rcu_read_lock_sched_notrace() and
> > rcu_read_unlock_sched_notrace().  If you really want to use
>
> Yes, I think this is better than what I proposed.

Thanks for your comments!
Yes, that's what I was actually looking into after Dave's answer on
the other thread
(https://groups.google.com/g/kasan-dev/c/ZBiGzZL36-I/m/WtNuKqP9EQAJ)
I'll still need to rework the code calling virt_to_page() to avoid
deadlocks from there though.

