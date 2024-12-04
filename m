Return-Path: <linux-kernel+bounces-431340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 671449E3C27
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C91D281179
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2116B1F7082;
	Wed,  4 Dec 2024 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i59dpYrB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rFgraBJi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2537226AC1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321228; cv=none; b=Ht57kyxhqEgXDR/XFGMMSJ9KktKjJVDYFO2LOttiGilMmGeQs67SS4ISgX2FSjCsGc4qZEv7XhkFCxjtrP1Ub6KlkdbU9uJfEtAlCkOLKp2FH4ljB5y9imMfwrd0q0lFSnhA+vQHtOZRbfm50+fu1pn1lzNiRgygN/VC1AIUv2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321228; c=relaxed/simple;
	bh=kWkk/8ptO3jP5MaPTjOlYG2ItxP4k7nMjgwEij57qUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J0bzZkg1lJrxAy1Xou7m0DoMHsvCR29HACP7FTtlgRvV9NHt6Y9RAQBEi8YGTDYoEXMTyezsbfZ5NCfRXVYSlJgbWAyBYauJosp9Ge+UyuXWleWdZJbw6j2h8q1efJG6IBAoPRBD3/gXcmbAsCOBKhdSmWvRi22u/Fkc5mTm5v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i59dpYrB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rFgraBJi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733321225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kWkk/8ptO3jP5MaPTjOlYG2ItxP4k7nMjgwEij57qUY=;
	b=i59dpYrBRlLQ057IQD+T4m5M7lpO59XtNnXcllxm0azECg+mQR7gjCtSFJUzmntL7SJmZC
	4zukglpfsCdmJGwx5Z+hqXxpE3cxg0WvdntaBx0ncQH5XXKwOiKOfpUz4wp6dwnEcuyFZ/
	pMMZJjgzG12cBsHnukPaIOXcIcDUu692AOXGorBHtUdVj7L+d1KGhHi22yNm3CGcKUrCB0
	gkwU+sLNF1XOqir7XWdgvQDjoXoGQIRVeFN7Fc2/mjoYWQb1llLLCrCFwAlesHqPT4owFy
	K3ncjHzcFU6flsXJdmO1JgyzOgRl7iqLmMLdlbOb2k3kKRWzpQxuvnYrsx7w/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733321225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kWkk/8ptO3jP5MaPTjOlYG2ItxP4k7nMjgwEij57qUY=;
	b=rFgraBJi5MaUfQcP6GbqNvYKx9OUvIAKMYmsXvtKehJIbs0vaEMLh1hGlf9zsExS+qw3zc
	tvHpj9K2sTYvr1CA==
To: "Farber, Eliav" <farbere@amazon.com>, Jiri Slaby <jirislaby@kernel.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "christophe.leroy@csgroup.eu"
 <christophe.leroy@csgroup.eu>, "naveen@kernel.org" <naveen@kernel.org>,
 "maddy@linux.ibm.com" <maddy@linux.ibm.com>, "paul.walmsley@sifive.com"
 <paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "bhe@redhat.com"
 <bhe@redhat.com>, "hbathini@linux.ibm.com" <hbathini@linux.ibm.com>,
 "sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>,
 "adityag@linux.ibm.com" <adityag@linux.ibm.com>,
 "songshuaishuai@tinylab.org" <songshuaishuai@tinylab.org>,
 "takakura@valinux.co.jp" <takakura@valinux.co.jp>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
 <linux-riscv@lists.infradead.org>
Cc: "Chocron, Jonathan" <jonnyc@amazon.com>
Subject: RE: [PATCH v5 1/2] kexec: Consolidate
 machine_kexec_mask_interrupts() implementation
In-Reply-To: <4192766c8f02494a82db68f5732c6dd2@amazon.com>
References: <4192766c8f02494a82db68f5732c6dd2@amazon.com>
Date: Wed, 04 Dec 2024 15:07:04 +0100
Message-ID: <875xnzsfsn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Dec 04 2024 at 11:40, Eliav Farber wrote:
> I'm just waiting for a reply if the new configuration option should be
> placed inside or after the following section:

I think you got one yesterday :)

