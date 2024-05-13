Return-Path: <linux-kernel+bounces-178055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920928C47EF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B28A282ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BC87BB06;
	Mon, 13 May 2024 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DR38NjzX"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF7F3BB30
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715630391; cv=none; b=W0oe0IFoLTrm/GPJMCFvubP9gEwAVO5D0TSMzWFHOCUeYPuhsOsmhCkjP46Wwrvmc0b7faQmpqrLpL1uBrlrzvMXZ2AjVZBRYWGB69ICv73eXCDd28OiqtvL7NMwp6yE/xznRiThT9gBVs5ygI5dttjRpquQh7GOlTHDA9doV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715630391; c=relaxed/simple;
	bh=u2kECm0nE5tU3MlD+0KreDk/UwhUrB7yFDHWOW0Jr5U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gcQzJO86tevQhn0UX75kUYllp6byRSHdKbU8ldAsP76QQYVvPceasyumnTmQoO3d+PBbQdB8VloU/GGuAKBy0w8i7ktoKyLFteXpDGBB/MgZz+kyGmbfcPoUi0utA2PH7rpDtOTHc5syKvdHl7o3JIT+0UPcv7eV7xQ2w4PCMTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DR38NjzX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0925140E023A;
	Mon, 13 May 2024 19:59:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3DmHYFnpBOdx; Mon, 13 May 2024 19:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715630383; bh=4P2bx3eenjneHPIbVS39LKraKJOMBfBSdjLyKwoj194=;
	h=Date:From:To:Cc:Subject:From;
	b=DR38NjzXWdhHGp4l2R8rvIBOPIbc3uNPaRm5tcrWwybFLlTUJn25VCG4uhPugALfZ
	 ZzgF5BiY6l3o390xw7D0jo6oQ2OkwxjkmC3/+lNekcDJ28sbSHF5dWfyaqNk9Locix
	 J1HooP7RZj5b4AfWCZOImvrQx1Gb1QoOdNYdURCpflQwtDuH+ddblL4Ap0PyCXZi7s
	 6IFFJ6WX+Da3wnA7MwxnpAPkjvyHNmh1kNUVVjZLOr6+JK6H31COiYPu41EM4SpAWm
	 +92gJuJ2nNAybB9TlHjZigCI/5cHZRp5Cr2w08mCClyrqX0z2npMwd7dPLvInuxJbq
	 SWKnujXuFo4UiEXDpwEvwW/9/XszL5Idf3Mrs0DF2oiVlB1cfXL0ng5Y/857MSYQh4
	 vS+s3iuWbC9hWhgP1XcUCcUIYmSHVZ97Hix3cEkHODtMUSuUpLSchND8e8gmHSxwp+
	 TuZE83yO0nZBRoOwPKdI5DZgRjm+HiFpvEmWC7Mc+khoHNs1zvuw+hhyKvCimY8SQI
	 +7bAPMx5T2+OKUnSAWFSrFa/UEOSfHpk9a8NKSIcR0baS7vB9DtbTgdZsv88Oefshq
	 R4CofFxiQRvKoLK5BfnHBOA2oZH5nb1mhHhDJfqkC3MTd+4JM+1vbnSZZ+w3O5Zpaj
	 +0i5e82YVAORm7qzbWws2/uU=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD83640E016A;
	Mon, 13 May 2024 19:59:40 +0000 (UTC)
Date: Mon, 13 May 2024 21:59:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sev for v6.10-rc1
Message-ID: <20240513195935.GAZkJxJwqejWsDqPN3@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a couple of x86/sev cleanups for v6.10-rc1.

Diffstat is a bit largish but this is due to code movement to avoid
forward declarations.

Thx.

---

The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_sev_for_v6.10_rc1

for you to fetch changes up to e2f4c8c319abd1afbedb7a31877cb569265db1b4:

  x86/sev: Make the VMPL0 checking more straight forward (2024-04-25 16:14:25 +0200)

----------------------------------------------------------------
- Small cleanups and improvements

----------------------------------------------------------------
Tom Lendacky (3):
      x86/sev: Shorten struct name snp_secrets_page_layout to snp_secrets_page
      x86/sev: Rename snp_init() in boot/compressed/sev.c
      x86/sev: Make the VMPL0 checking more straight forward

 arch/x86/boot/compressed/sev.c          | 197 +++++++++++++++-----------------
 arch/x86/include/asm/sev.h              |   2 +-
 arch/x86/kernel/sev.c                   |   6 +-
 drivers/virt/coco/sev-guest/sev-guest.c |  28 ++---
 4 files changed, 113 insertions(+), 120 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

