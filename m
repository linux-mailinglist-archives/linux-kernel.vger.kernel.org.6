Return-Path: <linux-kernel+bounces-402366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D42D9C26C0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0173228623F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DC31DE898;
	Fri,  8 Nov 2024 20:42:32 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFFC1C1F39
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 20:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098552; cv=none; b=CxErzBuxSXKAyRp4JiKXWatdJx465CoUP3D90DhLfRn/pzH0R5sbOCH5ulpazVCZQEsTYBGUVDTSbzgcAGABz/YqwpFdea8c0ToHoS5iWqXBnypNOybf71HfRD5dsqRown1d/xavpoR2bFjb8QuSoxBQv6GsU5mJ/8cACblNS/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098552; c=relaxed/simple;
	bh=YnbrrXAzls5toITLDD5LLdUSi05zmrS5Q89tD3Q5KrQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jB3lojWxrFK/iG/+Y7zzYqfm8+TsuRds17x2EDCvevwRwAIX7VZTXCp0Ei2MNlzT1Z6O952CMzvmdSuZwJ/UT7xbvI4es840V/ez3O/+pN62vr/FkTqBCvH0pfr/rXRSH2VpwuWk3Q3mrDtFCNUcmcXktpq4yPsGlRwbiJud3GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1t9Vnb-000000002e9-1REo;
	Fri, 08 Nov 2024 15:41:43 -0500
Message-ID: <a7cffa2a68a7c9e40357b3300220c5eb0065e86b.camel@surriel.com>
Subject: Re: [PATCH] x86,tlb: update mm_cpumask lazily
From: Rik van Riel <riel@surriel.com>
To: Dave Hansen <dave.hansen@intel.com>, Dave Hansen
	 <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>,  Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,  x86@kernel.org, "H.
 Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
Date: Fri, 08 Nov 2024 15:41:43 -0500
In-Reply-To: <1df2caa3-4c5d-4bd9-88bb-66a07bf1eb65@intel.com>
References: <20241108143144.2f15fe35@imladris.surriel.com>
	 <1df2caa3-4c5d-4bd9-88bb-66a07bf1eb65@intel.com>
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

On Fri, 2024-11-08 at 12:31 -0800, Dave Hansen wrote:
>=20
>=20
> The only thing I can think of that really worries me is some kind of
> forked worker model where before this patch you would have:
>=20
...
> Where that IPI wasn't needed at *all* before.=C2=A0 But that's totally
> contrived.
>=20
> So I think this is the kind of thing we'd want to apply to -rc1 and
> let
> the robots poke at it for a few weeks.=C2=A0 But it does seem like a soun=
d
> idea to me.
>=20
I am definitely hoping the robot will find something to throw at this
workload that I didn't think of.

Most of the workloads here are either single threaded processes, or
heavily multi-threaded processes.

For the worker process case, I would expect us to COW and flush a
number of pages in close time proximity to each other. In that case
the first IPI may get sent to an unnecessary CPU, but future IPIs
in that batch should not be.

If we don't send many invalidation IPIs at all, we probably don't
care that much.

If we do send a bunch, they often seem to happen in bursts.

I don't know if there are workloads where we send them frequently,
but not in bursts.

--=20
All Rights Reversed.

