Return-Path: <linux-kernel+bounces-433845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7639E5DD2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F901885AA5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A426227B99;
	Thu,  5 Dec 2024 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xSVCz83q"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396EF217F3C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733421727; cv=none; b=tBSvmFMKIAyoOnIa7HBMY/XdrCS9uSPdytN+9DmJBnKflaIJ7eaDCizpG/O5lxtB0YGPtN286698tEyzM+fMNc95GpvsGUxbJqS66wAXPrg0igeNGgTImFNBIXl9vHwmNG1aTGekI7oqhJAUPMYThoGLCXXSGPg2U9jJG41l9FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733421727; c=relaxed/simple;
	bh=rl6qwSwPmwstxso3urexxTtZz5A3LKOG2dzER+Weveo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdkwlwoSDG+HesWaBgo5I8RnvXeoPLvytOFM3xqY5/DJe0lS2THblsv02rB6dSqlbcharCWP/RKp1Yhi/F1jElW/pPz8HuZr5jiHe6svARa51ckBPIGfEBxUCxYk7eeco+BYGb6dje9Xvzk1EqaYq0TBWgGfsnLVM2/KgRlh10s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xSVCz83q; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so1061780f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 10:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733421724; x=1734026524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXkOgCi8HIHQGsuWXYvnWFeub+37cwugFPfSGaOkH4k=;
        b=xSVCz83qbeUd4lp+v3/89GpSYD9h9Ts+WttA81OYjlIIpJng5pHxl1L1RuEbWaXgQ2
         QO38uq1xPJSJriN3PKaUmKeYP7Wxpj5A2L9Tnb/OPK8PSYueBzmtoZq8Go6SnuwhbqzI
         sCu8L0+3YJmu2xiI/SpodLKM77MXMYuKlpuv+7Yj6Ix1NA+X+hQuxm5KEKDSQp4Zc1QW
         x4j8KcuRc4yrPaevx/TPjTo6RFoSi01uNzdG5Jb4LJsvCwvVeEHZlSwZmO/utcAkhENx
         y6Jd1nUxiA0JPKRu/deMHjsrNsiuwQxyJHu1iP3IGR+o271QH1TCcZktfV+D1ilKv73A
         eDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733421724; x=1734026524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXkOgCi8HIHQGsuWXYvnWFeub+37cwugFPfSGaOkH4k=;
        b=amc+pXNZ3aDyfLzlUTH4cDPjg1swMrZgTn1h9imKPiQa1L4a5JlzvO48tU8JTmMfag
         6MaN9BU0eUkvppLS2cK5r+t9gzPyJvKbj2533MJPkFPCGHtYJSJ59d+BTyzswGbCD0Nu
         n/NOGO2Z/X9dn7eT142LYBaV1jET8upNZQnOuRhvBNq96ny+yZbfm+m3f7NnCF7vf6SY
         pzRVPW8LbK+xvHRbFpZ79EpFMBlB9hkKmAV/roF7qG38QP0iPKnl8tPvTIjVPgaysw9/
         P7jyw9xmAIsuy5DcJGoxkjkkRM1O0eFG8v/u69KPbtRHhNpdWqRkpsiOae7Hk1l1uGTe
         plVg==
X-Gm-Message-State: AOJu0Yy46tuCGqGEnXAdLCI0cFHEgnHj5nriS6b77UXf3Htz9+Ar2lhL
	T3Sw7M1LCfqOxKC0kmsCObZBuhppnYfKkzZ5BUzR9TUuE6VbW8hwyoXu8jw9ejs=
X-Gm-Gg: ASbGncuEa1PnAEoOgeWTA6HFju6QbhQUhd0sIfivHTQQHNDKFsnwA+bHeUvHNkVhVp3
	cSza5hll2fqqW9TCgxeh0wDtefmbnYykFGL+9sqwgW2SUqMFBe2tWhVVwulR47GBBdArH1eHBwY
	i5cw98HY4ztQikmTrAaf1jQTAUNds0cD6NdfvpaOgnyad1EeqMLzkt/RUx6+Ta2yY92xLlr1ODA
	lzIxjrlSKFdno0uvcZ57Tl/5iNgz3tQNLulg9MtcrDrtqcTVNemaC8FV3FTT/Y7G0JUscqXMlCw
	wiPYpR+YaHH+EjC601/Jib59TtMB9nvl
X-Google-Smtp-Source: AGHT+IEPtZMmft62bUPhgYrLR+oDZpiHUMZkgxHhYwyxhO4GONqKTULpT/JUlhKvm0dRtGKR4n2z+A==
X-Received: by 2002:a5d:59a6:0:b0:385:eeb9:a5bb with SMTP id ffacd0b85a97d-3862b34e5f0mr30744f8f.17.1733421724237;
        Thu, 05 Dec 2024 10:02:04 -0800 (PST)
Received: from ta2.c.googlers.com.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386219098d3sm2618228f8f.70.2024.12.05.10.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 10:02:03 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com
Cc: linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	peter.griffin@linaro.org,
	javierm@redhat.com,
	tzimmermann@suse.de,
	daniel.lezcano@linaro.org,
	vincent.guittot@linaro.org,
	ulf.hansson@linaro.org,
	arnd@arndb.de,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 1/4] arm64: dts: exynos: gs101: add SRAM node
Date: Thu,  5 Dec 2024 18:01:57 +0000
Message-ID: <20241205180200.203146-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241205180200.203146-1-tudor.ambarus@linaro.org>
References: <20241205180200.203146-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SRAM is used by the ACPM protocol to retrieve the ACPM channels
information, which includes the TX/RX rings among other channel
configuration data. Add the SRAM node.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 302c5beb224a..1441e9a252c2 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -269,6 +269,14 @@ bldr_log_hist_reserved: bldr-log-hist-reserved@fd900000 {
 		};
 	};
 
+	apm_sram: sram@2039000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x2039000 0x40000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x2039000 0x40000>;
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.47.0.338.g60cca15819-goog


