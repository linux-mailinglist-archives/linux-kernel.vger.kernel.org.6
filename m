Return-Path: <linux-kernel+bounces-365774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE7799E9C9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19981C20E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197BF1F9A98;
	Tue, 15 Oct 2024 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="zpI6+yis"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D561F12EF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995194; cv=none; b=fDn0deFGJAGo8+2nBb2q4c9PbmppIkfswdNDSOxTD+uqbHyaxPRn+PPztfvbowbOsP0lpRoYTpZCViyIXuXoZWsrjMYW7KzVdm54yLloo59oH4DAGUJzQYjBhDkeWZN7XtP1t4HT/GPDnpSmi1xtdy7yeFNRfgHtBI3xqgbpWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995194; c=relaxed/simple;
	bh=03Qb5hxKK7rAKMhBjn9jT6mqUqatJTsr8tb5L6OSVI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qU4I0dSZ0Gq50C8l43AEwtZ42KOLrwGhggXDXT2Jy6oFhZCMzzk5OF/WetRbL8wRZH6P5S4TNLViD55wH8PsAz3h5dRttb1MnwoWUklUXuhUq6ERiS4HSjS1Oa0N3okBDpsA1UMRbeUiC0aoL/SAxhF6sMntmc9P85unBrN1pQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=zpI6+yis; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2b720a0bbso1062504a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1728995191; x=1729599991; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XkkT1YK08fvvBnsXdekTj1dlk1F6WdJ88gbC//Uv2Rg=;
        b=zpI6+yisdnnNbqTSacZHVX4xHdp5axZcL55Ekc5ljyliZmwJTBP3TSnwtRZLs6ttxz
         zvrqAcUg7DKg/fQwbx5n1I1uwg4WWLJ5ygojocd2ATJ+jnSYdIluwbeddPBvQh5zhRl4
         Ij+zk4KCbbCJ4/rohVxB6qqg9Mntd1n2irfgHqtMUmVpE9QDjNtRS4gfsfGnuWDrdrRq
         fE8RSWZ1dplg9khtgUU8nib9b1liCvHMO+ep9hAXe9EdkNDasGeDEBLUdYj0C5DCATd9
         5fejKIUsfBjIJucLj4qvBL+5re7MCWMITPLVqKhfzCG0Wy5i36u9nVh6Mmwusl38BGgR
         t4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728995191; x=1729599991;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkkT1YK08fvvBnsXdekTj1dlk1F6WdJ88gbC//Uv2Rg=;
        b=nF2zYEMgwJeG5iz0hxYjVsuEduC7Q2cx2kBNn2rg7MKgdL1RuMOWTDvd4T/zvbaOIG
         G3XUe2Yuij5pw5gi/xgGA78R2GVhNked6fI0rgRAVhKJSlqLoLnI8ol8rzhV5JJ0CsNL
         HI4JfYGfodGzIkFmKtfQ8AL/th1nxPUj7rd2phJIHxJVBxcmqxUAmWYESPnSZ9cj1iGL
         0DEMLvFhhSy2diEPadXgVRcz4sRPsKGEZe+FvFk5ssNHCXn9BxCJgvWe5eATQ2rUO/xX
         QxDlpNX/TBgl7vgYUCqhoP284I1rL3qeHUQ9sT/rCVL9fDnqQOHkpd6m/D9aaL7YcOGu
         oQVA==
X-Forwarded-Encrypted: i=1; AJvYcCXQy6U8+5i6NZDicrb1HQjeCXE4iCohLqN805CR7RKX8IWScthlrCMZY/ShgTpgDJM4JvJcI5rwhvBmuTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAoiF5NePytQPL/y5oe45Fb3hPaZnGWr8FNqTOzqUMq4d+eSV5
	wcYK5aMa+bPOakfaLhOqt3xpMkj2tzP5uLNzGXKQKF7/xAJnDxoDIC82vNOZQPs=
X-Google-Smtp-Source: AGHT+IFvZj2VfZqljCqw3jma49Pp6xcmlucmNJ1sekFJZrx2haRRMxJLdzbrnRlngELlYtE94RuvZw==
X-Received: by 2002:a17:90b:1056:b0:2e2:c423:8e16 with SMTP id 98e67ed59e1d1-2e2f0a2fb66mr7652523a91.1.1728995191585;
        Tue, 15 Oct 2024 05:26:31 -0700 (PDT)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392e8cdc7sm1592844a91.10.2024.10.15.05.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:26:31 -0700 (PDT)
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	hsinyi@chromium.org,
	rafal@milecki.pl,
	macpaul.lin@mediatek.com,
	sean.wang@mediatek.com,
	Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v1 3/3] arm64: dts: mediatek: Add exton node for DP bridge
Date: Tue, 15 Oct 2024 20:26:08 +0800
Message-Id: <20241015122608.24569-4-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241015122608.24569-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20241015122608.24569-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add exton node for DP bridge to make the display work properly.

Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
---
 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
index 682c6ad2574d..943837f20377 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -424,6 +424,7 @@
 		ovdd-supply = <&mt6366_vsim2_reg>;
 		pwr18-supply = <&pp1800_dpbrdg_dx>;
 		reset-gpios = <&pio 177 GPIO_ACTIVE_HIGH>;
+		extcon = <&usbc_extcon>;
 
 		ports {
 			#address-cells = <1>;
@@ -1656,6 +1657,11 @@
 				try-power-role = "source";
 			};
 		};
+
+		usbc_extcon: extcon0 {
+			compatible = "google,extcon-usbc-cros-ec";
+			google,usb-port-id = <0>;
+		};
 	};
 };
 
-- 
2.17.1


