Return-Path: <linux-kernel+bounces-222416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE90591012B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854B91F22D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ABE1AB367;
	Thu, 20 Jun 2024 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gV/5gmma"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E21AAE25;
	Thu, 20 Jun 2024 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878091; cv=none; b=NCesdGA0qAfGawYZhhpJoEz7/tTdsnovoD9ilQsFaCzPn6JKNNVh36mLT8+yOrWDO9IE/kuvFiPnv4BN8oHVBvzS2yMvhYqGn7q9nVZAPuqDVOQ+4hs2oTcPr9RSRE73ILZR87GQGsalvuD6dpUYtjxcFELUDmn2KsO18QQR0II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878091; c=relaxed/simple;
	bh=Qj/kipAraX9/0CVC2c8sN/n2d+6ockxINPF5uDszWlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5SdEte+4JJlTyVjkZe48KwnhoIVaFIp4o888GcXmmhEf+0J+oG8arkz+yCAfFQQ/D7xSDRel4KzJ/It5ThaSyUYTBgGZA9jTzt3vzQIibvcdhHY+cqYjCW7Dmr+BSKW/x4uwjQ7ByMzft8TgP6C6PB/GO/esaonb/hoWISiyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gV/5gmma; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718878088;
	bh=Qj/kipAraX9/0CVC2c8sN/n2d+6ockxINPF5uDszWlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gV/5gmma6Co/G7DtA+fQ1jljPvTh6b/RlAEPYpuQRpZCQoXDdG3ggbCBD5hW7IpTB
	 srLuDy2qRmJxHsX98n93oQbeWHPplZyDqmJogTIy4BPM6tv8SGzS1KJ3PASqTrFUXA
	 d5eRRAhY3WR2vVciJds3aAMJWdTlRALiiWBis1tEZYxj52YMBmDqoeBucWWwM8Xs2p
	 7Xoh92coDKYrurL2X7vFP5utWUmXwP3RNTvJqLijIpQpMZLlgKeHb2i1etvF1yFWV9
	 4jE6ndyo6ejBCk95jHM1JP9Sryz0lpzlq/ou7AQChASzcDn8Gf9Fe8JnosxPTqmYuZ
	 zo7kmVZA4O8Pw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 17FCF37821B9;
	Thu, 20 Jun 2024 10:08:08 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jassisinghbrar@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	houlong.wei@mediatek.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 4/4] dt-bindings: mailbox: mediatek,gce-mailbox: Stop requiring clock-names
Date: Thu, 20 Jun 2024 12:07:50 +0200
Message-ID: <20240620100750.1075790-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620100750.1075790-1-angelogioacchino.delregno@collabora.com>
References: <20240620100750.1075790-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On all MediaTek SoCs, each GCE Mailbox have got only one single
clock, and this is true in both SoCs with a single mailbox and
ones with multiple mailboxes.

Stop requiring clock-names on all GCEs, as there is and there
will always be only one CMDQ clock per HW instance.

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
2.45.2


