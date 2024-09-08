Return-Path: <linux-kernel+bounces-320087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5751E970600
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00521F21E5A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2609B13B78F;
	Sun,  8 Sep 2024 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FoiaN2sP"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE9913634F
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725786733; cv=none; b=Fpl1XucWFQMfpyMPfmQSoL5TPvveRPxJ+Ur6SMpw2I+q/ZJzpV0uGTpPsDZxdsEMQtOoV48LQ3/7XDPPYErML3cELO6dT49ARCa/TpBogzlwpsmSyw5AYmNR9aOSupalbRzEbpxXi4Z4kX5cJpM1spKDAW9sVYIiOJqOKeUDtfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725786733; c=relaxed/simple;
	bh=3mUaNwJxoetmMOhsCNXpNJY/Sj5TJHe9Kvm9AMgyWxw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PzDuV8Z+rYm3BipoQTizhdlASBhR1R4std3u36nnPYdNEd0nU3gObJyNIyh1H9J7OWSpN6W8tZuzqjQqxSSc+sFuLINJSTS3ycYNGsLWso/So8m5uRKsppE9RQYr9A/wgWOXSD/Uli87lUfGfXhD3XiWShLZ856OHM8tYkUJfkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FoiaN2sP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B492B40E0198;
	Sun,  8 Sep 2024 09:12:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id s8hhTfzOpYfJ; Sun,  8 Sep 2024 09:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725786724; bh=ZQXhS2ST16sMhfnDLTdHEl99s6OAVudrs7LYT80/QOA=;
	h=Date:From:To:Cc:Subject:From;
	b=FoiaN2sPx+CPUPybF4KdnT7pN1hsgY6Nh9mUJx04QKZQx3pP1d8W3XO1CNtmu38tn
	 JWrgQO0eDOxzaryYVPxTL41+h/Cso5nZwEmDfy2nlnb/soh25zyBorH59xk7s5cNRr
	 aEBADvACUkMpA8hl1mGdmMEuWkqdLFXb3n3Iap/RfEVA0pSk7aFZ9XuI7EX4WEWKkh
	 iECNbaxhDKamiyBaJ28am9VzdCLdWjTbiXxCm53SwEahW324m38tZgCb5JIe5fxwl5
	 ehZb9nsH65ErftdVxuXOIy7nTdsPXiCeKVHWoC0fn3AePT9pcXCL9DSvtXbvANnOsV
	 IPTqs/mnhGJA7+wamMCOuzjoBQ8F4xeIWa8lO5JHdlfIZPVe5v0jHPGEoSxVsYjCqd
	 5yXVkgUhO4OkxAfgzpkezL/eLee0gNXrwr/Tfv2BEnV6MWG/Z7urHahIa+FQLXpKOb
	 XoEKg1nXsRGNOhL6t3i539TqrAZ4gRH/ST25yhUK5ML3ymKZTwhusDuHHDaAop+9Tr
	 h9nGiGA0CO4wn341k9auEm7U96VUQpKjqo5ni8R0U+Szsn2AD91UGksqQvHSgWnL6c
	 08NAuejuv7/ZpeXEaoOlumsMP5Mx74JwNHK0fVEtisE62K880vqkmVUF+XJvIxBzhH
	 RW7gtyGKCJYoztgVPVMBcWyQ=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D83840E0185;
	Sun,  8 Sep 2024 09:12:01 +0000 (UTC)
Date: Sun, 8 Sep 2024 11:12:00 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] timers/urgent for v6.11-rc7
Message-ID: <20240908091200.GAZt1qYAzqQjCa7H2W@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull clocksource driver fixes for v6.11-rc7, courtesy of Daniel
Lezcano.

Thx.

---

The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/timers_urgent_for_v6.11_rc7

for you to fetch changes up to 342123d6913c62be17e5ca1bb325758c5fd0db34:

  Merge tag 'timers-v6.11-rc7' of https://git.linaro.org/people/daniel.lezcano/linux into timers/urgent (2024-09-02 11:56:59 +0200)

----------------------------------------------------------------
- Remove percpu irq related code in the timer-of initialization
  routine as it is broken but also unused (Daniel Lezcano)

- Fix return -ETIME when delta exceeds INT_MAX and the next event not
  taking effect sometimes (Jacky Bai)

----------------------------------------------------------------
Daniel Lezcano (1):
      clocksource/drivers/timer-of: Remove percpu irq related code

Jacky Bai (2):
      clocksource/drivers/imx-tpm: Fix return -ETIME when delta exceeds INT_MAX
      clocksource/drivers/imx-tpm: Fix next event not taking effect sometime

Thomas Gleixner (1):
      Merge tag 'timers-v6.11-rc7' of https://git.linaro.org/people/daniel.lezcano/linux into timers/urgent

 drivers/clocksource/timer-imx-tpm.c | 16 ++++++++++++----
 drivers/clocksource/timer-of.c      | 17 ++++-------------
 drivers/clocksource/timer-of.h      |  1 -
 3 files changed, 16 insertions(+), 18 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

