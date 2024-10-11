Return-Path: <linux-kernel+bounces-361324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1D999A6D2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99BE51C21B82
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F97A194AE7;
	Fri, 11 Oct 2024 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="efParbGW"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C217194085
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658121; cv=none; b=Xr+iyimvp0q6IrNacIjoQ9HqWFqyFWilm+veNRAoMHEQ8YXC6jm4XFb/kwai8C0LymFAcYY0VBZ9lk7ResIUgxi3WQHyHUsWpFvKmkbHV0CWykrviGDqIGbAtaHpBs5Nu2r+ZsYabt+0RskRaL3E57gPqGepVixP/umLkAqIS+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658121; c=relaxed/simple;
	bh=vCAthdAHVhbrVJ4dzxNhL9OQ38Q3l8lgUPnhH8VC4F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GK6hifn/C8riU+f5Rq4xBpKU8ioMz/Yy08bTriUNyr9m9T0IF8TkMbFXNKLIcM1EmTih26IuuA9nCwu2JckX61GcgUQxAqkipXn82ZpBLquToSJKg+cYH1CeL0asdm9S2neiWokcfU+iI15sG7seysErcMVIeFfRoN5DnDwo02A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=efParbGW; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AF93D4064C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728658113;
	bh=iqBh7nzoh4RgidcVzY4detvGARn0I3+5VA/OmJU1Iu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=efParbGWB01VrjoKWpz/zHaR/jKQjfxq8jGGzHc+H2nPhNGpic6Xuk/vzmYkk3qJb
	 xNY0B/ytkO1bePO/rg/gtfE2+yog5n//h0QjeFgtpAovHErreu4MwlD5AyuBRQ+z6O
	 NieG3BSYGXd2+YP7b9UhC5btzNtQ75wbI8AGVPiy8nZM1HgUD1yLs+jNlOgJv+1UW+
	 wHYPU/UHRw5JsVTaR0plpXBP7+uHhMHRe3EQYFLkl17jcmr1XFRQPNEAh+cC05cB9l
	 D6dMRCveDiTdEOkAWQkFSYL8D9MCPx5Z5IKarXZ8EzudWue6ANhlm65iiWozTqEyCL
	 MDKJanLrW67WQ==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a996be26171so337527366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658113; x=1729262913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqBh7nzoh4RgidcVzY4detvGARn0I3+5VA/OmJU1Iu8=;
        b=PD42uOZa7TaPwTgZJ8daR8ViIDn70IOstO3FeYejNC6oe6Y4T447Nv15luq6T06N9x
         jGnyLOI7z4cxGAA1JfFG0QTBiLrJS7sAyUPpPUlYqyjELCDxYApSN3CyjopC5PuckUys
         ZUnwYSDoHX7TrkVq7Bm9/HoQsWPRwqH2s1OHGGjmceQdDRIi8NrtEcphSFoBmJ1PMNSB
         B03RcdiAFVyeGDoZe74jtCEBawdpFkhT/B1e+QZSTmC0uwDoHhoMdAyeIpg9dscNJ1Rj
         LJzdQn4WQZPWj8LVVcMmDW7iL5gSXQzw1k/RW1tU7eL2YtspQ1Bq8Rc3lNZs4PID+W4P
         bFqg==
X-Gm-Message-State: AOJu0YwcmMNeBXB9yUsaSuUc/OuPueU2yQX0Z4so71pxuC3rc2+iACW5
	vyRXtgJLks/Td9KLYg85ZYV7RYh0BYKlt3bVqCzeQe/I8kd/gPQfL/duXIutOLL+/UdcYfJapXv
	bA45+WDp8tjMfB0GUJ2pRVXvG5jnjvoYHXYTsxdsu6PRfn0G1Y7jPEqnvGqebU/1WgSCRKH/exw
	L172TvRVVmzg==
X-Received: by 2002:a17:906:dc8e:b0:a8a:6bd8:b671 with SMTP id a640c23a62f3a-a99a0eb825dmr782896866b.5.1728658112568;
        Fri, 11 Oct 2024 07:48:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjQsLbc6u+mCW6UAgHzZ7I5ogU9vr//qu3BpEYvisyFo1ZiWCcvFSN+KbnXtVt+gsG6NG3Rw==
X-Received: by 2002:a17:906:dc8e:b0:a8a:6bd8:b671 with SMTP id a640c23a62f3a-a99a0eb825dmr782893866b.5.1728658112081;
        Fri, 11 Oct 2024 07:48:32 -0700 (PDT)
Received: from stitch.. ([194.62.169.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99c0c89bfasm54134666b.162.2024.10.11.07.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:48:31 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: [PATCH v1 3/3] pinctrl: th1520: Factor out casts
Date: Fri, 11 Oct 2024 16:48:25 +0200
Message-ID: <20241011144826.381104-4-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011144826.381104-1-emil.renner.berthing@canonical.com>
References: <20241011144826.381104-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Limit the casts to get the mux data and flags from the driver data
pointer with each pin to two inline functions as requested by Andy
during review.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/pinctrl/pinctrl-th1520.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-th1520.c b/drivers/pinctrl/pinctrl-th1520.c
index 8bd40cb2f013..7474d8da32f9 100644
--- a/drivers/pinctrl/pinctrl-th1520.c
+++ b/drivers/pinctrl/pinctrl-th1520.c
@@ -152,6 +152,16 @@ static enum th1520_muxtype th1520_muxtype_get(const char *str)
 		(TH1520_MUX_##m0 <<  0) | (TH1520_MUX_##m1 <<  5) | (TH1520_MUX_##m2 << 10) | \
 		(TH1520_MUX_##m3 << 15) | (TH1520_MUX_##m4 << 20) | (TH1520_MUX_##m5 << 25)) }
 
+static unsigned long th1520_pad_muxdata(void *drv_data)
+{
+	return (uintptr_t)drv_data & TH1520_PAD_MUXDATA;
+}
+
+static bool th1520_pad_no_padcfg(void *drv_data)
+{
+	return (uintptr_t)drv_data & TH1520_PAD_NO_PADCFG;
+}
+
 static const struct pinctrl_pin_desc th1520_group1_pins[] = {
 	TH1520_PAD(0,  OSC_CLK_IN,    ____, ____, ____, ____, ____, ____, TH1520_PAD_NO_PADCFG),
 	TH1520_PAD(1,  OSC_CLK_OUT,   ____, ____, ____, ____, ____, ____, TH1520_PAD_NO_PADCFG),
@@ -590,7 +600,7 @@ static int th1520_pinconf_get(struct pinctrl_dev *pctldev,
 	u32 value;
 	u32 arg;
 
-	if ((uintptr_t)desc->drv_data & TH1520_PAD_NO_PADCFG)
+	if (th1520_pad_no_padcfg(desc->drv_data))
 		return -ENOTSUPP;
 
 	value = readl_relaxed(th1520_padcfg(thp, pin));
@@ -660,7 +670,7 @@ static int th1520_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 	unsigned int i;
 	u16 mask, value;
 
-	if ((uintptr_t)desc->drv_data & TH1520_PAD_NO_PADCFG)
+	if (th1520_pad_no_padcfg(desc->drv_data))
 		return -ENOTSUPP;
 
 	mask = 0;
@@ -793,12 +803,14 @@ static int th1520_pinmux_set_mux(struct pinctrl_dev *pctldev,
 {
 	struct th1520_pinctrl *thp = pinctrl_dev_get_drvdata(pctldev);
 	const struct function_desc *func = pinmux_generic_get_function(pctldev, fsel);
+	enum th1520_muxtype muxtype = (uintptr_t)func->data;
 
 	if (!func)
 		return -EINVAL;
+
 	return th1520_pinmux_set(thp, thp->desc.pins[gsel].number,
-				 (uintptr_t)thp->desc.pins[gsel].drv_data & TH1520_PAD_MUXDATA,
-				 (uintptr_t)func->data);
+				 th1520_pad_muxdata(thp->desc.pins[gsel].drv_data),
+				 muxtype);
 }
 
 static int th1520_gpio_request_enable(struct pinctrl_dev *pctldev,
@@ -809,7 +821,7 @@ static int th1520_gpio_request_enable(struct pinctrl_dev *pctldev,
 	const struct pin_desc *desc = pin_desc_get(pctldev, offset);
 
 	return th1520_pinmux_set(thp, offset,
-				 (uintptr_t)desc->drv_data & TH1520_PAD_MUXDATA,
+				 th1520_pad_muxdata(desc->drv_data),
 				 TH1520_MUX_GPIO);
 }
 
-- 
2.43.0


