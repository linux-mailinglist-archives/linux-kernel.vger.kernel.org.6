Return-Path: <linux-kernel+bounces-269814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3909943718
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ECC6282893
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305091607B6;
	Wed, 31 Jul 2024 20:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="ehxxPX1x"
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3340A45023
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722457740; cv=none; b=sSAPxTgpwQ5jr26yi1XAdvgc3b+UaaLovb1DuG7/bgVP7oWKZ8FbahpS1vyfBXmGQTC9vrRPCWOexi73MMgg258IMWZ9J5v7eg680861cr1Ot6YTqCL8k/S8mfdIAuCNAyg0g46ImIAma0xZfeMxy4cmiz35UqAdNNuQw31Epjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722457740; c=relaxed/simple;
	bh=j6v7lTD1pCUL9Ydx0b3syzZyUX73yVXnWh0CnQpkixM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tg1wZzPdzOQa6koWgz27yvj8bAp90UwuDDGx7ZhofUqkn1VvwfylULZd8mG/4KGXhk35rzVvBA+dMtIeGiK0UMC1YotJdNRVLPHYHYGrCDCayWrIPWxz4Ksc7TyXYNoP+2WI8L0I3EdeU4C+TmthsUZcFKEbopi7EV7vFIUl32s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=ehxxPX1x; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240731201844138e103767bcf1f91d
        for <linux-kernel@vger.kernel.org>;
        Wed, 31 Jul 2024 22:18:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=SUxmYkjU52Zd0l8Y+msbh0zC3Tc3jd+DyqARUfWiOQo=;
 b=ehxxPX1xzA9T8723XVnod+NinDAChb6AKCoh/gobgoervllzp78zfY4sy620NTZorpjUSj
 CwlLIyzkh7mcqpZj2KLEnv1mrpPjTRK9NaOgRfxrP/KGKfr79gshk7+/QxiQqWyfY9qWsKmH
 ZoUtIVrshF+04vzSSXPTCkA3GH+kKUoNcy0Yrqh+/3PFuSW6+aHAoQE7JTh9FJ1kHRitjSyz
 mhU7vRNeNEYg1n0A+sBw0Ov1Abxe78WvlS4NCCzV1p0OdGwbPhK0G4VNUXzkJpEWCiwfuIQU
 1G/+n/vTjP8qPaj91iA9Awuim7xbu1hnx84bGW9eXTDnUNNyM6yAoweA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Minda Chen <minda.chen@starfivetech.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 2/3] riscv: dts: starfive: jh7110: Add sys-syscon property to usbphy0
Date: Wed, 31 Jul 2024 22:18:42 +0200
Message-ID: <b785c849ebae7040c83a2d0c097064e5a451480a.1722457123.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1722457123.git.jan.kiszka@siemens.com>
References: <cover.1722457123.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Allows the PHY to connect to its USB controller.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 0d8339357bad..0c0b66a69065 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -606,6 +606,7 @@ usbphy0: phy@10200000 {
 				 <&stgcrg JH7110_STGCLK_USB0_APP_125>;
 			clock-names = "125m", "app_125m";
 			#phy-cells = <0>;
+			starfive,sys-syscon = <&sys_syscon 0x18>;
 		};
 
 		pciephy0: phy@10210000 {
-- 
2.43.0


