Return-Path: <linux-kernel+bounces-324710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E516974FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15571C223B7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8184185B4C;
	Wed, 11 Sep 2024 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZHp+FWWU"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619B95FDA7;
	Wed, 11 Sep 2024 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051437; cv=none; b=P64ew6TsfKsdUns+yprV0TcQUJxQwYydoEQXrSkFPzdJ7opLhEVMZP0xDg8k1QN6icnxmlob0k+ccHP80wV7uTTorxG5cCZfiWiXLZJdILP5LrbQ/M0HKmN0nqOM7D4V+OxpsGv6EpJF6mXWUoSx1h/X4YMKfu1ByOqNZWfzD64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051437; c=relaxed/simple;
	bh=Ip66BIhkD3crNPgchKI/pt+cRMu/HakEdQjbpXQUZ/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QufGkmg6VBLm0zDQj5hqrjeRK7SQeRoVC+cyMfgYcERaor06TgfSvWk90yZsuzAEQFlC4n2MCOoqDRSaXXVZ86MKF+V0Nfi+gPcNWsL1yyhIgDJFdlTIKczr6KqcGt3FmwiQMaKRIt+vmpyl/aKuwaWH9hYHUD4TE0w8wmUZxJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZHp+FWWU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726051433;
	bh=Ip66BIhkD3crNPgchKI/pt+cRMu/HakEdQjbpXQUZ/A=;
	h=From:To:Cc:Subject:Date:From;
	b=ZHp+FWWUDz21rYHgDRSgDlX8UYELkBD2UVvP+Iwo4trP18oh7CMsNOMp+KCXOcDny
	 xOpFvRhvssH0ZLzc8hZjrqBddZXATvSF9SiAMGq/wFWyGsJ2rX7DPR0n17qt9G4lbv
	 R75g0mMwpHUgI9h7yCsiIDS4EW1QPKbzZyAZc7EXg4a7uJqR7+pFnHlW8K+dcEGflv
	 /lCDRuwpcwZmcch0b3UpZC/ErnVtPeuiLY4lZTLVY3Rlh7sfD329jr+BE36Uu04TFN
	 31tV8qDqdlsRuH1lycn0UfA5LZeBOLSh/ZIAJZGASsae+XmjMcqY+v7EGY1QHUG1lv
	 W4NrO3XjWLXlw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C05E917E105F;
	Wed, 11 Sep 2024 12:43:52 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: krzk+dt@kernel.org
Cc: jassisinghbrar@gmail.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	houlong.wei@mediatek.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	fshao@chromium.org
Subject: [PATCH] dt-bindings: mailbox: mediatek,gce-mailbox: Stop requiring clock-names
Date: Wed, 11 Sep 2024 12:43:27 +0200
Message-ID: <20240911104327.123602-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no reason to make specifying the clock-names property
mandatory, as the Global Command Engine HW needs only one clock.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/mailbox/mediatek,gce-mailbox.yaml        | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
index cef9d7601398..ff5d010fbcf0 100644
--- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
@@ -56,17 +56,6 @@ required:
   - interrupts
   - clocks
 
-allOf:
-  - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              const: mediatek,mt8195-gce
-    then:
-      required:
-        - clock-names
-
 additionalProperties: false
 
 examples:
-- 
2.46.0


