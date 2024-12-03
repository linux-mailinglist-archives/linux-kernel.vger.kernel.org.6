Return-Path: <linux-kernel+bounces-430363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FA69E2FF0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E427D283473
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF61F205AD5;
	Tue,  3 Dec 2024 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyQrCnB2"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89801DD0FF;
	Tue,  3 Dec 2024 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268996; cv=none; b=T/LnYBI+hJx4myPxlH7pm76KX+BIHMCz4jA0Cd9RcQmQkIvF7e1L8qLwcd/UoGFhwZVYAJ9UiJC22I7omDRZHGZnzXl2EsAchmRPUu7I/pd1tHVqlkmJN4pSZf0pYiQYZaAchBbjrvv7okEXFVPVzCG4zf+nKeWlYG4kKNMzAsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268996; c=relaxed/simple;
	bh=O9DB98ly00EVi5jqCLscYDWCYJVerIKnNbLNJ0XJlv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KuLTnIB63aEjfSkWTaGJUpU3H4SmQPoot2Z58Ktl4AaFNpVwdumZpzMcY+IWekwbDnXHz/6xVy1zMrVtTXwRVh9zZyGzQsW8oVMB6unHi5UaECwHyBbiaOlVweTxpJZ3uoM2cJ8DX/UXkUQw7/6gPNMwLhbqNDYmlBWUQc0WnGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyQrCnB2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2156e078563so27201845ad.2;
        Tue, 03 Dec 2024 15:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733268994; x=1733873794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pc5TgHTZwt6LxhA2uVCI7tpp7Tqag/4j85Yn1WwfR0E=;
        b=DyQrCnB2AQ+TvYI2QxiatN6TQxs1y1F3Zhbr9z8IOGwsVXWVug3oUm4pXSEpf76D0x
         We+RSOo2Of7emjtiqSGkoxCKSpZW9oK9g/vVyW4rJACSIQmW2NPMBZrzxx56ivSUz1JW
         /8VgfX9JX/WWv77LeO0oog/0RiYocQvPPerLFJYerG61pOd8/uBt7dgv+DFRv5cayX/8
         nMbpxNloqNI1/gGJmV6nZs9e72h8s5cwptb6f1UAkHUDmq4DVSmum9QuD23eXJt1zZvT
         +s8gu/3gU7fKVBBehES7h/HrT+KfdbpHVmdjdS1TbejaSXCzYZ7SKYQ0Fj+rT6h1+lEd
         S43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733268994; x=1733873794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pc5TgHTZwt6LxhA2uVCI7tpp7Tqag/4j85Yn1WwfR0E=;
        b=Ti8WOQOVU0o5AfWWj6bRzMAMmWAZmEK3BySH3pBLPKt3AzRg1Oa8fhKJn8QvQxQRUI
         BX1rQYKM02vsPVglHnfRYOgjT42yVUWdi3lIJQNjqLpzmvMWRMCCTtOqK5OQh05O30zm
         kdhexzh5+97ulV94awMgHJtUBeYNKCEJJ4lpRLXcMiIhsBWAk1gbiAszq/9iBWpa5k4X
         FWhKzULTTl7E5tZqZ2qa7MfRwZitpxBX0+fuRrJLBoOUrFlyue2hrcYIyXe9eG70Xa7L
         3GcEbmOKYk4UwsubSgoMlQlpD+n65TedX5Z3HxqTzNH/fPmDfwb1p1Vt/ZCOJo6LQQ7U
         PgbA==
X-Forwarded-Encrypted: i=1; AJvYcCU28PgmqWsnNSVQ76K85Y9H4O3uOwcQCnnzEdNleddxbU2iQLmY6pi92DM65HSgEkzSZj1sk9MpaCZl@vger.kernel.org, AJvYcCXkd8bX+mlaLr7uSMV5PIB+Kx9xdHpIExxSynE6PS2yl6BZNE7rUjsG678MOOlttN971kXXdv8kMYCpo4MH@vger.kernel.org
X-Gm-Message-State: AOJu0YyWiPaJ12F6SVzVCDgt3/1mJEEU2CMoiTPwYOOgN+pJaJF2S1bH
	CUOsX5zINZTYcktaXnCN5cXlEcENtdHBI+VqRF3WKdFrocS7uOKo
X-Gm-Gg: ASbGnctjj0y5QiXa4jKJlVGKWewKuzxfbM+JZNvPEqmlE8HU6dLidMC8J4Ni1FWfINt
	i5baMsqqAl/gtQ8uEx/eMNxdenywif9KWiwLLhqA2HWHC/3ZdXX0m+1r3jFxTinRMQ+tgtdwxqD
	5XQqjpOtvEjlCE3aH7cV09ABWojEood3W3IXr/7LqIYjeXTh8qnVgL/zLPrAlcciCmvdbBymL7s
	JJUxTU8yQSRC0Mhwjrxv0r9XQ==
X-Google-Smtp-Source: AGHT+IHf1rNluLIVYS/a49eRccOObI5iM0YG6/dTrhTZp7oNxYqcMIrUbYetBc5idn9jC/IMI8gNOg==
X-Received: by 2002:a17:902:dac5:b0:215:772c:fa6b with SMTP id d9443c01a7336-215bd241a4amr48023815ad.40.1733268994177;
        Tue, 03 Dec 2024 15:36:34 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215964b6b76sm40401725ad.191.2024.12.03.15.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 15:36:33 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: bcm4908: nvmem-layout conversion
Date: Tue,  3 Dec 2024 15:36:32 -0800
Message-ID: <20241203233632.184861-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvmem-layout is a more flexible replacement for nvmem-cells.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts   | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts
index 999d93730240..a5f9ec92bd5e 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts
@@ -144,16 +144,20 @@ partitions {
 		#size-cells = <1>;
 
 		partition@0 {
-			compatible = "nvmem-cells";
 			label = "cferom";
 			reg = <0x0 0x100000>;
-
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x0 0x100000>;
 
-			base_mac_addr: mac@106a0 {
-				reg = <0x106a0 0x6>;
+			nvmem-layout {
+				compatible = "fixed-layout";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				base_mac_addr: mac@106a0 {
+					reg = <0x106a0 0x6>;
+				};
 			};
 		};
 
-- 
2.47.0


