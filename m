Return-Path: <linux-kernel+bounces-386131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E569B3F78
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FC42B2142A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6715244C94;
	Tue, 29 Oct 2024 01:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0aMpgxM"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B621348;
	Tue, 29 Oct 2024 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730163981; cv=none; b=gSRrTJEKcyd0O999L0li51lsXJmyldgZ6CrAg9WU/ZXjxOIkE6QxV2by+zTRaaV3ZJcEdIe9IsNFWUXQTZP7uFjihgJRz3EJrUpwborSIHIuOqWlseTz/uVwMhKgulrdtguUsl370MklJ0o6IkOCWz7CHjVEEZJRfdh/XDYid+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730163981; c=relaxed/simple;
	bh=5y7ODK2Dk9vouU8KGrTXpnUReHKWZ2Ru6W9u6WOuE3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBKNyrk9uka3Zt0997VWHk/VWyXkFJP4zSlB3Gh6MrE786YRJrNrelCQvkQiai2bx3Kon/x5RPjmAkHn+cUobNurvabr/vWzrBcpen2FTCJacftdsmEboKpm33Jrf14mx7jbracWQlYHRevnEICU9qMAe4s471x6bcwZY4x+K5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0aMpgxM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20ca1b6a80aso47697655ad.2;
        Mon, 28 Oct 2024 18:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730163979; x=1730768779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ykES3oDK4GWMgcJf+eyKS9L0HXbi9j2qtJXcGhbmlY=;
        b=d0aMpgxMJxXtUhFjpUu7FB5MYSU6/pfXnzSqh9SMH1XfhbYg4gl8+I7EhZI02QbS6F
         HOz4YlLTy1pTJX/AwhMRG+vGpzx2KdZvU/iM1yQ/0x2yVOrBKIB35RvSpmDvo6eO7HsV
         63J9Pn2SsfCSRXfWbKQ3CJDcQKeqGrpkDgSZm1F0XbOtRpC1SFgCCk1lVg5bndtp7e9P
         ZnlA51AslPJUqDzwL2T9neqVtCYRD9t01DheRlBS9rhcdMMkjDnRYyrq6GyMmuSSPKow
         CxFJQuauYHKZjghCQ8Jk1XJMlYfUp/xjTivx9W1m+op3Aa96gv0P2NGIPLuzOOFxCIn0
         hW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730163979; x=1730768779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ykES3oDK4GWMgcJf+eyKS9L0HXbi9j2qtJXcGhbmlY=;
        b=d8FBwkdf5MvIcJUFXCaCG9Kg4qJ0n7LNKmiAJYXZ/IaISmvTRdqmJ/j+101s7idCLK
         +yfjuwbyiAYU610JaLAlCMbaTmFrknNFN+X40qiz3a1+yovOokDC3ZxKi4d2cgcAZJ8o
         eXd6/uaonegFC5s05jKYSS4Rs83LrGVAHJXoylj5MJU7d8oADsstJII3kBLGXVWXWtpa
         DdN4XutVvqDicsDoa5bXMSAXkdOXW52j0qVS7Xc+kin8tZB3+jHgW0DnuWLPOvLX49wH
         ObznzmXAcwEbyACLLP3yokGX22oOnlV8R/62He0y/grqbYBiJR1cAhipFNzr4+VLVQCz
         wV1w==
X-Forwarded-Encrypted: i=1; AJvYcCVEMG9E14OcBC0g7JBEGdGKJgFtMq7zJMCU6292fohhTAzpmByGdzESxNOifT7UDahMWOIx11WtVNQO9uyw@vger.kernel.org, AJvYcCXq+i3sP3lXzVjA/1IcZzemAkbgsPwyd6VXWRHwgeV1xbquqX5Wvfgfdaahjm/0/wJego+VsBiTZhiU@vger.kernel.org
X-Gm-Message-State: AOJu0YxU3Ke5DJUbL6F+e17IWPjAyleZbV/1A/t9k3+5wc+Cbc6d3LHb
	HlKp1V5yTHp7Wb/uzSkfegXYy4M5atAXyQ3bZFGsPCR4NwhsQaRc
X-Google-Smtp-Source: AGHT+IFeHXHCcPoPLxySF2I8zRYb1t19CJOoicaN/3KR7j3X8ouOCXsEGoLKx9fWFvaUXkzRPg/WQw==
X-Received: by 2002:a17:903:41cf:b0:20b:51b0:4b22 with SMTP id d9443c01a7336-210c6c8f84fmr120951455ad.47.1730163979437;
        Mon, 28 Oct 2024 18:06:19 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-210bc02efb1sm56306225ad.221.2024.10.28.18.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 18:06:18 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH asahi-soc/dt 01/10] dt-bindings: arm: apple: apple,pmgr: Add A7-A11 compatibles
Date: Tue, 29 Oct 2024 09:03:59 +0800
Message-ID: <20241029010526.42052-2-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029010526.42052-1-towinchenmi@gmail.com>
References: <20241029010526.42052-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blocks found on Apple A7-A11 SoCs are compatible with the existing
driver so add their per-SoC compatibles.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
index 673277a7a224..5001f4d5a0dc 100644
--- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
+++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
@@ -22,6 +22,11 @@ properties:
   compatible:
     items:
       - enum:
+          - apple,s5l8960x-pmgr
+          - apple,t7000-pmgr
+          - apple,s8000-pmgr
+          - apple,t8010-pmgr
+          - apple,t8015-pmgr
           - apple,t8103-pmgr
           - apple,t8112-pmgr
           - apple,t6000-pmgr
-- 
2.47.0


