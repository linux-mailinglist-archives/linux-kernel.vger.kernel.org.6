Return-Path: <linux-kernel+bounces-299683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA5C95D89B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A891F25AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA861C825C;
	Fri, 23 Aug 2024 21:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5xcNbAo"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8502A14A4C8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724449345; cv=none; b=T9Ncl/USMoD/nnldFKUy8oV6S5q0eMaJWM5ApaSftky0Vjm335XXaR8fAeB79TCWdBtk3kBZ2Ij+z3Xnyck8ii0Ky3ISidhMLkXNBd6p4ChiiwAaZ8IpCMYJOGzUoY36WjCU8MHknKDqIWpR4vQEPYYRPHhCxlnCJ+jVFeXPQIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724449345; c=relaxed/simple;
	bh=aI7PPWxJ6Tr3fljO4Nuv0IbZBiPNs0uwRox3fI3oYuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o561IMs6w5B6GY9w3xXI/Yy3D1l2dkjPv8Cksx/o+GoXMJeEH2qr7OmZFCXE21n455l8nkE31smAn5oEz23UhGIj0g8v1qABAFVZOYatlUVqVH783YGaasDyAf81bC5/gj+NgtsruwBDU+b9HjMKbKs6R9/w7GST2yBtOanKAps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p5xcNbAo; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bebc830406so4426a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 14:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724449342; x=1725054142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cCH5zIwX3G+pp4ZQhWB5NoY5CTXl/CUYEiOBSaPvWw=;
        b=p5xcNbAo1gnj+7pldWWp7/1SWSB3YB0YieDAjE8TvQlC0S70BtvOj9siNUh5fUT4ut
         bzFFMWD2oQi0LffKZl8drEhEur9SWWg+bGMJhtktBXuMZyLbx6GQvkLIjM5P/4e77fbw
         6BEomr0Zr83G8bt+LPYqNUu26YiQW1MLqRAXIlldHf8wL76bKmZsSa67avsh35ryr0SK
         BitP/lSzEDpKC+fPxgnUemkMnJDxTKmzeq6xvDUyfW3R+6XTgUVOq24wfI+CwYzHEOz1
         DRhth3hd1R4AoCMJkYe3atHlH8QNl7+IEw85sBxi4LzDdzz7V2yKNDFGVBNvrounjhKn
         xmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724449342; x=1725054142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cCH5zIwX3G+pp4ZQhWB5NoY5CTXl/CUYEiOBSaPvWw=;
        b=dYQAy8XvilXORWTsiwnQWITl3rsI7Fw+VMkYPfyFQoswHw8a696KsA1EXBEo8Mr7oa
         8aHQN9af07dcSnZW9NMvjgPyjI/wTsnnfOw8ZtFM7zHBgY+FyW6t1EJCSXtKEek2j3xQ
         NC9oggCt0GgErhZ4fCQkYVBDr6bR7F20cnzRMy07uwPzBF7jxIboR4HRi687ytNqWK0i
         ZEE/waVdsiDnAuTbZ7p6vTPBzLxQ6Se8s2cxlKFfDD4WVQCBSkee0GjNDbysPHT24sTO
         z8SaRKCADMevNXhXrQqUZ+/WA+CItUySbjnBJvw4aIdB8+GakXZLNINjCjrf1tyNikuZ
         lwoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2s68o4ULHh2uVQD/HKoYW1SegYWaIqeH9aJGc5xQxxrAZzfxbvahv1b/sFxnbu0+eqNVGVU0+6J09PqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwXjxrsDUaU2yN49a3Jvfmf9/aaEauV7Ua2+VqJFQnZQjhjB30
	7r3TOqznX2rz4tkt7cVyr4ooJTB9AQ3hObJDZJwTvWV92RjyRFcYseJT4IgHhK7PEbzzYvktMOm
	crIqAS1Z5jGgHYYNODcIIAOcDJvnFiKE/wy+L
X-Google-Smtp-Source: AGHT+IEGI07JYIq1FGeMPwKJLbtbaEie9Mu9gITdcOY1iZGw0/mXNLV8T5FdlFRr20y5dXEUb/uXU7nRRC7hPAWyt4k=
X-Received: by 2002:a05:6402:3550:b0:58b:b1a0:4a2d with SMTP id
 4fb4d7f45d1cf-5c097d15b2amr11860a12.1.1724449341467; Fri, 23 Aug 2024
 14:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812171341.1763297-1-vipinsh@google.com> <20240812171341.1763297-3-vipinsh@google.com>
 <ZsPE56MnelsV490m@google.com> <20240823192736.GA678289.vipinsh@google.com> <Zsj09MWgM7-HuZ__@google.com>
In-Reply-To: <Zsj09MWgM7-HuZ__@google.com>
From: Vipin Sharma <vipinsh@google.com>
Date: Fri, 23 Aug 2024 14:41:44 -0700
Message-ID: <CAHVum0dMmjd0b68aYJh8=F8kYShM3bQh0eXDL1+m27Om5YaDCg@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Recover NX Huge pages belonging to TDP
 MMU under MMU read lock
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, dmatlack@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 1:45=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Aug 23, 2024, Vipin Sharma wrote:
> > and if that didn't suceed then return the error and let caller handle h=
owever
> > they want to.  NX huge page recovery should be tolerant of this zapping
> > failure and move on to the next shadow page.
>
> Again, I agree, but that is orthogonal to the WARN I am suggesting.  The =
intent
> of the WARN isn't to detect that zapping failed, it's to flag that the im=
possible
> has happened.
>
> > May be we can put WARN if NX huge page recovery couldn't zap any pages =
during
> > its run time. For example, if it was supposed to zap 10 pages and it co=
uldn't
> > zap any of them then print using WARN_ON_ONCE.
>
> Why?  It's improbable, but absolutely possible that zapping 10 SPTEs coul=
d fail.
> Would it make sense to publish a stat so that userspace can alert on NX h=
uge page
> recovery not being as effective as it should be?  Maybe.  But the kernel =
should
> never WARN because an unlikely scenario occurred.

I misunderstood your WARN requirement in the response to this patch
and that's why suggested that if you are preferring WARN this much :)
maybe we can move it out outside and print only if nothing got zapped.
Glad it's not.

We don't need stat,  userspace can use page stats and NX parameters to
observe if it is working effectively or not.

> If you look at all the KVM_MMU_WARN_ON() and (hopefully) WARN_ON_ONCE() c=
alls in
> KVM x86, they're either for things that should never happen absent softwa=
re or
> hardware bugs, or to ensure future changes update all relevant code paths=
.
>
> The WARN I am suggesting is the same.  It can only fire if there's a hard=
ware
> bug, a KVM bug, or if KVM changes how it behaves, e.g. starts doing A/D t=
racking
> on non-leaf SPTEs.
>

I responded to this email before moving on to your next email :)

I agree with WARN there which is for checking if new SPTE is pointing
to the old page table. I have a few other comments (not related to
WARN), I will respond there.

Thanks!

