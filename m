Return-Path: <linux-kernel+bounces-283987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9505394FB8E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F33CDB218BA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 02:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED9712B72;
	Tue, 13 Aug 2024 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FNwkZB43"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C9CD299
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 02:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723514761; cv=none; b=fQq0qiR3DzpbL7zE8Dwg6WfCK4Fqeo50Hl8LmnBN75tYDqitFeV4tnUFrJJwG5Yenz+NO9gRSXnNCqi9sOyz3YCOCQrsmzVp8CaabbqlTNVhQ0QeK0R0u80KPfKIZqVEZJrrbbiDlSeChTm3gMTXiCbLk6R2OW+zfq6aJwkGB5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723514761; c=relaxed/simple;
	bh=/hCQcM4Y08P6qJOn4vVha/UUYcfFhpNYaUuiBNAL/ng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kRO3ir/0mkxcK6rJgQoXr9zSSjlOYp6/co2KgCWWXyj3j9wqVOemZiNueiZvhcouMLpB/YxoeD9r70KliWfwPrx2gIcYk3uM408gPc7mMDhL+yKBXeHebVIg+g+CYsGtf7AKhWXndDhD/Y6NVlQkXtgxaUV2LHHdSgCUkEmK6WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FNwkZB43; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70f0a00eb16so3418609b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723514759; x=1724119559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTrcYlNshYngPiSYeGYBD6ZRFP0rJ4yWLqR8htIj1GU=;
        b=FNwkZB43N8U4VF9cax4Hw0pbQoTKq6ee2ubgRN05GS8EE+G6ykKdXwLQ4XFr925UJP
         NLphaRzqT8c4r+Ct9JTTFNJb4hnxWIHbymIvLZGZx6wOSY7XjMpJibryIFLTaQvaJ9YK
         yPlHYP8qjowXbc9RSoHFlSfgLwMN2hTabE2kyMKcJm46hax4Em3qRBKkXhJW0PuBURbQ
         rdZYjVrICwFs6VEGvQThf8nz6Xawi+mDeGLagf0lygnfwfpZUSbGxKwsASlg6qGz4lxM
         /VN8vxT+cFuioa/QOaJeqlfy0CSiHjjHlxhmAPJmYVAhhJBpJA9uVULL/uzK5RuMC1WV
         u7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723514759; x=1724119559;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JTrcYlNshYngPiSYeGYBD6ZRFP0rJ4yWLqR8htIj1GU=;
        b=YZ5mfjaxLK3QJ6kjXpeN/iBRtO/8cGOohZ7vE9Wr8BprJA9UNbohDhrLPRPMGVEXl5
         abFz62X5/G4DyEyrLXJFIis/k8LRK5U6GoeJkvisLXQ81mHQGfG74SAAfcKE8jPgefI6
         NHx2FzvI40r+yacOiLYGf6f08gUpxnfg2eiVGW32zrGyhK+amnQhN+nv1mkqSrwcw3TF
         h+FOsW5MbSRaDoyQafDlhZISTXtlJF7R3gNrcOdHfO7KD9cI9GeYXALMZAU3tU1lpm14
         cIlkURYBTZ3pnjuscOh2kBC4MKUipf/5GeMMSX3bHdQ4TPxU/Sf3jITYKlA+us7qbP1a
         v5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXlAo4srzVICXDKwQAfGn6qEjCzloLTuQAARP3Bw7E56gtU9axk8IYtVzOpK3qJVZutCLv811Orky0EJt+ZPh/NyDj5mV/YbMES1rS3
X-Gm-Message-State: AOJu0YwcnQqaoFn3ECbIpDmbHXJOerbDMDY4kdVSeIjpC8D6uAAOKnnS
	asNoklkf3xRuu0/hDn0aoeB5XiQEDOlTvXfzfRZ1OELTwVhHIBXUxIXBVrf8UWwAn/ovpTIT6d1
	Nyw==
X-Google-Smtp-Source: AGHT+IEw4KOWnUezKCb07r49r8VQShv4Y6sqr3v4rfwBcl9BYsQ7jzdYpBrfRXTk/LiFtqSR5qMGQ76wylw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:6215:b0:710:4d39:c8f9 with SMTP id
 d2e1a72fcca58-7125551dce5mr5087b3a.6.1723514758712; Mon, 12 Aug 2024 19:05:58
 -0700 (PDT)
Date: Mon, 12 Aug 2024 19:05:57 -0700
In-Reply-To: <ZrZafa66bRxoVc0Z@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802200136.329973-1-seanjc@google.com> <20240802200136.329973-3-seanjc@google.com>
 <ZrKqrCnNpNQ_K_qi@linux.dev> <ZrK4x4LLz1wlwGQN@google.com> <ZrZafa66bRxoVc0Z@linux.dev>
Message-ID: <Zrq_hd5CkmmOl6jp@google.com>
Subject: Re: [PATCH 2/2] KVM: Protect vCPU's "last run PID" with rwlock, not RCU
From: Sean Christopherson <seanjc@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steve Rutherford <srutherford@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 09, 2024, Oliver Upton wrote:
> On Tue, Aug 06, 2024 at 04:59:03PM -0700, Sean Christopherson wrote:
> > > Can you nest this lock inside of the vcpu->mutex acquisition in
> > > kvm_vm_ioctl_create_vcpu() so lockdep gets the picture?
> > 
> > I don't think that's necessary.  Commit 42a90008f890 ("KVM: Ensure lockdep knows
> > about kvm->lock vs. vcpu->mutex ordering rule") added the lock+unlock in
> > kvm_vm_ioctl_create_vcpu() purely because actually taking vcpu->mutex inside
> > kvm->lock is rare, i.e. lockdep would be unable to detect issues except for very
> > specific VM types hitting very specific flows.
> 
> I don't think the perceived rarity matters at all w/ this.

Rarity definitely matters.  If KVM was splattered with code that takes vcpu->mutex
inside kvm->lock, then the mess that led to above commit likely would never had
happened.

> Beyond the lockdep benefits, it is a self-documenting way to describe lock
> ordering.

Lock acquisition alone won't suffice, many of the more unique locks in KVM need
comments/documentation, e.g. to explain additional rules, assumptions that make
things work, etc.  We could obviously add comments for everything, but I don't
see how that's clearly better than actual documentation.  E.g. pid_lock is taken
for read across vCPUs.  Acquiring vcpu->pid_lock inside vcpu->mutex doesn't
capture that at all.

It's also simply not realistic to enumerate every possible combination.  Many of
the combinations will likely never happen in practice, especially for spinlocks
since their usage is quite targeted.  Trying to document the "preferred" ordering
between the various spinlocks would be an exercise in futility as so many would
be 100% arbitrary due to lack of a use case.

KVM's mutexes are more interesting because they tend to be coarser, and thus are
more prone to nesting, so maybe we could have lockdep-enforced documentation for
those?  But if we want to do that, I think we should have a dedicated helper (and
possible arch hooks), not an ad hoc pile of locks in vCPU creation.

And we should have that discussion over here[*], because I was planning on posting
a patch to revert the lockdep-only lock "documentation".

[*] https://lore.kernel.org/all/ZrFYsSPaDWUHOl0N@google.com

> Dunno about you, but I haven't kept up with locking.rst at all :)

Heh, x86 has done a decent job of documenting its lock usage.  I would much rather
add an entry in locking.rst for this new lock than add a lock+unlock in vCPU
creation.  Especially since the usage is rather uncommon (guaranteed single writer,
readers are best-effort and cross-vCPU).

> Having said that, an inversion would still be *very* obvious, as it
> would be trying to grab a mutex while holding a spinlock...
> 
> -- 
> Thanks,
> Oliver

