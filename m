Return-Path: <linux-kernel+bounces-341549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22203988183
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448E01C21796
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D6A1BBBE5;
	Fri, 27 Sep 2024 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gVS9TYcp"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D8B1BB6A1
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430144; cv=none; b=JcpWHI1CQDjfbkkw5m7t5a4R2QU/LFebI6SJbfCfh/9Z1yqcN/iXeecJVyH6qnybdlMAFyFEYPVX69movHQAaqYijKs4/F+84BkztEEGL+A176YtOGj9ugkM8UHgbdqRogkKfr0VeRgmoTOjq2wZDAfbfZaAAYHkg7NOZzj+49g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430144; c=relaxed/simple;
	bh=kMhNo7Ln5nY1eA0klBlBDYwOc53pg40U8v9PVt3Cl2A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=vCLBNyBgCwMft2mjMICGVVYteFteRFV1raXiwHZzn7C3aUM4YL4FxDji+HpOi/JYETbiEdDK1YSoJxEz/2cSI31scntYUjkpE99EjAVmiCjmNJ/S4Vbh3Cw+zMZfkURpo6Q2Er2RLzLIsVnedA8qpXkeZQGtPoFbeswQQs9eniA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gVS9TYcp; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240927094215euoutp02ca02ab16177456c60bf38173b3dc4617~5EI47Oc-I0829908299euoutp021
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:42:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240927094215euoutp02ca02ab16177456c60bf38173b3dc4617~5EI47Oc-I0829908299euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727430135;
	bh=iRxMDVxsMTPf5GiUxbCu9Fzli+whUq6rFI3/VvGrkrc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=gVS9TYcpr0YkCsrQxNtNIIlK071vej0p/Zwyi3XKgS5y3syH8lhp8jZOVdzA48yUi
	 9Jtgb3lJ0l8SQ0K7F8E/wMfL1R0yQ8ytFnPJ9LCGkHk0xsI76puGIBpHbG5scPMVVV
	 gESYYTc65QPL+XmdC6swlYXY41nLE+3GBtrDywMs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240927094214eucas1p12cf5253caf393fb3a9ed19dcbaa76fec~5EI4BG82L2561525615eucas1p17;
	Fri, 27 Sep 2024 09:42:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 53.CF.09624.6FD76F66; Fri, 27
	Sep 2024 10:42:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240927094213eucas1p22449c12701e67bc29371a6a6cb6f72a2~5EI3ejCaN2825128251eucas1p2s;
	Fri, 27 Sep 2024 09:42:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240927094213eusmtrp2eae65dc4e30cbc3151c93403370a718c~5EI3dt4kX2852628526eusmtrp2f;
	Fri, 27 Sep 2024 09:42:13 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-b3-66f67df6a176
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id DA.33.14621.5FD76F66; Fri, 27
	Sep 2024 10:42:13 +0100 (BST)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240927094212eusmtip2f50cd86c7896a2fa249a0d0526ed22c8~5EI2vWRHx1283512835eusmtip2z;
	Fri, 27 Sep 2024 09:42:12 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH RFC v2 0/3] Introduce support for T-head TH1520 Mailbox
Date: Fri, 27 Sep 2024 11:42:04 +0200
Message-Id: <20240927094207.1650085-1-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djP87rfar+lGbTuYbbY+nsWu8WaveeY
	LOYfOcdqce/SFiaLF3sbWSyurZjLbvFy1j02i8u75rBZbPvcwmax9shddov1X+czWby83MNs
	0TaL3+L/nh3sFi37p7A48Hu8efmSxeNwxxd2j52z7rJ7bFrVyeaxeUm9R8vaY0we7/ddZfPo
	27KK0eNS83V2j8+b5AK4orhsUlJzMstSi/TtErgyXr40KpjPU3HhdB9zA+N5zi5GTg4JAROJ
	3xvXsXUxcnEICaxglJg66xszhPOFUWLOz63sEM5nRokF7fuZYFqO39kDlVjOKLHo03QWkISQ
	wBtGiaPdmSA2m4CRxIPl81lBikQE3jFKTLp2mwnEYRboBVqydybYKGEBd4mVPzcwgtgsAqoS
	j2ceAVrOwcErYC+x/YEHxDZ5if0HzzKD2LwCghInZz4BW8YMFG/eOhvsVgmBZk6JQ397mSEa
	XCT+/lsDZQtLvDq+hR3ClpH4v3M+1Av5Eg+2foKqqZHY2XMcyraWuHPuFxvIDcwCmhLrd+mD
	mBICjhK37lhAmHwSN94KQlzAJzFp23RmiDCvREebEMQMNYmpPb1wO8+t2Aa100NiwYeV0JCK
	lXj7vpd1AqPCLCR/zULy1yyEExYwMq9iFE8tLc5NTy02zEst1ytOzC0uzUvXS87P3cQITHKn
	/x3/tINx7quPeocYmTgYDzFKcDArifBanfuaJsSbklhZlVqUH19UmpNafIhRmoNFSZxXNUU+
	VUggPbEkNTs1tSC1CCbLxMEp1cBUfWr+I+k09WvL9j0T/rJn78Pnsjei7kxumvigvUbrVq3V
	T1t5qxMF2+5zeUveXGQtrdfGr6r0YMsmZyV776Vilg33GMzulDKU2aXfqf9ZEjNp6v3FX1MV
	tz7/Leo73ZBlx9Op9o2PaqtFWJaxX1ZPFAs4fHaZpBbHP/M1X+Irot+uYtgpou7iOGHfnwXx
	P70nzApeluRk+IUv62wHl8ScD/U6bvu6jO9GPmLaUphlqlGc0Dhb23GS432/zWUXQs/EXPzn
	frrgwVK2jS1bdorZHDxw5ZbRAu/ug2k8EYXM6+/aB77W3Oz+R/4wd8Tiji/n2+Se838Ik5EU
	/mDq3tj66c+6HfO7t3QqZsy1tdJSYinOSDTUYi4qTgQAFnDi8uEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7pfa7+lGayZI2ex9fcsdos1e88x
	Wcw/co7V4t6lLUwWL/Y2slhcWzGX3eLlrHtsFpd3zWGz2Pa5hc1i7ZG77Bbrv85nsnh5uYfZ
	om0Wv8X/PTvYLVr2T2Fx4Pd48/Ili8fhji/sHjtn3WX32LSqk81j85J6j5a1x5g83u+7yubR
	t2UVo8el5uvsHp83yQVwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZ
	pKTmZJalFunbJehlvHxpVDCfp+LC6T7mBsbznF2MnBwSAiYSx+/sYe9i5OIQEljKKDH/SiMz
	REJG4lr3SxYIW1jiz7UuNoiiV4wSL68cZQVJsAkYSTxYPp8VJCEi8IdR4vqzN4wgDrPAREaJ
	m3PvM4JUCQu4S6z8uQHMZhFQlXg88wjQCg4OXgF7ie0PPCA2yEvsP3gWbDOvgKDEyZlPwDYz
	A8Wbt85mnsDINwtJahaS1AJGplWMIqmlxbnpucWGesWJucWleel6yfm5mxiBMbbt2M/NOxjn
	vfqod4iRiYPxEKMEB7OSCK/Vua9pQrwpiZVVqUX58UWlOanFhxhNgc6byCwlmpwPjPK8knhD
	MwNTQxMzSwNTSzNjJXFet8vn04QE0hNLUrNTUwtSi2D6mDg4pRqY3O78qd4admr15+DkdQJe
	SyNKhaK8I2ffKJd88kTlyfw52hbvOR/a1v7+MSNC24j1qK7+fV7frrY1Dvlbpx/dfeCHUlFO
	F4+aQ8+f2VGfOq7PnuZfUK4Qe7nDyKhbx8qA8+vB3qUzAwt5g6qq2wqLvNeIPEn5O+/R9M3N
	XQWZU091PSrVnHokpV372626Hft2THt4x79gZpHv5BNhD22en3R+6D8v1d/O7qWaZuXFovqM
	ZQGz1uhEL9tc+vmnWGWT3D2JiXK5tgd331uVcUT7q6Rm00r3daz/enyDKxRKnE5MnPnI/TLX
	xIIz9e17pLcuWDPp1MUl27R3qx2Ye4nLJswhavPETxtfHbVYdvnTDiWW4oxEQy3mouJEAEzB
	mVA6AwAA
X-CMS-MailID: 20240927094213eucas1p22449c12701e67bc29371a6a6cb6f72a2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240927094213eucas1p22449c12701e67bc29371a6a6cb6f72a2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240927094213eucas1p22449c12701e67bc29371a6a6cb6f72a2
References: <CGME20240927094213eucas1p22449c12701e67bc29371a6a6cb6f72a2@eucas1p2.samsung.com>

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

Michal Wilczynski (3):
  mailbox: Introduce support for T-head TH1520 Mailbox driver
  dt-bindings: mailbox: Add thead,th1520-mailbox bindings
  riscv: dts: thead: Add mailbox node

 .../bindings/mailbox/thead,th1520-mbox.yaml   |  84 +++
 MAINTAINERS                                   |   2 +
 arch/riscv/boot/dts/thead/th1520.dtsi         |  13 +
 drivers/mailbox/Kconfig                       |  10 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/mailbox-th1520.c              | 551 ++++++++++++++++++
 6 files changed, 662 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
 create mode 100644 drivers/mailbox/mailbox-th1520.c

-- 
2.34.1


