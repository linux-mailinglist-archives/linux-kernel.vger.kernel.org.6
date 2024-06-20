Return-Path: <linux-kernel+bounces-223336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99AE911149
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05EE81C209DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D596E1BD4E0;
	Thu, 20 Jun 2024 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CkMm5lia"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5709D1BBBC7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718908858; cv=none; b=U4pvj/Mn2rZcnPjDdvg4QGzM5PWTSUtikUXtk2Fj+nOyLkLwgZRtIY6zua4tRkSicC5+YA/omvKSG25sHo+px3jwi94v4vLpglrN5C+Fkq16okgbWjdq/hWVMW3TULrDtxCWXFcnrjB3go+kt9m9nhnoXEIY354D4cU2PTxCQ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718908858; c=relaxed/simple;
	bh=Hr5kf+KXUvVcZoZOEH/mAZ6//f97ICQ9E+f2pvMUTSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0/oiCqmzM+aGvKAcYW/a2GeVqhH3bMK2GcHIllN2d2nkYe31eQMnstp99TzoQ391tEexA27se90SyWnCS+RrET4jnzWbn3lLXAhfyvfiYyJXl/LiFIxyPG9T1V/+NevFxwhLDAr5cbw5VneqtoL/oQy86hATsp+63j6v5yTGHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CkMm5lia reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BB2F240E01F9;
	Thu, 20 Jun 2024 18:40:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TmAqgIDiYFoY; Thu, 20 Jun 2024 18:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718908848; bh=luUoOSmN1ADHg7u6e8/IxhLsxS0MKrrmjs19vHwCzHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CkMm5liah2Zejz4iLV/myxckHlyrHM0mMGuxqTxb95Yi5eovrydxv4eqKJvk17eD1
	 mbU5jxPM6OOYGwBcMSahsoP3ukVMDhZNPRAj/v216i6qMtyW27beBP6M4QBwBZfrxS
	 lGyoR2+E/k9hvMoMqkQn9YAEZ2PVdXfFF4jfgwvzQ6Z2tdmA4VS9j/sufJT/1Bt5o0
	 QScT38swfT9TdF/QD4SdT6Qz89LjhcJQirK38s/mwfKpCKaKJM75d16/K60MnIfFXx
	 sB31LCHJS7+qNLYmLCIDEfdx2HTE/S6RWHFmLbHQPJ5UgVS86q20KN5CQm5E9IhVUj
	 VrjK4oL1SjmfOQNrp+cNN2703NaXrtR/eUbNk5NFjX6+eNHvF6SbBa6CVZeufuidi/
	 mXTw22qajxWqaBpv/OaRR9TxVgGMpvw3SW3/KUfSajFOAcjr8f7uxxjTzrvgAuavT2
	 iFT//hjiM+gYZ3bzzBX4hz2Xzz8rc22Cyn+n5cvnN9Kdh2x2KbaJVE43aj6hXPxGbp
	 My+7+KhgLNzVFq4I97yr+XGej9gCGmL5ueDgo/KgRApgEJCTMVtOnlodk3VL/gcew9
	 ZUfjRCq1yz7qIRUwSV6KLbwHtuchESdiH4dGOa5BnAGH9R1AsYMPRFx/MUu9uGWZBX
	 VpzZYc+BKne0T1yHu/pNOIGs=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B3BD440E01D6;
	Thu, 20 Jun 2024 18:40:43 +0000 (UTC)
Date: Thu, 20 Jun 2024 20:40:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@kernel.org>,
	Sean Christopherson <seanjc@google.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/cpufeatures: Flip the /proc/cpuinfo appearance
 logic
Message-ID: <20240620184042.GLZnR3qkVxuZYhSQr6@fat_crate.local>
References: <20240618113840.24163-1-bp@kernel.org>
 <D9E4D244-1E56-441E-AF6C-2822AC9A2C25@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D9E4D244-1E56-441E-AF6C-2822AC9A2C25@zytor.com>
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 01:11:17AM -0700, H. Peter Anvin wrote:
> Or use a marker like =3D instead of =E2=80=9Dxxx" to explicitly expose =
it under the
> same name.
>=20
> For extra credit fix up the ones where the user space name is different=
 so
> duplication isn't needed in so many places.

I actually prefer when it is absolutely unambiguous and explicit what goe=
s
into /proc/cpuinfo - no special characters and other magic.

But we can talk about future improvements later - this should simply flip=
 the
logic and nothing else.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

