Return-Path: <linux-kernel+bounces-321253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EF8971674
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FC21C22EED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2DF1B86E1;
	Mon,  9 Sep 2024 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EEA3mK3+"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95E71B86C0
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880685; cv=none; b=Z6xMzqzQg0he1RORJjaM472B5GszccLK5kguXKL9I4+cXcRXT26dNQrz9kWWvUWQuFCx5niXsZ2oBKg1pbdV8iARCNCj9jfLrLfuGUqsOoZB0RMrEckWSLMXDls4QguDWNgfv2kiIm3VfdyYZy176QyXATJEQnd8/2FtN8EpbDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880685; c=relaxed/simple;
	bh=pqX/r+DMu5XaHfD3/QRbdq8TiYhqynvHf5Xm5EJpyjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7j5GTs1UquFQ0n7a/McYubYWjyipmXmlCijFq2XkSKtBQc3y8eRCcO8l2YGamm0bMcvQ9VV/HvHlWqW8wrZc4IqJR75jbOy4SQbJ3R3ZNJijreQEAilIQHvHqCaTwNF8T6sLBWi7VlQSG7lyF50zmkwCYbe52N/XYS+ijnbkaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EEA3mK3+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2068acc8a4fso38845925ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 04:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725880683; x=1726485483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUOItIdN4CuqJ3bySYoQipdxuI7Z/Vcroiw20gsxaUE=;
        b=EEA3mK3+LIzdDznfnr6fBztuMQ7iRAgRy3KwCyTQFQSKpqU2SRozTYKYWMRf52ub8k
         TBzw1HB/NFebMwn4wC+Snr546vIVe6N0iP9K4R5tiC7FKGS+EZ18I0hJCTTMmV2SKugJ
         alKvG2XPyQ5C/VLpsEic2muogyJbFtqAQBh9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725880683; x=1726485483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUOItIdN4CuqJ3bySYoQipdxuI7Z/Vcroiw20gsxaUE=;
        b=C5TFGpdJHm+K851h4td9hnAGmWfO4PXLVuHNbjEK8jDfFTYH2OWjzBX0UW9r1JziMG
         QC9CzMVROn1LPJDcTa9wyt6tyc8lCtc0rCOhjvkDWurZacA+9urRBI9CnXZjylSq2Uv2
         79/Wht3ZY3gq8FI9Mly/qAvX9DXhb+NL3szC9nA8mqGvan9XRvbu+CyaHUa9ptnJAhyn
         EaAy9sWhZqMbMcgju3T+wdafmnvbIKi9+mTkttWrqvrJb1h+6/K1hY1H7Q/vBfpg+Oy7
         CJA9ijTKi0hAeloWANW3cD7gUKGreNwekzxk0fngxufZMLIXvHmwbvYAJpK9DGfkdTHs
         eDhg==
X-Forwarded-Encrypted: i=1; AJvYcCVURgH9jlwp1dQQfRV1n+cUDZ9fSFhzDoUtRxdxiGS8PH3DmMcDdgF58pdEE4+QRbq/fiAytxLdpjYv/44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTGXgWTCRPW+lw7pylsm5oUHXzglx4sqt6jA9bimK4oit2fC4A
	DP77j33/1IdTevqtm6l/xmJIwk+b8s3GhZ7v0cSM0+ookeYDBlGUqhfTAbcETg==
X-Google-Smtp-Source: AGHT+IG2C9XNJ4DI2nFoNmA76+SiA1/BQlCYF1MYXDlROT/zJMV16eihIHNxUAdcFdrNF1d3RzLl+w==
X-Received: by 2002:a17:902:d489:b0:206:9399:5dd7 with SMTP id d9443c01a7336-2070701f2dfmr72449825ad.56.1725880683061;
        Mon, 09 Sep 2024 04:18:03 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:6647:6d5f:dd48:8f5c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f1dc55sm32039745ad.186.2024.09.09.04.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 04:18:02 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 06/13] arm64: dts: mediatek: mt8188: Update VPPSYS node name and compatible
Date: Mon,  9 Sep 2024 19:14:19 +0800
Message-ID: <20240909111535.528624-7-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240909111535.528624-1-fshao@chromium.org>
References: <20240909111535.528624-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use and add "syscon" in VPPSYS node names and compatible to fix errors
from `make CHECK_DTBS=y mediatek/mt8188-evb.dtb`.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 2900d78b7ceb..14e51a11f688 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1799,8 +1799,8 @@ mfgcfg: clock-controller@13fbf000 {
 			#clock-cells = <1>;
 		};
 
-		vppsys0: clock-controller@14000000 {
-			compatible = "mediatek,mt8188-vppsys0";
+		vppsys0: syscon@14000000 {
+			compatible = "mediatek,mt8188-vppsys0", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
@@ -1817,8 +1817,8 @@ wpesys_vpp0: clock-controller@14e02000 {
 			#clock-cells = <1>;
 		};
 
-		vppsys1: clock-controller@14f00000 {
-			compatible = "mediatek,mt8188-vppsys1";
+		vppsys1: syscon@14f00000 {
+			compatible = "mediatek,mt8188-vppsys1", "syscon";
 			reg = <0 0x14f00000 0 0x1000>;
 			#clock-cells = <1>;
 		};
-- 
2.46.0.469.g59c65b2a67-goog


