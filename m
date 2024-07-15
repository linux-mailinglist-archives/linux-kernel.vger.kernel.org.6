Return-Path: <linux-kernel+bounces-252542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D8F9314F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0CF6B238BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386E418D4C1;
	Mon, 15 Jul 2024 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="a8qwVFNg"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654C618D4B6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721047789; cv=none; b=YU92UOLXvJ4mXPEeScC9qJNdd/8/z8E9lf1f7651I3Auwy7x4bZHyrjhGK1cXi6llvofIfC8QCjU3lQN4vveKYkRQPPOD3qFbGcBiwp69XlNyP7sE/DRWXwx7SHNODiCIQbapWmkg6U46NgJ0NA/IqpokTedExy0c+dzgmw8Dos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721047789; c=relaxed/simple;
	bh=8NHcAmJBwzoEecPBjYWWhPnBgoSd1c5fAOoFedzNxEg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X0LxUjE8SGTikVUkSXWKLAWvcIsA+Y09wY7hFoN8SJ4JoGjol0PpSkuJI5d+9MXsIot2mFdOlFnBYMZAMRfv6LCg8fZCsX3BkrEEQ0/HKBxaNzzJTbH0YTLbcm+Czk1iO5k4vZ/LC+ESS0GahHY+GI6lkFQXYBcwVeG/CyoOsLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=a8qwVFNg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C7B8840E021B;
	Mon, 15 Jul 2024 12:49:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vzigpvkzmgAb; Mon, 15 Jul 2024 12:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721047778; bh=pB7ToCsaJAraRUrkfovikSOiJEcWiJiPOl2TiEGIKPk=;
	h=Date:From:To:Cc:Subject:From;
	b=a8qwVFNgXFQwOKbVdtRKxEA5mwNyR5QP0ahbZrdvexmAjGrCpQaK2+Cu4FSGEwX5+
	 KWNve/sy1amyaCSngRG/f3RzfPmVyzxFvciASf9uSMOkbHjOay/7xi6iee7Fvao84M
	 dmCQES/2ztSFjFM9g/xxcdYOreKpSRXcVmfkBxsko5BFB8/N8LADg29yZktkTl+d0y
	 MoAVvAFbHEqUERbhmWhAMUim5PrDbknRgFcDxl32WrVg7Y7v57PxTZuBJZ0qXVibKa
	 FK9j+D7KF3JeXSpzasEO4dRkJhe1wa3IrbHlOp6OJUGu/u2dek2j/YdvDf37okUYTa
	 VD777/orq1x2u+dIBtZjjG2m742tY/4NZkIvM2TcA1PihGsuYAbie32fwA6vLfRie6
	 tyjYIGEA59Uyuz/cKARRs+2Uy20vAbltgV6+tLKAxg43UR2B+c1gnsheLw5M9jijvW
	 FezoRKTegEIMXfpFeHpuwW8d8p/fk2W0ugR+DPwrLZMazdQCRhSei5wxlNOGcwZ91J
	 SsOZOzZGcSCUndNZGRGXQYPa+Yt1XSqxnFUaId7wDoSxfhUjP5ZUHa5K8OPnboBy5t
	 O9rAJt+H1mBMPS+YNA5cxdj3Ll5pLfk795SZqfYlIZ0JylzakIQ0wqr3T8RgxOVXmX
	 uD3DxTTmXZyfPfbhePKnJvTU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4413340E019C;
	Mon, 15 Jul 2024 12:49:35 +0000 (UTC)
Date: Mon, 15 Jul 2024 14:49:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/build for v6.11-rc1
Message-ID: <20240715124929.GAZpUa2Uq4bwobX420@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a single x86 build improvement for v6.11-rc1.

Thx.

---

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_build_for_v6.11_rc1

for you to fetch changes up to 469169803d52a5d8f0dc781090638e851a7d22b1:

  x86/kconfig: Add as-instr64 macro to properly evaluate AS_WRUSS (2024-06-20 19:48:18 +0200)

----------------------------------------------------------------
 - Make sure insn support detection uses the proper compiler flag in bi-arch
   builds

----------------------------------------------------------------
Masahiro Yamada (1):
      x86/kconfig: Add as-instr64 macro to properly evaluate AS_WRUSS

 arch/x86/Kconfig.assembler | 2 +-
 scripts/Kconfig.include    | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

