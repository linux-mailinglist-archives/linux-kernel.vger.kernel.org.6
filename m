Return-Path: <linux-kernel+bounces-438002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B2F9E9B79
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6119C165C35
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182C7142633;
	Mon,  9 Dec 2024 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bulIhiAY"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305B835954
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761389; cv=none; b=CQkuVWeWnk5Dzx78dl+4si/JF2PXzNm1NaLD9QffPGrAn7PKVtQ4WZglw9mnTM651NaFAmdwy+EI0H4LPsQH8BAaAVMOupVIysT0liRUPTGgcXwF5aA0981oz1RMyjDTLUpUK+ASH5X6+Lgwh/r+LMJVQkX7r1JsQk1dczi0WTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761389; c=relaxed/simple;
	bh=SiNgeOD2CCYoaqJ4XEL8OLEwVYPeKmzfQUBaG5xdxTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rxmonu14VuDlecHQ7d3JRKBETJlP18EfU4OxZMxy5OGPh7NMP3dOOrP0WUd8ffTRo/JeITdeRLKn7MUCHeyCq/rjt+h8Yx0EwCBsHuAVKNfjh4kjF4NO+/EP6DMZ0opDT7z4bR1IywPv80LUE+n19lHqKlZnKYjWf7tIIBQtZsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bulIhiAY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C02B240E015F;
	Mon,  9 Dec 2024 16:23:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2UZxCBh-diZl; Mon,  9 Dec 2024 16:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733761380; bh=vxclhMPPNaUEG7VcdYdxZnZzzcDqnslPBEJzdSb9ELA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bulIhiAY6SOyEXNo/bUDJdmwjoaTp4NzZHl494ADPP7oUZ+zVPBUdDHP5sN+0++d6
	 Zwgs8aWXVPLWFBbPKlbZ6nYSvSjPT6E6MKIKtAVXcnwx756Y7bEVzlV8UfBzDErWQu
	 2ZMm7DdVtb5G52F/F0IerJcRhSrAYC/elu0fbgrkdN3M82y2sF9jiGcOAaqAYRsKzh
	 c8BwNMJgDqU+CisOFTqvWyMkBE7XiZr2FiCBdFYpoAIglnQhInItvV6jIwAlOduT6J
	 k8LcZtXQi+8oqLDO/O5sQRDZZClpIWL2Bu786y9l0PzE7PMP7/6+wvXnJFfN7svvhD
	 DzX/mDsePZ70AA3wY4ecAfoCjRDb3s0eutYK1gfVpeULlHaabd3s1YbivPaBcvLGtk
	 V/Wa2RFmrotip9ongAD7PLMYY3h4pvc/UV/osF3uGhzFrpIDO3Zebf9x7jBqkPgVUV
	 AffFFJIZlg+7kkQOmyNxsyvT+zgWBfEARyprJtyf2ylS9Dd44gvWuzOmztSpRqBOiT
	 Rv+ZAbTqLVjkRHwLpREC3/N1nV+pan5AwPl3oyf2eF+8eEDJuJKcn/yJ/FfLAOOTO3
	 R/ZPLOVGQYTpjo76EsfXkc958kioRRYZxz35014Wlel4iQCnszSIHiwjE9ewfMIJoj
	 oBPjCcCt54aRLTE7R8nYiRXA=
Received: from zn.tnic (p200300ea971F9307329c23FFfEA6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9307:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BC72240E019C;
	Mon,  9 Dec 2024 16:22:53 +0000 (UTC)
Date: Mon, 9 Dec 2024 17:22:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [EXTERNAL] [PATCH] x86: Fix build regression with
 CONFIG_KEXEC_JUMP enabled
Message-ID: <20241209162247.GFZ1cZVycGCYJwnMxw@fat_crate.local>
References: <20241208235332.479460-1-dlemoal@kernel.org>
 <20241209102929.GBZ1bGiT-DGK8uDdo4@fat_crate.local>
 <7ee6d1aff2da6f79e08c9a3134bc8519e991f0f4.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ee6d1aff2da6f79e08c9a3134bc8519e991f0f4.camel@infradead.org>

On Mon, Dec 09, 2024 at 03:59:55PM +0000, David Woodhouse wrote:
> (In fact, *lots* of the return path from kexec is just unreachable dead
> code in the case that CONFIG_KEXEC_JUMP isn't set, but it seems we're
> in the habit of #ifdeffing out only the parts that actually wouldn't
> compile.)

Yeah, we're allergic to ugly ifdeffery.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

