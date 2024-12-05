Return-Path: <linux-kernel+bounces-434081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF4F9E6162
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0362188584F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 23:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61DA1D222B;
	Thu,  5 Dec 2024 23:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTBngy2d"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947C9192B7F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 23:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733441504; cv=none; b=qxxvtju+VK7YG5TsKKAivAxgO9PpgTI21iLDjy94izZbPn+pTRBHgqfT+2dIL6SOBQUONr9kg1RuLjmKTxjPKGngrJcJl0T1mGL4sre0xQaNzzoRNtHBrZYy7GYw3UqFPdjArzP8Ra05+txX++w/1aQKfn5+4uku53b4caUECeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733441504; c=relaxed/simple;
	bh=/ihX0lCXBJfFCvsOFHIJu6cysZ6Vq0x4cO5iS9Q7qBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYj6QAnZ/YGcSVx98CFwQwEakczzEuXxv0cbY3Ad8xUplNjVTRXP/VdYCW1ydrmlQdxz3YqZO3po7WTKp0QTVWXQVcD+Y8y7QJfbkRu0nDLAYq4WGbTLYrpqlzB5RZ2eNcmHPaV8hm7UOWUJB+W+wsoebr1h2bjPAjemgxSOhpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oTBngy2d; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ef7f8acc33so10801787b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 15:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733441501; x=1734046301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0IMN5OU4hbVrS5t00San57aLCq8tVf/YYU7UNV9XtU=;
        b=oTBngy2dRTKxt4HaiJo2zQx2tJFl4Fzr7ePXI0fZaGsfY7TnvQmxydcdjiRyGEMKos
         Y8Olb3c6k1NRps8ToYYEbOS//ekrGPvL8uTV0KIYYQnWWv3mgBhFkvxS0PtXEJr8wZjH
         50Gy9fINYHitrIBb8CADRJKb0zrfkeySCYkSAGoSvScqv+3mr4aJDAKVTKwyttxJslch
         JW1lw5cC4GJRwmoAJm6+fR9iixNXgH1hWuDX4CO/a7jCii4+fUHt+dO68tN+OJcT6iuT
         gmymlIWrD1a4id/pkeGibfmFG6aI6JAz5CnZfTwdSBtCXz0WaKdLFI3Gzl65fUn7NUJu
         IVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733441501; x=1734046301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0IMN5OU4hbVrS5t00San57aLCq8tVf/YYU7UNV9XtU=;
        b=PS0lrpDktRxPxyzIWU7SJgklm6pyoeJoKeWJAnzTCefJbnAlLNzAeGkZTIuG/fLmFk
         12JJbleryEIlocnRffh/OMhTPu4z0Y3YAKk+YBov9DMKl33OPuCiP5cS4H1worgs15Te
         DxiWAmbA+iqPJVubTeoi78CrzJOt0jv8Hqu0/d1mw2U9ciwT90+ckjU9HzvBl2U/Ued8
         43OeqNWz2LMqdLjWLo66TtozGLtEFgtEYEUOAX1bzTJInkEmstNSh/SENJ1PjVV/xZZx
         DK8fKiS24DSUd/ItZqva3CWOC774eDF9HXf/A0mrnBAPaDuqkY9IEANPhYuqS683liHm
         q+lw==
X-Forwarded-Encrypted: i=1; AJvYcCWv1g9QmoUkLybUGWmXaH26xPZFg3p0L+CPBu2G2Q6qYsH2qVl+0iAS5qmCkGPI7ufucasZoY7TxkRuYuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4NDAqmfu0OL0hNX0veR88zM1wvVC1vW/SvilRHVxi4TIYHGr5
	feLrlJTN86W0w/PWvR8LuWOx3sI9bi7aLd3wmX5tPNAbxyXTV0so/rO6/HoY0dXYtYtRdWdoRB9
	g+pbaTKBnn4H+2VvKnyCHBAlC9axQUfhvFHTu
X-Gm-Gg: ASbGncuVN/G/clwlWjG1XVql12DCgPVh3b9Gyou+vY8EebGV78GHPqSGzouxZF//5sF
	fpUfcaYhrUkvsrdASaJ7YZJCD/vy/BHtpHwCxnBpfIPVNW4wU++7UACyO58nd
X-Google-Smtp-Source: AGHT+IGmoqWrGrMqKXzXbSlaDtMUJEUS1r8dSNypZARIHLTYBVYvB4FriHIdmOjPWn9wrKQu/NTZU5U476BPS24s0cI=
X-Received: by 2002:a05:690c:6083:b0:6ee:6c7d:4888 with SMTP id
 00721157ae682-6efe3c6049bmr11833187b3.22.1733441501392; Thu, 05 Dec 2024
 15:31:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204191349.1730936-1-jthoughton@google.com>
 <20241204191349.1730936-7-jthoughton@google.com> <Z1Dgr_TnaFQT04Pi@linux.dev>
In-Reply-To: <Z1Dgr_TnaFQT04Pi@linux.dev>
From: James Houghton <jthoughton@google.com>
Date: Thu, 5 Dec 2024 15:31:05 -0800
Message-ID: <CADrL8HWC7HhYmEBWa+5KeWmyD+iT1zPBJUAUtNyrhH7ZpLXJNQ@mail.gmail.com>
Subject: Re: [PATCH v1 06/13] KVM: arm64: Add support for KVM_MEM_USERFAULT
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	Nikita Kalyazin <kalyazin@amazon.com>, Anish Moorthy <amoorthy@google.com>, 
	Peter Gonda <pgonda@google.com>, Peter Xu <peterx@redhat.com>, 
	David Matlack <dmatlack@google.com>, Wei W <wei.w.wang@intel.com>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:07=E2=80=AFPM Oliver Upton <oliver.upton@linux.dev=
> wrote:
>
> Hi James,

Hi Oliver!

>
> On Wed, Dec 04, 2024 at 07:13:41PM +0000, James Houghton wrote:
> > Adhering to the requirements of KVM Userfault:
> >
> > 1. When it is toggled (either on or off), zap the second stage with
> >    kvm_arch_flush_shadow_memslot(). This is to (1) respect
> >    userfault-ness and (2) to reconstruct block mappings.
> > 2. While KVM_MEM_USERFAULT is enabled, restrict new second-stage mappin=
gs
> >    to be PAGE_SIZE, just like when dirty logging is enabled.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >   I'm not 100% sure if kvm_arch_flush_shadow_memslot() is correct in
> >   this case (like if the host does not have S2FWB).
>
> Invalidating the stage-2 entries is of course necessary for correctness
> on the !USERFAULT -> USERFAULT transition, and the MMU will do the right
> thing regardless of whether hardware implements FEAT_S2FWB.
>
> What I think you may be getting at is the *performance* implications are
> quite worrying without FEAT_S2FWB due to the storm of CMOs, and I'd
> definitely agree with that.

Thanks for clarifying that for me.

> > @@ -2062,6 +2069,20 @@ void kvm_arch_commit_memory_region(struct kvm *k=
vm,
> >                                  enum kvm_mr_change change)
> >  {
> >       bool log_dirty_pages =3D new && new->flags & KVM_MEM_LOG_DIRTY_PA=
GES;
> > +     u32 changed_flags =3D (new ? new->flags : 0) ^ (old ? old->flags =
: 0);
> > +
> > +     /*
> > +      * If KVM_MEM_USERFAULT changed, drop all the stage-2 mappings so=
 that
> > +      * we can (1) respect userfault-ness or (2) create block mappings=
.
> > +      */
> > +     if ((changed_flags & KVM_MEM_USERFAULT) && change =3D=3D KVM_MR_F=
LAGS_ONLY)
> > +             kvm_arch_flush_shadow_memslot(kvm, old);
>
> I'd strongly prefer that we make (2) a userspace problem and don't
> eagerly invalidate stage-2 mappings on the USERFAULT -> !USERFAULT
> change.
>
> Having implied user-visible behaviors on ioctls is never good, and for
> systems without FEAT_S2FWB you might be better off avoiding the unmap in
> the first place.
>
> So, if userspace decides there's a benefit to invalidating the stage-2
> MMU, it can just delete + recreate the memslot.

Ok I think that's reasonable. So for USERFAULT -> !USERFAULT, I'll
just follow the precedent set by dirty logging. For x86 today, we
collapse the mappings, and for arm64 we do not.

Is arm64 ever going to support collapsing back to huge mappings after
dirty logging is disabled?

