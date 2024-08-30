Return-Path: <linux-kernel+bounces-308958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10A596644A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9830EB20A33
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED261B2510;
	Fri, 30 Aug 2024 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bRWv4l8r"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD041B1D5A
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725028624; cv=none; b=X6zkCGPEbBjlSNvTa5SUMYuR+skfj2NaTw896Fvb9gVPxn85Lg35mAUi4UTiGx7KH9N2uWSo9oi/oi2sMiikNVHsNNPA+S1n4v8RTYkw/HIAC5mtI5GZWTWtU1V0y9dywzWnFXvm+eUNLqNTAyjVzq6GubMB+SxWQOlVaPxqMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725028624; c=relaxed/simple;
	bh=6DJ4mwdZqTyn+tCBTzm9Nt4MFTRGoqfAUGU4OJWiSPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RXM8Xu1TVDJrBHU2tnIFM/HY2lqIFoMXeIUntdIkEX8ciwjSmZxCBlkfPkZTCiN77TZouKgV/3pyGffX0ZUK+o5k/zk1pL6Q55XEnEX7uQne4C+BrAYVGh/yUzsRvxHooBkWk6w9C0Im/160MYOLlK23hFmI3OxpN/TXb6TZM/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bRWv4l8r; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2050b059357so15540675ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725028622; x=1725633422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hVGFtc4kbH/Z7yqtrPYtyKUgQC3PRuwLn6BIajvZoto=;
        b=bRWv4l8rs+inO6G4b2v0RFfqQwx6b1GVkLXMvt4cE3BtTgV6PzlGtUIhwrP0qDdW+l
         Q8850itHeKMxONyE8VuxUYKU02FYnSh2CGkX6MsN4XEstDEO9snFIXjXOkuzt1oA1Sqj
         anM+9kULzAPnB/6sydd8t7kdXFVMP2phanguE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725028622; x=1725633422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVGFtc4kbH/Z7yqtrPYtyKUgQC3PRuwLn6BIajvZoto=;
        b=PCHB7xDNc9wloZenZDY/IbiBlTRoBNXiCqFrLWHUwudNoNe9bbbwFrdRrzkKb7Fppp
         B6R0wLLSc3rlp6F5uyDO43hh2TtEEudsStF+31kf1OlPg7o+VejadkU+wijCR+XI+85p
         anxRdf8ML9FF3UVWJyKlHwB3IIFRVx3Txpv9YS/7U0+kQTjBVYuzyYjsT4oU5LgrwTq4
         DIil8VBt/MwWcwGQHTxke6vFOFZX1yBxkVISO4xVOpgPwPQXZ+JE7/SJ/mypvhPy14dD
         k7BkyL4U9YUpKt2k0HvhXV1HKRQ/vEuvsx7JR9vTmx3JCfymLKke9NLVh+M5HVqUVC6R
         cbQw==
X-Forwarded-Encrypted: i=1; AJvYcCUHTueZtr05NquUpbOP4v9f1N/E5jPqLywb6zlT3cFHuPiXYXMCbAoL2xCmN4r44Z62+iN/G/VugtWIFqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUE+0sQC3bQErS8NYMkurGidfrgQ19rQLoOrXcWTP3exvl7VV7
	eHK+zZIRefCsxjyZIuvz4le93APVyuImoSRxy0CSs12oKNk25UJwPK67e8Or5Q==
X-Google-Smtp-Source: AGHT+IGP6SDvpMqfxS3K75/5XYUOBv7vIBL6yYiKATWxkoAlTdnFF/xsDDuA76lReR1HWMHHMH5SwQ==
X-Received: by 2002:a17:903:1c8:b0:201:f9c1:f543 with SMTP id d9443c01a7336-2050c3b979dmr87360535ad.18.1725028622087;
        Fri, 30 Aug 2024 07:37:02 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:8144:c259:d49:bb8e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b3117sm27628785ad.47.2024.08.30.07.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 07:37:01 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	kernel test robot <lkp@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: core: Stub devm_regulator_bulk_get_const() if !CONFIG_REGULATOR
Date: Fri, 30 Aug 2024 07:35:12 -0700
Message-ID: <20240830073511.1.Ib733229a8a19fad8179213c05e1af01b51e42328@changeid>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When adding devm_regulator_bulk_get_const() I missed adding a stub for
when CONFIG_REGULATOR is not enabled. Under certain conditions (like
randconfig testing) this can cause the compiler to reports errors
like:

  error: implicit declaration of function 'devm_regulator_bulk_get_const';
  did you mean 'devm_regulator_bulk_get_enable'?

Add the stub.

Fixes: 1de452a0edda ("regulator: core: Allow drivers to define their init data as const")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408301813.TesFuSbh-lkp@intel.com/
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/linux/regulator/consumer.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index d986ec13092e..b9ce521910a0 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -452,6 +452,14 @@ static inline int of_regulator_bulk_get_all(struct device *dev, struct device_no
 	return 0;
 }
 
+static inline int devm_regulator_bulk_get_const(
+	struct device *dev, int num_consumers,
+	const struct regulator_bulk_data *in_consumers,
+	struct regulator_bulk_data **out_consumers)
+{
+	return 0;
+}
+
 static inline int regulator_bulk_enable(int num_consumers,
 					struct regulator_bulk_data *consumers)
 {
-- 
2.46.0.469.g59c65b2a67-goog


