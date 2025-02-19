Return-Path: <linux-kernel+bounces-521066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E10D1A3B381
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F2A1898E01
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96631DC9AD;
	Wed, 19 Feb 2025 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="K8NcYtzx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="CJ3Wviff"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297321C5F32;
	Wed, 19 Feb 2025 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953118; cv=none; b=uJgw7lw4fdxztMu4OeqhqS7U9BvAAlDMNLpjnQD9usB9Emsq8eyE7BAfghAHgB9+y8Hira0F7E4+Txq/IUbQRj5wCU2YH/XNqnPCuF4ElhVOyneC2boxvzgfx10GSdtSsm4L8+OdzGvZNoAstplvuHaml576FvssYCmlpTpcAZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953118; c=relaxed/simple;
	bh=pqCObTB0d6iXdWSzZwXqOx4nMVfxTJ4SKGt0D7Prxss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kthEaCQ1dSj0zJWgFly1GLpbnrvvCt0855AFQJCmT5E5mhPyR8YujoybHh4+t43/XEjnZ7Yv93FEMhKh6MIqj/X4RItiKU6IZIgAMcZNQ2TYKeNIteCXfgsCuqNRpgL9KJp1mHL8zo1v0rkxs5PsVJNp6VCBvLpmarhQIssKbKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=K8NcYtzx; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=CJ3Wviff reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1739953112; x=1771489112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HwSj9P7cDT8V91YvPThqayUco/hLI2W6VmhoMN33x4g=;
  b=K8NcYtzxyBtPOaVMMRealgt+9h6z9cdkW+/XTy2m50WDduEmk5yUJ600
   2eaxIONgV/WJIH7H0NXstPvOs8zVoPXi+WKRplRaWsaqKQCAQT0CnkUvs
   Aenl4hSx1FL7utlgyEawJJdynzlO0mGK/wWzxzUvqmx7zA2IoLzqvNPSo
   YiM23v7S5zvTcBbmbXGxiexUXtzN3FJlU+UBAdzjgbliFMDIpBNMqOvUr
   +4HFRudXNZP1QQMAdeCRWcpQxT6xa9OPmGxgpaMPYrpy/TQxJFfimjO1d
   V+v/lrBy32o2N9vmh/8bUlr7E/JVugV1cflLIrragZYNKRj5vCEIVmegs
   w==;
X-CSE-ConnectionGUID: u9wh4AVUSNKgRYHGd8qtoQ==
X-CSE-MsgGUID: p8R2SHBVQVWnVZ2D+Oa6tQ==
X-IronPort-AV: E=Sophos;i="6.13,298,1732575600"; 
   d="scan'208";a="41945151"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Feb 2025 09:18:30 +0100
X-CheckPoint: {67B593D6-1-B8541F8F-E50F9B0E}
X-MAIL-CPID: 254D9EE434293371C7B2BB799D6CDE2E_2
X-Control-Analysis: str=0001.0A002118.67B593D6.005F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 44D3B16D339;
	Wed, 19 Feb 2025 09:18:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1739953105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HwSj9P7cDT8V91YvPThqayUco/hLI2W6VmhoMN33x4g=;
	b=CJ3Wviff/oZvSgazQ7MBrBkZ9WyTdPq9Pe6hV7kJKuBTBzVLf8eJ53v6MiE/OfiuB0G2Ca
	k0FJxRGRN25klspCERIFR7oe6486I0qGoKhVkxN2qWQJy9LTe5Dg9KbCmQjyNL9TbLTcRJ
	5FQF90HcsIE77HiwZcCN3lQJ40OjMBv0Gi8Qo9Udt2p25KDFiUKUOk+PN3QkPE3d7DNCx6
	RAOMhn7lo0eHR/0KtKbsajSnnapabhkFXsyicYFraNsL1uG02psP3rbs4CF8R7V3TQ8u5D
	um2BczN6H6gvlDArAN+HORF2SeNS2Q+e2Gku8gXiuodax712Ntma9ECgVKosDA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] ARM: dts: imx6ul-tqma6ul: Add vcc-supply for spi-nor
Date: Wed, 19 Feb 2025 09:17:41 +0100
Message-ID: <20250219081748.1181507-7-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219081748.1181507-1-alexander.stein@ew.tq-group.com>
References: <20250219081748.1181507-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

(Q)SPI NOR flash is supplied by 1.8V. Add the corresponding supply.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
index d63229d8b4655..1e4022cba3cc5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tqma6ul-common.dtsi
@@ -169,6 +169,7 @@ flash0: flash@0 {
 		spi-max-frequency = <33000000>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <1>;
+		vcc-supply = <&reg_vldo4>;
 	};
 };
 
-- 
2.43.0


