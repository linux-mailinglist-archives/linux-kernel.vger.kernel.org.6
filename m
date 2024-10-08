Return-Path: <linux-kernel+bounces-355718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86343995603
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324871F23070
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8100120FAAD;
	Tue,  8 Oct 2024 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Br28VT5S"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EECB20CCE4
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409760; cv=none; b=j36zl+ExjqLokj8HbreQ7TuCoxIxb4kyNXtzUrVi5dpAoxgzSr7j4OZCYSt+vcFsdU2anhwh8vjxK254CkBmi/02Y8KzzdTEUoJC+aHhbgxkJRgzOMRmBR+Ke7EXWs6STFH4VU8Tst9FY4ctttYLrRy+yJBSJT5fQ6iAWIYCCqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409760; c=relaxed/simple;
	bh=pbX6ealTQx9fVIgIJYGW1OYa9DK6ZwQ9MQACLMUHfbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=WbfziNzuksHJtsTw5KE5UAA/PGVpoakguAreH9bAPgPhyhfUi5gvOFFfDjY593Dy7HUX37Vz/dd3Qag+GFGXZSqxh6TD+aQD+8lLhfQxaRGtWWHtmZaEIPapG2hH21VZiWL/A5k9sds3TgIpRE15vRX8d0fgOTitfoZtVw47ScM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Br28VT5S; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241008174911euoutp019ea2a4e0c87725e901e00310e13ba20b~8i4MJB6hr0373303733euoutp01C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:49:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241008174911euoutp019ea2a4e0c87725e901e00310e13ba20b~8i4MJB6hr0373303733euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728409751;
	bh=k5bx/+S6KDMkK8Imq/hflrXf6RmrkhVBbi73CyaDrlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Br28VT5Sd1vRP8ryX/E+YDWJmsPZb/Z0KD647msQGbdPg+ju5/Yih7i+wIY6FGm1E
	 cV2HF9+kMSc6qgnarzMWad83uj5uZ6XMnK4hfFfAAvMrORlWYuIGMgLTYbumXBvOnI
	 wlhsWBWrIvMyeCqsZJx3Vy2uo04AQj+5Y+33afD0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241008174911eucas1p207f10116056604fdb66a505394a0ba9a~8i4Ld3CSP0826108261eucas1p2w;
	Tue,  8 Oct 2024 17:49:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id B3.43.09620.79075076; Tue,  8
	Oct 2024 18:49:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241008174910eucas1p2e832dd68ad6b2ef1420ce211fc849fba~8i4KYvOEu1811118111eucas1p2h;
	Tue,  8 Oct 2024 17:49:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241008174910eusmtrp2635ab7bb5836b25fb982aad4b45b32e5~8i4KYDVLj3011330113eusmtrp2Z;
	Tue,  8 Oct 2024 17:49:10 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-66-67057097b322
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 13.FD.14621.59075076; Tue,  8
	Oct 2024 18:49:09 +0100 (BST)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241008174909eusmtip2c1fea8c67365df2bf2b8a8a00a5b1425~8i4Jmf0RS2916929169eusmtip2L;
	Tue,  8 Oct 2024 17:49:09 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v3 3/3] riscv: dts: thead: Add mailbox node
Date: Tue,  8 Oct 2024 19:48:52 +0200
Message-Id: <20241008174852.222374-4-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008174852.222374-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7djPc7rTC1jTDe6cZrXY+nsWu8WaveeY
	LOYfOcdqce/SFiaLF3sbWSyurZjLbvFy1j02i8u75rBZbPvcwmax9shddov1X+czWby83MNs
	0TaL3+L/nh3sFi37p7A48Hu8efmSxeNwxxd2j52z7rJ7bFrVyeaxeUm9R8vaY0we7/ddZfPo
	27KK0eNS83V2j8+b5AK4orhsUlJzMstSi/TtErgylt35zFZwmaNix6SfjA2MT9i6GDk5JARM
	JF7fXQNkc3EICaxglPh3eSUzhPOFUeL76kUsEM5nRolry74wwrScObGJESKxnFFi2e5jUP1v
	GCXerPsANphNwEjiwfL5rCAJEYF3jBKTrt1mAnGYBXoZJabunckEUiUsYC1xdNIFVhCbRUBV
	4uzC98wgNq+AnUTL/uesEPvkJfYfPAsW5xSwl3j7axFUjaDEyZlPWEBsZqCa5q2zgeIcQPXT
	OSWeBUG0ukj8WtMAdbawxKvjW9ghbBmJ/zvnM0HY+RIPtn5ihrBrJHb2HIeyrSXunPvFBjKS
	WUBTYv0ufYiwo8TyhyDfg2zik7jxVhDiAD6JSdumQx3AK9HRJgRRrSYxtacXbum5FduglnpI
	3J4+mWkCo+IsJK/MQvLKLIS9CxiZVzGKp5YW56anFhvnpZbrFSfmFpfmpesl5+duYgQmutP/
	jn/dwbji1Ue9Q4xMHIyHGCU4mJVEeCPWMKYL8aYkVlalFuXHF5XmpBYfYpTmYFES51VNkU8V
	EkhPLEnNTk0tSC2CyTJxcEo1MEU8OFJjsruU/0dM7Y8zUr/qpm3jvmK0Tkt48vcNj2c8DvA4
	EnVW8Lf38/1yX78aLZe1LnR7cX/5z32run59n7HpfkymuMDxa+f6rLYbvDF6EJH7eH5WUtSb
	rzcC+2bm3J/I3WF2NnGXtOAxcQ02rlKhWyq3fgR2LVNT/phj9qnA5Uoew+Gc13vZX6d+3HmF
	cdP9yOo7Vq2rJR70LpQ49Gv1U85L+/pF4564Xu//UfxlqUdlmsFnX++Ls6VaQ17pzHEJEb64
	2dCBK7PuiOiuusknTWb8OvtBV9pJ/Y6qvfS9R1xRDSq/G81lt7J0rLjWcVWmMuH481u3D1eu
	D1hofYnh/fnHE/5avb676JNzxKkHSizFGYmGWsxFxYkAiohriuMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7pTC1jTDf51WVps/T2L3WLN3nNM
	FvOPnGO1uHdpC5PFi72NLBbXVsxlt3g56x6bxeVdc9gstn1uYbNYe+Quu8X6r/OZLF5e7mG2
	aJvFb/F/zw52i5b9U1gc+D3evHzJ4nG44wu7x85Zd9k9Nq3qZPPYvKTeo2XtMSaP9/uusnn0
	bVnF6HGp+Tq7x+dNcgFcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2
	Kak5mWWpRfp2CXoZy+58Ziu4zFGxY9JPxgbGJ2xdjJwcEgImEmdObGLsYuTiEBJYyihxetop
	ZoiEjMS17pcsELawxJ9rXWwQRa8YJbo6n7OCJNgEjCQeLJ/PCpIQEfjDKHH92RuwUcwCExkl
	bs69zwhSJSxgLXF00gWwDhYBVYmzC9+DreAVsJNo2Q8xSUJAXmL/wbNgcU4Be4m3vxaB2UJA
	NUd29LFD1AtKnJz5BOwkZqD65q2zmScwCsxCkpqFJLWAkWkVo0hqaXFuem6xoV5xYm5xaV66
	XnJ+7iZGYFxuO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMIbsYYxXYg3JbGyKrUoP76oNCe1+BCj
	KdDdE5mlRJPzgYkhryTe0MzA1NDEzNLA1NLMWEmc1+3y+TQhgfTEktTs1NSC1CKYPiYOTqkG
	JvcHRYvSCwrj6rT+xSz7/1jRd5HDHOan37ce0p6hynPn+YqlHlOqHjmtiZi8+dk/T73LQVuS
	3b4dPfI4kOP4j41/mLbb+jLtm6bUtKi9nMkszF1y5UzhklK2zyz/rp/lkvBgy1K87/Vuew6X
	O4PN63tMjEym+WeF/6blV07ij7CwqHi79+0NKbdY5TTHrYzShwtO/o6b1HqqpVx6enPaGcmb
	8bPmT39iuZhD0yOi6PuNX2rcH/8+WSfbLRLPyl2YuMBw9QWViU/kGWLbGitWSQgzfv6U+EHR
	21Kz8OlZw5sbFWzWuLj+n3TW3EOs845jm84Py5qumR3zOfPesssash00ld2w3vybx9U/ygqx
	SizFGYmGWsxFxYkA6J2DyFQDAAA=
X-CMS-MailID: 20241008174910eucas1p2e832dd68ad6b2ef1420ce211fc849fba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241008174910eucas1p2e832dd68ad6b2ef1420ce211fc849fba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241008174910eucas1p2e832dd68ad6b2ef1420ce211fc849fba
References: <20241008174852.222374-1-m.wilczynski@samsung.com>
	<CGME20241008174910eucas1p2e832dd68ad6b2ef1420ce211fc849fba@eucas1p2.samsung.com>

Add mailbox device tree node. This work is based on the vendor kernel [1].

Link: https://github.com/revyos/thead-kernel.git [1]

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 6992060e6a54..435f0ab0174d 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -555,5 +555,17 @@ portf: gpio-controller@0 {
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
+		       #mbox-cells = <2>;
+		};
 	};
 };
-- 
2.34.1


