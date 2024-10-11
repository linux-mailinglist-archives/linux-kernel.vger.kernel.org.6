Return-Path: <linux-kernel+bounces-361824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D378799AD6C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7716D1F26A78
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDB01D14EE;
	Fri, 11 Oct 2024 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K8so7zOw"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40E51CF7D0
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728677844; cv=none; b=tM/khPkOMc9AFzBlzpu+sleC6pGE3eCM19RSp3hcW7Fv31oQxeR30Pm0RSnYN8Pj9MEqyN+ulLthM6+Lvm7/19RdAtpINIgnrxD4X6YrhGhsWmKUsw8MfWzaqhhqnuVgxk2zDwdml5NBXZC61N+CwHR2aWHV8TEWzwZ6XHtaPxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728677844; c=relaxed/simple;
	bh=FrG8EownqOV+2sB6g3ZKuECIwdP4tFnbb8ZQk58EUmo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lUz4Ibd+D+05zLaRnw+g4tCHi4YjxADIIqL68Np9EdieobakyQPTaYpYltRqzFMP/R8NkIo8dY1+OxR6X0Mf1yaBgj9ns1qxTYtfvQJe3YvJTLwUw1VwuonE0L9F7hxK0YDUi0bj9sMFyMvSiiy/+K4LjhcMkLgtPONf+AB9pP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=K8so7zOw; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49BKGlKo029265;
	Fri, 11 Oct 2024 15:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728677807;
	bh=Xp3T/ynIa7YSFa8v+/vcDQmP+Jv77elTldb8NxYZSxs=;
	h=From:To:CC:Subject:Date;
	b=K8so7zOwv1rR1Ub9k8dPpKQA2S7HWTt0m3OyBrK7pImAaCcqRlKFxx/afvizTVqF3
	 UeiKH4YYASvcVap6wClg3jeviWNWjmDMOq6VMi0Ben8kpUz5STFgMgBtyeZs9+/lut
	 /vysz5XWIzBRGl9CdR7D5D6ZnEpgdOlAi+qKArVE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49BKGlXf071093;
	Fri, 11 Oct 2024 15:16:47 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Oct 2024 15:16:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Oct 2024 15:16:47 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49BKGkCG102075;
	Fri, 11 Oct 2024 15:16:46 -0500
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
Subject: [PATCH v3 0/6] Switch more ARM plats to sys-off handler API
Date: Fri, 11 Oct 2024 15:16:39 -0500
Message-ID: <20241011201645.797394-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello all,

Continuing the quest to remove the legacy pm_power_off() global
function handler. Remove uses from arch/arm/ using the helper
register_platform_power_off().

Thanks,
Andrew

Changes for v3:
 - Rebase on v6.12-rc1

Changes for v2:
 - Collect Reviewed/Acked-bys
 - Rebase on v6.11-rc1

Andrew Davis (6):
  ARM: highbank: Switch to new sys-off handler API
  ARM: imx: Switch to new sys-off handler API
  ARM: pxa: Switch to new sys-off handler API
  ARM: sa1100: Switch to new sys-off handler API
  ARM: vt8500: Switch to new sys-off handler API
  arm/xen: Switch to new sys-off handler API

 arch/arm/mach-highbank/highbank.c | 2 +-
 arch/arm/mach-imx/pm-imx6.c       | 6 ++----
 arch/arm/mach-pxa/spitz.c         | 2 +-
 arch/arm/mach-sa1100/generic.c    | 2 +-
 arch/arm/mach-vt8500/vt8500.c     | 2 +-
 arch/arm/xen/enlighten.c          | 2 +-
 6 files changed, 7 insertions(+), 9 deletions(-)

-- 
2.39.2


