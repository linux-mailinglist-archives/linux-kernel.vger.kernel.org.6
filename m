Return-Path: <linux-kernel+bounces-222866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BED129108D5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09D31C2166E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31141AE09E;
	Thu, 20 Jun 2024 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVeWimOI"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A763A19B3E1;
	Thu, 20 Jun 2024 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894836; cv=none; b=DreRaXHY3dAYHC5UfT9IQN838F1Cu+6WhJkZjb2a5f+MUG4pHTQDTqQLVs6tF43aEVgGf6Z24ONLrM5KM67jgJx3A53zELwVYjZTDA2+FEL1JyFN5TEA+9+q5XATMSi5umXypowcH3p7/efpyB19C1R9DQnE03drI+WbL3ZnrzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894836; c=relaxed/simple;
	bh=biPfPerllV2YJWNLhd4V56/LPESkzegIsTdorxeX760=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nvb6thNP7RVYlWa4h1x8w6eGYVlHxNiOAI1otxYBaFFub3VRvmTwm/h+g+ec0oZQkGOqyvJgv9y1fh4KUbXJJ4HYsYquSeoVX8gNbNcErVjPulkI4pxZN3csUK5fF40wduA+1/zOf+7GNuI4RpI1oNaZiBfbsLL0cAQtibtxEf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVeWimOI; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57cb9a370ddso1053437a12.1;
        Thu, 20 Jun 2024 07:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718894833; x=1719499633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HCduCWRNxpQnCmzES1oGs/2/z/hqjBJcUHo/rS5dfu8=;
        b=YVeWimOI7QjRWUGTfEqteu4wqMtrtn548CkI7kNK0OSSZ2eQTvnReSJILUAlTApDnQ
         7eWUnJQm1xsNOca+X9+QeOvSSmXBEjEJAsw1TBtEyKwQH8eqFTViyqrsGn1KyaKfaiyT
         yPr93vBtnezXaKc07PwBJl09VjeXazYDPBMevpMT2Qlck2XY/wEGroo11JdrUHQ8kicJ
         TyY9HEJbSeQdLNpjNfU4GwFaK/Pe2n62vB70RMRIEgqoOnurpKjtdDyZVODw6SJm5C90
         IVNxRQXADgct81G72hFLI/nV4+FChcqfSLl9LOgG8CKlIuBeZutMd9Vvo48Flj5KWaRd
         b/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718894833; x=1719499633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCduCWRNxpQnCmzES1oGs/2/z/hqjBJcUHo/rS5dfu8=;
        b=oGK58qEgbXAcaspcAifsXxzn8zMU59jjIrwwu8tXkvdVwAIm/MoYhdCRxKwGw5o/Oq
         DucSkf9C5zddSaKclO/UHHTzOhq2IsW0btuQyWfoPjIoQqK9zNaIEeqt1xDLAABlQaR1
         aLi7KJV/tsdIrid/3bpgWhe8Xl6fmT3WggRL1CocaLI+HOIjCAoDLwhOJsSpO3RddZdp
         CQN/C4yi+Wb1CzgPpWQSXJ7+N5ga/KO6hbCnHbzS0BqwZ3U8O6gn2bf2MBIK1nfl3EzA
         5FCgdJ8IcGSNJo2cLujGInGPvPFNYF9ojM8bYZFfIz3u+Y2hjHzHhbKjU2uxYAkiKNYd
         dykQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOYKbIIXbIf86w7FVqQ1AM7ddfHi8z9HY2arGYE2oasPVBXnrhn/ygqi2gccqGupsQGlMjwuaViS4MJN8wQ8kAYdlopSWp3PkXZnZ/YNWOzV1fpHL3SOpvpmTyr2wcQCXm6Je4c7PjaQ==
X-Gm-Message-State: AOJu0Yy1E6FZktJ8Oy8O4JCv2bh1RkCH/SrKLnJXcxMtZhjdG64d6Izq
	JhjryLoRrf+PSeE+dZfgXJL+4A5YyMrG8/jBPsffxdVFZ1eg+++d
X-Google-Smtp-Source: AGHT+IFc69FMHRc+EgpTeoRHCMEOWZNRP/G9Qd22HpB81jSFlgy3FGk7x6qbuMMFeLoHQ7OoGKvE8w==
X-Received: by 2002:a50:d74f:0:b0:57c:677a:a941 with SMTP id 4fb4d7f45d1cf-57d07ebf13bmr3279772a12.40.1718894832869;
        Thu, 20 Jun 2024 07:47:12 -0700 (PDT)
Received: from iris-Ian.fritz.box (p200300eb5f2e9b00caea2d1d6a49249f.dip0.t-ipconnect.de. [2003:eb:5f2e:9b00:caea:2d1d:6a49:249f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb7439070sm9853932a12.85.2024.06.20.07.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:47:12 -0700 (PDT)
From: iansdannapel@gmail.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko.stuebner@cherry.de,
	neil.armstrong@linaro.org,
	macromorgan@hotmail.com,
	sre@kernel.org,
	hvilleneuve@dimonoff.com,
	andre.przywara@arm.com,
	michael.riesch@wolfvision.net,
	linus.walleij@linaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ian Dannapel <iansdannapel@gmail.com>
Subject: [PATCH 3/3] dt-bindings: vendor-prefix: Add prefix for Efinix, Inc.
Date: Thu, 20 Jun 2024 16:47:08 +0200
Message-Id: <20240620144708.125497-1-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Dannapel <iansdannapel@gmail.com>

Add entry for Efinix, Inc. (https://www.efinixinc.com/)

Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fbf47f0bacf1..8e9dc26b2a79 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -422,6 +422,8 @@ patternProperties:
     description: Emtop Embedded Solutions
   "^eeti,.*":
     description: eGalax_eMPIA Technology Inc
+  "^efnx,.*":
+    description: Efinix, Inc.
   "^einfochips,.*":
     description: Einfochips
   "^eink,.*":
-- 
2.34.1


