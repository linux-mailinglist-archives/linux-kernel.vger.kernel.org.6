Return-Path: <linux-kernel+bounces-376874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25209AB6F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61C36B23E91
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54A31C9DFA;
	Tue, 22 Oct 2024 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk4+s0mQ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFED61465A5;
	Tue, 22 Oct 2024 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625763; cv=none; b=GViMMKx6ScHaHRlKxhRJ5Cc4wvLIwSnMRSGNxcYT5CYJi1yLaiLicAmiJP35l9/V1tDo397jOZwpZGdGWTNoIZuBHyVE5W0fNpz4TE5bQAMXu5gBSKdsMQh9Kwjeynk/XQb3GRV8k1JMzkE6vriECpKt69C/86ABnl3A5UeV7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625763; c=relaxed/simple;
	bh=I/WoiMzEECRPe6MXg3HaJw19HDgI/LDm8teB4tvExR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juMNmF8lsv0ad4KoY6EYDd5Q811AurWcD6nuMQcLigrknouvTQofOH7ApZcu5SVtggu5GOUM+tGKFeKhPTAxIWBHsHnYvbpqascB5PqWptUsUTSKGT/x3yaxVGgd6dhATh/y+sMu3Dp/wgQI5OP/80kaMRPk5QP4JojQ3dpzY8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kk4+s0mQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c803787abso1358215ad.0;
        Tue, 22 Oct 2024 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625761; x=1730230561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGUU/iG7YJDkLyArhva5LWM7ySXTw/bZxI0PEkU3+xc=;
        b=Kk4+s0mQQAP6kzreiDJXYwPIsTqCDQqWCzQYog9FeYlEtNBjg8Gd1upg1iq4c2XZEX
         fm2c6LHePIQ1WlSzdseCQZNr+DbdBIhiHOGAjoAQBxyAqhsNAaUfRZU1VLq7fQWYlMKy
         0M/9HJ57s1bc7bMEQbeOZXumII+2//Tx4EzzZmBDQ6UG9dEmph4rIVY3yG33ccd0dlNS
         9m/eudH0IIvXQr1je67eH3lyrBJWM4B6PJYcBj/M3/ebk0knXw2qrLgETvFSz848/IUJ
         d3JowAar1WtgcGpDTyfZb4QAyqJbhA5jWOURbfnP7sB73jeF4kWV+fHzd/FN7nb+ymmA
         Eq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625761; x=1730230561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGUU/iG7YJDkLyArhva5LWM7ySXTw/bZxI0PEkU3+xc=;
        b=VS4MIUyjrkD5SLZqM8ie/IfqqyciKruIWHEzYQGfLux8wyXPZnEj11W1QUS7rfQaQO
         eHwhOtNSWF3S179E353UNubCK+I4dVu5YX9qyKO5ZC65Ggm5kvCCuTWUK+4N1tz+Gkh3
         9nEvUzG0Yn/kLYEoLeH31i3kK9NE2Av0umQHDoL0b4DoAJKtprm0nOK4rjsFlShwQNdg
         BUDfSWBuSLAZgLZdeW1q9BJFu4skKHyW4/NBGk9nVgMBc8xAQlL3wRk5pBvOWFNDFVBL
         3rj74QOuLDCvwANdHj4d2kChmhA3YmgYDj4IwXA6QXnW+aTqGqR9sTcfpRho2/i7blmV
         6CXw==
X-Forwarded-Encrypted: i=1; AJvYcCU0GDULceboZj5hE5SxeeJZhH0QadngsH25SKO2ivJFmjmpThcejTw8hgis7WtaQ5ZkbU8C6BZ8UFBxxfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymvbDDWgkmp4v7jh2j37FfjDSatf3UbDAJAjbC1t/VUaBmgjEp
	7X0NlDlIzZ5dKabXJhI075/3ey8c553Ps1/rmDqPFqoKXB+wVhPh
X-Google-Smtp-Source: AGHT+IF0hH1aKXgSZGmueQFJTPu4by03l1jAsjzPCoRjd1QS9+mDIqVHJuSSKO/3/auin2gHgPWK3w==
X-Received: by 2002:a17:903:1c4:b0:20c:f6c5:7f6c with SMTP id d9443c01a7336-20e9701dd7fmr50654715ad.16.1729625760598;
        Tue, 22 Oct 2024 12:36:00 -0700 (PDT)
Received: from CNSZTL-DEB.lan ([2408:8262:245d:4d65:bc4b:53ff:fead:2725])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeaafb1e0sm5467316a12.3.2024.10.22.12.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 12:36:00 -0700 (PDT)
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
Subject: [PATCH 1/5] arm64: dts: rockchip: fix model name for FriendlyElec NanoPi R3S
Date: Wed, 23 Oct 2024 03:35:26 +0800
Message-ID: <20241022193537.1117919-2-cnsztl@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022193537.1117919-1-cnsztl@gmail.com>
References: <20241022193537.1117919-1-cnsztl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the marketing name for model name, this matches the dt-binding.
Also update the website url in copyright.

Fixes: 50decd493c83 ("arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board")
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts b/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
index a7a55d68dbb6..6bc17f755b79 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
@@ -3,7 +3,7 @@
  * Copyright (c) 2020 Rockchip Electronics Co., Ltd.
  *
  * Copyright (c) 2024 FriendlyElec Computer Tech. Co., Ltd.
- * (http://www.friendlyarm.com)
+ * (http://www.friendlyelec.com)
  *
  * Copyright (c) 2024 Tianling Shen <cnsztl@gmail.com>
  */
@@ -17,7 +17,7 @@
 #include "rk3566.dtsi"
 
 / {
-	model = "FriendlyARM NanoPi R3S";
+	model = "FriendlyElec NanoPi R3S";
 	compatible = "friendlyarm,nanopi-r3s", "rockchip,rk3566";
 
 	aliases {
-- 
2.47.0


