Return-Path: <linux-kernel+bounces-573048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B44A6D229
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32B1169D92
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579A81FAC59;
	Sun, 23 Mar 2025 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CFuCW/qi"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED641EF368
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769591; cv=none; b=ZudCDHoVX2L0qXGJxWOP8nZ6HYcxybTYROBY/nh71f0FNmRvroahWV7zPHncRd7aaVa1K/sqPJmZDDOr2n7fnR5xLyBZ5bs555Ife//lASno40NqGpA32rx1OFWaYOyOBktRUQfUZl4aJP5p7TpKdHTLn5Ru0OWICtYwXmugc88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769591; c=relaxed/simple;
	bh=wFMuIyuQV4OeONZ1CTvvoJlBLS9yPymppIm/9Rg9fR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kKH2ZRcXk+OnYDX84N6n+B1UBQEg+iIzqMObr33PaNfxrqi+bVEsXOoHEMPJEqAozalSHPg3sbWANvZuMoNFBZ6/rTQJSqIiReow+kb3WDFAce9eDGQtndZgRwaizGwNoz1bzEOKIrQprzGcfoG93SqMhelgZq7xDEco8KzvZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CFuCW/qi; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac345bd8e13so673832166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769583; x=1743374383; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qB2B+UaRvhzRZZ5Wx1Ln6+NaDhGt6Oe4sLGxlVN20j8=;
        b=CFuCW/qire8aywCE8R2nF9KA3js6JnqRjYn0LxXqEbLMqqh7gljrc1Op+LWpPpz45+
         nzeHo60ZbYx7hfxaW6PPbDGGL+2YfYb/J0n51c9SPiMhge0z7JKYD+WjSpwdGeJYGTNa
         rNQsoK5zJjgWkTUgINrZyBDXgUIE+XUVFIzMPG011L5tTLUEmtg31J6QxPCn72ykhYec
         p/vqLmTB/ZJP4g1WqtgCc3OzI3MfhfTPQeEj+4UcgigbR5Sz3iOi6pEu96uT6XI8NsV5
         lGZjddAI4UHYxZJYjL3YlbXMiLNNqSdDaE9XH1YU3iE/p/2C2Kl2Qc4SOzEvzMKH5+H9
         LX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769583; x=1743374383;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qB2B+UaRvhzRZZ5Wx1Ln6+NaDhGt6Oe4sLGxlVN20j8=;
        b=xQ0RQaZYb5mShicIcsl4M1Zu0v8MkFazpuC3QkERNBZGA7rwRZSM6sTEGcOfVSMeEI
         tIwhZtIdXqKaWLFNhw66mrgW425ewQK/VZqvoC//U1keb8nrE2GkAcPoFo//lvltYFlH
         H2+/yU7aoe1iprsR2hRoq1qV2EBioCde1fTN821SlwKzSuEkQTZvtMfXLNv3ltCNyvx9
         pZzn1tyCHSZkczfOw93n9vQfpXQDb+inOic3BMY0Syb1+5LVVskG2RfrfnnOz+h/q1qP
         Z1hC9Opqv68Nf0Lw59gCNcSGbrXSH0T5sUh64rBcCjrxL+xy61wGwDHKjNABXOc5xhdl
         mNQg==
X-Forwarded-Encrypted: i=1; AJvYcCWezyDxdNKpcK2GxSJa49eNLeo4lFwE4sNglPZqom6m4hTRqJm0/OxBRjo+gagUurdsNuUHtAWn74fQUo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0v9/3f2f/+gATvSRDEUUU0DvTxoyusZumVrXlekZ513oa12M3
	YWGaNH85y9lhW2Cy7yxsKT/E/nbcrdaOQypV/+QjkVukR0WgCFpaEKI+uINq34I=
X-Gm-Gg: ASbGncvuUbtYqM0OeMcgRVfpPc9Qdf8/IbOVk9P6qS0qeVjPvvMJwA11mqc0Xr+BveR
	+NA8O12izZlKyWay0eoZqrUCpY17xlC6y0EW6RuDyNiz5DLzk8mpNtBtJmPfO8MEfuPdzS/7O7N
	Q1FSC7fMwQAHI+EprRSPXlJ2BatBFJ/xhRTSsERFqYJecccidEwWm03lxZKXqdV1cG3L5z2k0ut
	Lc2bqAvcjV3kuXfFRhu/v52uitDRzGSMkJ9JLaSrk+kxJnUZ8DsyACzlr5u7p2gy3uGYNhnGPKn
	wc/v1eliJMJVB27ViZFHvqAzy69YsHCVswWcUYYDRO0+e2MxjWGcNsVrbK6ddhdpy3L8bWZvvvE
	H+HMYGY7y0wn9WDlHc1gS/aBWVZbr
X-Google-Smtp-Source: AGHT+IEqdMFkeJB9L19k5i2T9SHkqV7HBIih5q+Sk1+mGJp+qYtrcbGq+req37UQlXtoOfZvy9bw1w==
X-Received: by 2002:a17:907:da0c:b0:ac3:f683:c842 with SMTP id a640c23a62f3a-ac3f683c845mr1099102666b.42.1742769582647;
        Sun, 23 Mar 2025 15:39:42 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:41 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Sun, 23 Mar 2025 22:39:48 +0000
Subject: [PATCH 32/34] rtc: s5m: replace regmap_update_bits with
 regmap_clear/set_bits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-s2mpg10-v1-32-d08943702707@linaro.org>
References: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
In-Reply-To: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The regmap_clear_bits() and regmap_set_bits() helper macros state the
intention a bit more obviously.

Use those.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-s5m.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
index e8e442c503064eb4e570af5bf7dcff6bfa7f4656..fb65a8e439d72d9070751c00f5826a403ac0b416 100644
--- a/drivers/rtc/rtc-s5m.c
+++ b/drivers/rtc/rtc-s5m.c
@@ -338,8 +338,8 @@ static int s5m8767_rtc_set_alarm_reg(struct s5m_rtc_info *info)
 
 	/* On S2MPS13 the AUDR is not auto-cleared */
 	if (info->device_type == S2MPS13X)
-		regmap_update_bits(info->regmap, info->regs->udr_update,
-				   S2MPS13_RTC_AUDR_MASK, 0);
+		regmap_clear_bits(info->regmap, info->regs->udr_update,
+				  S2MPS13_RTC_AUDR_MASK);
 
 	return ret;
 }
@@ -351,10 +351,8 @@ static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	int ret;
 
 	if (info->regs->read_time_udr_mask) {
-		ret = regmap_update_bits(info->regmap,
-				info->regs->udr_update,
-				info->regs->read_time_udr_mask,
-				info->regs->read_time_udr_mask);
+		ret = regmap_set_bits(info->regmap, info->regs->udr_update,
+				      info->regs->read_time_udr_mask);
 		if (ret) {
 			dev_err(dev,
 				"Failed to prepare registers for time reading: %d\n",

-- 
2.49.0.395.g12beb8f557-goog


