Return-Path: <linux-kernel+bounces-230322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0B3917B40
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169C1281867
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2015316A92F;
	Wed, 26 Jun 2024 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="AXgM3s/B"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D48166319
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391545; cv=none; b=mZceujzynTTV2fheX+o6ULIXeRMNG8kIEXAzi1LQZVuADAffvFuEANAK6BUPv/WJebPfg6eGZihWw3COgDt9+EB2NEMb/FdJYHswdegnHIDuleRTT1qKHqvg8oJheV/UqKTXxIC14QNQ1SG3zJpqwLIkeziJB/FE2AHHredYbrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391545; c=relaxed/simple;
	bh=DzNCPz0l+qOT0t/ADA4oPjAIWHqdAm5rRYNgDCTIR/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G90u4dG1V8fFMnBKAfQdpy59erWCDxge8oastoq0v3xV0Zwyd9GG2qQvqkg4DZfX+8QmSjI0o76RIsHNcLCj1CCDd7tkbMcoMz11XJTxiD7o4S9jG6RmPTL/nP3Br4TwxGK49DstejpwkwE/3avpS/gP1fRkrMeHRSw9WtYDHAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=AXgM3s/B; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a724440f597so479019166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1719391542; x=1719996342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neUGPkJcfoHd8KdVXvztCJl9LwrUDYQkaArrGg63MBY=;
        b=AXgM3s/BCGsdre8yMo6b7kgR1Ntq9J7YiTRU0uLUzhEICEan5GNVvNbud5YKebP7BY
         Y4yKpQx7f3RLDDSd46Mc/R3pax+iFWmQaicoAcxmCd663AJCcjgM7kQHKhpG03VDi5Mo
         c8/0slWxsBYq6Jn1eXP7jEQw/NK3NdKdIB8CXmCpTC5LIudm9ji6sa6nhtRdvZzWd/w0
         ASSKLhq2FjYai91qvBZmV7vVUG8/RSpPzuI9IucB5nQrQ7Horm6CsIfpuMzfg91BuQN0
         DDGpPImlUnslpdI2Fs8QGkreXDkghlSSOCR5pUioLXWXw3k1w7SRLUNqnYifbjEJaMm9
         ZowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719391542; x=1719996342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neUGPkJcfoHd8KdVXvztCJl9LwrUDYQkaArrGg63MBY=;
        b=CMMUcCFc69ZHZ1uK8z1Kg+MjlLYwLn6N9pb5Dbgfs0z2LZ3dfWOBs40gh30lgN0PCT
         qeCYenZ0VcdL3Wo93cO7pxr0z3v3JAXsvBxNKTkBKzenp+XVAu8o/oHvFrS+zSrMu76r
         dchobULAwiqhPi49B5DKbX9YRVpexO6aa82Mvuv8EFB22RmjFwEKGgGESybIQiwnYtpU
         nh814jOFAK291QXpN8J0TgvBgfZstHEDhO26Fye4GVhSkCdEZwHymjxhYa41yf2q7jGP
         0D9DmXTFYohU6bO1CcC2J8f0EQU/gIUgFue2n4I+5fW3MXehvvjHTEwXDv6mj5f4FueV
         MmTg==
X-Forwarded-Encrypted: i=1; AJvYcCWFHCQfmDdPzBUMjiLqraeUqw5fbZwOkajcim5ls2p93Q+T7EQz0fMZXpU8pxWvC5AmI7p6Iknh798UTDrlLoxcwchqQFE3PNRyJcqC
X-Gm-Message-State: AOJu0YwYu296+pes6PRUL1IVcbM3KzwsIgTt76Xine7c4ZdaKIz00ihY
	XCmPKVDciM0slg1sPtqLuPWnkwRL6YoEHlb8be3BCVxepgftpxx8EfLdOKSCtcE=
X-Google-Smtp-Source: AGHT+IGDBef0WRtb0XJ8d8v5qL2Ie1rZUFdFV7B0czkJOt4XCBhN/gvVhIsedYqTp0lfpWm1P/r0cA==
X-Received: by 2002:a17:906:911:b0:a6f:56d2:8f0b with SMTP id a640c23a62f3a-a7245b6dc3dmr664354066b.3.1719391541930;
        Wed, 26 Jun 2024 01:45:41 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72605ff279sm218647166b.5.2024.06.26.01.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 01:45:41 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: naresh.solanki@9elements.com,
	andy.shevchenko@gmail.com,
	broonie@kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pinctrl: cy8c95x0: Update cache modification
Date: Wed, 26 Jun 2024 10:45:23 +0200
Message-ID: <20240626084525.787298-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240626084525.787298-1-patrick.rudolph@9elements.com>
References: <20240626084525.787298-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the previous review cycle the regmap cache update code was
questioned since it seems and odd way of using regmap_update_bits().
Thus update the regmap cache modification code to better explain
what it does and why it's done. This is no functional change, but
it's improving code maintainability.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 781949e0e09e..9a92707d2525 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -475,7 +475,7 @@ static inline int cy8c95x0_regmap_update_bits_base(struct cy8c95x0_pinctrl *chip
 						   bool *change, bool async,
 						   bool force)
 {
-	int ret, off, i, read_val;
+	int ret, off, i;
 
 	/* Caller should never modify PORTSEL directly */
 	if (reg == CY8C95X0_PORTSEL)
@@ -497,24 +497,20 @@ static inline int cy8c95x0_regmap_update_bits_base(struct cy8c95x0_pinctrl *chip
 	if (ret < 0)
 		return ret;
 
-	/* Update the cache when a WC bit is written */
+	/* Mimic what hardware does and update the cache when a WC bit is written.
+	 * Allows to mark the registers as non-volatile and reduces I/O cycles.
+	 */
 	if (cy8c95x0_wc_register(reg) && (mask & val)) {
+		/* Writing a 1 clears set bits in the other drive mode registers */
+		regcache_cache_only(chip->regmap, true);
 		for (i = CY8C95X0_DRV_PU; i <= CY8C95X0_DRV_HIZ; i++) {
 			if (i == reg)
 				continue;
-			off = CY8C95X0_MUX_REGMAP_TO_OFFSET(i, port);
-
-			ret = regmap_read(chip->regmap, off, &read_val);
-			if (ret < 0)
-				continue;
 
-			if (!(read_val & mask & val))
-				continue;
-
-			regcache_cache_only(chip->regmap, true);
-			regmap_update_bits(chip->regmap, off, mask & val, 0);
-			regcache_cache_only(chip->regmap, false);
+			off = CY8C95X0_MUX_REGMAP_TO_OFFSET(i, port);
+			regmap_clear_bits(chip->regmap, off, mask & val);
 		}
+		regcache_cache_only(chip->regmap, false);
 	}
 
 	return ret;
-- 
2.44.0


