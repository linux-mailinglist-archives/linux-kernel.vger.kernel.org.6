Return-Path: <linux-kernel+bounces-409450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AB79C8CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10972854EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBD584E18;
	Thu, 14 Nov 2024 14:28:32 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E13036AEC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594512; cv=none; b=WVb+IgAgYtnuFFZLLlLx8b1rEJ3GGPkbg/BBZOkYXbsZeeKVsLhvxjVUswGYuR9pk8zDMhe21Af+Rc04NX512uB1Ch1DHEDn1tZ5lu+rVBBWQGjT8QLYpJfGmz1L1dNVuQrQ9fRqlCPaSjryZl5Uy7tTyb0k5zo2oIBPmdpWZTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594512; c=relaxed/simple;
	bh=+tLRMRRgVIfVK1+30N3xSWuIMkhafAbSNf8+byfeWK4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mWP/sUFyoowUr1uCQYG5L1HpvTCceqquZX78j5GlbTp4ZnVMpgTodlqhS8dEO/rX1Fl2VgDNv5Bh66Nh6bUzKdzIUvOvswAPlG65ygcF51Je5TUktaaS6x4FdolM46Sc4u+neH0weoCa1sF57BLjuybFEG9uJ4sqSZfxPlZ8M2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tBaof-000000007dT-3ejo;
	Thu, 14 Nov 2024 09:27:25 -0500
Message-ID: <cdba614a4522307fb06615fcc3909f2f2d03f333.camel@surriel.com>
Subject: Re: [PATCh 0/3] x86,tlb: context switch optimizations
From: Rik van Riel <riel@surriel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, 
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
 tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, kernel-team@meta.com,
  hpa@zytor.com, bigeasy@linutronix.de
Date: Thu, 14 Nov 2024 09:27:25 -0500
In-Reply-To: <ZzXIcAi4R5yH8ZtN@gmail.com>
References: <20241109003727.3958374-1-riel@surriel.com>
	 <20241113095550.GBZzR3pg-RhJKPDazS@fat_crate.local>
	 <20241113095557.2d60a073@imladris.surriel.com> <ZzXIcAi4R5yH8ZtN@gmail.com>
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

On Thu, 2024-11-14 at 10:52 +0100, Ingo Molnar wrote:
>=20
> * Rik van Riel <riel@surriel.com> wrote:
>=20
> > On Wed, 13 Nov 2024 10:55:50 +0100
> > Borislav Petkov <bp@alien8.de> wrote:
> >=20
> > > On Fri, Nov 08, 2024 at 07:27:47PM -0500, Rik van Riel wrote:
> > > > While profiling switch_mm_irqs_off with several workloads,
> > > > it appears there are two hot spots that probably don't need
> > > > to be there.=C2=A0=20
> > >=20
> > > One of those three is causing the below here, zapping them from
> > > tip.
> > >=20
> >=20
> > TL;DR: __text_poke ends up sending IPIs with interrupts disabled.
> >=20
> > > [=C2=A0=C2=A0=C2=A0 3.186469]=C2=A0 on_each_cpu_cond_mask+0x50/0x90
> > > [=C2=A0=C2=A0=C2=A0 3.186469]=C2=A0 flush_tlb_mm_range+0x1a8/0x1f0
> > > [=C2=A0=C2=A0=C2=A0 3.186469]=C2=A0 ? cpu_bugs_smt_update+0x14/0x1f0
> > > [=C2=A0=C2=A0=C2=A0 3.186469]=C2=A0 __text_poke+0x366/0x5d0
> >=20
> > Here is an alternative to avoid __text_poke() from calling
> > on_each_cpu_cond_mask() with IRQs disabled:
> >=20
> > ---8<---
> > From e872edeaad14c793036f290afc28000281e1b76a Mon Sep 17 00:00:00
> > 2001
> > From: Rik van Riel <riel@surriel.com>
> > Date: Wed, 13 Nov 2024 09:51:16 -0500
> > Subject: [PATCH] x86/alternatives: defer poking_mm TLB flush to
> > next use
>=20
> I'd argue *both* of your patches improve the code, right?
>=20

We have 3 possible solutions, and I think we only need one of them.

> Mind sending an updated series? It might not make it into the merge
> window,
> but these look like good changes to me.

I would be happy to send a new series, but it would be good if
we agreed on what solution we wanted :)

1) Move the interrupt re-enabling up (probably not this one?)

2) Explicitly clear the mm_cpumask bit in unuse_temporary_mm()

3) Have unuse_temporary_mm increment the mm's tlb_gen, since that
   is the only thing flush_tlb_mm_range really does for an MM
   without any bits set in the mm_cpumask.

Which one would you guys prefer?

--=20
All Rights Reversed.

