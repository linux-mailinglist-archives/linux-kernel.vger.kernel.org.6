Return-Path: <linux-kernel+bounces-295556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F94959E47
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2DB21C22585
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEE619ABA4;
	Wed, 21 Aug 2024 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Mk6RVncR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mMEFH+w2"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624C9199943
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245944; cv=none; b=KjdHrAS31nnR1I7W4AK8BBtyJOcgSNf2BCNan83MDv6SnlbLvNmAIqLk2LuDgkMMO2e27pEXcnEdL+COrZDn7ZSjoe+x/WgyLpPBfyI39JSPBxDMnBSJJyViAohHwWXy/Rbhv3FZiLofFlA/EbPE/l5HTu1g+PurhM8RfX5zX+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245944; c=relaxed/simple;
	bh=VozuwTVFg2YahKjNSXoyaFv70BxtLPQzAWZ8FXGAmJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ercgJv0jNA8YDmzJRo7bKgQy84rG+MGWya9QeW1iyMWixurhdB3KImSLNXrPsUJEQj25p+DV09jNghlmhOp+w5kc9aeTPmHfcHwmVD3uJ55icJ0O8uW6nhhrDyNvVWIAn7I8GY3qdcdjK4gJ89HBvFCYZhUSDami7U+4qwmxK0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=Mk6RVncR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mMEFH+w2; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9B7A31151AA8;
	Wed, 21 Aug 2024 09:12:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 21 Aug 2024 09:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1724245940;
	 x=1724332340; bh=glHCdfrShpImXCyDmQP8PrGcVW7ZjuKaqZGGEuGe/Cw=; b=
	Mk6RVncRqJEvZCvw+/cJDrrK9rNkNmdenxnXuKYYJ0p3H1R7b5CocwmScxbaZUuP
	Hkx5oDtwF1NBS3Wg79JZFnutoiJrv2h8i6Glsr0nfvhr46mGU2YyXl7cpiy7n4dA
	VCBopHX/2VZs8y5vRaXNtJ56FYdA6xbbTe+HJMoOy3N4p4/nLloPT1SHDZIGc+He
	KAv54zy4h8/78nQFOMOpVUqMf5G1JyMc67DAtoXG4PqGm5Li/O3dr+N0bfeUFbFw
	+ugapKHvKFesah3lhvjqdxAi2m9EZQ830yD3JpmFc+9Pyd7eBIela4E6uNgya9uz
	xZXVOlD92zrNdtD0Abu9ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724245940; x=
	1724332340; bh=glHCdfrShpImXCyDmQP8PrGcVW7ZjuKaqZGGEuGe/Cw=; b=m
	MEFH+w2DuvGMMd+xjlgh6IEpK2St1UJs7gnyDn8Y945wqQvtjTGqyG7blopBST5W
	2H9IzHZFsYWwDjkMz4DqFbF5KK0BPWzWim0DMEFpuj/7/bZqUbn7f26xhQx8Q4NJ
	QFkOw9N51V/sxpdQtQudAU2B3X/wIc6oY/2cUnlSKAOcvrJrCpNX5A+AD4gvlDfj
	dyV9+mff5pEiu1YoKrdKxLLdx416D+FVctwURqhvRwQqGiOG5XUNFhyuV0jVsU3b
	QDAl63Ejg4C/YuDTsldaUXe58ZRkJT3aEoz194trz4MsMzqvHA/U6xV7s4rGaAUp
	dJ7qWTgVXIUS7xW1rD98g==
X-ME-Sender: <xms:tOfFZmdHqERK-Pbr3XYiCHTG9Qmn5wwJosUiQH9KBDbg8NrnYHpj4Q>
    <xme:tOfFZgMNt9i82gkuwLbUjrWlpz3s-ICqaR1YFKTkCKSFsoj2TcwkcreBezvmh_9l5
    oxaPLAy4Ld7r1amIWs>
X-ME-Received: <xmr:tOfFZniUxUuAulml90IBGucVPth6Von8q2wsutH7Ya2CaMiJeXYr3flAwSfN-lEItJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddukedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffek
    gedugefhtdduudeghfeuveegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
    tghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epkhgvrhhnvghlseigvghntdhnrdhnrghmvgdprhgtphhtthhopegthhgvnhhhuhgrtggr
    iheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhoohhnghgrrhgthheslhhishht
    shdrlhhinhhugidruggvvhdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:tOfFZj9zB_oNhnO6_XgCWnH2sZnCP5MiHNr5lqEk9SRHdVaVpau3-Q>
    <xmx:tOfFZitwDkOOr20_5wTlmOST5Q_4c5-1Pb9TGLZx7LKho4eQZCsXxw>
    <xmx:tOfFZqEAd7gxvj--az44ReLqoWU0PeXLd26tSNP39j4fDnO8w4aeQg>
    <xmx:tOfFZhN8RRptcPLNodETwksRS4dZh4IWLmVcPx23EnI9WoQoWsJSSQ>
    <xmx:tOfFZkWwb-AyZ25O1gyF3q28SdCyEZybmHsA56sYNfAlRv8mVkJSBn_N>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 09:12:19 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 21 Aug 2024 14:12:16 +0100
Subject: [PATCH 2/3] LoongArch: ACPI: Introduce get_cpu_for_acpi_id
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-loongarch_archnuma-v1-2-f47b191beee8@flygoat.com>
References: <20240821-loongarch_archnuma-v1-0-f47b191beee8@flygoat.com>
In-Reply-To: <20240821-loongarch_archnuma-v1-0-f47b191beee8@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=956;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=VozuwTVFg2YahKjNSXoyaFv70BxtLPQzAWZ8FXGAmJ0=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSjzzcYiu/a7ppn/4lNPbWCb8JhF5V7Yr5MlsuYtx9pc
 uxL9bTtKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgInwnWRkmClXl+GcG3VaWjLn
 qNCF/R0d9+fdi7NRcDQx2D23yIi5keF/ToH4C8vtX3q+Wx/J+Z4h2hEu9PnXfc2y1DWP3b5flcz
 lBAA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

This would allow us to reverse lookup cpu_id from apic_id.
Since it won't be a hot function, just use simple iteration match.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/loongarch/include/asm/acpi.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
index 313f66f7913a..5d4f8f5efdb6 100644
--- a/arch/loongarch/include/asm/acpi.h
+++ b/arch/loongarch/include/asm/acpi.h
@@ -45,6 +45,18 @@ static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
 	return acpi_core_pic[cpu_logical_map(cpu)].processor_id;
 }
 
+static inline int get_cpu_for_acpi_id(u32 acpi_id)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		if (acpi_core_pic[cpu_logical_map(cpu)].processor_id == acpi_id)
+			return cpu;
+	}
+
+	return -1;
+}
+
 #endif /* !CONFIG_ACPI */
 
 #define ACPI_TABLE_UPGRADE_MAX_PHYS ARCH_LOW_ADDRESS_LIMIT

-- 
2.46.0


