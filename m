Return-Path: <linux-kernel+bounces-349505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC04498F70C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B321C22588
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35351AC884;
	Thu,  3 Oct 2024 19:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lO9Qx4ph"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974531AC43D
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984039; cv=none; b=bXdODJsPPgkQzgoqUIFt0TnhmQc+r0ZDM6vgdhbt5iGN8Re3d52pGsPYLMfapvd3F442HMijlbCg/5993lKsbj3Paarr0GqRndHiHUe1QECL+h21jbJWXSLQXQ9V2xpFfptmPQpRC4S96qws+koe7ikCO2o2NMIaPu5YT7qJUEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984039; c=relaxed/simple;
	bh=kIbV8w9VACrw56EiOJHnI17zKPAzzsTMVzsAhN5J9BI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhCysvfHIzCTG2fe9DcPAyi/c7PPdFqZ7aibWM/mgWXlvM7Q2roVIaZShJSlZ3oHnxgT8wPsbnQ1amkrp/wX2Kyoga2DtL8eTuLI33WUoD8cjuv/ATr5HWO1SPGPdu7V/djlxDBxWGolVaWE/DxNAYppCTTk+RVKTFlzHbxjTXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lO9Qx4ph; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42e6dbc8c7dso2112805e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727984036; x=1728588836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=03Fv72OC4PmcFCeI8nt8n17s1/uuSrep9ca3zTiEkFs=;
        b=lO9Qx4phjYRxxvLHSCyriMnMwDV06TBJCLyqssuzuqYsD8NSldIADmouQeBtjAseyG
         FmhxSKgj//kmEFS83N/r+LDKRqjlsTjGTRTPkRKEtozX02RJ02yYG5K5XutT8cCsoZ57
         y3u4EkUO+TzHsnaOJ75KtrLlmp2rW6QrW6tIZgv9rqm4rhXlc9wzk+8hLP0a0jISTeA4
         z7PsMoMwxmH3GNojkRXEtqxdFKy+VLeLnUnjQ6E5ulzJ9xaXFZjgcgmd85r9snC2Vkuj
         s2cmZl945NulfbT/G3d6L8RAIcupJ4KNpAPKMNsxJMaxVT/7g9zNjEv63/7DYvWYYWj1
         HrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727984036; x=1728588836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03Fv72OC4PmcFCeI8nt8n17s1/uuSrep9ca3zTiEkFs=;
        b=Yj9aMLiBEeKZVjD36F1L7S57ZJt1ei/54E0q9BtjQx7hduyOlPv5BIjvr4TEM+QiYD
         NH/6WQ/gRy6crSTlYRWNI0zJoR5pvPi/Ug2swUmyzc2esoLke+tXsFQJmovLXMpTwq7F
         s55mMjcldeqLJxoOq04Zj2GR7DR3yA+UnlIHgBORg4hNPIESW742jVH66bZZIGaODwXb
         TwOjbRAZb4ZYdaNaNmfAKf0eGg891vPqaFrfaPSTRuP/gW3917Hg7rlI9XGsE+TMpx0/
         H6uR1CBNJNtkJlPHvz8WiPzrKLV3WLBLRR7uyYknQtFlflVUAcnwZ5JYRXP5q/7fNggd
         olAA==
X-Forwarded-Encrypted: i=1; AJvYcCUWFHouEA8KIVoupZ45Ikox8INEvzWGYX7zw0HeVDOxajV5w/UJIuWF7XOIz6zjjCG+9P5sHuL9uftSd/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ2iabD2kM4dzOFGlvK8flYlKrW2Yhq8jpfDRau3wZI99XQkTV
	ipFvAOKEFflO8avohIk5zP/Sol1j5WGyqBtw/eh7SCyZYQUAuC1loL0mgpU6kAw=
X-Google-Smtp-Source: AGHT+IHjRWUaU8ltzBjbkFXmEkgDCxZchAnWE0VBPx5pWs6E7ZjLo/UP7jBOqliwGkw4W1bGRndjRw==
X-Received: by 2002:a05:600c:5106:b0:42c:aeee:da87 with SMTP id 5b1f17b1804b1-42f85af8cf9mr414215e9.9.1727984035866;
        Thu, 03 Oct 2024 12:33:55 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79ed3e3fsm51453405e9.23.2024.10.03.12.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 12:33:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Frank Li <Frank.li@nxp.com>,
	York Sun <york.sun@nxp.com>
Subject: [PATCH v2] EDAC: MAINTAINERS: change FSL DDR EDAC maintainer to Frank Li
Date: Thu,  3 Oct 2024 21:33:48 +0200
Message-ID: <20241003193348.102234-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Last email from York Sun is from 2019, so move him to Credits.  Frank Li
volounteered to keep maintaining the driver.

Suggested-by: Borislav Petkov <bp@alien8.de>
Cc: Frank Li <Frank.li@nxp.com>
Cc: York Sun <york.sun@nxp.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changesi in v2:
1. Switch to Frank Li, do not orphan the driver.
---
 CREDITS     | 4 ++++
 MAINTAINERS | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 63f53feefa0a..1c0ed4b16226 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3791,6 +3791,10 @@ S: Department of Zoology, University of Washington
 S: Seattle, WA  98195-1800
 S: USA
 
+N: York Sun
+E: york.sun@nxp.com
+D: Freescale DDR EDAC
+
 N: Eugene Surovegin
 E: ebs@ebshome.net
 W: https://kernel.ebshome.net/
diff --git a/MAINTAINERS b/MAINTAINERS
index 636a84ccb5f6..03474c934930 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8120,7 +8120,8 @@ S:	Maintained
 F:	drivers/edac/e7xxx_edac.c
 
 EDAC-FSL_DDR
-M:	York Sun <york.sun@nxp.com>
+M:	Frank Li <Frank.Li@nxp.com>
+L:	imx@lists.linux.dev
 L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/fsl_ddr_edac.*
-- 
2.43.0


