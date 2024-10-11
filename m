Return-Path: <linux-kernel+bounces-360872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB2999A0D1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A75284D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3529210C05;
	Fri, 11 Oct 2024 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPUwLjE4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46649210182
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641352; cv=none; b=qa+OHu8V9KxtGAcGBAK9GKTWpHNuhSGEwhpbF86pUZMpepBBX43xSVhSaTytqxHKaKKQx+yHli1cHqQD5MgnifCGeyz7JnhRA08qoKEbJZLWfx7JKXQKS9GQl+MCGeMgNkqm40SFqUtK7tqHquWCXlatyzFICRLDfOFccgKYJqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641352; c=relaxed/simple;
	bh=PMAPZWief1Cvlh5MnoziMG0cwFA7qKjTMEUZ3nnKxnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOKffjlgCLcxLqg7MAP9OJcAbz8+FtnRRATp4xcdQJK18A9AGdkGIBi2x4vl1PSEr7xRCbplUSRe5A6b2gLZ8HFpeTzTScW+JV5JEXP2ubANo49iQdytkBS/xnQNhjWFQnu96eE1FBSfxVBmwr04bDBAcjd/4LwGhO32H+zOVSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPUwLjE4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728641348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rYX1/0xaAsVY9y/xa8IDQZuNB9RuCS/ODqECEVP3XcY=;
	b=WPUwLjE4cr6Za6/zA3/AE/EsmyVg0exnhEHgEwbxyJhHmx9XMeQkgi2/SRCI1f9pk92t3M
	xJoYVR9xpB6Kt3f4WzMY2LppumKL699oep46Xq5+KsTfcECnvJsU6Uhzdk/H81liKK2ilj
	IgWB2e+Y8q+cJn3Jda1WexS51y7v3Hg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-k28PQQtFOa25qK2iOOyLdw-1; Fri, 11 Oct 2024 06:09:06 -0400
X-MC-Unique: k28PQQtFOa25qK2iOOyLdw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5398d98bea0so1283074e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728641345; x=1729246145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYX1/0xaAsVY9y/xa8IDQZuNB9RuCS/ODqECEVP3XcY=;
        b=oUuvb3GdVne2mkh6CkGLQw+i3YZPOVaJAmErklpOH2+pNE+ZQE0KpiAK5eb0tUnXMb
         9WtvB9skz8AY7LAK98ZCBGm2XJvpUbqAz6uspNuzwUD9/T/IPNBFm3Mah3aFdERix4to
         a+9KU2B2GqX2TcuU70P/e5jceeMShVZq6oNnoG0XbHUJla8WYrZXmHiIfsgzhYVYN02K
         xPgVwvHxWf2KZG+q6KaQ5OjhRFzgNP24QnMXpy+p2j59ypXbKTOShvMyCXCXwZa0p2wq
         YeHxwteD8Ym/mcW7FL/mJ7kNCux5P8b0ztVJ6IZgp4PVD4EJdIjNwLsGNnYJOQgTh79w
         e16A==
X-Forwarded-Encrypted: i=1; AJvYcCWAPbIOvLzHgj7qC4FiaS2cJHxTathidSpeEUfQcsLZysOQ6bRbadeS3thVRtLDQUuTIs4Fkkqi6QqeNLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuvEeGfSBprNGORdIF37gLZR76R72sA/2FsjysHEKDaTf4HDlk
	9/uaKQEJdnWN6wjuWIUgz1qeTImey1u1DR8FfSBRY2H923RjlDJF3BKAye3U7VFjGWaEjL9gAGB
	FG4Y3oxoMGpohDb5ZQjOgKkz/kzWyxKcvhXEzNI05Dby7yqn+HRHcTiWLckRerliFKjR5rqtVig
	QIovErf5N6NDFluUy1TDjTFurZwZXC0I4htbrF
X-Received: by 2002:ac2:4c43:0:b0:539:93ef:9ed9 with SMTP id 2adb3069b0e04-539da4f8601mr1065152e87.36.1728641345339;
        Fri, 11 Oct 2024 03:09:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh9JhMluU61p9DiGJofBd50PyPZtVPQ4h/Gwn/PPd9vgOrL5ypr4hHBgPmFmh0wtP+fgFjDzk950NotpVtb30=
X-Received: by 2002:ac2:4c43:0:b0:539:93ef:9ed9 with SMTP id
 2adb3069b0e04-539da4f8601mr1065125e87.36.1728641344858; Fri, 11 Oct 2024
 03:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZwgYXsCDDwsOBZ4a@linux.ibm.com> <640d6536-e1b3-4ca8-99f8-676e8905cc3e@redhat.com>
 <Zwj4AllH_JjH5xEb@linux.ibm.com>
In-Reply-To: <Zwj4AllH_JjH5xEb@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 11 Oct 2024 12:08:52 +0200
Message-ID: <CABgObfa9AjsDTTKJY5sZLcH0+-7tbpUvMnEiyq_wxhe9-fajzA@mail.gmail.com>
Subject: Re: [RFC] powerpc/kvm: Fix spinlock member access for PREEMPT_RT
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 12:04=E2=80=AFPM Vishal Chourasia <vishalc@linux.ib=
m.com> wrote:
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 8094a01974cca..568dc856f0dfa 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -168,6 +168,7 @@ config PPC
>         select ARCH_STACKWALK
>         select ARCH_SUPPORTS_ATOMIC_RMW
>         select ARCH_SUPPORTS_DEBUG_PAGEALLOC    if PPC_BOOK3S || PPC_8xx
> +       select ARCH_SUPPORTS_RT                 if !PPC || !KVM_BOOK3S_64=
_HV
>         select ARCH_USE_BUILTIN_BSWAP
>         select ARCH_USE_CMPXCHG_LOCKREF         if PPC64
>         select ARCH_USE_MEMTEST
> I tried rebuilding with the above diff as per your suggestion
> though it works when KVM_BOOK3S_64_HV is set to N, but for
> pseries_le_defconfig, it's set to M, by default, which then requires sett=
ing it
> to N explicitly.

Yes, that was intentional (the "!PPC ||" part is not necessary since
you placed this in "config PPC"). I understand however that it's hard
to discover that you need KVM_BOOK3S_64_HV=3Dn in order to build an RT
kernel.

> Will something like below be a better solution? This will set
> KVM_BOOK3S_64_HV to N if ARCH_SUPPORTS_RT is set.
>
> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index dbfdc126bf144..33e0d50b08b14 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -80,7 +80,7 @@ config KVM_BOOK3S_64
>
>  config KVM_BOOK3S_64_HV
>         tristate "KVM for POWER7 and later using hypervisor mode in host"
> -       depends on KVM_BOOK3S_64 && PPC_POWERNV
> +       depends on KVM_BOOK3S_64 && PPC_POWERNV && !ARCH_SUPPORTS_RT
>         select KVM_BOOK3S_HV_POSSIBLE
>         select KVM_GENERIC_MMU_NOTIFIER
>         select CMA

No, that would make it completely impossible to build with KVM enabled.

Paolo


