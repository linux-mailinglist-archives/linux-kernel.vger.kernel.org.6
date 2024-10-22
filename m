Return-Path: <linux-kernel+bounces-376879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 550719AB702
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6D8280F17
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219041CCB58;
	Tue, 22 Oct 2024 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+TOhRgt"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423261CB506;
	Tue, 22 Oct 2024 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625790; cv=none; b=DBwJLY62Jj42iRxLlJJfn2ITTGIdRfdTMkRgMdKdDup2Z5ELQegIIra+kDLPVZPcFzVb8DEwmiHfY+bO5HRBv0TumwErJr0xgORP3VBZ5c/5IkmsUDI+DcjLZL/ojRP/iv6LEiITXAqVVFXPX/XxM4LgxhXS8agFQXRo2/zOE+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625790; c=relaxed/simple;
	bh=C/+2SgXeYmcIKn77+1YOSb6RNVx9TrqkO66oZtCdJNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScKXb6WjFENk2jeK53H1pfgqwlPOZO4QwdqSEz/S+j+vlBTQzlLSBweZNfklD+KY6qM6vIyCJ+wNAVLEQ0gxnUNJQLrHGIGTp1KwHgtv3g13YlqkEzYpae5pnHsBD/dp5ejdTiSXsANKhAep9DZ8IfVJC3ax6kQKU/Y8zhibAFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+TOhRgt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cf3e36a76so58871565ad.0;
        Tue, 22 Oct 2024 12:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625788; x=1730230588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8wiRg5W1PtOs1HUIUCqVFmtQqvRNw6+deonhikANW0=;
        b=W+TOhRgt9qVlX/7mawsqsURj+YvGFJsxp9CmYNrWdyLffslSgT/PFe+0/WK9+HHsKc
         eVAvhxSUb2DY+jgoZLKOaR9FBtWe8aK+stUJnrUjuUv1Jd4+3MV5mcpRc6QGwPA+wRYO
         t3NbCtU9lu8UUFsuZaHW2A7UjieFfjwuEWLa2Rj6+Pm2F/GVDgajZTdGv+PwJDGHFZyx
         aSyI684wQeII9qQjXFaT6ywMOChzerQptNKn3flMgMEwTKFmNO2h28GsSFGbcAw0E/gQ
         eGNgwTVuMQ9Z9Uq+c/XMK/mLX++VIz/NPv2VoXMNVJkm8Q+jjAUkUFDfZo7Zn6QD3HGg
         UHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625788; x=1730230588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8wiRg5W1PtOs1HUIUCqVFmtQqvRNw6+deonhikANW0=;
        b=ZI3i6UYrn6W+0YBpWPW8m2s1LTPM1U9gssS5WO0i3PfvxPEU5KPs2gUGlnSU36Yrth
         LU9H5+JIZt/DOv94CJ8/rm6dD7mrV2S5wSfNm9kgmfsmakY5SpUN0+ZKZ/GF8BhtlfMg
         dzMemDI4DT8k4CnnGUCRVFfmMD2OjGWGKhfyRCEZQ84J9TlGFstU/ZHs0Iignx9vHmz6
         yJ62WxaL6fvgkzc/HARhgi18qNjkaQL7ZJU2E540FTcqRMgriEBTuDlpPRp9MlG7QVjO
         Xi0vdyoAAzk0J4C8xxlNcovO3W8hNe7R317Aiu/bjwIze8nItC92b2THkbHZXUIv11g5
         OAXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXFFgfyg9PJhGWD1HyuLCNCdlPRvyesNCf7iN1P8mlpZCqOjdHGonybKn0HH8TN7W1pXzVS6OJty7BVJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF0OU5vtwmZSKwogoVFDPyEtSRM64WAbutmbUXT6G2Loeldytj
	Uh/dFrx26VTNeCtS/iuF7UXoN/phPJq5VnAlrhxlYll7mtZDUxp7
X-Google-Smtp-Source: AGHT+IHcM9OVE8m7QLGtMQFh/XvemYftK7Dm2+Nn3KopFxQ5Dvr2Qu3K/wfO5X/iP72Xd1Y56zAfYA==
X-Received: by 2002:a05:6a21:1798:b0:1d2:e888:3a8e with SMTP id adf61e73a8af0-1d978b1b03cmr128873637.18.1729625787998;
        Tue, 22 Oct 2024 12:36:27 -0700 (PDT)
Received: from CNSZTL-DEB.lan ([2408:8262:245d:4d65:bc4b:53ff:fead:2725])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeaafb1e0sm5467316a12.3.2024.10.22.12.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 12:36:27 -0700 (PDT)
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
Subject: [PATCH 5/5] arm64: dts: rockchip: reorder mmc aliases for NanoPi R3S
Date: Wed, 23 Oct 2024 03:35:30 +0800
Message-ID: <20241022193537.1117919-6-cnsztl@gmail.com>
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

Typically any non-removable storage (emmc) is listed before removable
storage (sd-card) options. Also U-Boot will try to override and use
mmc0=sdhci and mmc1=sdmmc0 for all rk356x boards.

Fixes: 50decd493c83 ("arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board")
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts b/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
index 03a2f90f6217..fb1f65c86883 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-nanopi-r3s.dts
@@ -22,8 +22,8 @@ / {
 
 	aliases {
 		ethernet0 = &gmac1;
-		mmc0 = &sdmmc0;
-		mmc1 = &sdhci;
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc0;
 	};
 
 	chosen: chosen {
-- 
2.47.0


