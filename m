Return-Path: <linux-kernel+bounces-348171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93AA98E3A9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BDEC28363A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2561215F74;
	Wed,  2 Oct 2024 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AQnN4uzr"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAD91D0430
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898299; cv=none; b=MpREVo3OtujVed0wUj3n0BRH5ZzE0OEr3/W+gY8hG2lhObCwvoX4I8CGUqL3tSBk3lWmzpJIMxL4t1uGRzAz9434Zx55ZSLcRlpIbqY/gO4JBf5KTKvW88F/gAoR/u0x8dNFP3uPXy3Z2hTDI0JWlPFfEaqdBQ0QMPOzCpQ7vkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898299; c=relaxed/simple;
	bh=wR03qyv3rnNLJ4+4W6CR03em8xujXadJ4svo+mPVpy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FfbiW0LpbWBeMD1zqVCnf3QMfCbK1AOSDzOc/RdRLei6MDt3guxVizz+o9PStHGEwTsjkpNFpd6Kgpo1ut9hxI/Rytr+FTKY3uv8h4YXGC74oGUZ5Lh852T0XigjzPQS7kJQeSbYBPucwxKk2NbnBGvlJmH1wVe8Sbvh1a+59FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AQnN4uzr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so855965e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 12:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727898294; x=1728503094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eaZBiLx4vvQaF78fB45OuDsdyRmEPlFfuMU6svXdEjg=;
        b=AQnN4uzrUqBroPS6kk2CUw1Ga+FN6puvtxCHF5LTwnQVpjcRk1TgWZwmdLMDOYut1i
         gBLKIdHza6SffT6I00e+EAywVQlEZHI0qzoQLdeDFeJvQRahhMA4iMOfBXRJhxpaK11i
         htvRxl87qG5KXSeQD/SD6MKlXPQ2Q3PUoibsYHQCIwDC7smIVXgfzPp3dWnjIG/QrVlF
         CLIuGjB7I2ou26W1fYKoqrQFJsvhhecCSnbbPgpqSUi+sn9k+03OiQoz3a9yhmRwr1QR
         MOLEVg7/hMglzxbUYQdEjFo47FPzaMH0l9Pw2grVz8YGEvKBTI44XPCmB0w6W+oMgnBe
         PLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727898294; x=1728503094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eaZBiLx4vvQaF78fB45OuDsdyRmEPlFfuMU6svXdEjg=;
        b=FHMzylPvhslN6wpLZe8aUP6IjDbwhgebnfIWiO4bxBYV0J9mHGVbwZQzwpJFLKaOWh
         HBYhL8HtUkYlnnB1p8pxIRaktl3feWXos9L/TlOp5K5o9KyzQNty1fMhZ8EmOgSTkDJn
         m2wiiYqLPptuu0yerDzyPiEdEso0dsOoZVP+BcPX3kAb1Kj7d0pJK3H7ZY+Xc5+FqXh9
         rSdPmV62YJSLKjYzPgDp5f+j7Su9uO2hvttw04dYSdjJ9n2dvO76Mo9IRIscaJi0RDLe
         lAYR+IcR180WwAlA0ggdRZ8KhgYaWRVxqH6OU5XWpgEwsuqR4QsxDBfZtziVkgtmc25T
         Ca8g==
X-Forwarded-Encrypted: i=1; AJvYcCUnz4Af8+xhhkx+zGWMnN8iq/KBUKPXKvz88VyO1+tQgtVc1D7XDYtpoA9rnygd5bzSCxVcJW4NQqsOmB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVDOrJpZVoP4RTyVHOci7E9GFT/rKb/443oKq0nTUpxEqQZ9Ut
	pKg7M1aLygofUeROxofiTgz8NrqX0WHOLcBpsBCnzPI76sVl6fZzO7JZ1guG580=
X-Google-Smtp-Source: AGHT+IGm5PMHhlLi5YFsfyGGNIixT6A3/mNucPlJSqwr+L1RehYxRKM+lc0KKtFad+lX3yUuzyGxVg==
X-Received: by 2002:a05:600c:190a:b0:42c:b4f2:7c30 with SMTP id 5b1f17b1804b1-42f777ee74cmr26207735e9.23.1727898294317;
        Wed, 02 Oct 2024 12:44:54 -0700 (PDT)
Received: from localhost ([2001:4091:a245:8155:f78b:11e0:5100:a478])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79d8d3c7sm27690725e9.4.2024.10.02.12.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 12:44:53 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vishal Mahaveer <vishalm@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2] PM: QoS: Export dev_pm_qos_read_value
Date: Wed,  2 Oct 2024 21:44:46 +0200
Message-ID: <20241002194446.269775-1-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export the function dev_pm_qos_read_value(). Most other functions
mentioned in Documentation/power/pm_qos_interface.rst are already
exported, so export this one as well.

This function will be used to read the resume latency in a driver that
can also be compiled as a module.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---

Notes:
    Changes in v2:
     - Rephrase the commit message
     - Move the patch out of the series
       'firmware: ti_sci: Introduce system suspend support'
    
    Previous versions:
     ti_sci v12 https://lore.kernel.org/lkml/20240904194229.109886-1-msp@baylibre.com/

 drivers/base/power/qos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index bd77f6734f14..ff393cba7649 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -137,6 +137,7 @@ s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dev_pm_qos_read_value);
 
 /**
  * apply_constraint - Add/modify/remove device PM QoS request.
-- 
2.45.2


