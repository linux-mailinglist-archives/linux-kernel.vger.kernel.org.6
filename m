Return-Path: <linux-kernel+bounces-555077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6149A5A53A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE883AE582
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9FC1DED4B;
	Mon, 10 Mar 2025 20:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jgK+HMm2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C551D5150
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639518; cv=none; b=Txk7Y2/Q1bEpe9lPPp00hJrqYIpB9O7XXaxuJJaAPyUCZSF8c/46q2L1hfAtc2pGX1/hBlJdsY//h6YT7fNRUC/N/JQpPRqEsJdUef4aF36HU42Gj99vxQhIrTptVl1Ns5yOSkWtISc/37JhKK7U2gYKQcv/QlmOO0rvAkc6Qsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639518; c=relaxed/simple;
	bh=OU5J+jfc1jopf4JWDFtsMwKpDim0WBKH9tHIa9XMzpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4GjCovTz7LktUrPfcq0JAWJNuOEE5IxU2jf7x85yVbU8b5bKRrNaikR5/P6VvHOfPwwwglTNNEoWMa8uqfC0mS+9FrlqrzktTfDQy69hhmwC6a/r5zajBMLuaup8Yz1uE68ZiImBXQLpIQQZlmkOgYaLAvkan4Hmse5mGfR410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jgK+HMm2 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C5ED740E01AD;
	Mon, 10 Mar 2025 20:45:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SHR3Q_uU7qdW; Mon, 10 Mar 2025 20:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741639508; bh=0RjFQIwL9SDXqHJ6TO7Bg4CU5uAaCQ1XEaGuir1TffY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jgK+HMm2n25T8Y5g5PH0Z+CbQBANiJOZ9rrJJqxEswatjsFvEzaJZMCDMRpQgMdgO
	 450v4XVpPPleorhjr4P/aVaRB+gA0tZVLH7obbP9h4bhvDs5fyUM1YOvTdgfWh7vCg
	 ePEuxDHRV9QuVrIW9nN8x2mpSVAd6BQrcFhVAKe3oO9UMyi0QDShfceKGqey45RpOL
	 V4KJVF6KW3x6cM8LJLqhmrW+W2THt86M6N49XH6m/uJafs9Zz49T3h6Qhy1dav33Zk
	 ej61i8TWxCljGtAlSe8EpbvllSe8AOwWzb+pcTnp67R6MGnQ0PVnzcjDL/gim4i8EC
	 Ga3N1T+SWk+ptNM+HSdSmIvQRGF4APsnIP9Utr7XyuoJQ2YuI0LzDg6pQAlWhhlQT2
	 KOTLIPpyExd2f6o2A8SDpPXbipFO5IlSq9MUseLWFh00XQ1SY7GJo5gIvSpJzFn3wd
	 w4Qf5oHl/3tU93hzMwGILLHILO/vP1D37GA0/z2XzUCEDSpJ6KCIEFu5PPHjfeXOcz
	 KD7b73J6aGQiGC33fhfDLDfThCug/lBrfGyVR2k4MpMJkhmx9xDG6A/79BLF9DX9OF
	 QM5kxOkTdLICibVHBQahM9J28P6+PcaaxbfLC7HrPzEB3QQA6rS+7Ew1ksKFsBHASP
	 RTUoBL9t4OWgzuZrILI8gnJo=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D3EE540E015D;
	Mon, 10 Mar 2025 20:45:00 +0000 (UTC)
Date: Mon, 10 Mar 2025 21:44:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/hweight: Fix and improve __arch_hweight{32,64}()
 assembly
Message-ID: <20250310204454.GYZ89PRl3dBR-9oBIY@fat_crate.local>
References: <20250310200817.33581-1-ubizjak@gmail.com>
 <20250310201227.GXZ89Hq5LVWKHjHBeO@fat_crate.local>
 <CAFULd4ZCc08kJU+3ZVdyWhO4s5fu0Y-RDPS-Y-_sPB1R0KrnoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4ZCc08kJU+3ZVdyWhO4s5fu0Y-RDPS-Y-_sPB1R0KrnoA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 09:35:42PM +0100, Uros Bizjak wrote:
> On Mon, Mar 10, 2025 at 9:12=E2=80=AFPM Borislav Petkov <bp@alien8.de> =
wrote:
> >
> > On Mon, Mar 10, 2025 at 09:08:04PM +0100, Uros Bizjak wrote:
> > > a) Use ASM_CALL_CONSTRAINT to prevent inline asm that includes call
> > > instruction from being scheduled before the frame pointer gets set
> > > up by the containing function, causing objtool to print a "call
> > > without frame pointer save/setup" warning.
> >
> > The other two are ok but this is new. How do you trigger this? I've n=
ever seen
> > it in my randconfig builds...
>=20
> It is not triggered now, but without this constraint, nothing prevents
> the compiler from scheduling the insn in front of frame creation.

Can you please stop with this silliness?

When we start doing git archeology months, years from now, it should be
perfectly clear why a commit was done. This one is not. So either the com=
piler
is doing the bad scheduling or it isn't. Things can't just work by chance=
.

Geez.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

