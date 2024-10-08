Return-Path: <linux-kernel+bounces-355533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A07E995398
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53611F248CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E0F1E0DC1;
	Tue,  8 Oct 2024 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2aQEEhzN"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9A21E0B8F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728402304; cv=none; b=ijcDggwLrCUjFZKOFDSwrbBeX+tEstoBgjYn85NT937PS9SWMCn8V6XnOn7JQ8BuPidvRoocJO5AqCj6I1InC/rTRYGmJPuYzM2BLmhIpR8OvPzNxP2gLjxVL557jyWgelSZjd3TcQ4OH18hRV6FmDdLdbFL4jakQZ5T2v3Zzro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728402304; c=relaxed/simple;
	bh=oVBsJqn/AvE56D2S6kVn7RApm8mO3KrtDZZVK89hK7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCaMcwg3jmYIWnmpb9ycNydO470YNBKAvOKAF+hWM9bNHf36F+cupwlm/WdEo11+QjO9lehsKxSp2Gmj2zgyQ/8lpAHjXwz4qCYVzfn9bX5Jf0KAtXKGQvgoLED1MgaP5tVq/CPaDL/KRrfaDecNkUQgGAn7ASgIT+JHoTIeEQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2aQEEhzN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-430576ff251so3220235e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 08:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728402301; x=1729007101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbelPJURc0Qo14/gAixY0bohF8WhC7LFbvL3eTZ4rd4=;
        b=2aQEEhzNVnzaUEdGYgis+pG4lV+KnujMXXvqo/L/8g98ofHm1R/mkKyjt4SlFHpSkJ
         erV6W220X1GvcHoxM3x6vxsLKyJHBfeNQfp47vUfKlBk/hQ5KQjQ+Zx5+ZlpG5yJQ0UD
         ad0kgSbmia3g9i8UbtZeV8FANC8DOgtX1pMBv2vgBQMTExf7vop18sprRo1wpNcHKvAh
         ORy43Uf0nTRuW+URhdJGprh0lePiWT7hNy0szvOlwEGNgeHvYWdk7Ss9cihLds8kFaU8
         Ff+Njr56e3xVLYUxAQUxWcAGvhHuFHwy4aLXF1B5+1Coe6w0LS703V3aQrAX9Wik9am8
         imKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728402301; x=1729007101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbelPJURc0Qo14/gAixY0bohF8WhC7LFbvL3eTZ4rd4=;
        b=wvY03I5SfaoYvKIuEAMh1Gsrecbuba00ITn5HI0VAa3CbD6vhjaVO9TtLXO76jeKQi
         l4yv01i9ZEQ5SsYniPg74Xb9fjhPEaaOPO3GpKHSCrPJ56lmNeEFrbIkxTt0F/ugH87D
         yqRyDWvbmIV927F+RMBOQSohBPap/IwuA4nwGK9AqirOifXFTad7qo7m0oZwWcs7b+r3
         gwgrW3eOjLwOj/VBD8siC0GWt7Z0KXJdG/9XDF7Dr0p8Bpm0GLseixQNukX842bO/LnJ
         3lsRh2Ia1TQ9q4R0AWjrVfmt4wqqEI6QTgyeE1gHGgJSwCF1SH8jcqNsuMAqwcnpgLS+
         X8qw==
X-Forwarded-Encrypted: i=1; AJvYcCXlMSW7LehpKXDe7hhT15wWlW4mc4ZmxHLZMyl4zFjO9j8RgSl3SoI9IWCidfIHSdaeg6YJdpWKr6BpKvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnicRvIKcJ+CarDRukgi9o4YKupFOe8SWNGvmCjXsADtH2Jydt
	5ma7rsqx5DDr7dM4fkjpRTamiuFzm6LoHYpsQq71od7lXwPnSsetOl7CNU7Duw0=
X-Google-Smtp-Source: AGHT+IFOq9JRDmt8Gehc04UjC3HBBxMR6du/qX+O5gNpNaBTqBviThtjoi8LjMjD/1TypknrJQ7wbA==
X-Received: by 2002:a05:600c:198c:b0:42c:bdb0:c61e with SMTP id 5b1f17b1804b1-42f85aae2damr127558255e9.13.1728402301418;
        Tue, 08 Oct 2024 08:45:01 -0700 (PDT)
Received: from [127.0.1.1] (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b1d826sm129591215e9.26.2024.10.08.08.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:45:00 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 08 Oct 2024 17:43:33 +0200
Subject: [PATCH v5 01/10] iio: dac: adi-axi-dac: fix wrong register
 bitfield
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-1-3d410944a63d@baylibre.com>
References: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
In-Reply-To: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dletchner@baylibre.com, 
 Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Fix ADI_DAC_R1_MODE of AXI_DAC_REG_CNTRL_2.

Both generic DAC and ad3552r DAC IPs docs are reporting
bit 5 for it.

Link: https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
Fixes: 4e3949a192e4 ("iio: dac: add support for AXI DAC IP core")
Cc: stable@vger.kernel.org
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/dac/adi-axi-dac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 0cb00f3bec04..b8b4171b8043 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -46,7 +46,7 @@
 #define AXI_DAC_REG_CNTRL_1		0x0044
 #define   AXI_DAC_SYNC			BIT(0)
 #define AXI_DAC_REG_CNTRL_2		0x0048
-#define	  ADI_DAC_R1_MODE		BIT(4)
+#define	  ADI_DAC_R1_MODE		BIT(5)
 #define AXI_DAC_DRP_STATUS		0x0074
 #define   AXI_DAC_DRP_LOCKED		BIT(17)
 /* DAC Channel controls */

-- 
2.45.0.rc1


