Return-Path: <linux-kernel+bounces-440791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C079EC444
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B0C188987B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 05:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EBD1C5F36;
	Wed, 11 Dec 2024 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fZX4rFTa"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6AF1C5F25
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733894697; cv=none; b=grKLl5vrfKOTMgkTUK0dh7Jl4TKlFX6Bn/+cQBJtuk3VwC7pKo8ygjf9hp8K0NKi7yUri0gjDOy6DuYQwspm94I2MDtXd93gHQRA+boaV82vCRcoc7gJYZ1rljVYIzEz8ZxFNiGy2YNHM6HpK3XwEWYu/EewZxOJzuSftb7ZtJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733894697; c=relaxed/simple;
	bh=JaeMGgUFcLiDKBLrL/rZFvR/uybc6uxeUC4gPJ3E0kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMEOeeQnXJIS8zqrUYWO7OvhbQU6ggMGGEc1JN3jZbSgvj37QdhMld8MJ9/zuvaOTFtPcNiydNFraMnWWM5aLdnaqQc/SIwvap16h99THNP1E51/b+sONMiWLDXKEng2Fh5xVmrJ0i0ySrC3nbfEG2nFYYUb5jwS5wz02gi6Ss4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fZX4rFTa; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-728e1799d95so1611430b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733894695; x=1734499495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRYLo1XVsoZcdIe8JMdl8StALXaXVo/fdHv6b61KhZg=;
        b=fZX4rFTaCP45qAinFSKtxXnQ3ILaMKOK2kOA6aZagWyTYT5Sg5Q/GyCG61ggMXt+ra
         OIRq/CSrWm7W5gewCXiSwjtWsW6YaCS4GACUmgHTz9YxbVjQXVyqeiDiD0c1Df7D8Wpd
         7pt5CXtFoC/nMvTKd58rVEOrGxaxDiavrDhx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733894695; x=1734499495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRYLo1XVsoZcdIe8JMdl8StALXaXVo/fdHv6b61KhZg=;
        b=ISSrci8OjgnHU3bq4WT/iB30VNnuVLUGJmHuEdQKIyEE4Bo9X0KnNQcAEKvoQJD9gj
         UJccavlyDxi/dNPlNXx8rr2ENFwktx3rEgebESMJef8w9mrvgkpYUUjwgVr9N4X8NKkb
         AVu95jI0PvqF8ygkan0dQfGNjUHJCfMK4aKHxS0JtzccexRfAbq3KSgw4yv9q+xlLWyU
         IlFb84z/O/VOfPpBQP9Iq/RGHnaq8xhdKAfS9f2pG/WMAaLwUSW7ugilJEBH0ghegegI
         HQDrygeodbJ2dAhkyjMVeiQwVMaGa7Yxv3GHI9Yj9h349vrN1G3yyL8ijxDnLR8TSnCq
         Cc0g==
X-Forwarded-Encrypted: i=1; AJvYcCUOWExBpMwy0GGBOERctNw4uiKY32bb3x5zNW/nkitjHKE9FaHNBYOXEtCDFYtSa4R1KHDtg0t7Uesvx7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSukZV4F+Y5iwrXxsFwgqCI05OvxiAarrlBzJZud1YDiJtd7zd
	FhDUMmjvLPUQYpznXzysfwO35kLqqEBbdZH+tzUV2zqvyk6taoLsEGNa3rXgGA==
X-Gm-Gg: ASbGncv0ET7oqqCvTyQXmYhklRyvOJLCFu5rWJURa/kExEKzwn3IRvaCukO8vrZTHkS
	zKB5H1A63cETNcWCLa56hB9bkLLM1h5lGPtWEkH8XPN79y1IFlyWhpuPXxULzcySCrkQAM5iDY2
	DIVFvVC4ZRN5jnZbyfboW4pfgPltMk5CAWXp4Afuz/QWWVpbyhz3z2vjb5X7Pmf16Ja006DLN76
	cKla3z4PNAPZ2GeMnrw4Y63+r7QvemAtOpBa5kBFHJQLvbPGz0zm9SBHMOSU1fwiPeDI7Nh
X-Google-Smtp-Source: AGHT+IGcmT3GR4NnAQIsxi7y5dgBXEJxX3Yf6AWVmokkpdMshwchaRs79fYSgZNuL4uxCYG7JeSC7w==
X-Received: by 2002:aa7:88c7:0:b0:725:ab14:6249 with SMTP id d2e1a72fcca58-728ed1bb30bmr2871732b3a.2.1733894695561;
        Tue, 10 Dec 2024 21:24:55 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:4dfb:c0ae:6c93:d01e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e66801e2sm5397702b3a.160.2024.12.10.21.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 21:24:55 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] arm64: dts: mediatek: mt8395-genio-1200-evk: Drop regulator-compatible property
Date: Wed, 11 Dec 2024 13:24:26 +0800
Message-ID: <20241211052427.4178367-9-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241211052427.4178367-1-wenst@chromium.org>
References: <20241211052427.4178367-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "regulator-compatible" property has been deprecated since 2012 in
commit 13511def87b9 ("regulator: deprecate regulator-compatible DT
property"), which is so old it's not even mentioned in the converted
regulator bindings YAML file. It should not have been used for new
submissions such as the MT6315.

Drop the "regulator-compatible" property from the board dts. The
property values are the same as the node name, so everything should
continue to work.

Fixes: f2b543a191b6 ("arm64: dts: mediatek: add device-tree for Genio 1200 EVK board")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
index 5f16fb820580..5950194c9ccb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
@@ -835,7 +835,6 @@ mt6315_6: pmic@6 {
 
 		regulators {
 			mt6315_6_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vbcpu";
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <1193750>;
@@ -852,7 +851,6 @@ mt6315_7: pmic@7 {
 
 		regulators {
 			mt6315_7_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vgpu";
 				regulator-min-microvolt = <546000>;
 				regulator-max-microvolt = <787000>;
-- 
2.47.0.338.g60cca15819-goog


