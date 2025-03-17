Return-Path: <linux-kernel+bounces-564285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D223EA651EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31251173283
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F81323FC5A;
	Mon, 17 Mar 2025 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kiypk5GZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6723F422
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219758; cv=none; b=YVHNVNVWXuzK0bLO49EtK9Q7G0KeODtWFxfiIEJrE6McXFfmFTfZJEMQ+wRELvPymcpS8cLx3AOYnESaFfz/8txu6+zI7GSDzVYHvhFurIqp5z72GcXh0Os+BSuundZOi5TvGOicjjn/ch8BE1OUDBK6oRJeuEmHk6NkJ2B77/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219758; c=relaxed/simple;
	bh=zvWJh3DSRJyVsIm7BvHAKzWU7gO86oXNSSAUpE5SCZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ozgY75V/YfhGd+Rank0bSeSV30tXADRNC65SR6qd0l3YBTn1vrYffyVOKibDzyayffFz/SJ6O+rHPdJzg3KcKZIW6Bt+5obkuPslXN1SRZ0YZYSxB3TBnDzazDzQTHBTtDNW1o16ZiDPqo2XIUoidvuVWJlIreJ6SWOz/j9pZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kiypk5GZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0E8FC40E021E;
	Mon, 17 Mar 2025 13:55:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VZbPGyYK4-Pu; Mon, 17 Mar 2025 13:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742219749; bh=5qo7vzYg2Dakc/vFLLeDg9RMYanszlPYu0u56xmeYQ8=;
	h=Date:From:To:Cc:Subject:From;
	b=kiypk5GZLyUWoXeMljSXjjYYn+QAbNVPnemjD0/D15MQSOX6ratMnm3VSlBsWL3kJ
	 /pKbSsUwngJvRBWiVoqJidMSu8brN+YqEFRd+bg1Rx1xzbI5n1gwlf5ERQnqK0MC02
	 bR6uHzsTkNuUi1Rc+zTiligeH6X4s6yCOQv84ZP0d+LWQr1R851mW6AzyyO8wc8I6O
	 qxsFGs97jlE0czMFpLtOvqhfXt9pf2dqaChsbZTeGHEOuTToRNN7biCBWES2K0H3lc
	 cDQlanOqapo18EmxZagt/T35VmA5GwspTTTUDbPpuONUvSdBY8mCR2fU8VnhqrXFKw
	 d/X5fn+YcszwMtYAjrUnezn9PxVE6jJIWvIhSo40hvL3R0YBg0l65NwwqamtN4k7v0
	 ZuzdruMaOcpKJeg9MiMht0IHgHllsBttcH3gksTsMmwNYEEjvrSpOO+t7VJdyHVE5J
	 ZvGL/AiARKtAFfbTQa1ZX7Q8SNTBK5eNKtjZaF3nElnBNJtK61YzJSPtSA5vHu1G4e
	 FvKHzG405xbK2h0VVqZN3xOPLg9qVunzYjUN6aCTaCgkNRZi6TbYj4N0b0BVO5w0b2
	 /WrY+TLba913JGWuTlQd5jHRIIUI08BB3drmWUtBA/zoMf+8Tuo1gU17Zu/0DAF3LN
	 cNCSVZ0mHBS7GGPs1zetxi2U=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 228ED40E0216;
	Mon, 17 Mar 2025 13:55:45 +0000 (UTC)
Date: Mon, 17 Mar 2025 14:55:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nick Terrell <terrelln@fb.com>
Cc: Arnd Bergmann <arnd@arndb.de>, x86-ml <x86@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: lib/zstd/compress/huf_compress.c:1033:1: internal compiler error:
 Segmentation fault
Message-ID: <20250317135539.GDZ9gp24DhTKBGmkd8@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

so the below is new. Kernel is -rc7 + tip/master.

gcc is:

gcc (Debian 10.3.0-9) 10.3.0
Copyright (C) 2020 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

and it built -rc3 just fine on that particular test box so it could be
something funky has happened in-between.

lib/zstd/compress/huf_compress.c:1033:1: internal compiler error: Segmentation fault
 1033 | {
      | ^
0x7f8dd185af8f ???
        ./signal/../sysdeps/unix/sysv/linux/x86_64/libc_sigaction.c:0
0x7f8dd1846189 __libc_start_call_main
        ../sysdeps/x86/libc-start.c:58
0x7f8dd1846244 __libc_start_main_impl
        ../sysdeps/nptl/libc_start_call_main.h:381
Please submit a full bug report,
with preprocessed source if appropriate.
Please include the complete backtrace with any bug report.
See <file:///usr/share/doc/gcc-10/README.Bugs> for instructions.
make[4]: *** [scripts/Makefile.build:207: lib/zstd/compress/huf_compress.o] Error 1
make[3]: *** [scripts/Makefile.build:465: lib/zstd] Error 2
make[2]: *** [scripts/Makefile.build:465: lib] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/mnt/kernel/kernel/linux/Makefile:1997: .] Error 2
make: *** [Makefile:251: __sub-make] Error 2

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

