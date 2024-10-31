Return-Path: <linux-kernel+bounces-391270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5409B84A0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5062836DF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E731D0F7E;
	Thu, 31 Oct 2024 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pPNLMeeI"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347921CDFD6
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730407675; cv=none; b=jxMi6QCiYc9wN4roYSeLl0u+r1wxEwezGM1pUendtb0bZFaDZNbYpz/BVXi6VDz5W/TmyOZX9o70QXjzgNqQKqBdM3AkJOP1POmFLpLyT6ZOkS721hd4citKzKRDYabHEPXNyLimeG8uVwN6rQXOva3j8P670JjuOdyHkSJpSrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730407675; c=relaxed/simple;
	bh=rFgxEKAY53F1vr1UjWz5Op/T157tTAWmRMUpgFYnWY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ewL3r5AeLuT6fgSL7NkqOarlX3Xo4zA0A3B0tTxFjUlWtrv+S8edsvkPIFBqcKUQcgINcW1UxTQRzpusyHEUZ/QhfNpiyxqbdEQWqfGo8wnNFIFJlOrihi9Npk2A3Q1l63++BjJ2gXqQLRf3XbPw11ruzz+MKlPLA9WH5A+wVTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pPNLMeeI; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241031204738euoutp01137c53752de240423dff379de05983b9~DpJj6iYa_1761317613euoutp01r
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:47:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241031204738euoutp01137c53752de240423dff379de05983b9~DpJj6iYa_1761317613euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730407658;
	bh=vxNiS8XZmEMSZYQqnfyixq5+aqnBLp9jGcPWzOWdRC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pPNLMeeIVisSQc/wiEnyU5IsPQoSJdo4/2MqulL6DREOjMBM64OC7JXt1cf2U5Oat
	 x23tnPw9KWUcOSyVw7WiIlv/meGN0jtTXhCBYeCmvSwMQ+mEB/q36Ub6vJAD+nCB58
	 cifC5eBezs+GSpGUJH31I+8SZq/qgSB+x52hNJ9Q=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241031204737eucas1p15251ab7dfccfaa4906d9ac64859ef16c~DpJigZ9Mx2981929819eucas1p1P;
	Thu, 31 Oct 2024 20:47:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 0F.C6.20409.9ECE3276; Thu, 31
	Oct 2024 20:47:37 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241031204736eucas1p119124263356d8e5924b03f07a5638b42~DpJheAmKM2174621746eucas1p1U;
	Thu, 31 Oct 2024 20:47:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241031204736eusmtrp2bd47663bb74eb2ad5ced19e5d4694f4a~DpJhdR-oD1392413924eusmtrp2v;
	Thu, 31 Oct 2024 20:47:36 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-1d-6723ece943d1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 19.53.19920.8ECE3276; Thu, 31
	Oct 2024 20:47:36 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241031204735eusmtip106d535dfcd5976eb7d664912f7f31151~DpJgqUCFN1679316793eusmtip1K;
	Thu, 31 Oct 2024 20:47:35 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com, samuel.holland@sifive.com,
	emil.renner.berthing@canonical.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v5 3/3] riscv: dts: thead: Add mailbox node
Date: Thu, 31 Oct 2024 21:47:23 +0100
Message-Id: <20241031204723.1149912-4-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031204723.1149912-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djP87ov3yinG/x9z26x9fcsdos1e88x
	Wcw/co7V4t6lLUwWlzpXMFq82NvIYnFtxVx2i5ez7rFZXN41h81i2+cWNou1R+6yW6z/Op/J
	4uXlHmaLtln8Fv/37GC3WH3uCotFy/4pLA6CHrMaetk83rx8yeJxuOMLu8fOWXfZPTat6mTz
	2Lyk3qNl7TEmj/f7rrJ59G1Zxehxqfk6u8fnTXIB3FFcNimpOZllqUX6dglcGS+/trAVHOGq
	OHnnLGMD436OLkZODgkBE4ntW1eydzFycQgJrGCUWP5wGSuE84VRYsLEmcwgVUICnxklZj2S
	hOn4++4fI0TRckaJZfefMkE4bxglTq66ywJSxSZgJPFg+XywUSIC65kknu1eBraEWaCXUWLq
	3plMIFXCAtYSS+e8A7I5OFgEVCXe3kgCCfMK2Eus/PuNBWKdvMT+g2fBzuAUcJCYvauVHaJG
	UOLkzCdgNcxANc1bZzODzJcQWM8pcfDWHHaIZheJ9dfmMkHYwhKvjm+BistI/N85HyqeL/Fg
	6ydmCLtGYmfPcSjbWuLOuV9sILcxC2hKrN+lDxF2lOhZeJ0VJCwhwCdx460gxAl8EpO2TWeG
	CPNKdLQJQVSrSUzt6YVbem7FNqilHhLzT9xjmsCoOAvJM7OQPDMLYe8CRuZVjOKppcW56anF
	Rnmp5XrFibnFpXnpesn5uZsYgWnw9L/jX3YwLn/1Ue8QIxMH4yFGCQ5mJRHeDwXK6UK8KYmV
	ValF+fFFpTmpxYcYpTlYlMR5VVPkU4UE0hNLUrNTUwtSi2CyTBycUg1MjJ9OO6QGCPxdOePd
	heysQC8Gxb36E9WmMb9//C3ttYt95C7WmRcUXvaKrHtmynrw5/Una/e84+JXuvT+VvwCy8qX
	1w9sXfbwxGPVcFFzg0/d8YWPvrzd/Oa3ouH0KX8tIt2i7Jk+fvPf/D/Katucf7Jrb2zRLDO6
	pbjhjft5M+Fojpgg1S0yXbsiC2rEWBicfppXT00uLzJlmNfM3/LqDPOFtH8c+ue/TP00a+s0
	6fSIm0tPT/VqUb+T5tg4o7tNfplZb+7cqdx/1Y16DGxXGgYnVRVFLJiodvQdSwnP5bV+si/1
	l8+Y8fdxh2/XtBJWXg0fzXU2eetfFhirVjomLfSwYryRlVM8XXnfDolkJZbijERDLeai4kQA
	kGrjlfIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xu7ov3iinG3xayGKx9fcsdos1e88x
	Wcw/co7V4t6lLUwWlzpXMFq82NvIYnFtxVx2i5ez7rFZXN41h81i2+cWNou1R+6yW6z/Op/J
	4uXlHmaLtln8Fv/37GC3WH3uCotFy/4pLA6CHrMaetk83rx8yeJxuOMLu8fOWXfZPTat6mTz
	2Lyk3qNl7TEmj/f7rrJ59G1Zxehxqfk6u8fnTXIB3FF6NkX5pSWpChn5xSW2StGGFkZ6hpYW
	ekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GS+/trAVHOGqOHnnLGMD436OLkZODgkBE4m/
	7/4xdjFycQgJLGWU2L7sKRNEQkbiWvdLFghbWOLPtS42iKJXjBLfr99hA0mwCRhJPFg+nxXE
	FhHYzyTx+mwRSBGzwERGiZtz7zOCJIQFrCWWznkHNJWDg0VAVeLtjSSQMK+AvcTKv9+gFshL
	7D94lhnE5hRwkJi9q5UdxBYCqjnauocdol5Q4uTMJ2D1zED1zVtnM09gFJiFJDULSWoBI9Mq
	RpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwIjdduzn5h2M81591DvEyMTBeIhRgoNZSYT3Q4Fy
	uhBvSmJlVWpRfnxRaU5q8SFGU6CzJzJLiSbnA1NGXkm8oZmBqaGJmaWBqaWZsZI4r9vl82lC
	AumJJanZqakFqUUwfUwcnFINTOX1f1rPtgldebKyJ2g+d9jfxqMZ1ietQucKXmVoYak+YLto
	enKSgl/ZtCMa2xfUMDIYqPa95f6fvdDavGyq4p33Hcp3P/a3d3x94iLBsG2Zs8bJ+FlhQYs3
	qOXarHJ08TvNfrGEaZKqQ+9THcU8vo5+jxrXsviT3foe3HFGPw0aPX4dy5ZWUFieqfhJknd5
	hWrHwjpmbmfbA8niTyXzVnxhtbxzX8f2vdizVTfEXbqcl/v75iYeyGl6/UJKdfPWbR8maRgv
	qci68nnV4te3GBqPc/LzcCXHSiw/J3hzmTjXf7uAnOzF0ipvPTP/ZonMNOn5nlja4+T7yLTt
	rrrO7jmeQslqm9vP9fbbmCqxFGckGmoxFxUnAgBI2BACYQMAAA==
X-CMS-MailID: 20241031204736eucas1p119124263356d8e5924b03f07a5638b42
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241031204736eucas1p119124263356d8e5924b03f07a5638b42
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241031204736eucas1p119124263356d8e5924b03f07a5638b42
References: <20241031204723.1149912-1-m.wilczynski@samsung.com>
	<CGME20241031204736eucas1p119124263356d8e5924b03f07a5638b42@eucas1p1.samsung.com>

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


