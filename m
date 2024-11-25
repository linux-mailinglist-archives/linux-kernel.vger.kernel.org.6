Return-Path: <linux-kernel+bounces-420812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B399D8429
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E864B256B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335DA18FC70;
	Mon, 25 Nov 2024 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XNYZ2/Yp"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229ED2AD17
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732530166; cv=none; b=m+XWgc5Frkwsc0nVPYQKli3D+k29aakWGirNgXZmFY5OHONEoNSn6Cx3OEGvsNlxKHS6rE1b0XSjlIAb69DGlMN2XFgQfy7Mawl30DvyywUnM0NGgaMylyyuIxu47H5VwWi8V4NsnWdGyahB4s/3YlPU6x5SVCE+/DAFByS8Ba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732530166; c=relaxed/simple;
	bh=kzYf+6PScgXD4sI6yVpCX7oxhaUPc52Ia/vLyPOEo1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUeQo5EEOAX6mGHMgDuOKhDB0y985vhPPUC/YcL75VdjlW1nVlFEYF+Qx+w5Me4rz17KGhEfnd8QdDEiixQeNb7mRGG3TMMcW6PNMIT591G2zRmDdCepIiB7dPm0Ohfi7gb03gAFtJU92HXpmNmAP0ed9G/Ornzqb1Htat8myMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XNYZ2/Yp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 84CEE40E0163;
	Mon, 25 Nov 2024 10:22:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id W2qTVURu9ady; Mon, 25 Nov 2024 10:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732530154; bh=CicIqlTfk/RV9e9jhUxJ8Q4nlFktb1GQ71aDtqFOiMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNYZ2/Ypu6kSG+430qUE/SnvgfAik/Fo6s69E05Jp+hjoa0SeFj3zAJKPogoRFPwA
	 Lvxli8sNHct+3/t6kCBQywrL0sCHLpquXytisdze7Y7jBeES6HGlid9S+9svF1pvA2
	 cZcpo0tmXJhfGmW51e4VT++BTx6USr+gQLNwXWigs70U2fhw4zgEBD9b6Yuqnm2xW7
	 Qr3j591COh8HRVqRMyXOB8BQC8n8f5DF+3jJ+9PRIf0z6QjZmzseD0rj+tRuUhtSZn
	 dWNSIfMykuJv02SAE58CWOk6I1y2nTswZ94bsoMzPEFpkW9NYdVlR3WQ4SjcHZ9pSn
	 OatvrWyuvyN4rIh38Ep0+w/FJihKdTZKrn1xqUF4jlV2t+uVrJPgZwwMDWkPudEbfq
	 wxRfa+WeZ9nNBFNVhkCYA7ZV5wDZggeHhlZb5cAgcSpIbmpQyO/WnSIzafzjA4S9/B
	 +uDgKAr+GMdl5Ah+RiS0tat4xzmMWeAkAkY/+BVV6HO18YGr467zj/Lx8hdejrkCRm
	 ErbEBbC4pkjScf4bbcxdMWAm9CC7sqwN9WPjUiAknPpPi7A4x6FYDpV/wQ6uwno9pE
	 l2Vd59mDPqe3nEfZG8PpjpkrkuZYkaaS31a9XZsrPYFify7kzVj8UzaP052tPLutCG
	 s+AlBkrkNZJygfw7Fi9KsucE=
Received: from zn.tnic (p200300ea9736a192329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a192:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6AF6140E0269;
	Mon, 25 Nov 2024 10:22:30 +0000 (UTC)
Date: Mon, 25 Nov 2024 11:22:23 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/boot: Get rid of linux/init.h include
Message-ID: <20241125102223.GBZ0RP375DufF0QQds@fat_crate.local>
References: <20241122163139.GAZ0Cx63Ia9kgYgRIr@fat_crate.local>
 <Z0C3mDCngAf7ErM2@gmail.com>
 <20241122170227.GAZ0C5I-F8AUpwCAcG@fat_crate.local>
 <Z0Q0PJzTMg_Or22I@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0Q0PJzTMg_Or22I@gmail.com>

On Mon, Nov 25, 2024 at 09:24:28AM +0100, Ingo Molnar wrote:
> And if someone doesn't add the ugly KERNEL_PROPER_HEADER defines to a 
> new header that somehow gets included into the decompressor build 
> virally, it won't fire either. I think it's better to concentrate the 
> uglies in the 'weird' code, ie. the decompressor.

Yes, I'd need to think of something slicker...
 
> Also, what's the root problem being solved? The changelog says:
> 
>    > no collisions and ugly ifdeffery when those kernel proper headers 
>    > get shared.
> 
> But that's pretty vague - is there some recent build regression this is 
> responding to? Which kernel headers collided with which headers used by 
> the decompressor build?

The sharing of headers has always been a PITA. Because the decompressor is
different from kernel proper, the moment you start including kernel proper
headers for functionality, you need to exempt or add ifdeffery or do some
other weird dance to be able to share those headers.

Things like below are only some examples.

So I'd like to separate the two namespaces and only share common functionality
through asm/shared/ and avoid all that ugly ifdeffery and workarounds we're
doing. Because each time we have to touch the decompressor - and we get to
touch it a lot with the confidential computing stuff recently - it is like
a house of cards.

I hope that makes sense.

/* Use the static base for this part of the boot process */
#undef __PAGE_OFFSET
#define __PAGE_OFFSET __PAGE_OFFSET_BASE
#include "../../mm/ident_map.c"

or 

#define _SETUP
#include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
#undef _SETUP

/* No MITIGATION_PAGE_TABLE_ISOLATION support needed either: */
#undef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION

or

#define KASLR_COMPRESSED_BOOT
#include "../../lib/kaslr.c"

or

#ifdef CONFIG_X86_5LEVEL
#ifdef USE_EARLY_PGTABLE_L5
/*
 * cpu_feature_enabled() is not available in early boot code.
 * Use variable instead.
 */
static inline bool pgtable_l5_enabled(void)
{
	return __pgtable_l5_enabled;
}



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

