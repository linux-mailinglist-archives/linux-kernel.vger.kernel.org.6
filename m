Return-Path: <linux-kernel+bounces-511042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAEBA32503
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF1116A6B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F3920E32B;
	Wed, 12 Feb 2025 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w7LeVGsS"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AA820E309;
	Wed, 12 Feb 2025 11:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359763; cv=none; b=qTjqsvY5uqyopRpvw3AEeabZE8S6FqqbL3k8fUH1mAGkLY7/kmEe5ss6I8t76Uj/LPAvCxke98n2yruuHRxMDOoekDqFLtQ/l9DF3nJ07OOeFuYG0ZPARPM+3kevBTgiueU760/bgKAwHjQAESAEmFrhztfApil47A3/cMl/voE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359763; c=relaxed/simple;
	bh=5TdzermAcWjbhypz8LhaRMGLr/vZLtFdrYPC7ueEmvs=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rDs+SuuhvkOKJzeuMv6WtIH/wTkPqyaBKjMrYidACvmwG/sdftDI9B3ngMuSZ/qJ68h76BzLoSOmBriRuVd3wVIRPnjStVp1uNa8AIkqBx/KnV4fs2IzlFcZZPCKzvCxZ6L48vMEWtrFEeKvO8gi8Kc1pk9ufAwsCgyvAsrDS3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w7LeVGsS; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51CBSwmb517174
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 12 Feb 2025 05:28:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739359738;
	bh=C51Vw6EdNVniNG41V7LhTSrg7eW06Bz8eJBE8EVbadY=;
	h=Date:From:To:CC:Subject;
	b=w7LeVGsSvss9bMhGYL3IUIHV1719PQQeOwqpeloNcrL7uwsXckmgLF8aRGUpIhRWm
	 vrXYAcglzmFjOcxTUtDkOQsknBJQ9HsIqobULdnbUmjBh/LNCBr1tHMWi+tH44wGeB
	 VzAqFubKIXUTlgDTb8USTDFsiWvwE6uI8T5eHnOI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51CBSwsE033857;
	Wed, 12 Feb 2025 05:28:58 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Feb 2025 05:28:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Feb 2025 05:28:57 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51CBSvmO075174;
	Wed, 12 Feb 2025 05:28:57 -0600
Date: Wed, 12 Feb 2025 05:28:57 -0600
From: Nishanth Menon <nm@ti.com>
To: Arnd Bergmann <arnd@arndb.de>, SoC list <soc@lists.linux.dev>
CC: SoC <soc@kernel.org>, <arm@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>
Subject: [GIT PULL] arm64: defconfig: Fixes for TI K3 platforms for v6.14-rc1
Message-ID: <20250212112857.pm6ptaqbx545qnv7@eternity>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi SoC maintainers,

Please pull the following which is part of the fixes required to
restore the behavior of all TI K3 platforms.

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-config-fixes-for-v6.14

for you to fetch changes up to c7691aec5e991cec9c5c5fdab08c24856a1fc56f:

  arm64: defconfig: Enable TISCI Interrupt Router and Aggregator (2025-02-06 09:10:24 +0530)

----------------------------------------------------------------
TI K3 defconfig fixes for v6.14

- Enable TISCI Interrupt Router, Interrupt Aggregator and related drivers.

----------------------------------------------------------------
Vaishnav Achath (1):
      arm64: defconfig: Enable TISCI Interrupt Router and Aggregator

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

