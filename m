Return-Path: <linux-kernel+bounces-355715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 709729955FE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40E41F247E0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5E920CCFB;
	Tue,  8 Oct 2024 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KFeE6dY1"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0621E0E0D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409759; cv=none; b=cA2oKlCUYPGdgcBbv10ky5PQnkI7a3Zmzth5CpwNdij61kuBQiVZMv0OuqYRardBkCvTdNYoGWW8Vci9lGk0+j3OLyeY7unFcjZSP+P1OP7T5oR/GY7Famb9QQVKbpR9FgrmJmeJbQtHhUI8jRBSlFGYwMvAC8R7QQC8RTi04Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409759; c=relaxed/simple;
	bh=uv2RUQOb1CbYJ4DRVC+ujhy3nbVrcXTLsWHlflGCg8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=H8PvRDmimJv1uzLfU6vNYY+QOCDg6TNDCgCRV3G68nlLLiSo/JREB6OUaHMjHEC4gWBoLzDCTUCpHHnxvwZE1v9TLr+DI+zC/i/XgiEqKppjtK2y5an1Ot72istntEDzIKrlWb4GT9JoKYkWEPYP3ApetcUbjs8sODQW5MNi+Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KFeE6dY1; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241008174909euoutp011e92c299807b1b6c0e57801aac8e37f1~8i4JrFAch3183731837euoutp01P
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:49:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241008174909euoutp011e92c299807b1b6c0e57801aac8e37f1~8i4JrFAch3183731837euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728409749;
	bh=8vrYJB8Siw9RAOlVinaG8bxKGfgftgY8netEzRiOTRc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=KFeE6dY1BNR9Dg4rMIWrCCKwV+pGQQa6BJd8qDHod0+ufETt2T921spDo95uvDf56
	 VqBD19WWazc1RFNS4GW+GUOhsKlw0TEjRoDF6xkXG6afOeqSpnZnrCZgzI2mgAcyDO
	 8bk3aeB4E+cf9uLFjNzjVkG7RAwTiAQXZ9lE3WmA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241008174908eucas1p1c65fb2196e9986025af67b2602ae0619~8i4JLK_DL2026120261eucas1p19;
	Tue,  8 Oct 2024 17:49:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 4E.2E.09624.49075076; Tue,  8
	Oct 2024 18:49:08 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241008174907eucas1p1100fe37efdcb49cc20c5171248492fed~8i4IUrnN41985419854eucas1p14;
	Tue,  8 Oct 2024 17:49:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241008174907eusmtrp228ebb2c5ca0e6368bfe5b9dd3dfafc09~8i4IUAIxA2980729807eusmtrp2m;
	Tue,  8 Oct 2024 17:49:07 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-f4-67057094a608
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 88.40.19096.39075076; Tue,  8
	Oct 2024 18:49:07 +0100 (BST)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241008174906eusmtip2082484b90db97fd8aa733cecde52b13c~8i4HhAlrM2347223472eusmtip25;
	Tue,  8 Oct 2024 17:49:06 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v3 0/3] Introduce support for T-head TH1520 Mailbox
Date: Tue,  8 Oct 2024 19:48:49 +0200
Message-Id: <20241008174852.222374-1-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7djPc7pTCljTDW7M1LDY+nsWu8WaveeY
	LOYfOcdqce/SFiaLF3sbWSyurZjLbvFy1j02i8u75rBZbPvcwmax9shddov1X+czWby83MNs
	0TaL3+L/nh3sFi37p7A48Hu8efmSxeNwxxd2j52z7rJ7bFrVyeaxeUm9R8vaY0we7/ddZfPo
	27KK0eNS83V2j8+b5AK4orhsUlJzMstSi/TtErgy9izawlpwQ6xi0d9G5gbGNqEuRk4OCQET
	iYajHexdjFwcQgIrGCV272phgnC+MEr0r5vCCOF8ZpS4teYNO0zL7CUXWSASyxklDl95yQaS
	EBJ4wyix93EAiM0mYCTxYPl8VpAiEYF3jBKTrt0Gm8ss0MsoMXXvTCaQKmEBZ4n3y74xgtgs
	AqoSPzo2sILYvAJ2Emc332eCWCcvsf/gWWaIuKDEyZlPWEBsZqB489bZzCBDJQSmc0pcnDyf
	EaLBReLYnbtQtwpLvDq+BcqWkfi/cz7U0HyJB1s/MUPYNRI7e45D2dYSd879AnqHA2iBpsT6
	XfoQYUeJW++eMoGEJQT4JG68FYQ4gU9i0rbpzBBhXokOWJiqSUzt6YVbem7FNqilHhIXd71g
	hoRVrMSjhQ8YJzAqzELy2Cwkj81CuGEBI/MqRvHU0uLc9NRiw7zUcr3ixNzi0rx0veT83E2M
	wFR3+t/xTzsY5776qHeIkYmD8RCjBAezkghvxBrGdCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
	qinyqUIC6YklqdmpqQWpRTBZJg5OqQamBOEZKfWBG41tt3cIvrXzLa2QnWJrJzXr5kvN9Kp5
	f5Ye/9jWYbBl+xYdtXYD/4Zlj2v2zfJ1VrqUxHDwR//WN1kuOxhO6119suTHtbcbGaXCTJ9t
	/rVefYFlr15ZRN+2pzGB1Wsyj3/Yd7xU5s+xd13xa1rsVJIteC/80HvmuiVPQFTk/94TX25N
	ZDjTe1C9zyzgzY2XK58f37DTT3SR/M3EDT73rc5869Ao6NiRWRvr7nlAZEs8d/q7TJM7Fr1M
	J7elLr/ewJr85YWv6PuYW43TK89f59vVsdNhkXSz/qaIvaVFO2NqLfq+eYdx2fjM6ZE82Hje
	Quehc4zs57tRDXvtj1u8XVdkduuy+hNuJZbijERDLeai4kQAu/rOLuQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xe7qTC1jTDWZ/0bDY+nsWu8WaveeY
	LOYfOcdqce/SFiaLF3sbWSyurZjLbvFy1j02i8u75rBZbPvcwmax9shddov1X+czWby83MNs
	0TaL3+L/nh3sFi37p7A48Hu8efmSxeNwxxd2j52z7rJ7bFrVyeaxeUm9R8vaY0we7/ddZfPo
	27KK0eNS83V2j8+b5AK4ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1s
	UlJzMstSi/TtEvQy9izawlpwQ6xi0d9G5gbGNqEuRk4OCQETidlLLrJ0MXJxCAksZZQ4OnUV
	G0RCRuJa90sWCFtY4s+1LjaIoleMEo+WzmUHSbAJGEk8WD6fFSQhIvCHUeL6szeMIA6zwERG
	iZtz7zOCVAkLOEu8X/YNzGYRUJX40bGBFcTmFbCTOLv5PhPECnmJ/QfPMkPEBSVOznwCtJoD
	aJC6xPp5YKcyA5U0b53NPIGRfxaSqlkIVbOQVC1gZF7FKJJaWpybnltspFecmFtcmpeul5yf
	u4kRGJPbjv3csoNx5auPeocYmTgYDzFKcDArifBGrGFMF+JNSaysSi3Kjy8qzUktPsRoCnT1
	RGYp0eR8YFLIK4k3NDMwNTQxszQwtTQzVhLnZbtyPk1IID2xJDU7NbUgtQimj4mDU6qBSXOu
	2V0Tg7ijyfmJtxSyxM1LHmqG3NU5eTpK5OzcY4fYlMOYOJaemFM9fePB8pp/vzbzFaXX+F/5
	FfB2/eK98TnzWlYEJwRKpc1+kKFZyWe1yU73w3r5RZFFz0vnSy/mfpx0vi3PdN2nQN0/G87v
	erFq6sYNx75t3+NdNPPY8qeVj8rttBe+1N9xSfjUay7t6mm8lzc0RHo4RB0R0CgwsHKef3Tp
	zvkaBh+Cr4Q+1Fxep3RrDmfNRHufC8VbYx06ZU1sg1qm9PpZfZiwjGO3j87lZc3+xic2iaev
	uB40c/u2Xf9UmZxfB181jJl0S33Jvw3Fq9QOO4qkWi7+8Uf6j83BN/PME/UVJU6pcz7Uf63E
	UpyRaKjFXFScCACHylRoUgMAAA==
X-CMS-MailID: 20241008174907eucas1p1100fe37efdcb49cc20c5171248492fed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241008174907eucas1p1100fe37efdcb49cc20c5171248492fed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241008174907eucas1p1100fe37efdcb49cc20c5171248492fed
References: <CGME20241008174907eucas1p1100fe37efdcb49cc20c5171248492fed@eucas1p1.samsung.com>

The T-head TH1520 SoC supports a hardware mailbox that enables two cores
within the SoC to communicate and coordinate [1]. One example of such
coordination would be cooperation with the T-Head E902 core, which is
responsible for power, clock, and resource management. For example, in
the specific case of the BXM-4-64 GPU, it needs to be powered on by the
E902 core, and the kernel running on the E910 needs to 'ask' the
firmware running on the E902 core to enable power to the GPU island.
Given recent advancements in work on the upstream GPU driver [2], there
is an emerging need to get this code in the mainline kernel.

Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf [1]
Link: https://gitlab.freedesktop.org/imagination/linux-firmware/-/issues/1 [2]

Thanks, Krzysztof and Rob, for your review! Since this series is gaining
some interest, I'm dropping the RFC prefix with this v3 update.

v3:
- added a comment about mixing devm_ and non-devm resources in the context
  of shared interrupts and explained why it's safe to do so in this
  particular case
- changed the order of resource freeing in the .shutdown callback
- used a wrapper function for register mapping
- since the only conceivable use case for this mailbox driver is
  communication with cores not managed by the kernel, I’ve hard-coded
  this by removing the thead,icu-cpu-id property and adjusted the mailbox
  driver code accordingly.
- added a more detailed description for mbox-cells.
- made some cosmetic changes.
- retested by applying the patch with non-yet-upstreamed patches,
  confirming that the drm/imagination driver can read the registers
  correctly.

v2:
 - fixed thead,th1520-mbox.yaml binding file by dropping redundant
   descriptions, renaming reg-names, removing unnecessary clocks,
   providing constraints and defining ICU's
 - fixed the mailbox driver code to work well with updated binding-file,
   removed clocks support, as it's not necessary for mailbox to work
 - adjusted the device tree node instance of mbox_910t so it will work
   with updated bindings file

Michal Wilczynski (3):
  mailbox: Introduce support for T-head TH1520 Mailbox driver
  dt-bindings: mailbox: Add thead,th1520-mailbox bindings
  riscv: dts: thead: Add mailbox node

 .../bindings/mailbox/thead,th1520-mbox.yaml   |  81 +++
 MAINTAINERS                                   |   2 +
 arch/riscv/boot/dts/thead/th1520.dtsi         |  12 +
 drivers/mailbox/Kconfig                       |  10 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/mailbox-th1520.c              | 576 ++++++++++++++++++
 6 files changed, 683 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
 create mode 100644 drivers/mailbox/mailbox-th1520.c

-- 
2.34.1


