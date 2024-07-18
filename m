Return-Path: <linux-kernel+bounces-256242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC193934B56
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4CE285747
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE6312E1ED;
	Thu, 18 Jul 2024 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ElxYlEfT"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B1612AAC6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296689; cv=none; b=Ysycm3tWCWG6KAWSQmjkR3qypR20Q+L8EECm3+UatYxlWXGIvWbiaU5n9XauEcCnWKBm80C5xcmI3YsgZfP/BEhDbiardGq7coI2c/C0C0rK66dvK7nkyNrnlRjr7YZMRuIFcTR0p3rCDk0r9Ur0R7/MU5nb6VQO9P2x1jqdOaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296689; c=relaxed/simple;
	bh=stfv6wCp8LQ8d3OZA86W362D/4yVzrX9ApYD5+7KnVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxHIVZafzDjLmS4f0IJ+E+yzSOVOyE1xyqTaIyNVdie/87JkEMFBKXXQxnpMmfQxeHsSPicsjVErt5X/HTuVwrB0/FAaemNGapD+6PIvYRYMtEOIpx3nWpRAnqwtFBGs87UtmyDH0vZl6DoeyV0dsCju6hs9Y/tCQS8VuvINfjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ElxYlEfT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-427b1d4da32so896765e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721296685; x=1721901485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHnjFErAgDASCliWVSwJYSmFcBoJAvgxBHMIXQRsSBo=;
        b=ElxYlEfTeZq2CEULhjr8+kxylhjbHDBkXHo4BdUbKcrIdQ/ItoLIpzAEgLrg6ZHb4S
         aaCzTTo0AVAIgdFpSAWtQMzkkLF9HoNGBQVDZT63hC8Yc+OBkEhIkXp2fGxe2hVektOm
         MJXxE2Hx2eJsjAxkIxjnjTSDe3opnV5gG7oZ9oDE9yp2H9cXSv0UIgMiM3t/4BcaU7VI
         oHqmplvZX9exqnWV0AbACpqZEkjZ+oF88APYoUHigglMz3939AC/66ShmA4knR0pJyCw
         nuTkE7P/EnwEbX0l6h+ZWCX1vXhXjNHREKSOYpBrTU5Sf12+E/4fNM4OmDxKYXD3PemV
         o7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721296685; x=1721901485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHnjFErAgDASCliWVSwJYSmFcBoJAvgxBHMIXQRsSBo=;
        b=LDcg0yaYFU6p3ue0hVS0sxq0blLgCs8LxAbVHkaf2gW5XidRjMK1ATX8jwF8CeYUxp
         pa8H0HDY7JPWVUXeAPEvvNQiUmGy88Ea3+3NsUIIRE+LQClzauCedNO7OZe2qloCRIYS
         nRO+1+uJukIs8WLV63qvhnh0pSlfoAsfrB4iVr6JwHueEv9guKe+dvGesbgk+DdDZ5Pr
         OjElO6taUbg5llyCtWHFvnoVf4Frth2Mpfne4xy4ZWSn4wKNDZnREeK6kFAf6S1YbkFb
         xWhDD8zIH6O+AgEmNfUNU6YW1k1bTvjvmnXBUp7oVJMpqfSLXwkj6Ia8uUW2gchWfNrH
         d7AA==
X-Forwarded-Encrypted: i=1; AJvYcCW8taAgED83iyXIOq0CiEkEyXfBGcXyWxjdCz98wXXR8Hs4SjGnxikp1jW1poWBfBMCAPpxeds6tvonqcZaNowCcAf1i4wuyttJieyo
X-Gm-Message-State: AOJu0YzXSlUDgp+sk79U047toaQclEDsSVW8aS94nMhc1YNuHVGkr6mt
	PaTtu/lHmjx9l+HIz/cvbIfE5iorOqGR29ajQgggosiWD2KpKisxO4YgSppuOyM=
X-Google-Smtp-Source: AGHT+IG8+Imv2pZJ1VDWhnhTTaOQKKCKWkuYOQ3logSxOWNN3Qv8MGDFasB5Wj/12nLcm5NH0GyuVw==
X-Received: by 2002:adf:fe92:0:b0:367:940b:b662 with SMTP id ffacd0b85a97d-3684b3c82e8mr1763009f8f.31.1721296685057;
        Thu, 18 Jul 2024 02:58:05 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:8d37:f44a:c212:e320])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3680dab3be3sm13837155f8f.24.2024.07.18.02.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 02:58:04 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v2 2/9] reset: amlogic: use generic data matching function
Date: Thu, 18 Jul 2024 11:57:46 +0200
Message-ID: <20240718095755.3511992-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240718095755.3511992-1-jbrunet@baylibre.com>
References: <20240718095755.3511992-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

There is no need to use the DT specific function to get
matching data, use the generic one instead

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 8f3d6e9df235..cd7dff5bff61 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -129,7 +129,7 @@ static int meson_reset_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	data->param = of_device_get_match_data(dev);
+	data->param = device_get_match_data(dev);
 	if (!data->param)
 		return -ENODEV;
 
-- 
2.43.0


