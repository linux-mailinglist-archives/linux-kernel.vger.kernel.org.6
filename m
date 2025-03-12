Return-Path: <linux-kernel+bounces-557559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E52A5DACB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09CE189F516
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A0C2459F6;
	Wed, 12 Mar 2025 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lAwCkucf"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1FA2459D8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776255; cv=none; b=cuSAxnTsBbTDmZChWYtD2gXI+7c+wfdrscnlVCOvaVNcQz0SSg0uqUyco8ohwNCQjNdMJ1//wQdkRewEY+ycRonEeObj1MgmRIQrgLmbxyTOAZgMabnt61ovs7fsDBQuS9K5XaNTmTQeA4aEq4nNZ7Z1/kExXXCT5OlejkZOBVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776255; c=relaxed/simple;
	bh=9hXJ05Bllblc/HNvRr6L30WMFsTUsEOeU51KuFxzBIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eY0YIHKTPJ0W4hnofNDdiXX24BIlQi6pMpkJ+wp6arsLn/mwQXyq0eqvy6ZVa8MhfwGqhN5uXSlPBahoV+VDL/Mbkbmjc4RwnQ5lxD7pa6ZqlcaZT64GsTwhvohWeOlY+iGnvO8WwtMwkfJd1hsMGF4N+pRtR7UP5HLsZpyUC1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lAwCkucf; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so13837300a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741776254; x=1742381054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07NeGidiEoFI0vJcWncCuXXVE170Ua3zDu2V1ci+TTk=;
        b=lAwCkucfkAByoO8irfgFun7M00BMvmyymxIxyCUi9NyJCAJNin16elYQyOCm/G5Gw1
         Wj0+XT4ablczSmfsm4lO9yGxf0CQoGt0G9YldIUBCkqa1M3A029sepUS4ahkQwaE/bWV
         YRaslabLellu8hCSz4gYQQouD8/2ksfinqaec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741776254; x=1742381054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07NeGidiEoFI0vJcWncCuXXVE170Ua3zDu2V1ci+TTk=;
        b=AYVmSMwiPxQk1SpPkbJZOt2ukMDp4wHARg3AqEAG5v4CWl8n/6bp5ITHU/4pyx4AMd
         ao4yvWcp/AyrcoJIvpu3uN7XbZmtQx9fYB7S4d6HfDH8Voymmnedcyue/kOr2xPwl3/P
         JztesKL8JqQ8/Y5iGEhmdIBixEhkqV/Khk8EyM/qMOxRErg8yPFzZGREfmRmZQLaCYS7
         ef/LUjPsLyfYnxO/koUW5phXoPovD72RDr2pD9bgbI5Cytmi0EFRlkBCztMHBEJdyQks
         EHxBqrWVLnBPQVjwsGjxur5GmC1H5fR4YV5OIMcqU6iEQ72UZ5C80lK6aeJnuVdUEnAt
         NOcg==
X-Forwarded-Encrypted: i=1; AJvYcCXODORC/cr0SiJT3LNMMF89gH4zTip8eQ2V7Z+c8UNSYrX/TKyWKbicVitBAcffCHxD2b60R+HI150hJCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjrSHH0D0UutVBA/BcG8v0wmKcMZgtmASMcS0yg1t/rTJLSQkv
	hP2k7yj2KM6K/N9EU79BMEtihs5bB2OdYPXPOUtetOSoQpwEoYdapC7qg5Vmyg==
X-Gm-Gg: ASbGncvx/2h/DLZvnc+SKGyV8PzqPt0DMbRjWt5KNq5CXcSNeSYbKVA+WZsp19V12w3
	YoSxXWDQMWTIacj4O/mH9QLDbJ5pGEr4ZzKlDX5fcqJGL9y/yIyrjpC7dfcrICVa3+DOVGFjbsk
	aJgPjGw0uil7smqc2uIYgmRJLoodw6m8yp0ju29H+1ByMAgvuidduKCi0ixFvUgWkkdP62pZupy
	vos57Jlfr0pMWdJDErsduCE5WWY523GhS9/BZ2BP5EKTy871xTKj+A7uJ5aA9psJMjJOrylBK75
	38ES+WVCwdxq2yDYfuKUoSHoxZcJg6aAQ1zLyiS+aDoDQb82DgYEGO4atCscuaI=
X-Google-Smtp-Source: AGHT+IFSE2gHTCSWYPmLv3kDZjxj214O8BELRgRt+BaoekLoQKZE6r3o5wS+pqNMYHoEB24uQ1fVVw==
X-Received: by 2002:a17:90b:388a:b0:2ea:bf1c:1e3a with SMTP id 98e67ed59e1d1-2ff7ce94cccmr37763724a91.12.1741776253695;
        Wed, 12 Mar 2025 03:44:13 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:b5ed:b71c:fb14:a696])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3011926599csm1405675a91.35.2025.03.12.03.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:44:13 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 7/8] platform/chrome: of_hw_prober: Support trackpad probing on Corsola family
Date: Wed, 12 Mar 2025 18:43:41 +0800
Message-ID: <20250312104344.3084425-8-wenst@chromium.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250312104344.3084425-1-wenst@chromium.org>
References: <20250312104344.3084425-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Various MT8186 Corsola Chromebooks (squirtle, steelix and voltorb
families) have second source trackpads that need to be probed.
The power supply for these are always on and their reset/enable
lines are not exposed.

Add them to the probing list.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/platform/chrome/chromeos_of_hw_prober.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/platform/chrome/chromeos_of_hw_prober.c b/drivers/platform/chrome/chromeos_of_hw_prober.c
index c6992f5cdc76..eb01851e1cf5 100644
--- a/drivers/platform/chrome/chromeos_of_hw_prober.c
+++ b/drivers/platform/chrome/chromeos_of_hw_prober.c
@@ -57,6 +57,7 @@ static int chromeos_i2c_component_prober(struct device *dev, const void *_data)
 	}
 
 DEFINE_CHROMEOS_I2C_PROBE_DATA_DUMB_BY_TYPE(touchscreen);
+DEFINE_CHROMEOS_I2C_PROBE_DATA_DUMB_BY_TYPE(trackpad);
 
 DEFINE_CHROMEOS_I2C_PROBE_CFG_SIMPLE_BY_TYPE(trackpad);
 
@@ -84,6 +85,18 @@ static const struct hw_prober_entry hw_prober_platforms[] = {
 		.compatible = "google,hana",
 		.prober = chromeos_i2c_component_prober,
 		.data = &chromeos_i2c_probe_hana_trackpad,
+	}, {
+		.compatible = "google,squirtle",
+		.prober = chromeos_i2c_component_prober,
+		.data = &chromeos_i2c_probe_dumb_trackpad,
+	}, {
+		.compatible = "google,steelix",
+		.prober = chromeos_i2c_component_prober,
+		.data = &chromeos_i2c_probe_dumb_trackpad,
+	}, {
+		.compatible = "google,voltorb",
+		.prober = chromeos_i2c_component_prober,
+		.data = &chromeos_i2c_probe_dumb_trackpad,
 	},
 };
 
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


