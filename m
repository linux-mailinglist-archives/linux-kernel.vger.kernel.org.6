Return-Path: <linux-kernel+bounces-394465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E809BAF7F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568D21C2131A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC621AC435;
	Mon,  4 Nov 2024 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="U/h+IwVC"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A701632DD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730712157; cv=none; b=jZ1xCwAByMx8heuwEl8Sm9NSoAKZPL88aGP2sflJPsNatLEKkCTQQycpc0ZAp69q0jw71WCH4EwGTE8CvXjzY5qqRznNHvuU6a45FJEiURF0IRWjPi0WiigD4J7p00EuBbnrFTHQK/Lc4J3GIsFYxU5Sbr1b3/twYwlMpGxPn6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730712157; c=relaxed/simple;
	bh=DBgTrbstgIrfs2aAOPjrRLfqOaoR8mlLG5lDgCgfVN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YTBVqNNiOlJ1NpCJm8hMQFwxr4WegfZ/pa7xTsoOlHaqvsfUA0aFchE93XNQr28EYSpAb3d1iOQMo47RZ7ZHFwXhoQjrHagU+h8kiQencqTZaz1XVReoKV43f9ofQMkcRHAV0jLfdrOUswq5PMJSBL/as9Sqf++spdZ9bhjBPWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=U/h+IwVC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43169902057so30885075e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 01:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1730712154; x=1731316954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0x8YfzKgLTDDx7pLL9ZIfdpCd48D9g1TybgGh/+DyxA=;
        b=U/h+IwVCaI9Z4IwpRdEH93qrEzOoWABRz9zET4XduXUPiqvOh9a7l+epkUeXAn/z9E
         oTehqEFINP7ncoPGTGj4fjBrPE06W9bukPRcVS71mFOZxMfLDfgeWCLrv+O7kdDQaygI
         K9ge5pIDcSmKSDb76pLLFOBxFltZFknm8xhwkYiQCRz0NDirpbOMWdREbgE1bi9QuZXg
         pAFdkIwzMaCkqTMzlS3FwGNkC255hJx9CCUE2XPHREVHtQr+Ps5Fmw3lwxmJ8IKfxHkf
         Hwr6RdMi+Ua/QHfGlXgp9MRIjZar/omkujqNYE1Arezo08vxvTQhXtIiaewDn/G0NVwB
         n7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730712154; x=1731316954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0x8YfzKgLTDDx7pLL9ZIfdpCd48D9g1TybgGh/+DyxA=;
        b=MQBRhpSo32QVdJNfnRSRg1OR4F6pT32DU+Y993KWJpmZFmN7tMeADQ6inrZ+4juJSr
         MPjPZN7yvwc+IACe0yrii1nb+lG7nfPNKv3sK6hGSzcKhgxGLXLjIIyqrDjQAcfYYy0b
         /rik/6JQH5bZmKmqITmlOvHyCr3HqlqgoxPJRMY9AXQqAi2zWgzInDOmtstVELrNClHo
         bMVCRAAJvCHCr8lHhVY/UkjxLe0Y/GHiI4yf48s+fhF7rbCuhZNo2pLiSm7qHhltsgDf
         UiviJJNjn2Ke9543YkoY5x9cCmYrLchokaldH+fKN1ZfzzQuqkrWh40pOE4ovMl5ADr2
         iFzw==
X-Forwarded-Encrypted: i=1; AJvYcCUyPNQDJJ4m0I3lA6ckx9BTHNC675nhPfZPidNm+YMQM9LlNzfVytLX+MkeA0zxtkHF/PRifCJHUfbwXu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhpqWmt25koYWQ+9eJZQQXHy08PhE4QHGWzIUp4ji3Wm/4Ev85
	DvhGOYaX1zMAqCcw2jzeqUcgnT96iI1PVsc+oii0Z0+ledCH7CHCM1FetaJwWsk=
X-Google-Smtp-Source: AGHT+IEP9RuCeHmDYOOToxOTcWwGxpvwDvs0FtYDNiDwDu9dBrotM0xovdSu4CmO4Yn3WMu3dC2yrw==
X-Received: by 2002:a05:6000:18a7:b0:37d:45ab:422b with SMTP id ffacd0b85a97d-381b708b694mr15447460f8f.31.1730712154262;
        Mon, 04 Nov 2024 01:22:34 -0800 (PST)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116a781sm12744872f8f.96.2024.11.04.01.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 01:22:33 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	sylv@sylv.io,
	linux-hwmon@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: [PATCH v6 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
Date: Mon,  4 Nov 2024 14:52:14 +0530
Message-ID: <20241104092220.2268805-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on IBM SBP1.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in V4:
- Retain Acked-by from v2.
- Fix alphabetic order
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 2f92b8ab08fa..c79c74ab3d78 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -91,6 +91,7 @@ properties:
               - ibm,everest-bmc
               - ibm,fuji-bmc
               - ibm,rainier-bmc
+              - ibm,sbp1-bmc
               - ibm,system1-bmc
               - ibm,tacoma-bmc
               - inventec,starscream-bmc

base-commit: 30a984c0c9d8c631cc135280f83c441d50096b6d
-- 
2.42.0


