Return-Path: <linux-kernel+bounces-390506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401779B7AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048E7285FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3493A19EED6;
	Thu, 31 Oct 2024 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="LQ68MGVI"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C96119C562;
	Thu, 31 Oct 2024 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378197; cv=none; b=mHN5/I/ruQsiOa7U9aCqDG7Qg+0Hf/mGBB5kxxinROESKlfk3sau25zKMv0cOxl3oBpk3+UniAVf73JwY8QV7DVw1tHIxogSxewZIOF+aouoqB4biSXvYSu3GLoQiWVWWA/eVLWK9yFhgyspWUKmonOsRdyAfYxtzcHibDqsRng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378197; c=relaxed/simple;
	bh=3UkeRzv8tuyM480RNYtsP4upZlJ+1C00o1KTqGMdwCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcCuMyEiWUUunmBNtjBjCzkCknktSy1jjhMve8kh5vfIb8vwUt37zXZxjkA73fEvEATsPurpeVjPyOphzg3DDvUp3ftkgkWX5Boze23giwt1sWASwkerESFQKhPUeT8nqPT8aYOzj5OGiPBXusvt+azW1RCpNK8n/fUQfPAVOnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=LQ68MGVI; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id A810FA10C1;
	Thu, 31 Oct 2024 13:36:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=6BVVyLjJdR6me74k/F+O
	t1blbg2/epRtk+d2HKjKdKo=; b=LQ68MGVIC86SMlJjtvg5Jee/xNZrERR5EiYQ
	3NT0ILBjt4JY89V3DYQD3RjZhrBhNOheZlrFBtOnK9sHYWyfwM60lA3GuJ376jUZ
	/JGKbIjU3GEaYwZ3v+lzfEBHTVvFZ3htqepE75CiVMROfg+v/TxgLRrdiE14mZ00
	MuPtu6uuJMu8f34Ec5D4vAuR6utaO/GXARNnThKmZNbKPjJF64ElUwBJhD1m19Zk
	mDs7tkjD0zaKi3/NRsxIcbYKPxC8kjfytyO6dyqaPnKKLcWEFdUTU+U0BlnO1h/G
	r1XMBHBReC/ld+IQEh7gSJELcT39Wr2MOqkftotQcDa0E3aNNVvrUbiCyyS9GJ4d
	/AaEP6wy6u61kzKIIQ4eJrjlyrx6beH+cb6afvbBoTQtOXBipHoZ/8W/BcyczzQV
	hicB2vGhnAQjuf1K2SmZ/eeG5lNmNrKlmGWynUqBOdz0gvFqqzsqOAFEAB7geALE
	3r8NzkPhbjqnJzI17aCeY80HSYF6Tm6WDIcFY4E8r5xlS5MxpJeLr6NkkRWv2rPU
	N0gNVz0KpscDu2D6hgQ0JZssOeW/87fCMA1JlYoCu4B+3p2rcFQLhdghjEQiicEa
	TXKEtvWSEv5Iw4wD0X4h3REHN8nUx7kqHb309oIwnzPThk262BZjaTDo9NooSpyh
	7hFTojk=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Liam
 Girdwood" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, "Samuel
 Holland" <samuel@sholland.org>
Subject: [PATCH v4 07/10] dt-bindings: sound: Add Allwinner suniv F1C100s Audio Codec
Date: Thu, 31 Oct 2024 13:35:33 +0100
Message-ID: <20241031123538.2582675-7-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031123538.2582675-1-csokas.bence@prolan.hu>
References: <20241031123538.2582675-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730378193;VERSION=7979;MC=1610445493;ID=207187;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667667

Add compatible string for Allwinner suniv F1C100s audio codec.

[ csokas.bence: Reimplement Mesih Kilinc's binding in YAML ]
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 .../sound/allwinner,sun4i-a10-codec.yaml      | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-codec.yaml
index 78273647f766..16f4f7a40d9d 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-codec.yaml
@@ -22,6 +22,7 @@ properties:
       - allwinner,sun8i-a23-codec
       - allwinner,sun8i-h3-codec
       - allwinner,sun8i-v3s-codec
+      - allwinner,suniv-f1c100s-codec
 
   reg:
     maxItems: 1
@@ -70,6 +71,7 @@ properties:
         - MIC1
         - MIC2
         - MIC3
+        - MIC
 
         # Microphone Biases from the SoC
         - HBIAS
@@ -80,6 +82,8 @@ properties:
         - Headset Mic
         - Line In
         - Line Out
+        - Right FM In
+        - Left FM In
         - Mic
         - Speaker
 
@@ -229,6 +233,33 @@ allOf:
               - Mic
               - Speaker
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - allwinner,suniv-f1c100s-codec
+
+    then:
+      properties:
+        allwinner,audio-routing:
+          items:
+            enum:
+              - HP
+              - HPCOM
+              - LINEIN
+              - LINEOUT
+              - MIC
+              - HBIAS
+              - MBIAS
+              - Headphone
+              - Headset Mic
+              - Line In
+              - Line Out
+              - Right FM In
+              - Left FM In
+              - Mic
+              - Speaker
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1



