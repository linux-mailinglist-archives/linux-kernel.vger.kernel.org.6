Return-Path: <linux-kernel+bounces-407258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6B59C6AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE64B24AFC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE3E18C002;
	Wed, 13 Nov 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="0QsHFDyL"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D54618BC05
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731488071; cv=none; b=h4Y8uvp7dZ2xDUhE+rDBndYtpRsil4qpIlB4ReFijIJ1f48mU6An8D2UHrBBnqBoqppboifbaWDmENLe52LplP6LikYFdR5P1nwCZgv81Gcsi88LStW18eQEvZACcO9oq2ny79FQguvXvAeYw+OGG0xq5b1Ir56nZ293TIYoCBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731488071; c=relaxed/simple;
	bh=5rZEVE8ZG2QG5VfVFTqm/2+0sB7OhE8B8hdHzbk+2lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ED4GV1tBgHeCr7J5PX2noHk0jBjs6wg98Rfc8mDTG7lihvR7B2bylFAb+VN59g4xBY+Mb2v5Q5iH3Qt0sajNPEMw4QFauDGBVW8rFkQmjaQNvHrHPKytZ2mLywnFoi9PcdTxs0J68u7TAybW5rAFt+TK/kBfF1mkzuT3oi3MJTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=0QsHFDyL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2bb1efe78so370329a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1731488067; x=1732092867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/QQvBKfHWcx99S3MFyn6CIdzyDe++fvtDF8fIMsYbQ=;
        b=0QsHFDyLWvXErQ78o3GVBKaQtkrJzd0M40782OJXHR4s4TdgUvDDnRo0k0bNAvedh8
         TaFiDD0Daw/fymOSxOWQb4aAWv1fYV9awwLKxoR301YP9/LpPFv7u+cY8mBYeJqCl7Mg
         f89bvKDzdmJ6mGTHV3dnSu3Qo66Sjdr0VPnxKeUVL5aJm5KmdL/JvUJYFx6daX3S7jB0
         hsQ8/I0uD34EHsXKZvuJ93cDkkzAgN+L1keBv4aL+n1XEsDy1aHFTPoWQ35grMKTHKVW
         Roqo54OYahZLNsk9tGBBl2PS5Hir0hUJTqY6i5WZooBcVNPCi1/M1zAwQMzEafAH4mlL
         +brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731488067; x=1732092867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/QQvBKfHWcx99S3MFyn6CIdzyDe++fvtDF8fIMsYbQ=;
        b=Dia9tQOwhqM62w7wfSxPrA3IL6hZrZnaL9TEgiTBFBiWaI2UDQSITEd/5ig/pSR6NM
         OOvrGegngEjD0YTBzZRUnjQ6/N8lDOrMMmsJBZ3JPSrAQ8uYYDYGrrwvrxIcew5yruHC
         +NkjvV5Lsct3Nqy9DlKWpPRIu9RaJ06CEr9ejJl06kI17QDJ34PCQEwKCH52tWALLOzF
         4WeeM8pe3XUQ4ks0Qkzlme4TC9IqTXHXpQju3yFdqoayW2u4omf17jPyJV1pCjAlgaou
         f7btWnudjXgi5si8Dtyp1z/yYJAGh/F6etqOSMffIl5VMP/e9lmKKCL6AAIuiONbbakt
         JhAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5n0JKxzLsUlbzj3iJizZoOJXa20mMEEsXMcwHZTtKs9QOmGR0VuQYK2fnphoxX/LkiI0N4ZVqn0VfvHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR/3KVaimRxDF2AKpjcEmvUl7sUQkboXMG0OjQQrul7kQMbac8
	qdy7qsQ2QlnXXNv45i8733bT3RGenxL0qHRUzPoFP6iH3f3zyHI9C9pSL/IT
X-Google-Smtp-Source: AGHT+IE88wJlLPAh5zibBEt5ecTqueLIppGyqpsefbMEfjjtHXPO/LKkFBoqmw1dPbdImmuU0m0nWQ==
X-Received: by 2002:a17:90b:4b88:b0:2e0:f035:8027 with SMTP id 98e67ed59e1d1-2e9b1ec3ad9mr27550774a91.2.1731488066639;
        Wed, 13 Nov 2024 00:54:26 -0800 (PST)
Received: from localhost ([2405:6581:5360:1800:a83:68dd:5f1c:4ed9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3e94e8esm957843a91.3.2024.11.13.00.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 00:54:26 -0800 (PST)
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: linux-rtc@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>
Cc: linux-amlogic@lists.infradead.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH 1/5] ARM: multi_v7_defconfig: Add RTC PCF8563 support
Date: Wed, 13 Nov 2024 17:53:51 +0900
Message-ID: <20241113085355.1972607-2-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241113085355.1972607-1-iwamatsu@nigauri.org>
References: <20241113085355.1972607-1-iwamatsu@nigauri.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are many ARM dts that support RTC PCF8563 but are not enabled in
multi_v7_defconfig.
This enable RTC PCF8563 to work with boards that uses this.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 9a5f5c439b8791..139b1c6fa656fa 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -997,6 +997,7 @@ CONFIG_RTC_DRV_RK808=m
 CONFIG_RTC_DRV_RS5C372=m
 CONFIG_RTC_DRV_PCF85063=m
 CONFIG_RTC_DRV_PCF85363=m
+CONFIG_RTC_DRV_PCF8563=m
 CONFIG_RTC_DRV_BQ32K=m
 CONFIG_RTC_DRV_TWL4030=y
 CONFIG_RTC_DRV_PALMAS=y
-- 
2.45.2


