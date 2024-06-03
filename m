Return-Path: <linux-kernel+bounces-199350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C938D85E3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DDF282A5F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CB512FB0B;
	Mon,  3 Jun 2024 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IoRfee5w"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D8D6E619
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427945; cv=none; b=l0OgHULzJmNx1Z13lKNbfUeUDJcBS/6d2EHd4hV31/s7PbVQN6IqT45XTpEua5CH/tDDdb8F9NrdBtbuLrcm/xWyc+X6Q2U540Py4vEXI+396F7Xoghkx3M6KYVxDca/O/gTX85rC3DsRJPVWzdQhGVE1ecD5cojVPalfMr+kI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427945; c=relaxed/simple;
	bh=WrF1PqVK7BBRiK2Msk3KzTt3BWtdAC/HrKmBU9+7HSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXWh/Dw978y3FX7JuhQdlz7pDiWLVtBFfLuDAPJS3CYCTxUIa65kMvT34mtUwHBpNyxvky0rGz2IckNFsCKJPRM+1tD2AVLCyXjn5WMmkAw4BtBrTLMv6BXz5jeyIGgP00/rGA+8UxjGpe06FiO+3pAjC/eHyxut+JACPv/dAks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IoRfee5w; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DF6CE40E016A;
	Mon,  3 Jun 2024 15:19:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hDswJJ7JDKdp; Mon,  3 Jun 2024 15:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717427937; bh=r4AxofPCNiuX2W8ZoKSi2lk7pfbcJt99dVTm8crU1LI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IoRfee5wzMYlcIcBm4rWSO3fRRMPzXZYh1f8QEaSNJvCyy86E7Lu7eYK+zwUgGN1w
	 jJDRsDot6Ojy+j+we4U9j6m46Z7b3Kk1EpcAAzICJ6HAXWe5BZSotYXYW8fZJfi23y
	 BfeToEtCjoBoYyMuNgAA2/W9UgVwWUeYf9EtDsdtyG9Srq2vNRnfH/Y0//Gj3HUFeN
	 p7Sg7mxyvbrqjkxWuSMGgYogXzIp6/iZjXQD9mUR2z4ab2rGuCmbc14+b7tBq4+HC8
	 D6BR14Mw83MLLb6Ukr9l/ra3lLXw9XxGBczG6bCulYV0/yGlBO8zmae4N4JwMrjI88
	 6Ks+W7nHxYc7Ama5Gpp3mx0oXAepPCavWLy+ESFt2xc9Wqt+sBjJASv9Saisqvpgpv
	 iF98WE+t8Fupb07XHd4AHpNNmc0Evqm5TV2cvSFyZTbkTuhvwj3Wdjv3aOpxg5J9DW
	 9oHYi3HpveLszTv4BCqi+QVAW9bAE86Cm0nRwCTyBe/eRrrJjIQjRSPY0gbycZtCFW
	 1KzGAhs+/b0Latl71JCEbcCxYdsrfNYPDMRXDHu0ZJYRgW3VaPGjdC3/y9fSpiGeCh
	 RqpAo8LekxFBKGKX1n8YSCqJ/Usq1uj0p6CQFbJatnHAJ3Zkzu0kIK0ykXwZQw4KYE
	 gU/HXS1Z3ih9tMLhzu9pcvdA=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 48B0540E0081;
	Mon,  3 Jun 2024 15:18:52 +0000 (UTC)
Date: Mon, 3 Jun 2024 17:18:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	David Kaplan <david.kaplan@amd.com>
Subject: Re: [PATCH] x86/kexec: Fix bug with call depth tracking
Message-ID: <20240603151846.GDZl3e1kNpOkjE2ALW@fat_crate.local>
References: <20240603083036.637-1-bp@kernel.org>
 <16622c3a-034e-9f78-3afa-b0c273ee4949@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16622c3a-034e-9f78-3afa-b0c273ee4949@amd.com>

On Mon, Jun 03, 2024 at 08:30:26AM -0500, Tom Lendacky wrote:
> Does it need a Fixes: tag for call depth tracking (before the change to
> cc_platform_has() it was a call to sme_active())?

Yeah, something like

Fixes: 5d8213864ade ("x86/retbleed: Add SKL return thunk")

I guess.

> Looks like spaces used here instead of tabs.

I was fixing those and forgot to refresh before sending - it is fixed
here locally.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

