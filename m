Return-Path: <linux-kernel+bounces-439175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B839EABE9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C47B1887544
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF81233D70;
	Tue, 10 Dec 2024 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GHSfJMK/"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2181F22CBE5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822781; cv=none; b=Qt1POOcrBH2oPeBEx7sr0el9K1sIjjSMpUA99HangAOhJvMx/gj9WPQMimVcgIjx3Gh9KVAUFyJdPsvc+w01XWhvRdw60YxangIc7W+WEL/6pbTcCouNe+/T7IsWn+VQf5KjplDzDwWEWZ2TWbmPOVEHGdQWfF9kZkYdYrc3t1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822781; c=relaxed/simple;
	bh=dRt7jwAWsviDNd6yFNvQ++iSH09jta3gIXgiARPB+Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jyhS8+Yi/PYHtEHzMf/1A1H0anstXR9BgXC62l4ULI3MNPe+paWZizk75U/jzdmkCjc9Pq7KWBQkEr6B4tOBL8V75ErBbwoPV5kGuJyFmgfQBu1iqB+K3X1qZhXKmRnINwvxV6urwndWv3C3vVlupPqTwPlh17aG3jhKZpVOoEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GHSfJMK/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2165cb60719so13442525ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733822779; x=1734427579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kGRD0hSRVjDln2H041utB2MSY4gQ8R47O9Y5WYRUCMw=;
        b=GHSfJMK/mrAM1hUtA65ZWSI8HSF5zGWkiN7WqFPy2QxG8KasyP8bcEpPWRhjK5JkOw
         5hTx/FYMoqGi9VAuwFWEmD7i6jPeUMnrSvmuZFIIX6PIg8jL51Xj2NX9MA1rDK7YIwAg
         8de1kdXFREsareyb590jXGwRrRHS4SR97sIOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822779; x=1734427579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kGRD0hSRVjDln2H041utB2MSY4gQ8R47O9Y5WYRUCMw=;
        b=Q1Ct7l+JZrRwK3kJQEfLJkiXcY89nVtnR/GwUeX97BctGiq+i2kZMSHJAO/3TYGcBN
         w51mPk/351HIW/SXnjrmF7dwr8+SC4RAaxpN6cMU4LAWH0MJGU5eTaaJgivOIieOgCOt
         YaWvtH3R+t3/hN6/UlSaQMIiRfTjTGqRDmcF7RgHeIN4Ah29CiqTNEEjzRqm0rfYXPsX
         lxyCUhzYliupbUZjClYUMfGqKHL2OrsmsD8YYA8FaCxwbe1z8hOH7v4LdcmtBAqw+dmC
         PpyZ7firwzthDUfE0QG+/ULa96ELFYIXi+6w7od0ROsLUQxg9yYgqpxyygYNwWpj/cH/
         lXZA==
X-Forwarded-Encrypted: i=1; AJvYcCWhXjG9r+d2nUQTbYtifakEcPvVvHexq2DHr0A5hJO9SKk1E3zNNbb+ZBp/zFXV6CHfBUqakui+m5Os6rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA+fdIVnB/kF7Pj5Up64La1RjjThcgb2pebbGU3ZO5iBMmUkHo
	ASwC/KEMeqEMiGUZSwTy1c7IPIvE7AT6s2bHYoxW7tZL015WBKuCbUEBLk4afQ==
X-Gm-Gg: ASbGncvyD963NDB3Vw4UhQlK1vZoJSYRZrzsfYYtfzp5s2kKSllUEUAnYIIsCPnGdFe
	XfM1nQM7WFLs2wiCUDcaOTKw0MVdQhTbqO6mLnyUrVJGV61fQm4dfDKw7FugS6KW/rBnP02ZLgX
	aYi97Y0Grfd63qHsxYq81fY/7ljizKP28kG+4rWSTCQvuPq1cxVTXg3oezeWx39YTHp8+lWPvw6
	UQ25qL9/H5N9E0BKDLXO26JCDyxqHcnrk0jv87o0GZGBGbHsZXcHZvWXEO7q0Zw4TE0W3YC
X-Google-Smtp-Source: AGHT+IFppVkXUZtU5Ti/lKVHNrZcFZH/mEntPtAhtpRBAEfq5xqQx4M1XdryOoDpDNSLeE8I2hMSbw==
X-Received: by 2002:a17:902:ce88:b0:215:a97a:c6bb with SMTP id d9443c01a7336-21669fca850mr59408385ad.12.1733822779591;
        Tue, 10 Dec 2024 01:26:19 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:89ce:2db9:f7d5:156d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21632c4fc62sm49006905ad.194.2024.12.10.01.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:26:19 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: mediatek: mt8173-elm: Fix MT6397 PMIC sub-node names
Date: Tue, 10 Dec 2024 17:26:12 +0800
Message-ID: <20241210092614.3951748-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT6397 PMIC bindings specify exact names for its sub-nodes. The
names used in the current dts don't match, causing a validation error.

Fix up the names. Also drop the label for the regulators node, since
any reference should be against the individual regulator sub-nodes.

Fixes: 689b937bedde ("arm64: dts: mediatek: add mt8173 elm and hana board")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index b91072f4723f..b5d4b5baf478 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -931,7 +931,7 @@ pmic: pmic {
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
-		clock: mt6397clock {
+		clock: clocks {
 			compatible = "mediatek,mt6397-clk";
 			#clock-cells = <1>;
 		};
@@ -942,7 +942,7 @@ pio6397: pinctrl {
 			#gpio-cells = <2>;
 		};
 
-		regulator: mt6397regulator {
+		regulators {
 			compatible = "mediatek,mt6397-regulator";
 
 			mt6397_vpca15_reg: buck_vpca15 {
@@ -1108,7 +1108,7 @@ mt6397_vibr_reg: ldo_vibr {
 			};
 		};
 
-		rtc: mt6397rtc {
+		rtc: rtc {
 			compatible = "mediatek,mt6397-rtc";
 		};
 	};
-- 
2.47.0.338.g60cca15819-goog


