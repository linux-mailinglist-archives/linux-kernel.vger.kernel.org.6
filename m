Return-Path: <linux-kernel+bounces-321415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE916971A2E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260861C21C1D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CCD1B78F7;
	Mon,  9 Sep 2024 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bjT1SrN8"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCB41B4C4F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886692; cv=none; b=DAZtFH/sP3KaZtrHYLgQI3hEMIl20C0gOUPG4rA8lomHRFJPbru0gm+t3frKs0rZBqyzEbfLM4u99JjyIF7BefOptdVCx4cE5JdiPRXUaoHc8Kbjdi9RgaQqMc5UVkPak8Hse8tB4woxSg5Y9Sd5ZWLuCKoSjofA3SXUWiO9ZS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886692; c=relaxed/simple;
	bh=ZpnocGD3VaBOcTHVLGeKcx/oLO7/CPdPhguOFHXp8Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gp2pTb/+QJiIOE5QprlVvDQ+wZbr8ecjvYACOtN9atROu2EUXmWQFicGI7tlQwPwTjYn5K9mGVHpBSdzJhmJhT+ArxzU3bFUuFAMFXPJyLTPuVy6l+6NIZzguZ3jvYzjZ6AtgsVMZkYt0BZRlzRHMrTm/L6Wii2JT26T1/nPeck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bjT1SrN8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 057E240E0284;
	Mon,  9 Sep 2024 12:58:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PP-SypyLXrOA; Mon,  9 Sep 2024 12:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725886684; bh=k2B8zAy6jgdBzYEuqd4KPdP5XftBCf3jUigky1RDHdw=;
	h=Date:From:To:Cc:Subject:From;
	b=bjT1SrN8v3diSo6Wd1y6V39+VL77mR190Vt3uNg9fP2M2RJiMcn8MwK8i6HPtvr1q
	 E8Aj2zQuH+ALKU0FjTa+iqwq/ucbo1m/cgNCGfPdVjE2mZPCAB3AiiGECcuE9SFDB5
	 Ryp0T+lVvb7OvaCBsYGpzMoQx0HkEvt6vvPavdlUaGfQHtbLVhEOA/jFlgOqqfygzJ
	 84qzfksjZygX7RqpJ47iMjoYh4lg4RTt0VKPuF6ruL1ZAdbZ6H8kd25kpMzfWWUehM
	 TeR3uWr0AxtH73N48R/YkveGq2v8DZwM7QzHDrpQxkVEEJTo1MP1U5vhjjgQfxf+fy
	 2vCDzO5G3FV8Qp9QaSuTSuAF2LT0jaWDl9R/pGeodV/6lw7Dze9/GJPYuxlfgf4GWp
	 zuhd/Xe1jftFkIf60PCbCTbWApVZIn6DLb32/yxSoDYTXvVzz5ri58Kbr/OvtKriLl
	 JWTvtAgEkAhzBQtFThbS8DaHVmTO1Rr3XRtbi9Z4G4r0eLIVQBqUfUcVFD2dk0yoKU
	 KgcomZl+BRmHlVgvMlrBBXLWBpVVZLU6TO0bPdERpPZCxti/iW4BJLhfyp3si4ppoX
	 Kv+Tne/JausbeFpFqvfh06Qc9F2jL0uOPfWp/QFNd68Ru+YiVTeCl/j+Rv41oCpWIG
	 BC1WguEIcIIECNW1a1v2cvRg=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B64F540E0185;
	Mon,  9 Sep 2024 12:58:01 +0000 (UTC)
Date: Mon, 9 Sep 2024 14:58:00 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sev for v6.12-rc1
Message-ID: <20240909125800.GAZt7w2DcMRPncqQ1w@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull some x86 SEV cleanups for v6.12-rc1.

Thx.

---

The following changes since commit 5be63fc19fcaa4c236b307420483578a56986a37:

  Linux 6.11-rc5 (2024-08-25 19:07:11 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_sev_for_v6.12_rc1

for you to fetch changes up to 2b9ac0b84c2cae91bbaceab62df4de6d503421ec:

  virt: sev-guest: Ensure the SNP guest messages do not exceed a page (2024-08-27 10:35:38 +0200)

----------------------------------------------------------------
- A bunch of cleanups to the sev-guest driver. All in preparation for
  future SEV work

----------------------------------------------------------------
Nikunj A Dadhania (4):
      virt: sev-guest: Replace dev_dbg() with pr_debug()
      virt: sev-guest: Rename local guest message variables
      virt: sev-guest: Fix user-visible strings
      virt: sev-guest: Ensure the SNP guest messages do not exceed a page

 arch/x86/include/asm/sev.h              |   2 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 132 ++++++++++++++++----------------
 2 files changed, 69 insertions(+), 65 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

