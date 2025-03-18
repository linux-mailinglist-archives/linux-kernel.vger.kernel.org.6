Return-Path: <linux-kernel+bounces-565242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F18AA66452
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F47176C87
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DFC148857;
	Tue, 18 Mar 2025 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="uQZWWx1p"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0010E17E0;
	Tue, 18 Mar 2025 00:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259423; cv=none; b=ZIwKCEbNNYJKSnq45rgsPPXQLQz9Uy6h9htouhCOQlUDljsO07qAJ0bmfW/OyGjX92Cw/1+v4V3uAHn0zUFFC5v2b2gt5aa+HONTX9r4GgHW1wjYAiFlo/oM8m6bqDhpxO8o43N+Be5RClFifB9IiS1Cr/P78XHk1ojdHtE5IME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259423; c=relaxed/simple;
	bh=i0irJbDBaSvOqTfybaeN06ycrOgXP+5Y/61IZOn+DsU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YgEgVfbBjWOneDpOJDjjLN7A5s/DPN1eF0oHvIWUyVUFeIjR/a4Zk9wPzXMAy7i+NzcaiQA4WiJ9Apd1LbEMo3qoYVxsxc85IZHuE6luduaGg35gSccOhXGCNABYpgzbUaJ18YG2d0Gyyj98+0JKqVZ6jI6XKRaTjp+eswrOn5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=uQZWWx1p; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1742259416;
	bh=JaGRpm1aLDFi5cSsPwC/6+r43Mz4MyQHGYZWjy2AUww=; l=1014;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=uQZWWx1pVWT6oQ7x6arWLTncqZeO+IcJEXaZ8eZUhIGz/KFw2TK5KVCPUm+aMxmDG
	 nFFIlfLyiNZwIaK7Ey4/rkSU07siDUTwv5nvHQQgMikckqafncWVMCs6VWehDkGiXk
	 NqxAHyOjFfzvq+oXk38UTFnDkzTbROX8kKXOW776Jz9FfkSp1xxAYiiBQ8gbejqLO7
	 ENVPDGpduGtvRrKMrqZIofYcV/nBT+6o8v7q4EK8hZpSWExbDhjkQNgKmfrbdiwJ5V
	 Yr43aAh+YFbmIBlLuAI/AYb7kbw0FUdD3zleEnP+sBe/F+WKm19pPQoZqwJ3MRxaFq
	 pcY2Pop49LqsQ==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3810272:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 18 Mar 2025 08:56:47 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 18 Mar
 2025 08:56:47 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 18 Mar 2025 08:56:47 +0800
From: <cy_huang@richtek.com>
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, ChiYuan Huang <cy_huang@richtek.com>,
	Otto Lin <otto_lin@richtek.com>, Allen Lin <allen_lin@richtek.com>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: dt-bindings: maxim,max98357a: Add compatible with richtek,rt9123
Date: Tue, 18 Mar 2025 08:57:51 +0800
Message-ID: <1884c3ce2d901ead5d742958889f5a742e168376.1742259040.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

The hardware control and specification of 'richtek,rt9123' are similar
with max98357 or max98360. It's no need to add the new source code. So
make it compatible with one of them.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../devicetree/bindings/sound/maxim,max98357a.yaml    | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/maxim,max98357a.yaml b/Documentation/devicetree/bindings/sound/maxim,max98357a.yaml
index 83ba8666fbb4..5dc7e60b67d6 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max98357a.yaml
+++ b/Documentation/devicetree/bindings/sound/maxim,max98357a.yaml
@@ -18,9 +18,14 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - maxim,max98357a
-      - maxim,max98360a
+    oneOf:
+      - enum:
+          - maxim,max98357a
+          - maxim,max98360a
+      - items:
+          - enum:
+              - richtek,rt9123
+          - const: maxim,max98360a
 
   '#sound-dai-cells':
     const: 0
-- 
2.34.1


