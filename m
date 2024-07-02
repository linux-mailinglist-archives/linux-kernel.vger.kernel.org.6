Return-Path: <linux-kernel+bounces-238274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192369247BC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACAC1C2500A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D01084A40;
	Tue,  2 Jul 2024 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BNRE8li+"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B101CB313
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719946742; cv=none; b=bty3H718e7gJE6+7PmCo8mkSPzgnaCIOjHUkzB8f6KaLWS6CNVhPc70RKWbMJTpgYTcLGP5H9gGASaD8+h/9mufqem7kOVFGw3gZ7AxAdAIZs4eMgKspAbYQNcws+q6UEKcqBhpivwFChV3JA5s4y/vrEtBBGOVzuxn3BiJvCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719946742; c=relaxed/simple;
	bh=rSgaHqVZQImHTOfgOEqTu4ULIR2aezhDn/5iYMs/7bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vw/TnikM36V0Bvo914amwn+w57D0rJ/hf8yfW1BgkJyxOCScnKtk0m4Dqz/RNJTf5hbmBaMekRG4Cmy5X4EhS4lb6UPpcoYSo1IObVUCCjYX3bPTg0Hq7gSe5mBi7r4I0VLD73EJqG6b7zK0u8hKlVa0P7cOjPhGhz9iHybAie8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BNRE8li+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 689C040E0185;
	Tue,  2 Jul 2024 18:58:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RsFJfm7RO5gT; Tue,  2 Jul 2024 18:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719946734; bh=q093ooWosuu4xO1lQUGjKU525ujMW+zd9lX5wt+JL3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BNRE8li+UWwsfDIt8FNop1QVprUu99EAMtTMjo0ogkDbJ4BTlrCFr7CmE/RT8SK5H
	 foLjwwCfPOzwoWKHz/+l7yS0OV+MVEpOsKpTVjXKPqXH3G0Aumy+XxBMXKkMJXlNAc
	 2S1wqy3yna6vok1gora14mk3KQX8vqrJbhPSVk7QDWdRY8iuwOiE2krBzMMGleflh9
	 h+mCa++pvf0BTIM3EjGvb60hMiaIy74dxziHjSh6aMpIBHccw+/fS+Vx1xA8gnmxHN
	 ZoH0NOSdT2FWMxydIZ9c+yJh18P/CkdsoNpIi7LKfpew+IQpp3EdKuXo0X5mrHQYLI
	 Kwc/VGImvbQpCdDetYDwD3ZRP2kVB2pFWy4097K3y5uCqUFZ9yaEapaE8YKZevpfBR
	 7yyEcu3S0/VeRFgoOPO1vDPjnRWhDfG7jqNqdwFvuuX7mspTzsgLTKjw3ojunMJTrX
	 v+baoU7VIujDcchwaVXYuS/jNEok9Lfet7XkxSf/VL+HKshiVzd9OlR/sUcqEWdxzO
	 AMMfb9zYnaxKxIKLeHQXZ6h6d+MTX4PJUfdPZPGlOIagXLYtDKIjfU4UjL15vgHhQ0
	 Yk0msO1Bz0KiUQdC5r/FIH8e9xh6Xai8C7iOrEX8xS73TM4zLzVccUTv0Ez05M5x9U
	 G2U4eM6miaL6RKwCJTVJRSyQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 578C340E021E;
	Tue,  2 Jul 2024 18:58:41 +0000 (UTC)
Date: Tue, 2 Jul 2024 20:58:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v3 1/3] x86/mm: Use IPIs to synchronize LAM
 enablement
Message-ID: <20240702185835.GIZoRN297EJA0QgBDC@fat_crate.local>
References: <20240702132139.3332013-1-yosryahmed@google.com>
 <20240702132139.3332013-2-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240702132139.3332013-2-yosryahmed@google.com>

On Tue, Jul 02, 2024 at 01:21:37PM +0000, Yosry Ahmed wrote:
> Change-Id: I7fd573a9db5fe5284d69bc46f9b3758f1f9fb467

What do those tags mean?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

