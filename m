Return-Path: <linux-kernel+bounces-363955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 056D299C8EB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C631F22633
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368CE19340F;
	Mon, 14 Oct 2024 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="D21siMqm"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0037919D8B5;
	Mon, 14 Oct 2024 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728905462; cv=none; b=cUnLW8qP+7m0lmCUht2fnd2N11uwFa+E2dkQa2rigB7osBE49osCCXCLBvBqLcCMfRCThQdJfVBKt3nDmu57WROwFvNSiDeiYaDEWskCgJEgY2sGVbAL6BdzDKJyQEd4FQh46zPhrZrY64/S4euK8B1QvpwYQALdCpFtCG+fAQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728905462; c=relaxed/simple;
	bh=vFJR7CTgwXCYeBnb6v8lM1+OwOxZe8sTLWbRiu0w8sA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6A2Ibhl7VIeqKBlV7eJCWh7he7au/Q/GM0rpEiss8C8+iFI9/wfsvDjMMV4bGZmtfHha1UqS6/tmJj2BD9wzfjiGPtRFpcMZnUvCAk2jsr4d7wjX4vweToJGPJ3jUiJpAM4jsYGUMZrPdAFwBVw1GYdqjsFunYT5nAgHeT+ajo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=D21siMqm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d533b5412so1869585f8f.2;
        Mon, 14 Oct 2024 04:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1728905459; x=1729510259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRnQ3wM/yvmN8D3h5wad4fsxQX5Y5/CgF1kTgFuTf9o=;
        b=D21siMqm/yFphBT1Z1vk1g0T5ClBJCHB1dv9msMRRBEQpWjSGbf8DS/jKQ7Dfg0Uee
         4WElz2o9jkSRBOVIQi6oDTQR/claELlusOr5EJ/0dsrk9PxX/Z3T3FLXvjQJzSvQjyzb
         RunbpCY9DiEtM4Ej25bhsr4DbON8CVZRLfnXeMlQM9JjmyhN8pGpRFT+5510AZMVXiVj
         Ok7M1BCcxzt0HEAvbXLK/QYtJIJCNl/2yq6OHjcR+tXEWMuewoIvjhm0inIWukWoE1Wt
         HX+dQ4LYSbMwkb5RRFr5PXryyFSdNr/sGQ2uI0yjs0KnOsUBzoKYpMxlU3FgPH/x3dLj
         my8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728905459; x=1729510259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRnQ3wM/yvmN8D3h5wad4fsxQX5Y5/CgF1kTgFuTf9o=;
        b=FsVSq7tLhB7rktJTD9mHBe3It4n9mweAVWjeoVmBAWPsbdYMtMz2u6WhM1a64MtNc1
         /wKXmkJVKoHIY9hl0fWWlGErlISdolbqKmnTuP22gz85JTvK8xx9n38VxQsxEdQaaTYt
         tYF9poVwXBj8SFImdSUoECMuQOHtlQzyIaZPE3uWPRhnl5bqyWI0PtiEt1oBT5fPcXpf
         TyWKGlhxKcSYNUPi6KOOnZUhW4C5Zd0FYGHHRjzIAqY+4fzCuX/sWh8jowjbtd54dY4X
         Z5nj24L7NLSwa9NcYJARmz76DafL3duz3RTFYdzmn9CNB83dLQcqCLWAJzVCxqRbZiHD
         ik8A==
X-Forwarded-Encrypted: i=1; AJvYcCWPlrWcuuo3Hh/lFwekGdn8P2dOYcaw1+ROmZR+VK8ri+N3LPXuq3VmOy3KotTP//jVHntopZvb2EjQ@vger.kernel.org, AJvYcCX9kdyYbQObjkcXgk4YT5EPDibmnIVm1sGNDnXKi7/MN6dcLxRdMsyXMpQmaLEyZzQLmGH0NkaCrY3nbTC/@vger.kernel.org
X-Gm-Message-State: AOJu0YzLCIZYU+CMfjD9w2kTNM49QQoVQZAKt8k5nBwdU8LBMVIhmFX+
	uov/FErysO65CTN+jo9jG633HckdyiYW7j0/YQalRLhSv2YLq/gH
X-Google-Smtp-Source: AGHT+IF7aGH2KyJ9NX4ZjXM9BC/pvoTRLMioJHryDRhjhIzRaT90GYIXhabR59yNUel9vX73+30ISg==
X-Received: by 2002:a5d:438f:0:b0:37d:4956:b0b4 with SMTP id ffacd0b85a97d-37d5532c4bcmr6869977f8f.59.1728905459134;
        Mon, 14 Oct 2024 04:30:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:1587:1e60:bb77:bd6d:6fe3:9eed])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b9190f7sm11084477f8f.114.2024.10.14.04.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:30:58 -0700 (PDT)
From: Cenk Uluisik <cenk.uluisik@googlemail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Andy Yan <andyshrk@163.com>,
	Tim Lunn <tim@feathertop.org>,
	Jagan Teki <jagan@edgeble.ai>,
	Dragan Simic <dsimic@manjaro.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Jimmy Hon <honyuenkwun@gmail.com>,
	Cenk Uluisik <cenk.uluisik@googlemail.com>,
	Jing Luo <jing@jing.rocks>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] dt-bindings: arm: rockchip: Add Orange Pi 5b enum to Orange Pi 5 entry
Date: Mon, 14 Oct 2024 13:29:56 +0200
Message-ID: <20241014113026.78853-2-cenk.uluisik@googlemail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241014113026.78853-1-cenk.uluisik@googlemail.com>
References: <20241014113026.78853-1-cenk.uluisik@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This extends the Xunlong Orange Pi 5 device tree binding
with an enum for the Orange Pi 5b.

How does this board differ from the original Orange Pi 5?
  - the Orange Pi 5 has a M.2 NVMe M-key PCI 2.0x1
    slot (hooked to combphy0_ps) whereas the Orange Pi 5b uses combphy0_ps
    for the WiFi.
  - The Orange Pi 5 with the M.2 socket has a regulator defined hooked to
    "GPIO0_C5" (i.e. PCIE_PWREN_H) whereas the Orange Pi 5B has GPIO0_C5
    hooked to BT_WAKE_HOST.
  - builtin eMMC storage
  - no SPI NOR flash (u-boot, preboot etc. initiates
      from within the eMMC
      storage)
  - ap6275p Wifi module (like the Orange Pi 5 Plus)
  - builtin BlueTooth module

Signed-off-by: Cenk Uluisik <cenk.uluisik@googlemail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 687823e58c22..62bb6587da8f 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -1051,7 +1051,9 @@ properties:
 
       - description: Xunlong Orange Pi 5
         items:
-          - const: xunlong,orangepi-5
+          - enum:
+              - xunlong,orangepi-5
+              - xunlong,orangepi-5b
           - const: rockchip,rk3588s
 
       - description: Zkmagic A95X Z2
-- 
2.46.0


