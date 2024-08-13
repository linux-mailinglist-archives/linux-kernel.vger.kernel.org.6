Return-Path: <linux-kernel+bounces-285067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 244299508D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574B51C23FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA2B1A08BA;
	Tue, 13 Aug 2024 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKXpVNU2"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303351E86A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562364; cv=none; b=VTTTN7h/QYF6EWXVmJVsrouTF0o9hK1TM+ll2OggzzT0bISFI2HkJSLPpK4LAaKkLU2Q8eN+JkqK6gTirpmb43/aGBVUPifgtqZuBWpvFiXFDjMXRPWu1fgIihyb52kANtGJS3H2gIJnFNKoAV6AfB7HzPYUOSY2O6zbRl3+3Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562364; c=relaxed/simple;
	bh=4Xp48SJMLcVIZJiAwvicvIafG9pNg+39hHzu6XF0VPQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jHmuLMMU4e72thG+qr8lmALYyveGdOG9YNhcQp7wkz9x/xBgX+m5VFTW+tglRLSi1zFhy4XwVq8ISWPuMf54J5HNJssPTGq4dB/pe+K+LOppgJDWOMCp02esqy31AtffBcgnPq/QJ6zZhm55r+jqZpX18YDha7ytfB4biBgH0Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jKXpVNU2; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7106fcb5543so3922691b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723562362; x=1724167162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiVajlnnhMg/Yh+qfX66bQ3bWZlc6mtowqxiGC0tj8M=;
        b=jKXpVNU2Ld1vGetyzbbs8IiJ4B9FR+acfv2T1ufUnPQVqP3/6WpDd//qmRe0M0wpch
         bnVK9tEcAbH4pSxPq08NyWkT45blPM7ZkKOYzXemR9JrEsjIqft2Mk7SAxeyhzIy4Hj3
         izsNjZ+XKsm3EwJtM5gzPF78Q+3henvnvHL/ZvzbnGdmsp7XXh7awAJ3Xzb+xERPN2Gy
         wFeO/inL2GWfj2Ado6PAPqw1Js0yRTmNeYGsqbJ7ho2maWEdLX1intB3/bqpFdcylI0o
         Sf3HXw6N9fb1ASJ2w5V66x6Zo396+Xg/4bRXeIA3yNlGbuiV41FhbZ0Y65SpJKkbmo1Y
         gOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723562362; x=1724167162;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yiVajlnnhMg/Yh+qfX66bQ3bWZlc6mtowqxiGC0tj8M=;
        b=qZtFpC3UBi0K33qh8cRCKJuz/gdvLH6BWwVvJ4qPmVj72KIqw9dyAfsGveQe8yt0yr
         jNhukpMQydRsqw6UTBa6FMuaYx5ZtNpyjrwPDb716dPvBgWj4t5IxwHCyTPAO3X8w8TC
         0gq2cFi7yj2XBvvqI6iPAALJPQIKBxHS1Xh+YVMLcfooR1CSmZ8ytsuBrzn8BGhJPhfe
         UhgUy5lCdCJOOXrae6Hhv2TdVEUBvAn9XCivGU/zLN4XqmSDL/fK+8f/mspS3N6e/WLd
         xmJzkOsFq3RpOhNOd47bWtdIHciLudTYvjQ0exzXX0jjKmROUTbKksH8HtQgm2pTM6cc
         rwMA==
X-Forwarded-Encrypted: i=1; AJvYcCV360n0V2l4rOavVAOrfG9f0Na6ewtxdsa+tFj/f0slRX/QWjvl9RBBxGhWzkWmE7dfDSnsE4q/hM8gtbSoKTMAsGXtMJbEcn2ay0Q9
X-Gm-Message-State: AOJu0Yyq58F6EwhbSGTaS/n6+Gq8EkuZcvGI4p5eS0fhsnJcYXJ6RByv
	qZMV1hxIehMo9taG8Zpnbo6y1w0DXXlk4TR/Enx/NCHCeY/d8MVq96Hki5Aa/jlTneF97MaIXEF
	JaQ==
X-Google-Smtp-Source: AGHT+IGZphdjDZHrlcnKAsnjY8cAGv5jEiizyXDCv8b9DV58tXXEL/E/tosVycOuJ/VmvuOmGLWv2ESAQ/s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:bef:b0:710:4d08:e41f with SMTP id
 d2e1a72fcca58-712554d8bbamr9757b3a.4.1723562362321; Tue, 13 Aug 2024 08:19:22
 -0700 (PDT)
Date: Tue, 13 Aug 2024 08:19:20 -0700
In-Reply-To: <CAJhGHyDa+-ehMOeLGhZ9-y-ubB4fSXG83hBGUWMRmBOtJ-wSLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com> <20240809194335.1726916-20-seanjc@google.com>
 <CAJhGHyDjsmQOQQoU52vA95sddWtzg1wh139jpPYBT1miUAgj6Q@mail.gmail.com>
 <ZrooozABEWSnwzxh@google.com> <CAJhGHyDa+-ehMOeLGhZ9-y-ubB4fSXG83hBGUWMRmBOtJ-wSLg@mail.gmail.com>
Message-ID: <Zrt5eNArfQA7x1qj@google.com>
Subject: Re: [PATCH 19/22] KVM: x86/mmu: Add infrastructure to allow walking
 rmaps outside of mmu_lock
From: Sean Christopherson <seanjc@google.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024, Lai Jiangshan wrote:
> On Mon, Aug 12, 2024 at 11:22=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
>=20
> >
> > Oh yeah, duh, re-read after PAUSE, not before.
> >
> > Definitely holler if you have any alternative ideas for walking rmaps
> > without taking mmu_lock, I guarantee you've spent more time than me
> > thinking about the shadow MMU :-)
>=20
> We use the same bit and the same way for the rmap lock.
>=20
> We just use bit_spin_lock() and the optimization for empty rmap_head is
> handled out of kvm_rmap_lock().

Hmm, I'm leaning towards keeping the custom locking.  There are a handful o=
f
benefits, none of which are all that meaningful on their own, but do add up=
.

 - Callers don't need to manually check for an empty rmap_head.
 - Can avoid the redundant preempt_{disable,enable}() entirely in the commo=
n case
   of being called while mmu_lock is held.
 - Handles the (likely super rare) edge case where a read-only walker encou=
nters
   an rmap that was just emptied (rmap_head->val goes to zero after the ini=
tial
   check to elide the lock).
 - Avoids an atomic when releasing the lock, and any extra instructions ent=
irely
   for writers since they always write the full rmap_head->val when releasi=
ng.

> bit_spin_lock() has the most-needed preempt_disable(). I'm not sure if th=
e
> new kvm_rmap_age_gfn_range_lockless() is called in a preempt disabled reg=
ion.

Oof, it doesn't.  Disabling IRQs crossed my mind, but I completely forgot a=
bout
preemption.

Thanks much!

