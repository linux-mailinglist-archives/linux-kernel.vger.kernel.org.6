Return-Path: <linux-kernel+bounces-265758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 783CC93F594
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203191F229E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930E9153BEE;
	Mon, 29 Jul 2024 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WQGKnV3m"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C07B1487C1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256574; cv=none; b=S9ZRwv4QPmlm4PDqmVOio0yMRuwa60mtMUU/w4HLRS1+2nvemR3gBIM/8/4vpoIVfbvt4nOl6ardJWCk6ZCncZw5nEuVqPf41wQOJzq2XdMOWG6g5lGgEf3shwOvdSyTykMxGkb80+ViCqRZZJOL9YBDSWnEVOqmCUqIdiCAjGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256574; c=relaxed/simple;
	bh=i4kEHJEsCMPy2HNNo+OPRxyneve3g9qnbo+wIKnY0pg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kcvwju0la64w2+DkwpFBzlEuXHJSyPl1kwT03ut8S8dZBXD0+LE8yshJy8siFLFwtC30rQEYQMvt6Ndxc6WoxbbefbFPPEYtlD31qPzhJJY+FexdfUNFxLzeKSBJkj22pLaqhH157edi4HBa3JedFSJtJK+VNf8UrU1LPwTzOEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WQGKnV3m; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46TCZe7q086611;
	Mon, 29 Jul 2024 07:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722256540;
	bh=8ALrXitASKffYFpDqEiDahXzsP+PddcOBx3OJ0P7n1o=;
	h=From:To:CC:Subject:Date;
	b=WQGKnV3mTY3aWqqney38Yc+NX8ZMXh7bjVDxmfflqml7/TH17Pis5sh20QIb+OsfA
	 43cJDcRrJ7i5GbO/KcFTSdvHfFdiSw8pHcU8KOGVKyEC4eVwfOkHOSelVZIItsskjU
	 /0gyaoOBufeAPtWpNELbffpMDY705F9BBtP3kig0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46TCZeZL125503
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 07:35:40 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 07:35:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 07:35:40 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46TCZd0h128014;
	Mon, 29 Jul 2024 07:35:39 -0500
From: Andrew Davis <afd@ti.com>
To: Andre Przywara <andre.przywara@arm.com>,
        Russell King
	<linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer
	<s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement
	<gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian
 Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <imx@lists.linux.dev>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 0/7] Switch more ARM plats to sys-off handler API
Date: Mon, 29 Jul 2024 07:35:31 -0500
Message-ID: <20240729123538.175704-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello all,

Continuing the quest to remove the legacy pm_power_off() global
function handler. Remove uses from arch/arm/ using the helper
register_platform_power_off().

Thanks,
Andrew

Changes for v2:
 - Collect Reviewed/Acked-bys
 - Rebase on v6.11-rc1

Andrew Davis (7):
  ARM: highbank: Switch to new sys-off handler API
  ARM: imx: Switch to new sys-off handler API
  ARM: orion5x: Switch to new sys-off handler API
  ARM: pxa: Switch to new sys-off handler API
  ARM: sa1100: Switch to new sys-off handler API
  ARM: vt8500: Switch to new sys-off handler API
  arm/xen: Switch to new sys-off handler API

 arch/arm/mach-highbank/highbank.c              | 2 +-
 arch/arm/mach-imx/pm-imx6.c                    | 6 ++----
 arch/arm/mach-orion5x/board-mss2.c             | 2 +-
 arch/arm/mach-orion5x/dns323-setup.c           | 6 +++---
 arch/arm/mach-orion5x/kurobox_pro-setup.c      | 2 +-
 arch/arm/mach-orion5x/mv2120-setup.c           | 2 +-
 arch/arm/mach-orion5x/net2big-setup.c          | 2 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c | 2 +-
 arch/arm/mach-orion5x/ts209-setup.c            | 2 +-
 arch/arm/mach-orion5x/ts409-setup.c            | 2 +-
 arch/arm/mach-pxa/spitz.c                      | 2 +-
 arch/arm/mach-sa1100/generic.c                 | 2 +-
 arch/arm/mach-vt8500/vt8500.c                  | 2 +-
 arch/arm/xen/enlighten.c                       | 2 +-
 14 files changed, 17 insertions(+), 19 deletions(-)

-- 
2.39.2


