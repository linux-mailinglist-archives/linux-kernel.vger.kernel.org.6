Return-Path: <linux-kernel+bounces-368357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713DD9A0EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D70BFB25351
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A94820F5C6;
	Wed, 16 Oct 2024 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mentallysanemainliners.org header.i=@mentallysanemainliners.org header.b="YHvydFZZ"
Received: from out-03.smtp.spacemail.com (out-03.smtp.spacemail.com [63.250.43.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48011209F3E;
	Wed, 16 Oct 2024 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093695; cv=none; b=ral+yZjpCXTB3bE8yiHG/VAQWzsgLjK8QMY9L4zsxbZpqbyGbq/0DiUyX/D6+/S74BNLARgSkwtrIVPO88+tQ4WeCFXgtE/rN+dD5818fRNsucTTFps7Vwi4QLOZCgtaV6VjKK0NubYIp9LR1rqfzY0KADA3+KCmTU4yvIi+M3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093695; c=relaxed/simple;
	bh=S3U+b3hTaCTPOPTp+geqZoOfUjqW4wpwzav1nDtIva8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gt5ZeF6WUO/0HSczcEiERVYqlzM6qo+FORNTy22xSzc1aLWYtQ3hj1B6baKm3YLx3xGh/xpEmV1vMTLWmPOyinIqR5Z7nvZxTx1eJrM66m/TvQxqh/RsPuKFj5X/uT8Y/K0U2jN6Qf48lT2x0ooaXBOI/QCpdZsPw/sLFmTf1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=mentallysanemainliners.org header.i=@mentallysanemainliners.org header.b=YHvydFZZ; arc=none smtp.client-ip=63.250.43.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Received: from prod-lbout-phx.jellyfish.systems (unknown [198.177.122.3])
	by smtp.spacemail.com (Postfix) with ESMTPA id 4XTFjn1BdCzGpV2;
	Wed, 16 Oct 2024 15:48:13 +0000 (UTC)
Received: from igor-systemproductname.lan (83.8.245.91.ipv4.supernova.orange.pl [83.8.245.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4XTFjf05T7z8sWP;
	Wed, 16 Oct 2024 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=mentallysanemainliners.org; s=spacemail; t=1729093688;
	bh=S3U+b3hTaCTPOPTp+geqZoOfUjqW4wpwzav1nDtIva8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YHvydFZZ7mrHId9grQMhP5eNdlG+Phf+J7atxNdrW/hAhZxMpyKO5CR+/B1mp0cxm
	 iKHNp5zgsiglvcog23Wo8AI0Ew4E3HKtJyt30LGQrdINdivsNG1VLb/Ctxl2Jds5t4
	 GZxJuJZBzEcUKq8um+0Cg1KAsPz+2BwnJGkv7t6hdku191ETmhjdEy7/g5Aldf9yIj
	 as6r8dQiUo2R2F/urOUUQGK0KpxkDXPNdNkZFG9AEGDKMG76vut9yIy/T3GIn2t9R+
	 dbMopicBKM5d4MwfMd0/37BlenMA+xmUjJq8i3He4qnXYa8wkInjv6WRovvS0vbVZk
	 wAku75K5lHGYA==
From: Igor Belwon <igor.belwon@mentallysanemainliners.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Igor Belwon <igor.belwon@mentallysanemainliners.org>
Subject: [PATCH v3 1/6] dt-bindings: arm: cpus: Add Samsung Mongoose M5
Date: Wed, 16 Oct 2024 17:47:42 +0200
Message-ID: <20241016154747.64343-2-igor.belwon@mentallysanemainliners.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241016154747.64343-1-igor.belwon@mentallysanemainliners.org>
References: <20241016154747.64343-1-igor.belwon@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible for the Samsung Mongoose M5 cores, found in
the Exynos 990.

Signed-off-by: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index e41a8aec6066..c54d20dd9d7e 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -207,6 +207,7 @@ properties:
       - qcom,oryon
       - qcom,scorpion
       - samsung,mongoose-m2
+      - samsung,mongoose-m5
 
   enable-method:
     $ref: /schemas/types.yaml#/definitions/string
-- 
2.45.2


