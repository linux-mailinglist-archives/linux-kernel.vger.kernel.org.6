Return-Path: <linux-kernel+bounces-309768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDE1967039
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320C11F2339B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FA816F27E;
	Sat, 31 Aug 2024 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URipuntP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34970320F
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725090997; cv=none; b=QZa4h8AjbVHaBumrfdChBG6oYU/QK+P+2UEzyg9dPzy0AKfNfnrSE/lYbhljOE682wXoZppA5lWJH1HyBlqiT+8GUaiPSuZPT2YC+Vfx1Ez8VS7Nk5KdGzfxuy9vrIFJ1wNprkJmEJlZ3QPPuIfhzXe0M5lYinzOjH5tcp7d54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725090997; c=relaxed/simple;
	bh=3UEayJfJBFtKvAdjmCeaSetXwKEkj0MKFMa9bGKtd34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJmQFRuEZNBS685DtkSfKQMo1Z+ycW3JoVgoJNM0HnCRwqSUSyxlUUwawtvigMcW4AdDO3HRrs/Xjuhv0mSxg88b3d1XBNOUSL7B2J7CptVCKDReRkte3uAMn5v/FqInuceb7GouI9T+B0lcwOKYhEl/dNLydbydz2Z4Q1bSCSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URipuntP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E90C4CEC0
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 07:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725090996;
	bh=3UEayJfJBFtKvAdjmCeaSetXwKEkj0MKFMa9bGKtd34=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=URipuntPYay30Oc9EaoEQk3jzs5uo/kQzomEzUvlpiNMeqT63JdcnffPpZfUiS0he
	 5tblZhYTUNGCUzF8V9raNc3hdgc/AOC8C9yysE+zI8SZs5P2RzqKBsCUOC/fRPP5fD
	 bWwe/HOxXAiT48trD/d6xV15W+DFxUZ8SDZornsmslHrUm01HVuBlkAPtVBmvnu35W
	 B/sZVyjHvvLPhbuBcrh3OwOrMdQJNavXNxJm1ZAV869ltlZVajo4oAzLoOsj/ybCiU
	 MzPLukO5ntsXG9BVnvEjBvmvEwKFuGL3oIFUeZWUfucS8jMtMxudIyzMP4+ZGKPXDg
	 T7pJl7fzJUaCQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso4289060e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:56:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8Zesh/xwW74dIu6Ydi+dQtvvxRucZqQk1MkTMp0F49otSlAjw25HlCNaqN+Q2Lcl7JsNtGz5PZv+HGnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXl0TcIY3LG9bVROBqlGiG+L1gmf/b8Hv5e/AnWJeWlXpU5WHI
	0yv48jzAAitolk/7IzwALraVEajQkeiNYGm7G32W8iD89dt+dCjb/pAQUJaVtcgkOo5WUbC6ESi
	hKyFBNxOjccyZ9ts8V5Yf7tJypoY=
X-Google-Smtp-Source: AGHT+IFV5df6xhbkPQQxnT943f6ufMjPf/6uJ/4xj84CfujGO1G74LiSQF7RyO8tGcPKx8TKsROCPNn1smp8qlUYCEk=
X-Received: by 2002:a05:6512:33c9:b0:52e:9beb:a2e2 with SMTP id
 2adb3069b0e04-53546b13ecemr3487099e87.19.1725090995083; Sat, 31 Aug 2024
 00:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <214e37e9-7aba-1e61-f63f-85cb10c9a878@huawei.com> <86zfotuoio.wl-maz@kernel.org>
In-Reply-To: <86zfotuoio.wl-maz@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 31 Aug 2024 09:56:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGocnZPe4EfzsB6xd2QZacp-a45R5f5f6FDpVtVEXCcGQ@mail.gmail.com>
Message-ID: <CAMj1kXGocnZPe4EfzsB6xd2QZacp-a45R5f5f6FDpVtVEXCcGQ@mail.gmail.com>
Subject: Re: Question on get random long worse in VM than on host
To: Marc Zyngier <maz@kernel.org>
Cc: Tangnianyao <tangnianyao@huawei.com>, Will Deacon <will@kernel.org>, oliver.upton@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, "guoyang (C)" <guoyang2@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 31 Aug 2024 at 09:42, Marc Zyngier <maz@kernel.org> wrote:
>
> [+ Ard, who actually understands the whole RNG thing]
>
> On Sat, 31 Aug 2024 04:34:33 +0100,
> Tangnianyao <tangnianyao@huawei.com> wrote:
> >
> > Hi, all
> >
> > On ARM64 server(Kunpeng), performance of some syscall cases (like fork
> > and open) in guest, which need random u64, are 10~20% worse than
> > those on host. Because CONFIG_ARCH_HAS_ELF_RANDOMIZE=y and
> > CONFIG_STACKPROTECTOR=y, guest kernel need random u64 and
> > require them from host kvm using hvc.
> >
> > If FEAT_RNG is supported and EL3 firmware not support smccc trng, host
> > kvm finally return random u64 using RNDRRS to guest.
> >
> > Shall we firstly let guest get random u64 from RNDRRS to avoid hvc trap?
> > For example, if host find smccc trng not available, then tell guest smccc
> > trng not available when guest check trng version.
>
> My recollection is that it was a deliberate decision to decouple what
> the host firmware offers from what the guest sees (we can always
> implement the SMCCC TRNG using any mechanism that the host has to
> deliver entropy).
>
> Now, userspace has almost complete freedom to expose what the guest
> sees in terms of PV services. In this particular case, it can write to
> the KVM_REG_ARM_STD_BMAP pseudo register to remove the
> KVM_REG_ARM_STD_BIT_TRNG_V1_0 bit from the bitmap, which will hide the
> functionality.
>
> Isn't this sufficient here? Given that you seem to be micro-optimising
> for a particular platform, this seems like the easiest way to reach
> your goal without having to change anything.
>

On top of that, the guest kernel should not be calling this interface
every single time it needs some randomness. The kernel's entropy pool
should be used, which is reseeded as needed using whichever source of
entropy the system provides, which includes arch_get_random_longs().

If every fork() and open() results in a HVC, we need to fix that regardless.

As for RNDR/RNDRRS vs TRNG: the former is not a raw entropy source, it
is a DRBG (or CSPRNG) which provides cryptographically secure random
numbers whose security strength is limited by the size of the seed.
TRNG does not have this limitation in principle, although non-p KVM
happily seeds it from the kernel's entropy pool, which has the same
limitation in practice.

TL;DR if the layering inside the kernel is correct, none of this
should matter to fork() or open() performance.

