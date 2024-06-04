Return-Path: <linux-kernel+bounces-201416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA958FBE33
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88AB6B22F29
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48F514D2B5;
	Tue,  4 Jun 2024 21:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GbijcIrX"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DFB14B97B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537360; cv=none; b=UISn5QCSXHsc8o29frYlOXqhWPeyMCFxNDVcTV1loMBaqdd5t8JmoNFFwT9mtfTvMSp9rjSxM3XBDcF2yeFiOmmgtkxnU8XqJ/XEt1iLhqklvO6xteqp7cmSfKCYf2/1jSyL+JbG4zaX1MWhowawO3o8V/Xo1j0QVYtUPx3m4P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537360; c=relaxed/simple;
	bh=DR4noGTvQJfxqZgaRPYStAP3sxtorZHW3MerXwYFYK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQ2rBFYJtKxDqwXwrDGIIKqJAvuymYvuQHKZHZ+ZvCzpY8VscZ4iUkHb3NCnMkPiTX0FlS3DIIaj9HrQDI0cSZ9+XSA6rgCAknwBjAzfxavWMcHFNRgIScdb8ZH09h9Dr4Yq9AdCz9+1b1a/f3U478Q2bVXplIH9bVBw1AbHA0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GbijcIrX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f68834bfdfso12975655ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 14:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717537358; x=1718142158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYm2Ihcymc0GYYvAeFdOt61hcsgG8S3It6RMdtYbi9k=;
        b=GbijcIrXMRHO0d/7I+IjGT8Cj+XG/7mYMDHgInqqYXbroH08fHVwhCxZh5vaQsJFTJ
         FcJfSJrX6Q1SEfUC7upYnBMeDIxMyfGtbLBx0dCxIsMSybRRj//dE36yv1AvwfJCQ7fi
         WSpykp60ocoOBcyRX7zBwFEQnhItQctlw3wkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717537358; x=1718142158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYm2Ihcymc0GYYvAeFdOt61hcsgG8S3It6RMdtYbi9k=;
        b=rbjp5FR2rfR8hZnKQTO5/ROSYsAJsReI9OhkEwHV7qIRGZVUvwxTYeL7Gx5eG4K+JD
         7X6owO0lotzZky1E7PMgvmOnPSNjYJCZ4+xzGTHlOG/rSvLTTP85qZVwhrxp1/1qiNRx
         NqbfrQJb7bDn5QGwBN+aCBsAJTHMdTrMkWK/Nk142nR24hDw/QTEPJTsNuDG9ODlW6zk
         t5kq4zr5E/dJlixo2IdcNqw4x/4t/sH2Ig6LYNQmr+PoAwJylYH7vNfJuBgVXb8HFiRQ
         LfINk5eHkgvuf3KtTZduvMhB3xbEmDATRsWq+IyyptJDHj6bFSPPv0PXoYljW4zZfff1
         pdYg==
X-Gm-Message-State: AOJu0YyYJIIddTccVJAX5IIGlZjUBpx3erxue8fdagLdoMDG4Hfcx5FS
	rjuuSA1OthmNG0hdib1EmNRfP4kC1yH8VHfAqxBFestSfGGWd001Ykxq8JqxPQ==
X-Google-Smtp-Source: AGHT+IFhf8nAUYL+FNdvnpqa7A/O+7CUJFcajK2GH8sYTtYnOeRE9RYY6Tu3RIZW/OiV5NO7hyrY8Q==
X-Received: by 2002:a17:902:e543:b0:1f6:5551:9e6c with SMTP id d9443c01a7336-1f6a5a6b42amr9616895ad.54.1717537358165;
        Tue, 04 Jun 2024 14:42:38 -0700 (PDT)
Received: from localhost (132.197.125.34.bc.googleusercontent.com. [34.125.197.132])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1f66c412fd2sm51747355ad.283.2024.06.04.14.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 14:42:37 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	patches@lists.linux.dev,
	cros-qcom-dts-watchers@chromium.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 2/3] arm64: dts: qcom: sc7180: pazquel: Add missing comment header
Date: Tue,  4 Jun 2024 14:42:31 -0700
Message-ID: <20240604214233.3551692-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240604214233.3551692-1-swboyd@chromium.org>
References: <20240604214233.3551692-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We put a header before modifying pinctrl nodes defined in
sc7180-trogdor.dtsi in every other file. Add one here so we know that
this section is for pinctrl modifications.

Cc: <cros-qcom-dts-watchers@chromium.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: <linux-arm-msm@vger.kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
index 8823edbb4d6e..73aa75621721 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
@@ -83,6 +83,8 @@ &pp3300_dx_edp {
 	gpio = <&tlmm 67 GPIO_ACTIVE_HIGH>;
 };
 
+/* PINCTRL - modifications to sc7180-trogdor.dtsi */
+
 &en_pp3300_dx_edp {
 	pins = "gpio67";
 };
-- 
https://chromeos.dev


