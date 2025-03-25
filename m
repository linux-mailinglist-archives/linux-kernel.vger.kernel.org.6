Return-Path: <linux-kernel+bounces-575892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB94A708A0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303271668BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9A4261589;
	Tue, 25 Mar 2025 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UmuRXoZe"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CED6253B62
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925572; cv=none; b=o/aEnukADcjfX8/l+q5s2PgxhTLhSq5Ahj67T/2ntc/MS5t8k2fZDEQbBC+BsP9viaBljbTFLEn98pOUuNEHaz76mGpwBwNLzRWh1W4N9Hzk11EthFTcaxad9VInBAlM86W1/sn6M2yy0ysrmPcBoWFjo5brqU5SSgva2PP9/ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925572; c=relaxed/simple;
	bh=sT1FXNg+ECfYd0FvpfLxtsBGZr09O3/jGdSbcikuClg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIUGJ79+OWNi9tD39gJaSaD1DYdouR0fw9NYwA0pGOp71NrS2B56IzpqXAQP4j0xkKqxumZTz0HjTVI+CjJ7KsWWG97nkIC1v+zyu8JK0YfJNq9krx9i9DbyQ2nmHKmuqAk2Mtx3IO6D+Vz/gS9eeTbheCIZuwEbbmCGORQbQkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UmuRXoZe; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6A0C540E021E;
	Tue, 25 Mar 2025 17:59:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iqSqdzDzFsiF; Tue, 25 Mar 2025 17:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742925564; bh=x2+Uq6D5KKFP7YQWeHEfNGQeuCXfzzg0JrTh+N4r4SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UmuRXoZexZNG/xaVY/JwVg9P/YcLDfxoIL/cR2n2be97KZv4WEPANEMiprmxeirMK
	 46L41n/9dtx3zbvQ6tTUFdnMyWNbt8SDQwnoM/+sADpcCsfDyCgIQpousUOWZqDu/3
	 OuYe54i3GDdfMJ+km3doiBr1289CxxymlmVc33ayB2C1NOCyqDL78d14MEjmsq1pTw
	 DSbyrHbF/Nz1P1ee1tXHMYWebbSLynBMoFikYdvF83kgRFlxsDW7Dq8GbqgO6XknmO
	 bxmaIm4qQeb9yFpn9rn00bv2CD2xddI0pH6l4Fs+ZYpmauAGd7gqD9baXY4X15OO8c
	 JgqoBNXqf8kGtAesWBDUgWSz+tkaQRdBtlxWuCZIIQdX8nHcUzJfmkNbsNHDcLLj3U
	 WCGEPx/DHT9BmI508N/E/wV9/pj+PoL4q5RxUmRkW9yvXRrojYHPivZNysCE4pJTVg
	 Z/E8ImXcc4uJZJa7YKed+eNe9qPN46tlS8GjAKj9JIxY/oOWZI2Yn43rtON37UlcX3
	 ObC5D880eZ8C330eaieAkPuUrdqfNzEfsg83Hhyd7kx0XCBc3VYwnHlMw5gfWBifcQ
	 bM+y0lMcjpHM6HUstGmJrXjbQC7PbdNOIA0HSKu1kTQX+GONQrEgnz7CC/ugZkrxzD
	 UGN8M8Hju2YhdFMMvQzHqie8=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1824E40E0219;
	Tue, 25 Mar 2025 17:59:16 +0000 (UTC)
Date: Tue, 25 Mar 2025 18:59:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/2] x86/bitops: Fix false output register dependency of
 TZCNT insn
Message-ID: <20250325175911.GGZ-Lu75TMFAML7gNf@fat_crate.local>
References: <20250325175215.330659-1-ubizjak@gmail.com>
 <20250325175215.330659-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250325175215.330659-2-ubizjak@gmail.com>

On Tue, Mar 25, 2025 at 06:52:02PM +0100, Uros Bizjak wrote:
> On Haswell and later Intel processors, the TZCNT instruction appears
> to have a false dependency on the destination register. Even though
> the instruction only writes to it, the instruction will wait until
> destination is ready before executing. This false dependency
> was fixed for Skylake (and later) processors.
> 
> Fix false dependency by clearing the destination register first.

Same questions as about the POPCNT patch.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

