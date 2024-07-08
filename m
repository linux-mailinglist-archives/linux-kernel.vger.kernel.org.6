Return-Path: <linux-kernel+bounces-243828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D22929B26
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 05:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D58281468
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 03:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CBE79FD;
	Mon,  8 Jul 2024 03:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqEd0NqI"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3478F812;
	Mon,  8 Jul 2024 03:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720410534; cv=none; b=hSwpS8ldU3shw8ZPoIEl7rOT99hsQawTa2MGc3AggjYBW42zZXbIanJRZ8ez0CmlsSDyjifyGEKMtiqSKmci3sRl4/xtmRWXhMDHRVjeTlSTeAjV1/M2wB1IE2Q2iPE4S3yUiTpGAGvgVJdVa5xXx+7y0UnLirkjJ62L/VmhCGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720410534; c=relaxed/simple;
	bh=DR3lQkt61V+LYkFulh41gYt3LOsgKd8rT8vexpvJNyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FKjFRQEUQCxJYuZE5j17/JpjDAe0kx6iB67v2JTDm1FFGg5iuo/E5FkC33F2unp39vz4et3VIziDjsXJ//8Bp9RK2z3bBIZXywU8wN1Gsjm7mElllsO174fHaMzTTapR+gVWv8huVjpSA9FDdvacNGW3zJLo2dyer7Kos0u0IXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqEd0NqI; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-75e7e110e89so1703066a12.3;
        Sun, 07 Jul 2024 20:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720410532; x=1721015332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J0qY0eq/bCYTLQqVWP+SkvvD807zfIcKNdRibSQIaU4=;
        b=RqEd0NqIFC4Hw+uT1gZxvwdR/bb57PDcYiLFj06SfD30qgs1Ca94Z9lEcv7dP16ymH
         AYg/KLq/r81s+x0EcPbFmHqxKqCuUReGiwW3CLeFzM3tVDrh3rqccpF4SwztaRp+S2SL
         2YLcB6ywW6cztUzpsSkJEEABVWiyggY5KGrMc350PwHfAvY9tr8I7XMiKH4Pw68VF1XS
         GNPPdtTrEIhdfo2UZ8A5ATsGS7gPa2vpbX76w7pR7u6R0A8bkEdCWghsrcUNDRjUin1r
         v2767MrIStpJl0/95AuGR//Z4q/+oayj9RWy1JayTC5oqk/twvjtFric/hu1TTp/t3/U
         vn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720410532; x=1721015332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0qY0eq/bCYTLQqVWP+SkvvD807zfIcKNdRibSQIaU4=;
        b=wau3oOu9twlX6qmQeYrXcw2yZr37m+AQsl39iumC3Px8LCJa1PPSVz4xhFn4ZoNWtg
         VyWFX6Fm7kwU8XbGSY3hZzmhLM0FqY4C6+988mEN2ofXZDJWqG5mf+sYGb4dgoRkCxUf
         XhwGnZzFLiWD1bwU6BHgJ/zT4JRgnavsDAnjk3JO2Nvrpa4vwTqaZUXEY6zQr2GUZ0nS
         HP+EsRxtydJN8HwuBjVafs4VjNidO3MdC+Fvf37R9UxNaRLoyuI6Pshz036i2gBJy/77
         13v73GsVAQNm5Wdvb5fSBVKvdVk17O96im4y0Kai7ABbgXjOOVIl9l/IbDt9opLSpd8f
         39gg==
X-Forwarded-Encrypted: i=1; AJvYcCVplw5jesaoTla34BY9P6D7RT3G/Tr6Uce6syWmasqKH4H5pEF1xyt60xy6AV24RL7RO/bXCs4MkyqErwr6ZQ3BNfvpHo+jHaAg3ftF
X-Gm-Message-State: AOJu0Yz6+xXQT7WwIEP4jsaVnG7VIVJ74zypGohRa0XwHxh/1+kt616L
	YuwidAnAsz8ldDEUU42ycSnJd5W/KUZpKh9f6EEftEuOMumi7jCA+qXg39JD
X-Google-Smtp-Source: AGHT+IGHpvTAZEYiOcCH84LBE7U4kiNjB0dWQavoCxPd59xGuk85zXCbRWBVX9b9HASK128Gl+V5pg==
X-Received: by 2002:a05:6a20:734b:b0:1c2:8904:14c2 with SMTP id adf61e73a8af0-1c2890416b9mr875148637.37.1720410532123;
        Sun, 07 Jul 2024 20:48:52 -0700 (PDT)
Received: from localhost (66.112.216.249.16clouds.com. [66.112.216.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a961f50sm7103416a91.21.2024.07.07.20.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 20:48:51 -0700 (PDT)
From: George Liu <liuxiwei1013@gmail.com>
X-Google-Original-From: George Liu <liuxiwei@ieisystem.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Subject: [PATCH v2] dt-bindings: arm: aspeed: add IEIT x86 platform BMC boards
Date: Mon,  8 Jul 2024 11:48:48 +0800
Message-Id: <20240708034848.100930-1-liuxiwei@ieisystem.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on the ieisystems

Signed-off-by: George Liu <liuxiwei@ieisystem.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index e386d0ebfb14..818fbe9c45fc 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -92,6 +92,7 @@ properties:
               - ibm,rainier-bmc
               - ibm,system1-bmc
               - ibm,tacoma-bmc
+              - ieit,nf5280m7-bmc
               - inventec,starscream-bmc
               - inventec,transformer-bmc
               - jabil,rbp-bmc
-- 
2.34.1


