Return-Path: <linux-kernel+bounces-524754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEC2A3E6B5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0100317F3BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C075226463B;
	Thu, 20 Feb 2025 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr/jFqhM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D87226461B;
	Thu, 20 Feb 2025 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087227; cv=none; b=WQDKKcQIZTlenVUTqJ9ZsJrdKc6Om0/QUoRD0Kn+EsWrPiWsp3AVK8ugEE+/8M1LUMAcXOTAzUWl/SuXuf8PbSF4SuL7NFpadD2yW8px34JuvPOJzSvasbm/slfbGoUjjpdjuUxzjrzqeCMQ1+3tCLvFpqyTvR3yEhW7RsJ5BYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087227; c=relaxed/simple;
	bh=RoVzIYQI0Sz67H8m1YsKGIZn7Z2NnixLo6bTVb4oSmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgDRyYyaQpXLgFvTY2VvrMUrj5Dp1ugr6QZht+ls34rse37rD5ZByGU8rII9Sya1j6JkHioSRGZMWZPZSm2JpvY8z/F4IPQinWDEsrnuKvYurS8hi91VL/puC/ZjDAywfESMEG4uMBwimd054lw2YfmCfnzvQbZhS6QoNyVbgWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kr/jFqhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFA0C4CEE3;
	Thu, 20 Feb 2025 21:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740087227;
	bh=RoVzIYQI0Sz67H8m1YsKGIZn7Z2NnixLo6bTVb4oSmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kr/jFqhMsC41D9nQAnzIGStdkhH3ADbWwcO9Oi/kVJja8hI69c84MTb0dHUc03grP
	 0ZTAldeyL/P7wHhOX/j00y1W/g7UrI0QZc7XRJMwPNxg5mR0c8Z5OCwAxY2ROq+Oxt
	 fagY1+MmUWjXtLjejAy4uZFoOXsBLRM9vJ/bqtUmZHUxOi10z51PW0Dgf6E+dGJxPW
	 tXCqgOu63lzPKNMkyDUdR+Z2Jvrl1uXTwo04f2dEx7nGpSP2fjiI7FcM/bT3aYW/lE
	 oNqzErJqTHCM4ybHSDZ1Ojk2vQQ+c+H70OULvAowUkhUAdmgORn82c3cGPuj2xPkqC
	 luVzY6MAo8cCA==
Date: Thu, 20 Feb 2025 13:33:45 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/9] Add jump table support for objtool on LoongArch
Message-ID: <20250220213345.6bbca4eqethbvzwp@jpoimboe>
References: <20250115013444.anzoct6gvs56m225@jpoimboe>
 <4612bfd8-442e-fecb-240f-46e735b48540@loongson.cn>
 <20250210212653.oidcl4aqyrcu3yzi@jpoimboe>
 <CAAhV-H7MVDj0CbXfwveb7GDn+D=O4N6oUT6rpGrbGmYPLPpRPg@mail.gmail.com>
 <20250211233056.q47mp5askk7qrxcp@jpoimboe>
 <CAAhV-H563HcK2bck2k+VLTvrf0C7=cEMr8BJpQhFdJNc+dFOUw@mail.gmail.com>
 <20250213025108.svqgj5nzseqs6qox@jpoimboe>
 <CAAhV-H5mYGnxHPxAeXkHo2XBvi-RtPjDQRBnDiDyKVtFv-ZBBQ@mail.gmail.com>
 <20250218174632.gwseuvgezj7eni2j@jpoimboe>
 <CAAhV-H4Vwhsrp-y=pLa6xh=nVEOZy4wu2mPj00ES=OjsM7vruA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAhV-H4Vwhsrp-y=pLa6xh=nVEOZy4wu2mPj00ES=OjsM7vruA@mail.gmail.com>

On Wed, Feb 19, 2025 at 05:49:01PM +0800, Huacai Chen wrote:
> > Looks like that's not going to work.  Without patch 7 I'm getting a
> > warning (upgraded to a build error with a pending change to upgrade
> > objtool warnings to errors):
> >
> > arch/loongarch/kernel/machine_kexec.o: error: objtool: kexec_reboot() falls through to next function crash_shutdown_secondary()
> > arch/loongarch/kernel/machine_kexec.o: error: objtool:   kexec_reboot+0x1c: (branch)
> > arch/loongarch/kernel/machine_kexec.o: error: objtool:   kexec_reboot+0x0: <=== (sym)
> > arch/loongarch/kernel/machine_kexec.o: error: objtool: 1 warning(s) upgraded to errors
> >
> > And that would break bisection anyway, so that really needs to come
> > before the others.
> OK, then please take the whole series of V7, but please exchange the
> order of Patch-6 and Patch-7 (I think the enablement should be the
> last for bisection).
> For V7: Acked-by: Huacai Chen <chenhuacai@loongson.cn>

Ok, but to avoid the warning, patch 7 needs to come *before* the objtool
patches, so it will be the following order:

LoongArch: Convert unreachable() to BUG()
objtool: Handle various symbol types of rodata
objtool: Handle different entry size of rodata
objtool: Handle PC relative relocation type
objtool/LoongArch: Add support for switch table
objtool/LoongArch: Add support for goto table
LoongArch: Enable jump table for objtool

-- 
Josh

