Return-Path: <linux-kernel+bounces-422226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBED9D961A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC07C167205
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD8D1CEEBE;
	Tue, 26 Nov 2024 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cB67RTp2"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467411CEE8F;
	Tue, 26 Nov 2024 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732620033; cv=none; b=a+5hcWnmee1JnsWcVZJArKqxMi4fxhxgWKHIbA7vy6Zq/BlrxEQD45K3XJWwd9C/aAlOnmO4Qb1SMCwFcWM7/6piKspF4FtKw9IR5unGCpOcC91W/hM6kkHdy45vVxQBewAH0cbVUoyiI16TXypDa4t8GjCX1KkuSJ1fLqht8hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732620033; c=relaxed/simple;
	bh=QpyK+s01Lxhi8NEMyuaegdg89/DBEY+s4MsxWQu0ff4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hNx8iMu43pVcXZmusBUPdEIZN6Zttb4WngHb6GsQsXvRfllQmWI0B6bZJlR9KEhCYh37zDjkbcGRWSnN9G0/Ul5eaqRcJ64u0SJ403weqZjnkkjABvQsltAo7Y74v3HFIyTJMd6qHQjWdAGg8HJl0wPdmJ7DnB0qWLg+o+/iKkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cB67RTp2; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7248c1849bdso5460318b3a.3;
        Tue, 26 Nov 2024 03:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732620031; x=1733224831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tb+EnpOEWqbg5iCLmnC0J7ea39+1VY/WhLbt5ileqoQ=;
        b=cB67RTp2VENfhfY063YfoN/Xifj5j+jJFMSQMt22wySqHy1ZljyeVsTypOkrxk/z9l
         RJLH63D9UShhvkdA58Y6iDcf4lTv8epULSSQfjJG2lPUGOHyiFkHQRtesexpwmyoxBBI
         PA+cjid269h18j44jdTl1WxzuEvQzAwqYsMTOeIPj4jnL0UsKmxGaR0uT2KHPtlibhj4
         bykBc0oWTCrBupIMA8Cn0JR5W+Uc5hdKI45bMadXUKflAOyQTUtxATvch8I+rb5Kb5v6
         bDwytlzwb6HzViGQD8+BpjHlfizUthtQVxLAj3YW4UdbagtLQv4a8H6onyuFp8zHQftm
         VXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732620031; x=1733224831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tb+EnpOEWqbg5iCLmnC0J7ea39+1VY/WhLbt5ileqoQ=;
        b=ZsauoaOh1Svi7m0PQettOld+zIPcrQt/pp8OsnSlfwSGeSqYFCJVBr9QUcCIq9RWXI
         TVxJKhwG3DZ5t6mgM9nCPMyWL2Sh8jtjL443vut4qh/SRx7cQbszXcjn66jnMickwYA1
         3lIDT7CZNsq/b0Y2JKMI1kZfZoPgOtl89BlxV1MDvoWPhU+vb9PfVJSGbXfl0v2sZdm6
         PdoHOjrsxquDERwYJ6VW4C1tIQy9V30NfFo3buV4AlkfLUoC9s7qBgNnGcJEBEeQcrHI
         qSGrRzgZN+SCo5o/uPdjbL1ce4Ke6LuywreEWSJYaXSCi3xc/Yl5pm0oqsrM2hMbUXMr
         doOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9Jl1GUlxSQaK3aQtU1UyTbrO7zgN0Y8RnFQVlcTOfSm3jBcie9+EX0D/vtf0ZgrEodGPOxnan+K/P@vger.kernel.org, AJvYcCWLg2OUgslwQXh9sWmzdWFs2Oi3JVNZHpPzZmzHcUGrY0a1vw/D4lGhy5UwDxjPsSyoE21s0L19Sr/4sxMX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk99OpOi/uRHuCHF/dXNtz606CpCwBTVOdLrZu5AyC8l+aw1mV
	uNZWZN4/4+wxDchDXJBeds50FenrptqPvnQXAD/WIvXCZLEivYWZ
X-Gm-Gg: ASbGncsD3ew9hPix6jmZoR32YoDfTQsBjtBJmSeigDkP8juE/Lns8K24G78oPd5EldQ
	3dtJPsQ1x+UY1BEXCONg9pYzUp7luAbAhHL7bithWGZ2q+DS3Z6+tyewYj7vHAm9pEvFBn30C6y
	pQ31ltA/Q5PAwl8VF1NPlDhxdJH35wgOhhCVSuu7FXs872zmImQITV1xTq5DanM65SmDJ4c43Hx
	RWM2BBY5XUpmF0JHS6kHu5z/RoOsRLxTdeLJas84Gj9T0WgeYZmvC3J8jNnQgbWHM4AtrYDxvn7
	zulU+6n4LDgFxWxlHKNCYEVW7iYtcZ6AC7dvcno+gVsZS3G1GAUl2gqL5hctw7V8
X-Google-Smtp-Source: AGHT+IFwaXUSQdileW3hevrYxNeWCHpLe9v/tmEc1xux1jDfeU/ZHkgB6y/eGFDCPWiwoeS97ASx8Q==
X-Received: by 2002:a17:902:dac3:b0:212:e7c7:6bf4 with SMTP id d9443c01a7336-212e7c76fc9mr192626005ad.28.1732620031447;
        Tue, 26 Nov 2024 03:20:31 -0800 (PST)
Received: from jason-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba5d4bsm82210885ad.80.2024.11.26.03.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 03:20:31 -0800 (PST)
From: Jason Hsu <jasonhell19@gmail.com>
X-Google-Original-From: Jason Hsu <jason-hsu@quantatw.com>
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
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: add Meta Ventura board
Date: Tue, 26 Nov 2024 19:18:16 +0800
Message-Id: <20241126111817.2331577-2-jason-hsu@quantatw.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126111817.2331577-1-jason-hsu@quantatw.com>
References: <20241126111817.2331577-1-jason-hsu@quantatw.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason-Hsu <jasonhell19@gmail.com>

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


