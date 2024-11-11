Return-Path: <linux-kernel+bounces-403463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB1E9C3612
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46B68B21FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10CC1591EA;
	Mon, 11 Nov 2024 01:31:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E395415852E;
	Mon, 11 Nov 2024 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288667; cv=none; b=nVeaY0jLyeNBNY2jy2lME5tKw9pd893eurczW6bUF3v3q1A/KpjpAbcd4/6nAwLPcldcUbJB9j181KoRIKm6HnamBaiLguY3iWkhxy9jLbK29GDSpnvMkQQuEeRPjZlkWz2RdlgB9PTZMQ4FJaXH5HgzazCGURwHGxP3LvTAeuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288667; c=relaxed/simple;
	bh=LZCOi285j7O4lbN4YKXUfdjxAXbA4mMOF4QR+DNejS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTKFhRVd33GDqcyofEEon/8IYplDjuVelELwZy6YagGSJuTYORIPZ2t0E+wYY7qy++aVwRTpq4lNdDYrEU6Sgg9TWYGCoO2CbKSQaHbuOqF8dLWXAanM6O4Dow9U8elae89X31Sql/lPWpaUtENDbVkwc6GUAK47HydvZZCl43w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 784711480;
	Sun, 10 Nov 2024 17:31:35 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E27B33F66E;
	Sun, 10 Nov 2024 17:31:03 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 10/14] dt-bindings: rtc: sun6i: Add Allwinner A523 support
Date: Mon, 11 Nov 2024 01:30:29 +0000
Message-ID: <20241111013033.22793-11-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241111013033.22793-1-andre.przywara@arm.com>
References: <20241111013033.22793-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RTC in the Allwinner A523 SoC is compatible to the D1 and R329, so
just add its name and use the R329 as a fallback.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml      | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
index 4531eec568a65..9df5cdb6f63f2 100644
--- a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
@@ -30,7 +30,9 @@ properties:
           - const: allwinner,sun50i-a64-rtc
           - const: allwinner,sun8i-h3-rtc
       - items:
-          - const: allwinner,sun20i-d1-rtc
+          - enum:
+              - allwinner,sun20i-d1-rtc
+              - allwinner,sun55i-a523-rtc
           - const: allwinner,sun50i-r329-rtc
 
   reg:
-- 
2.46.2


