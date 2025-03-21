Return-Path: <linux-kernel+bounces-571661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA74A6C04B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF0416BAE5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA9B22DF99;
	Fri, 21 Mar 2025 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZaZtDSSk"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534CF22DF81
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575284; cv=none; b=DerbbekApWOTs9laLZbaW4RMq4r7bstMlOUqBZqSsg84nLIB16yuTAFPpCKTkXlveOppcoGrcf8DKo3ZtXialoAjws2w3AertUWZyxnjGQoPSGSVDpfKTMtfozZCl7hnMjHet0pvIa4m/lcsTKz7/Yr8BST63/ETMGOP5jrpek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575284; c=relaxed/simple;
	bh=hWUyFAm/NQQwMKBx9+Vamkc7xZdb1GiT/4B+V0cKFg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UTmyBJ7EeJlDYD9RpODuewrS0HoJRB6/Q+iD2pTQMKuP1lEQW0SBuBaqzpTDMKMTogwFleQxZtB8SnNhYZZOMfQf3PdzgLrbNoiKMYqeKgh11qEVl5V3WHqeNc3sMeSO1VMEK02Cf59Yx6O2jIbXz8ycxn0uWt9jXURyXMovGQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZaZtDSSk; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so367894566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742575280; x=1743180080; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/oQ5hD1cA9VD/VPcz8yv6T4aW7gPvF07IV6qUGx1gU8=;
        b=ZaZtDSSky47mc1/J9uXS5+EmHUdREKFWmnwapAGmE85j4yU/pqL3rEQ2AeoqD1Fe0Y
         oDrXnnyehSYk686AhgV+0bdtXNtTckwOfNmAmrB4v13XH6/wrQ8OcCgO0T68TIRLkLW3
         356QtMpM6zPh1SIMSFFoO0HPcS/SG8TmNn0CwgdgeKq4i3GUkaA6dvu1tovB/uhiL6qU
         usFHq6uu5orlxWpf8TPtLKS/hev5Vw6iRkAfCZDxGmsZmBAcEp+m2uCUNFyg8YSlm+r+
         9NM3zAx53vYAiauFQ1hS7jbOHJhDMS7tic4iqYVAKtXgHwivLPcql4UX1CKJoXNPMjih
         u57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742575280; x=1743180080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oQ5hD1cA9VD/VPcz8yv6T4aW7gPvF07IV6qUGx1gU8=;
        b=gq7Eap6J/4OVISSom/HxADRF+z4Mtkkh1fm55+EknAXUXaAkiunwtqdwjS1J3G0gIu
         U3k7QkgN5/N4o2hYCI+y5dIkPQtLkkNGiOjRJav6puY9mQqU5MYRwfIIcnmJypKryMsl
         3UX4e4YeHRB3MFcEVUYkU1vuF1HKPfSIW2FKbnOXB1g7RgoJEmdLcqJI6n/UOjD/c0AM
         uP5J4ZO7TBlmv7gS9TGsbbxY9A6tGHIF4H9Avs4cw+SLOAeQuCF+326gKo+R18JoDX4a
         1cGJ14XjCOlVVTbyQ0Kyo7bowcixNn+dCKmqcPresoAcwLjnzfPP2b3XbEMadfgUFXIy
         EH2w==
X-Forwarded-Encrypted: i=1; AJvYcCVbifgbGDNihjsGhsjCqEuaUx9HzRVcLhTTt7GhTmvILcIEkZFCRklVBkgjTREz+Dqw/3yfn3yYo0//g4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ89qOcSIMEFHIZywh1WUiBQwnTTG7p01ADgCJIsufvN0u7tTt
	LVSa/+DkvNBLAWgguRf8Ea81AjWxYmh6gpIhnYLaQwPW8WjmxqJcAzEAIiz99I4=
X-Gm-Gg: ASbGncusbBiA43Rwm8rZwiAm+9P5zPssBD2t6hFt955OUk+AhDyl3ZixZ/pBZ06cOgo
	tH4l0XhP6vlLDXfv0sGC8WjFpzWMl7eCgZoevxU/Lp+LCyv12Pr2cFYSe8bYqFDWxTJMfu/fvuj
	DaFrkR45kIGvOE07etOpdcTNmcS1+ZPA/u4hIUvsteqcO+pCIU84n/CKgRvXnI76o1DaWsAT3sZ
	jgUXZRCalfNDmezp8jdZnFfw1L/eBT3yKexmBdOJ+GrsHQ3MybT7dD/cH1UJZDufvp3vf81CMni
	0k8ctxBYwfpXs7qtbY8GXGMRpTOZoURfaz9r/I79RuaIdWHytFDWVTrh/qtZK6yqBo4k7ayoU71
	5fXCgoYlDj5hHjRXP16cJ8gCwXBLh
X-Google-Smtp-Source: AGHT+IHAwCySYHv7J4LG8oqKj+pJ3kDHG2FjXW74oHg2qd/1H+0+7k4RIohqqkos0sYylQOT2uGzTA==
X-Received: by 2002:a17:907:2d87:b0:ac2:fd70:ddb2 with SMTP id a640c23a62f3a-ac3f2086f35mr381559166b.2.1742575280417;
        Fri, 21 Mar 2025 09:41:20 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbdc78esm184015666b.134.2025.03.21.09.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 09:41:18 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 21 Mar 2025 16:40:57 +0000
Subject: [PATCH 1/2] firmware: exynos-acpm: use ktime APIs for timeout
 detection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250321-acpm-atomic-v1-1-fb887bde7e61@linaro.org>
References: <20250321-acpm-atomic-v1-0-fb887bde7e61@linaro.org>
In-Reply-To: <20250321-acpm-atomic-v1-0-fb887bde7e61@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

acpm_dequeue_by_polling() uses a loop counter and assumes that each
iteration of the loop takes 20us. It may take longer, though, because
usleep_range() may sleep a different amount.

Switch to using ktime_get() / ktime_after() to detect the timeout
condition more reliably.

This change also makes the code easier to follow and it allows us to
adjust the sleep without having to adjust the loop counter exit
condition. This will come in useful in a follow-up patch that changes
the delays.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index a85b2dbdd9f0d7b1f327f54a0a283e4f32587a98..d7ed6b77a957af5db5beba7deecce13ac7b30fd2 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -32,8 +32,7 @@
 
 #define ACPM_PROTOCOL_SEQNUM		GENMASK(21, 16)
 
-/* The unit of counter is 20 us. 5000 * 20 = 100 ms */
-#define ACPM_POLL_TIMEOUT		5000
+#define ACPM_POLL_TIMEOUT_US		(100 * USEC_PER_MSEC)
 #define ACPM_TX_TIMEOUT_US		500000
 
 #define ACPM_GS101_INITDATA_BASE	0xa000
@@ -284,12 +283,13 @@ static int acpm_dequeue_by_polling(struct acpm_chan *achan,
 				   const struct acpm_xfer *xfer)
 {
 	struct device *dev = achan->acpm->dev;
-	unsigned int cnt_20us = 0;
+	ktime_t timeout;
 	u32 seqnum;
 	int ret;
 
 	seqnum = FIELD_GET(ACPM_PROTOCOL_SEQNUM, xfer->txd[0]);
 
+	timeout = ktime_add_us(ktime_get(), ACPM_POLL_TIMEOUT_US);
 	do {
 		ret = acpm_get_rx(achan, xfer);
 		if (ret)
@@ -300,11 +300,10 @@ static int acpm_dequeue_by_polling(struct acpm_chan *achan,
 
 		/* Determined experimentally. */
 		usleep_range(20, 30);
-		cnt_20us++;
-	} while (cnt_20us < ACPM_POLL_TIMEOUT);
+	} while (!ktime_after(ktime_get(), timeout));
 
-	dev_err(dev, "Timeout! ch:%u s:%u bitmap:%lx, cnt_20us = %d.\n",
-		achan->id, seqnum, achan->bitmap_seqnum[0], cnt_20us);
+	dev_err(dev, "Timeout! ch:%u s:%u bitmap:%lx.\n",
+		achan->id, seqnum, achan->bitmap_seqnum[0]);
 
 	return -ETIME;
 }

-- 
2.49.0.395.g12beb8f557-goog


