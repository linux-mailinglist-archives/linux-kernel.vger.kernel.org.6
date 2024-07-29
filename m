Return-Path: <linux-kernel+bounces-265421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F60F93F0DD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB8FEB21183
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B72A13E039;
	Mon, 29 Jul 2024 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TpUEkn8C"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D69D13DDCC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244883; cv=none; b=mwke2mesBTBpePQEZhMbOQRKwooEjIr6s04ohbHNFcMV1XtxmG1ye0wH1B/Ut1pd8yoo9cf9jHlflvYVbE7j5vowREg/vKdIL2ckbXOp3smfvmOfGc2gg/xH0FxImbnfSgJJYXmXTXBqi04yQA5FoKfs5L1mZ6/zVnAnnOfRadQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244883; c=relaxed/simple;
	bh=wdH24kndMVx8PfW4zk0n7/2Blacu0Xbz2/cYCuxgUdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdd3lrbhI6QMZTnMH+cft7sswBM4wXmUGlsFfQGE2wIBXMisPkOxSFxQUo1AkahAgLlS/BuNhFtWQctNvqRLMbkDmHLbSAwwfovo7eKdrDSAIKdFxiaFRFGnkMVhj2+NAKIooCTwxNP/8fbpNbYJGK5SdyJrJbqcuVmXO0xSyIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TpUEkn8C; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EDF7840E0185;
	Mon, 29 Jul 2024 09:21:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FMVcALq_nEzJ; Mon, 29 Jul 2024 09:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722244876; bh=WUhgRVSXMYMF2xk9qkzoRJxpqm8e3AsuCfaP30+d2Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpUEkn8CSaWmAI2Y99GiaJDEW6/zcubLU+1g+Y6pIGJM6qvj1gtQv36iKusuR4kFb
	 5dy/8jVouIpIU4Z3ICVsucvMd21YjTTe64OBJAw3qLOmcEIl2+d8fETIAbZzcBRGzD
	 0VpC0dFA2OLgFgauVJN3DPNaUfXUlbjOYphcz4CLE8JaFjt0oUn/lTJTzeFIfZgfjY
	 N1oKGyU2aob3ZfTVe2o8arekrdKvsfW7PKCAY5eqjNq0IRHvouNOoBkTd2igM/pQ6o
	 OXjBQ1kZ6KPcil8hEDlpMoC3A0UBz63bJdu9Dz4b1sw/IneTxzFRJZ2wyAY6C2r0sf
	 ZAHC00fKRCChNNbAUBFd3Ku7+ER/IUEKphTj9lQevXSHZTIqewdyam7NWLUD9J+cxb
	 vPZBNYOjdIxAUMOrihq8jVusZiAanXnu6TyTHBRdbRh3k/y0kCW7FtzKX8M6daAGaR
	 FaEqD/xZEeiCyX4ncJYa5ndi/iffcKFn5VfN4K5izF/eUUqO9GyYaYf9uyv4A50FDQ
	 evPkW4loNbK7p6HBpDvpA036tpzcYKvvNsMN30U34L3d7yMRTKePbsNb/ZlLbscyX8
	 sOJUCowJ02FudEbfeXBh8j4GGW2S3iNgBtupOQPy2s+cU/gkd9mPDLYVUJtDHUAAnJ
	 KZUUeoTCXJd2MX+8zgvglkkc=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D184D40E019C;
	Mon, 29 Jul 2024 09:21:08 +0000 (UTC)
Date: Mon, 29 Jul 2024 11:21:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Breno Leitao <leitao@debian.org>
Cc: jpoimboe@kernel.org, mingo@redhat.com, x86@kernel.org,
	tglx@linutronix.de, linux-kernel@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com
Subject: Re: [PATCH v3 00/10] x86/bugs: Separate config for mitigations
Message-ID: <20240729092102.GAZqde_tdP_Ca-chhl@fat_crate.local>
References: <20240422165830.2142904-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240422165830.2142904-1-leitao@debian.org>

On Mon, Apr 22, 2024 at 09:58:14AM -0700, Breno Leitao wrote:
> Breno Leitao (10):
>   x86/bugs: Add a separate config for GDS
>   x86/bugs: Add a separate config for MDS
>   x86/bugs: Add a separate config for TAA
>   x86/bugs: Add a separate config for MMIO Stable Data
>   x86/bugs: Add a separate config for L1TF
>   x86/bugs: Add a separate config for RETBLEED
>   x86/bugs: Add a separate config for Spectre v1
>   x86/bugs: Add a separate config for SRBDS
>   x86/bugs: Add a separate config for Spectre V2
>   x86/bugs: Add a separate config for SSB
> 
>  arch/x86/Kconfig           | 117 +++++++++++++++++++++++++++++++++++--
>  arch/x86/kernel/cpu/bugs.c |  46 +++++++++------
>  2 files changed, 140 insertions(+), 23 deletions(-)

Ok, rest looks ok. You can send a new version with all feedback addressed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

