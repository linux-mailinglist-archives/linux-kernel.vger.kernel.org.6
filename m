Return-Path: <linux-kernel+bounces-421417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 421D59D8B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A3E284625
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75811B6CFE;
	Mon, 25 Nov 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YoxLP3lQ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F3F1B0F2E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554588; cv=none; b=bSjaBDf22OJnwX1ZtOeT0uOHkJ/UZqXIht5GGIK8UNqdb7Tbt7LxNT6hmbbrCRIrOPzmBFX76ISOE/xRb8+U1DGsoph21TXBgrhFenPxeArCiPb867scEBMrBsfPTHMfS+/FN8aDoBdcLO1tguDPlA+EhY7J1Qrw/dNIYJCGvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554588; c=relaxed/simple;
	bh=pXwO1LYjPY4ljEAgE1Bxmvf14iyYOr2bWLACupLRrbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlXL9MPAbQY42SX+3+R5na/XlTmFyCFF+kvLUvTSVUrE58/+Zwil4itFFtLSQwvXJLGvY4Tmw9x8VZD3TPvDCqVQemMkV7j6jt5J+QwWlQF99rqiWdAhyuObdhkAf26wMNHOgF3H7OJmHPBqi9nC7DIq8r85e4UDRoCxrkeCD/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YoxLP3lQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 94E4040E0163;
	Mon, 25 Nov 2024 17:09:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id okZUO01E82yE; Mon, 25 Nov 2024 17:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732554576; bh=qVRtjrx/b/IlbScVpe4e6FZPtxTqNmI4mpQjzC6YXdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YoxLP3lQwU2HAAPXRb9WUera8Ygm1SCxnXrDHdSN9cgoF/q/UjGP9lkmsT3qfqX27
	 vZi5jyME8LguN4NimUdDhsTydv3My3foBJC31AbCrBJjAkB4yv8NJdM90qzQCOriLM
	 /cJcSeFoPVH+p3x/3ni0ltZTBxD9BaTdJ+P5g65BMDcDSSAHzt3a2neuhy+NfkG5qB
	 J0DdhxvjoI2CsiQouLneur5PtImlmwfFO2mLYj3lYN1hC8j/n3Ki0mKfQ4UlV7pDR4
	 4hhdRsp8eYzti8dncVnhaqjKhGWQYK3MmUJQeYlok1EScbhQdqGLOqnrOOenYK0zLd
	 WpyUDUS9LdyGXWCcJ4PMJmmnBjsfWAV0CMvyNFkd7vAIJvj3vCSHbu30h2TWIR0Oi9
	 G44+oBnikN7P3cwf3B/TXOZ9C+4/datVWx9rI78V4Q8VyORDmuH2aqY758XpZvgyUr
	 d0EBIWKSXVKSXJW3+79Qbcn8ITDorgVFFIbOVNWCyfC6SeauG1GTMWDcptv1ZEPQIE
	 4o9sB14sn3hPNAFW6n2SD6AhYlKzNW+4vPDQuditiHtJpli7BG1B4A0lr77P2q2Io/
	 A1B0qkUPSaiNZQ8xI2KiZqk0gQrza3/81jeTl02QTi6TCkKWcOsiFPnZfC4rfeCuBZ
	 cb1nUfMO4pW8dXM6A5rLJoV8=
Received: from zn.tnic (p200300ea9736a192329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a192:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D664B40E015E;
	Mon, 25 Nov 2024 17:09:30 +0000 (UTC)
Date: Mon, 25 Nov 2024 18:09:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brian Gerst <brgerst@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/boot: Get rid of linux/init.h include
Message-ID: <20241125170922.GDZ0SvQj8FgK0ej8F3@fat_crate.local>
References: <20241122163139.GAZ0Cx63Ia9kgYgRIr@fat_crate.local>
 <Z0C3mDCngAf7ErM2@gmail.com>
 <20241122170227.GAZ0C5I-F8AUpwCAcG@fat_crate.local>
 <Z0Q0PJzTMg_Or22I@gmail.com>
 <20241125102223.GBZ0RP375DufF0QQds@fat_crate.local>
 <CAMzpN2gysxoKsjGhdSwykxQ1a_F0pZG=j6Y76QDgSmNG3V7SPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMzpN2gysxoKsjGhdSwykxQ1a_F0pZG=j6Y76QDgSmNG3V7SPg@mail.gmail.com>

On Mon, Nov 25, 2024 at 11:57:37AM -0500, Brian Gerst wrote:
> How about removing the kernel headers that you don't want from the
> include path?  This is a part of a broader issue where different parts
> of the kernel need different compiler flags (main kernel, VDSO, boot,
> etc.) and the current makefile structure doesn't handle that very
> well.

Right, the idea is to remove *all* include/linux/ headers from the
decompressor and have the build break if someone includes new ones, forcing
her/him to properly split such header and use asm/shared for the common stuff.

There are examples in asm/shared/ for that already.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

