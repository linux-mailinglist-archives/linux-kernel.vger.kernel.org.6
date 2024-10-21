Return-Path: <linux-kernel+bounces-373802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2992A9A5D01
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927551F2226E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E481E00A1;
	Mon, 21 Oct 2024 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="aZ435by4"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D381DFD8E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495662; cv=none; b=Ezj/bxQyMgt9pFZU8KQsgy0naZY6tf7omCSC0AMN6RjUpoLJl3MElVJ7NED8IGs93SmqYMdiWQC4ers+nkELb8lhEhCOg1AjSVVG5jHtqrqfUhM8JxsBkh/5fs4y6wVehJOy6KzQyvv2u3NHycBcqTEd7ZkKHBCtonV6QFv4pvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495662; c=relaxed/simple;
	bh=03Qb5hxKK7rAKMhBjn9jT6mqUqatJTsr8tb5L6OSVI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=G8hPt4lilsFsFvUikQYwZBJPgJXkEjs3K7w0I60DI13YZrmZulzq6wc9Ur7+gGfLWVUKbC2rWQxMoyNQdUXVLw53Z9FxShnLc7KOISuYwd3ElewLVmA3lKvq4/syShmy0QfnWo0V4IXq56Ou8bKeNz2TCXTybNzchfoboDfgWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=aZ435by4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c804409b0so3839945ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 00:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1729495658; x=1730100458; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XkkT1YK08fvvBnsXdekTj1dlk1F6WdJ88gbC//Uv2Rg=;
        b=aZ435by45LAqLAeDuG6tSbjua6pMzwvX9oGJw1C1nrj2c4rTIBAeYD0OJgU/XxSoyr
         YMoiounZY65YC/7XWzHmzvyn2zq8OljHx1/Go/4/jN/9Iygt2HLlqYVMMtk1d3aq6Pk9
         BGH46n+FrpsnJLyvcaIMGMh+CY6fqb93jr9s/UVN52NFvD8yk/2tGhDVw2s1t2iZBMDk
         QsIAPF8vJ50DVEuxxfV2SU0EST5oIOg54rvixE2+mzn+NapTwoKTvVTGANwWtMFerooJ
         yySZrgp45Mn039Toxv7tEQQ/I/epiaw+61eafXx1jZXK7+lpLuAH3Rz0NPBv/RCZNHX8
         bxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495658; x=1730100458;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkkT1YK08fvvBnsXdekTj1dlk1F6WdJ88gbC//Uv2Rg=;
        b=wnTWZsZYKkQ35jNc2IP3dxtEinYZj276ZHFDzYRj84B/8krz0XcDGMOY8uorGzYJtZ
         80+AIstzu03xa5yylFqAbOZ4dFRzaJMaNsHCTXxIEHPCwkf195iEPkJwKfHyEwCdL07Z
         cjQbhfqKbU62vjDHjrEkyLobSm+fgFFe9VmgQV2wbTup4qt2CCMoulQQzxe4geJUhk2c
         I1xxwJNRACP9rFmAZwehraB+NB+7QaGzwfrviW4LBn3tiL3w0va3HI0FA5HbQZM2BT2O
         p7sCGJb4H52jsCca6+Io9yWEmyfTtTqVFB6bo0cSI2uJFw/g8wycvnn7oqAZJvQhx/Cr
         rxbw==
X-Forwarded-Encrypted: i=1; AJvYcCXqRlq1nUKQyO3Pv1KcjjdYK50v5Du6BPoHpRX3kFYBDWshOs0DvsGIGCcZMFK43GwmBvoVPgCS1Nxepig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3/zVcblkoXpM7wIGvN4ItcAoy+/fdcb3z2QhSg/g2qj7ew0tT
	vzhzJPOYmMQB/0IPecNGdsXic34cO58V755f5o8FWNTeN88bGopIR1xGI8nfzAc=
X-Google-Smtp-Source: AGHT+IEh6/03mZfFhuxBy6xAmriaeuAlOB4siq5+NfULwqzoaaUzBkefycmGSb5S4BiTt/jpYQtLhg==
X-Received: by 2002:a17:902:c44c:b0:20c:df08:9a78 with SMTP id d9443c01a7336-20e5a9ae59cmr57079665ad.13.1729495658258;
        Mon, 21 Oct 2024 00:27:38 -0700 (PDT)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0db2desm19749595ad.203.2024.10.21.00.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:27:38 -0700 (PDT)
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	hsinyi@chromium.org,
	sean.wang@mediatek.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v3 RESEND 3/4] arm64: dts: mediatek: Add exton node for DP bridge
Date: Mon, 21 Oct 2024 15:26:25 +0800
Message-Id: <20241021072626.15102-4-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241021072626.15102-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20241021072626.15102-1-xiazhengqiao@huaqin.corp-partner.google.com>
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


