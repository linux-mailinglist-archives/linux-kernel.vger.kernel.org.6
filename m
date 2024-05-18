Return-Path: <linux-kernel+bounces-182742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7B28C8F3D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 03:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4EF0B21733
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178257464;
	Sat, 18 May 2024 01:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6T21Bfu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576CC6AA7
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 01:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715996823; cv=none; b=ccm+u122CHjgdpTspNcSyFDvpy2Vk21b1giC5LzwoKYyg1OFpsjuoTUDSp2mk0yE6AuMVkytGNjBPn+HVTI1wn7RPfSkiCHYvMvSUQm6W3OyTehMrsXWOeMg4+Mp1+hg0TlOy1R++9KU8RcG8SOUCzHF6/Mhx68Xb6SykZH+2VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715996823; c=relaxed/simple;
	bh=3w6erTs0VsX7bzWfjAMEaC++hcnvOlzJH8P9cpgslP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbCcKerxOpkZaspJOXyfOGtx1RIjdSk81xagDIXQt7jF6tumlqtprMsWXqVPD3wpioddaysuFiVDMXBNA9BG6TRWJUSrIh3h3KAic7YXS7MTqWJWifb2aUBZEGLw0B3qYJagSvYYQCoYKW/RHkaOr82dsFW3Gmr1GpIF73fhIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6T21Bfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE7AC2BD10;
	Sat, 18 May 2024 01:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715996822;
	bh=3w6erTs0VsX7bzWfjAMEaC++hcnvOlzJH8P9cpgslP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m6T21BfuczDC0ek9BVTgqbC60ygfqSCLkGGhUqbS+cU2WsOTHdwekPmYeKkC63/PA
	 CIPKJcK9CCPyN5ApX4ssUQrZsAowwXtZWCnWzVKQ4oxruGvsUKj5+ezj/jfLJfI3WX
	 m9pztPMF6Elvy98zANXox3knqQGsu4QBAImGvFzwc3Ep9exr3dIxVzSq6Ujf1GbXFY
	 cRnxMaF5ulrY1nyohqyqkkkr7scGVPatlNmhSuSSRKwJDmAd7+NPBRamhwF7z1i+yT
	 frtzIH7BBeLxrGFWl68+cIM7klsMTKPGcjThv+DXAtHQaO8+pjIR9hw+AYUGDSYNmU
	 Bfv8t0xnCSTnw==
Date: Fri, 17 May 2024 18:47:00 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: x86@kernel.org, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: select ARCH_WANT_FRAME_POINTERS again when
 UNWINDER_FRAME_POINTER=y
Message-ID: <20240518014700.3aieomeev4s4rq3a@treble>
References: <20240204122003.53795-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204122003.53795-1-masahiroy@kernel.org>

On Sun, Feb 04, 2024 at 09:20:03PM +0900, Masahiro Yamada wrote:
> It took me some time to understand the purpose of the tricky code at
> the end of arch/x86/Kconfig.debug.
> 
> Without it, the following would be shown:
> 
>   WARNING: unmet direct dependencies detected for FRAME_POINTER
> 
> because commit 81d387190039 ("x86/kconfig: Consolidate unwinders into
> multiple choice selection") removed 'select ARCH_WANT_FRAME_POINTERS'.
> 
> The correct and more straightforward approach should have been to move
> it where 'select FRAME_POINTER' is located.
> 
> Several architectures properly handle the conditional selection of
> ARCH_WANT_FRAME_POINTERS. For example, 'config UNWINDER_FRAME_POINTER'
> in arch/arm/Kconfig.debug.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Looks good, thanks for fixing that!

Fixes: 81d387190039 ("x86/kconfig: Consolidate unwinders into multiple choice selection")
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

