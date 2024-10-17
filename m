Return-Path: <linux-kernel+bounces-369090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81249A18CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF1D1F22617
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A420B58ACE;
	Thu, 17 Oct 2024 02:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Svi4T/zJ"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4031F1805E;
	Thu, 17 Oct 2024 02:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133562; cv=none; b=RnXX9wYPJRt93XmgB785xAfj8k4LC1P519onnYuk60NP9M4xjPHBazmSLWG+gZp+LZ/H3xzFMPEu4VJyXiTWjkvyNtW8IwJN/9uk/lP7vOfyKk9jEAuc9nDxI0Oz9gycu5qPdEQrGGN1cQuVF050TmtEIYCoV3mFH3t7muULjzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133562; c=relaxed/simple;
	bh=YeJsNoHDNgrGGZdatAqIveQuwNOffoXVjT48thayfgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qEp+6b+1ZO+qbsBrcpa9nc9jH32l3bsd3KtIppRR90+vTfbZ2a/T+CvL76b4Go8u6p8p4DUvkaoliSz+o4BGihOVu9+uUGsnxLp9SE+hpp16pGKdlLZSupu4+AWp60weaprByySnqNdAINq4VjwlZlVIHtVoseAlMmaJQqQLmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Svi4T/zJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e2d83f15f3so78902a91.0;
        Wed, 16 Oct 2024 19:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729133558; x=1729738358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=anEJomHrsRlwp4bT7Y/2bAO0FBPIolgYlKqfNbjU7Sw=;
        b=Svi4T/zJWMVlDbJs8SiZOz5nRXV5vOe9UJDSbpFPysMbIVCZX0GMKBaUwspVOjWGIt
         i2BjQSzABK9MTQpX1FqnmFGb6hAlJUXbuBn+SORg1KmqeBDbbdE5rr7o82/8j4meI7Aj
         SQXB4Yyi8TX7muAUfbLEQIMjt4Q/5IB6iMxOgHZVYEbfl7mbKB8rA9PWrRYQw6Es9tgn
         IVzqbnqzgNktQk1VVJCdOolRYzT5JVUr4EpuSfxCg1OYv3mRKwGrke2enQlCmpx8iLFE
         +7eyIdJmvER9XoJVdvHzdgXYEvgLQ3mWoWAKG5WAUsdEPTnkpOm159onnROJf/7IBJJK
         UbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729133558; x=1729738358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=anEJomHrsRlwp4bT7Y/2bAO0FBPIolgYlKqfNbjU7Sw=;
        b=n3vRCRx5RS4anw3TAYUpZj10YQyT2MTa71uCNXykfwTvVZoaYRZhOcHLxpX+b59Sml
         gIkmugORNxgAGFvX9gFBeFOQZrgDBzwxTbBf7Afwpo2ZuuOL9IoIMsHfgE6M1wq/TB5M
         BYQKDppworJIpWcuFxUHbANS1jMZAOnDu9hk1kV8RBtD9nH84k6pLKx1iW+Y0VJUDZyO
         ZBH2xxWUn0Y1DEdM+95Q8NrR/LAdymQMmJVfdwPSOzY+vocI0LoSdXe+Z8XUmTu1MzCG
         36yua/7s7HMA+DuqNGVTEmtHXWFp/FPRDE/dbZkZ/R8/GWuI9bxqxiUEZu/OEDdau7XJ
         DVlA==
X-Forwarded-Encrypted: i=1; AJvYcCUR/GnZibKVTgO4oyBzi5pE9hb5EZ7pNGTArubBPCBkIBTkbNpLPG9MRWQFZqTAjn6uurxnA+nEERFCGwL8@vger.kernel.org, AJvYcCVdKCfeW8d/4uTOaq+gSLAN3mMHAqrSlKoQyCeaN/+BmquFPeTNICyBXbJvxVak+YROUNOx9toySkqF@vger.kernel.org
X-Gm-Message-State: AOJu0YzYiJj1XBVtLjEaR2WdqRXA1ecHrU9i4Uv27E2iGcbbZQ4E8EyS
	11pcROsPDM3QYVc7Xp6Itw/WKb/QFysCDiziF1p5OqmJ+8Z7+pVmx/jKdA==
X-Google-Smtp-Source: AGHT+IGzn1MbFJSDxZL13wExxR6YzH79TcUSYhLQOHgaB/BQ6FXcMXvtdf5p7sXpTbHEEivTkILiNA==
X-Received: by 2002:a17:903:228d:b0:20b:99cd:c27e with SMTP id d9443c01a7336-20d47ea03cfmr8564085ad.3.1729133558431;
        Wed, 16 Oct 2024 19:52:38 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08d8b6esm628537a91.29.2024.10.16.19.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 19:52:38 -0700 (PDT)
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
	yubing.zhang@rock-chips.com,
	Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH v2 1/3] dt-bindings: soc: rockchip: add rk3576 vo1-grf syscon
Date: Thu, 17 Oct 2024 10:52:28 +0800
Message-Id: <20241017025230.28752-1-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wang <frank.wang@rock-chips.com>

Add rockchip,rk3576-vo1-grf syscon compatible, the vo1-grf is
configured in usbdp phy driver.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
Changelog:
v2:
 - This is a new patch adds rk3576-vo1-grf syscon.

v1:
 - none

 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 50d727f4b76c6..fd42217ab85e7 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -33,6 +33,7 @@ properties:
               - rockchip,rk3576-usb-grf
               - rockchip,rk3576-usbdpphy-grf
               - rockchip,rk3576-vo0-grf
+              - rockchip,rk3576-vo1-grf
               - rockchip,rk3576-vop-grf
               - rockchip,rk3588-bigcore0-grf
               - rockchip,rk3588-bigcore1-grf
@@ -283,6 +284,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - rockchip,rk3576-vo1-grf
               - rockchip,rk3588-vo-grf
               - rockchip,rk3588-vo0-grf
               - rockchip,rk3588-vo1-grf
-- 
2.25.1


