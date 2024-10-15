Return-Path: <linux-kernel+bounces-366252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D74199F2B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC104B21356
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F412A1F6677;
	Tue, 15 Oct 2024 16:27:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291E81EC006
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009672; cv=none; b=SmHGJ92VWv+ioRCrnVjnd2VC87FfwPFqALXuOuCj838UT6idoL6QLzcjrBExcIrbnywBjMczPIEXLvzhtv/ghlFQJDKKbe0KonYGObDwOAXcR+4Rt6QzkjVgHwIcw/nANnds94j2nEU5Nlfg4BN2xpNT/qLJJzDjQ8L4NR2T2Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009672; c=relaxed/simple;
	bh=of7g9E0gG9fv6n5gnyfrrVsPY8yP+rhfejlab2z226A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmxJ1laKUccOppIL8TWVqGM9LyabvsHnxO+qB20GwRzfyTagyT0EcMrQI1WnW6XKEZiqoUUvF3z1UV8fUm1qC9pfd6wZljh5Qd4a0He9EBQYFkP038d2fC76crwAdFPp0K0M4untoKJbzcpC83G+6jw1wmJElBBrzkhDfR5urfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD8101763;
	Tue, 15 Oct 2024 09:28:18 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 131043F71E;
	Tue, 15 Oct 2024 09:27:46 -0700 (PDT)
Date: Tue, 15 Oct 2024 17:27:32 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Clement LE GOFFIC <clement.legoffic@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Kees Cook <kees@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Antonio Borneo <antonio.borneo@foss.st.com>
Subject: Re: Crash on armv7-a using KASAN
Message-ID: <Zw6X9KQT0-z7r7SY@J2N7QTR9R3.cambridge.arm.com>
References: <a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com>
 <Zw5D2aTkkUVOK89g@J2N7QTR9R3>
 <CACRpkdY79nbBoaHe6ijuyJS9dDduNw_sv1J90pz121YDgCvC3Q@mail.gmail.com>
 <Zw51fhCkmCYrTOeV@J2N7QTR9R3.cambridge.arm.com>
 <CAMj1kXEcLD3PWd-9osjo9AOe5Jg-NMOmJ8afB_x7VeboueLoeQ@mail.gmail.com>
 <Zw59x0LVS-kvs9Jv@J2N7QTR9R3.cambridge.arm.com>
 <CAMj1kXEnhHkxywh8TH1i=fmyAR8cXZ8D-rvV43X-N7GpCf2Axw@mail.gmail.com>
 <Zw6Jk74-d0mhR0jx@J2N7QTR9R3.cambridge.arm.com>
 <CAMj1kXG3bwMGpArYNUm-qMO7PPgb3--wy5kp-3Ks2Uv9M479xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG3bwMGpArYNUm-qMO7PPgb3--wy5kp-3Ks2Uv9M479xg@mail.gmail.com>

On Tue, Oct 15, 2024 at 06:07:00PM +0200, Ard Biesheuvel wrote:
> On Tue, 15 Oct 2024 at 17:26, Mark Rutland <mark.rutland@arm.com> wrote:
> > Looking some more, I don't see how VMAP_STACK guarantees that the
> > old/active stack is mapped in the new mm when switching from the old mm
> > to the new mm (which happens before __switch_to()).
> >
> > Either I'm missing something, or we have a latent bug. Maybe we have
> > some explicit copying/prefaulting elsewhere I'm missing?
> 
> We bump the vmalloc_seq counter for that. Given that the top-level
> page table can only gain entries covering the kernel space, this
> should be sufficient for the old task's stack to be mapped in the new
> task's page tables.

Ah, yep -- I had missed that. Thanks for the pointer!

From a superficial look, it sounds like it should be possible to extend
that to also handle the KASAN shadow of the vmalloc area (which
__check_vmalloc_seq() currently doesn't copy), but I'm not sure of
exactly when we initialise the shadow for a vmalloc allocation relative
to updating vmalloc_seq.

Mark.

