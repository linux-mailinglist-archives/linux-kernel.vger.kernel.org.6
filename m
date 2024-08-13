Return-Path: <linux-kernel+bounces-284208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AE994FE7A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5301C22B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040F158ABF;
	Tue, 13 Aug 2024 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="MwZp5mCr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="hC63vtzP"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774E64C81;
	Tue, 13 Aug 2024 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533433; cv=none; b=HkgNuqedYyvTg8MKlr3/zAQb+HK2f5dxeuUdndVOOFgolh1pkjIm6xqyF50g4Sl/oKiLHPVOqPyxctVykuYC2e0fHs45GbhSTMexH7btsR2xuNfoohWNv/62VidPOqQerXb1i94cTdMmyh1Av8oUsf3JLFQ7gdzIdKdehpyfceE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533433; c=relaxed/simple;
	bh=9pX1OaonTIu4bKYzWQDBGmB7EQBH1hs+F1VSkLTdjyA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HKPP+/mjzai6KLoAkJzYzHEcsUPRzoaPd5qwapqnpLo6LZt+HxFy4F8KxrX5O+oqMer+kQ3By5RRHw8dlADwqYjYepSTF6u8/W9D6ZE8TUtOvYV0xur+/CgmAnnZ2U1mwN+Xs3U2ZgGUWRwxdVqurj+orueJBkCuS/4kFDUmPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=MwZp5mCr; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=hC63vtzP reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723533430; x=1755069430;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6Gcv9SaYMhdUFSH3ll9l5WDvFGE6rvx7LNmkMGKQPOk=;
  b=MwZp5mCrjLWFdQ6lT8HyfJ/HAmID6xe04CNNmhnhzWphziyOW6ssp6us
   WHPznkdUH2Ose9+P8NpdRWDKl4Yl2I41nQmrlt3tGpoDFaKiX6CK0m7Ke
   RaYeLgoiw1+NTuPuKptfcOUkMCe50xN212RoLYSCKv9ejzC9t4G06lTkr
   bR5FndcybzIy09gqbSAVuor8dsrjGWjkIgg6JULjpm24n64nVvtpPkILs
   7qjpnWCGJwKSofVzp0C8+20bGTsgL3TMkXZH/sCBIfsqrRV0kJBl63y8M
   jsSEjYI1EXbn18GEs2hG0YB9XZBCC5IxkVzWo/0iluNPMQjnLPgCjUs31
   Q==;
X-CSE-ConnectionGUID: xLD9tkCvQfqzhMpWAeNsGA==
X-CSE-MsgGUID: a1Te5wApRt6N/NyLeMNrNg==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38375830"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 09:17:08 +0200
X-CheckPoint: {66BB0874-A-2C7A84BB-EFCBC4CF}
X-MAIL-CPID: 31DB44AB7A2FE553655F68547661D27C_2
X-Control-Analysis: str=0001.0A782F1F.66BB0874.00A6,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26DAA16423A;
	Tue, 13 Aug 2024 09:17:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723533424; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=6Gcv9SaYMhdUFSH3ll9l5WDvFGE6rvx7LNmkMGKQPOk=;
	b=hC63vtzPI4q4DE/LW69AO/VzvdhQgNrQ4KGO+cfd9OP9FeOYWU22oyxdxcSLG5f6bZ/EEj
	L6TeWjIdJESZMvmrjvPauywdq8LdpmJe7zeR6mij2m9o03hsjFKBrWfGOgOx1EBwnUtFeA
	fBmTHCtETVvnSPknV6Iw3AQ3KgbYsf6Pr2rOF4JtP0LAk3etAlPKuP73CSCH+K4IpzfKeS
	QSJINYGRMJn2sFUlLRbi+jXQBR1mIKdcX4R625B404+0gSyj/fzoUD2ToEUhfqubdkDMJl
	3uDIHdg6MBZIAQZrnYR2NwFayeA48AjEw3u5T+7m2nZoIJClrgMMbfCbWlRC+A==
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] ARM: Fix license and copyright texts
Date: Tue, 13 Aug 2024 09:16:26 +0200
Message-Id: <20240813071637.72528-1-Max.Merchel@ew.tq-group.com>
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

Max Merchel (10):
  ARM: dts: tqma7: change licenses to use the same as imx7
  ARM: dts: tqma7: change copyright entry to current TQ Copyright style
  ARM: dts: tqma6: use GPL-2.0-only as used by included imx6 device
    trees
  ARM: dts: tqma6: change copyright entry to current TQ Copyright style
  ARM: dts: tqma6ul: change copyright entry to current TQ Copyright
    style
  ARM: dts: tqma6ull: change copyright entry to current TQ Copyright
    style
  ARM: dts: tqma6ul[l]: correct spelling of TQ-Systems
  ARM: dts: tqma6ul: use licensed as used by included imx6ull device
    tree
  ARM: dts: tqmls1021: change licenses to use the same as ls1021a
  ARM: dts: tqmls1021: change copyright entry to current TQ Copyright
    style

 arch/arm/boot/dts/nxp/imx/imx6dl-mba6.dtsi               | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6dl-mba6a.dts               | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6dl-mba6b.dts               | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6dl-tqma6a.dtsi             | 7 +++++--
 arch/arm/boot/dts/nxp/imx/imx6dl-tqma6b.dtsi             | 7 +++++--
 arch/arm/boot/dts/nxp/imx/imx6q-mba6.dtsi                | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dts                | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6q-mba6b.dts                | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6q-tqma6a.dtsi              | 7 +++++--
 arch/arm/boot/dts/nxp/imx/imx6q-tqma6b.dtsi              | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi              | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-mba6a.dtsi             | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi             | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6.dtsi             | 7 +++++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6a.dtsi            | 7 +++++--
 arch/arm/boot/dts/nxp/imx/imx6qdl-tqma6b.dtsi            | 7 +++++--
 arch/arm/boot/dts/nxp/imx/imx6qp-mba6b.dts               | 5 +++--
 arch/arm/boot/dts/nxp/imx/imx6qp-tqma6b.dtsi             | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi     | 7 ++++---
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1-mba6ulx.dts    | 7 ++++---
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul1.dtsi           | 7 ++++---
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2-mba6ulx.dts    | 7 ++++---
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2.dtsi           | 7 ++++---
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l-mba6ulx.dts   | 9 +++++----
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul2l.dtsi          | 7 ++++---
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulx-common.dtsi    | 7 ++++---
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ulxl-common.dtsi   | 7 ++++---
 arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2-mba6ulx.dts  | 7 ++++---
 arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2.dtsi         | 7 ++++---
 arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l-mba6ulx.dts | 9 +++++----
 arch/arm/boot/dts/nxp/imx/imx6ull-tqma6ull2l.dtsi        | 9 +++++----
 arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi                 | 8 +++++---
 arch/arm/boot/dts/nxp/imx/imx7-tqma7.dtsi                | 8 +++++---
 arch/arm/boot/dts/nxp/imx/imx7d-mba7.dts                 | 8 +++++---
 arch/arm/boot/dts/nxp/imx/imx7d-tqma7.dtsi               | 8 +++++---
 arch/arm/boot/dts/nxp/imx/imx7s-mba7.dts                 | 8 +++++---
 arch/arm/boot/dts/nxp/imx/imx7s-tqma7.dtsi               | 8 +++++---
 arch/arm/boot/dts/nxp/imx/mba6ulx.dtsi                   | 7 ++++---
 .../arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a.dts | 4 ++--
 arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a.dtsi         | 4 ++--
 40 files changed, 155 insertions(+), 101 deletions(-)

-- 
2.33.0


