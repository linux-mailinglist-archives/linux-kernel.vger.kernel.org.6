Return-Path: <linux-kernel+bounces-517873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAEAA386DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A8E164568
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADD2223324;
	Mon, 17 Feb 2025 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOfpMhxm"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B6321CA0E;
	Mon, 17 Feb 2025 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803615; cv=none; b=k7cGdpPJmElEYdYG4hzaNsCgwjqbAY2VwKaYlAEeMjfsUZTg/ZrDC6k0TXaUwykXqHQyESfUCCmnBiiVi5atVDP9torRvKre7NNXpVEWh/K+gLcSDxgN85kIVbd/GyvCmAa9ERXgXYlSFEhjM4ifQLkih6Tp87wp6WHwzHc0KGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803615; c=relaxed/simple;
	bh=He2J25PYapSdSVGECk+3czLOmeAHYAYgRABDmE3JShw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlwCgKVjmDqLmGyQU9OEJhc4XxlytW3wjNiFwi0mVNLMYCAyMAcoqdYBtKLhMNskGNO37UJIeO0uqx1YFxRbaiLYERHY2Lpy9rpV9mq/nf7j8VE6dwJrfEH8P7OhQht2EmI6L3a9L6+HhIVxg3igyGXaXfBx6IgYCFD+SnyVwLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOfpMhxm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso48575955e9.1;
        Mon, 17 Feb 2025 06:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739803612; x=1740408412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1gRK3Ew1hi0PFgqsl/YmhtfeV57oqbHi+ExGuEM3zt8=;
        b=cOfpMhxmS/RCzbNM3DZ3wF8QK3Rl4RsZWnukaleA4Vc94Ac8bXvpHpDajtIEtSj4ky
         zdgMY073j7U/n2V/ABBOwBCRs5sFRJslctQqjBUBjcZvOmGnHnn6NwTkuu6CffjJs/az
         MZ+KtLAwO5n8/vj0l5i7rCJGftrcFBLTSXHXhQyIpyvKfhOuD+V9IGmJlMfO5efroKpj
         RVPqwLn9xPmbKQ9VRkuBFrAD7dWZUJfbBSN3ggu71i6FiDb6dv0kDriH+VZjlOxWAxsR
         WnoipTZw8TvwVwqczB3nOV/1DEn7GhiiCAjKcBi/h+x1YzTMpTMG6MCLRZV4CSfOA9hq
         lqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739803612; x=1740408412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gRK3Ew1hi0PFgqsl/YmhtfeV57oqbHi+ExGuEM3zt8=;
        b=a/Yx1C8rvyKQSge+xEBsMvQCSCxzKZXN/LppCRUqD3YHJ0QLN6T8W/ULlGvjB6GqfT
         iDdGUeUEmbFsLzn7Yj1OORMVydxNhAWBHcbw5ulpQwo+s1RLx8snUOGktQbcH0oGdQ0o
         GSRhh2V/K2SFjcGPYV2tP7/blFUg2GPCx02lgUuL63Gh12/T76DGw8RRUgcwQRJ0JE2k
         Prc6rTkM9ywP7/9YmxgfsABYXPDPMC+DdLD79M7YbKOAZd45y+Z344k9RJ0WAqyjOlCP
         Jzj8dXLhnxovYIp7aqRspX0ytI3ur5XmJ9hy2ka6OjGmCzLfU/GsStr1DeIwFhS5brbQ
         QP1A==
X-Forwarded-Encrypted: i=1; AJvYcCV7zJzFz3IPkbOgpn+YV3owLgX5LjG/k+wx/8IZpt65m9KeDYqQbYsAbHWhkPIkBVSIGhbNuNiL0ehz@vger.kernel.org, AJvYcCVBufj6qxN4S37kC7VjQpiNtd2ZETOAjRsZ/0gK5ZG5FQ3jYEv+z7xzH1pJdgKNKYh8Qnz/7LGaY4CKbA95@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5kw+5IDusu6cs9zfmL++rusnzIdLOzOK7Vjp8zR0Xf0xSEcXJ
	fki0noglVT8BsrMW4HXSpnqM28oJn4xQdI2VeyWBhPTcvTZO3pm2
X-Gm-Gg: ASbGncuZRuftuTO4kdze2JlpU/ZFmVB/jV5dRYJE85nRS0mVkgP9NgJl4EJSjtKCNIW
	HViS4DcOZoIrDMTiul1ezhO2Onc3+W+uoW1q5yVqL+lGtFLa0uw8oxbYL1p8WpLaeik0hyz38GE
	9RIDQBNlQWxmiBXTZ5doX9K2UmTiSq1Ng1clg8F8+ZbR4sEU7kC+QwaVWPTEKU2ub+fR50NFLFc
	b4bZreIgBkCJePAR+VWK2WSM24kZ76uuvr8uVzEva+jG6vgH+xYxFLzdDTZXEMuoUAGUDVBEETE
	g+jofb1XF0nMmWrunIPN0I9NQCXIwpA=
X-Google-Smtp-Source: AGHT+IEvsVySnJ+l7Fovemaa+2WhfTAXf+xumNmEOKxOaoi6B4K38BG9ABeK/x2mrfAU1A28oIBrvg==
X-Received: by 2002:a05:6000:2c1:b0:38f:474f:f3f3 with SMTP id ffacd0b85a97d-38f474ff5bdmr3521133f8f.13.1739803611955;
        Mon, 17 Feb 2025 06:46:51 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:48e7:ac19:aeba:f677])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258cccd3sm12424688f8f.23.2025.02.17.06.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:46:51 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jai.luthra@linux.dev,
	francesco.dolcini@toradex.com
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1] arm64: dts: ti: k3-am62-verdin-dahlia: add Microphone Jack to sound card
Date: Mon, 17 Feb 2025 15:46:04 +0100
Message-ID: <20250217144643.178222-1-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The simple-audio-card's microphone widget currently connects to the
headphone jack. Routing the microphone input to the microphone jack
allows for independent operation of the microphone and headphones.

This resolves the following boot-time kernel log message, which
indicated a conflict when the microphone and headphone functions were
not separated:
  debugfs: File 'Headphone Jack' in directory 'dapm' already present!

Fixes: f5bf894c865b ("arm64: dts: ti: verdin-am62: dahlia: add sound card")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
index 9202181fbd652..fcc4cb2e9389b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
@@ -28,10 +28,10 @@ sound {
 			"Headphone Jack", "HPOUTR",
 			"IN2L", "Line In Jack",
 			"IN2R", "Line In Jack",
-			"Headphone Jack", "MICBIAS",
-			"IN1L", "Headphone Jack";
+			"Microphone Jack", "MICBIAS",
+			"IN1L", "Microphone Jack";
 		simple-audio-card,widgets =
-			"Microphone", "Headphone Jack",
+			"Microphone", "Microphone Jack",
 			"Headphone", "Headphone Jack",
 			"Line", "Line In Jack";
 
-- 
2.45.2


