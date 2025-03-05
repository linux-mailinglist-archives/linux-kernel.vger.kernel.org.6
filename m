Return-Path: <linux-kernel+bounces-547670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363A2A50C35
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D3C03AC9BC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F94B252907;
	Wed,  5 Mar 2025 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WHHyZinb"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B23C1EA7CF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205271; cv=none; b=TOgFlgM/BeIHtJHpRCEBGvmjBiWgtQ/pflc8iCE8c5+RUDyq+TEK0/YJ1C4md/eeAqondZCro9WAvoDVhX05AkbyT7C4GzeQloiU8PNZ2uUjlBbRayJoqFIMHhNkfPOW6bD+3gXNv8sCWiXaZ24I2ftQYsJV8yWqNOEGBZujp1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205271; c=relaxed/simple;
	bh=CT6OathKPmmMVW7TEga6ky5CAgLjW7t7G7m20dQXeyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbtzNklT3x2QTfolYWqcqx/0BURmh93XF4FlEbJi7YzWmhFcJvozFETv68gK0CPoRB1G9rV1ZY+Q5437K6EdKuKdMhL7WQ/j/mtOm5SQIjW6z6PvQylADmM8qAz5yeu1jMnKieu4Y2sg4I7urOnwTqrBH4V0gPgdSsMG6GEA2jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WHHyZinb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BF80640E016E;
	Wed,  5 Mar 2025 20:07:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0Zuo2bW_fwOE; Wed,  5 Mar 2025 20:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741205261; bh=o+2Zdih3jIJ+DBEzUVJ7WYC6OGK9ewFMpH5y0x8lnl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHHyZinbEP3hypr5SmuUZJyPdVcsRg2bba2r3yMcCOITGooaXCZ4KyMldhTr7BtOT
	 ZP9zC70QZVxDQ8zryRRAZK45Ka1jsuBF6cqMXwyMzNuc/deQ+SW62eI5wFILkYigCu
	 4jhybLsO4pQ2gJXlW6MpNSSGd7ovyww48OzabyoV10XRQfetMhFkmu/+PNvzrIhnpO
	 W0hITsewmlO2ZtUKSLLgo3X60wTOulfILctgl/VEuanekQJyBEzBuzWTOQbQujLGzG
	 E4FoS16E4zJvBhIBCKU8KJanU/j+ir5XtlUL6y1nu6u2Ux7gminFw1ICZ8W1nrUtGd
	 Ushrf9Qx/wxK6JxMGzKpH4NM6eD2M6fAhlkGM4+4wx01FIFoE4Zbw55kKBu0SzrOmf
	 5PB2JzgSZOcRfeeUdgZpVxm8HdjylVENlh+4AegQuHvUTRbp7Tdr8qhl3HBdB2LFFY
	 DTceH++1uLO+fWDctiom4OOiJPbXPRZZnEF5FI6acd8DDbq2zpsaIBxNVIYhSquOsB
	 Qt/tBK2yf1+6luYbArQtOkg8gMm8rGAuWRoYlprcQsTkEGUQCuqnLFOi302DcxN3gO
	 JJ7pWZLTNAcdDgNI43sLJS2K/FgjpH+gHKX1rMghTvgM2zOYzzAfy9D2XU62ZRcZ/6
	 ydXHEVnf/UJ28TZh3Dhasvkc=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6374240E0176;
	Wed,  5 Mar 2025 20:07:30 +0000 (UTC)
Date: Wed, 5 Mar 2025 21:07:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Joerg Roedel <jroedel@suse.de>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <20250305200722.GMZ8iu-iq6b3GHaUVb@fat_crate.local>
References: <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>
 <Z8g01YhM_FtdB5n6@gmail.com>
 <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <Z8g4sU_dsZgY0PuS@gmail.com>
 <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
 <Z8hYEsHvwUwlOold@suse.de>
 <20250305153705.GKZ8hvoaz2GPt2rGtu@fat_crate.local>
 <b0cf4bfc-bf22-4986-9e76-62e3f54179ea@intel.com>
 <20250305165502.GLZ8iB5kAtQmW6fu1F@fat_crate.local>
 <e2f9c22d-d09c-46b5-9695-a052859d04d2@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2f9c22d-d09c-46b5-9695-a052859d04d2@intel.com>

On Wed, Mar 05, 2025 at 09:09:47AM -0800, Dave Hansen wrote:
> Not really. There are always new features in the pipeline, but no real
> fundamental changes to the threat model like SEV has had throughout its
> iterations.

I'd call that more a iterative design with adding more features with each
gen.

Regardless, we should think about some sane mechanism of communicating guest
coco attributes to its userspace...

> Xen has a bunch of gunk in:
> 
> 	/sys/hypervisor

Yeah, see uptread.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

