Return-Path: <linux-kernel+bounces-416498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF04A9D45E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C711F22253
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EFE13B584;
	Thu, 21 Nov 2024 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2LUvPLg"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6AC230998;
	Thu, 21 Nov 2024 02:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157611; cv=none; b=mHuWhKsinYy/F95xTlDkTiBBpmvlVUnce6Hy0AbUilwx2cvcYzYK5+CkP6MrI1B5Brw5wb1MxVSWwkrQQnDjCGoZ0tNGNRTZ3Arw5TN606b7DqSjwG4rENfwxL9CNhcnfTfeJDDwpvABvlczlTuDglWGzcrXiPNONAdHs6imBZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157611; c=relaxed/simple;
	bh=pNDadNPE+seJ2P44gQv2hdW3/j+p28gq0S1kxnj0Qlg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=gUVIgeRohmUmjCzdhU870OhkvtX1A9zPDx245ZJ0K1Apzi7RYWBxVGE8E8qIrHcMci+Jtz2vUC1rLzIK0YuxaFzsI20CuqGWx1LMdpxb0H317BKXH7jkW5Pqg3bqb24dXRps9NhxC8x+P67zP7/6ldyoDUgXZzFqO76lfSU7pvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2LUvPLg; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-718065d6364so181010a34.3;
        Wed, 20 Nov 2024 18:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732157609; x=1732762409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NToX9+BNUIk/wvm1hddBf7K2+ouHu2IvaZpJI3Ppy8I=;
        b=U2LUvPLg5PmCvP4hQuHElh5RYDADzN92HlpM7w9bYbb3zX04+SUWv57u23Hy8iz7d+
         8BRXGqSm326IoGzboTA+gwM1kSvmDcUbrpQeP1ujc8A7x+d5yuKE10E37HZbojvq/iA6
         OqSoM412XXeng5CROfemxeWNRcD5eKu0Wol4UGruHIvSUlFl386/GKQtOzT5rARQSVEw
         Ker3BGufg2Q8EZFWeGfsHRWbS1uVth+28XV/XPB0wr6pMfrEy42Q/mvgLrLWgDNDfiwD
         2hPOiubdW6LzqZlbFzLJbxnQnYysMNdBbpTZfJlRX5APfMKaa6AzunWnnoPPq9rE86yc
         Qskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732157609; x=1732762409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NToX9+BNUIk/wvm1hddBf7K2+ouHu2IvaZpJI3Ppy8I=;
        b=MJrSGm7g7aylPU+JXD6URWkyA7+63opldYZlHqD9lNaowYurZmKLbB/Rkf8K86gFE2
         ezmOsukzc/rB69gtYsaVjRa4J4YYgeMTkrOfnEaDitg0tAsPlEr17FEMNfYqV/MIhvuE
         huVRqP85/UzKyFDvUHvA56S9u5CeN2Ou+9+KaZPLVyn1q8KRWYVQ8jG3/O2llD5nc7Q0
         +tLQkImS+zX4sxh318hZS6ktA7mx+plPg2/WTgWkiHCoYljA46WYGtUvEeCmvTH4VnQf
         bqMgkrNGTjMjwPOWl6aokDzNN/OiUblP4W4llwcEsTSeh3ZtkMlwfeWA08USgFsFdX1/
         suZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt9Rfc2qMRZ2emMtYTBMhrjqwfx8dgzy5g0WZVODtKGXDbRYGPI1tlpb6T4rcke0woWvZrOw3F2p5X3bC+@vger.kernel.org, AJvYcCXIqt3Q+a6h/yw15YjVgWfN4uHp6UCXpI5ELTPjZFJphHS3GNAGQoB1tdPIhUpM0f6vZEcT79pfcEae@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+36vRYiuojVO7nfqGPRfaZPOwc7K5WqlWGkXRoamkcIrd6Af
	G6EIrae2wiyakMbXJxWiVOMNnvfx/YHL7RY44Gz7RK3aLITLyJnfHM1vJg==
X-Google-Smtp-Source: AGHT+IFkbEHHx3XfJszzn97ujfOlcNxcTBfxrOx7+9a00uiuu8u3anBb6MDO613kJHYzHthySL2VsQ==
X-Received: by 2002:a05:6830:1512:b0:718:9b8b:429d with SMTP id 46e09a7af769-71ab30c329bmr5065817a34.4.1732157609031;
        Wed, 20 Nov 2024 18:53:29 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e309-7a4e-e779-1177-8427-3602.emome-ip6.hinet.net. [2001:b400:e309:7a4e:e779:1177:8427:3602])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64f5514sm285513a12.34.2024.11.20.18.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 18:53:28 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Thu, 21 Nov 2024 10:53:17 +0800
Message-Id: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

Base on:
https://github.com/openbmc/linux/blob/dev-6.6/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts

Base on:
https://lore.kernel.org/all/14e1a0f581417d4228aea8c2569598d42b4bd334.camel@codeconstruct.com.au/

v1->v2
  - Provide additional details for SGPIO.
  - Add adc128d818 device

v1
  - Patch 0001 - Harma: Revise node name
  - Patch 0002 - Harma: Add retimer device
  - Patch 0003 - Harma: Revise GPIO line name
  - Patch 0004 - Harma: add e1s power monitor
  - Patch 0005 - Harma: fan board io-expande
  - Patch 0006 - Harma: add adc128d818

Peter Yin (6):
  ARM: dts: aspeed: Harma: Revise node name
  ARM: dts: aspeed: Harma: Add retimer device
  ARM: dts: aspeed: Harma: Revise GPIO line name
  ARM: dts: aspeed: Harma: add e1s power monitor
  ARM: dts: aspeed: Harma: fan board io-expander
  ARM: dts: aspeed: Harma: add adc128d818

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 134 ++++++++++++++----
 1 file changed, 110 insertions(+), 24 deletions(-)

-- 
2.25.1


