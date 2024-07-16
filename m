Return-Path: <linux-kernel+bounces-254182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5AF932FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE631F2330E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1871A01BF;
	Tue, 16 Jul 2024 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="d1SaYQ47"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D381F171
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154576; cv=none; b=Ug6t9oJ51h+X5uvKP8Gts5r9lR/sizkVKJHDo8fBgXSPJ5me6/RYOOuHXZeyMThoDUfJhIUuR2vNtWVNJ9bIt5plVFqF4BCZ6q0xMCOnLVFqQlpWqAxW7jdp8qbhM1nrKQUP19Y6iHX94kTIca/JoXBchZP4uBsidf+mMEPfMg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154576; c=relaxed/simple;
	bh=ovtB+LyDpT1rEO9qsdIvY9Or3ReDQPNeb2H8fZisNoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfO0p/fdifjymPbLw/h4/927/FqmUpdaMG2U0/3fRv05HYZjByb1X6l7DAFAD1vdWLseoe+GrA08Z+2i4ffg3QqPIX1hVRF1mpywAIGmSGIJ8HJg7Lrinvg2SNheriTayZkbxYuUTjpN5e/HqH7+d9O2mH2KjDbFJYm4+YnNWCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=d1SaYQ47; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9FC4040E01A8;
	Tue, 16 Jul 2024 18:29:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id M4eyCIT27Kdt; Tue, 16 Jul 2024 18:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721154561; bh=H3VfaGYIT27W5ux36KS31L/hJnulZusDhFrHWmp3rPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d1SaYQ47G+aOAF+9aGBed5mTTd+36FICnEPkGD7gbcGg4DLjc/BO1ZNexs2wTXcGZ
	 SXiV3ZqUGzxThFxAC8KzehZPSEbJCCpTWUngFcpCQqQE80GTcKfp1pRmnm36b5DAtw
	 jTgn3JWCkyAy/pXRNfyi7NqyU0TZ/3P6gcQ2UJ/BlnPYtLyFIJUmDidmJvY/zmHD+q
	 LO6jtQr2/Jr5ci0xDzsNMYuThesIDD0EhKXhyKVYUD8UnPDPACBqdHXAnKl29KpJRz
	 YuaBYpxIKlJQ7YtyzIhUfVnz9mZrK2ckJh4opVfSd3LOZDNKXPs9pdJ/ZVaphwgd5v
	 fNlkrP2KqfQNW85SDPwqeZ93KkLXj2cK1inaM7kVFRYvPkLRs3EOfNPXyLfsDCx/Db
	 nji82oN0wlcGWW1QTnroFVTf2ZpKfjwsVDJsADttfbwqxz17J/DBsIuH6MIzvB/apn
	 hPAOq9NpTrLiGuMVhz1WjRxncLyzGM4QiFyWSUQc3vr3T9lG+JUAMxvEQZVAPChVkK
	 10O2MRd35Tvlq3S/yteTflKi8O9CVdPeAVVozoXPsiqKVhgPolWZMCjrIuZe0D1CCT
	 dd8423IoqpgdmGfYuorLwD1MzPjVGfGezI/pTorefFAVWdP7FfpFP0PF0x3SOdZ5l8
	 vdkgeq71efU1k7afVmZ6Xd7A=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 879A840E01B3;
	Tue, 16 Jul 2024 18:29:18 +0000 (UTC)
Date: Tue, 16 Jul 2024 20:29:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/sev for v6.11-rc1
Message-ID: <20240716182911.GAZpa7928qKYrt6V0T@fat_crate.local>
References: <20240716095557.GAZpZDrdC3HA0Zilxr@fat_crate.local>
 <CAHk-=whRLe=TVzGE8sLKL6140evC+NDxP0=a81WjxqCbs9npRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whRLe=TVzGE8sLKL6140evC+NDxP0=a81WjxqCbs9npRA@mail.gmail.com>

On Tue, Jul 16, 2024 at 11:15:21AM -0700, Linus Torvalds wrote:
> That line should be
> 
>   #define X86_FEATURE_SVSM        (19*32+28) /* "svsm" SVSM present */
> 
> as far as I can tell.

I can swear I wanted to do that when resolving... I'm a moron.

Sorry about that and thanks for catching this - that's exactly what should've
happened. ;-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

