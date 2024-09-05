Return-Path: <linux-kernel+bounces-317223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5524496DB1E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37381F233A8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11DF19DF86;
	Thu,  5 Sep 2024 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LpkF0uFE"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B8F19D063
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545113; cv=none; b=A8FVJ9DzzTbBu53XSkAZ3qMJl0WxqCekSyUjRZzSGTS7ydBGyaRtk7DrQDh9sopAknx9MrA2g5kZ61KJ7tW7lv/pVehDgg0iqW/ge3/Yf86ZhwnCSWkhMWt9KXt020Gmc7TDj2W+fb7jffNzOak5weqv9qQje+fffhKnNCGwei0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545113; c=relaxed/simple;
	bh=/sXUD7yFY7s6D9vfcEo4Soc8XPWm2ouH+IdHPfdX5VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B349AeEeNZTktSuguEX0/3jwBKmElPhKDOYVvTbFq9gJjC4zmTlQBI6aJOaX34NhB+uFnO03OciAgr/0qcIu6cDROjwPaD7t8TaXvxXF0lkipUf3dzj6OLCvbuzzjibiDlUeXuKWmHRJnK6/qcVipdB/sZKYXalGypFgZbH0P9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LpkF0uFE reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5726440E0275;
	Thu,  5 Sep 2024 14:05:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SLOxHCcBzqJL; Thu,  5 Sep 2024 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725545103; bh=AjpM1WDrHJ+dslP31d1g1yEHl2ZRFYCbBBP91Y/KEmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LpkF0uFEdl9QhLarTVRfM5iRGkJzVOKPfEkrnty78USxkif7YieJ/XEl88lzTEHLw
	 swkFokyaq19m/YJCEZ84Rr2ARLAfQjCPkO+TeQgWY05pJ0LfnVQJvAaYra7/o6BB+B
	 Qxach3jdIvkkJLqFt9LgeKAeXpRATzRFO6epzPANKstltleR7N3zXgekS1/vX73Hya
	 va4PEuvBVG6DxUo0bVFvQcvU3cyt8umcXqqRYpqbNRkC9PytJeWVGfWUuFPsVX68/a
	 Dyi0BP/fln7CU+ZfPg097mSV8cGSD7+HsHdhgfyw7r3JGcb5XGW+WZlrnlbRCDufAK
	 /a2hn3bFNnkndRHfVHnhmfrp0VeUhRVS164aHdnJOcxYPofJRroW+mqjbMDTtgfxJf
	 k+DD4mS3NWjRCRKVCvF9HsW+IOebz/8Axt0Bw7qJeetq0dn4Ok0OCLCwYAhQR/ZI/V
	 UfaGpebspXv+yzrjerD5BzB4TbJr6IHailPp9pL/C8w5xHcQB81IKqJA2u7WOyNV0v
	 xr9KF1jbeMYC/+mbhFBO5oEmYNazBPQ81OBKRjnvRjEQFPlW2EDMrqu1Ft2wcJp1vF
	 iWFj/Lwd/2BTiQsaVby0x6JARZChEd2fN2prGR1YANyfBR86WG8bfsfmR+Wd9hVnsv
	 HKxUv2/Dea8jvJzdP+a97JJ0=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F30E740E01A2;
	Thu,  5 Sep 2024 14:04:52 +0000 (UTC)
Date: Thu, 5 Sep 2024 16:04:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: Christian Heusel <christian@heusel.eu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob <rob@durendal.co.uk>,
	regressions@lists.linux.dev, x86@kernel.org,
	Joerg Roedel <joro@8bytes.org>, Tony Luck <tony.luck@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>, Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH] x86/apic: Remove logical destination mode for 64-bit
Message-ID: <20240905140446.GCZtm6fu_H5JH_aP-D@fat_crate.local>
References: <ZqQSmw51ihns03ob@vendhya2>
 <ZqQl79UhhSQ5IobX@vendhya2>
 <8734nvuvrs.ffs@tglx>
 <ZqTufKvJKvotC-o_@vendhya2>
 <87cymyua9j.ffs@tglx>
 <877cd5u671.ffs@tglx>
 <ZqZ3Kp2NVctgstxs@vendhya2>
 <c7b68723-6ecb-42be-a9f8-14d64c696283@heusel.eu>
 <87jzgpubxj.ffs@tglx>
 <d9cbe524-ad83-4c48-b6f4-3376ff3172d4@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9cbe524-ad83-4c48-b6f4-3376ff3172d4@heusel.eu>
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2024 at 03:28:47PM +0200, Christian Heusel wrote:
> Now since it's summer people are maybe on vacation and I hope it got
> stuck there because of cocktails on the beach and so on =F0=9F=98=86=F0=
=9F=8D=B9

Yep, check. :)

The patch is on its way to 6.12:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=3Dx=
86/apic&id=3D838ba7733e4e3a94a928e8d0a058de1811a58621

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

