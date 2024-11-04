Return-Path: <linux-kernel+bounces-394530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C77E9BB0A0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C468A1F216ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D09B1B219C;
	Mon,  4 Nov 2024 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cKHu7gBu"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD5A1B0F1C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730714891; cv=none; b=tN9m0AfthRhJ8HSOzl42oZovNBe9mbcf0F++upQ0+j7qez4M9nJ/AIjaPwXzpF2EhtdPX9n2Jluh012r5GS0zDUT24oUB6j8w/D+59q/qxYzEiFMmFM/5ImOB/GE5NVfn3nqXfjwsKyuM5liqmm0vmEpQmOlUpL/5zmLiZJIGpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730714891; c=relaxed/simple;
	bh=rFgxEKAY53F1vr1UjWz5Op/T157tTAWmRMUpgFYnWY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Lr7UP8sVB3+o3SaQ0RmwRBINyDVysjVAkC8yxi/tDQMvWwmWpKpsYw5Bg23Iie7gzhCGPMc02ropmFOSTIPumOcz34gmyXfXx/7BGiPVHHCWdEwAvKPZzBeMgj0bHCRGXl7tt58UzU/n4O4ldhgt8y150JOqngTvX8HGTFweukY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cKHu7gBu; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241104100802euoutp02fa91cfd47abc1168660085a3bcc0470a~EvAQRTakH0773007730euoutp02O
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:08:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241104100802euoutp02fa91cfd47abc1168660085a3bcc0470a~EvAQRTakH0773007730euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730714882;
	bh=vxNiS8XZmEMSZYQqnfyixq5+aqnBLp9jGcPWzOWdRC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKHu7gBuasc5eAfb7TwtV0Zl+MIpwGHveZ8zwqQkNxenzEcc1UO1TAQsrq6QIx68f
	 YtTWO3WBI0sv6WMJ5K/N7RmAkkgshKdT4VhaJ/4+oeAw3JK3GupBNUgI2ed4I5OoOT
	 4xkOpRnBcpejidyZmwotjHNB7LDkge5mNW0kGaJw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241104100802eucas1p1b33700ff4fdd391202998a0330c0d8cc~EvAP2EG1X0455904559eucas1p1I;
	Mon,  4 Nov 2024 10:08:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id CD.DE.20397.10D98276; Mon,  4
	Nov 2024 10:08:01 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241104100801eucas1p27cd0d7b9b5b4500604470664884c42fb~EvAPT3Z4K2364623646eucas1p2V;
	Mon,  4 Nov 2024 10:08:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241104100801eusmtrp1757aa91b22956a42dc6fbe959ac26d29~EvAPS0WIq1011310113eusmtrp1a;
	Mon,  4 Nov 2024 10:08:01 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-56-67289d012784
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 52.B7.19654.10D98276; Mon,  4
	Nov 2024 10:08:01 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241104100800eusmtip1e1410955ce324ec0762b7beedd809821~EvAOeo3AI2849928499eusmtip1S;
	Mon,  4 Nov 2024 10:08:00 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com, samuel.holland@sifive.com,
	emil.renner.berthing@canonical.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, christophe.jaillet@wanadoo.fr, Michal Wilczynski
	<m.wilczynski@samsung.com>
Subject: [PATCH v6 3/3] riscv: dts: thead: Add mailbox node
Date: Mon,  4 Nov 2024 11:07:34 +0100
Message-Id: <20241104100734.1276116-4-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104100734.1276116-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7djP87qMczXSDa7OtbDY+nsWu8XWg3NZ
	LdbsPcdkMf/IOVaLe5e2MFlc6lzBaPFibyOLxbUVc9ktXs66x2ZxedccNottn1vYLNYeuctu
	sf7rfCaLl5d7mC3aZvFb/N+zg91i9bkrLBYt+6ewOAh5zGroZfN48/Ili8fhji/sHjtn3WX3
	2LSqk81j85J6j5a1x5g83u+7yubRt2UVo8el5uvsHp83yXl8vrueNYAnissmJTUnsyy1SN8u
	gSvj5dcWtoIjXBUn75xlbGDcz9HFyMEhIWAiMeGYSRcjJ4eQwApGibX7dCDsL0D2heQuRi4g
	+zOjxJz2DmaQBEj96i1PWSESyxklpm3oZoJw3jBKfDy0gQ2kik3ASOLB8vlgVSIC65kknu1e
	xg6SYBZYxyjx6Yo9iC0sYC3x4e4TsLEsAqoSF6ZNZAWxeQXsJfqubmSCWCcvsf/gWbAaTgEH
	iV+9X5ggagQlTs58wgIxU16ieetsZpBlEgK7OSWWvXrNBtHsIrH53nxWCFtY4tXxLewQtozE
	6ck9LBB2vsSDrZ+gfquR2NlzHMq2lrhz7hcbKIyYBTQl1u/Shwg7Svz7eYMVEnR8EjfeCkKc
	wCcxadt0Zogwr0RHmxBEtZrE1J5euKXnVmyD+spDYt2EI8wTGBVnIXlmFpJnZiHsXcDIvIpR
	PLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwLZ7+d/zrDsYVrz7qHWJk4mA8xCjBwawkwjsv
	VT1diDclsbIqtSg/vqg0J7X4EKM0B4uSOK9qinyqkEB6YklqdmpqQWoRTJaJg1OqgWnKrxPM
	7jq6OYfULrC+7FpfuXqis6K8+cygPLNPs7byn/5x+1ny+Zt6V8WvBPcvkxbO/VRjfmPPFrfI
	N+/5OBJ/P7x4nK0keFcK3yv/h5zbfi3Z3uL1482etqeFX758Yf/6X6Rr/tELG7U6b75Vnrr3
	8qzAzx0rGE/9W/JO+dLePlF7hiPvz289ck334C+Ri3eWXrio2JBSfemRlswupwJdb+vzbtUf
	XzolR62eE7LrbECLpkC/lmTuTf7A43EGHRaOy2Pm8zQFdYuu4b736aMxa1HscoFv/6SKY2yi
	Pk5wu7vg4Nt5P0PPHI67L2G3gNmaTV5hv/msfe1fp7sKrbijcu60+6UZ+xennRBzPy45Q4ml
	OCPRUIu5qDgRABP2Lrj6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xu7qMczXSDWZMFrPY+nsWu8XWg3NZ
	LdbsPcdkMf/IOVaLe5e2MFlc6lzBaPFibyOLxbUVc9ktXs66x2ZxedccNottn1vYLNYeuctu
	sf7rfCaLl5d7mC3aZvFb/N+zg91i9bkrLBYt+6ewOAh5zGroZfN48/Ili8fhji/sHjtn3WX3
	2LSqk81j85J6j5a1x5g83u+7yubRt2UVo8el5uvsHp83yXl8vrueNYAnSs+mKL+0JFUhI7+4
	xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j5dcWtoIjXBUn75xlbGDc
	z9HFyMkhIWAisXrLU1YQW0hgKaPE2ydaEHEZiWvdL1kgbGGJP9e62CBqXjFKPDgTBmKzCRhJ
	PFg+H6xXRGA/k8Trs0VdjFwczAKbGCUurexnB0kIC1hLfLj7hBnEZhFQlbgwbSJYA6+AvUTf
	1Y1MEAvkJfYfPAtWwyngIPGr9wsTxDJ7iYMH9jBC1AtKnJz5BOwgZqD65q2zmScwCsxCkpqF
	JLWAkWkVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYAxvO/Zzyw7Gla8+6h1iZOJgPMQowcGs
	JMI7L1U9XYg3JbGyKrUoP76oNCe1+BCjKdDdE5mlRJPzgUkkryTe0MzA1NDEzNLA1NLMWEmc
	l+3K+TQhgfTEktTs1NSC1CKYPiYOTqkGpkKDcxJNLBO5f86LFAg/dTEs+cCkqHefnK//YVKf
	NGu96NQZOsv/TF9nV3743rxPS+YrtbiX/kyzOB14eUXvw0T1Xz8T3xRHcagarZY4FVakJ21m
	+M94zeEbHpUbTWc2BB2s/vRKjqlrxiXtvCWh5w9OzQviEsrbetEpvydc8bjC9bU8S74LXTXN
	ulqQtr0jeP7BE+LFERP/3ftwMDWlOdz/0Pm/yTwJe96EvP7ObPq0Yd/U8NcP+57cuVT5/rbv
	hJm3HzQobvpSIzrp7eLsNZ6RO668cdCL2egqtVd76kKN3ct4/diN2ZU29W4Xi7oup7U76SGT
	UH7Q+T63n0vjMw/lrJMMmMp39nmVZ0vjhydKLMUZiYZazEXFiQCe0wTnagMAAA==
X-CMS-MailID: 20241104100801eucas1p27cd0d7b9b5b4500604470664884c42fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241104100801eucas1p27cd0d7b9b5b4500604470664884c42fb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241104100801eucas1p27cd0d7b9b5b4500604470664884c42fb
References: <20241104100734.1276116-1-m.wilczynski@samsung.com>
	<CGME20241104100801eucas1p27cd0d7b9b5b4500604470664884c42fb@eucas1p2.samsung.com>

Add mailbox device tree node. This work is based on the vendor kernel [1].

Link: https://github.com/revyos/thead-kernel.git [1]

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 6992060e6a54..89de5634d3d3 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -520,6 +520,22 @@ timer7: timer@ffffc3303c {
 			status = "disabled";
 		};
 
+		mbox_910t: mailbox@ffffc38000 {
+			compatible = "thead,th1520-mbox";
+			reg = <0xff 0xffc38000 0x0 0x6000>,
+			      <0xff 0xffc40000 0x0 0x6000>,
+			      <0xff 0xffc4c000 0x0 0x2000>,
+			      <0xff 0xffc54000 0x0 0x2000>;
+			reg-names = "local", "remote-icu0", "remote-icu1", "remote-icu2";
+			clocks = <&clk CLK_MBOX0>, <&clk CLK_MBOX1>, <&clk CLK_MBOX2>,
+				 <&clk CLK_MBOX3>;
+			clock-names = "clk-local", "clk-remote-icu0", "clk-remote-icu1",
+				      "clk-remote-icu2";
+			interrupt-parent = <&plic>;
+			interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		ao_gpio0: gpio@fffff41000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0xff 0xfff41000 0x0 0x1000>;
-- 
2.34.1


