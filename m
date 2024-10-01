Return-Path: <linux-kernel+bounces-345792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E7A98BB2E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F65A1F22D3F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5453D1C3F19;
	Tue,  1 Oct 2024 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TqnW0ByB"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C141C3F0F
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782294; cv=none; b=l8c/6JGo47oqzg8owWmePjI5+ZaRAtOpr3pwRSi77U2yEYmFgsIw54Te+hzJZCI9z+XcumtT/3z9cBvwVBsNez7lIpBxy6yy/4So9tyk2WIcoU9A2iE4TghAMH4ibWsgdMNCc3jTTxqzaOGYFgpqjos9ZiMj3e9H/dhI56c2wr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782294; c=relaxed/simple;
	bh=nLKLUoRAXjBaJW9yZt4O5whKBT4sDQoOBzI695cAKQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNRy4rjDDBKTi+6L70lDLSxn8DNavqwPvAgKqNuAfO0t8T+iNywKyo9a/2GTicYgP4H2WMKRIHOaKMSnXDYDOTwLvqvoMq41koiEozZCdr0zEGeiVDzgd8H7ppiummsh/vSKSI2JNFTVUZ0FqXznbOqqZWyJPKsJhkaLH/YUSZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TqnW0ByB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7193010d386so4660824b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 04:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727782293; x=1728387093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkkLEEucgoW7bgbQKsmRzFtFQZp/ikQpw3ZnY6QygrQ=;
        b=TqnW0ByBDthk759UhDyS1XknDeryE1wDn+3Z3mM5ss9PiJhcmDuVLq5okD+3i8dYxQ
         Yws+36B+GYM08mDLXRR11kYxqSl4SwN9lTWXvrxCUbwb/kOe8zLG+vYz+R7FOx3A3zyu
         3LJaEk9pjpOeRjFBu9Y3UBP8mMwGHvj4tvPhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782293; x=1728387093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkkLEEucgoW7bgbQKsmRzFtFQZp/ikQpw3ZnY6QygrQ=;
        b=rTGrVYKIErjnqmV/OV4oDYh9XsqXI3dLbCl6vVJecXzh0lpRl1PiUwjggkAaF+xfLE
         RjkR4MckLb2VsYkYUX0zob8Aw0Fjp2EfJ7wud5tDZ5QevYLIWobeGxSLJxI65XujDJWs
         zQ0Bg5C8S9NQM0ACjHNIK49GDwJwb7bUO0fOVoj+gj/FNaZYyb+iJvFvKBnsZq59QknZ
         tNO5LJ6JuoF7p/UBt1bG5CPMCRbDxTJhzTMNU8I7GvXCtgGg5Ki3sRabdhPlgQjrqD4l
         EplYcmLa2VK2q3THgrk6BrNB4fvBaEjufrKTRcBoIbb03coNqwxTlhmUbeNY5J0L2LxR
         4ohA==
X-Forwarded-Encrypted: i=1; AJvYcCXiiL4CZ0o1nnWUOuCMsM90enEl/q6OFcdKwtxoDQavwajLlpmfvQ/iUvhnhJnEHjmZXM8RLO3ydDqu5/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy668gOGeE5bkGzzfNit7mMyilXQPdnb0e5zEOGFB4sSOBQVCzc
	FNeXC3qw9APGKWhOfsmvXfHiSrN/9D+mtT0hTWfAqiLsVAeduhlwUKI6G+WUsQ==
X-Google-Smtp-Source: AGHT+IEgzRkoFd2sNCI4/vjWyPLOdY4pO3TPXtmTpmnMfuOP0TUArqKEjA+xqCTmER3Sm89xeggSoA==
X-Received: by 2002:a05:6a00:194f:b0:717:e01d:312f with SMTP id d2e1a72fcca58-71b26078cf5mr25062339b3a.27.1727782292819;
        Tue, 01 Oct 2024 04:31:32 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:e044:f156:126b:d5c6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264b63d9sm7810646b3a.52.2024.10.01.04.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:31:32 -0700 (PDT)
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
Subject: [PATCH v2 5/8] arm64: dts: mediatek: mt8188: Add missing dma-ranges to soc node
Date: Tue,  1 Oct 2024 19:27:23 +0800
Message-ID: <20241001113052.3124869-6-fshao@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241001113052.3124869-1-fshao@chromium.org>
References: <20241001113052.3124869-1-fshao@chromium.org>
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

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index cd27966d2e3c..69390da9cfe0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -878,6 +878,7 @@ soc {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		compatible = "simple-bus";
+		dma-ranges = <0x0 0x0 0x0 0x0 0x4 0x0>;
 		ranges;
 
 		gic: interrupt-controller@c000000 {
-- 
2.46.1.824.gd892dcdcdd-goog


