Return-Path: <linux-kernel+bounces-323455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30788973D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E06B26AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06E51A3BC9;
	Tue, 10 Sep 2024 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gkOpf3OF"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702E01A0AFB
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985988; cv=none; b=JsgrQahuQZy2t+AQzBSgfGaJm75JRKCj2nJfGYmVd7CS68+wTfncuG1ptZxcNui3m+++ryTfuLO3hbRm2S38QpDUvUnk+5UPexIUPrWw0RHz9VwnM1o7RiuXoNNKG3hJ8Banw4peU1gzlh4NcC3ys7pnt94Rf7sNhG87tiNAD7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985988; c=relaxed/simple;
	bh=I6joFYKtEZpmpOu7whQFwYwYWPHiUyzVlrs8QkUbiqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K4kXLgmAH6fsZzSvNIaDnOGIKJxdavLUCNPv72y1rxEXMF1AnplwRNYObS0leQJ2TT2F3PIlEPzECmbto8ksElb8Vbfq9/v8PxgLpcoE4ekqYAVIX+YvLGYxBn6rvzOyTzat8/dirtjYQdgWE1dARYC3c5ZnJVnPG4aUR8l93xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gkOpf3OF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374b5f27cf2so3417419f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725985985; x=1726590785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdCiYPdjlPcL03UXJdJSn9R8TB2L5xNznH8+xFLLXME=;
        b=gkOpf3OF9jGzM2gLvpMYuUFMeHaGCxEAvxvg0lIPA4nKdn2BhWWyj5OOGl54KFVd+E
         i3JZZ0EHURRUwSv4Ranf7lymdKFsMfDFwKjELce+KuTACJlKlyvFKTQHcIWy+D0QvTHv
         mPbEj+rE2AbNycypz5ZCQZSioYHxAGr2bmffer+PY26z3tA9bVlxXo2xW92lndFfgohV
         7Z+d5xEvOdB+/2X9A13H3LBnoQg1WHfYDFAl9f3DcRoumEulAuccemwd1PqIV/zOvubW
         E1lWtuuws1cMA+Kt2EgGcN6blXUa9+RuzVEbhtz89sF6b4ocEfnCVSR0tTXSEaj+l/ii
         qtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985985; x=1726590785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdCiYPdjlPcL03UXJdJSn9R8TB2L5xNznH8+xFLLXME=;
        b=H0b4ejrtAnORbEz7kCEigPL/S96WYLdAGDQArKrq9aQ9j0QfOZwOmlM2mShufJUOTL
         hBSBF1iblGKW9uHYeEJHOgzjlo6H/mfRV/4tRTT50TQMJlP00gABJukZxNIw9aI/VPGy
         mUNBwU5BnKknM5PHc7OsxmqT90WkEr/9EbInxMfUlIxSMguf5G87ghtYRB44/w8S6hRm
         NR9byqblwMgqfLRMUJlJo6oQN6WNtNIbVMXlDBt7QiWQw8SsY0A0Xm8Vak2wMbJ/aePw
         wkli/YbiYF59sQ731cUbOYZjIfTHFzkwB9L9mZoiqgEvVm5fR+RGQdrhhR8TcvJA2vX/
         romw==
X-Forwarded-Encrypted: i=1; AJvYcCWPFSDGs1MCG7b2XUvlDNZ2qLh5iT3EK/TewIEY6rySOsXmd8Cye89RPdSO6dHKkRCUmlVlI/6DPWKwPGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDbjtSW+5rOUr85aJ68bDJGmzvn6xLySF7C/E1PjBhg8wc0P3+
	85e85y3DkOjFilpJWNhuMWeet+dfCRGHzXomEfptBjos7DCvYa34rc+Fy+aCn64=
X-Google-Smtp-Source: AGHT+IEYJJaHk2U/FX9vPPozpXuXIiqpvUnZX4hJXDjt5ixtTHSPLiv++R22SrtDiFbpcEWrBAzjsg==
X-Received: by 2002:a5d:4fc4:0:b0:374:c23a:2ce8 with SMTP id ffacd0b85a97d-37892727bddmr6243973f8f.52.1725985984538;
        Tue, 10 Sep 2024 09:33:04 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:8ba7:bfe4:fea9:65b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42cc1375189sm25076025e9.1.2024.09.10.09.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:33:04 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 10 Sep 2024 18:32:45 +0200
Subject: [PATCH v5 3/9] reset: amlogic: make parameters unsigned
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-meson-rst-aux-v5-3-60be62635d3e@baylibre.com>
References: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
In-Reply-To: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=I6joFYKtEZpmpOu7whQFwYwYWPHiUyzVlrs8QkUbiqU=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm4HS2itiARGZrvq/tXETgO2AUVYcuyrsCp7sa0
 TH9q3ap+YaJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZuB0tgAKCRDm/A8cN/La
 hYasD/9S8uCMfSuqThBYflvkEd3zYbAGGV2FKUHajNLbUZ8VsNZkd12w8M26sndSWIOKHfuxjX9
 +6MJOUuFzPgOtJGf4SRvnrbuxybbEHDCdebuH/cDExu+w851pesycvMjHWytEecEw0NXZjwtP8E
 9zCL7KqqImvL00hVnKIYeTFhV/RCFMwkdmmPHx4AJk2FC47EWJiBJY3dtTzF9qwnyPnB+0HebwO
 6Qq4VpsarQpb1fbJk3zdq9fNxSAQOPf6YNZN2C5A5/91iokwBBx9nguKnZkRpLg/I5IjnuyvTG7
 wDVcRM+P1jDrREVS/mbt4rS0LpPtPowBIs02f1hJNSAQ+8Jo1k52QCiA4BpHWZ5T7KQycPBTzof
 BJF9Lh4CFKTTV/oA45QIkebSFA1ME6YH2UbRRT3cMEdds1PwIMWQpD/u/DtoUzZsEVIYGMA+Lr5
 jkz9xuf0oJaKnaQ4UzDD/ctFZzCTnoCvIem12B7njHXYOlJST8dm/Jpec+EdrAWLQUmmEz4M312
 7ZqkkW2jymzi/jvgNHor7I904jwR95vulk5yYyWujz6jb/2xBpM7dmKMBr4+vcVkfUI4N8QjuSJ
 GZnXwVTDvf8+a/M4zGQn6ENeqirvhTx5idTF2OrAfvEublCWVlY8LdTsv+pLuB9Cc0ttIpPRPY/
 K5THCKSgsv9WOTw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

register count and offset cannot be negative. Use unsigned integer
for this.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 848c2d88503e..50bd2241ef2f 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -17,8 +17,8 @@
 #include <linux/types.h>
 
 struct meson_reset_param {
-	int reg_count;
-	int level_offset;
+	unsigned int reg_count;
+	unsigned int level_offset;
 };
 
 struct meson_reset {

-- 
2.45.2


