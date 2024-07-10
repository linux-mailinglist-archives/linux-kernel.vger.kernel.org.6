Return-Path: <linux-kernel+bounces-247916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A0792D649
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2961F215DD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD53195811;
	Wed, 10 Jul 2024 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cfiw1nN2"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27550194C65
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628744; cv=none; b=Ygzq0obwLRvVGvGbCIDJmmMGjK+42j2Fwgsz8OxpXjCbi/doJktYxD8eKuewY2ND/MusdW9UG8U16uZZSGpMa/B+YifJ8NXWT1PA1fEOZ99OAh2JtXPW+3VI06k2ViQRd5Srqq6niUM2Z0waZKQ1vLbb8cBH7p537m82FXLAINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628744; c=relaxed/simple;
	bh=G+dvNYQOBLr+WoKmLXh98J7Aryp0MXfhIBc7+yfe0sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9qu9ixT2yLa6RNuAWHL5J81WX4Veqaq4/v6TXMj/jXx1OGxdvXFxs0YOEYh5dxB4wnzOwXb8nBgmf2NQRUle9pkg7zANV1vE4jwVkF+zTo14qWZd27HQD/KuByouuSHI9YzPQxH/j80wWINWaPRdy4SmaYZlkBfAnsp6VsicNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cfiw1nN2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4266b1f1b21so22067225e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720628740; x=1721233540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypBfZt6woLl48yZMYWLwJnxD1n063j94AW3SXRtrghk=;
        b=cfiw1nN2l+n0NtGqQDbJ78cuqjAZbQIuvGBIa05C8RKg2q6Xhj4mMtYMgmuwzaR5xw
         c0QnUva/2XNWm8s06iYu6i4xDhqSNczZlrbl7yuuJi2L3q3z0S8E6zphmpsYLhNMf04k
         kvhRxSbL+8bB8FJEKHYgCNOdA1zDkhzS0F9Qe5J2X+UeFYOZYgI87YDSIWumEBzg67s2
         6r61/KeAUAf0LCmWPgEVO5qxF9Ogs2uAoY40n9HP6gLaauCAwtOVfxNi4d9HaB9CDVhE
         saMLWpjnmLMlkwwOJnwm2Bgl4UMdR2byaDHY2f8nbKlHzGcxC4sc33/OAPOi4cREHAX0
         QqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720628740; x=1721233540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypBfZt6woLl48yZMYWLwJnxD1n063j94AW3SXRtrghk=;
        b=VF3EFK9hoDAR84ePRFixZxhYD666rmp/mBlMjHa9IKzcaBvS+OLUQdaMHjjhTWwKBM
         dLwwteq4kT+8tVE8hGXKhD0xHk/EXCeOzeUdPqEwTVe0wP/gCR2xQ3Ml0tLnmt11rtAs
         +z7fXyqxVdA3Lq4LPjYTx1NT4C2/8aTx/SnNdS3q9nPowRUpQmqIEGVrfd4/Dq1ONTF8
         jN5K9P845GCaEItfA3EzUQ5B4P27O9u4jhthRKou6LeU9mKOyaLEt0AI8FLV32juFdmM
         FTcxo5bqGaL7jYLjxGcHRnvH40G377tTJ6h8283jllRfNpmyZhgkeBSJgbEe51P2h4Qd
         6OYw==
X-Forwarded-Encrypted: i=1; AJvYcCUDe1TLfosdp2fEHAQv1OS7k3nktjkPTk9IiBIjcEkm5BLk5z0r671nV5z/mmZhBBDELBC0P6eaocSla0Uaep6vlYYMUw92QwauK2uc
X-Gm-Message-State: AOJu0Yy4pmCcyj3W2kvAy+r/Yxca9FAdQjGR7o3oZhxwstu9hKq5TYvF
	PdrzFv/bFw6GazKYahJ9VnEGj9BMKcaLdwCUuQcv9De91QijyFGtO5X7z0wfgsE=
X-Google-Smtp-Source: AGHT+IEY6Gw5O2963Scyj/oRKu7QUIVR4X1flEdWrgEg+3YfHL8aVdfzQffvR8CC//15Yu303pOoSg==
X-Received: by 2002:a05:600c:63c7:b0:426:5f0b:a49b with SMTP id 5b1f17b1804b1-426707e360fmr36598765e9.23.1720628740679;
        Wed, 10 Jul 2024 09:25:40 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1c99:6356:8466:36cf])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4266f6e09e5sm88693815e9.5.2024.07.10.09.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 09:25:40 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 4/8] reset: amlogic: use reset number instead of register count
Date: Wed, 10 Jul 2024 18:25:13 +0200
Message-ID: <20240710162526.2341399-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710162526.2341399-1-jbrunet@baylibre.com>
References: <20240710162526.2341399-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

The reset driver from audio clock controller may register less
reset than a register can hold. To avoid making any change while
switching to auxiliary support, use the number of reset instead of the
register count to define the bounds of the reset controller.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index fec55321b52b..3e0447366ba6 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -17,7 +17,7 @@
 #include <linux/types.h>
 
 struct meson_reset_param {
-	int reg_count;
+	unsigned int reset_num;
 	int reset_offset;
 	int level_offset;
 	bool level_low_reset;
@@ -90,7 +90,6 @@ static const struct reset_control_ops meson_reset_ops = {
 static int meson_reset_probe(struct device *dev, struct regmap *map,
 			     const struct meson_reset_param *param)
 {
-	unsigned int stride = regmap_get_reg_stride(map);
 	struct meson_reset *data;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
@@ -100,8 +99,7 @@ static int meson_reset_probe(struct device *dev, struct regmap *map,
 	data->param = param;
 	data->map = map;
 	data->rcdev.owner = dev->driver->owner;
-	data->rcdev.nr_resets = param->reg_count * BITS_PER_BYTE
-		* stride;
+	data->rcdev.nr_resets = param->reset_num;
 	data->rcdev.ops = &meson_reset_ops;
 	data->rcdev.of_node = dev->of_node;
 
@@ -109,21 +107,21 @@ static int meson_reset_probe(struct device *dev, struct regmap *map,
 }
 
 static const struct meson_reset_param meson8b_param = {
-	.reg_count	= 8,
+	.reset_num	= 256,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x7c,
 	.level_low_reset = true,
 };
 
 static const struct meson_reset_param meson_a1_param = {
-	.reg_count	= 3,
+	.reset_num	= 96,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
 	.level_low_reset = true,
 };
 
 static const struct meson_reset_param meson_s4_param = {
-	.reg_count	= 6,
+	.reset_num	= 192,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
 	.level_low_reset = true,
-- 
2.43.0


