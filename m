Return-Path: <linux-kernel+bounces-555590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43E4A5BA01
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E04387A2212
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D741A224B12;
	Tue, 11 Mar 2025 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="sLpiH8Kr"
Received: from naesa05.arrow.com (naesa05.arrow.com [216.150.161.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7898F2248B4;
	Tue, 11 Mar 2025 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678545; cv=none; b=XFXs03UXzvK7ZNKV32TowYYZCHKdVTFBPSUIhlq8Nr5BAlrhXWYhlNG1oz0V9ErNZWB30uKppLC2o34kQQm0NUISOwRqucWmDxmyHgMZpsIqdZdKQMNZVEBZhNv3aAORuSRjyM0QcEJ2f11563ADs6RTMP8IWP2zw6Lr6a+LcNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678545; c=relaxed/simple;
	bh=j+xRRvEsQ5Zde71RH9nSywG6D5xyLD8tE9QtSC9gGFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EH5fllw1WIZKie6S9JtbzlQPV+1QxwFWme8SFuJusEjcOmp34Cm4NQFFJ6nfIUvbY2TXU1pc8YNVT6pqlBw9B+rwx791LJihBBd9Dcytx9r0nsNOAi/sPMN7p2Yi6tY4jm3u2RoiiVs0A742dkOhcrquVx0KbZohj6BQ5CeVB1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=sLpiH8Kr; arc=none smtp.client-ip=216.150.161.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=einfochips.com; i=@einfochips.com; l=2107; q=dns/txt;
  s=NAESA-Selector1; t=1741678543; x=1773214543;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j+xRRvEsQ5Zde71RH9nSywG6D5xyLD8tE9QtSC9gGFo=;
  b=sLpiH8Kr9lrIb9Dx9Wan3llnSglOl0u846B63nNgxp9C1ey1v8Lj5BUH
   vRFbnu5W36Wr48yDQj+2Vy8TPTtntvU9L/SNBNy7U+0Xf7+i1kAhoB0+Y
   fGBp0msRnp0nZ+GfcrVWb/vHnHNVsxaz8ZBr7+C470IYMRPar3+rOk6bZ
   syMLVjFB7MBNCw8a2wmTa2Kiv0GLmQiioE5xEbTScV+wmce9fpj1r4+hD
   8UqYC9AAf5k5+UhaB4WelsOxQXBZZVEp/P1g6r4knE4CkV0xG4Vc21ro4
   g5SgtcJbE54xfGVjEQgCAlFhrcNi1PMzfpPLVcuySAk8rFOYUec+G1BF5
   g==;
X-CSE-ConnectionGUID: svRjCT2eRmet1julyqo/jQ==
X-CSE-MsgGUID: Lih6TCWvQOeN8+Bc4zndew==
X-IronPort-AV: E=Sophos;i="6.14,238,1736838000"; 
   d="scan'208";a="20386356"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa05out.arrow.com with ESMTP; 11 Mar 2025 01:34:33 -0600
Received: from AHMCPU1888.ap.corp.arrow.com ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.14393.4169);
	 Tue, 11 Mar 2025 13:04:32 +0530
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
Subject: [PATCH 00/10] Basic device tree support for ESWIN EIC7700 RISC-V SoC
Date: Tue, 11 Mar 2025 13:04:22 +0530
Message-Id: <20250311073432.4068512-1-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Mar 2025 07:34:32.0718 (UTC) FILETIME=[080982E0:01DB9258]

Add support for ESWIN EIC7700 SoC consisting of SiFive Quad-Core
P550 CPU cluster and the first development board that uses it, the
SiFive HiFive Premier P550.

This patch series adds initial device tree and also adds ESWIN
architecture support.

Boot-tested using intiramfs with Linux 6.14.0-rc2 on HiFive Premier
P550 board using U-Boot 2024.01 and OpenSBI 1.4.

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

 .../bindings/cache/sifive,ccache0.yaml        |  28 +-
 .../sifive,plic-1.0.0.yaml                    |   1 +
 .../devicetree/bindings/riscv/cpus.yaml       |   1 +
 .../devicetree/bindings/riscv/eswin.yaml      |  29 ++
 .../bindings/timer/sifive,clint.yaml          |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 arch/riscv/Kconfig.socs                       |   6 +
 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/eswin/Makefile            |   2 +
 .../dts/eswin/eic7700-hifive-premier-p550.dts |  29 ++
 arch/riscv/boot/dts/eswin/eic7700.dtsi        | 344 ++++++++++++++++++
 drivers/cache/sifive_ccache.c                 |   2 +
 13 files changed, 450 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/eswin.yaml
 create mode 100644 arch/riscv/boot/dts/eswin/Makefile
 create mode 100644 arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
 create mode 100644 arch/riscv/boot/dts/eswin/eic7700.dtsi

-- 
2.25.1


