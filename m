Return-Path: <linux-kernel+bounces-437740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD16F9E97E6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC2118850D0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36381A23AE;
	Mon,  9 Dec 2024 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JbCbYDjX"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FA623313C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752531; cv=none; b=jvZdUcYAocs87yAmkSRP/ZYK2Z14ZPr1J0LVLUA3brd0ACCcwBAJYk745MTvisD3Ougxmdy6g+z3usPOukU9IjxIjdvrK1Y/B9PwMH6+KN5IKJZnGp3tgTjMZZxye+Y/WyEyW19yb9UaEsYCAl/SyJIroinf/UEEog9ECVTN1zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752531; c=relaxed/simple;
	bh=NHxTXnftAq9FYj25cKxNqlonaN5bCPigEJYX1PeHSiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tA+/jJ0PKd48zntPlXrXMoXjFBDr4xYPjCPoGL2uC0f7VAvDEOZ86ZtvVN1SK4y31ZuJ5mGRUppRg6p9otsvql1lLG94u0ju7sH0FK7sjORFJ1AfgNb99OavW3FPV/0+Z+2QjIZlP9FbyIiK5YPM+3WFZ80EasO3lCgoUfTsFtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JbCbYDjX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5858140E0289;
	Mon,  9 Dec 2024 13:55:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6X_h-SIK_IeU; Mon,  9 Dec 2024 13:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733752520; bh=BZa1ECv9TcBClCxMLCM/qf5bpxVRhOd7AvnD3pm87t4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JbCbYDjXB1ZexYsIlYvm5L9TD1StmzoW4q5byuvvK3EHom3sayPFbgIYiXl6QuaNI
	 WBNT/Fp0FTTl9+oF7zkhJ0r0z0ks9g4sqbqYyntHDfmcVTl+B+Vfmvafl0twPKrFZQ
	 MTGBk8iR84wpCWKBvEiqSoBnRnSQVlpk3SqzUlivjgTlHtKfSMz3toLNoKxpub2Pb+
	 6iQxWFQKxf4djp0DdkJmV3h594iKPbaSFBz9ifimiU7GAbLjYLns0RPv3hwEwNu2CL
	 20+v4/vbEbglmuHtY3IwaDXh3kJgMbF9ED7LoedGswvYlkMI/amZgbdOTfzUfm/D7b
	 HlbNVzBLUlFGE7K6RH+VtZgC7c49XTeGBBMcNHQz/Pga5s0DKMqyr7RlvERy6TkE4H
	 qPTAt/9jWCFaTYpbK1uJo1+f7ptPs2t5UH06BNOw31rO0a1pPh9CsbjXomowyCd27h
	 MLlksWaZeGabafB+8NsYt9WnvnVOyPbSuot70VS4SYWHcmD6ODqMOq+MSJVxG//6sr
	 LUAaHT92kc17WO5enA0gbOepW7XHv62DNbJ3fyUpV98cJWyV0v/U0Dk5yH3580+/8+
	 Q3PkeH1u8Zo0dvFk3Hcyzy5ua4C1a4oHWnnPhWSeUOy+/0c0Oj6aceW4TI1g/8Lj35
	 PBqkEA89v/ezehgeMnNEw79A=
Received: from zn.tnic (p200300Ea971f9307329C23fFfea6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9307:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E1A240E015F;
	Mon,  9 Dec 2024 13:55:13 +0000 (UTC)
Date: Mon, 9 Dec 2024 14:54:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Fix build regression with CONFIG_KEXEC_JUMP enabled
Message-ID: <20241209135456.GCZ1b2sCBrLkLitHra@fat_crate.local>
References: <20241208235332.479460-1-dlemoal@kernel.org>
 <20241209102929.GBZ1bGiT-DGK8uDdo4@fat_crate.local>
 <1ad3aca1-9e53-4595-a01b-a5f6f2f65f02@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ad3aca1-9e53-4595-a01b-a5f6f2f65f02@kernel.org>

On Mon, Dec 09, 2024 at 07:34:54PM +0900, Damien Le Moal wrote:
> The build bot uses gcc12 for x86_64 I think.
> I have gcc 14.2.1 which is what comes with Fedora 41.

Yeah, I was able to reproduce with your .config and gcc12. So it is
.config-dependent.

In any case

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

if Linus wants to apply it directly.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

