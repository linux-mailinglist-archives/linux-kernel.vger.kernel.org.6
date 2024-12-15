Return-Path: <linux-kernel+bounces-446303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6109F2251
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 06:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65E51886A6E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE3922334;
	Sun, 15 Dec 2024 05:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXIwXjyb"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037F5C13D;
	Sun, 15 Dec 2024 05:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734241020; cv=none; b=M1f4u80mPqr/1/MLaNje+nWGHgWVtWjv2PxFtDqbufa5zRkhrrDXs1pYPrXIeK2PGGSqJ6q9G3irwypLkKv/7vPGhLTNjlLPXKjtGen+dLoJE+5AbuueWEKssp51gn3MgdKRXRnoFxjbzShPAV5+CkhbNTxbQBW8edXI+TUpO4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734241020; c=relaxed/simple;
	bh=vD0k3JGDE0A91abw/IgokKvF+uGeM+sDMvZDAxLCVjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NH4pGcCI07z8b0kEmVx/zm4uiAm+lPNdKoQ0KWqSQ1aOwqDcjMKB/3I97V+TBn1U0x1CC4WW9unop3UNtS1LAl4YjK238cFmbJXCImNNVU8zffBs4HI2FNHCc7ZJF36htyxcMVBcbVUoCwzGCeMk03OUGnwfTyaQjlXfH8pa6ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXIwXjyb; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so2223732a91.0;
        Sat, 14 Dec 2024 21:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734241018; x=1734845818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWB9xUbuC9ZZF7GN4R9hjYXfuiqehEyAMCDY4g5eDqY=;
        b=HXIwXjybD9PoRgFkA0WtvqRdRHy2iJkBp1uUkmMGY89gg7ohVwuO1N9e++aKKgod58
         w214d1xByuSFJZDChlg3BJiWxZjQpEjms99RxL1jzXt0EBhUvxtg78lOYAjCjoEySJr4
         yWJE0xe7JsSAoY4zD3RInDgcksEXKjmltNSKODS8UoFNYqlvU+aJ79afWZVUM5FMUno+
         K19+ZdFxgjEOkiaz9Zgf0EF9jA7tbD7VumLE29g3MSy0KdoMEebgGffZOcaIFu7REbuU
         DGlGUb97MLLWZTBcgJ8hR52hpCBK+zcQNy0+7wfvYi7U9DdQTvmpV7++2FrfHrZAaoi6
         JCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734241018; x=1734845818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWB9xUbuC9ZZF7GN4R9hjYXfuiqehEyAMCDY4g5eDqY=;
        b=ty3HsSB0zsY16Z64mN2sMZaefOzmJ/KFGfCMFF+3PjlcOc/OleM51SRJMekWVrp4lB
         SNMGGvnkm6lsMEGiEzDH7L09JjgblVO6Sij5zb46hQ1Uqkuuo1VEOjjbIGvBmFQ6eeLa
         7R5abuAXLnUKRL9L7W56N2luu0KZz0Q+t5qvpxhsKxf+zoyHkjCTGd8EYBbhrSp15TA1
         XrZuuJ+JfA8sTMhNKJ5tJVdp92pRFz8WJBrMgKF3E+0Ylp1SSj58G442ah4jE5uRJiVp
         QpFE1JA070I/cPIKj/IlmbIc7mjVZr26wcAJ5/07NSqG1NoclKFpu1lwuGnKU2E6Isi1
         Kbow==
X-Forwarded-Encrypted: i=1; AJvYcCUYgMygnSAEclXJtNMv1oArq3i9WrYjqNKGRJrLehBHK46Mu2uv4HsEmTUE0uxgm80n4yXJAKaCYGkX@vger.kernel.org, AJvYcCVsyESHUUxd5a4qFBkwIDiHkJbm93CA3ezBLDS51i82cCOb7Ccoh4Ew3lwGJ84Z/KasXU4jeIDgpK2u@vger.kernel.org, AJvYcCWdts5NPz1i9SsDgJx9BJK0gV1ar00Kq1koErKfzRlNW9yY+woGMKTwCEEFLIsBHtJG0GxYusNbwjXbWmmx@vger.kernel.org
X-Gm-Message-State: AOJu0YzrqlIdF88fsjg3eNi+H6Fh7pqViv3C/cAe7w6p1bB5cCXX/anw
	IeZhNUxzJn8mQ1y2JvgFUecLM519+fT5PwBIJ4+J45cp1T01pcA6
X-Gm-Gg: ASbGncvClhoYcRjyjB801FUtLymjVZyXH6XVA2wm6S9n6TIScCrmaoF5rVM8JEka39u
	/lfNgakR1UOwLgRm7OfSc5lz1UKadTGodXlTjnR92628tJvtL8XYQm7ZcXKoccaFjqfYoZk7nWJ
	QXHEHhiPSn5rSfxLJ8vL8hziTx8fCgMUbTEJ+2oMFG2CQPExDnhu8tEb8C2H0UtDb15FoX2NNmt
	jb/9WteuvoaOEa1+JmtG4i19jGcJGJMZCMzQNiwOxlshEvzSA==
X-Google-Smtp-Source: AGHT+IF2jjiTuuQytVaWgmoT11AJ2AJQUADdSWheU2GdN/FSM7l8KDl+72eN5xP8lMEWk1y6CvNoFg==
X-Received: by 2002:a17:90b:3e82:b0:2ee:edae:775 with SMTP id 98e67ed59e1d1-2f29153c0c4mr11837653a91.3.1734241018179;
        Sat, 14 Dec 2024 21:36:58 -0800 (PST)
Received: from anarsoul-xps15.lan ([2604:3d08:7780:1ca9::398])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fa1cf8sm5729803a91.38.2024.12.14.21.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 21:36:57 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Roman Beranek <me@crly.cz>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 1/3] dt-bindings: clock: sunxi: Export PLL_VIDEO_2X and PLL_MIPI
Date: Sat, 14 Dec 2024 21:34:57 -0800
Message-ID: <20241215053639.738890-2-anarsoul@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215053639.738890-1-anarsoul@gmail.com>
References: <20241215053639.738890-1-anarsoul@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These will be used to explicitly select TCON0 clock parent in dts

Fixes: ca1170b69968 ("clk: sunxi-ng: a64: force select PLL_MIPI in TCON0 mux")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.h      | 2 --
 include/dt-bindings/clock/sun50i-a64-ccu.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.h b/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
index a8c11c0b4e06..dfba88a5ad0f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.h
@@ -21,7 +21,6 @@
 
 /* PLL_VIDEO0 exported for HDMI PHY */
 
-#define CLK_PLL_VIDEO0_2X		8
 #define CLK_PLL_VE			9
 #define CLK_PLL_DDR0			10
 
@@ -32,7 +31,6 @@
 #define CLK_PLL_PERIPH1_2X		14
 #define CLK_PLL_VIDEO1			15
 #define CLK_PLL_GPU			16
-#define CLK_PLL_MIPI			17
 #define CLK_PLL_HSIC			18
 #define CLK_PLL_DE			19
 #define CLK_PLL_DDR1			20
diff --git a/include/dt-bindings/clock/sun50i-a64-ccu.h b/include/dt-bindings/clock/sun50i-a64-ccu.h
index 175892189e9d..4f220ea7a23c 100644
--- a/include/dt-bindings/clock/sun50i-a64-ccu.h
+++ b/include/dt-bindings/clock/sun50i-a64-ccu.h
@@ -44,7 +44,9 @@
 #define _DT_BINDINGS_CLK_SUN50I_A64_H_
 
 #define CLK_PLL_VIDEO0		7
+#define CLK_PLL_VIDEO0_2X	8
 #define CLK_PLL_PERIPH0		11
+#define CLK_PLL_MIPI		17
 
 #define CLK_CPUX		21
 #define CLK_BUS_MIPI_DSI	28
-- 
2.47.1


