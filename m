Return-Path: <linux-kernel+bounces-569536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65247A6A445
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D9F463B76
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6410B2253FC;
	Thu, 20 Mar 2025 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="X4vIynPL"
Received: from naesa04.arrow.com (naesa04.arrow.com [216.150.161.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC1D22539C;
	Thu, 20 Mar 2025 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468160; cv=none; b=fZ0vaIYnRVBeH5mJR3cowxRHPNICPYrPhETlDQ7725BEL+NZtcsU9/awuRiRwFBQgmiC9PgwhjVx38j0jQtL3z0XOvqPvS/hTg+Eoksl26JD9btFbuX2WgASkgrQlG7ZtiPmsURAP5yB7JgKMIxYq3jInIACQ/NHwX3d9YhO6T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468160; c=relaxed/simple;
	bh=X0wyKFUB79B8njiPMvO0AbT8BMzGHrl1igEtHamhg4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jjF8bzzSJAH82XlKwnDEXt3qbkK0RwBv+0IT7f3ni/ZEOIeKCVKG2mcXtoor/8dI3hxcq0P+qQbpzrN9Xswjw/3+zRi4t3oiPqu4X6oBSSq3saIbly5PQueXeMsnB7dJtb4eKUd4fFauCXfdy5HIgbT/5xUFxJPt55lCMwZm0V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=X4vIynPL; arc=none smtp.client-ip=216.150.161.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=einfochips.com; i=@einfochips.com; l=2547; q=dns/txt;
  s=NAESA-Selector1; t=1742468159; x=1774004159;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X0wyKFUB79B8njiPMvO0AbT8BMzGHrl1igEtHamhg4Y=;
  b=X4vIynPLvhP6PAHK3V4RaRjpP45YWAYXBFlsrH7gV+8m+gJjfNP3pejg
   B9KEZLR78M+c/FHLyOVP3LlUwDtVScrciGXT2OcplDngFJ1xDhva3ZVVO
   zu75AVphXTb43JVvObNuMZHU8oYnQRYWC4YOVSEnBybbrObPmI7KQBsbw
   NrZRxUiAZVmNnf+o969JJd5keKUg4Um7g13r0ASJAsL1lPIH0G8Lpsr0V
   wxJOVQMlcrPglDzlSDYv+zcG4XtonGyff+3wpfr8nP02puZ1nQE3MhBml
   9rszcEtz/pLIB7eEnzXyJQS1KpBY9qWIJqQLDdHIV+vS/fOdMsZixIql1
   g==;
X-CSE-ConnectionGUID: SBDo2ZI9Rw+oEahypipnXw==
X-CSE-MsgGUID: pT0CxiICQIeZ6rESsGX41w==
X-IronPort-AV: E=Sophos;i="6.14,261,1736838000"; 
   d="scan'208";a="80263083"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa04out.arrow.com with ESMTP; 20 Mar 2025 04:54:50 -0600
Received: from AHMCPU1888.ap.corp.arrow.com ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.14393.4169);
	 Thu, 20 Mar 2025 16:24:49 +0530
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Min Lin <linmin@eswincomputing.com>,
	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Yu Chien Peter Lin <peterlin@andestech.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	rafal@milecki.pl,
	Anup Patel <anup@brainfault.org>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/10] Basic device tree support for ESWIN EIC7700 RISC-V SoC
Date: Thu, 20 Mar 2025 16:24:39 +0530
Message-Id: <20250320105449.2094192-1-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Mar 2025 10:54:49.0663 (UTC) FILETIME=[80698CF0:01DB9986]

Add support for ESWIN EIC7700 SoC consisting of SiFive Quad-Core
P550 CPU cluster and the first development board that uses it, the
SiFive HiFive Premier P550.

This patch series adds initial device tree and also adds ESWIN
architecture support.

Boot-tested using intiramfs with Linux 6.14.0-rc2 on HiFive Premier
P550 board using U-Boot 2024.01 and OpenSBI 1.4.

Changes in v2:
- Added "Acked-by" tag of "Conor Dooley" for Patches 1, 2, 3, 7 and 8
- Added "Reviewed-by" tag of "Matthias Brugger" for Patch 4
- Updated MAINTAINERS file
  - Add the path for the eswin binding file
- Updated sifive,ccache0.yaml
  - Add restrictions for "cache-size" property based on the
    compatible string
- Link to v1: https://lore.kernel.org/lkml/20250311073432.4068512-1-pinkesh.vaghela@einfochips.com/

Darshan Prajapati (3):
  dt-bindings: riscv: Add SiFive P550 CPU compatible
  dt-bindings: interrupt-controller: Add ESWIN EIC7700 PLIC
  dt-bindings: timer: Add ESWIN EIC7700 CLINT

Min Lin (2):
  riscv: dts: add initial support for EIC7700 SoC
  riscv: dts: eswin: add HiFive Premier P550 board device tree

Pinkesh Vaghela (2):
  riscv: Add Kconfig option for ESWIN platforms
  cache: sifive_ccache: Add ESWIN EIC7700 support

Pritesh Patel (3):
  dt-bindings: vendor-prefixes: add eswin
  dt-bindings: riscv: Add SiFive HiFive Premier P550 board
  dt-bindings: cache: sifive,ccache0: Add ESWIN EIC7700 SoC
    compatibility

 .../bindings/cache/sifive,ccache0.yaml        |  44 ++-
 .../sifive,plic-1.0.0.yaml                    |   1 +
 .../devicetree/bindings/riscv/cpus.yaml       |   1 +
 .../devicetree/bindings/riscv/eswin.yaml      |  29 ++
 .../bindings/timer/sifive,clint.yaml          |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 arch/riscv/Kconfig.socs                       |   6 +
 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/eswin/Makefile            |   2 +
 .../dts/eswin/eic7700-hifive-premier-p550.dts |  29 ++
 arch/riscv/boot/dts/eswin/eic7700.dtsi        | 344 ++++++++++++++++++
 drivers/cache/sifive_ccache.c                 |   2 +
 13 files changed, 467 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/eswin.yaml
 create mode 100644 arch/riscv/boot/dts/eswin/Makefile
 create mode 100644 arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
 create mode 100644 arch/riscv/boot/dts/eswin/eic7700.dtsi

-- 
2.25.1


