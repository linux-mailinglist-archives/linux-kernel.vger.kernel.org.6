Return-Path: <linux-kernel+bounces-216465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26739909FAF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 22:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32FF28298B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386DA54F95;
	Sun, 16 Jun 2024 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VGA+8PXl"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC949646
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718569576; cv=none; b=FEcZsfHhU0RSzihNL2Qxsu7d3DQyEhscv08DH5mpZOFMyBM1pVbYe02o3YHA3jMPSTgTS5jfAK0AffuYD9bE73PrUxEMyhjEJNf0pnemj7nyqEhx9dT57bCKHbtNt5NMi1j9AuPPdKYISy2Q0g/Z7dvFP1bZ5QHveKFJ9Aue+wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718569576; c=relaxed/simple;
	bh=TMP6bmhrFANzQbE5D5h8RGOkBDkoU58ya0LuQGdqoeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J94c+ZOcnbCok7DRFTzhURPIHGkixiXAbCEJuXRoQVvj+750qP8nU15jd6r/X8QfEBIC7w+2lJoTUmMaIdpPFlq25Nk74CQQUZoXsX0Omo59mmzbG/4R7KsskZLSUZIrFrrncbd6TG4+5p4ddzWk6KG/Tripd/vidNL2xLB0g6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VGA+8PXl; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9834A40E021A;
	Sun, 16 Jun 2024 20:26:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mRffuhg47vy3; Sun, 16 Jun 2024 20:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718569566; bh=t/LaOXsGUnHHD+1X3tcuuQx3oixUCeADl2e70Jnv1Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VGA+8PXlkOLN9RTmIa9jjD2f26yi37/UU5A0erkC70+PTpCXPOXzcr92NAeUc5zBh
	 Jsv0yFXpDqS9MfPGLRFcEka2UbmvH+OxpmrH490hGXW52SlMG2IZjDW4q1JtWbD9ty
	 5dJPtxswOJpC07SLkCZnwTyiH2GYsD3QeQBtF8tJoyyQewlYqjY8cdG+wFprDSN8RL
	 E9Uk80+QkbeBiv3wvzz6pYTHjCNdgFPQ1k36QtA67in/JI6UUcOJOVnbOpJofLor5A
	 sfNvDDRs68O5bzmMIk6qGW2hJLzT3g9Zg/5bD6wCbyVOHPNTOC1/k9yW2VhiXzRy9s
	 84hXOBh/i2/gvyeu4kx3LD8rHdXNg1A8Jnfi5XLyitRGJqbzZ+Pry+9h8CMV18Hd3t
	 q/SSjk4reXtmgzPJ1V01OmsXF64h2HIgrq9tlu016/IzfR2wIzl9g6K6jg4f2T1eEk
	 4xjSKsWFBaykANMxk5HST9+4GVKqR4ztlX5g1MaSoPQwFGdguexumYZAYGx0BXH8X9
	 /Ub8g2vFaFU+DtyTOoMtT/UC++NzsqBIyBKfUPVC8/M1ECYCmuAgz+2Lzfx8RSZPvP
	 8L4iq50FVbTvTZII4r9MQ6T4Anme7PA6gsejXrudmIccgMI8lKr2IgcDT7bJRI8Dvj
	 3ep25Dmn2V8jReu0QHAvCXsU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED38F40E0185;
	Sun, 16 Jun 2024 20:25:40 +0000 (UTC)
Date: Sun, 16 Jun 2024 22:25:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Ashish Kalra <ashish.kalra@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Pavin Joseph <me@pavinjoseph.com>,
	Eric Hagberg <ehagberg@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Eric Biederman <ebiederm@xmission.com>,
	Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
	Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <jroedel@suse.de>,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
Message-ID: <20240616202533.GDZm9KPZtpDKw5aXWX@fat_crate.local>
References: <20240520183633.1457687-1-steve.wahl@hpe.com>
 <20240613152826.GKZmsQGnO3OthLH3Vu@fat_crate.local>
 <ZmsbZCF9rFzuB3rO@swahl-home.5wahls.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmsbZCF9rFzuB3rO@swahl-home.5wahls.com>

On Thu, Jun 13, 2024 at 11:16:36AM -0500, Steve Wahl wrote:
> The Atom was the prominent example of a platform that the code
> introduced for SEV broke.  Unfortunately, the fix currently
> implemented leaves things still broken for actual AMD SEV capable
> processors when nogbpages is used,

Ok, how do I reproduce this?

Please give exact step-by-step directions.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

