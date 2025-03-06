Return-Path: <linux-kernel+bounces-548377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC592A54404
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032BA16C4AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BBE1F4185;
	Thu,  6 Mar 2025 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="go+JhxrR"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513B61DC9AC;
	Thu,  6 Mar 2025 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247681; cv=none; b=rRAAjDUSa5oHr7Dmq5RK9MzRn6pjpYL15MHQ2kyuRWQYTBf+RHHp+qR7BJ4qa7xORxZ0Yn3lqAO3eNuyWcOF41Q6948OkYyYHQeOQwtvqVErfmHIKRkLrzSdzkfXdzcfO0fsbTXAMvA2Sm5AmUAKS5f6T02256nEqmo/KnERb2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247681; c=relaxed/simple;
	bh=KC3evV8+E4TMmXJsaHaV+xF+Zlwo3/sRwLFbnpUYLeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ly8O6aDpEoVHRKoscY62tptgzByNArx+zJK2Om29iEj1WjpTA7ZpnOk3llw8/11Wc3rIuJAbQKKbxzxgd15qVByk69ps4gzzFjecAbe6jCNXCQwRYgKuhTdE6w79BHEx8BpN7ictuSXvsEMGzQhx2An9Ra/ux7aD3PSbet1oPNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=go+JhxrR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22356471820so4364015ad.0;
        Wed, 05 Mar 2025 23:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741247679; x=1741852479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbBWp8Gpp+tRkxfYN3BsRLi83MVsRiY+awmccSWrlIQ=;
        b=go+JhxrRUJSSfrZ/FwhTFvySsf4+mxsyT/o1VHK/EcJ1MOrZBPjqwSAI7MABc88IY2
         TE4HUW7T+UM9BQOb3SCg7uqFkpgJS3namxTtSVZprDEF5TZooHjqVu7ncNKKQYBjy2jk
         8Xf51w69UaB9lxgUiqfu+JNkn4UpeZT5Hh0Mz5MProhHlhNv7srmGpCzrV8eF6s6Qudk
         BEoLXWIje89jGbFLOzLRY/geO81jEAElup0PmPxGo2y14+0kctcmq2AJM4QOmV7XhGrq
         IvZwWeqt0QzZbcXCFaVGv1TeKcqGy+jxJfAbpqhQUPx3F/kkBPQnyUEYvWqjgWesNtP5
         NXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741247679; x=1741852479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbBWp8Gpp+tRkxfYN3BsRLi83MVsRiY+awmccSWrlIQ=;
        b=qZbGuD3O94SsApI9oKWsv6X17qM4R9xEHKQuB4PXOEVuAghUE93R7tMBmEH1vZNQO0
         9GyiDoN+NDYpltO3KYMvQxT+CXkg1lQwCHVqTd/Gpu9hQRTzj9rX3CZMfFFhpg9WD5kf
         nVz32cpsTgg7Ej9jEAH5T98AkMmkuNaronw8f3bJvz/zhjlsfh0aZHHcCeFFcXEyP2Rh
         zcYp6yFROLmZ+v7hZvQ8IBQdLpRoAxqVQnWsjQY9il7b/xYSuHAlHkTTJZih33RCi/jb
         vepklqsrmbHKZaDC8athUbb28LZSvN0fvhMy6n8PmnD7VTXxBZHQMgO7TF46LG/D2LcR
         +0lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUHS0aqbDr5U7JfyqIIv354Ie/2bZBOKEMJk4UucuowXws+eOy/EtaCc1xooVGUIW4rJdA+JNzMEct@vger.kernel.org
X-Gm-Message-State: AOJu0YxzW4BRstwQb4M54walSwRfYmxe2UBy7P66NZ1+AXofAHiQIg5M
	DO3YbCD4VoQK+15FEjsjGkIrGK+fdZCK/O6XZecHIx4ATQPT0jg/
X-Gm-Gg: ASbGnctSriaSPmSeFkl3o8XGSqCY/ZfRZDtAgUUL6SihOhH46T+FFpAAxaFww7B4dfL
	zTL2shBGRW8WpsxZVYm8NTIWnMUCiE9/Lo4Pkbs7zYziMqQPnnD/fuRxhhb6Z4+ZaBLcgQh/Ken
	1POs7JFBVl2g4bJIKQvHVZKEzH3BKu737bwFMlUP6bACsB3jCA/aQY+VZGH8W0ynvdmB9l8d49S
	p3Jxy2Euu3llX/dxTyeEi1oog6MfLsjBL0cHWxg0quwW0CiZwz/Z7vn9bI5P2+bB5VtEzaiN4VK
	uTk/Vx0CI1cyBlWjtI8vnpsT/fnBig3lVgiFFdTdUMj1mBQ51tD6p30=
X-Google-Smtp-Source: AGHT+IFlRA1ASdPJHVciwnsTAixFnm9+f7L02Rxbp3y0Ul030LzW40hSSZUseZYzvsv3j9+MbuLuQA==
X-Received: by 2002:a17:903:230a:b0:220:ca39:d453 with SMTP id d9443c01a7336-223f1c81e80mr96320715ad.17.1741247679382;
        Wed, 05 Mar 2025 23:54:39 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:d305:9d26:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa448dsm6085485ad.210.2025.03.05.23.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 23:54:38 -0800 (PST)
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
	yschu@nuvoton.com
Subject: [PATCH v7 1/5] dt-bindings: i3c: silvaco: Add npcm845 compatible string
Date: Thu,  6 Mar 2025 15:54:25 +0800
Message-Id: <20250306075429.2265183-2-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306075429.2265183-1-yschu@nuvoton.com>
References: <20250306075429.2265183-1-yschu@nuvoton.com>
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


