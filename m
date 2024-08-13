Return-Path: <linux-kernel+bounces-284223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3AB94FE9B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9786BB24FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7D113B791;
	Tue, 13 Aug 2024 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="HU/MeDb6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="EVXNzy+s"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A21136320;
	Tue, 13 Aug 2024 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533646; cv=none; b=P2xkWwmQ+qyhr52DHz17/OeFvpERoh4oxMGRqtHKvrvlzJKGP5nbFnZ1e6O4ZS2eZYZdwKB8UR+dGPt0ZKZktsSyAj7n0mj1GNC+3xdDFBW9jd7MaYG1U3as7Zhili5k89XLU3oIyBKHLUemDVKQ5cOi2/d+vDfOJXr7fzXZUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533646; c=relaxed/simple;
	bh=8AQQeAALK6UKHif4So19Hs/TFe5GHB+qPdfF+XP1Qa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HZ9TijlvY+pJJkOFEB8SYEWaT87IzYkP6SEex0XVMb3lnMG6VEp1PwzEmivbldboxEr0dH73JcrQfLDam7XObcJReupoob7sBdL3vHWk7LuEOKgLnYLHplXsfsZ2E0G0vN0EIj2Il6iVdTZ76eoET1dVgoq6PXoHQVg1x/6RXnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=HU/MeDb6; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=EVXNzy+s reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723533644; x=1755069644;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CRRw6U14fOkdd0tuZZYeBkuct0cMS+e+vrGYA0OATzY=;
  b=HU/MeDb6ztp8jQ6GKX7NsIYNiYDYQMFk01H7EPSBuBpVKgoL1f2gZDyk
   Sw+/07KUzopR+BdlaC0Axq52HM5Z2keqkF/UiDNOFtMi/exph8gsBg3Vy
   pX6BC2f9y7OVGo6Xwa8LppWWgsn3nhXT74XFiYmla72bjtdckxaan6gHJ
   tFvSRAuUKLp4NdTNxTPCro2A9jFwPhb6Bj6XGFvvqxcBft3lmF+qTnq23
   RA6qEdrtx/APYIN3ztrS2OCzNBaaWRagqjWuX0EwMNL8/jIqYnYTXBI8F
   LkMjQf/nUXD7L5g+7k8idGAtCy6CkFk2LvQfNEM3a/ZgqpxwwlLqdgW+E
   A==;
X-CSE-ConnectionGUID: nX1UOdnwTCmLn4II2e5NvA==
X-CSE-MsgGUID: SsOhI2HASKWfQfbHg8HsrQ==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38375992"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 09:20:42 +0200
X-CheckPoint: {66BB094A-2-751552D8-F91D2344}
X-MAIL-CPID: 3AC29AFCF7F29C1C9069701B02C2AD3C_4
X-Control-Analysis: str=0001.0A782F1B.66BB094A.006A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5092416A2FD;
	Tue, 13 Aug 2024 09:20:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723533637; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=CRRw6U14fOkdd0tuZZYeBkuct0cMS+e+vrGYA0OATzY=;
	b=EVXNzy+sYqoUwImme2XUcvoczamL24iqU8htoTbdlYTuLM2GSoxT/BzsWDi0fHX7VlTrXU
	7VG2qlCm0r0Sqh6Xugj9PN/9UTndRHTPSrQhWe0D9H7L2/rGCU/HGcVg7GE/EFn3/CqAzL
	ko/B88wkaAfXxzGXxjftt4Iz/W0EhrEjLjiB2edp4vKIhwC1tO1Nx2E4Rl8VQNno4s9n8F
	Vf5W0V22DqPD8TdjUXC/2fU1YjC3s3N2qq6oGD8A9BoOkLnsxM2kX/G3aicxUT4Xw8CCF+
	v2V9bJBecDC5kN9xDqa5qpoCbC+VYmbxfEjmK7lIKMgjF/lJh25Bw+cvT0xLDw==
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 0/7] arm64: fix license and copyright text
Date: Tue, 13 Aug 2024 09:20:12 +0200
Message-Id: <20240813072019.72735-1-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

this series changes Devicetree licenses to included file licenses and changes TQ copyright entries to unify TQ-Systems copyright entries.
It also corrects the spelling of TQ-Systems.

Best regards,
Max

Max Merchel (7):
  arm64: dts: tqmlx2160a: correct spelling of TQ-Systems
  arm64: dts: tqma8mq: change copyright entry to current TQ Copyright
    style
  arm64: dts: tqma8mqml: change copyright entry to current TQ Copyright
    style
  arm64: dts: tqma8mqnl: change copyright entry to current TQ Copyright
    style
  arm64: dts: tqma8mpql: change copyright entry to current TQ Copyright
    style
  arm64: dts: tqma8xx: use GPL-2.0-only as done by included
    imx8qxp/imx8dxp
  arm64: dts: tqma8xx: change copyright entry to current TQ Copyright
    style

 .../boot/dts/freescale/fsl-lx2160a-tqmlx2160a-mblx2160a.dts  | 2 +-
 arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp-mba8xx.dts    | 4 ++--
 arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp.dtsi          | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts    | 4 +++-
 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi          | 4 +++-
 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts    | 4 +++-
 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi          | 4 +++-
 .../boot/dts/freescale/imx8mp-tqma8mpql-mba8mp-ras314.dts    | 3 +--
 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts  | 5 +++--
 arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi          | 5 +++--
 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts      | 4 +++-
 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi            | 4 +++-
 arch/arm64/boot/dts/freescale/imx8qxp-ss-vpu.dtsi            | 2 +-
 arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp-mba8xx.dts    | 4 ++--
 arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp.dtsi          | 4 ++--
 arch/arm64/boot/dts/freescale/mba8mx.dtsi                    | 4 +++-
 arch/arm64/boot/dts/freescale/mba8xx.dtsi                    | 4 ++--
 arch/arm64/boot/dts/freescale/tqma8xx.dtsi                   | 4 ++--
 18 files changed, 42 insertions(+), 27 deletions(-)

-- 
2.33.0


