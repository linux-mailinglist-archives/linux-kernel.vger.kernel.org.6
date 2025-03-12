Return-Path: <linux-kernel+bounces-558120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC02BA5E1ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFBD7172639
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7491D9A54;
	Wed, 12 Mar 2025 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYxtqT1n"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934FE15A856;
	Wed, 12 Mar 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741797741; cv=none; b=R/6s+m+3YFM1ncWkwAVKorQ6Jn33Ie7eE7Wn1U5yVQRk0XhRbUuFe/xFrzimyVgx8B7wx7uU56I64vnd5lNyU/UW7VHjGQOZfOlHdTDycMDzBq+jWEb243T+t1jDmsiRfXOZ6/P1CVkZJUjGXYCfCPdRJvmZLOHnlj8J+I3X7N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741797741; c=relaxed/simple;
	bh=OAqVbmUII8u2wdK2eteSkh77IL8VXKjj9jBaL8mcBkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rB8rUA4BPkerK7roqzwAJuDCJvQ5Q2hk6riDq/84cLxIbyqKhezha2b6NLJRJWRUZYS3P3nZAc0oy7ybxBC0/HG2mm1BI25yX68ZrGxiR119eELvVA4I09EA3oEKhP9EzgCQgUEKv0HA/FVX6TbCZBWq/W/mTw4yx/5YTyem2Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYxtqT1n; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2240b4de10eso158735ad.1;
        Wed, 12 Mar 2025 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741797740; x=1742402540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fDo1mOrvYsr1Wor/NfjNciCcvytoLzSX/OlLcDkL+Vk=;
        b=UYxtqT1nauGQUci9u4pyOhEQprs9dzOIpkjwNnmsn4K3oxeJ4CAFsNW4Bu0LJDTMGZ
         btLBJuWghvunaTgWyb75qLnkvWMw5UwyPanbebrNkk3wsXp+ngufqmMLTtqOxyLJsIiq
         gcgrz1Asp3JNedxgJaeJxHxSSLsETvOmvcwBNvL9qG9XulhoZbLZ1CZz4duEP36yUU/i
         CX06w17d9NyeTXR4NIh2Op5PcalrY6pNS6t5+1LKMVlBtHQRIef099QfNhLzrF+kyNW6
         SndidClHM498Nn265cAHuBp23MCcJDpLi1ABWqCDA5QEj1GsMXUl1aq21Dc3ufTbmzh0
         b7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741797740; x=1742402540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDo1mOrvYsr1Wor/NfjNciCcvytoLzSX/OlLcDkL+Vk=;
        b=kuUVA6Arlq/dzQ/vlywHCatxulYvd+sLDru91NdJBf76iJ5+SoVhdfD7/BcF9gVmy9
         a62Gu7G0078waMVKlE6pZbvyVg/8urFAmwcHjqdChQ0cxPIwbNB7FHZbuBXqYyYIV0Pr
         6j6htM1FSjH6EMYbWb/oDjAhUu/RTYkfmzlUotQq2dXthN86Af8l61Gl3R8u1BpVxG+3
         8mCqjhJ0cuIht0Y5k2SrkQj3iIL9j75C3RvdeUBNmWGRgJ/fr+Kf5MxPUu4cNnHd0tHU
         5/iDSNbwsaz6Y7tb2ClcYOwfYhCaylsOBJ3TTRvull+SXic/iH9yQv5flJ2rK+1OcGui
         oDxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDMl4vzZB0uLwqaQwtgp4TGDQEJujCd+Uxc3jlOBUZpZsw2t/I4keqJObGyXBvkztOvSOBubRHBItX@vger.kernel.org, AJvYcCX0dFSf3daJJExHmaQAn+v7O0W5c1K9qwRMJgmnw7eXygsw+4wSyDTaDfUq3ShFYYX4KBZDDle0QojfOPRs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1oLzMKQyuzHy85sBD1oqmRHTSVeQ997SN8LiSRoccP3X/EMsH
	u+4e8W+solabBD62ef+TBpS75dyCRi3d6ggOg65BfyU/kQhF5QfJ
X-Gm-Gg: ASbGncvGq1n50mx4P6QoVLmae8UIxnCRGqeOHkG3XAiNkTBwr8yoBvzjdtXEojFPP5x
	FcJcOBYo6cs1ajPkxlrwTEhprMw/X9u8HIXthmJHFfuXN8KsLkdN6XkrtVobtEY/P1ZswMW8K+Y
	7hv7lKlE96RKLBeRS4zz9kGjAOxAg9FjFAbYELz8oSwmV2TdFe9prm7L4EjrEYbKL67XbcT7X3S
	7FjhY5E0Enr1W6eaQ/XtyYa77eC4xKwFWUsQOmKxEulBGUpakwuhM4ofP4pYhrJfd3EtU/qW5jR
	wsXSP+b6dZUjlpRLzDM5B7HztzSEtF+sBnkqxkpAG/JAhw==
X-Google-Smtp-Source: AGHT+IFm0JEzBi7UsabiIcrQjLIM22yD0b/DK/hkrICcjfxMd5Mxwm9emaajvbKq2S2Z2DtdbFKo3g==
X-Received: by 2002:a17:902:eccc:b0:215:a96d:ec36 with SMTP id d9443c01a7336-2259326cb9bmr44059855ad.5.1741797739771;
        Wed, 12 Mar 2025 09:42:19 -0700 (PDT)
Received: from rock-5b.. ([45.32.55.39])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af28126e281sm11574509a12.47.2025.03.12.09.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 09:42:19 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Enable HDMI audio output for ArmSoM Sige7
Date: Thu, 13 Mar 2025 00:40:49 +0800
Message-ID: <20250312164056.3998224-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HDMI audio is available on the ArmSoM Sige7 HDMI TX port.
Enable it for HDMI0 port.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

 arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts b/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
index 6a0fffaa26ee..0ef8ea76b0a8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
@@ -192,6 +192,10 @@ hdmi0_out_con: endpoint {
 	};
 };
 
+&hdmi0_sound {
+	status = "okay";
+};
+
 &hdptxphy0 {
 	status = "okay";
 };
@@ -290,6 +294,10 @@ i2s0_8ch_p0_0: endpoint {
 	};
 };
 
+&i2s5_8ch {
+	status = "okay";
+};
+
 /* phy1 - right ethernet port */
 &pcie2x1l0 {
 	reset-gpios = <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
-- 
2.43.0


