Return-Path: <linux-kernel+bounces-303033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64174960663
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9625A1C22764
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C4319DF5F;
	Tue, 27 Aug 2024 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l3CuIDeR"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DAC19F461
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752572; cv=none; b=VAyHv2r2JP75ZzoYiwitJytGhNdTgWpu4wb4MGtDBOND2wTVcqBlpRphPoISzeX0NJVYoNn/HaHAvN08BCmGDX2JSBctzd5CWE1sF5CZvkuaVB7sWk0txLwx22elSPZVRiMW6czoSkmnlk6UxQ8SzYf/TpncH8CKZEDQHpeDn0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752572; c=relaxed/simple;
	bh=9nC5Pd3Zk8GhLxKe+1Y1HlO8qtSqLygWM4QVbLXpa4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YH8baB4SjdF/FOr+/7DhCWqbB3qD4zkxuPYR6Tu2rLdwzyEkkcusRxvI+tAzv7LtPufN29hwheRk42sRzFaUeMutckAaZFXCwmUn1jcx8kS8yCIK1mioP/I3XkQmFNIpw3UTb10S0Hw3GnW2vBFVEN1xWQAwVxc45hBU1fhFaPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l3CuIDeR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7148912a1ebso1288583b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724752569; x=1725357369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kEjsRoTrc9YEAoIm4fI2W5J5jFppY9yqOw4qUfYcYc=;
        b=l3CuIDeRzoMor0oevmRuhbTgDKvkOrYdZI2eBPUqvBnG0pF3hH/7CSJSogTBvB311a
         kADZun+/7rEl2JzeEPj6DvGwyAKfzmWLB+Hdy084b3oVXwFmc3pqcQKdkQDRxy/IVn0x
         DI4+amE+3Hh0MDBVLmEKtnxPJyWjogJxV9lpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724752569; x=1725357369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kEjsRoTrc9YEAoIm4fI2W5J5jFppY9yqOw4qUfYcYc=;
        b=XrOgGlcjlubrnH9jAZHv7/ZdzaFaWkATb1iBY8Yzjc+9D9d0SV6SD7t8HvVBYSoy8P
         hPeXniF4n7XTEygFVNCN8yxdrZ2ouKBMiXlACGWcJq4t3BKkDFwBuAn5QJVNGst4/sI7
         gZkjlpAl1k4AFJIjP7xjKYuNxINLSqJ5UBiSsk8dtePikBJI9wkYLc9RKOGyIjEzdezp
         F7uz1612pq7FyaxocbuYmlJL0bEJcY4HOjOnVLoEWBKeT029KROEDydGhplx+cIENd7M
         R2/M6TISdrpBuI6yltmxxocnLrQ1dJLJRZf09QYRS5xtqznsgI+LAzsngg91yIPAtkl3
         wOHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7yqhRDohx++hi6vws3++oNfXy5rc7YANtCqiZXwKgjCu9/gjm+dqKMwBLiZ3HwGfoHUbEDO/a+Is6jlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1XanIQtSCVDHFmMVS84LHM7xz0XtkgSsUfgWuIPCAlXdsyBJ7
	KgesVm3kzP9TfiH48NNIiYIFOGgLEMHn2Aj+MRGn+L+3efGum012G6DrW8VBzzPg4hDys30mcjA
	=
X-Google-Smtp-Source: AGHT+IEkDjIQuJoQ6kCa98vVLTWPO/VYtGd1/XSnCdwwHvl9WI+e65ZCQr6Z5uPOx+2prdu3WCvVxQ==
X-Received: by 2002:a05:6a21:33a9:b0:1cc:c2d5:f9aa with SMTP id adf61e73a8af0-1ccc2d5fa66mr1778594637.4.1724752569071;
        Tue, 27 Aug 2024 02:56:09 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:3102:657e:87f4:c646])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560c2basm80006775ad.222.2024.08.27.02.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:56:08 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 6/8] regulator: fixed: Fix incorrectly formatted kerneldoc "Return" section
Date: Tue, 27 Aug 2024 17:55:46 +0800
Message-ID: <20240827095550.675018-7-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240827095550.675018-1-wenst@chromium.org>
References: <20240827095550.675018-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-doc complains about missing "Return" section for kerneldoc of
of_get_fixed_voltage_config(). The kerneldoc has a description
about the return values, just not in the format kernel-doc wants.

Convert it to use the proper "Return:" section header. The existing
description have been reworded and moved around to fit the grammar and
formatting.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/fixed.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index cb93e5cdcfa9..1629aa525ef2 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -158,8 +158,10 @@ static int reg_fixed_get_irqs(struct device *dev,
  * @desc: regulator description
  *
  * Populates fixed_voltage_config structure by extracting data from device
- * tree node, returns a pointer to the populated structure of NULL if memory
- * alloc fails.
+ * tree node.
+ *
+ * Return: pointer to populated &struct fixed_voltage_config or %NULL if
+ *	   memory alloc fails.
  */
 static struct fixed_voltage_config *
 of_get_fixed_voltage_config(struct device *dev,
-- 
2.46.0.295.g3b9ea8a38a-goog


