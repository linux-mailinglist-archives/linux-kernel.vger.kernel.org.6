Return-Path: <linux-kernel+bounces-188630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE5E8CE49B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEEB928242A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B8F85C7A;
	Fri, 24 May 2024 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="g3WaAMdR"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB25185C6A
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 10:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548385; cv=none; b=EZFbzUuNY+Kq2jxt6Lo/DVLALorXWbWNnSis4iRwrIELWPyrDupRiW1hVHd/O37g32BkkFtTxgGf/h04N5gpMkssnqiSCX/fqZjrqfGbmOiM7B3O3XT7d6GTmfM50RceCwYLqKX4qRnjn2JB0wPupu3U3Tsna3w+LpadbjqR7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548385; c=relaxed/simple;
	bh=NqeeJSjs8RW6WO+W/yuYoxXi4n9LCs94p37EgDi17ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P7oI4KJUo0rWb8t2pco5VrnIiO/J/YTrrJdPuTG0qz1ypzVAfJ06mIYN0miTXCleC/swZBWp/jXB5H5AC5ZRtRQRGS+IML4ayWyinefYBAaBKrJLis05OSF0KGdbs2FV3gayHlTNnCUHe5PdiOHBIA9rIZ3LpDHC6cNa5bD9y80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=g3WaAMdR; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e95abc7259so6846611fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1716548381; x=1717153181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yP+35eRZqZ4WiMnuzTxJyTRhfiCcTNB314PeuCIhpmY=;
        b=g3WaAMdRjdHzT1fsYRSthhxHOBJlIAwLmXfs82IbobLtWqYUvA066B83npdgaWfQCF
         oLcgaxV6B3PrRpOa4OIJjtoY994DJHIugtQfpqbfHvl3/wyis6BtN2eGSVsaAHKcC+El
         Oic6E+zqaIinsPm47KZS2/0/WmkITcWPK/4wwRQ7dqByyR6cghhlNgyUdKVXIfIBiJUi
         HwP/wdzCyh9vafthOZTm/IGgcPTc+PDmRrHyse9bKJkF8Nc1qLEpKpbnKVKaCbh26Ruz
         I/PxMtzWNqSpocf51iKjfa3jkh3N64W7WthW1M/jIsopAT1j8e2DCyec4lnxI3chgfwO
         hGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716548381; x=1717153181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yP+35eRZqZ4WiMnuzTxJyTRhfiCcTNB314PeuCIhpmY=;
        b=PzK54eONIBVTSSAuNpTh0a3CcWepsqpUEegDZY7NJjJp7hmoTam/24iDxAdy2nRLYj
         Ojl2zBEX4sW7KT/7ATiVI6OnN5sn7VlHz1MEFqtNcQipIPwU6XEOwnz5roqsm/wAjnTy
         hNLUJWI4zHPIi92zQovU+XNSxqp7SxukmD5nfHmrnGFUjYbqPxOi/U9JqbHoyI32QbMw
         5HFNC+7ct9T40nzcK0TiWkCYktaticA2BXPs9GqudqofCLIEf6nBZsJPjz4xPyfuHTJZ
         X9YjmK/M94q/6/kWSdvduzZG/Ojwhk0JLky8pFpTUVwBRbCBKV2RUbg9UYNKRyYfdvpo
         JrxA==
X-Forwarded-Encrypted: i=1; AJvYcCX+lgUI8aYTncnCnzlbtnDUtg+p6EICP/s0TaH8n6Fa11Bb93llIT/GraP4NXL4ufGk5FBMj4BNslQ2xPrQaLXkPNDC3qaU1N5mdzAZ
X-Gm-Message-State: AOJu0YyI7/RPMzrjpyly4sy7TM3lPbTP698yqp73zYU7OIL874HKqwfW
	A2pPhpdDOd1Kocbvu77WTbFUJS9mt1v1O+rOU4RYOjAnO/Hr6lgqShlyi3kPI3a1NOvP30H2yJ5
	ooF0=
X-Google-Smtp-Source: AGHT+IGK/BLRQXataXUt6EPhmbkyqO5rhkY7srRTdSk9qHDfilweWDrpUOv1g25WtjZeg6fxNjakXA==
X-Received: by 2002:a2e:b70a:0:b0:2e1:adc4:47f6 with SMTP id 38308e7fff4ca-2e95b0945d4mr11424051fa.6.1716548380802;
        Fri, 24 May 2024 03:59:40 -0700 (PDT)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108971393sm17396985e9.19.2024.05.24.03.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 03:59:40 -0700 (PDT)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
Date: Fri, 24 May 2024 16:29:23 +0530
Message-ID: <20240524105929.557129-1-naresh.solanki@9elements.com>
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
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 749ee54a3ff8..307232336629 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -83,6 +83,7 @@ properties:
               - facebook,yosemite4-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
+              - ibm,sbp1-bmc
               - ibm,tacoma-bmc
               - inventec,starscream-bmc
               - inventec,transformer-bmc

base-commit: d976c6f4b32c2d273d44ff9ad7099efe16279a39
-- 
2.42.0


