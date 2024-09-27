Return-Path: <linux-kernel+bounces-341547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9794C98817E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1431F22D60
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11411BB698;
	Fri, 27 Sep 2024 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CYSOHS09"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F0A1BAECB
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430141; cv=none; b=PQX5QEQvTCSq/GazhrtQpqSPz/HrE6/7BkT2lBugmj/VTxOICGFTejN+/leLljRr88GJuwaoN4/93ggRbPfctEqdYdRoMXP1bEQUopLxpCjkpDQ302UuVQu7qZjE5f+lQngkcbyRYQSSAgleCfdF/SU9R82ZBJG3h5LOaYB4920=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430141; c=relaxed/simple;
	bh=SJw5Yqr/AcqADMJgnPbnXE8o3F0Vz/K73SSnHERIeic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=TyAwsADfNw2QvOgUUGS1EXcACHjw2Y+gEB0iJ8qi1qw/ZTP+Y3niGM4eaOj+tdg9/Gm1iXDKEWCpioOOQMZDHqMS2qjJNeYkudOHqBCTYWMrXm6ko7LxZZQhNkPx3tEzRly2QFjC1JaQfAjZy5c9J+oyAdoCZDAtvBrWwFNnhTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CYSOHS09; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240927094216euoutp01645baebf52b2b0888fbd649ef12fb6ba~5EI6hS9NP3044730447euoutp01-
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:42:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240927094216euoutp01645baebf52b2b0888fbd649ef12fb6ba~5EI6hS9NP3044730447euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727430136;
	bh=3MO46mXfOuocY1HlZiYe3RsDsrIw9zYFpIh9D2ZuYOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYSOHS09S8uPEq1aRBPWXDQUDHSLt3XMfdsP3ajsa/F2QbBnt4uph8zyJsxNBS3xH
	 JGlNyZbBSDUv0ge9RGRMXkpOMjDUaJEQ0LBeJkBI+o3h8nymmSepunhyGhAt5aNIJS
	 usePpPpnuaZnvPpMqzFsXVmjp9TVBje9LNyiEEPU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240927094216eucas1p12673651e7c57f716ec7ac14ab1fbee3d~5EI6Kir9k2561425614eucas1p1B;
	Fri, 27 Sep 2024 09:42:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 97.CF.09624.8FD76F66; Fri, 27
	Sep 2024 10:42:16 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240927094215eucas1p29ac564998ea7f9dbe8b5d908060c7c38~5EI5oe4Gz1993719937eucas1p2W;
	Fri, 27 Sep 2024 09:42:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240927094215eusmtrp2c68f985da93ddaac31c79cf6c49d4ca6~5EI5kpq1s2855228552eusmtrp2O;
	Fri, 27 Sep 2024 09:42:15 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-c0-66f67df8f5d6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id DD.86.19096.7FD76F66; Fri, 27
	Sep 2024 10:42:15 +0100 (BST)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240927094214eusmtip28b1dc98ba9577f83b1b7b3fe58569a5f~5EI4y8ReL1991519915eusmtip2n;
	Fri, 27 Sep 2024 09:42:14 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH RFC v2 3/3] riscv: dts: thead: Add mailbox node
Date: Fri, 27 Sep 2024 11:42:07 +0200
Message-Id: <20240927094207.1650085-4-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927094207.1650085-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djP87o/ar+lGaxcImax9fcsdos1e88x
	Wcw/co7V4t6lLUwWL/Y2slhcWzGX3eLlrHtsFpd3zWGz2Pa5hc1i7ZG77Bbrv85nsnh5uYfZ
	om0Wv8X/PTvYLVr2T2Fx4Pd48/Ili8fhji/sHjtn3WX32LSqk81j85J6j5a1x5g83u+7yubR
	t2UVo8el5uvsHp83yQVwRXHZpKTmZJalFunbJXBlbH79h7HgO0fFt8NHGBsYf7N1MXJySAiY
	SNzveMrSxcjFISSwglHi386tzBDOF0aJ+x8eskE4nxklju5+CNfy+P8qVojEckaJWZ03oKre
	MEr8f3qEGaSKTcBI4sHy+WBVIgLvGCUmXbvNBOIwC/QySkzdO5MJpEpYwF7i44N2dhCbRUBV
	4mLHJbBuXqD40snbmCD2yUvsP3gWLM4p4CDxeekbVogaQYmTM5+wgNjMQDXNW2eDXS4hMJtT
	4seJp4wQzS4S/QdgfhWWeHV8CzuELSPxf+d8qAX5Eg+2fmKGsGskdvYch7KtJe6c+wXUywG0
	QFNi/S59iLCjxL8HG1lBwhICfBI33gpCnMAnMWnbdGaIMK9ER5sQRLWaxNSeXril51bAfOUh
	sWnjObYJjIqzkDwzC8kzsxD2LmBkXsUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGY7E7/
	O/5pB+PcVx/1DjEycTAeYpTgYFYS4bU69zVNiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9qinyq
	kEB6YklqdmpqQWoRTJaJg1OqgSntb64bo8mrN9/fPW5/6ftI/XWZkYpjgMqdRT9XT54ZdGiH
	wGtdlv1FuS+29xv/OfunvPzz+d2t7yNNgo2OqTzVuFq6bZmH1WSfapX0jN1z1S/lteS167a+
	ZG50WbPCsNJN6qHxeq4NKiV50b5np+WqvHrsslWQycl2wTejqF+ivMJPzE/4pUcsnpZoJWrV
	vKnD7DDPPxuudMPKldUTS+bP+LNm25RMlyMuk/e/7FNbwZX1KEHjQJWrHMfJZ/JxW3LcpZtj
	b0s+VJp0zzX8tGw0k3PwCd5fM6K+vXaJmy2ftHTBPJ4TG4356w4c4TGc81Xbxe90zMOj29n+
	K5/ZY+t2a9Fc/nXz+jZ3ZlRfnazEUpyRaKjFXFScCABlL4aP5QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7rfa7+lGexo1bPY+nsWu8WaveeY
	LOYfOcdqce/SFiaLF3sbWSyurZjLbvFy1j02i8u75rBZbPvcwmax9shddov1X+czWby83MNs
	0TaL3+L/nh3sFi37p7A48Hu8efmSxeNwxxd2j52z7rJ7bFrVyeaxeUm9R8vaY0we7/ddZfPo
	27KK0eNS83V2j8+b5AK4ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1s
	UlJzMstSi/TtEvQyNr/+w1jwnaPi2+EjjA2Mv9m6GDk5JARMJB7/X8XaxcjFISSwlFHi3sXJ
	jBAJGYlr3S9ZIGxhiT/Xutggil4xSpyY2gyWYBMwkniwfD5Yt4jAH0aJ68/eMII4zAITGSVu
	zr0PNkpYwF7i44N2dhCbRUBV4mLHJWYQmxcovnTyNiaIFfIS+w+eBYtzCjhIfF76hhXEFgKq
	6Ti6nx2iXlDi5MwnYJuZgeqbt85mnsAoMAtJahaS1AJGplWMIqmlxbnpucVGesWJucWleel6
	yfm5mxiBcbnt2M8tOxhXvvqod4iRiYPxEKMEB7OSCK/Vua9pQrwpiZVVqUX58UWlOanFhxhN
	ge6eyCwlmpwPTAx5JfGGZgamhiZmlgamlmbGSuK8bFfOpwkJpCeWpGanphakFsH0MXFwSjUw
	9SxcXpzvLt+ZlXTy8rYo3R/PHzn/mPj3aarLuundvq0TY4+ZS5ycsLNVafLX5OaYZMk1r+Y7
	rYpfkTDj8aVY/wurXq5IsV52TGdPx/MCfaWPe9a82XF00sF5uxgeV/491b9fYu81N0bFCVO8
	YicaGD097OG49suVCJ1Xxf6usyPnxzE4vJQuPSS/fcJ7bTl/McPwhxkSUtpaP8q/S8uZfDra
	tnDnR/lAfb039vMtUz68WB79alv+ZeXEssrlOv7nPtd8fpK7iC//y7LdEx4pxN28fM72jzeL
	BceU4u/fm/6WfNm9yp3DZlLbuR4Px3vv7/Lmnls5SdPenevywv2R4oLXhG3XLPz1mLHAIPJh
	vrYSS3FGoqEWc1FxIgBKqnpPVAMAAA==
X-CMS-MailID: 20240927094215eucas1p29ac564998ea7f9dbe8b5d908060c7c38
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240927094215eucas1p29ac564998ea7f9dbe8b5d908060c7c38
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240927094215eucas1p29ac564998ea7f9dbe8b5d908060c7c38
References: <20240927094207.1650085-1-m.wilczynski@samsung.com>
	<CGME20240927094215eucas1p29ac564998ea7f9dbe8b5d908060c7c38@eucas1p2.samsung.com>

Add mailbox device tree node. This work is based on the vendor kernel [1].

Link: https://github.com/revyos/thead-kernel.git [1]

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 6992060e6a54..7474f8b28592 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -555,5 +555,18 @@ portf: gpio-controller@0 {
 				interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
+
+		mbox_910t: mailbox@ffffc38000 {
+		       compatible = "thead,th1520-mbox";
+		       reg = <0xff 0xffc38000 0x0 0x4000>,
+			     <0xff 0xffc44000 0x0 0x1000>,
+			     <0xff 0xffc4c000 0x0 0x1000>,
+			     <0xff 0xffc54000 0x0 0x1000>;
+		       reg-names = "local", "remote-icu0", "remote-icu1", "remote-icu2";
+		       interrupt-parent = <&plic>;
+		       interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
+		       thead,icu-cpu-id = <0>;
+		       #mbox-cells = <2>;
+		};
 	};
 };
-- 
2.34.1


