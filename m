Return-Path: <linux-kernel+bounces-527336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31553A409D6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD09189BC24
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB3913D539;
	Sat, 22 Feb 2025 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="je+VGqDg"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A1E11CAF
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740241182; cv=none; b=ugKuTp/XlRnUNgsceC9oPIRyCT6PBMlmWvs6gguATSrmmuM4GHubAMWeoWVaEp+QSKTAXPxmA8Q2I1T3vABAtCTcHAy5jRwvE95+eqgKGyhaBVeF8J0nzftAz+a0D+KUS/KC9soF1J3dCX/Y9gVWtLJjbDM7htLKKt+oT1qHMCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740241182; c=relaxed/simple;
	bh=wGJeKwXEQnAOaYDwP4JZG1Pxz540yOM14ypcDN69CfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VokMEX4dIAFAsFV5X9DWsyHQjew/xfpfGxc1fataUAUYBRFJ7SUluIWNE8OM3ppNBMTlSe99wSXkRfiSJ1o6qbB4Y0InuGargCIW0mkJ4VRDjHzP9dYnNj78t1AB3J7ZgBrCKgDqjbG/6opL0xpEvDCPSV7x7ElaQYFsnZOu1OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=je+VGqDg reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A911940E01AD;
	Sat, 22 Feb 2025 16:19:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sLJ7bO-Z9SZM; Sat, 22 Feb 2025 16:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740241170; bh=3c6QLrQOPMg4gJUMnvvUhkC8BZW8S7qXs09rUpcW/W8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=je+VGqDgPUeJKKE+49xZd7iT3AI8eVDYVvU2BjhZ6xZ55sF1YWtjo55DS9fA2H5Ms
	 WBHxh3A3Z0pz1QWtFCBG/M5dAvaZBk3LYHJMGEj60xS5WeqFVbdpTJpM2gW/BcFVxC
	 ZzUcnDZBF+i/tyDEhzL8DFcdVRnkUGxXDhKvF2UF7sIiOeS2ouXgUO7iN9j4/Bbo3Y
	 VD5UVFMFyZKS+y6e3bQgeo7xDiu1ywROr4twPPzYFoKeou4A0WmZLXRexGxmdTE7jW
	 I4ttWCqHmzYXqYC1bytwSz3aq8irro63NDXkqVRnpYGFJyd86OH3B6RsTZO/MERYHZ
	 JlI/Frm7G/2kCJbAQwtrKk9paIhk+GaBYwmfKebhZMiD/I2KI9hMjMXh4C+MsqSVsZ
	 fZbPVNx8pYwMnfoBqBzXs2f6sOubVujKF6NqSXHs4j3l72kmfh5E3pFz9vW1C9mPed
	 In10JgkKh3o6GlzjCqlFWX1KQx+Q6dl5g30y0m9/qk7vyIrtVT/uF8hCb8tQMTuYQG
	 87AL208rIUtPvwLgy+7aYc2zrE44EBeBYkaCp2GEXQ6/hp7e/pGeqqITt4Vd3owuhO
	 o61TrvKn2JqUoVk4uJpBz3OlTOIB+Dz6dp2utYeyjllQkvnVgWdS3e9daD4drtSEmZ
	 Zn0uA3GJfoPed3DLEvGy0KEU=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 60C6940E016E;
	Sat, 22 Feb 2025 16:19:13 +0000 (UTC)
Date: Sat, 22 Feb 2025 17:19:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>, x86@kernel.org,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com
Subject: Re: [PATCH v12 00/16] AMD broadcast TLB invalidation
Message-ID: <20250222161908.GDZ7n4_I-t2BSg52X4@fat_crate.local>
References: <20250221005345.2156760-1-riel@surriel.com>
 <5861243.DvuYhMxLoT@natalenko.name>
 <eb2feccb1874399699731aa9f16049a375b0f9a9.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb2feccb1874399699731aa9f16049a375b0f9a9.camel@surriel.com>
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 11:05:41AM -0500, Rik van Riel wrote:
> It's crashing when writing the value to the
> invlpgb_count_max variable.
>=20
> This would be because:
> 1) invlpgb_count_max is marked __ro_after_init, making
>    it read-only after the system has finished booting, but
> 2) get_cpu_cap gets run at resume and CPU hotplug time!

Yet another side effect of us reading CPUID gazillion times. /facepalm.

> Borislav, do you prefer I move the initialization of=C2=A0
> invlpgb_count_max back to where it was before, or get
> rid of the __ro_after_init thing?

You probably could move it back to where it was - cpu_detect_tlb_amd - an=
d
leave it __ro_after_init because cpu_detect_tlb() is run on the BSP only =
so
I'm guessing resume doesn't bootstrap that thing...

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

