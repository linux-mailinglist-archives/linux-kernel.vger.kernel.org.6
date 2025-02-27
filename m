Return-Path: <linux-kernel+bounces-535663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EC1A475B5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C5A188CA96
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0F321B9E8;
	Thu, 27 Feb 2025 06:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDdgiBS/"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E858218585;
	Thu, 27 Feb 2025 06:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740636109; cv=none; b=gke33x5ImaC7h6f8hKrAMpUYJ6nJe0Bq86APEcqQvT9xvDGvERhL9Z6FGMTTdDQtkHZ3DcSA4d1fd5hsAZFA8EJxxFCFgiV1wtSJywGRv3qgb6NtZprNLWbMHyz2WgvAAbGR2Jszw7NKCJUAMh5UQVWmduxW2csQ6H+4dCcx+kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740636109; c=relaxed/simple;
	bh=KC3evV8+E4TMmXJsaHaV+xF+Zlwo3/sRwLFbnpUYLeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JhnHjesza3A4tslV+Xy4gEYDs8W/TsaD59hgue7a2IwV+eV4LidNHpuzqgM08OcJ7pFC2wWEz+KsVGhmgGd5XTMw5Fo5maa3UiH3QGn+8CS6yx5tP96BPASmabXl3RtDYqC3YqK0Y4vy3Ji7RETmWDCE0EoI7aNE58WiJ+sLh7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDdgiBS/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2211cd4463cso8939635ad.2;
        Wed, 26 Feb 2025 22:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740636107; x=1741240907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbBWp8Gpp+tRkxfYN3BsRLi83MVsRiY+awmccSWrlIQ=;
        b=CDdgiBS/cL9CmxQjLsLkgzWqTPVyjzN0JstO48/s+SePScZ4j74azHug6Akt36fOHO
         5ZmhfuzMSqdXHK6eNJBQyC6HitBWPzMTAiIIGCkh6mriyRQ3dcVI4QavWJaVygnNRPtz
         OriVInGj/ChJRAPykVycSqxmi4uzVQqDy7FRmwB0IWYgPuDcSP7AfGBCe6fmvVlbgOG4
         Zrxg/Ur5k7qp2yG2z6Rjfv11UphnLmnfQcpL8sYMOWHWH2SZjYyXi1SEmGJPWqQEg/8A
         3ou78KP6LHEYKJEcfFFMhWNViuTONj+CWYhGSewZdILK3ttBcY7PZAoJrgcu4FmNV/jM
         8ElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740636107; x=1741240907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbBWp8Gpp+tRkxfYN3BsRLi83MVsRiY+awmccSWrlIQ=;
        b=EL13EptH5iLaPTtXhDs0leqnxE3by/w/Bx1KEhyzsQVQ+XkgBtJFd476auz7/4nW9y
         p75URjTayuacWLQUa2S5jipFBCkbn7F3DLU4lgn9ewhP31Ks3Adi3elND7ygATwdQp+6
         AuPFKPr4EjetR/7nS2eV6frJkT9hBMbbcK4E8UNAHsBCVWSAjcYA2AVo7WocT2RSAMir
         4olECmQhKDHGzU/fuS9y6mm10k/jZtQXoKSHzkjzAWNPjwO4jaQ05NJUhSCB47VJ85By
         ZpM6BiVGblSKzvG6APPpkDEnkinMaye4yziPg/5/BLcpV8kYJBCCDBLun2DuIA6ha71I
         UXQA==
X-Forwarded-Encrypted: i=1; AJvYcCWLZJ4pCU2FyVoFTbIHFXnW3Gxi+1I7vmI/GiHFSb38UAkLILp9QRz5cCDc6EV8FClWosdgmdJEOCiv@vger.kernel.org
X-Gm-Message-State: AOJu0YzMPdcnX5I6AlZobI/lhmS2v7fqZWidHAcN2QYc3rSy098V27z9
	dDTRnxrtp8+AyX0fGFlQku402F4rQSeTxg3//9urUJxFDzgpS6C+
X-Gm-Gg: ASbGncs32ft/GBrMrFDFdfUxJ635z2keG5Sc/XC87zimekxdohx8iztZCO8e8W29o20
	gEoZnFj3K2O5YRWvP/WTvAryaenlzo++86we22YPbXbhyC8i1YLDBrBbzarJJCuCZoz1KiShGNs
	pWJ0q3g7KBSFccvizu3xstxx6YIh798wqKp1JrUCzSJFmiZ+5PHvUX54fKokqqm5rFR5qdGlTi6
	AcX8E1s30EwNc/sQRFAk0mjUldSJiGqeOzwiwHiWQlTuKKoA/kIBhS4Yyw05WClLsho9lujU8TB
	AoRauDgLbmaR2ouCml9vAkSTTZTvtSSscp9m
X-Google-Smtp-Source: AGHT+IFUBTM3E9ZUTYM/b7On4JzvSLZbPDNefBic4lp+FqFMQP4Iebm5RLt6/QZBY9X9G7Gd7D0Cdw==
X-Received: by 2002:a17:902:d4cc:b0:215:a04a:89d5 with SMTP id d9443c01a7336-22307b33034mr151602275ad.2.1740636107465;
        Wed, 26 Feb 2025 22:01:47 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:cd02:bc36:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe824b67a1sm2728177a91.0.2025.02.26.22.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 22:01:47 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/5] dt-bindings: i3c: silvaco: Add npcm845 compatible string
Date: Thu, 27 Feb 2025 14:01:27 +0800
Message-Id: <20250227060131.2206860-2-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227060131.2206860-1-yschu@nuvoton.com>
References: <20250227060131.2206860-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

Nuvoton npcm845 SoC uses the same Silvico IP but an older version.
Need to add a new compatible string to distinguish between different
hardware versions.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
index c56ff77677f1..4fbdcdac0aee 100644
--- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: silvaco,i3c-master-v1
+    enum:
+      - nuvoton,npcm845-i3c
+      - silvaco,i3c-master-v1
 
   reg:
     maxItems: 1
-- 
2.34.1


