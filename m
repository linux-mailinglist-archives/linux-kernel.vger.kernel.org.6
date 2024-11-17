Return-Path: <linux-kernel+bounces-412231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4603C9D0596
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 20:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DF12821CB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 19:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E8A1DA633;
	Sun, 17 Nov 2024 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SeenTW4i"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA9D2629F
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731873205; cv=none; b=gXppdNWEe4cBfV5HRP2s8kyoi3KurUGANtVb2i2+1HGRz/fTNUemWsgtd66sVEykGfSsBFiNT27B7CS3cwmhMS++2ZkEpYaqOOVtZom5PEdjNRGiaMMoDugwQKaPK2d6vT3+p2VyLhIJLOh+O1RbFQAemnr/q2Xs2HenZcTjAoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731873205; c=relaxed/simple;
	bh=drKbxlN+WCqncl6+dfHtGCw/Y2b8PS3Ls8HdgwF9PMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzvUbA5R2t0enic/NB9zKUUXefMp2CTnldQN0++KOvsqv75VGQUPGi3IfLE5at32uvKzDnbCj9JdB9EDCEWfUCOueyMzaIROYjjVPsI53HCW/N73nD3FLNf3m1LVAX4hNnc1p4dDCUjpK2LCXRSW+sWBxCdNn7JJQZEhsYRwr0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SeenTW4i; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 003F840E0261;
	Sun, 17 Nov 2024 19:53:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ld6pF0VOrRmW; Sun, 17 Nov 2024 19:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731873184; bh=vTbi9vZB1ZT5qRDbz2NohYb0AKopUpegDeVIxyzWDno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SeenTW4iYQQ5v8lwwDcot+o+l392ZAFQ4/n08pX8FZCNx/EUW8TWJbqu3ddS9rNiG
	 13eX+eBuqBfSb+5CXgvsM+KTSgN5AVwSYp9a1Bt/1XCsCcOvhAWwS+VgnNiUSuy2rQ
	 fHl/KH2C24RPikd6RCKZxA7uHmbedDLR01rotyRLyvGM7pIduY+vbkDXZoA6Z3syHn
	 yRqxJqh8WDY5slzQ4RO1dh6Izi7zCutc4RohRkS8LxxHyq9h+V3RCt51AXiJU5uAn/
	 rF6edPyaKstPmR6sjSJPAL7Vrvg59XG0pkJhlKWm+BLyaR1kKWsFmvEkLLd+nhybkZ
	 6ZaR034HTfsbTBweIhYeRyO0h7PTqnYGnEnirCtpqt5MSeqq1pVavrChF9xqCVsucA
	 EroAvERCuBpB9c7SLrTNEgZ6Oc1iLj48e2lKhD6Nzqf6z972yNfOd+VfJZ/lTgxViW
	 Dx01BjUdsdz/84WUcV5uyUIer+f5Kpcv4F7l/DYRZ4EHmjdWfmzSCKnD5qp6PXgHmj
	 XRnfx0F6ESZc1/2R7GroWpK/uFg1ZF9KzvfxoxoRNrBpYavI+w4LyTJM3RWmuVY0bD
	 JU/gswhBtzBmU/xmdMYQGvdGbOd4TMKejV5XCWsUCTWnd7gcNBiuBBmjum99WpEKrw
	 9b1BTiTvlUxw9KieQpPmY5T4=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 08B9340E0208;
	Sun, 17 Nov 2024 19:52:58 +0000 (UTC)
Date: Sun, 17 Nov 2024 20:52:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: David Laight <David.Laight@aculab.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: x86/amd late microcode thread loading slows down boot
Message-ID: <20241117195252.GAZzpJlOY7kSUDeaT-@fat_crate.local>
References: <ZyulbYuvrkshfsd2@antipodes>
 <6449aa6c-43b1-40eb-ab54-48803481d11b@citrix.com>
 <20241107153036.GCZyzdHEwm9-LPQOzY@fat_crate.local>
 <Zy0p5DT0SOWsCDn7@antipodes>
 <20241114095639.GDZzXJV1EDJlMqv24c@fat_crate.local>
 <3f6a84bd-af4a-4ffa-8205-25b2c9084893@citrix.com>
 <20241115205114.GCZze0QtUKbeXdFEHe@fat_crate.local>
 <53daf7e9901d428fa25ede7caa99b520@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53daf7e9901d428fa25ede7caa99b520@AcuMS.aculab.com>

On Sun, Nov 17, 2024 at 06:23:20PM +0000, David Laight wrote:
> Shouldn't that be 'psize - 1' ?

Right, it should.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

