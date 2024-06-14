Return-Path: <linux-kernel+bounces-214152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F32908042
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F20FAB20FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053274A29;
	Fri, 14 Jun 2024 00:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtrXvUsG"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040721C3D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718326141; cv=none; b=Mv5eMwJqp9kW8x6LqaeOrM4MHydp3c5i0TbceE1Oh2d/dKHMBjNcMWTLrk+ZmYSuTIVo9M832AvNpIjdFD0hEVtwUetYOY606ijtbt+FEaKdpWmATpa+ae9Fqb8zwxZ0uBi0TGHtg++a18RCWK1+GOCBjREkzxAI6ThgtMg4d1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718326141; c=relaxed/simple;
	bh=EzpkdrF+lhKU70e/G955Esb8W0Pby1fF9pS1lclAB+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtzPJ/DlIxp973YODyd38NGpWeh07z3UK+4U6c04zYc4q7Q0i0dWrgAH8ijCJogoYC+Bht+gnPuVXQahHJ2O+nDp1HNAcI9/4atuQ35Nxo7T3WZyDqTW8XQxE1uMr+KT6Lg9Nw0wIgCFhh7Ng9OY/XTO7YK5E3WoOHFLj11QVs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dtrXvUsG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f70ec6ff8bso85875ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718326139; x=1718930939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cs3I7xb2JkPfyVWwhfDDItDBDpUbWjmYdCsu/iDXVRE=;
        b=dtrXvUsGBzM1zr29vh5hOYKxdIP6P+az+QDjYj+sTaJISBKwtwTBtLAaSW0OmGlF/Z
         EQwiVPrASgXAUNZ/Zn4NrHLj4zZPIQDEhEZCW7lOePlu+P6BsECJWwVWkQQjHNoy4LFB
         09iHDkeUqcqg3O3mTZLt+MpPvnmo38wmcLDhOezFRdBPWz3pJFkOYpFNd0IpBZ6GTi1o
         AXlKf5kAHprVLwYwzFpOz2LbPDTUJKISjGugc2fmVKP7CQTH7vrN3RNJ2klO6j7FsVFC
         4UotxyN4r+/4trESUfUfFS8rUxCVU65xmMUAViiz0EM342z6iHz4I6WW/0W20Tk1oCbU
         4Q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718326139; x=1718930939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cs3I7xb2JkPfyVWwhfDDItDBDpUbWjmYdCsu/iDXVRE=;
        b=ZRXrhyKOlpoAKDTV30CZOAh2YPLsaBeNPnps7POhAtY1Wfi1xb9lRlyKEFBZS0oz/b
         mMyQFEq7X1u/L/2NfWJQnZlCIV92rZLtBtYGWhlYf0Z/dXBZvpvrC2dYQN8cc0TbATJ5
         m9XV6ewhFZp1M5z24Djtx3+D6cLBmXwfroFh0A/v10TZ7HTOCLU9mr4ODc1f4oMfORB5
         PkLJ2mLSePd4RRXEwCsSSHGeqV7Cg/x9OJz1jRLEAjqzHaNF4eQS5wE7c/oTmMYKxCva
         V52ECOoSA5Wqqk8VgxxjsuDa3CkZKflH0P8lusFNsGhgyaeAuOraPxO2XcXXJGtszI3c
         4DbA==
X-Forwarded-Encrypted: i=1; AJvYcCVNRvwbrIDAguK1oj2Q4oJ/nVm3HqS5SKXDWJ06Fyf9+DzbV1ZxV4BPKndsuAi2OErv3aBdcfKYEsIzT6ue4XgA+qyIZaMVLmbAQ8KS
X-Gm-Message-State: AOJu0YxfHjRq6Nzh8KSIrsWlTYZ7eU4FySkDMQdMQFAKok/UkE71Y8ov
	Ea74XtoRgnIfY5AA7k0aB1IIKzB5dK4Zvv9hii/VeaFFAY60LXl/8/yQSefaJAaihVHHfaEI3XL
	QlvQ+I5XDuIniU9pIdjnjO5bODmXjaBcvitym
X-Google-Smtp-Source: AGHT+IG4rh9cysMLIjJvQTQbAGIfEWjp8FbFtGimlgyhxAwv6QoKwTYp7w2DNRBP89lE6kBTdOWPtAittybnD94st7Y=
X-Received: by 2002:a17:902:b782:b0:1e4:35b9:cce0 with SMTP id
 d9443c01a7336-1f86777297bmr804415ad.9.1718326138884; Thu, 13 Jun 2024
 17:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611002145.2078921-1-jthoughton@google.com>
 <20240611002145.2078921-5-jthoughton@google.com> <CAOUHufYGqbd45shZkGCpqeTV9wcBDUoo3iw1SKiDeFLmrP0+=w@mail.gmail.com>
 <CADrL8HVHcKSW3hiHzKTit07gzo36jtCZCnM9ZpueyifgNdGggw@mail.gmail.com>
 <ZmidYAWKU1HANKU6@linux.dev> <ZmiqXUwMXtUGanQc@google.com> <ZmqXRhFSoE38foh6@linux.dev>
In-Reply-To: <ZmqXRhFSoE38foh6@linux.dev>
From: James Houghton <jthoughton@google.com>
Date: Thu, 13 Jun 2024 17:48:22 -0700
Message-ID: <CADrL8HXhGFWwHt728Bg15x1YxJmS=WD8z=KJc_Koaah=OvHDwg@mail.gmail.com>
Subject: Re: [PATCH v5 4/9] mm: Add test_clear_young_fast_only MMU notifier
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, James Morse <james.morse@arm.com>, 
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Shaoqin Huang <shahuang@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Wei Xu <weixugc@google.com>, Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 11:53=E2=80=AFPM Oliver Upton <oliver.upton@linux.d=
ev> wrote:
>
> On Tue, Jun 11, 2024 at 12:49:49PM -0700, Sean Christopherson wrote:
> > On Tue, Jun 11, 2024, Oliver Upton wrote:
> > > On Tue, Jun 11, 2024 at 09:49:59AM -0700, James Houghton wrote:
> > > > I think consolidating the callbacks is cleanest, like you had it in
> > > > v2. I really wasn't sure about this change honestly, but it was my
> > > > attempt to incorporate feedback like this[3] from v4. I'll consolid=
ate
> > > > the callbacks like you had in v2.
> > >
> > > My strong preference is to have the callers expectations of the
> > > secondary MMU be explicit. Having ->${BLAH}_fast_only() makes this
> > > abundantly clear both at the callsite and in the implementation.
> >
> > Partially agreed.  We don't need a dedicated mmu_notifier API to achiev=
e that
> > for the callsites, e.g. ptep_clear_young_notify() passes fast_only=3Dfa=
lse, and a
> > new ptep_clear_young_notify_fast_only() does the obvious.
> >
> > On the back end, odds are very good KVM is going to squish the "fast" a=
nd "slow"
> > paths back into a common helper, so IMO having dedicated fast_only() AP=
Is for the
> > mmu_notifier hooks doesn't add much value in the end.
> >
> > I'm not opposed to dedicated hooks, but I after poking around a bit, I =
suspect
> > that passing a fast_only flag will end up being less cleaner for all pa=
rties.
>
> Yeah, I think I'm headed in the same direction after actually reading
> the MM side of this, heh.

Yeah, I agree. What I have now for v6 is that the test_young() and
clear_young() notifiers themselves now take a `bool fast_only`. When
called with the existing helpers (e.g. `mmu_notifier_test_young()`,
`fast_only` is false, and I have new helpers (e.g.
`mmu_notifier_test_young_fast_only()`) that will set `fast_only` to
true. Seems clean to me. Thanks!

