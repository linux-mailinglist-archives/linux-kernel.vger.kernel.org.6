Return-Path: <linux-kernel+bounces-245056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FA092ADBF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F281C213C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE212AF12;
	Tue,  9 Jul 2024 01:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zyyo31OW"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9064084C;
	Tue,  9 Jul 2024 01:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720488170; cv=none; b=rXfRorBvJDMglBPfYnDdOfrRs0rLCOV6XXgCWRiuTlQAWCIMDnH4zj/sAEykgc2cqtmLZJKHUdQ1x1qqYbOB6Zwr/b656EzY7IFgj+TgZNiLU42dnIjIJWVsb7y0JRwotUDV2t91t17UGlRULcb08AvRpbUl9FYph/KhVeBRxM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720488170; c=relaxed/simple;
	bh=X55x89F4zQj+QNYug9W0Ln2GA87v+38srXruTiwv8qI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Z28zp/tOPhn03JsG+NSY0H/AdmS7eThFa0xaogG4bLfGYYO76HxcI63Ioc9ir411ZP8NC254J/O8mNoeV2JrHU+QURWUH5wmDfRsK3uwcHBezrNkOdSLkQ0zqSNvso1cDjUUlbwe2cHrXA0b6/9ae6mA2wvpd3oRs/txFBD3uzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zyyo31OW; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-70af2b1a35aso2893985b3a.1;
        Mon, 08 Jul 2024 18:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720488168; x=1721092968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ALdI0UctgImPzi6D1BhhRSlNPVcUa47pGds9rw5vQLw=;
        b=Zyyo31OWP73VR5HYyOBBckDGzojtF3tB73ZPLhXAkMyPsDTc2Ie/gDjlOP5VaiI+TG
         XRlDnx3H1NektgaV999gAUHKgtC1IozqX/Z+q8KFNXZFMhM2meLgxBO9CyIjBal7bPz0
         vZKE2wNgGjQ32EN5zqyOLpP2uhpUpE1EFKoRpuTt396e4S88RbvPfamGbMmoyYNAEtq/
         Ua61BcqE+DTu58Ad1IEW9L+SJO7tZ2HivoV4NGD6uquwQ+t1I9wDoacbgUs4RJK5Chw1
         9BU8/pl1yHUB4iQyQc4KcNuSuCBgMcmhcFRVrCwHiau+btDrZZeg9OhJOgvWByYVFnje
         QJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720488168; x=1721092968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALdI0UctgImPzi6D1BhhRSlNPVcUa47pGds9rw5vQLw=;
        b=fVYgN8ueV0t0KJ7bXkxsnN9VCNK3xUBC/Ra7qLS41bFAZzYU78tOqc7kTJ+Fnsj1ap
         ax2sC3hJKVrMu9TFmX9ZLFhtbpQtsCM/YosFVeW67QYMAD6vPqQwhr/nyjSeKhD+PXtw
         clCJILgc1guwM3lKzs0Ih7t1SFnbw8ZNXZGJ17MhD/vTPaSYOjoMgEo/AchzK193MMzv
         zTwWS2hkKk/gH2D8f84mVCEReyNLqpiVgNyRId5t8VP2T6/lfvt/rr8fD0n66XxQYga6
         12Md94Wokd/DE69kGl0GHbmD8vmXJ44xkdXeR7ZC/57z8bqXmXDtyC0Ka8565Ib8iUoT
         Ejnw==
X-Forwarded-Encrypted: i=1; AJvYcCX3KQHd1c16aFJWrwLPSizLiQi4YkLW/fwr/Vg5uqyFG/q6z0NXfKCMz1EJnTanxXRZIg3rMGVGqedzxZdU80QiqaWkYtpqQeUYfw6g
X-Gm-Message-State: AOJu0YzSyndKv0igyPy/BdGVUrLoYiRgHGs/yFYGuyZxSa1xCUlSgSvu
	3+VdVx7Ara5vaZr2j/RXAtji2zu9eUhs0SzTgiorrGbD26RqiJG2
X-Google-Smtp-Source: AGHT+IF94XayGITTJcNJD+5YvSPWF3SzKp+BdV3iLGBq2+H1893cXMfeWjxEHicL39N8sbma2rAUmg==
X-Received: by 2002:a05:6a20:3ca4:b0:1b3:d59f:2d87 with SMTP id adf61e73a8af0-1c2984e10b8mr1190308637.55.1720488167607;
        Mon, 08 Jul 2024 18:22:47 -0700 (PDT)
Received: from localhost (66.112.216.249.16clouds.com. [66.112.216.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a92a05dsm8929857a91.3.2024.07.08.18.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 18:22:47 -0700 (PDT)
From: George Liu <liuxiwei1013@gmail.com>
X-Google-Original-From: George Liu <liuxiwei@ieisystem.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	George Liu <liuxiwei1013@gmail.com>
Subject: [PATCH v3] dt-bindings: vendor-prefixes: Add prefix for ieisystem
Date: Tue,  9 Jul 2024 09:22:43 +0800
Message-Id: <20240709012243.44810-1-liuxiwei@ieisystem.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a vendor prefix entry for ieisystem

Signed-off-by: George Liu <liuxiwei1013@gmail.com>
---
v2 -> v3
 - match Signed-off-by email
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..0ffa8d06aea9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -609,6 +609,8 @@ patternProperties:
     description: IC Plus Corp.
   "^idt,.*":
     description: Integrated Device Technologies, Inc.
+  "^ieit,.*":
+    description: IEIT SYSTEMS Co.，Ltd.
   "^ifi,.*":
     description: Ingenieurburo Fur Ic-Technologie (I/F/I)
   "^ilitek,.*":
-- 
2.34.1


