Return-Path: <linux-kernel+bounces-320951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C866971269
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1841C22AE0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1931B150A;
	Mon,  9 Sep 2024 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cmT4ASQK"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D441417557C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871535; cv=none; b=JF4BLS1Tj5pIEgsQ+yq1wkBizgxmo2BYPGRQU39B6he+u8vzeBazfnXf+xJ3l3Wk/B85IjRCR8fgqPyko+4+9BboYDhvyxN1i+5O0L1Np3hIOZ6zu2gVVa6fZ54hUpYWMdOtsFb9tu295ZOiSLWj7/cqMcjUbPdGmWANY0bNRzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871535; c=relaxed/simple;
	bh=Am1/QsuH+Xg3d5O7SvGf1SXjExXoXN456fVX4nDf7pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJ8UphNjnIU1jLkSf4Udc72IrauZqzNIje3nxa/Oyqzd3DAOpJozun7R3x7gVv8VJ6YuNyUJgQ5kpaviLpOyJKh0wzxvYVVNb4k2JdPt/5FHLt4tYXIVE3fyYWgwkz5RSCbVtKCWQHVr+3dLyUZ49D+HL6Zv1ShI8S5jLqjH634=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cmT4ASQK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6193D40E0284;
	Mon,  9 Sep 2024 08:45:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Smcyy78yUVRc; Mon,  9 Sep 2024 08:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725871527; bh=cXRkoUjvWWukIVmvh78yiiN7jPJRZwpkNqUTm59HqO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cmT4ASQKWcfjfWlXEKk+u8iG2po9B2WRedjfHPbSDnxtY20l8Cjn9kHpALbjL67yQ
	 3Ev1yk4OPdnSkTO3SIfPbx++/z91dDlsD4eYvI4uprDoCIJFKJJMW3XWFsLrOzCsGV
	 e7gBX9T1o4u2BpanAWGiSa8m9SsieeIiTTzj1sLiwxr8j3fxRv1q9FmxiFOLn9HNoW
	 GWK2HkGXACnGX2leKTMXwagoP08GOOdgkOhqJb9StnOYG6xZQwY/r1cpoyMROQWByA
	 tDImLNBJuvi5VQfow6Z/1e69Yzq+uB1vHyDsIEhemFZFkIkLEBPYXwuWmkNnAnkcOf
	 PbfC/j5MkCEqD8dtwyPzDmpjYmA05nmfZsndbrsc3Jt8nCUk6MaO7xp7u54KCqeEjM
	 7ZTRYT24XiODsSRR1bL8me80E5kl3l7o1E0cEGTglDnwAD71PSTrLyqWJvk0qp+9J6
	 XqL+8RTdC6ZnFDRhS83wMDiAXELuAGFSCM5M8r5j8dqoOVkGdNPYxvzkN2yvlQIZq5
	 k3QdRRONsbXXroNIvEW8GpS8DicMPxHcVT3+UzA6nkJ1vUmHH13vdQbtren4J9z83s
	 GrJ82j8vDsX1KN5dTFuexmW95sdxTRxVLJiPanfWTo3I1plq+2neqaGPSfif2TOGj5
	 nTfnCtaxVeZLChwhjDyIhZAw=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 19C4F40E0263;
	Mon,  9 Sep 2024 08:45:13 +0000 (UTC)
Date: Mon, 9 Sep 2024 10:45:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com,
	Yannick Fertre <yannick.fertre@foss.st.com>,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: dw_mipi_dsi-stm.c:(.text+0x8db9a3): undefined reference to
 `clk_hw_unregister'
Message-ID: <20240909084506.GBZt61kqqGVUTqjKc4@fat_crate.local>
References: <20240905081902.GAZtlpdlQp5XOm5XtO@fat_crate.local>
 <544a633e-de53-493d-9c29-de8ff52630da@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <544a633e-de53-493d-9c29-de8ff52630da@foss.st.com>

On Mon, Sep 09, 2024 at 08:57:57AM +0200, Raphael Gallais-Pou wrote:
> Arnd Bergmann sent a patch regarding this issue on x86 that I merged several
> weeks ago.
> 
> https://lore.kernel.org/lkml/20240719075454.3595358-1-arnd@kernel.org/
> https://lore.kernel.org/all/c3d0757a-07c0-4f83-9f06-c3ad205aa1e9@foss.st.com/

Thanks.

> Now, I'm not familiar with PowerPC architecture and toolchains, but I think
> this patch should fix your problem.  Do you have the above fixup in your
> tree ? If not please try it.

Not PowerPC - it is an x86 build. I do random config builds as part of build
testing and when a driver depends on COMPILE_TEST, it does gets built in some
.configs. So some may fail, as in this case.

So I think you should send that patch to Linus now so that such randconfig
builds do not fail anymore.

Unfortunately, I cannot test it right now because I've removed the triggering
randconfigs but when I hit it again, I'll make sure to apply yours.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

