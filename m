Return-Path: <linux-kernel+bounces-373334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F569A5560
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B255E28297A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 17:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD9D194C9D;
	Sun, 20 Oct 2024 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAqIVLHH"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021FF194C83;
	Sun, 20 Oct 2024 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729446000; cv=none; b=o4GaFklx0E0d6AeOs6plSJZkpCKsFnMbP/kQk+iMOvWJchxwm59z9/wW4VLo4lKs4g44JNxPx15aYKe/Kira/OllGCKbuTcE9ViYvc4T7JZ98IUd0Fo/T8TQoRye3mX8syu1PcMxlQ6OaaN+CwXUnvUxFMYhB2WG0KJRyOybeFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729446000; c=relaxed/simple;
	bh=xjGbZSjwyozty4a/+zmFgBEQ/KekPNCfVm81d7HmOHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDT/sG7RAm9ov3DsCUjXAMHinLvWfTUW0rl98EoxXwkuBJBBzV+jejpeCPYLgMJkXgI9bkTPlZi2/+CJRfuBcNnLZ0ok7eY92ZJGcbLoOuQvihOIcVwY2q0Km9kia/AqKANKMXc6DttdyWb8KQPwImAIc/YtvnyXYqHz+FdjcdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAqIVLHH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ca1b6a80aso33318165ad.2;
        Sun, 20 Oct 2024 10:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729445998; x=1730050798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iCzoy58B728Y9YfdMzrfkv1ULrAnawyYFUq7OsuAFiM=;
        b=GAqIVLHH0uomFM+Mh20coflHaUk0XfsQRZ0lnZVHWaBvmOTcZYQuzX++lAmZWwJ/Uf
         ydy1Ht5CSWPh9Kgb7eFop0hCXpef7fp+HPA+7VpLZe5aLonfPcpMQBfqC3zccPowjJsB
         uzzfRRAysCJItUUpl5YBQbTjGp5+UnQn9HvxoaxU8eRy5Qx6pFlVpZGCaoIQgBSpqa1d
         awu3QwRAcf/NN8SEKl0Wn5eMqgKpCkw1mhi1p3CG9mp/ywJESr7qpNTKN325Bimow4nF
         RCEj5kJAcdIpRNoM0j8PlqaMCsAsjJQPxgXIN7ii6YZak7B9qh3gw20KkdKFiToH6h/0
         a+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729445998; x=1730050798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCzoy58B728Y9YfdMzrfkv1ULrAnawyYFUq7OsuAFiM=;
        b=E8dfBtcRpsBe01s+KH60QWdhIOLNjQZkIDCmCCWsOZ7r+rlgFQseHqGr7ACLOPuMAD
         2gDfSvrJ3QtfYWu6pPFce5ENVuFgN1Tn9oOp4nSftA4cVYBYH9/FsPzHyxlSii1fwbA6
         wHkq9zkeoW0+rRyPl5aKSMBlRCYCwtCrWwfRiZnkZGS4s/9AcYDz7Hh2z9PrY4uGS/n8
         JK8QBh0gEMoKA8VlHtI0g5xUQSHSDlRPv8ANp4PfFuQNcrzkiNjWK0pOxYGLFM1HrC+T
         TwANt+GweJF0FhWcgM2hTMh3ZXZbiNkWNDK4M7c1nDCqhoXXFPdFrswj/oPolnRu20Tn
         Pf8g==
X-Forwarded-Encrypted: i=1; AJvYcCUQWq7xrOwJxFq3ewLY4G92examk0Qt3VUOmDig/6lVyotMRWdTA1fG2qR3xttdGuO0vCtOfE2HmagymMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwx4L1ZTAQZ5gOoyEVKkKfuwFF4++bRW6bmn8m3AENLxLIk8FC
	+tOJ/zk8TEYfEqmaESzwVKQUFxH/Mb5P1kMSBQKqPgtneiwrYyD7
X-Google-Smtp-Source: AGHT+IER0PkLEfl8SCgcw7azi7ZIdy0Jj2EnoxnllTknGc7m1H1PEoBmWi3QsD899JLxWGBQOXHY/g==
X-Received: by 2002:a17:903:2287:b0:20c:ab33:f8b8 with SMTP id d9443c01a7336-20e5a76da57mr135652535ad.15.1729445997397;
        Sun, 20 Oct 2024 10:39:57 -0700 (PDT)
Received: from CNSZTL-DEB.lan ([2408:8262:245d:5b64:bc4b:53ff:fead:2725])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee8b94sm12600785ad.4.2024.10.20.10.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 10:39:56 -0700 (PDT)
From: Tianling Shen <cnsztl@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Andy Yan <andyshrk@163.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Tianling Shen <cnsztl@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: Add FriendlyARM NanoPi R3S
Date: Mon, 21 Oct 2024 01:39:45 +0800
Message-ID: <20241020173946.225960-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding for FriendlyARM NanoPi R3S.

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 70bd2e4d1195..862cc2982086 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -244,6 +244,11 @@ properties:
               - friendlyarm,nanopi-r2s-plus
           - const: rockchip,rk3328
 
+      - description: FriendlyElec NanoPi R3S
+        items:
+          - const: friendlyarm,nanopi-r3s
+          - const: rockchip,rk3566
+
       - description: FriendlyElec NanoPi4 series boards
         items:
           - enum:
-- 
2.47.0


