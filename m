Return-Path: <linux-kernel+bounces-561299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3879A60FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39DAC461BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327E91F5420;
	Fri, 14 Mar 2025 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="L2e/62u/"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF9F1F30A8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951521; cv=none; b=kUPinGTUp8SZIUXeKLpSrxte3sd5SgZztlDUAI2rU73qBnjyYMjQifTQxmQDymx8Mm0ocuT0+O6DGmOj1bVCDfxzcdh7Bdn7mG+I/Ao/JGhkydmDhsvfEFcVR27QK/+vZ9opaXEsJo7OhacZeeRajyjkJCbvXmKmJgocWSHoLdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951521; c=relaxed/simple;
	bh=Hd7VsClSjXYQH5mEsOYpQLQhh3q01/eVgjFjBaz26iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhZ8s605QMvUxZpMvsHxKagJz7hW8XwvVbi76QVjzc+g7mNGrEIBxqBH81xE+9HkwT/T1TfC4tgPtCShlKDAOqnOhi244Dy4Mxpz+RfzkrD2O4iO0ME4opiFcI10hrUeh54Ter9KOUZZK25hZzCUFvq65MOKOTAY9lfBrjyogCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=L2e/62u/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2A9D940E015E;
	Fri, 14 Mar 2025 11:25:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KVwuMmaLbcP1; Fri, 14 Mar 2025 11:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741951513; bh=dO/lNqZ8eNwLtz2jXK/wa1wYbq5HNRktLopvgijx24Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L2e/62u/gzRShfyYAEKdsTqwuv9r1ON1dwvxlo2J5sQ5I8dH/G7cwKXfTfjceIgnl
	 Cq/aMs3FoRUFKmUdz/efQKgwDom1Pofx7c5PWbEuw9K6LgBV7LjzPuHMnRkMMMRXQ9
	 Q9f7qGD0idLNk8Zzle/8As++PnprYtv8226eXePHL4r+sjhQvXVUkSTgWeJ2GA7bUr
	 BnWX9whw3YLE4HzaCWGqwET7U76MXEvLTz4ysI6lC1QNECBK6UKQBHYzixZ74paw1q
	 6q54xSQ16VzESGBzxsarRZftqlUIpMAAoqdyUWIarC3qC4sYiE8v/bADFjKRCxzmgW
	 pG9yz65InQUFp1qbF7hdh6bfwx18Lt6z0e5w0SlO50Zh+E7n9LRTynHUsXEyP9r4uE
	 X/WvYZnQ1sq/g3rgnly9AUjeKaphYrCoBgyvj7+iCon3Z4ZIuGdjksQUA16JKY4SAV
	 4OrB/nskCfnYjo6EEynXLznr7pcXUoT9FpZiMZK/TvbHtA7y2kboX0wnPKCpwQ3oZj
	 tCYYcmIUXW0DBsae23kvhCQ0Pfy5oPBgWsiTYyHT7lR2RJaft9bSZJl+S6+YUDBwC1
	 9lprf256P3exShv65JpMZBvUuxSv9jiZN2ky/3N/r4UJMgUuXUDAAAIatqLItJt1s1
	 qaYlW5tINXXGFVXvy9STSsaA=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9868040E023B;
	Fri, 14 Mar 2025 11:25:06 +0000 (UTC)
Date: Fri, 14 Mar 2025 12:25:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/asm: Use asm_inline() instead of asm() in
 __untagged_addr()
Message-ID: <20250314112504.GBZ9QSEL1hgjp376ey@fat_crate.local>
References: <20250314093111.654359-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314093111.654359-1-ubizjak@gmail.com>

On Fri, Mar 14, 2025 at 10:30:55AM +0100, Uros Bizjak wrote:
> Use asm_inline() to instruct the compiler that the size of asm()
> is the minimum size of one instruction, ignoring how many instructions
> the compiler thinks it is. ALTERNATIVE macro that expands to several
> pseudo directives causes instruction length estimate to count
> more than 20 instructions.
> 
> bloat-o-meter reports minimal code size increase

If you see an increase and *no* *other* *palpable* improvement, you don't send
it. It is that simple.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

