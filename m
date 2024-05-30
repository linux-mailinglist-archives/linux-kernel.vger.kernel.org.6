Return-Path: <linux-kernel+bounces-195544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B12208D4E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660A01F246B0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0183617D8A7;
	Thu, 30 May 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="k4I/tL93"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F93132129
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080422; cv=none; b=BOqedCUZZfUOa8FqSI0qy2fehrbuVZdVBKDuQkXmj4RAReWwlJfIkmFL34LZuD9IkkHGFZycWmY5UhlfO09QlIXPlKMGgathdkuYJr25QgmcagWGvqO5acBwF4Lmc4Mv/P6W24FSl5DDWkPIhFAwYPH9ataAKzFOFlFDoCi6HGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080422; c=relaxed/simple;
	bh=hec9jZ8GWjjsOhfEAzSjDoHUwtpSRvZqlBCq8AeIrFo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S/fpFW/6iBByb2jB6oWlELa/3osYfxiuV+OdyaHAOg+6KnThs+9/Jg3SkcLGj1Fl4XZi7BIj/sbsnQVlFfx8SNXDyIblgVguai6WtuSeLMew5bvxXsjb3xxASqHxJPC0QS4FD3vaDpW4Jgoz0AOKnjVkx69pl662HoQnKKqACaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=k4I/tL93; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=ghtoP556IbQ/4WNCjbdXYdl4SF/fbsBPebHF32JHF24=; b=k4
	I/tL93vaUznDzldj8OIPU2ha2h+e6lf/zM1QEjKjHd2quynoZiN1zahEuzRAZ4+bHOgWq6Tbcs9fw
	WDm+F+bs7JNE35wJf32IceQHAa2k1bYDmfWo+pV1TMAMzOdTngeDMadfuXhAt7PFC/RBhnwTzSX8T
	wHNFXEfLZF+PEC6vTMV7D9qZoO472Z/18NA/Aotrm8RUpFMHDVJ5LikAlBhiB9QYzA1THkfYr95No
	ZeWt5QiDAPIPMwc+SiEFIl8T+fp3u1YZwLBdY+aPN4ew7GLvZ39Ie7N5M+K4R8bgRhbLoAwhs4djm
	wMe4Y08hGige7WNGIuBmJ8nOelEK7RAA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sCh3B-000CAW-Cu; Thu, 30 May 2024 16:46:41 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sCh3A-000N5A-1R;
	Thu, 30 May 2024 16:46:40 +0200
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v3 0/3] memory: fsl_ifc: Make FSL_IFC config visible and
 selectable
Date: Thu, 30 May 2024 16:46:35 +0200
Message-Id: <20240530-fsl-ifc-config-v3-0-1fd2c3d233dd@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEuRWGYC/3WMQQ6CMBAAv0J6dk0p0oIn/2E8QLuFTbQlrWkwh
 L9bOGmMx5lkZmERA2Fk52JhARNF8i5DdSiYHjs3IJDJzAQXJ16LCmy8A1kN2jtLA+hGqZaLXrQ
 KWY6mgJbmfXi9ZR4pPn147f9UbvbvKpVQgkRrVdUbrVBeBuwczUftH2x7JfHZNz+9AA61NapHJ
 WXNzVe/rusbKHPTy+0AAAA=
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717080399; l=1363;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=hec9jZ8GWjjsOhfEAzSjDoHUwtpSRvZqlBCq8AeIrFo=;
 b=buzvR/qD7i5oCABreVm4NXVrvG2Yrha5/9sV9qT58rBe0Y1V0HlLMjxj016UsCkarlgM2PV1D
 qnXPPLMay4qDek66RR3yRO4bP1kvryYBpWSCZwqM67gmus4KuCWQaIZ
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27291/Thu May 30 10:29:52 2024)

While use of fsl_ifc driver with NAND flash is fine, as the fsl_ifc_nand
driver selects FSL_IFC automatically, we need the CONFIG_FSL_IFC option to
be selectable for platforms using fsl_ifc with NOR flash.

Fixes: ea0c0ad6b6eb ("memory: Enable compile testing for most of the drivers")

Changes in v3:
- Refresh arm64 defconfig.
- Link to v2: https://lore.kernel.org/r/20240528-fsl-ifc-config-v2-0-5fd7be76650d@geanix.com

Changes in v2:
- CONFIG_MTD_NAND_FSL_IFC depends on CONFIG_FSL_IFC instead of select.
- Refresh powerpc config snippet accordingly.
- Link to v1: https://lore.kernel.org/r/20240523-fsl-ifc-config-v1-1-6eff73bdc7e6@geanix.com

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Esben Haabendal (3):
      memory: fsl_ifc: Make FSL_IFC config visible and selectable
      powerpc/configs: Update defconfig with now user-visible CONFIG_FSL_IFC
      arm64/configs: Update defconfig with now user-visible CONFIG_FSL_IFC

 arch/arm64/configs/defconfig        | 1 +
 arch/powerpc/configs/85xx-hw.config | 2 ++
 drivers/memory/Kconfig              | 2 +-
 drivers/mtd/nand/raw/Kconfig        | 3 +--
 4 files changed, 5 insertions(+), 3 deletions(-)
---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240523-fsl-ifc-config-c877902b297e

Best regards,
-- 
Esben Haabendal <esben@geanix.com>


