Return-Path: <linux-kernel+bounces-204043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B142E8FE34D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F4B287EC6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C722A178398;
	Thu,  6 Jun 2024 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRvbFSbG"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9AC178383;
	Thu,  6 Jun 2024 09:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667121; cv=none; b=jvW+EHxoxv/tkOANPsxCaPTO5t9AcvuaIpCT1mXy3M8SZn7RmkCA9koAWbVuJc3Ww6qq+DuzHIkE9mw724P1j9hq/l9ILNkuKqm3KAiHBicKQ3KGjxfLmSrPJ7tCf7xwsambxWqGRa19ziwYB/V2PonGjw2PEnZJRDZ13nIwJ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667121; c=relaxed/simple;
	bh=zwS8aRpk2PjtiWNBIc6j/DUCkzUhH6Dfqs4PqpkLx5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WFLQQpnkyp2unWd6ggDdlKiuxy0z0ZX/VNsOHG13mJ3vjJwKtQrlez64pUuOKDKL+W7LEDu61wRN8gH7UnIZycaRX7fTZT5PQ287ZTGSe6E/W3lqoWwaiWbv44fE38x2NCTBahdPJrmI1nCy0UTxWTMxkH2YG+8rm/VIc350jgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRvbFSbG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35e5c6600f0so623654f8f.3;
        Thu, 06 Jun 2024 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717667118; x=1718271918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZB61FsXEvdeTva0wKHZGI63+eRsL4trnKbQfk9L9rtI=;
        b=WRvbFSbGMnAPOwvWMxOubyYk+dHSJHyBOEEJIVPsOm35JKm8irIu5mySnEmuo0JLKK
         WSMxOH1f/zQmzRnJFNzGFkLjaZL64XHQkgRCB+Ap65LCtA3jS8dsoXgQfqp54YtfnpcY
         BfjUnt8NPhVo9Auoca5ochLiuINOH8y61awvgW6VxJzw8mRfTu32bHt1QAfhBh+lM9eN
         s3xN6toV3cB4D31rYBSB+32hKUdOiioeBRc8M9phtv3sSZhB+EG8d1bKX35mgsT+bYle
         0S/dZ+LzUBqYs2BS/GRzZKE3oXnWC9+0q0r8ogJuQFkxaFmkgp9/BOf7rb9J/O0u/hYj
         xU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717667118; x=1718271918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZB61FsXEvdeTva0wKHZGI63+eRsL4trnKbQfk9L9rtI=;
        b=auQcOWNR2nxXTZwBYFNxzNIScanRkAfL8k4DARtu8H58GFosDZTDornv5H7zx0/x/x
         JSyKhtROxMVK5IGg84RAb8qDA3WC0fRNV0oZ+nsRWCxpT5HKesBoc8WxDB98cRV54oGo
         0/WgRR6TtH5YkPslc09wf32ucYNMURoY5urk+RSOI9BxPdtfvex+oKeBfXlo1EX7/6kb
         e91Nsm1wYIRvmjhe6tAUC8g9/4EVtTiaQZiuHzg9t+Gpz5hVPKoRcjMxD27T+dbCpPDh
         1dTL84N2gJgluTHXWf102i29uwMC2dHzlEgnhcfyIWHz3PaCtu/uWx+lrfdh/xDKuMwF
         +GBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVVXkCPMJgqEZ/keo097qX98neLE3d7Xvwp0nAx2VgrxudOZwqpFgipTegPt4iR/WrCDiZaW01YpjQd4y2q5dLU3/oS/U8cUZRYXUpvFxgtSBMOpGC24FZUMTNiY4U6PnjVWS/C5txIw==
X-Gm-Message-State: AOJu0YykzESwPa87Bx2j/Gmv96xRGsRf1vL4Z8B6jLWDNDoSl/lbT3gM
	oalSukSON/BAi6Z2uskdqe1ExmkEhZRyDbEJOyLSL8YDroSnMPUg
X-Google-Smtp-Source: AGHT+IEYqlkNtr2dIqwmiztFMsgFnSBixadRM5Vl8vwGezMTvxuiQnVcKhqjqfys2YOKPQVjWIxxIQ==
X-Received: by 2002:a05:6000:1749:b0:355:52a:eb37 with SMTP id ffacd0b85a97d-35e8ef861bcmr3676931f8f.67.1717667117732;
        Thu, 06 Jun 2024 02:45:17 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d47930sm1094817f8f.29.2024.06.06.02.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:45:17 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/3] dt-bindings: add dream vendor prefix
Date: Thu,  6 Jun 2024 09:45:11 +0000
Message-Id: <20240606094513.3949323-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a vendor prefix for Dream Property GmbH

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fbf47f0bacf1..a6cb1eb8e5e0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -394,6 +394,8 @@ patternProperties:
     description: DPTechnics
   "^dragino,.*":
     description: Dragino Technology Co., Limited
+  "^dream,.*":
+    description: Dream Property GmbH
   "^ds,.*":
     description: DaSheng, Inc.
   "^dserve,.*":
-- 
2.34.1


