Return-Path: <linux-kernel+bounces-374210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C97C79A66E2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB6E1C21A19
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08EF1E8830;
	Mon, 21 Oct 2024 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NZSMyBQ5"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4FD1E7C34
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511023; cv=none; b=vBnmVt/tLQToi3A9GgXgeTbRsaMwtuJt6OYopfPw5mOPuzvZcDLpSglxC3A6qCek5Y16ih1wH8cqbZo1ilBtoUMCi6CbuiO1OVd8x3pHHs+awhoRjatjDpz+/v0gr/W3HM8z+BLFyiJU4RlmLdf5/h/j0RJy0xdW02b6JXmitbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511023; c=relaxed/simple;
	bh=9m7nPwGYGatk8PiZOPfski67B+ZXOfLg3qC+0yYbpKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YeG3iWtWHgNUVDwJSN6XuLSqu+emC33aY1mc9L1kIAmJKgzp0bhCPMgN+iqsX2T2gg7cegSJFCwhenNY26tPxa03OlvyU6lkU/g3Nrn1+wetlWOpUSyeuPx4x9AvXDjZCzXnbooWFiDuNZf16OUt51K0vN3UQrRYDphffhoEwTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NZSMyBQ5; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2fb304e7dso3580037a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 04:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729511021; x=1730115821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pFGqW2cFYVEn/q/mCaxZhdSAZg1df4AGxlVE7Nd7m2M=;
        b=NZSMyBQ5RJUTilqzdsgU2p8vQl842APzOwdKD0IFY2SP5WEJYzP3Yw1TKcuMOy+NBL
         Pq9i0nJuvYOP3xKp6So5MkbsmQGehizvYmjutKZtaA/08XHD45nth9uRWIUxfl/ARYdy
         0pooB39HHAqMpxLJMYeiywzWYIc6/C/TeoxoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729511021; x=1730115821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFGqW2cFYVEn/q/mCaxZhdSAZg1df4AGxlVE7Nd7m2M=;
        b=rWDg/oaJzSBvlsE5TaQpyfk8UWr055BBWTX8UmZrWlQHbHvkWlufldxtODodNq1Kd2
         iZqFj9U7W0J13vXAGYtpGWj0CUL3cwXz3u/IYsE2wW1EtWHELKaBNrcsdPAywP0n5nH5
         yk8ihyCHgtlzbdaoZH5I6O4dQASFfYgaUaIiqAoQ3/c4DvxjK/We/OxIsPB/wH23xkYU
         Ci1tWEo715cxXt9Wt/riuYfyO3cM1VBACcF5QhNb0wn02hOgbCPSd4rz+O93CGHjCkEE
         kJXoa0iayO5uLgEdwbgqPAwhskz9wfZ0B+bf1L9aGNooz6mjhetcYawhS1C+M8CDXyML
         KpWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBj9iq3xlqSkkaX9w753wEvqnRRSoKY5R2cRHGxiVqKoWJ8qczd8fEGZMOqgrJy4Mucbcdnf4v6OavZU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpGMG4+rXzfaZK+SGxBXfN9CScOuzvBKpbF0l/tMY1no7kkVeX
	8HXRHCEuTrgw6igoEk+xQZW1fx0rPy+uih0iz8t38gPqhUIpxtWbB/tlHFvrwQ==
X-Google-Smtp-Source: AGHT+IH6P9i9bth3v9J1SxyMP+yL7cKvTFdnB58JeaUhpcK0fnL4b/zRVxwRyWOMVGHEvr9v/WRN+w==
X-Received: by 2002:a17:90a:c590:b0:2e0:d693:7884 with SMTP id 98e67ed59e1d1-2e5616de895mr14134967a91.5.1729511020820;
        Mon, 21 Oct 2024 04:43:40 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:66d2:3298:fcb4:c6c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad366cb8sm3536518a91.20.2024.10.21.04.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 04:43:40 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] arm64: dts: mediatek: mt8195-cherry: Use correct audio codec DAI
Date: Mon, 21 Oct 2024 19:39:33 +0800
Message-ID: <20241021114318.1358681-1-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RT5682i and RT5682s drivers describe two DAIs: AIF1 supports both
playback and capture, while AIF2 supports capture only.

Cherry doesn't specify which DAI to use. Although this doesn't cause
real issues because AIF1 happens to be the first DAI, it should be
corrected:
    codec@1a: #sound-dai-cells: 1 was expected

Update #sound-dai-cells to 1 and adjust DAI link usages accordingly.

Fixes: 87728e3ccf35 ("arm64: dts: mediatek: mt8195-cherry: Specify sound DAI links and routing")
Signed-off-by: Fei Shao <fshao@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 75d56b2d5a3d..2c7b2223ee76 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -438,7 +438,7 @@ audio_codec: codec@1a {
 		/* Realtek RT5682i or RT5682s, sharing the same configuration */
 		reg = <0x1a>;
 		interrupts-extended = <&pio 89 IRQ_TYPE_EDGE_BOTH>;
-		#sound-dai-cells = <0>;
+		#sound-dai-cells = <1>;
 		realtek,jd-src = <1>;
 
 		AVDD-supply = <&mt6359_vio18_ldo_reg>;
@@ -1181,7 +1181,7 @@ hs-playback-dai-link {
 		link-name = "ETDM1_OUT_BE";
 		mediatek,clk-provider = "cpu";
 		codec {
-			sound-dai = <&audio_codec>;
+			sound-dai = <&audio_codec 0>;
 		};
 	};
 
@@ -1189,7 +1189,7 @@ hs-capture-dai-link {
 		link-name = "ETDM2_IN_BE";
 		mediatek,clk-provider = "cpu";
 		codec {
-			sound-dai = <&audio_codec>;
+			sound-dai = <&audio_codec 0>;
 		};
 	};
 
-- 
2.47.0.rc1.288.g06298d1525-goog


