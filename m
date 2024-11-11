Return-Path: <linux-kernel+bounces-404536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 234839C44DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7641F252FA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A3A1AB6C3;
	Mon, 11 Nov 2024 18:18:16 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4EF1A9B33;
	Mon, 11 Nov 2024 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349095; cv=none; b=NI/zmmT/5y0i/KU29BDNvsez/4nql1jQNIvOo2Vq9Qw+ps00Zax5rnFnyia9dDCA5XCIKFju+JPZz7E6JyatmUA0kQFR3dfOHL4SeuxqSEU35RY4YWMtiMJVFZ1m/FQ7ItUfk5JjM071RjYQXBr1RS3c9BR6BcM8nKarW0wMi5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349095; c=relaxed/simple;
	bh=HtvMLoBZx4eM3Vdilo3yNeTV5Fp45Iqg0wKDB4QwmDU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bjJuvtT/eF5VMfKje2on6TO1zL8GEQ21ySDF4vIsZYTym0jC4i1CDZdoLhOQ7o0G8ZoODNDyQ8BkF0BfBUChcdu0j2/pzwgxcxsvSBTkbaKtyATaKk/OEaVvbgGkp3GcnNtTbIpD+/PJHpGIL2oonGlCp/gDkqcnnyH+/lXRINM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so630040466b.2;
        Mon, 11 Nov 2024 10:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731349092; x=1731953892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eckdRA2Gz50Pl0iUsR156tV+5lFkIuN6FgaOkhY4G4M=;
        b=kAFQk1Kw1lSvnIR5ZjC2/5vA16Ad/9hlXzkJ7LxtzzM/gelKubLF86yxo8MS4sr1rh
         zqXr/0qpzxAyDGTfhnQcbL5XzX5P+6lGYaBEoHu9VL5P++hX2RDxs3AHQBZcGc54sbdV
         AG89l7QzlwdEyV5zQS8kK7/FWJWqJNvw77Qq4lpNUrY/9CA0XTQA+XjNeEQo2pcGmzzc
         BPh2VaE13sZq0MHNZIskJxb+TAUVhJcdcEGcteRP7wmnQKXXojdIO74VB46ncuPgumar
         p/sTSrUB9Q+3UawhY3wgOUQ86NSnys8FNRj22uQcAJgE9igqRWWtpwtK048oabG4t3qb
         GOFA==
X-Forwarded-Encrypted: i=1; AJvYcCUr0BRtgkBmbi52B2KH8vlxz5/k3QquhukGPseLg5RYDb9Cw06JP3BzF4NNcG6JQKbN/QLACEvjbs+V@vger.kernel.org, AJvYcCVsSN5jM05QmLMT2wTe6bxe/dpa253t+2xSsJaKS9pWOTbFDo14PVomiQGMF17EqjguwXuztl7QEqTHBvPo@vger.kernel.org
X-Gm-Message-State: AOJu0YwUGuY8BC3E/C+VnQTuv+EegeyuXxi99NADzskDEqT66i/nEz5e
	jXF9uXwcwBR6KBx2TnyHgqcWBvbPgIX3ur84MtlB2prYYB0hcJLa
X-Google-Smtp-Source: AGHT+IHD9WSUDwH4PlIGM00maH6QB8VOUn1a7QCnR3fLMSi0p8bYg2PXCsAsVliSK0qebYRlecvEmA==
X-Received: by 2002:a17:907:84a:b0:a99:e1a1:473f with SMTP id a640c23a62f3a-a9ef001914fmr1369234166b.57.1731349091955;
        Mon, 11 Nov 2024 10:18:11 -0800 (PST)
Received: from localhost.localdomain ([193.142.191.186])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17b64sm617868466b.39.2024.11.11.10.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 10:18:11 -0800 (PST)
From: =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@linux.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	=?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@linux.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Dragan Simic <dsimic@manjaro.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: rockchip: Add supported UHS-I rates to sdmmc0 on rock-3b
Date: Mon, 11 Nov 2024 19:17:25 +0100
Message-ID: <20241111181807.13211-2-tszucs@linux.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111181807.13211-1-tszucs@linux.com>
References: <20241111181807.13211-1-tszucs@linux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add all supported UHS-I rates to sdmmc0 and allow 200 MHz maximum clock to
benefit modern SD cards.

Signed-off-by: Tamás Szűcs <tszucs@linux.com>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
index 3d0c1ccfaa79..242af5337cdf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
@@ -670,8 +670,14 @@ &sdmmc0 {
 	bus-width = <4>;
 	cap-sd-highspeed;
 	disable-wp;
+	max-frequency = <200000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	sd-uhs-ddr50;
 	vmmc-supply = <&vcc3v3_sd>;
 	vqmmc-supply = <&vccio_sd>;
 	status = "okay";
-- 
2.45.2


