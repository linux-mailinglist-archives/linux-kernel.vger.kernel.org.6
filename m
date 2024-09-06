Return-Path: <linux-kernel+bounces-319067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE0196F744
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB36285D5F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1731D1F53;
	Fri,  6 Sep 2024 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hdkchmhx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861CA1D174E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633973; cv=none; b=PuL1vIwLbJqCM3Iv+0qCGmohdHlUGYmMg0JC4PWzDsMq7j7SD0Dbi708r2v3GYRdxo22Pr65nCBHhnoXdOru+Q18yEXlsXB463+5j1iEcVFvfzLnn9X6H4CCz/E10TDb7RljkzmoIDrbSTzwHBPZIYuQiK7ZdVhPcRMCLywQzDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633973; c=relaxed/simple;
	bh=udaOxyKy9/nPsTjW0mxcicQ00+GeYV6skDpP5PBTHro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8F3BQviUIVCZ/lKxX/LPk7bqFx46akINsv0UDM3aA97hqR7+I8idGY4SQ82eMqiMDB94jm8MfWPa8OXdAPI3miiTU7veTHuplGMKCIyIBDkzBzL3u1u4WnqnwZwVhGwqiAsr6vpy1CxsRioQ+uUVxXhh1AXV1j9usqLYTCOPRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=hdkchmhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C37EC4CEC4;
	Fri,  6 Sep 2024 14:46:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hdkchmhx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725633970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LQaqdd4gn6hwyJ6X/+wp06IeAX1AuCwE2tKJcvmByYs=;
	b=hdkchmhxBGCbaIA9Ddy8tLE2V3TigvEtRRSSeTX9BsM7QQ4qIJuX0ADLJbDVgWmYlSonvd
	Bz0qYCzSkg8NdulUBcB2nO4r2j8iwwSNGQko0n9UdoJdiRM6FT6m7IIdYnvEifxsZ47cna
	AwAA+oz9pguT0Yk6OmB338aNuSS3wI0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 89574607 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Sep 2024 14:46:10 +0000 (UTC)
Date: Fri, 6 Sep 2024 16:46:07 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 2/2] Fixup for 3279be36b671 ("powerpc/vdso: Wire up
 getrandom() vDSO implementation on VDSO32")
Message-ID: <ZtsVry_LL2jjeLJ3@zx2c4.com>
References: <700dbf296d02e32376329774be35cfbead08041d.1725611321.git.christophe.leroy@csgroup.eu>
 <ffd7fc255e194d1e2b0aa3d9d129e826c53219d4.1725611321.git.christophe.leroy@csgroup.eu>
 <ZtsMpcV7iLYoytdJ@zx2c4.com>
 <795db5f1-c266-4fb3-a51b-c2b3745d334b@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <795db5f1-c266-4fb3-a51b-c2b3745d334b@csgroup.eu>

On Fri, Sep 06, 2024 at 04:26:32PM +0200, Christophe Leroy wrote:
> And thanks for playing up with it while I was sleeping and getting ideas 
> too.
> 
> Did you learn powerpc assembly during the night or did you know it already ?

I don't really know ppc assembly. I had perused the tree over the last
week and gotten some feel for it when reviewing patches, but I don't
have anything memorized (except, perhaps, the eieio instruction [1,2]).
Last night after sending the first broken patch I went out to play (I
play jazz guitar ~every night these days), and the whole time I kept
thinking about the problem. So first thing I did when I got home was try
to fake my way through some ppc asm. A fun mini project for me.

[1] https://lore.kernel.org/lkml/Pine.LNX.4.33.0110120919130.31677-100000@penguin.transmeta.com/
[2] https://lore.kernel.org/lkml/alpine.LFD.2.00.0904141006170.18124@localhost.localdomain/

> At the end I ended up with something which I think is simple enough for 
> a backport to stable.

It seems like a good patch indeed, and hopefully small enough that
Michael will let me carry in my tree for 6.12, per the plan.

> On the long run I wonder if we should try to find a more generic 
> solution for getrandom instead of requiring each architecture to handle 
> it. On gettimeofday the selection of the right page is embeded in the 
> generic part, see for instance :
> 
> static __maybe_unused __kernel_old_time_t
> __cvdso_time_data(const struct vdso_data *vd, __kernel_old_time_t *time)
> {
> 	__kernel_old_time_t t;
> 
> 	if (IS_ENABLED(CONFIG_TIME_NS) &&
> 	    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
> 		vd = __arch_get_timens_vdso_data(vd);
> 
> 	t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
> 
> 	if (time)
> 		*time = t;
> 
> 	return t;
> }
> 
> and powerpc just provides:
> 
> static __always_inline
> const struct vdso_data *__arch_get_timens_vdso_data(const struct 
> vdso_data *vd)
> {
> 	return (void *)vd + (1U << CONFIG_PAGE_SHIFT);
> }

It's tempting, but maybe a bit tricky. LoongArch, for example, doesn't
have this problem at all, because the layout of their vvars doesn't
require it. So the vd->clock_mode access is unnecessary.

> Or another solution could be to put random data in a third page that is 
> always at the same place regardless of timens ?

Maybe that's the easier way, yea. Potentially wasteful, though.

Jason

