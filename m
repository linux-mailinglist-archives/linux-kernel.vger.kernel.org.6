Return-Path: <linux-kernel+bounces-252265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED299310BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 168FDB2356B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D275187542;
	Mon, 15 Jul 2024 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7K882P0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA85185E65;
	Mon, 15 Jul 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033961; cv=none; b=bcwoA79WqLoaPHwsn3h8VP6EgazVNaY8jf122wUZbpxYCR4hcU+WN/86u4oRAbTFcPJ4iBt/xf3AU3p0sIpqJ1nlPEPL9slyfNxHc2nmsJ8EsC6YarN8j5mX6LibzesTDAC6VprlFAGlN4NuNd6UkGABZwIWJ8CU0YkfdsJBso0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033961; c=relaxed/simple;
	bh=/O2nGpJcr16vRLvgrd+SZjmwJdnjJPrOC4NvECf8nUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bbcv8oCJGgMOszZEmGCNUPGWC91QhJNgymJln/tSe0DHGDNq+GNqZd+IZg+1NH/uTl5zTQyRmJ/9F02ozEcanitNfGHCgkNg5D0rEd/3JsM1eEs3ApeAj5eHzyd61rAGPJqOSe5el0uc1FD+A1QzEfPrqqoidwTy1yS/wh+Q2sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7K882P0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69E20C4AF11;
	Mon, 15 Jul 2024 08:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721033961;
	bh=/O2nGpJcr16vRLvgrd+SZjmwJdnjJPrOC4NvECf8nUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=M7K882P06PDKXe+45ygDPWh29IXz4bfMKePRHgQV96VoAKoURRRL5g7FFDqRsK0RT
	 srLZotmoUl87ghOID2fgY2+QRlEOvcBbVZ0Ztu/KCowolQvZGvdD+9SKimthH70BwU
	 RYXwdeOFtTKUliJ7uS9V3qpktrd+FcbQM4PmZ2Iyz4JkTc4wUKLw46GACUpRBqCh6+
	 yX10QLeFpP4YINPa2+ztk7pP5oM7NRRdBH7Lna1uv9wR6wN1EgYaMyeE7HgKcaEXUF
	 nhoFiBtHnJjI0RkMq9DYTwyHKSyQ8ZBFWbc2C6dk6Z2HcFHb15d1Q6I6Ojjuhf4MpY
	 ynQRBo9KXD44g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D4DC3DA59;
	Mon, 15 Jul 2024 08:59:21 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 15 Jul 2024 16:59:20 +0800
Subject: [PATCH v2 2/6] soc: amlogic: meson-gx-socinfo: add new SoCs id
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-soc_info-v2-2-3836c8cc27a5@amlogic.com>
References: <20240715-soc_info-v2-0-3836c8cc27a5@amlogic.com>
In-Reply-To: <20240715-soc_info-v2-0-3836c8cc27a5@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721033959; l=1182;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=zRWWsMnyYjBcl83+I2nHF9NZDOoGs2C4FOAOFivyI1k=;
 b=smDNFXgxoSeiIF54/TDERqvLgFVop9bAHAJkTpYw3WsTuikbc3zfL7BHtc/ebZfXE/Yej69VT
 1fK7rlvbx2XAqApVBpLw7a1nHoxW812k77RvHQ7MjowYUVxKU/4tmCF
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add new definition for Amlogi SoCs, include S4, C3, T7, A4, A5.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index 8809a948201a..7549f1644e5e 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -41,6 +41,11 @@ static const struct meson_gx_soc_id {
 	{ "G12B", 0x29 },
 	{ "SM1", 0x2b },
 	{ "A1", 0x2c },
+	{ "T7", 0x36 },
+	{ "S4", 0x37 },
+	{ "A5", 0x3c },
+	{ "C3", 0x3d },
+	{ "A4", 0x40 },
 };
 
 static const struct meson_gx_package_id {
@@ -76,6 +81,11 @@ static const struct meson_gx_package_id {
 	{ "S905X3", 0x2b, 0x10, 0x3f },
 	{ "S905D3", 0x2b, 0x30, 0x3f },
 	{ "A113L", 0x2c, 0x0, 0xf8 },
+	{ "S805X2", 0x37, 0x2, 0xf },
+	{ "C308L", 0x3d, 0x1, 0xf },
+	{ "A311D2", 0x36, 0x1, 0xf },
+	{ "A113X2", 0x3c, 0x1, 0xf },
+	{ "A113L2", 0x40, 0x1, 0xf },
 };
 
 static inline unsigned int socinfo_to_major(u32 socinfo)

-- 
2.37.1



