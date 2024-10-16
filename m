Return-Path: <linux-kernel+bounces-367122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F4499FEDD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524741F25FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D51C15C139;
	Wed, 16 Oct 2024 02:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ2qxiTB"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8996D41C7F;
	Wed, 16 Oct 2024 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729046143; cv=none; b=gd+76nkng+n2FYOYjv7Df2kHcToRBQ0AoY95posQgQwSHuZZlpmvqHFNZAyJnmEO+4uUOtP2c0HveRdKfkurc3xV3BPv+0axv8DUdWHPJaSO9YtKgNUHHx2Xs1EewjXO+/Aa5fygcYTwr+euXNLL7VKQhZoOE30jn2pdJITllZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729046143; c=relaxed/simple;
	bh=mH2oKUJ9FTxJ7+DmgF1bKX4kxfCE2Dn/qbUNRUyq5VI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yv0/4UV+cvcEInydmMEKv3znCEnvJpRHQt4kp+/t4Nek2byswDOlYQkqW3ZcRLJEGOCafWpwY91r/aoy2EIOq7PAej/g7raa2xCiS6zUITUbfMbszxUtkoiIBl+LA3+q0ENoz+tM71BFW7H7aePQjxmVqBp2s4MiZQjDoYvw4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJ2qxiTB; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e5f526645so112279b3a.2;
        Tue, 15 Oct 2024 19:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729046142; x=1729650942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tnt5DpGHzegrynfkadyD2B5UMZRREmWTkNZg6fg83aQ=;
        b=OJ2qxiTBlOuoNjg62QczxUrm0b/ZSRiA3CduWgTU0bf6yRzBE5gER17ShKlmdkJaDP
         HflG0NIAHcTNm6/qFMw/ekk5aJ7dhRUyNJWfZC0bDnGJFDN196lF1m9cUSH7f7gnV+e7
         bx0Xfq4nIfm7ouwY0utCGlAKtlmuzOWnphVKxJJZQvFuh8PplKsxfyZmNRPutfKhWTQQ
         G02CcpNOQXrQ68T6bXPRe4yNllN3PChV0d0C7CHfx5/99j+N18TJF9YMxx1kn/py9dvo
         DMC1PJ/ZbkOXHYvzkutYIsr0r9ywSgFr8LABPC511dh5r9OcyPjOvWqoiHa7v0QHcd+X
         3/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729046142; x=1729650942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tnt5DpGHzegrynfkadyD2B5UMZRREmWTkNZg6fg83aQ=;
        b=FwET8mfIueSCrJjV/I5XYU6VfGhCl3NPDQWbRCXsVnXgOKH9umQLH0winNp/GPuSBt
         SvhMlIhktXVLls4KZnVIHNo6F/SzM3s0kt4Onu5RtQmu1mz+ngNyOKnbXHx3syE1FUcp
         TZx9Aq49XkfxGW3epnnoc7dRs/Tundxf7pmes+2oEeFwhC+nkTib7sZe9ptr2QLyhtvC
         bSVmJ2BxU/jIM7P9/9DdjH6WKWEIuwRT3e9h1xoE5u8zBzAE9MzvtbpvXlr2IU7NV/iC
         SqJ3kOr62vIYAMdiGyCCl6L5xbpndsUF9uK/a5VbZB+E3epjUDz4grWuAjRxX9RfJdtV
         KufQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXACmN+7iQRREA0pYSdoTlnkbP6EOiPWqNQvtRO+ZPogiXEOmj6PTNnv15N+twQzq1FrZMYaxazoO/@vger.kernel.org, AJvYcCXbesjyhjUK7dI8YeiY0YQUULqdZ379bQ0MXPVTQuPBZ5KFrb85VUbMJ7hGXoyPZTjIiFfwtiN0JMvrD/zT@vger.kernel.org
X-Gm-Message-State: AOJu0YwLxfWKd5E6h70XiTLBuTtioohy+u8VF/OkNUL3wRQe2Ek7dy8x
	/wiB75iqn9hodbqThJu8gNPY9+QwFvL6B8/E69MdKdR0xyi2CIS6pFC6WQ==
X-Google-Smtp-Source: AGHT+IFPA2+Q8qPUGLhCU45KSlCy5f4LjPJeH+FKGYtHQrxltaoOTrgJVlSFnWk9ugDrUn2wtSppLQ==
X-Received: by 2002:a05:6a00:6f12:b0:71e:596a:a392 with SMTP id d2e1a72fcca58-71e596aa3e0mr6809808b3a.2.1729046141498;
        Tue, 15 Oct 2024 19:35:41 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c70587asm2192920a12.72.2024.10.15.19.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 19:35:41 -0700 (PDT)
From: Frank Wang <frawang.cn@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	william.wu@rock-chips.com,
	tim.chen@rock-chips.com,
	Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH v2 1/2] dt-bindings: phy: rockchip: add rk3576 compatible
Date: Wed, 16 Oct 2024 10:35:32 +0800
Message-Id: <20241016023533.12018-1-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wang <frank.wang@rock-chips.com>

Adds the compatible line to support RK3576 SoC.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
Changelog:
v2:
 - add Reviewed and Acked tag.

v1:
 - https://patchwork.kernel.org/project/linux-phy/patch/20241015013351.4884-1-frawang.cn@gmail.com/

 .../devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
index d3cd7997879f7..1b3de6678c087 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     enum:
       - rockchip,rk3568-naneng-combphy
+      - rockchip,rk3576-naneng-combphy
       - rockchip,rk3588-naneng-combphy
 
   reg:
-- 
2.25.1


