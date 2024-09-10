Return-Path: <linux-kernel+bounces-322961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F199735EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8048C1F265D7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB8714D431;
	Tue, 10 Sep 2024 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="h1euPbz/"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D03318C324
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725966432; cv=none; b=S+vZev6XsWutasYSxmdrvjCwZ/d32ERH6LcpefWHs3Xrxzs7eZa+sVWWWZeoX8xrL46Bv83v9HbRb63qZDNi0JuigJpOTB0kBAG9qniAzKJsyJCd8rdi8NcoY5TEn5NR4eg6gzJvHkjL0/JcOfi2/wdk58N9nTIIe3qIXtDZC6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725966432; c=relaxed/simple;
	bh=4j88YUU+NzRUvqlo7ArzeVxf988a3WA/7mwo5NDAFLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hud+wY1aw8fjR/brE0h+rN8IEwj2qoPlLzRf07gdXV7iaKKwvIRHKmSwJv6MMqXWA45A2tAoeccBhtHDU7E7PqUzxIr8P2Ot7u1K7b91upDlEPdlGiImlu5JRXqQK/o8lowKZd08GEIZ0/XtvlBSrxnaKEf2/2EFivnsY3SgLL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=h1euPbz/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8128C40E0285;
	Tue, 10 Sep 2024 11:07:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qrGWVqrTr6ZO; Tue, 10 Sep 2024 11:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725966422; bh=q7/7i/hleCHmeIelV+J/jkKAUyMAdVAI7TwF0D/iof4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1euPbz/eINJg26bo1VdAuCGL3YtT4WXke/s/QTbdUBNuaw4tN4CZ2Tmwg7p4jGrx
	 XOrZ1Xbpw3qhbn77G5Igcv5fYT+S+6uiE5sTP8nx+qOoSK22Y9s1QGQhszVhQTlqvZ
	 XeWOGIsqIMyMmgKYujxQO/9aerou17O6fY6rmGm6fQEm81kDLJ8ub8rUWE/lR8tYiu
	 qsuFZQ4h4iVZKFTgoPnTnYfPQQajXawwBusQNj+z9DEprwXor4oNiT5trlmEzjVqXO
	 AJfJQu5usxw27FxDDFy2XRTRQSfguyIOC3VK+g1jkrGnKkvo3mud8NlPuLkkutJ6yN
	 H183fcPIn54bti3UYfOsqDvQXv21LJsuvhtySTvjhXO/vCc6T9ypjtTf79gjYbvea4
	 WN41/pCIA+Sutaigak2gTF7//QjGVuP8D35AuD2TyJ83/la7RGt1MhawAV7paR2f6Z
	 wlYaCF8+xUWqsXEKTcJ6+e9Dxae+rMN79LkY17PpWBCZG9TjqdXa5LeRLsLqobHXYQ
	 S/DZjwPJsC/1cLTT9SQ3CGgqs45SE7Gd/c4KKJhibWXGjCd4MJL17ovU5O0pj6nzs1
	 GXilzgnSdSObcBPWsf2F5ugfx+owoNuu6uxoj8iQfRgKyEU1rdJHfArG4Y1zDxFeJQ
	 rllAmw1rHXWh9frbC1OqTDQo=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C421740E0081;
	Tue, 10 Sep 2024 11:06:47 +0000 (UTC)
Date: Tue, 10 Sep 2024 13:06:42 +0200
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
Message-ID: <20240910110642.GAZuAoQnZqcr98x5en@fat_crate.local>
References: <20240905081902.GAZtlpdlQp5XOm5XtO@fat_crate.local>
 <544a633e-de53-493d-9c29-de8ff52630da@foss.st.com>
 <20240909084506.GBZt61kqqGVUTqjKc4@fat_crate.local>
 <0e9018d0-c49f-4dac-aa0f-b05504f9c6f6@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e9018d0-c49f-4dac-aa0f-b05504f9c6f6@foss.st.com>

On Tue, Sep 10, 2024 at 12:48:49PM +0200, Raphael Gallais-Pou wrote:
> Unless I am mistaken, the link you provided refers to a PowerPC linker error:

Ah, the kernel test robot is doing other architectures now too, sorry about
that. In any case, I am triggering it on x86 too.

> What do you mean by 'sending it to Linus' ? If you meant to do a pull request,
> then no. This patch is already in the drm-misc tree, which means it will keep
> its usual pace of merging with the rest of the drm-misc tree.

That's ok - I'll simply disable CONFIG_DRM_STM from building in my randconfigs
for the time being.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

