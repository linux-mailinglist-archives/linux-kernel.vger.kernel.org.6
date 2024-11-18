Return-Path: <linux-kernel+bounces-413101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AD59D137B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2211F23304
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBDD1AA1FF;
	Mon, 18 Nov 2024 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aCpv8SqD"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFEC1991B8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941116; cv=none; b=KTi9+4LzazYc3pYCJYWs1ZemSIgLPcWfPU2CWXRKM61YoeEuWY2Buk82gjMshgblv2qVTWrv4HU01dJZ53Mqj50ZIXBRJJVlrhd9lO5G/6T4VKPqGe0EtxAXUjnR+Z5C5GS1M8bPAo0hEvd6+GGj1iPm810RSoMFyMl3LzQINX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941116; c=relaxed/simple;
	bh=/Xz0JwgX9Q0nBvQW3XLWCalr5kR6xnoUWb7e79xOnF0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pIfBiKjhXYflsHEpousNaEC3tA7yBSGOvcOoFlxpJd+fOfeYhoI7MSLcYUL3uZx24Kg/Gm4rg+2eRFnJuIvgKvs8W/DAa93pczyOqskUbLLroEFMg47RLVjgTG4lKQRpzSqUjVSoConNqgPLO7Vh4nBQoWyCIeYuxWhG4jmTTR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aCpv8SqD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A6A0B40E015F;
	Mon, 18 Nov 2024 14:45:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YtcRhVW5pzNx; Mon, 18 Nov 2024 14:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731941107; bh=PVKfd6U6svPLQmrF2zNKAKIzZMBNVASdL4LyqFRIQPg=;
	h=Date:From:To:Cc:Subject:From;
	b=aCpv8SqDH6NPH3V4l00TyFGd4RVWsAvxSb0h1zTNdAKqki98/8f+qW7reQ4akB4zV
	 J8FZ/zl8teE17IWLf+Gnr67Sx6vDh/S2xkcTJTZLUxZlVDhvyy10cDaQt6Z8MetG3n
	 qfD8b9WLRjp5tCXWWcAwkw0OF3LLUTyPuebJW+0cuJI7f2jmgj3Zq0jU4ticU3uQLh
	 OyIbR084gnGPH+W5to1I4rgPG1opDOjFXaLy2Sd3l88Bi1AQZ50+T247dUIpsFt7sd
	 NQIb1AtFu8vFMfvOHEPVbscX+7zFBt/tH0duz9mcn5RwZAKPshxspvM4KNapavf114
	 1bsUKQHMrJRBy5gNQLVKib2sFYlPvQ2KBSRYZlqcbLrdW2pY2N9nWwvuoneURDFYK4
	 +OdgliqapT2AKc8I1wpG5yr2yCyzB8f+AGZIpqKMZXDPmADFpgxCFj3US7TZ/J/ym2
	 0GgOFihWq7xeii7LzdWbF4HpKF1QeggxgLLbuwFnm3Jowil9/Jv3kis79V9ySj+52e
	 z9iqaFH/t/HGQ5RXGMq62eJG8ndD54SmruSBp+H1hn9zjZoTvFkdS9yPsjjqlKxbly
	 nc3v6USz/jmyOwb+G8E1MY3YNwYRtsSoRKEyU3BMOT/VrXIhZnU/PeknluyfhwUT64
	 72ZfuI5UwPc/pgWwvUi51I0g=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 82DC640E0261;
	Mon, 18 Nov 2024 14:45:04 +0000 (UTC)
Date: Mon, 18 Nov 2024 15:44:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cache for v6.13
Message-ID: <20241118144436.GAZztS1DHC5ZXOi8vT@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/cache lineup for v6.13.

Thx.

---

The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cache_for_v6.13

for you to fetch changes up to 9bce6e94c4b39b6baa649784d92f908aa9168a45:

  x86/resctrl: Support Sub-NUMA cluster mode SNC6 (2024-11-06 10:49:04 +0100)

----------------------------------------------------------------
- Add support for 6-node sub-NUMA clustering on Intel

- Cleanup

----------------------------------------------------------------
Christophe JAILLET (1):
      x86/resctrl: Slightly clean-up mbm_config_show()

Tony Luck (1):
      x86/resctrl: Support Sub-NUMA cluster mode SNC6

 arch/x86/kernel/cpu/resctrl/monitor.c  | 3 ++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

