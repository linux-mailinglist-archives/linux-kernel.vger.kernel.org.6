Return-Path: <linux-kernel+bounces-366574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8725D99F743
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3CA1F25082
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4761D189B8A;
	Tue, 15 Oct 2024 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WBlvEpJ4"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B03A1F80A1;
	Tue, 15 Oct 2024 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729020430; cv=none; b=nisGearKYuO7n/kU7TAKCTK7UGOkLR96aNwZUkhrn4Z1O4WSBwnnmXXKh4Ixzm6MCkxD8tGXkDct/+SoDWRYPZdnAFtEv3F92FzCltNBBLyL/UUIYrEv+tOa/MCMvXJV4J/HQFS59WbCRcHsWZlhKTPazXYaeRwi57a8tKXnUQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729020430; c=relaxed/simple;
	bh=T4QxYgvxCjcejnbOwMByRaNGZltIDpS2NRTCBzbkFXE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=em9iCu9i9xNotVDZiUQdPnvutvomqNUa4C3wpcDqoIe0S9+ZsMIx0B2vOYFy1TK9p/kWuC15OkVNfKzRSAFGI5h0N/2FserSdBphiFi7VQ3/vg5B4SdJFD3yHddQnbVQBo8M3wDmna4KLeVWDz/KJMTnBYnSg910uqT3Ib6lgWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WBlvEpJ4; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e8607c2aso3802362e87.3;
        Tue, 15 Oct 2024 12:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1729020427; x=1729625227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ffK46DaQHiPwkYw7K81WBqFGG+/9qPysfgZJJ0kG6Pg=;
        b=WBlvEpJ4VGJq9WlD4I1AMNK7W+r7FuSowpy2+/pTGhMUOAI2/b7f0bus9nelfF342N
         ds464QVl8xn4Atiz9Fs2togJ6qLntbiPrlYGwEkuzogMSDV45AVDflMC6peFefKm5ztN
         dhGdhDTjgL+1+SdxKbqdO7l9WTuS+foikhU71U6mFsa5jvA7+95BUygxJ2p7avdBMCHv
         DJlsN1qe3e1sJz+bK//DY7GSf2C6koL42cCMI0+y15e7iOUCxWQ5TFKgd/C6CmAVA6zC
         vm8FA+OOY1Bp9nnRMuTza+mFqTKHiGRGR9hs9I6/jjyRhLNbsXapA4u1JwKyLc/4IaPh
         6Jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729020427; x=1729625227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffK46DaQHiPwkYw7K81WBqFGG+/9qPysfgZJJ0kG6Pg=;
        b=NzIPjJ2rjCYpWDMFlQILIU718EX2/TCH8ZWktQQwrIbHhiN6v6jeJd92KZSStrlAR1
         XXK+WlfeOTMcdACf4hW4n680Kzh/+A3wzRHLyCNV0DETnU1hnK758XwoaY/TGEJKQB4R
         ibzmrBgUG9unYk2JmS5LRVwI3fmL9WnjEl5m2rdhIndBqqsn6EJLIWajOKHUkp+DfVyB
         SfJTqggBWiP/MJ3Gupp4RLHDfAMiI1/eGwnvGk49GMn8ryFgC3CorJZoCOgMRgWkbKe8
         jxUGBC7mqec0GCB28lx6PjQYl1gH7d6uITxyepK+8wBBPBm0JZughePMrrZoZmsNEg6s
         vGUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpZ90awO/yJo8XxFy86km64b0cN5JZA7azIOwGULsesUNhDhjD8I/aQSBVG3l11Z/R74Mm40bkzkvj5c+p@vger.kernel.org, AJvYcCX18T3NZ5Xx0OSVr1slqol/5kDpEh104ubTxWzOC4ypKEDxAR6IrtFqRzr6wbgYuakXX7rqp/yHDVKk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5r2bwKbJ4+MEGF+IYtxz0EClJIdiNC7B0nh4f7H4uVqkr5qGz
	MD0uXixILInMwc0Gnz7HFzF1H6v6A7lfA50afCZIKfIZskl6afYY
X-Google-Smtp-Source: AGHT+IHcQvdJj7AJdMNiZiGIzyqu6EpciJDknpyuQlSSGl44WJwZ9wJQ8kQZfKW/qnmmRdNVHjgemA==
X-Received: by 2002:a05:6512:1193:b0:539:ee0d:2bb4 with SMTP id 2adb3069b0e04-53a03f77dc1mr1169585e87.45.1729020426770;
        Tue, 15 Oct 2024 12:27:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:1587:1e60:43a9:8917:3db1:25e8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a298443f3sm101324966b.165.2024.10.15.12.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:27:06 -0700 (PDT)
From: Cenk Uluisik <cenk.uluisik@googlemail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
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
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: Add Orange Pi 5b enum to Orange Pi 5 entry
Date: Tue, 15 Oct 2024 21:26:19 +0200
Message-ID: <20241015192650.28648-1-cenk.uluisik@googlemail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This extends the Xunlong Orange Pi 5 device tree binding with an enum for
the Orange Pi 5b, which is implemented before the device tree.

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
2.46.1


