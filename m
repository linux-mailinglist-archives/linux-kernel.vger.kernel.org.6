Return-Path: <linux-kernel+bounces-511487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF46A32BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92A867A1F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABE1243945;
	Wed, 12 Feb 2025 16:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TR4QmaMS"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD819211A12
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377971; cv=none; b=iEOfgD0sWh+m/HuuoKtylncZjzteuoYEm+O4y1LWTV3OdRKBDCJoerVdhAA24I9+riYsghJIpxTukPS3Nqq8wOA8L8b1r+/NGEpIGAMYM9uueLfS00j4i85bP+WYmZlGPhMeroZs0AcF6fECODHJsU/ETd5o/TzZg6Q+ogecKMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377971; c=relaxed/simple;
	bh=uM+rgeiyIG3H/nI3hJGwzzxr1vwwAYELU/clwSlSP0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X9bux9nF2jycPpVV30SdbashnhuVCFmz2y/YkgMnd19vRd0zEu/aRhO7LmuNz6zrw1bGKll6JiQppK6cVn8xvYETFdfw4iQUAhHcunBBKrk+omnWk0YZr9n0XjiRF8yF6dyT9xNYg93EBnFH7Rk5T6tsF77RdBtQJ+WL/Fgm3A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TR4QmaMS; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7bc87197bso65727766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739377967; x=1739982767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D3+GwMSFhqocbDKQfg41i+abCZPRjFt/R7A5GSXrnUk=;
        b=TR4QmaMSTyI3dInttInKYSlUMSiQa/vAht7WqMRcncedRANOJeNfczhQbmODSlgbKV
         9StRjkTtPrf9EY/xCJOAPEHwmi7To1KHjkuKMnqxKmwdxBqllJKTGYhjWM8Iv+OdW80h
         hY4J1/wRRwVoVgm7gwc9k3QascxowxfyWXB8Fquc4P9rb+n6AOZ/N9sXxC2uUhaJmw27
         YPzHVqygaOwKCkuOp/SLN4epm3hd41pg5MITHfUyNbcvEbskgMqVR6gGyR8LlRrHs1Vb
         PhsSH+/DPGmXpu+PmQolSIBYya+tVwZstmWNLd9ODP32l1Y0f03QfXUIs2VJv5GN/Whz
         2Dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739377967; x=1739982767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3+GwMSFhqocbDKQfg41i+abCZPRjFt/R7A5GSXrnUk=;
        b=gWN5FkD1JHOdy4BG5FzWnRJ1koZngZqatKoM1KLFfFxxCEXuX3Vn2zYAw30mAx0Wt0
         0ODpsVpDLMNMw9CmG0XGTQQkKfBnGhS2Igb+0xepNwa7A5MdYM3eleQeVlFHBZmOSVHh
         CEATPBE/A96CJ1Wo5eITms+jYMDHpWurG9M4q/CUsJXa5oybAOmkg8soXOty67UJ9+26
         2q1UNDaFDjupdbVJkql3j9HcMBPJZ8RQpj3Y2OPsX25nCiotNt5pHzkfoR8buLQXI/Na
         pSrERCgRx22QH/PwgyCaffwJU7UCRj2/SMvNF9x5iqlIKYXGZPO/WgZKfBygmZS9QCfF
         luHw==
X-Forwarded-Encrypted: i=1; AJvYcCVAxK4J0lh7ga8LXEmXoN9V2Pcd1N8QBgpj6YRzWyPp8/l54AGRreh2Kl93nnWmwGXfA1g0FAgCeLsc7LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvYSJ72lKbuWDIQzHrsWuzLz0hjaJ82vJPGaKJapZCd5O6dVru
	+XyaBUM5rz7vyglH/QWbpyClIXtxdDhgec27q7yJa24Fw7YYfL1M17qNFwQW6PQ=
X-Gm-Gg: ASbGncu1hw0seme/xYA5iZWHngrrkvDSS0g30iXENTYMGJSXjFxZIzUETrrI32DlTpK
	14mFPgT0ZJOirEXeXWpSnG2wDZWpX+e00/C05vcs40UI94dorfqYfHPrik3Igw/X6HbAMApisBs
	jE99JcpS4rGYI6KNnW/H+J97hPHCzbhtielnEdXyGamr75ohTXQEeIQz1AnXs255Ex1y4Rvc4H7
	T/dcVZ8tW3VryGtC4diV5Oho40RnkbTWTEOrLLE5Qje2BEOnsvd+XfppREYdno5zHMhX7ZnzpNK
	8KxLxFUXfm4WeN7peb1jb3h019d9Ng==
X-Google-Smtp-Source: AGHT+IF8u/EmJRpY1cgIvJEM+EbW+M73tl7S5R2stGgnFzaxNtA80WlogXUtJNIeXD6qOocbR1VfGg==
X-Received: by 2002:a17:907:9719:b0:aa6:9c29:86d1 with SMTP id a640c23a62f3a-ab7f334003emr129760866b.3.1739377966988;
        Wed, 12 Feb 2025 08:32:46 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a697c2besm917631366b.151.2025.02.12.08.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:32:46 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] clk: qcom: dispcc-sm8750: Allow dumping regmap
Date: Wed, 12 Feb 2025 17:32:43 +0100
Message-ID: <20250212163243.237658-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reading few registers at the end of the block (e.g. 0x10000, 0x10004)
results in synchronous external abort, so limit the regmap to the last
readable register which allows dumping the regs for debugging.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/qcom/dispcc-sm8750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/dispcc-sm8750.c b/drivers/clk/qcom/dispcc-sm8750.c
index e9bca179998b..2c9714788739 100644
--- a/drivers/clk/qcom/dispcc-sm8750.c
+++ b/drivers/clk/qcom/dispcc-sm8750.c
@@ -1881,7 +1881,7 @@ static const struct regmap_config disp_cc_sm8750_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.max_register = 0x11014,
+	.max_register = 0xf004, /* 0x10000, 0x10004 and maybe others are for TZ */
 	.fast_io = true,
 };
 
-- 
2.43.0


