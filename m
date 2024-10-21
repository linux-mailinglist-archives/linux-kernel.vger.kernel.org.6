Return-Path: <linux-kernel+bounces-374054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D09A6135
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3637DB28887
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7A91EABB6;
	Mon, 21 Oct 2024 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="K9jFrbt8"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6098C1E9072;
	Mon, 21 Oct 2024 10:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504984; cv=none; b=JNnELXstK1jcCzAGLyJ8vbEYXvPfWyttPdVdH+C1q/7prTl5fI9D4nHLOVQ9StP1O1ulwxqHYRjDq0pLbNWLi9rHR1lPSFGQ9AvqxNp1T4Mwxkv4eHUIeyI3VFFQp+N04uZAdDYnRlJeAYjQV2KtB20cmFu7BAtFBLOKfVIFZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504984; c=relaxed/simple;
	bh=AmhwSNepj18v/9BsyXl4q8BQhzGM+VQTPO0KStA/Clc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=udVwf1sdHB39QpQwwd/k+UZGRf6ahdoC7vIfVS9RhM7RqxFPF4WLiWazgq3aGf5zWd5F5rf24ixBDLqAqYrKCCzNui8sSM2n5U8jDwB+bOqL+D4C5Zc8zlC1zJuytBTbIe3GTdQZM4oa0q8WSsiH5n3QnE788duHNG/2/1a2RjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=K9jFrbt8; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 9214688E6B;
	Mon, 21 Oct 2024 12:02:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729504973;
	bh=2GHI9zvaCMNZNDAcNWlVDJe/x4Y4cP7miGsJUaBFGh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K9jFrbt8428rBt6pGEv1kM4yxTEHscFcytjAuRkO0kZszAbLj51OSij0RzTCiQhDQ
	 3u+cMwTwEXa3EaBymeEFeg5pE0ExjZWdW84zJX0OAe7+lwBXByjwvA0dkmnuvf47Zq
	 T5UaCdEEn6/eff/d2io9bxlFcommhY5mOsedby+0xMGWdsNLhyAVgKdThCc4QITCWL
	 +rIWYOKS8UqQA3DF21YyYFz4wrA9Hpw5WZ0HlsMomGpe5eShaDiAQnPEZ3SzR6dURb
	 +SEADT3DWM+JThE1GpT4Es7xEb7TA64SnoEclfpZx/721z5avtr5pxQxnuCJI3LW+Z
	 m+STDG4u3lppQ==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Lukasz Majewski <lukma@denx.de>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v9 3/4] dt-bindings: arm: Document the btt3 i.MX28 based board
Date: Mon, 21 Oct 2024 12:02:23 +0200
Message-Id: <20241021100224.116129-3-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241021100224.116129-1-lukma@denx.de>
References: <20241021100224.116129-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The imx287 based btt3 board is very similar to xea in terms of used SOM
module.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---
Changes for v8:
- None

Changes for v9:
- None
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 2a42f943330d..ce128377200a 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -97,6 +97,7 @@ properties:
               - i2se,duckbill
               - i2se,duckbill-2
               - karo,tx28                 # Ka-Ro electronics TX28 module
+              - lwn,imx28-btt3
               - lwn,imx28-xea
               - msr,m28cu3                # M28 SoM with custom base board
               - schulercontrol,imx28-sps1
-- 
2.39.5


