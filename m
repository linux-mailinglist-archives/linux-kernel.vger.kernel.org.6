Return-Path: <linux-kernel+bounces-185316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEC98CB365
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693742831C0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926B37EF18;
	Tue, 21 May 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="MkKGpjw7"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AF01F959
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716315513; cv=none; b=EDOOzzJb1mHq8kxPxx3NYWFqpwzHFp07sCsro6LVrGr/4xTscC0GQSxphL6DvDooATk7Ah+7ph1DHQNDPFI0t40u5NQpkFKjslzF9/wWPP0GXzRsf0nmJVdVaaqVPMWeOXI95JfzBwqf/KEHw8SEU6oMLzEp5fZsFtPdxuJywWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716315513; c=relaxed/simple;
	bh=lfq3/p0h5MKLio19PWndwbYN7MTFoTHLcIZ5Z+wNiy4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MowisPxQwdEiuB5u2D95Q8O74fSqOf+8AKR4rT6gUq830go7FJanXwH99ancaZmIirROI9qbr9lqcVyNIaOISoaVRmiSoRmgkVstffldtDtfs8ctMa9g4JOGqGcoiyv2CMRTjFbH9EWhw3ImE2vbJXnhOFI7ixbuXKQg9NNzyWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MkKGpjw7; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de54be7066bso22855964276.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716315510; x=1716920310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwQ9snbu95pE4x0LUCjBq9CW+c6Rq1RORndHTBMHkaw=;
        b=MkKGpjw7yRyu7hFkfcAWL/Ua8etRSiR/yt3NX3LgjfpIoZcwBfK79AIiXZd9XHl084
         h8PXOiALT9wdbP6pJN7+OlUn6vBwbOoc3AMHPyK1h4jGnM0IIoTFrEqHIDtjSTSplD6A
         NuqrmnsvAc9Nofrw2qfT7N7FGJAHR3xj9RdX7l/Yry4ufvkIB52rr7lT6eWWGxMWvFA2
         XcdEGW6ZODGFGARytnWO7fYHhj3XpFiXvRZ14UjjO1qAdE8pHohGykFxmo3StyBUJc/5
         J0CK5VTgmNYgwMaEUk5TpdIHqluy189p/8l2ZzBcvIHos4fYQUn3NenWZ7YUsDlMTEfE
         qSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716315510; x=1716920310;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TwQ9snbu95pE4x0LUCjBq9CW+c6Rq1RORndHTBMHkaw=;
        b=p1deFhdUqPFYf7QudpOQys39bBEVh97QVlESLHqv60y+vrno6b7rsCAdzErifZKSdT
         WsrTUILASFvSRear3jMnsucQrRn+O3OpV59t/WeopQser2ED/Yvjx62/gdtG3HT6F9V9
         8Xd+0au6YDrf78Zh6yRIjWi+WB7TAsCzkW9EhJMHrWvGU5cGFfqLqfrufCl+GCkSGJl/
         u7nInZ2mzWZg36pApuzX5UO+Fvv/nNElv1dLjLlg6NnyxTJehbOJxRKO/plUJZLfcx79
         cUHRLnqKB/cWiF+j/kvdh9QzvlXMZypuzsU6aoHXyPGZyAXjMdWLItJmHJ+h2HsgKwa3
         2tlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqVu9BHaRh5OsQpsPqsRKOtbJCzUqwK8Iepw3RrJWTIorX5i2pIabzSyvVJt53M+yWCrThSoXqbs57KFX/cZQP68eyRSutbTjvn+tZ
X-Gm-Message-State: AOJu0YyrTsezh3k0SzzaLH7GiAEPQDkfSX7dEP6eGghJjQq4T+d29ji4
	Kyo94wG2jPp4xg8MhMyZkrDOB2SS2yb890z1ApBp4f0vdmj3Cr1LYc1O/dt9XZE0agN3CThn4fG
	LGw==
X-Google-Smtp-Source: AGHT+IGHGDBMmiK5t+GbcsuTKyZDDKZC3FkQs9ca5TrM1ADcpb5DnT7k1vbmiAW7NmfDK1CcFHd1cmlhwBY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:149:b0:de5:5225:c3a4 with SMTP id
 3f1490d57ef6-dee4f304cb7mr7842641276.7.1716315510346; Tue, 21 May 2024
 11:18:30 -0700 (PDT)
Date: Tue, 21 May 2024 11:18:28 -0700
In-Reply-To: <CABgObfYo3jR7b4ZkkuwKWbon-xAAn+Lvfux7ifQUXpDWJds1hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240518000430.1118488-1-seanjc@google.com> <20240518000430.1118488-10-seanjc@google.com>
 <CABgObfYo3jR7b4ZkkuwKWbon-xAAn+Lvfux7ifQUXpDWJds1hg@mail.gmail.com>
Message-ID: <ZkzldN0SwEhstwEB@google.com>
Subject: Re: [PATCH 9/9] KVM: x86: Disable KVM_INTEL_PROVE_VE by default
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024, Paolo Bonzini wrote:
> On Sat, May 18, 2024 at 2:04=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > Disable KVM's "prove #VE" support by default, as it provides no functio=
nal
> > value, and even its sanity checking benefits are relatively limited.  I=
e.
> > it should be fully opt-in even on debug kernels, especially since EPT
> > Violation #VE suppression appears to be buggy on some CPUs.
>=20
> More #VE trapping than #VE suppression.
>
> I wouldn't go so far as making it *depend* on DEBUG_KERNEL.  EXPERT
> plus the scary help message is good enough.

Works for me.

>=20
> What about this:
>=20
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index b6831e17ec31..2864608c7016 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -97,14 +97,15 @@ config KVM_INTEL
>=20
>  config KVM_INTEL_PROVE_VE
>          bool "Check that guests do not receive #VE exceptions"
> -        depends on KVM_INTEL && DEBUG_KERNEL && EXPERT
> +        depends on KVM_INTEL && EXPERT
>          help
>            Checks that KVM's page table management code will not incorrec=
tly
>            let guests receive a virtualization exception.  Virtualization
>            exceptions will be trapped by the hypervisor rather than injec=
ted
>            in the guest.
>=20
> -          This should never be enabled in a production environment.
> +          Note that #VE trapping appears to be buggy on some CPUs.

I see where you're coming from, but I don't think "trapping" is much better=
,
e.g. it suggests there's something broken with the interception of #VEs.  A=
h,
the entire help text is weird.

This?

config KVM_INTEL_PROVE_VE
        bool "Verify guests do not receive unexpected EPT Violation #VEs"
        depends on KVM_INTEL && EXPERT
        help
          Enable EPT Violation #VEs (when supported) for all VMs, to verify
	  that KVM's EPT management code will not incorrectly result in a #VE
	  (KVM is supposed to supress #VEs by default).  Unexpected #VEs will
	  be intercepted by KVM and will trigger a WARN, but are otherwise
	  transparent to the guest.
	 =20
	  Note, EPT Violation #VE support appears to be buggy on some CPUs.

          This should never be enabled in a production environment!

          If unsure, say N.

