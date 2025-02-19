Return-Path: <linux-kernel+bounces-521709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4AAA3C13D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04ADD189E570
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CDD1EDA1A;
	Wed, 19 Feb 2025 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hnIxpYxd"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB3D1C4A16;
	Wed, 19 Feb 2025 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973720; cv=none; b=Q5w2E6LBA5NpQjrlZujuXaP2fesyl5THfIdtPSl1GHs+SERM1mRsfH+/8Q7mV2eRiSFaOYwPgHWzAdxWJhlzKsiC8fa1WORQRKQSr7MCvJCBiQ/4n9FxjTXPDKwuBFitvhiwaU171SbbaEaU2AaRYuufjmobwdMp/bXnZMrzULM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973720; c=relaxed/simple;
	bh=yeXZeFGVgjsBj6qQwWrJOBipnnmsY4EJo+vkx+HpaF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=azkHGzlCJbnH6YimhvuW8YhSH7MSDkBMGGO9qwsMcXGoAV9EqPYyigZgSNwHNX/A6Nnq7K+Mb/PgvBW2hd5Rs1BS8BoENAKBy7HfYsZYR6NcsH265jKwoHqOfe+VQJjzthMduVSbQG99pcszi/3eI3fnCsEfN5DhJ/dhuHVwqoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hnIxpYxd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739973716;
	bh=yeXZeFGVgjsBj6qQwWrJOBipnnmsY4EJo+vkx+HpaF4=;
	h=From:To:Cc:Subject:Date:From;
	b=hnIxpYxdrLM5EIblIbgZ49/7DEdJSsdElvaz+7x93GMH8CYPVYGhtSw0QIgRjJelm
	 PH687C7tcelNZA/CD98xANjjmyPcrqwzl9uzV+d3SeO+ASCk/FK/yVZ5rk3oI0+e1c
	 4ZXxHtJkgUlDtqaTt+K38tyvs2ClEXZwEPwMJpOD6HhCTkaKLASilhzF+Lc6Aeeshj
	 vDCtNKyDZQacRx7Y61XeC6CptqUpCeHcPhiyIum/0O9sFR2KpaVsD90ns8kdlMwCwD
	 n4Oku4XUPwwW4iNkSmO3h/gU/iWc26AS0CFGPsMpKSI4SmbEK4Lh9o9J9/ImCpZmz9
	 pLRh6NZ5rUKqg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B091917E0860;
	Wed, 19 Feb 2025 15:01:55 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: gregkh@linuxfoundation.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	gene_chen@richtek.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	pablo.sun@mediatek.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] dt-bindings: usb: richtek,rt1711h: Add missing vbus power supply
Date: Wed, 19 Feb 2025 15:01:43 +0100
Message-ID: <20250219140143.104037-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RichTek RT1711H and RT1719 chips do have a vbus pin that is
used for attach/detach detection (respectively, pin A1 and 11):
allow a vbus-supply phandle for that.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml b/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
index 8da4d2ad1a91..ae611f7e57ca 100644
--- a/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
+++ b/Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
@@ -30,6 +30,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  vbus-supply:
+    description: VBUS power supply
+
   wakeup-source:
     type: boolean
 
-- 
2.48.1


