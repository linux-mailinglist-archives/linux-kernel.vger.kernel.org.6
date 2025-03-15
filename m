Return-Path: <linux-kernel+bounces-562308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA68A62285
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 01:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DCC7174F66
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B835963D;
	Sat, 15 Mar 2025 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyqmXb9a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239AE366
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 00:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741997223; cv=none; b=Cuj41u+jV6tYXdCEtGEjVe7P0vBw7l1hMgFAzjFlMmOi+qMdOhferEM1x4invgfSAYlWThE0YsMEUavOlqbYii232ZF2yQu2yWyNaZjdzN/3MHewwi62EkZRCAOB2ysrV4u97W+PknCpA+sgbay6I8uvps9i/A/az9j9QGF8YGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741997223; c=relaxed/simple;
	bh=bZ7A4wajyX66jPBK03q5XKQr1foQe3MxppwMvG1y+u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqAjdbTt+sTTvUNigRgzUrL8yqTOcHiteTADrpsQNtWn/ej/OXorJXvG/rTN2MGuTfJHWkTll10Ub4ILVtSkVrpHgc/BQQqpGgqQDXeewxpcrfnInEueOXRGBGhl9iWD2mExygAEcVe9LhjHT8H/JRMPD+5uOnic8uN3G+ju4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyqmXb9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7767C4CEEB;
	Sat, 15 Mar 2025 00:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741997222;
	bh=bZ7A4wajyX66jPBK03q5XKQr1foQe3MxppwMvG1y+u8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AyqmXb9aMuZe2m9YoYIMZ975fO4EQ49ALAg9F3zFuF3rf8TT9kEF7bOsOlt4bxyXz
	 3Cm64kL0bD8h9EKdK2zCLnzhC3HW005PX0sylVfjy956b635pC5yr3+UFaCXAVjDmz
	 gr7tKVZ0DlDILVqEVCmOnPPwgq+SryXKl7KwJUELM293nfTetH3zqNJ0A6GSvzjsrQ
	 3KTv0L9moPNSKM377zgOOxvRNrVkhSugk5al59V6zCtx8bYA1NzQwOgR/evBB1qVBq
	 Lzhdv0wLsaSUs4+fGJQSBTzejT+zUFFT3ow5XbDne1J//IX+Zu9vG+r+souq8kIBUv
	 Q+X9Zv+GYVrjQ==
Date: Fri, 14 Mar 2025 17:07:00 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 04/20] x86/cpu: Use named asm operands in clflushopt()
Message-ID: <gor6hi6lzohdo6hfcffmxdzc4fiqdn2itncxatw4zkhouzmm6l@obz43xcfcl2i>
References: <cover.1741988314.git.jpoimboe@kernel.org>
 <c007f4ddbfdfe92777a7df35bc121cf9bf0d0682.1741988314.git.jpoimboe@kernel.org>
 <CAHk-=wjBjq6u+r9KGTHQ5nOA1L2TDhz0JPL_+eE07un9y9Qm-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjBjq6u+r9KGTHQ5nOA1L2TDhz0JPL_+eE07un9y9Qm-w@mail.gmail.com>

On Fri, Mar 14, 2025 at 01:46:00PM -1000, Linus Torvalds wrote:
> On Fri, 14 Mar 2025 at 11:42, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > +       alternative_io(".byte 0x3e; clflush %[val]",
> > +                      ".byte 0x66; clflush %[val]", X86_FEATURE_CLFLUSHOPT,
> > +                      [val] "+m" (*(volatile char __force *)__p));
> 
> Hmm. I think we could just use 'clflushopt', it looks like it exists
> in binutils-2.25, which is our minimal version requirement.
> 
> But maybe that's a separate cleanup.

You appear to be correct, I'll add a patch for that.

-- 
Josh

