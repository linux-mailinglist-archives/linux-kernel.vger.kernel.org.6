Return-Path: <linux-kernel+bounces-364038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C152299CA49
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82851C226A9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02FD1AA794;
	Mon, 14 Oct 2024 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Mut85KB+"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9371D1A76AB
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728909260; cv=none; b=VFmr8TqpWrFEtP1D6RsXlrMWXcB00jIieQyoFVjy16mXBy4bZCiAPY8Ky/QO0l9U47Xt+i9X3yeSwBFCIZbMCpnafoMW+SttC64Jgyl0l9UA4B0ZmNnKMZgJrlKxkUJ/OOdLgdzFpOkZM2yxXfxKVoQ7VDq0OLprbCAZcvz3zJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728909260; c=relaxed/simple;
	bh=pbX6ealTQx9fVIgIJYGW1OYa9DK6ZwQ9MQACLMUHfbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=uTF5uqOrhkWfWcrJWNjojbyK7lafxD/EWWL8OQmQwHRyVutmInFTFMEylpYUk27siYwkvfGy/g8dLElNBLIC6TUgv+qLkG7O+9GB+g97LvcLqZfSZKyDGufU21WPkgkbO/hyoQVPx6BlJmn0smxsDQi1waitolzUBg+kiLpUMkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Mut85KB+; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241014123412euoutp01e9f848ad9d7566f15c7e1b8e61700787~_Uc4xwa020198501985euoutp018
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:34:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241014123412euoutp01e9f848ad9d7566f15c7e1b8e61700787~_Uc4xwa020198501985euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728909253;
	bh=k5bx/+S6KDMkK8Imq/hflrXf6RmrkhVBbi73CyaDrlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mut85KB+bjc212Fb3lhT+CYDsVhpU42bt4nLrhdYPjnplyOr4RIpKdNMgK9nPy8s/
	 j+NtsyovWQdQ0EHpOQ4sJ+bOcDPXoZjSNbUNur0mdO1bgas4xhH1RZY7efTfKca74h
	 w66vZRnb38Gkyl1NNv0gS8VJfq6gg2LdLMzOv8EU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241014123412eucas1p2317656ae2718e5559068372f1e69eb46~_Uc4cYYuW3262332623eucas1p2x;
	Mon, 14 Oct 2024 12:34:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id FF.01.09875.4CF0D076; Mon, 14
	Oct 2024 13:34:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241014123412eucas1p2144768f373a2e2de7f6d00e7b67f9328~_Uc39weuk3263132631eucas1p20;
	Mon, 14 Oct 2024 12:34:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241014123412eusmtrp123830495008b1b9e8e3a7dd8c739473d~_Uc36kM-U1593615936eusmtrp1c;
	Mon, 14 Oct 2024 12:34:12 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-7d-670d0fc482c0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id B1.23.19096.3CF0D076; Mon, 14
	Oct 2024 13:34:11 +0100 (BST)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241014123411eusmtip1cde3dc3cf904bf3c313474de9c110b18~_Uc3ILKWt0548005480eusmtip1-;
	Mon, 14 Oct 2024 12:34:11 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, m.szyprowski@samsung.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v4 3/3] riscv: dts: thead: Add mailbox node
Date: Mon, 14 Oct 2024 14:33:14 +0200
Message-Id: <20241014123314.1231517-4-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014123314.1231517-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURSFeTPDdFosDMWEByJqRRATAYnBUYkURTJxD9EoEJdqJ7URCrQi
	aIhiQKwILgg0jgqaIGCjgmyCigsiqEiJVKwIJZpgYhWL2KqpBpcydfn33XvOzXn35hGoqMfV
	l1AodzMqpTRJjAuwpg57z9x2D6E8rPuZmGr8zvKoy616hCpv17tSQ70NCPW29SBGPa8+x6PM
	7BBOGW6cxakmay5OXWk38aiaz+UIZTYUoFQe60H9vNXMo3LvFGMSD3rEbMbo+xobj25hTTy6
	TncEp+srDtC5VzoQevR2H04fa9ABujfHyKOtdf7rBAmCSBmTpNjDqEKXbBPsrBy04qkGIrO5
	yA6ywTCeDwgCkvPhqDY8HwgIEVkNYM3RapQrbADa2hoAV1gBND6tdM0H/IkJy90zTqEKwEOt
	XZhDEJEjAA71L3IwTobDV1Xlrg7TZNICYNHzAcRRoGQhgCWtpxGHy4tcDB9r3uIOxshZcODL
	+4kIIRkFNV+f4FzcNHjnXjfqYD4pgRV3b2GcxxM+Oj08wehvT07jGZTza/nQWhHBcQyss4zx
	OPaC7zobnOwHu04VYBynwFeNn5yzWbCloNPJi+Gg/tvEkVAyGNbcCOXa0fD6RaPzdu7wxQdP
	7gXusKhJi3JtIdTkiTh3ICwpKPwbqq9uQjim4c9sLXYCzGD/24X9bxf2X+55gOqAN5OuTpYz
	6nAlkxGiliar05XykB0pyXXg95/r+tFpawZV78ZC2gBCgDYACVQ8WThawpeLhDLp3n2MKmWr
	Kj2JUbeBKQQm9hbOkk1jRKRcupvZxTCpjOqPihB832ykxSfWtLAk5iRhdzmmfSkJviSLGDQu
	N1wIsuc2vuzzebiFCuwrnD62Jvr81KMvbJFH1upTi7fqxg3muNCsb5H1UatHBt3zOiyJST5l
	3usC4jzc/OTtj3ULPpYZAuS1gZWl/CDE/Dnuw3oYHpjmMt6bnhf5YOr8wxsUx30NOSvIpfft
	GZL6LSvH3RKvbQp7msWqfXRaP1lMRIAlId7LpvN6vxTvH0iTXt0uqtxrkln0M4P2I2Hdm9MS
	PP2NOjTq47m1ErY/p+dgd3xhctnczKwobX/pTc0k71r/1RnNtp6N+UysYGbQthSZUrFKEVJq
	W5aWObvL/Dp6x/d9pjcubsXDYky9UzpvDqpSS38B39c4RuIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xu7qH+XnTDS7MtrbY+nsWu8WaveeY
	LOYfOcdqce/SFiaLF3sbWSyurZjLbvFy1j02i8u75rBZbPvcwmax9shddov1X+czWby83MNs
	0TaL3+L/nh3sFi37p7A48Hu8efmSxeNwxxd2j52z7rJ7bFrVyeaxeUm9R8vaY0we7/ddZfPo
	27KK0eNS83V2j8+b5AK4ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1s
	UlJzMstSi/TtEvQylt35zFZwmaNix6SfjA2MT9i6GDk5JARMJN4dmM3YxcjFISSwlFHi/9+3
	rBAJGYlr3S9ZIGxhiT/XusAahAReMUocfGkDYrMJGEk8WD6fFaRZROAPo8T1Z2/AJjELTGSU
	uDn3PiNIlbCAtcSpjhdg3SwCqhK3v70G28ArYC/R8f0M1BnyEvsPnmUGsTkFHCSWHNjDArHN
	XqJzzVs2iHpBiZMzn4DFmYHqm7fOZp7AKDALSWoWktQCRqZVjCKppcW56bnFRnrFibnFpXnp
	esn5uZsYgVG57djPLTsYV776qHeIkYmD8RCjBAezkgjv+6mc6UK8KYmVValF+fFFpTmpxYcY
	TYHunsgsJZqcD0wLeSXxhmYGpoYmZpYGppZmxkrivGxXzqcJCaQnlqRmp6YWpBbB9DFxcEo1
	MHXvmOlx31ti1ixlp1B7Resyzd9icopTv151ObX/7CmBjJpW3Zhke1mDKZVP1nGvbd7CGas0
	8YfO1wb/oC0LLvwpqfmbfOOALQv/scOvQ9uLZh/6/PXQu+A/Oz4IM1vM8KiqkhFrMVn1fU5D
	6t01elxVXIxCTF5tpiVqSQ7LW6zb+GK0RHXex5mIV5yV0ZruxaNyRmjPC/vi9j69pFJ/rtBT
	kYvbg6RO3JFbpsHlzCUt/TiH9UePgPvkuddbU0QO6Lqmdekpqy8v3POoeWbMz8bnITk8F9bW
	l2Z8jCn1ZVHbUfGo6v7fad3Lv6dNWrYp6xJ/p6cXo/qRetPDK75zvz7Opeso9f9HndaV2qlK
	LMUZiYZazEXFiQACReCxUwMAAA==
X-CMS-MailID: 20241014123412eucas1p2144768f373a2e2de7f6d00e7b67f9328
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241014123412eucas1p2144768f373a2e2de7f6d00e7b67f9328
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241014123412eucas1p2144768f373a2e2de7f6d00e7b67f9328
References: <20241014123314.1231517-1-m.wilczynski@samsung.com>
	<CGME20241014123412eucas1p2144768f373a2e2de7f6d00e7b67f9328@eucas1p2.samsung.com>

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


