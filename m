Return-Path: <linux-kernel+bounces-244591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 595E292A693
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AA9288AFB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E070014B090;
	Mon,  8 Jul 2024 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UXYaEpNa"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33311459F5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454293; cv=none; b=Vs8EFn8LsPtv5xV5MeM2bA5yvdakVvMoEFlHDQo0jTiVU1Rt0W9aees5jyxqaUDpsBKAGuwIqr3r5kl04S1Myxn1dXok7Ixfhnca3iFPUYJVi8Emdf8l4byxarEtmKA3Y60fYYw5AP9zH8r02CwzwaP/2TNUw8qCOq9xB1QXpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454293; c=relaxed/simple;
	bh=Px8xm/hnky3EWRPnHZXwOMv/BlJdcF/mT5OoAzuqNdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEendUTwwNzxyfeHCR3afHwWCl13tzgA4a3ZIYQdcXX9amBlstsaLmtdfDHFz2oTm4zapMBVQlE5AjH7FCPw1T4D+uodbcsGnrmWXrgosfoR5zs5LjaIPRR2/wVtmbG/Lj0UJzqvHPPUuHYR78TWT1Eu3i9QL1WwDshuzVCJIY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UXYaEpNa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8644440E0219;
	Mon,  8 Jul 2024 15:58:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8S0bYZDvHkH7; Mon,  8 Jul 2024 15:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720454285; bh=0y5PCAzqc/rXTL8LjJDhTpqsGe+rcq9FLHFfAGwW66I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UXYaEpNaaB6jLNNK+1creH7EAXmohenz+ztJdVwgcKtnB0gafVLZYebr/FrOWsnBL
	 0/425DKlxPtXThVm9IZv/dwgCR+cjJsItON+TAKe8/zPkhBVshApCLDJ8xdfYXTNjp
	 fUFRlX6wWTSITaXVGdpPliD9MD5sU76hYcuI3/JmU+w/PM0KG9QehF0boNhUGgl/99
	 4Bsq0KTvlYb8u2F8UI8MVW4qTg2X5V93T41hhq4Sdf2F9oHuGNTnbw9vvx1w83auLW
	 wmIL6+qImMJnq68cEeZ7V0ItKH4Iv/Z0o+4W+L+NaeVquYtQGx+KxjK9457yzIrH0P
	 Ol8trcTjAu3IC7jT5IGlGokF6IuL1EZChTiaBQ9sq8QMv4azAG2IOdj1q8/mteQFoe
	 hekPbCQUZ1XXg1CRWnzp+36bX58i6/LPeAJ/Z+pBIUtPspf/URTBQK+DrToZx9kBGQ
	 MlETdRS56mB/04nXUYy9oTo3HnjC8x4uKEum3K2r53eqFwtInUVmjNKp3HQ3fJj/08
	 qiD/3CWgp95ghLzNX2Xvkf0mi6OMOa3ecxuKInmw4V5jbWC6eZ/if0osXzyDyRHnFv
	 eWM6QHb8md+PCK/rByhiQnHfkLQi1ekUbk6mhuFUBTW0pGqCsRN19mE3g5D1kWczq0
	 YyP+0j+XceKVY94G66U7hP98=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 56DC440E0177;
	Mon,  8 Jul 2024 15:57:52 +0000 (UTC)
Date: Mon, 8 Jul 2024 17:57:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dexuan Cui <decui@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/tdx: Fix crash on kexec
Message-ID: <20240708155747.GEZowMeyE64PF1O9os@fat_crate.local>
References: <20240629135933.GAZoATRVAubo7ZDdKB@fat_crate.local>
 <poxeykijyqrz5hxrey46s6hh2qd6byirbevwuwec2gtbfq266c@npegk7sn3ot7>
 <SA1PR21MB1317A2E38083B300256AD5F1BFD12@SA1PR21MB1317.namprd21.prod.outlook.com>
 <20240629194103.GCZoBjTzC4m9a9yw1k@fat_crate.local>
 <SA1PR21MB1317B5850E4274CC31EDFBF8BFDD2@SA1PR21MB1317.namprd21.prod.outlook.com>
 <nx7jjplwvtmxsq675omsi5hc5oxceiffpmkqx754azuv7ee2zh@7fttse2hssti>
 <SA1PR21MB131745AD18D9E91D2ACA1964BFDE2@SA1PR21MB1317.namprd21.prod.outlook.com>
 <uewczuxr5foiwe6wklhcgzi6ejfwgacxxoa67xadey62s46yro@quwpodezpxh5>
 <20240708133242.GCZovqepGsDSL72tjZ@fat_crate.local>
 <xa4zdohlxg2xeq3qjpaeycd5ixpkm3b4bjwm6mcoore6dfhiqt@xxbajpzq24je>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xa4zdohlxg2xeq3qjpaeycd5ixpkm3b4bjwm6mcoore6dfhiqt@xxbajpzq24je>

On Mon, Jul 08, 2024 at 04:51:12PM +0300, Kirill A. Shutemov wrote:
> On Mon, Jul 08, 2024 at 03:32:42PM +0200, Borislav Petkov wrote:
> > On Mon, Jul 08, 2024 at 03:34:34PM +0300, Kirill A. Shutemov wrote:
> > > Borislav, could you drop the original patch from tip tree?
> > 
> > Long gone already.
> 
> Hm. I still see it in tip/x86/cc branch which is merged in tip/master.

Yeah, it should be gone now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

