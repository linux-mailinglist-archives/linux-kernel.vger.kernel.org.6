Return-Path: <linux-kernel+bounces-437160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDE39E8FCB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70A7280FF1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3F921660F;
	Mon,  9 Dec 2024 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="atnxlsU/"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B484421660C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739134; cv=none; b=KBKZGgE4S6Gv+WbwzCRP1G77u+KuFLxLXp8cR/xblZI/X9EmfMj0aBO8PAPZOG1WDJPfIX6j1QcExywSqO5H1zhHujWNg7DcUGafB1NeX8aW/oR1i/4xFvdNG1D0KbAb9xu8gdnlEBFW0SO9kY6DRH01BzYIqNlQx/jARX4nG+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739134; c=relaxed/simple;
	bh=m52EXTc1ZMKOMX8hnut2MH1/0oerVOK2fU+ivpdreDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WelfP7C8cOO/pgVl2zONX8tw/HKwmp6XeIlaIdbpJA/xMOHhsVA6n3ckCB09BMuhUT5MGjhXGUc6lwrVoeyFRcrnF1zWDSIqBlVLLU/S6qPfLHjc8oBGsEDgrI9fILpZdSrNrqX6PQKMem5GDRM3/TLMgHqIY8veD37Mh78URLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=atnxlsU/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 971FB40E019C;
	Mon,  9 Dec 2024 10:12:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aFCpefXij5jv; Mon,  9 Dec 2024 10:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733739127; bh=bX9dqnipS2YZio0qyvxHAZebd9NHe/FUZqqC0LukZkQ=;
	h=Date:From:To:Cc:Subject:From;
	b=atnxlsU/VIY/3HWzneASS9mezjCRgGsecwWUBRCg8lTKHfKylTICXJwiqgb5uvlgH
	 PoYhxpTc9iMAyPdU89Nvt46hMOXa8b0SoBOr0sU+Oh05DRNjcyYhlcPhQhBcPLs4O3
	 OXhgZ4PgaTk+D6vBDnQTvShkZV9DjLIUElSK3I2K/mzShKqrit2dxsP1s6otT/JV1/
	 3+ukZI4uXukMmM943DWeebhexHYuZjXNMUJCAWa/WfdBg7u9XeJHxybyzQg4p/R7oF
	 CbZoHeRZ/NfYOf80BAOTCR6HphO2NRKlLBjsxFgxRuh9WQOG9tW+EsGgbW0gTWVF23
	 o2dgpY4nEGAGwEjExz75Vfagye/Sdfau7Az8Vc55KBKw7ePVOe852F5JXEUPEXpdCM
	 Rz3xxwsJj2Di70XoArpzIZ2fuOsew9FXdtNsL0vxwrgoYKCcCivwodbgU+ZVzklpON
	 UO95Fqms0PM+DlGQDeX/892Gk8HWBWgRWpplvzc1AU+whkw4ZoKUft8WuUYlh1cCKC
	 gCWrvLImLEAMvgeGwPBQYrDlQqkNxvpRjCHdGZCT78Zglr5bs3IMYqXMHrpMCyvdzz
	 5Bcswe92DQqmRTngchBrJQ9uTmvXmRj/dQIzSDLjzfXA928JjNuDS43bPi69jtw/Wk
	 yLBXN3HQa6v7zNhuLHxuAZnE=
Received: from zn.tnic (p200300eA971F9346329c23fffEa6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9346:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 87F2140E0163;
	Mon,  9 Dec 2024 10:12:04 +0000 (UTC)
Date: Mon, 9 Dec 2024 11:11:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.13-rc3
Message-ID: <20241209101159.GAZ1bCb25_H5m4Fb9i@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the perf/urgent lineup for v6.13-rc3.

Thx.

---

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/perf_urgent_for_v6.13_rc3

for you to fetch changes up to 9f3de72a0c37005f897d69e4bdd59c25b8898447:

  perf/x86/intel/ds: Unconditionally drain PEBS DS when changing PEBS_DATA_CFG (2024-12-02 12:01:33 +0100)

----------------------------------------------------------------
- Make sure the PEBS buffer is drained before reconfiguring the hardware

- Add Arrow Lake U support

----------------------------------------------------------------
Kan Liang (2):
      perf/x86/intel: Add Arrow Lake U support
      perf/x86/intel/ds: Unconditionally drain PEBS DS when changing PEBS_DATA_CFG

 arch/x86/events/intel/core.c | 1 +
 arch/x86/events/intel/ds.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

