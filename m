Return-Path: <linux-kernel+bounces-252622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE5A931602
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E2728314F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8901B18E767;
	Mon, 15 Jul 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="emzY4IRu"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F2B18D4CE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051043; cv=none; b=L4cJY1wqoZw75cdzOaXJeQsc5QDPUJJFj6JaaDrEcpDsPVkta2jPJJjgI1N5WDnG7v91E1RTspguWwbXVKl+PgGm1e7a06bpYezgpcloYCorsxYAEGHYS7kVf/jzC+NwHBHMbke7NexVyvRFlCt4xPzO6zJGIC3AMqBaT/0q95A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051043; c=relaxed/simple;
	bh=kI8z31pvmkACsoY4R6xD2r4WjAcXm/QhY0zJzKqHpRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vn8P+q65x6fYpnJPsORkPtu6sWZ7+4KYbb59W6kiJwkklOCJBQiWWbyVZj6qqkaHKcj7ERcriexqcZafiUYAazX0BtqcUvHqxWEx9C16PtCoGK8HV5KGi1YURnVv5az6B/WA/LqWcaYEamifAZwOPDWmh2ZcUGUvWDRIDuL7ZhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=emzY4IRu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8671040E0192;
	Mon, 15 Jul 2024 13:43:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vn5LfA3idBTd; Mon, 15 Jul 2024 13:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721051035; bh=E+7GeEIa7s6ZzFSriewwh96Qj6j59sXyizWzr/1bfmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=emzY4IRu49NieNZq8jabnJ/O2KblA6d0LcncapU3uS7udK1x1zu9MdEh5hU4ZUFGF
	 WVlkAceEEeD7tOLVG/uhOubtnvRHalRQDFwpuYDqol2Du5c6WfnDabLPYDCRqMaU+H
	 hWKXjf+KXOFlyZ3yTH6hDonHrmz+RQDRnunRrismGyLrbvGcUohoyRnV7iodEGeg/c
	 0g5f/oj1OwTJRNsBWSsJFPTt7F/mlYu+rv0l0JBtMAeUkKYk7feMHgH6v1G5sSZ15g
	 sn8RaCZZp3vJtqT1dxiMoVW187/6ugnf11bEfF5qHbH3QFSA2hyQZP7ScRS7FIecit
	 KQJ4rvNlVPUZ7HSyyYW41clZwVJeHaDmvTQqmn3VfdaT/o3hyOc3MbFa3Z+r84z1lV
	 I3X6hUKlCuXFehl4OoUe4cFrMRLSD0OLalk+DXPOSz2oR0N+zapubSjHi72lPEYoMP
	 qootPe88ICt8kWQBFFgX1gPxpvnkOWL63oqgGGccm0z3tdeM4g5kYg9l8mKoYMqJk1
	 uhx2AqujOLSon+zXERG/madyHeqrwozq1o7TEwiDLFNfJHfK/+alkQLD1rkehXmovz
	 TZp278L3DO2aWG/AzoR8YjsHVN0w+d1XCzpDfUu51FLEMXRjMncK4naUC/shT6cFOV
	 QIDQ+t03VAPuesbyNUmkWRls=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D6B7640E021B;
	Mon, 15 Jul 2024 13:43:43 +0000 (UTC)
Date: Mon, 15 Jul 2024 15:43:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: Breno Leitao <leitao@debian.org>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, mingo@redhat.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] x86/bugs: Add a separate config for GDS
Message-ID: <20240715134337.GBZpUnibQhORw-MpSR@fat_crate.local>
References: <20240422165830.2142904-1-leitao@debian.org>
 <20240422165830.2142904-2-leitao@debian.org>
 <20240712172132.GFZpFmHBJHte2xS1fr@fat_crate.local>
 <ZpUSvl5eKgkLeJrg@gmail.com>
 <20240715121703.GAZpUTP-8TJpZBCWne@fat_crate.local>
 <ZpUlmf/iVgo78h4J@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZpUlmf/iVgo78h4J@gmail.com>

On Mon, Jul 15, 2024 at 06:35:21AM -0700, Breno Leitao wrote:
> Regarding this patchset itself, what is the patch forward?

The path forward is for you to wait until I've gone through them all. We have
merge window now so not in the next two weeks.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

