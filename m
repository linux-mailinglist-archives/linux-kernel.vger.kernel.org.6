Return-Path: <linux-kernel+bounces-564889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE21A65C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9047217BA04
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F961C84C5;
	Mon, 17 Mar 2025 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V7scCnqm"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3835A1DE2B6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235664; cv=none; b=ZXUNLBfc9pywV1cfMdbE6uBkqr0GpG2rH9zRDa+64ax1g/gJV265fLEInE7BecDJsTCzFwt3FhVY6WGjOAsZuI6OqVIbYCSjXacquAFgrAK+OqOsGdokqhCmfUSzfnx15UgsOvHxMmRZierRCj3Npz6X6Mb/s1SE1PWWKMZYehY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235664; c=relaxed/simple;
	bh=DEZg8E/YPssgqgAe0ee5/XDHPkpG8U6UYZ1JsrBZbTM=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=D/7psOZVZcBRqtORBcMTF4ddKtpt89dHAo0uVnswCx25FB6YOiEOnOAQKQsJs1u4ILhsFfNmMQCFBy1nCqoDMNOaipTCbbAznETtrcyLCeOEt1tJsC6YnpznQj900hPMeNkCXC7dA7zZhjWK6sYf7LoRfJZtAcroLQF5jUTXA8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V7scCnqm; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5e5d9682f53so4790824a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742235661; x=1742840461; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sfFuu+eJmVYNAVthekeQ7PDh1EKYPBc4N+wgHd4KYbE=;
        b=V7scCnqm91UpgBiqQhVghv3RHGUgcabPzrXpSD+R3u4H1vszQsxlUYUQMPfLf8l8a0
         MJvBm4iF3PVdh+RgsTb04tkgZU9Q9pXkYuwwq+1Ek9Z5k89LHsoWBCndKu/XuwRxtD4x
         p9HHhuorbrwx1gCtSmf8Xj5H6HKJeWj+Zk5pVXXAJ8DlHpPmAMYAaHi/JYWu5sdBz1TB
         VS7hNJStaFwv1+oOyB18XknIelH+siWEjLlieGnAGbBi5sR/aJAy02r8adAxMwIfOnhu
         bRi6s38x7YFYKS1pzicMDYqd0nVbEDHAFIRcvipWD9MxtUT1mI5uVAJTt7BW57hAHQu6
         Hd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235661; x=1742840461;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sfFuu+eJmVYNAVthekeQ7PDh1EKYPBc4N+wgHd4KYbE=;
        b=UflK1vKpK7ZgYOPhy2pdqq91l/vniMf+GlrJCjscLlZQM5X1jp7M1QRrPfylZtk2ED
         WHNgnDIFQQjJG2JqihMSz/Rb4tg4ix4LBeXajtVFhTUn8UvFAQL7YBuv0WaxDeWZwK9U
         Dy56NwMn/oy/wGSVnYjr/6ATbLnxox0cNFbzXP02uxCQjO1s26vDdTi3LA2pYd212yvC
         Y+KY1JdHlRY/IXk6KC+By3aVOX0outUFxu+WYASk0XeOre74paVcq+LYCbx5x8f4gQET
         wwgaTSILxIvT12m4sLtbUJrqxWdy56ZBKhQur1lfldi5xDCpnj0b6O2S3t7azak+317w
         MusQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmbOCcGUIzoanK9s/l1RQXrtA/LiwnnIBk5aQ/lR3ZsLoA5WbYACowN7zDP9jCqtoMjqTQlpCRaR6Z8eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwhmnqwqL47q3CoI/l2OvqbH3WAvcno7bh6iA58zaVShppWgg8
	P/kDtPJiJOGKU3RVXnjEeknoqkeXBUK204F31bmnfDLWD3HXlUG+kFZsCW9uhjJlAMq4hLCAfaB
	gG/phxA==
X-Google-Smtp-Source: AGHT+IG1h8GfnurAMl6dMtwyuldeVpIzzbD9T5cwDcyYDpilHM/PkC7SNnNSgKT74Xa5F/SNuijtZLO1G21O
X-Received: from edbfi25.prod.google.com ([2002:a05:6402:5519:b0:5e7:8957:e479])
 (user=czapiga job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:26c4:b0:5d1:f009:925e
 with SMTP id 4fb4d7f45d1cf-5e89f649a75mr14429927a12.16.1742235661486; Mon, 17
 Mar 2025 11:21:01 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:20:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250317182058.2060277-1-czapiga@google.com>
Subject: [PATCH] mtd: spi-nor: macronix: add MX77U25650F, MX77U25655F and MX77U51250F
From: Jakub Czapiga <czapiga@google.com>
Cc: Jakub Czapiga <czapiga@google.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

MX77U25650F and MX77U25655F are 256Mbit chips with SFDP and block
protection support. MX77U51250F is 512Mbit chip with SFDP and block
protection support.
All chips also support top-bottom lock configuration, however this bit
is SR2(3) and is also OTP (defaults to top). Due to lack of API to
support TB in SR2(3) and due to it being OTP these chips will only
support top blocks protection.

Signed-off-by: Jakub Czapiga <czapiga@google.com>
---
 drivers/mtd/spi-nor/macronix.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 99936fd25d43..c65e7cdab5cf 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -193,7 +193,22 @@ static const struct flash_info macronix_nor_parts[] = {
 		.name = "mx25l3255e",
 		.size = SZ_4M,
 		.no_sfdp_flags = SECT_4K,
-	},
+	}, {
+		.id = SNOR_ID(0xc2, 0x75, 0x39),
+		.name = "mx77u25650f",
+		.size = SZ_32M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP,
+	}, {
+		.id = SNOR_ID(0xc2, 0x76, 0x39),
+		.name = "mx77u25655f",
+		.size = SZ_32M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP,
+	}, {
+		.id = SNOR_ID(0xc2, 0x75, 0x3a),
+		.name = "mx77u51250f",
+		.size = SZ_64M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_4BIT_BP,
+	}
 	/*
 	 * This spares us of adding new flash entries for flashes that can be
 	 * initialized solely based on the SFDP data, but still need the
-- 
2.49.0.rc1.451.g8f38331e32-goog


