Return-Path: <linux-kernel+bounces-316609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283F896D1E2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B27B1C23848
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C93198E80;
	Thu,  5 Sep 2024 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YI0oukfI"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4A7198E77
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524388; cv=none; b=nRzNJCbuLBCnTVkUZc2s8PJhmltLs/e6fvSEMxfsm07BNNhX7atxYfKTJfeZ51a09YT9++umOUohDU7Ofq61mDtNo6yDvEV+o8FYysV8ETZKVKqcl1vjRjTB9yDW5YV7yd23hzuujhH1r9Ag/D6t44ej5f92ptjFnBowv3rzy6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524388; c=relaxed/simple;
	bh=RnFjPmD0d3mK1TMt05FOAr8yRd8QI/RzdLwlySfqFFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lcdv+Z+kFtPqktVN4aYitV4c3YP6Zl765850sIjEe5rV9nAq4T5l4/Chi8nUolk/2IhNBgq/cB2q4lQgpvmTP5s8T9+JwVJ44OHDJZMG74CkcS2qFrPM9Pv3zTLNx+XyQJDcqSLuCkPEV/+riyGkAm6Z1hhYBr/c4wOOgLYAyXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YI0oukfI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EA03A40E0284;
	Thu,  5 Sep 2024 08:19:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id j-7o-7WItxvG; Thu,  5 Sep 2024 08:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725524372; bh=R5dGDsP5UUAqve48fbetJtWj/XRQVM4kjtwcRHxLMAQ=;
	h=Date:From:To:Cc:Subject:From;
	b=YI0oukfIcBgEqX45/5eMWLqZrS3JiUd4miyhCLXBj5TzeHrH66qLAP4+Qd+5mRNBP
	 85oxAJO4MrFF1i5si0nCbjH/YhagZQYcGj97gJsHSNcw44iRLpyDzqhMt8QC/p/ZTM
	 J7rCC4CZ7lo7Ejeu/G5nMPzSupQHQojfS4skVYNXA/BuHCOyY4TF1rQ9VamQwR4hqa
	 NClV6N5oKL5UiKycbIkz9lv6rlNgIsa1RkWy15W8e8ZZeLnl5HSJdGgqP0VX3SsJZA
	 XkpelkbTyMTfU5ZJagmE/T6+rQyIptw+nJy2bX4hLT1iva1ouAY28XGLwqDUO+a8Bb
	 jS4fFCa4CskATy1EJenpNXZfAm7AfInhMv/wHlLzACOy++IuVv6mxAD6xsT3Bagc7g
	 1mSKV/eSFpXQCrX1Vi/idqn9/7KhaiML5dE4emN0G8/fiP2F5spPINCs8SOzqU1dP4
	 h5QaLfZNc/9nTbf3TEsExuPcIpsEivDY6BGufLdtttcaz1VD3tQiFzNXCUXdaS8RDH
	 ImBkjTArDnHiKbynZKTQXEhx96onu6Y2/VYOmyTzPXI0T2ywf95rIfUsVMfr267UYo
	 OrJcSsCvRPTWiY/I1eZOG2cJ93dMJc+azmqaK65c5rZ8vXzUcSus6yHQ9FPyqQdSdP
	 iPO8kZ9XMo1/vJSkpcH0tzbs=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A61CF40E0275;
	Thu,  5 Sep 2024 08:19:18 +0000 (UTC)
Date: Thu, 5 Sep 2024 10:19:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: linux-stm32@st-md-mailman.stormreply.com
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Philippe Cornu <philippe.cornu@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: dw_mipi_dsi-stm.c:(.text+0x8db9a3): undefined reference to
 `clk_hw_unregister'
Message-ID: <20240905081902.GAZtlpdlQp5XOm5XtO@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi all,

this fires in my randbuilds here:

vmlinux.o: warning: objtool: adis16400_write_raw() falls through to next function adis16400_show_serial_number()
ld: vmlinux.o: in function `dw_mipi_dsi_stm_remove':
dw_mipi_dsi-stm.c:(.text+0x8db9a3): undefined reference to `clk_hw_unregister'
ld: vmlinux.o: in function `dw_mipi_dsi_clk_register':
dw_mipi_dsi-stm.c:(.text+0x8db9f5): undefined reference to `clk_hw_register'
ld: vmlinux.o: in function `lvds_remove':
lvds.c:(.text+0x8dc605): undefined reference to `clk_hw_unregister'
make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
make[1]: *** [/home/amd/bpetkov/kernel/linux/Makefile:1156: vmlinux] Error 2
make: *** [Makefile:224: __sub-make] Error 2

is there a fix somewhere?

People love to do

	depends on ... COMPILE_TEST

but then if no one takes care of it in time:

https://lore.kernel.org/oe-kbuild-all/202407212000.rpDH64jP-lkp@intel.com

that COMPILE_TEST thing is forcing me to simply blacklist it and is not really
helping.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

