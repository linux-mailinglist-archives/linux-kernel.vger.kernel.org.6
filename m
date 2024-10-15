Return-Path: <linux-kernel+bounces-366339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC5599F404
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8AE6284484
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A779A1F9EAB;
	Tue, 15 Oct 2024 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOX/5/Mh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149041B21AA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729013301; cv=none; b=F4Qb35JxAI8FHzE0v2qXzNki+xqUZGScpXpH8VwgO9gUteLGCrmNhxo6xLyQOfM3KJA8tsRIvDfKAYcFTRb/fZRSM/r9ex2wjjE1OOvKT14wJxqarDDm4HGcwREQPe91reOeUUM3E3gZ3Uf3I4xgdXmZLNHWzH6rJVxoRMZvj8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729013301; c=relaxed/simple;
	bh=SvcSbNOV5T7V2CTtwonfghWnpiklqA3U7lIbuIE4G+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quSyAYt/0vhDpMDHRfzYtIAGj5EcfsPfnNoE1vgAOor3tgj9+4nE7amuHNtWaLQ7iZDG57CTNxuZ8jLdgTKMCZONEHyX2u9Z3n4Zn/BOezjN0eqgIkQfOM8TjOgGfOJdTaw5/cL/237XePDhqLYCfLBL3PoibZUF/SGAvcGCZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOX/5/Mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80785C4CED3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 17:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729013299;
	bh=SvcSbNOV5T7V2CTtwonfghWnpiklqA3U7lIbuIE4G+Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oOX/5/Mh/ly1EsAVemx+gPhlkl/hdlXNmXx6dSD5GuWJQWHvl5golqpq+fjfiE4Xb
	 qevXKTK+h5PjTPFrYw37gVEjUTUzfj8AcapAbWZTg0F89dMQweaW4wGNuF4y1+80cJ
	 OlsIdF/HAGsosdXOIf4vAownWKijVRqCrgZht9A/1dlcu2F1U2PUgPmGQ5AR2SfNQ4
	 w83mq9HwXCQ5OXvyLS8sXtHmMIhXQHQ/11Pg88Z3v+MT1eMf6Uf3WxCUZE5Z16U7Js
	 Wp5QBVbMQ4bQiQnVGVJWQGOcfrtrTXtjtQNslECH136zdOILjf6nUs8JQgx10y0RJv
	 VNlUtA+3oLkWQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f2b95775so3225280e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:28:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWgTD+0GVft6U/DHUiQwrJDOVMDBZONlWUS2edYVgWu8mYwQ6f1upbp6xH3pCKQI1I2ZQwA40vY8E4MIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsUOUbja1H+5RsgU4gXi4GlBB5te9VPS8Z5iMiF7wANn8/i5wQ
	uglL2YNPompy7dVLOGOqi6CUiPN2mUObz2yJglaMPZjOBtk3RO6QgBhsxobR47Tif1+7Jnon4Df
	ln42ZQPrTWg/kAdaoY2xbEgtsezU=
X-Google-Smtp-Source: AGHT+IE5GOsOWQkMJkrj4nhB0GASLO2dOdYEjGu86LFNxJf9a5XL+AzU5hJxbhgWTqIjSR+qZV4yAeu2L86rm2hdapI=
X-Received: by 2002:a05:6512:3f12:b0:539:959e:f0d0 with SMTP id
 2adb3069b0e04-539e54e823cmr8475739e87.21.1729013297829; Tue, 15 Oct 2024
 10:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com>
 <Zw5D2aTkkUVOK89g@J2N7QTR9R3> <CACRpkdY79nbBoaHe6ijuyJS9dDduNw_sv1J90pz121YDgCvC3Q@mail.gmail.com>
 <Zw51fhCkmCYrTOeV@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXEcLD3PWd-9osjo9AOe5Jg-NMOmJ8afB_x7VeboueLoeQ@mail.gmail.com>
 <Zw59x0LVS-kvs9Jv@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXEnhHkxywh8TH1i=fmyAR8cXZ8D-rvV43X-N7GpCf2Axw@mail.gmail.com>
 <Zw6Jk74-d0mhR0jx@J2N7QTR9R3.cambridge.arm.com> <CAMj1kXG3bwMGpArYNUm-qMO7PPgb3--wy5kp-3Ks2Uv9M479xg@mail.gmail.com>
 <Zw6X9KQT0-z7r7SY@J2N7QTR9R3.cambridge.arm.com>
In-Reply-To: <Zw6X9KQT0-z7r7SY@J2N7QTR9R3.cambridge.arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 15 Oct 2024 19:28:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGGmsWs2XpM7zLURjKp67Uz2ePi1pSV1=rPCMgviLVUgw@mail.gmail.com>
Message-ID: <CAMj1kXGGmsWs2XpM7zLURjKp67Uz2ePi1pSV1=rPCMgviLVUgw@mail.gmail.com>
Subject: Re: Crash on armv7-a using KASAN
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Clement LE GOFFIC <clement.legoffic@foss.st.com>, Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Antonio Borneo <antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 18:27, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Oct 15, 2024 at 06:07:00PM +0200, Ard Biesheuvel wrote:
> > On Tue, 15 Oct 2024 at 17:26, Mark Rutland <mark.rutland@arm.com> wrote:
> > > Looking some more, I don't see how VMAP_STACK guarantees that the
> > > old/active stack is mapped in the new mm when switching from the old mm
> > > to the new mm (which happens before __switch_to()).
> > >
> > > Either I'm missing something, or we have a latent bug. Maybe we have
> > > some explicit copying/prefaulting elsewhere I'm missing?
> >
> > We bump the vmalloc_seq counter for that. Given that the top-level
> > page table can only gain entries covering the kernel space, this
> > should be sufficient for the old task's stack to be mapped in the new
> > task's page tables.
>
> Ah, yep -- I had missed that. Thanks for the pointer!
>
> From a superficial look, it sounds like it should be possible to extend
> that to also handle the KASAN shadow of the vmalloc area (which
> __check_vmalloc_seq() currently doesn't copy), but I'm not sure of
> exactly when we initialise the shadow for a vmalloc allocation relative
> to updating vmalloc_seq.
>

Indeed. It appears both vmalloc_seq() and arch_sync_kernel_mappings()
need to take the vmalloc shadow into account specifically. And we may
also need the dummy read from the stack's shadow in __switch_to - I am
pretty sure I added that for a reason.

