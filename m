Return-Path: <linux-kernel+bounces-386781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615109B47D6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923091C24993
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C5C20512F;
	Tue, 29 Oct 2024 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bXkBGJ1X"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507D11EE031
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200030; cv=none; b=WULuR77Kr4gqRfaR/+yoA5RNBPzTPv0TxOX6lPkzyMguAnbJ2dNDGCEbqFsw73k7PKGwGCu2ptzQme6W2tNp1Gsjg1clYEr6kooEbRuIRV70N9emCFZ50uk/kL/4t5QN31M/0p9RRAETrBW7RxRhnKkyYOmAuUKxZHSRofv7ag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200030; c=relaxed/simple;
	bh=nruZqsA2XW5jXE6oIEGXvWuKwoAGvf5ZIlpBMwK76jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gox87Agx7xTfb4WEXCPQYKexseXIWmBqRrf7A8uFvwY17k/AnEuYx/jdEpl5j6ggilHus9Q3FDplkXZreDYHtnY+0Hlv2YizHhMA8ifML3A4LbhU+qEDIbZZuhb0UTGDf8fXsEC6aYt2ucoVmIywsMQuuJnGot6AME+8Bq59x4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bXkBGJ1X; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8EB6F40E0198;
	Tue, 29 Oct 2024 11:07:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dFfMh_i6PbAn; Tue, 29 Oct 2024 11:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730200016; bh=eAWbP0fRWMPLppgvWu2z9VQau+eDPrgN+MGorysQCOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bXkBGJ1XihE+oQLvLC9rEcqmsibmUS2jRSclA1LWnd1awt4kcRBADQJ7OtK4Sr3YI
	 cu8EmIrxCIu6vI3eE9jPByrC7FsweJ5vDnY0cwH6TPD0D7dFEXaL0Jebeli4wowNpu
	 R4cCSWSitFwny7KJmTtqZ6y3YAnNlXqLNVoXGCUi8805VSWE1l3oYq/w4/vyHbvpfV
	 lu9yCxl1tCMewTxUC9zb79SPbo3ZDaQRgPMR1ZqvZmQQ3p1DNQXtAr7Kg3Qttgl+nX
	 vKMeWAeXyp7fMaiXZORQ6IHJknpAGFlafg6SMFBXni1RdPlhXxuhWvuAVEPxpIQwgf
	 v+jHQXISlqVORCrgcdALJonBMXdl37d/8ofh7lzBcrywpfHF5fY+qW5tfVxpN8SyLQ
	 k3XxJksckrSaMKEJiIxJyo6bawARIFYDoViVqcSP5C+2LxWIVrx2T0ABbBspPkEe8/
	 FqQvZX8I4obyHSNL27g6ma83vUALPnu0aUuO11WZoaKeMsGwYQOgmo38cnlYmvUUMg
	 Phwubt7V7UyFoZbQPMjyPmKO70i59IOGmjZHL7hN9O8jeqyQQHqS99prAyD7yVdFyH
	 S74CAxkHUljzg4mN/wcpT2EEK0ST3BEzX77msAcP+c2QHGK3Hx419BgG/cL6psvxUN
	 o84+yfA0aOAd1NOBRYzY43pU=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 95AF840E0191;
	Tue, 29 Oct 2024 11:06:42 +0000 (UTC)
Date: Tue, 29 Oct 2024 12:06:41 +0100
From: Borislav Petkov <bp@alien8.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Suma Hegde <suma.hegde@amd.com>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86/amd/hsmp: fix compile-testing without
 CONFiG_AMD_NB
Message-ID: <20241029110641.GFZyDBwa2o1a13Bt-T@fat_crate.local>
References: <20241029092329.3857004-1-arnd@kernel.org>
 <20241029103316.GBZyC57KGSxyPie3Qu@fat_crate.local>
 <3a5360a4-e5c7-4c97-ab15-778d73f5b5a6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a5360a4-e5c7-4c97-ab15-778d73f5b5a6@app.fastmail.com>

On Tue, Oct 29, 2024 at 10:56:12AM +0000, Arnd Bergmann wrote:
> That would work, or Ilpo can pick it into the tree that
> has the driver changes, possibly folding the fix into the
> other changes.

Right, while it shouldn't be a problem, I'd like to keep all amd_nb changes in
one tree because we have stuff in-flight touching and changing exactly that
area so...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

