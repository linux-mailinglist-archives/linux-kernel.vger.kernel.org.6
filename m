Return-Path: <linux-kernel+bounces-375451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 458829A9620
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AA81C225DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231A612D773;
	Tue, 22 Oct 2024 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gkj0u8TQ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F211EB31;
	Tue, 22 Oct 2024 02:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729563439; cv=none; b=MeC0x7/lX9KNuEpbn1WHcm3eLoI43fT8N3LgLZLGc/9gaBcGGK52fbg7KSnhBw1LzejJmwULWCjw1H7Z8qwytFzSmutqII/gHv3mPtczRb+p4Qf+aEONEz3BWmmBAlW0i0csVSkO/hAeV6To7EAfMz1dDdiFjfGPTavCvOsO87g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729563439; c=relaxed/simple;
	bh=e0Uc8eCy9XVcLAOVwDDRG6Zn/E7kMIrzUdMpCLWVH/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ROE8jl1pQCshHt0CbMFbsKG9Wr4FOLP2gEQaM07iB3eWJVMz69gCFn21cnIQ+8dfAQeP5jWshMtJ5yIcgQkLifqQguZ9Wi6OoLBnRKqMDf4ZBALTz1zDANgOSnR2SjocBK22mPhrb8e/tG8KAjSTDvBJmsgiRs7U9NRFjZfHvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gkj0u8TQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71ec12160f6so1350483b3a.3;
        Mon, 21 Oct 2024 19:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729563437; x=1730168237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=unl0Nii+eAAEgvAHbej2wxzaLvXCEqrnRixry6vtoNA=;
        b=Gkj0u8TQ2gIxTVchF3/t/6REHHqpZnZyILGJQ2lLLhCVphyXdXQaGj0lTbXMlJK4nA
         2yMukMvDMp/m+kL0MZfNPl1UBiPduweZK1VAPGSKq+NrpViZMJhcvoDYjRB8XbFMXtg/
         dKkcLHZkiUyCA7u7sTvnPHIlijgrXzEIfljO7FBqBYmEAou9owlG3/PLDz+ab40Hpqq3
         hPDlaKh0ZceA/nSJbxWPErUazAAf8X8lvz9BZX+fbtvciLoDRvVDFQnQc+1kyikaoVaR
         BrVdH0BbtTtlupWEtqhVs4/kdkKiQIcuX0eTORyn/X5lTWw+0ettojzZK6oSVgTmDOrz
         JXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729563437; x=1730168237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unl0Nii+eAAEgvAHbej2wxzaLvXCEqrnRixry6vtoNA=;
        b=fHdt90T0NI/SAqPDoeJ9jibxNmLZNZ4ucmIcXgblvIn0M2QPpFsK/BL9k/9rPmL+TV
         jdNYWVObQ2L9j5K/Ep/XKxv1bBRppG+zsj6qkWldcBN76yO9RSjguYuz7tfM1rckS9HW
         FnM81Kc4Cnkl+2c1NUrf/WWb0khN2oRZLF543q+0OIihtC8LfJGEVwHP1fLexR/RBvYx
         gB6K42ywLreJQvxxuGsiUozsM04W4TgzVWi42UKh3+1VJa+fP9554g6o/fuP8avOtJgc
         vaWXiiz1sC9oQqJDpPa6jFWlVznW0fKaDCF/jAfCPGaShlonvPbsk6TeDYwEwvWyZUqG
         N40Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHI1lqwKv1fn3SCZ3mL090W5ntHXcO1/p75vljfHqX1G1bgmbCaQeGWNb6rzqcg/mFS3Urh13fFYBD@vger.kernel.org, AJvYcCXpVlD/P/+QIWdKs4ZqO2cVVsjkt1Mo+LxnKgm6RRqks2fIJZFEBoeee8ti2LCY8n7Ve8q78GB75CEYTGZu@vger.kernel.org
X-Gm-Message-State: AOJu0YzkF50HFRyLY4A/so9JHmkggGPwiZRHL2FbvNbp6CWrqzcwhdIA
	YejvO3VF2lhdMLxPFjc63pFHbm1Nq8z69dVKzweETvDIJ4WeHZwY
X-Google-Smtp-Source: AGHT+IH24Wjpa7mWhYCtLnIwnpS4VpShU13ixMjcSAsq2LSlny5LqHchOyGbpuSSaPnjBSYW8C5o6w==
X-Received: by 2002:a05:6a00:2292:b0:71e:5d1d:1aa7 with SMTP id d2e1a72fcca58-71ea33761e2mr18554041b3a.17.1729563437379;
        Mon, 21 Oct 2024 19:17:17 -0700 (PDT)
Received: from jason-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13ea1d1sm3595592b3a.165.2024.10.21.19.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 19:17:16 -0700 (PDT)
From: Jason-Hsu <jasonhell19@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: yang.chen@quantatw.com,
	jerry.lin@quantatw.com,
	Jason-Hsu <jasonhell19@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: add Meta Ventura board
Date: Tue, 22 Oct 2024 10:15:11 +0800
Message-Id: <20241022021511.2322303-1-jasonhell19@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on Meta Ventura.
Add subject prefix for the patch.

Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 2f92b8ab08fa..98ea2b3e0eb1 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -86,6 +86,7 @@ properties:
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
+              - facebook,ventura-rmc
               - facebook,yosemite4-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
-- 
2.34.1


