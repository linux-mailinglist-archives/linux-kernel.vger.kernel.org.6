Return-Path: <linux-kernel+bounces-295367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0330959A21
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557C41F21753
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA271B5ED3;
	Wed, 21 Aug 2024 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="MqXjlRaG"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4611B3B20;
	Wed, 21 Aug 2024 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237996; cv=none; b=Z0O4AxF//D401PxTcnVxd8NScstnmHxVEnYzYRD/YJENB0NltvQu76hLyUB/Zxboq2SAAvQ0bUIOEgjzFqSFPg92tudCwmY/RRvbGnvSuB9C/sJzb7j284P7izkqTQWT9FZCnldpPeUFUjKBdovLVIPieLaAtNkgFEfVmFAYstE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237996; c=relaxed/simple;
	bh=lOVznm8znpiD9wHxT5WSSLClhJbN3kr6RCRdHWLy3eA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hC4WyTkVOZegwtx+zr0yjt1fMbiYi9eiq51eUv5aowAddmIrIkALmDlrEWShwNXLa8uYaeFa1CT6vmC9cU1J+pv5noJG75OyPDKC/pKBDkWzfWvKxacmMUjECFp1FMH7Bhv+lDCSt8K2oRqjZ2GaNg5ierG3y7F/ymHhnzwC4Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=MqXjlRaG; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 334771483DF3;
	Wed, 21 Aug 2024 12:59:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724237992; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=vc+ZNqDqtDjunBZp8r2rWXp9yJg3iRJrNVvLS3A0AHU=;
	b=MqXjlRaGpeliknT7/fXfpDP3ZLqCTYlPXXl618rXz38QxZTqKCZoV53B5btH7ZNTIrVBXE
	kwGwoyEpE4GWjvIuiEEx+BxV+VkZzrKz3JDN87ees/0qIfaLWWnEjpMR+/I8b+5RKpkO3V
	NNJVhQVkdBWi72PEIOxvKm+pJuh6a8B/OGzG3LyZS3TL/o/Pjch7rFzIYryGDT++6dU/YG
	OZ8o3epf/A0u3cDEgPKAXbWmMcY1EhI5KwoKOznoiQ9LtkunCpOEzmrIqiSuxc9uPogmsj
	AHQAHwptUiIdiO8g1xfY/FZ50KDxBt/ORWrZbDwk5KJsu8l/f8s50Rk29WYHGA==
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Christian Melki <christian.melki@t2data.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:MICROCHIP OTPC DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 03/12] dt-bindings: nvmem: microchip-otpc: Add compatible for SAM9X60
Date: Wed, 21 Aug 2024 12:59:34 +0200
Message-Id: <20240821105943.230281-4-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821105943.230281-1-ada@thorsis.com>
References: <20240821105943.230281-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The SAM9X60 SoC family has a similar OTPC to the SAMA7G5 family.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 .../devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
index cc25f2927682..d98b6711bdfd 100644
--- a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
+++ b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
@@ -21,6 +21,7 @@ allOf:
 properties:
   compatible:
     items:
+      - const: microchip,sam9x60-otpc
       - const: microchip,sama7g5-otpc
       - const: syscon
 
-- 
2.39.2


