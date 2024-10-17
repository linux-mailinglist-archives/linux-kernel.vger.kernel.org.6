Return-Path: <linux-kernel+bounces-369091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A5C9A18CD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934A628686F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D944EB50;
	Thu, 17 Oct 2024 02:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvzPf4FM"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D649E762EB;
	Thu, 17 Oct 2024 02:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133566; cv=none; b=QQU9IBwWIVMdMyI6ewMtGoJRe8aqcf91cloP6jPrVGHbmllF2pSfHou1gb8FbbwR3XjxEbph8600k2e7RfD4/mqCiaPA7PHTspnD5GICMhoSzg44ksL0wxp3EhzSVNJicisTTmtTPJhPctKPxeswLuWJ5HjkAhpcNFm+pU8BbIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133566; c=relaxed/simple;
	bh=qJIRvSBgDKJcNAkvSuGTo/M1E39uThZ5hQ720R46XB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T3OWDhQVpfhooMGE5gvMV4tQ7qTNMS2QoUy/VAWHgbW81CQfmXOEHYsLElpudZMNWOGsq6MxWdqqSNAhQqGXJ1m7UrY4G5dA3t9jlRr9qbTp9kxVynRojxqPKMuiQWUTSrURG+8YWXcIQSvinEFm1ubefjY4H6PmLFKg+PUziyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvzPf4FM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2a96b242cso76669a91.3;
        Wed, 16 Oct 2024 19:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729133563; x=1729738363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85QbIQffcxhlYB86XB+l//9U96d/RGIx76nV68ii/DI=;
        b=TvzPf4FMqW5U4Hlnmj1wAljGreryC2zLHYTuCg+AvqNRrR1KQ6aSGoKJiAAKj9uR3B
         Y+lKbOfK8y0whThyyZYar7jj20JrhQS3Ip+a4oUkNMfVaw/V084n+APzzly++wbYVCVG
         yKWTAjJhwFb7YpNBzlEOI4oiFdFZRy6EawBt9vIo0V0+PErg5DeVD3fTBM+rEcyhNTwa
         T1xQVG8TNyTEMqhzOyEx2TPo0MyobIqbCFXldDq53z2gpzUcpsDzzv84h6U1iRnwqEkm
         q7Vasos2U0/ZFpaSnd8u52x7ftX4AT8AVuYtGjzMys/+63Ngwddlfi8v3Sy3brgZZPpy
         Z89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729133563; x=1729738363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85QbIQffcxhlYB86XB+l//9U96d/RGIx76nV68ii/DI=;
        b=AdUgWy4eFo+gZIBVmcb7gYdNFAnbeLSCWc/e/eza5rB/OAiWyXptTwIPOvDhbGbydp
         InFoIyO2KhQFJf4n1jItvhi4X9fkAyuh8nVlkcaL7K76GpLTevRPBNNRkj7t0BytMemd
         pbCDViBhEwLDi24eLGVcvey5t+oPIdKj0O6w/lCS0SSZRCY+WlNld+2sXI5zFDik++S1
         A2EuEwszJXbq5PO7UyRdaK0N0ZmFmHS+Z625R63721ycQTtqWRD9uS0KlIcXLOcQmK4q
         0Tb6n/xesLqs0Uo9FNXlEosOIv3Wkt0gpmHfXbRHuvBskCwfN9G4pmZlpGz467f3gno5
         LgEA==
X-Forwarded-Encrypted: i=1; AJvYcCUnqeYNMgBzUSI++F4Imt9cHtoDuCUciGM3mUNK5rlWdZxriuyz/aiywXJcoJOuXazlx5Iuje/O9TZY@vger.kernel.org, AJvYcCWhvTbPOBM9OvIf6kg7riXS5wJCznxne7r+wgxAAIhu+7TwstlU2GG1Y7oKGb0QXtU0TkkwmkbxMjgeOuzG@vger.kernel.org
X-Gm-Message-State: AOJu0YwABtCmXjSj1ObqylFpZWEa525RuKZlsQwWv35enPfUkiZieLVv
	0Fe5zk8nvevxHm5WIYFrf0nL//wB9Y8XyDEfjXZ/TN83GvfBKZGabgWoFA==
X-Google-Smtp-Source: AGHT+IFawOJeailC2Asgzjpb5jX970qzHmdvlW2PrVbbt7XJMis9ydsbJUn9eiDov4nXvZpPai5NrA==
X-Received: by 2002:a17:90b:3144:b0:2e2:d1c0:758a with SMTP id 98e67ed59e1d1-2e3dc2abb36mr923178a91.8.1729133563258;
        Wed, 16 Oct 2024 19:52:43 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08d8b6esm628537a91.29.2024.10.16.19.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 19:52:42 -0700 (PDT)
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
	Frank Wang <frank.wang@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v2 2/3] dt-bindings: phy: rockchip-usbdp: add rk3576
Date: Thu, 17 Oct 2024 10:52:29 +0800
Message-Id: <20241017025230.28752-2-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241017025230.28752-1-frawang.cn@gmail.com>
References: <20241017025230.28752-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wang <frank.wang@rock-chips.com>

Add compatible for the USBDP phy in the Rockchip RK3576 SoC.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
Changelog:
v2:
 - add Reviewed and Acked tag.

v1:
 - https://patchwork.kernel.org/project/linux-phy/patch/20241014020342.15974-1-frawang.cn@gmail.com/

 Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
index 1f1f8863b80d0..b42f1272903d8 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
@@ -13,6 +13,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - rockchip,rk3576-usbdp-phy
       - rockchip,rk3588-usbdp-phy
 
   reg:
-- 
2.25.1


