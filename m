Return-Path: <linux-kernel+bounces-440724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0429EC356
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D282847A8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D5020E332;
	Wed, 11 Dec 2024 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vMATBJWx"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EF31AA1F1
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733887831; cv=none; b=bgNDQL/1D87su1FdoIdqKAHkDCqycp42LaOUEHfpFHyVEDzg3SNuP1VHvYkRe4YgIZrzAWJ23UGMQYErQ6GR1dVym2doGii67djC3/MRihLuKL/TyLK0k8Yo2no1AGARuxoL2bruDjDQ8LU71QUCrQM8pl50CLvdq1DMmtPdpoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733887831; c=relaxed/simple;
	bh=KPVIZUaYLPhhu+NT5yPD4CmhA0oRk+MtYTE4fN805/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oA/KRRpwp9gfpf0Q3RPb4gFJy0CJgMnkb35aTjAQknxAr6i92jbpUkMabzEwmFxbyNGdQ2CFVTmLDTX2IxV4Bf3wM/Ig7umrXz6vJEWZrsgxY17KXhc57mtfKEvb0D+lsYFrFTE9LQO4zm6EibGF5iloqH9JzvPAiYKubOjhUiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vMATBJWx; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71e10e6a1ceso271727a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733887829; x=1734492629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v+SqWvKMXn53ySqihikLvjixvoulHaOpfvaW+kjjCzk=;
        b=vMATBJWxEVpJYR3+JJayfGyyJYnULB8Bi28j+3caQDRLzYhIbPUDi3K5bqgcI7pc8Z
         EAzgqLqKPTH/Kp3awp57sb5Wy+IYW2hgHKyD3PvhoeA30mO4aERHVKOMmo3hRP+T7JUF
         Bz2fmwZPv5iF0yxKmcc47mX6/c7U9jLSGUDkli5adfVNztKsnlM1S8JRmJd6+9cVATxk
         ilnUrTGzpKtilB9JI2fq1qlCq60xX8Lns/hc2NKegVe8LL1NgqZEcMqXzMo31OyUOfYu
         NmemYMO4eQprDPG1VmWhAjMjQ1ztOdfhyz1C0shrL8fhCmitE0BgIVCl7dGQXml9sSgn
         F/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733887829; x=1734492629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+SqWvKMXn53ySqihikLvjixvoulHaOpfvaW+kjjCzk=;
        b=AfafqFkCQUyDXgVb447fdZjXefVsLdJ6IOGRfu40Oc29OytGfBVhqffMGIeYN3frk6
         RqkrLy7u574TJUPL19OD8PuHiTvoK11ITG5VZaoHzLKX2oIF9oYL5C+106y+VhALYtXK
         9nzbSPJQ1I1MtizO6FoElrcbzNHVCROIBSJvZ33bleSXoo4yEyB7gxi2AjQcgiX9jOSs
         8WTvEEMzVsrPVuNwljmyFLx/sWjFVDXvtyzQTENMONyBAadg6xrhNS8alKk3xCvr8fPH
         e/GyvCOMBCAb4hBjImlC7hSJEfBrqPrhekS3tl+9qY94UMP/RNn1oWBCP25/OwUEAJNJ
         qmng==
X-Forwarded-Encrypted: i=1; AJvYcCWXbNrJeP8YCYqCfmtCkHUSdr7Mb/l2XnRpoX8NK3o9bVGnLiff3ZqZYPGgzUnjfHE/Ujr4DtA+RULWDwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysAG2vFP82DwTU0cymLYkumCqirdfhwmrHUn9+VyXh+mekEWsq
	1YCCYL0hG7KmGwBOcAuwGfX72oIcBTAroBvyKix0X1vw7oSOey2nihO6GMtv+2k=
X-Gm-Gg: ASbGncsRCvi/iNDAu9IDuzpyadUHfzqZDVFriTD0u0IGD5zGeB5ypd8WuftR3mp5qi7
	6bKKcPqffyYxJIAsWNOiLQ+CODvZnFFe7e3ebm9+tABZyebPWG5nfPplrbgZp+s2kVOimsZlYFa
	dZzsJy4S09HDj2h6JSCiAjTii1qv8OCr7vYERGJnMrEHRPZiqznLfyQFIIaB4I1wJgfYWxbhjnE
	57Te/ndd+EW+hixRHesdZdUYuMCyrVbOtpRdBeQIbwKbsd1VP0xV8qWSyc=
X-Google-Smtp-Source: AGHT+IFxuwtOuX7RSi7QuMnWBVAHW2v93lQ0WBBx/aGpBUEB+zUeX9kV14JIgbiv2kahMG99yLppvg==
X-Received: by 2002:a05:6830:25d4:b0:717:f701:4842 with SMTP id 46e09a7af769-71e19b5ac55mr619830a34.28.1733887829115;
        Tue, 10 Dec 2024 19:30:29 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f2c472a028sm996004eaf.33.2024.12.10.19.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 19:30:28 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: exynos: Specify reserved secure memory explicitly
Date: Tue, 10 Dec 2024 21:30:27 -0600
Message-Id: <20241211033027.12985-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of carving out the secure area in 'memory' node, let's describe
it in 'reserved-memory'. That makes it easier to understand both RAM
regions and particular secure world memory region. Originally the device
tree was created in a way to make sure it was well aligned with the way
LittleKernel bootloader modified it. But later it was found the
LittleKernel works fine with properly described reserved regions, so
it's possible now to define those in a cleaner way.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
index f074df8982b3..7d70a32e75b2 100644
--- a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
+++ b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
@@ -45,17 +45,9 @@ usb_dr_connector: endpoint {
 		};
 	};
 
-	/*
-	 * RAM: 4 GiB (eMCP):
-	 *   - 2 GiB at 0x80000000
-	 *   - 2 GiB at 0x880000000
-	 *
-	 * 0xbab00000..0xbfffffff: secure memory (85 MiB).
-	 */
 	memory@80000000 {
 		device_type = "memory";
-		reg = <0x0 0x80000000 0x3ab00000>,
-		      <0x0 0xc0000000 0x40000000>,
+		reg = <0x0 0x80000000 0x80000000>,
 		      <0x8 0x80000000 0x80000000>;
 	};
 
@@ -146,6 +138,11 @@ reserved-memory {
 		#size-cells = <1>;
 		ranges;
 
+		secure_mem: memory@bab00000 {
+			reg = <0x0 0xbab00000 0x5500000>;
+			no-map;
+		};
+
 		ramoops@f0000000 {
 			compatible = "ramoops";
 			reg = <0x0 0xf0000000 0x200000>;
-- 
2.39.5


