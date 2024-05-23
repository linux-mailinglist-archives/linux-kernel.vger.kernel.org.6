Return-Path: <linux-kernel+bounces-187141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA898CCDB1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F54BB22108
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9434813D265;
	Thu, 23 May 2024 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VnEYlMwh"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D80213CF9E
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451357; cv=none; b=hx7lDTUZYobcJtjEUjhFFZUZLkgyeg5MOrLPOfVCWIdTCIqafVfLf4mA0IAb3zGq5weVpbLRI+eyv35oCNG9ZE7ue/K+cNgf/OJBlO8dZaTsON3pAodBNitfZaboeH/bHQrPxI2TCR6nDhDJum6vCa5mhx84MdWunt8rBRgEWso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451357; c=relaxed/simple;
	bh=n8HeudbjliWXaBQUvD9BlfeZlqMnARef/edVZd5Ox0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XWOyHVOcWRWtt/i9Q3ykxvXiSI10P3b7S9H4o2pkfs8m+uSqMEA9Pade7sOVIdpcjm4/Xo8WXvfB3WlKNkEYCUIkP0VROtxT+Ozqx4p0voCoZ6CcgtoYU2WP+boy7snGWNGl/PEpnNbFSD8e463wFiqWS7pr75vpXCPcTY0AsGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VnEYlMwh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34d8d11a523so4005739f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716451354; x=1717056154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlxxT6O8N73c9hvaUpQrlj0G+RWv6RhO/OTBz0tylgY=;
        b=VnEYlMwhB3YrE1zWm5QkIj5YAazLoezxbNzVT0GL3bduaFBHR/NLOexFF23sL06ZfI
         ++qZY522ZzDJxVchGSynObBz3QoVbz0v4mG4gbFXSRi2mx1c1YKlkg1S4BZOt4VwpJMT
         eEFVz4Z6WpENy7fC1Fg1iTgweH1WZNqkw289SPlKZzafCXoGltm2W7Iv8LR5eZsVXZvd
         U6k2eXNNis4U2JiJ0Xc6M/c2C/83abP02WxpHOhe4fLJOs3Fxh+Zw0y//vgUuj2pd1eu
         fLDEa3tc9x0wv/6SLCRwna4WfVqtrpStidrvDLKQ36pa+ZRhVBQdcH60O6tj07r4Pvyz
         RuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451354; x=1717056154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlxxT6O8N73c9hvaUpQrlj0G+RWv6RhO/OTBz0tylgY=;
        b=bXYw0s+/3CFEIiB5qLWUg7Fm34FSPJ703QKrTo2cUyFMZXVWjdD/DkG0PBWbPlzn9J
         IZ/ppvuwLanMeDCyORWK5j6hENWj7gj42GFFl1HrSk9UfuAj2lam5YgoWKeTk9pf17dB
         pZdfMzdX+lt6bovmh3yMo8OD8o/dUF9gYTIYte5s2lWSr6n+fqRIWmBbfi0m6uqDHGTz
         4MdektZ71ieej8wcmXGrVhrcp24XzzoWfeHD7mU8XW5dmCI82Ld6n9h9vGbiqs9QeGEa
         bYuc8tUGo/k4WR8ep2wg6kXmsLjZM7TY7G3CBtj+YBvYK5CzR8C4dhPX0r9uABeBZ+pW
         MRjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPHUvh3mtZvzRVu6QFqPQwuvpy1OiL+0vKw2L8vCQMtPFMeKMGNxoZXLoWR/yZP2KTif0Iuwwt/mFnWJDzGh0jD5phsB/TV0aROoNo
X-Gm-Message-State: AOJu0Yy8juamodYDiFYr4GNgJFKIokr9G9Q8gs+OJ2PWUYRPm8MuOT0T
	ewbUY9kLRMzga+WCM0TTPNIG2egK9z6ZYrmI8h1gSUfHUx3gtPxV2kUyLiRlGUQ=
X-Google-Smtp-Source: AGHT+IHha0spuQLWF3mRLOAXmYo6c3Nk7W94QQizRM9z1j60uMb1s3ETcJpRBzV1BunMRUTV4mflMg==
X-Received: by 2002:adf:eecd:0:b0:34e:34c5:2312 with SMTP id ffacd0b85a97d-354d8dade41mr2802684f8f.59.1716451354367;
        Thu, 23 May 2024 01:02:34 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35501abfdddsm93637f8f.110.2024.05.23.01.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 01:02:33 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 3/6] arm64: dts: ti: k3-pinctrl: Add WKUP_EN flag
Date: Thu, 23 May 2024 10:02:22 +0200
Message-ID: <20240523080225.1288617-4-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523080225.1288617-1-msp@baylibre.com>
References: <20240523080225.1288617-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WKUP_EN is a flag to enable pin wakeup. Any activity will wakeup the SoC
in that case.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-pinctrl.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
index 4cd2df467d0b..e36bce881f44 100644
--- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
+++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
@@ -12,6 +12,7 @@
 #define PULLTYPESEL_SHIFT	(17)
 #define RXACTIVE_SHIFT		(18)
 #define DEBOUNCE_SHIFT		(11)
+#define WKUP_EN_SHIFT		(29)
 
 #define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
 #define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
@@ -38,6 +39,8 @@
 #define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
 #define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
 
+#define WKUP_EN			(1 << WKUP_EN_SHIFT)
+
 #define AM62AX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
 #define AM62AX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
 
-- 
2.43.0


