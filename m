Return-Path: <linux-kernel+bounces-364555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A8499D611
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9501F247A4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B8A1C82F1;
	Mon, 14 Oct 2024 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jwQYRJBe"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879971C2337;
	Mon, 14 Oct 2024 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929018; cv=none; b=mRT3IGaqQu1M+rs9vEXftywGL9yRgkVYL5oXBYeIU32I0K9PCYQh6URq+McblpU27L9N2ESgm8Oa5Ls0L7d5FS2/5lVYggiKah08fnsKoTlnfAMBQEOqNETKVnzHcbrDDi4AxdznBbQ2G5ZQJdOxm28muwWye3B+KS4N+URaSro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929018; c=relaxed/simple;
	bh=gU/OPFGzRBm7CiKBMvJEgP5zBB3UuvQOn2jKgWZC69g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SPOIWjRbSNwcFM/uHosNgruBetlzf9tfFVijQLUE9vHoDSKP03nj4Q24wMjh8N01D9KY+pNQ4E95Xch1eqiMbQXa/p1nqP/+81/LrU3N9HgiCSm2CWJmTRA/4OXWvnExdbPa5hOLsuTPwGnmooEK2z1Sjti2oRJRkjicM4wt0Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=jwQYRJBe; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so3938225f8f.2;
        Mon, 14 Oct 2024 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1728929015; x=1729533815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ObsYGsWlXukxxjuEIramfBHcuA8P6eCAA0Cj7es+Bc8=;
        b=jwQYRJBeSiqgF5u43IIGyX3HEb2QYNZBBdVDLpB3Kq8CnUf5s92zGz2DYV4F7WlwD7
         2glAa+XdHGTbTXuCCMzUUkcGBPXVyce4Fnr1vVQXKa6VCa+cQjMjZ1Cr4TPllaQv6PUh
         HaCztbZWFa3LDCvuM8OSESgQWyiPugAYq9FYA7gIIZxfAEBLtl/KIq+DSovi7CRiNJzI
         dTqP+kxtMuMqcCNwHDPVc28H2aY/JJ9Q2zmdaC+ATAEJquV2UyIcrziE7S5OU2mwscGS
         AqL96Gb2AqDujISLd5fzgCmCs7+7WULWFiKwndrIpgxFm5V0YZ/mSSsTMB3dRw36Rmlb
         fq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728929015; x=1729533815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObsYGsWlXukxxjuEIramfBHcuA8P6eCAA0Cj7es+Bc8=;
        b=nDUcpUH4buMAVknWmuOsVIhQHNOe/G5sO0NjA/ao1s4AjnYHzLFfElzHqWw8f+QE7x
         DIeqWtlJ5CiOS9VMqXQOw0mMv6082Yxslt+ASqqBE3ilnS3QadHgM6E6gmUx/tXFEeHV
         yJOllS4NVbNHqO67s2tsAH59lLlnqC8ajtZUfWInyK0aEjr0GtEAzxKNA5h7zsVhdOK5
         YztJdpsaHds4NO0ylJKNxW3wkKulWBWWrY+etm26YWNc7CO3burc+/XAHyrHz59rYHD6
         w8diFyfNhugXf2tSxilxCNKz9ZGOf7Grfa+UeVVvQzKxvjpmbIqs9ZgQghu+SRg5c8gx
         m+tA==
X-Forwarded-Encrypted: i=1; AJvYcCVlYohWVhlpg1e4hryhYQL1wLRcOCXxkr50hTz2eRCNZ7SoNRjJ2rFhqKMYHHMKztl2N0KbosFX6QQB@vger.kernel.org, AJvYcCW+jiFyEW64NdM778q+rIfBYTCgitFXGOtp5ZQcNJJaKx5qfk4cwUawnIiWefre2pQPz51VqM0WIemucKX4@vger.kernel.org
X-Gm-Message-State: AOJu0YxpAo6bl6vfPgNlBNBhSAh7WvUxl1w7PZnZ0/taiwmVXQDppj/K
	jIiLgtleuBlErjSiB+88VaV6cSzg3E7wWMGLY+UVwJ71N2w5/2Z6
X-Google-Smtp-Source: AGHT+IH4Uvlv1XC5cawIoHieQSG4T8O20vNS3hdgJD5oeAxhY/X8/3aGSIUN9Nq22CuCLE/Cer7Myg==
X-Received: by 2002:a5d:534b:0:b0:37d:4376:6e1d with SMTP id ffacd0b85a97d-37d600d31ccmr7949074f8f.41.1728929014722;
        Mon, 14 Oct 2024 11:03:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:1587:1e60:bb77:bd6d:6fe3:9eed])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ee412sm11914656f8f.101.2024.10.14.11.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 11:03:34 -0700 (PDT)
From: Cenk Uluisik <cenk.uluisik@googlemail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Jimmy Hon <honyuenkwun@gmail.com>,
	Jing Luo <jing@jing.rocks>,
	Cenk Uluisik <cenk.uluisik@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: arm: rockchip: Add Orange Pi 5b enum to Orange Pi 5 entry
Date: Mon, 14 Oct 2024 20:02:52 +0200
Message-ID: <20241014180324.536702-1-cenk.uluisik@googlemail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This extends the Xunlong Orange Pi 5 device tree binding
with an enum for the Orange Pi 5b, which is implemented
before the device tree.

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


