Return-Path: <linux-kernel+bounces-219635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEE090D5E7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B55B284C47
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A911487DF;
	Tue, 18 Jun 2024 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="flh3q8Q6"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43F61F17B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721450; cv=none; b=K4A1bTNu3Ckm0+gQDuingpQE+xA0cqMFB3zs2upbu9xPN9QeVf2n4+UeD6RUp4SAIcBPim3vVI/umtZ5nMpW59Vos2KVV435uKkjIbqT/DCSIBW/VLKNg/gKU4lUCdcpruVbgAckBBsDfBF3haTY4QF81z2/k3psxY2pmbH5WO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721450; c=relaxed/simple;
	bh=aOu0/jH+c+xg2A3PJvl53jLIf3oYGe7U7yf1SetbVWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bnfzwdu1cPZz+1bHb90+Kfmby7iaTpci3ZLwnt27tX2wq4clhGYyAaULEGr6d63zrOUBAl8s0ss66UHQYoGyJW4OahInGUpgWcrUpvA+AYi+QtUPvtYv/sysWw5Bpm7gbZ/nTCnKjBd0ZbGqAmYQALHD0BEspbnYoXk3REL09Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=flh3q8Q6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dff1bcbc104so7249186276.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718721448; x=1719326248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jteX3qu1M+ho2SEsuD2VKCJXLgOnluRf0X8KAKxQZSE=;
        b=flh3q8Q6wIXGdWsV11No69YcV+Ss8MJj2F5+vVl+HRz+BslM3fHLjvDoIOwF/olJ9J
         R4CrW/l+eD4qhRLx8ZRTms5ManRwBkxa7MIbD6lAIz8Ye2Et+lpcNJPDlioScY8E8WjU
         Pn684Y8RIbsvKEMQgt4SFu7Axz8JD0I4coqh0sxQImrZKlFzt2t92oFQDlBuIjehR0HO
         riiv4oXlUDGesvj5anESIM9Q3WpCRSTT0r59gyZLDrYLa7sijp6PMLRe54Hp3JXdE4NZ
         AwsO14O7F77y7OLP3RMgxllqEcnaaU7X1yjkQwjcnm0drEXcdvbddQt6Bcydq4YIHW2u
         VERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718721448; x=1719326248;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jteX3qu1M+ho2SEsuD2VKCJXLgOnluRf0X8KAKxQZSE=;
        b=tXdZs+HLhdWtA8xNhKfJXes+1YbfE4dO6QFP8+MtySzkrcgQ4FY2pOR0CI1s+FrA9K
         ug3xwrw3ep3A+auq4NkNergfFG+lqfKk22MjGZUdu4pg8HEy/5XGgd7xGZna1uUBkRq6
         W3oCE4wnJ0BIJAi3dnsF5wTKaAiKeEdjIZT8OswLgcQDXJV3j0vWSnp0eHzTeKzZ7iwM
         sA1P9ghYBCF0SHhcbA6QGdydvpYN9aotOu1n39jhnbu4YU/Axz3ezCR9ceNw78WzsCEx
         1N8JZ5A+8P15cJsWmYdhUTCYdCmLe1FlnsiOVxrT8zUrpWUYqWvvYzAYFJ/R42opa1Py
         9wpw==
X-Forwarded-Encrypted: i=1; AJvYcCVF3HM7SRTc++vlT5hze/DUeXdWDhS6pUR+XwgbRXweFsUCCVowF5AGjZCm/j2t1Uv64vydHTmZw4tMcWE58j0nFJQAiHlIUt3DJLvy
X-Gm-Message-State: AOJu0YwpLxOdLhWh/lwIaRpdspmfhTWTg3hsDvuJ+ss4rgsk/MIKDxvd
	fvUj1mQuFwLVsWCEhvZDCp5Jt9ILfzT/0JDb8kokDxkA1aBGLsmPFiVa6nOFPg7M+QmiU9R7wWu
	Kgg==
X-Google-Smtp-Source: AGHT+IHdPmqiCw8J4Le5ic/RNDfekcm6Vi0d+tfaxfbnBmc0hVTs/YAhUz+Mm331qyU6QDy+rbMcIOqRP+k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:858f:0:b0:dff:36b3:5c1d with SMTP id
 3f1490d57ef6-e02be18bb15mr618276.4.1718721447818; Tue, 18 Jun 2024 07:37:27
 -0700 (PDT)
Date: Tue, 18 Jun 2024 07:37:26 -0700
In-Reply-To: <CABgObfZCNN4AdzGavqzFANCLq4E5pi+h2+mr9-cysZrFk6bUzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507133103.15052-1-wei.w.wang@intel.com> <171805499012.3417292.16148545321570928307.b4-ty@google.com>
 <CABgObfZCNN4AdzGavqzFANCLq4E5pi+h2+mr9-cysZrFk6bUzw@mail.gmail.com>
Message-ID: <ZnGbpizfefZgO0Q5@google.com>
Subject: Re: [PATCH v4 0/3] KVM/x86: Enhancements to static calls
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024, Paolo Bonzini wrote:
> On Wed, Jun 12, 2024 at 3:23=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Tue, 07 May 2024 21:31:00 +0800, Wei Wang wrote:
> > > This patchset introduces the kvm_x86_call() and kvm_pmu_call() macros=
 to
> > > streamline the usage of static calls of kvm_x86_ops and kvm_pmu_ops. =
The
> > > current static_call() usage is a bit verbose and can lead to code
> > > alignment challenges, and the addition of kvm_x86_ prefix to hooks at=
 the
> > > static_call() sites hinders code readability and navigation. The use =
of
> > > static_call_cond() is essentially the same as static_call() on x86, s=
o it
> > > is replaced by static_call() to simplify the code. The changes have g=
one
> > > through my tests (guest launch, a few vPMU tests, live migration test=
s)
> > > without an issue.
> > >
> > > [...]
> >
> > Applied to kvm-x86 static_calls.  I may or may not rebase these commits
> > depending on what all gets queued for 6.10.  There are already three co=
nflicts
> > that I know of, but they aren't _that_ annoying.  Yet.  :-)
>=20
> I think it's best if we apply them directly (i.e. not through a pull
> request), on top of everything else in 6.11.

Works for me.  I'll maintain the branch so that the code stays in -next, an=
d so
that patches that are destined for 6.12+ are built on the new world, and th=
en
post the rebased patches when the time comes.

