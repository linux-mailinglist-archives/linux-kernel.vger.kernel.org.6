Return-Path: <linux-kernel+bounces-338416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53FD985788
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 13:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21CFF1C2109E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F00186E3B;
	Wed, 25 Sep 2024 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RO/xHM9J"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5101474CE
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262097; cv=none; b=d0Bifb9kS1+bib/IWjDJHvkuCzLDZDPHWoQkP78vBsezaq2UXe7+oA1M25KMWTI/MkMxqjjpPL96tJpWs7KjgZARlEXD9gkMo1Sz+MSgnylJ0Y4Jdyfja2B13+xPbUlceMUhXzDTDUGolEG9dF8zVYNMZaMqQ6u52O7tKICVYK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262097; c=relaxed/simple;
	bh=Treg63VPAdJVHmDj+VXIBsVkOkKeXKOgO2nyaDRwFiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8/EoFdlS8sTpImoHlGjBQkutnHA0gU7lmA1nelauPKCnGULeVkc5tnKpzaPuokNuq2etZ4SuyKC/OCZKoWGpLwGAQxiR4DiCDGKFsdmqXw2JROpi2OAONWE8xS+5mPAeOzO1CprPgvbsO8ObZqA1/jxhvkDOlsgmnACFNsvdB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RO/xHM9J; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718816be6cbso4980249b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727262095; x=1727866895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hncFvWLq+2HIxkK3IdImc39anusCXRWego+hIX24T7w=;
        b=RO/xHM9JD6Gjt3PAuQUXUfe8hYmmpeMJXcU+LxEL+kdmIn9O3sa0r409MlKBtF7fW3
         16OkdyKMDNbRhU0YgFuEtm0GPwulAhWprCtuLHib/fy1pUGn3/nZSjbN16sZuWrRsmdL
         T2rFC0o8LCz9rO1xOzxIH7rHWW3N/NpHHrgNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727262095; x=1727866895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hncFvWLq+2HIxkK3IdImc39anusCXRWego+hIX24T7w=;
        b=ES+6oaKQYpZPKobV80TnN94qNcRdhHFeyY06SlGfq80IsJHd39qsWE9AbrZVtPbYkj
         dgeNDyafmDG1OY/G4UpsG9UDPgBhnv7Y17mrinbwZgOjQjOIWGymCKk3KGbpPju8d7iP
         0UCjNG1a9WA7PNTXwHq7WKv4oiT2ZjZ7SJhbCcSGrFJzaH7NB+MKiUpt5zRqF7dsfuZ1
         u8cxkm3Nb+xz1CfftAxIoRE8wot0ftpmWqcD9YogfitToQYn9gRDcRdG4OzbVUuDtbQw
         s6ChHIyCLwdNJZv+iwhxbAGwKm42buqHFJ0U9bpzio2ov4bsDsrHUHTnAEkIJvv9ThnT
         xJbg==
X-Forwarded-Encrypted: i=1; AJvYcCW3uygNF9JzJVuaqEGnZjvgm+rQx60xC9QHd7ZJndQVvGU1WJauv7RdbEQlZGGJQoPhMvgtyn5K78wzz14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCWw9SsvhymjZnevjzhQjbK69S0kYz87SJUgouy8tTnsB2MHEn
	6gq+S0m6h/EpxMIAnkWv6IWUnTfCoFcLy+3emwM2psr+e7vId1bc/ngd1+cIxg==
X-Google-Smtp-Source: AGHT+IHU28Q8f9/KJ3N8Jxjmx5bV8UUivj8/F3xolVCMLHtBase+oJeqruIcrf8KyuRBh44bM56zZA==
X-Received: by 2002:a05:6a20:9e49:b0:1cf:32d1:48f with SMTP id adf61e73a8af0-1d4d4b9bcd1mr2511337637.36.1727262095334;
        Wed, 25 Sep 2024 04:01:35 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:2b86:78b6:8ebc:e17a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c73085sm2570298a12.59.2024.09.25.04.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 04:01:34 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 4/6] arm64: dts: mediatek: mt8188: Add missing dma-ranges to soc node
Date: Wed, 25 Sep 2024 18:57:48 +0800
Message-ID: <20240925110044.3678055-5-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240925110044.3678055-1-fshao@chromium.org>
References: <20240925110044.3678055-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing dma-ranges property to the soc node, similar to how it
was done for MT8195 and MT8192.

This allows the entire 16GB of iova range to be used and enables
multimedia processing usages, like vcodec and MIPI camera.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 51bf08b2ff9b..ff5c8e0597f9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -880,6 +880,7 @@ soc {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		compatible = "simple-bus";
+		dma-ranges = <0x0 0x0 0x0 0x0 0x4 0x0>;
 		ranges;
 
 		gic: interrupt-controller@c000000 {
-- 
2.46.0.792.g87dc391469-goog


