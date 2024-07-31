Return-Path: <linux-kernel+bounces-268953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBA1942B86
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD751C20A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D4C1AC425;
	Wed, 31 Jul 2024 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="H5F/8Z9h"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7671A8C14
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420152; cv=none; b=tcHzVQ6capi7TBm+EX3kuRzAib/Spo6afqi7Z1JfGZKyYPfjf8aV7OmT0WsliwFXm5SVsJ3H73Sg8YbAgiJ71h8i6twHqDvqu4T0ddPA7PzNKlEt8XPTnRLV2/KuqKBwoPkfg3wK8h88KBwiZ0IDH3mXi0rBTjJ3SRGK9P6iIGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420152; c=relaxed/simple;
	bh=KdWParlwplWZ7ZsWqpCyXWyK1qnFrVD8qAJVpFYcBAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRbEYCpSAPGPRMlNk7UTv6L6f5H1Z/8EA45q4TozfyKGaP0TrJ/2KzBR/FufY7HGHVJVIxOOYTdlaDmZ4UjfrbXMObq83ekqAwk/oYsscV8AhajoZCiq0ChCReJHeysatoIv1xoy0Xjo+tuo6lzyhxRgMFnSE1/vo50GDabXqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=H5F/8Z9h; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8EEAC40E01A8;
	Wed, 31 Jul 2024 10:02:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6IbKJbw80gfJ; Wed, 31 Jul 2024 10:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722420144; bh=5zOmqEMLwVt4WgbCn6YmjoUINAkNWTh2JHrgDxT3jqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H5F/8Z9hHZGOdHTenB6VEVGEURF7wApLmQHINft/0CZiv7AIVrC1dXN5uJCwn9elj
	 7Rbwbm2rDlX+msKJNszcNOSjC/3kZRt9a1UpubmmlNMWKvAxziqmRUNJTePmO6Vqul
	 b1JH2d9/voyIXHkId88sDODw49hHfwb+zntSlAiwjawYmpnVlulrYC4W9dxefHGwvE
	 AQkiL2Gdqk11IXcXx8BuJfIzmVGSnxAaX7ICNWdWIsdNEzCj85ljAy1PBi2SG4BxDP
	 hgXcA/KrVNScRzlcSwqsQSmquMTPHvLn/cHtfa0cU31SQ0i5CZlvqBa3jh/0ViUSo3
	 2Nmqsy4z6WQ2qBlm/iAgV3vhXQnowh+w8H+MrsKMXB3EqMHwQrbDvLr7u3gYcMNVU3
	 71hwa1XGY8O8riIprSAz5s/dm9kFaxY+9ApBxz097qNza4KOgx00iGKmbszJk92tWv
	 S009OLFQan5IhEy4d9b8naNI/7UPjcVzB3uGEqWLLcczoDv7vPrSgWn1NLAAPTLpr/
	 VmgzIsILvtYfupRp4NpRnuix1sEdgwVtkeeboppT0n3sCgpliDqgdLSd/FCblroAwO
	 PNw1FONWVke84ogwkCRELbNK2mbsBOiFiLgL7izJ97xV955vtnOV9jFItE3QqW9+0m
	 gUN+qMGHo9+PqIs4vNyWZAkk=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5708340E0263;
	Wed, 31 Jul 2024 10:02:15 +0000 (UTC)
Date: Wed, 31 Jul 2024 12:02:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Anvin <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
Message-ID: <20240731100207.GBZqoLn9Q49fqlU97J@fat_crate.local>
References: <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
 <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
 <f395b9d1-9515-434b-8ea5-c3bcaac10fd1@roeck-us.net>
 <20240730200947.GT33588@noisy.programming.kicks-ass.net>
 <e791c078-a821-4636-b44d-e02c22c046cc@roeck-us.net>
 <CAHk-=wgnmrbQhnXdpi=sY68m4OJff+qSiOUY-L8SF_u8JkHe8A@mail.gmail.com>
 <20240731082111.GAZqnz97mCll6rDyV-@fat_crate.local>
 <20240731091148.GW33588@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240731091148.GW33588@noisy.programming.kicks-ass.net>

Just a data point:

gcc-11 (Debian 11.2.0-19) 11.2.0 - does NOT repro.

Upgrading to

gcc-11 (Debian 11.5.0-1) 11.5.0

*does* repro.

Fun.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

