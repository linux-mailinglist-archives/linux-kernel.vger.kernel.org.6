Return-Path: <linux-kernel+bounces-330908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199E597A5FB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB401C26A89
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0B215B133;
	Mon, 16 Sep 2024 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvgG2epv"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F60B15B0FA;
	Mon, 16 Sep 2024 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726504215; cv=none; b=CMJkJj8LYBZAorudbrkUvpejx3ncPdNHVYZdJfAgbPJHkz0igWSPqCMVTjO/+d0X90Wrb4HgIb08GqlBF4u3POqI8XFV6kWGe27yvRwfWxTDQUl8XBepRPhAuKb+SfsxRC/iIPR3cFi8+TCLAcnKLS1z9fXqnlfhkx1MDiMPNXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726504215; c=relaxed/simple;
	bh=EuytTvgDgOMM78hVNpjfaJDLmg1Z09ncXbEZw2CiDvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mwr/KpbFAczS8Wz3kf4oNPGLXrb1vuo5uqesOmXOL8JOJ4Vu5M2jVxW+GScUB1RidwAbgy3+JagfZf1nb3EVG6rxeUNenUNfR02CMRgOUQTPTbRqfeoI2GEoF6lV0rhSrmJAwP8zM2+kDNBufkj3wOyG3xqZXUwaZzqPWb70MxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvgG2epv; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-536748c7e9aso5524091e87.0;
        Mon, 16 Sep 2024 09:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726504210; x=1727109010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0oGX2cVcDg8n9bBokDIe5AJiMWrG4qmBl/bUEKpKSwQ=;
        b=AvgG2epvaHNqVSsg44HcPoa6bJPKw+wWpTYuJONWqXpeky5Zs+EaCzabbUVqPEq0gk
         dKW76Gdj8emAYRW1Ha4w+Fvbwg7oeSBfmf1FCyi+2Fl9MBEplT3wi2f4uOo5czbBaJIt
         GBGWxzVkROZHdGLgJZMtw+THMDLpmLcxNQf16tI5ZAWolNZtfRlsSUZx2kzNzaMc8xA4
         U8YzYu0sbHAZFk+wDolZZj3YO1Y/y7Ij4Fe7MTa5yDx2xYxuFJczq6VXtyuoczTg/uD0
         XSMFBl202/74cs9YttmvyJKYoZ24FK+O892JUtb1AtJnELQ3c8pIbnz9TxDfUBWY+Kiy
         R+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726504210; x=1727109010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0oGX2cVcDg8n9bBokDIe5AJiMWrG4qmBl/bUEKpKSwQ=;
        b=Hsk5Dfly/4yNSDrxz2uo19+yl+KhY+DEtlxj5pKxHiUskBNh+VXOu/6j3JiBfM0FYO
         N4WLvXWanwWa4Gn58pyCWswpjUZNZaoYUl4kTFclb+6C1Ap7ky0qINiA/5p4TbExP+A8
         BOy00UuAF1bTMa5xoFy62n5T6GGSy4zC85MVXppfQCjzMJZ6c5oMOTMfgTtx7Ulsct5o
         qw9LteVv+wRLzO/lxWRlikWnJWT311p25o7/LFsqPlxOclZQRrH13j95Mh6ntb1y9FpT
         /UDaBsV+yCFdHlS97T9CKnu5YHB4TKXuwMHdErTs0TpHc4n5SEJyvnTwrsGJOUn1rmTS
         Q3/A==
X-Forwarded-Encrypted: i=1; AJvYcCWxMU75KyUoz1+H1D+Lu+hDP+QHKS1MsMhUnyWS/6Z6PrSF55oEGLyZTHP0yf6/imT3zqhbXtDYkCi+tFbq@vger.kernel.org, AJvYcCXxAfNvxFC/kBwZhmDKr2xzxizMk9Dsppfyd5c9wbjsto4FAV5c1TY6CG4ITqrh+AyuU3jrED7K95yi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1inclXhISuaDKnK4FW2vtVbloLhetgszHbdSxEkiLJjirIsCi
	AthK5VLD1XJfMLPdSiFBHMY5x/xNapP2caMkVdoS1BBUw/gic4oT
X-Google-Smtp-Source: AGHT+IHtcJ1YcDrAz2kQKqR5WKY41KEmQUmaGuv89pTxIR7GbvzwLNEv+6RonALiz+sDYt30CX/Rog==
X-Received: by 2002:a05:6512:15a1:b0:52e:999b:7c01 with SMTP id 2adb3069b0e04-53678feb0c0mr7958701e87.48.1726504209925;
        Mon, 16 Sep 2024 09:30:09 -0700 (PDT)
Received: from ALPER-PC.koi-vector.ts.net ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368709656bsm930130e87.171.2024.09.16.09.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 09:30:09 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Pi-Hsun Shih <pihsun@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Fabien Parent <fparent@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jitao Shi <jitao.shi@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Pin-yen Lin <treapking@chromium.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH] arm64: dts: mediatek: mt8183-kukui: Disable DPI display interface
Date: Mon, 16 Sep 2024 19:29:32 +0300
Message-ID: <20240916162956.267340-1-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 009d855a26fd ("arm64: dts: mt8183: add dpi node to mt8183") adds
a device-tree node for the DPI display interface that feeds the external
display pipeline, to enable HDMI support on the Pumpkin board.

However, the external display is not fully described on Chrome devices,
blocked by further work on DP / USB-C muxing graph bindings. This
incomplete description currently breaks internal display at least on the
Cozmo board. The same issue was found and fixed on MT8186 devices with
commit 3079fb09ddac ("arm64: dts: mediatek: mt8186-corsola: Disable DPI
display interface"), but the MT8183 change wasn't merged until then.

Disable the external display interface for the Kukui device family until
the necessary work is done, like in the MT8186 Corsola case.

Fixes: 009d855a26fd ("arm64: dts: mt8183: add dpi node to mt8183")
Link: https://lore.kernel.org/linux-mediatek/20240821042836.2631815-1-wenst@chromium.org/
Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 22924f61ec9e..07ae3c8e897b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -290,6 +290,11 @@ dsi_out: endpoint {
 	};
 };
 
+&dpi0 {
+	/* TODO Re-enable after DP to Type-C port muxing can be described */
+	status = "disabled";
+};
+
 &gic {
 	mediatek,broken-save-restore-fw;
 };

base-commit: 7083504315d64199a329de322fce989e1e10f4f7
-- 
2.45.2


