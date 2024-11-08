Return-Path: <linux-kernel+bounces-402316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C619B9C263F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50DECB224AF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9C41E883E;
	Fri,  8 Nov 2024 20:08:01 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEE01F26C0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731096481; cv=none; b=MUpzGlwA620JowOXxdbPXOkSqy6hIVuMS8DwHxqkxOvPMqkC4jvY8QLkDdJOcbyil7QOjObgqzldg7XI6K5UlSPtnnb8CLcgyjWDSkxQjoyzk9sRG32qe1exSmB6HbghXd2TBif10FySynveSz2eghBuhsBBRC6A6Q58LBotvWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731096481; c=relaxed/simple;
	bh=1K1pLssV5ZrYFU3AqLaKLNrDoQpz99T6UPphEacdFUo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SrJXw5vBzIMj/uuShFfKvKqLrAyO0k5RatinjOhbBUrwvXlNbXtpwDM49o1fUAmZi5zSWUxrpAWFC0ZQZCQsmBthEUB+docSFRfFe+bJi+DnMAtR3Ex3WVfi9Owy4r6y/rx0F0SucCEPr4dMk9TRGM3pFe/tTcNmzpT3X7JNXbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1t9VGO-000000002Kg-0K1C;
	Fri, 08 Nov 2024 15:07:24 -0500
Message-ID: <55ada30f76d544a3f700e57a01cb6f6f255581d5.camel@surriel.com>
Subject: Re: [PATCH] x86,tlb: update mm_cpumask lazily
From: Rik van Riel <riel@surriel.com>
To: Dave Hansen <dave.hansen@intel.com>, Dave Hansen
	 <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>,  Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,  x86@kernel.org, "H.
 Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
Date: Fri, 08 Nov 2024 15:07:23 -0500
In-Reply-To: <4f7d5752-41eb-4828-8bd8-9bd07e89f4f0@intel.com>
References: <20241108143144.2f15fe35@imladris.surriel.com>
	 <4f7d5752-41eb-4828-8bd8-9bd07e89f4f0@intel.com>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33Aeo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdYdIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gUmllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986ogEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHVWjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE+BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTeg4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/j
	ddPxKRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/NefO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0MmG1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tPokBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznnekoTE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44NcQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhIomYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0IpQrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkEc4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Fri, 2024-11-08 at 12:03 -0800, Dave Hansen wrote:
> On 11/8/24 11:31, Rik van Riel wrote:
> > =C2=A0		/* Start receiving IPIs and then read tlb_gen (and
> > LAM below) */
> > -		if (next !=3D &init_mm)
> > +		if (next !=3D &init_mm && !cpumask_test_cpu(cpu,
> > mm_cpumask(next)))
> > =C2=A0			cpumask_set_cpu(cpu, mm_cpumask(next));
> > =C2=A0		next_tlb_gen =3D atomic64_read(&next-
> > >context.tlb_gen);
>=20
> If we're worried about contention on mm_cpumask(), then this hunk
> makes
> sense independently of the lazy updating. We might want to take this
> hunk forward before we do the rest because this seems like a no-
> brainer.
>=20
If we always clear the CPU in the mm_cpumask when prev !=3D next,
wouldn't that result in that CPU's bit being clear (and needing
to be set) for next when prev !=3D next?

What am I missing?

--=20
All Rights Reversed.

