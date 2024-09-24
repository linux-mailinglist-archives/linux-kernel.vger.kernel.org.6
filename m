Return-Path: <linux-kernel+bounces-336993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A219843C9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFAF9B23BCE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC26119CC13;
	Tue, 24 Sep 2024 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="outZdxA7"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EA819C54E;
	Tue, 24 Sep 2024 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174412; cv=none; b=kHTBhzdrhZ7wz8CNm8GAQHenwEjmtE7jN+rja5/pwW1igD8UePlsbqFBsU4FTD4bVkK1cfnoZnACfs9ev/S3/676Y+f8lrh6EfROKIbuwn5VNGF9Ecd2VgjKmYVQYG6lHyKJnEh46WDLZmUv8kfslDR8bU+O0xXleHPsHCvfdjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174412; c=relaxed/simple;
	bh=cswY7xpnoJWre2QZGQ3bNQS8rMVmaVyyE1L27YU8iAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFI63p92OLG+dtT84oZxYzpSncXSLumL21kYnB8Xo91B/XBbHvi9uDj9Ld0qHUxMKCzBlrIOP5czpwIxyxJrSk89UDwzfwhCvl74Ae8b85+TuRnCyXxGWmPoaPqbf2fAkvLJR3amP/n5hpe8l24abdW6gQmBzfRKrBBevG/y/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=outZdxA7; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1727174402;
	bh=6E/r9vEalbrru4VLWcwb2At6l9m60gkehHfk7P/OQcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=outZdxA7SlCAclkkZYMWZjjzTSJOwbhXghKm3eYBFNYtx6QFPIqZVYCoKjSf/9fHo
	 pTIRpQK9qJ3S0RxG4VXq5Wm+E5hD7Fe+daYNm9r1VwwAOgQE6/uctFtv3b+qa2dqHB
	 ACYGzGe6TSj+a6f3P0GRFFz5iz6uN/aIGhxvVPKo=
Received: from vokac-nb.ysoft.local (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id EBD22A0522;
	Tue, 24 Sep 2024 12:40:01 +0200 (CEST)
From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Petr Benes <petr.benes@ysoft.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Michael Walle <mwalle@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] dt-bindings: arm: Add i.MX8MP IOTA2 Lumpy board
Date: Tue, 24 Sep 2024 12:39:40 +0200
Message-ID: <20240924103941.1729061-2-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240924103941.1729061-1-michal.vokac@ysoft.com>
References: <20240924103941.1729061-1-michal.vokac@ysoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add new board from the Y Soft IOTA family. This one is based on the i.MX8MP
SoC. It is basically a stripped-down clone of the EVK board with some minor
additions.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
v4:
- none
v3:
- none
v2:
- Added tag from Krzysztof.

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b39a7e031177..a3389f2d06e6 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1088,6 +1088,7 @@ properties:
               - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
               - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Modules without Wi-Fi / BT
               - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
+              - ysoft,imx8mp-iota2-lumpy  # Y Soft i.MX8MP IOTA2 Lumpy Board
           - const: fsl,imx8mp
 
       - description: Avnet (MSC Branded) Boards with SM2S i.MX8M Plus Modules
-- 
2.43.0


