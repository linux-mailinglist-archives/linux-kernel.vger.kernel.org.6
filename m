Return-Path: <linux-kernel+bounces-371404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 651319A3AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26DF0287DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8EE201005;
	Fri, 18 Oct 2024 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlQXTOE5"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AE5168C3F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245453; cv=none; b=uYDuVBr6Lav1tAmGehuBHeJxws9zGmUBHgMhmgyWidwr2LjYNammO+ao/3eJVSkRXs64KYfHmThaVfKBoPO+tUY1KeGztNJt3Pj0nIREg4Hzj55MREv18KkiPp3v1GOa7w8WJQ4tJrL1XOKFstVCT9KFZixV8TCmlHVaV2n+gOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245453; c=relaxed/simple;
	bh=ppPiXEetbt7hM7JgNh/mkoO4MmccshLeXaKKm/hvPWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b9xbr9qkvoX/gUvCtU6dVe6JADEO1gTHaL7QU4jrYMX1Jw/6S4bpqyWA1egbA0HFbg3qrnEFGYOFctmh+/bTVLKFeou5Tqn6uk9T8BmMMxZvk3zwwXTR/IPrEBsWzHNfvCWF1DjuLNb2deJAW+nnwjA5AvIQJTymX26hRuJ7OFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlQXTOE5; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e59dadebso2801596e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729245450; x=1729850250; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TwDAxn8hr5/Z6eYXB0TyuhQ+73+e0ZHcccVnO8hBXVk=;
        b=hlQXTOE5RalsTWdkXeu5zvd+543JRHKCRzwCraOkoJ/xv+vQbHXbiGcfcUYXZ5R6n7
         JcmhU9Vjr+052lz9WRux+fMDXrSB4tWgmrwJrj6hukHy9vsgFPHasd8RPGWfKj0gzF9r
         hce/1R0sPcMb+CBE3jXxlR2HTONuno83g7yyx76L1DxPTJYJzVlo6XJEfEuJN1MrOmfb
         MJuguPXzb+Eb48pDfYwNKefUzDP0/xJTBxML2zC1YpW6YYoQsFt27LJTeIiNLRbSaCvq
         meyfe3MhDAjs3QlhLLNRZ/fUrcTRygU0JtkIjOT6Vw5AM/YkjJWjS2KGXvYX3E3osxK0
         ef+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729245450; x=1729850250;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwDAxn8hr5/Z6eYXB0TyuhQ+73+e0ZHcccVnO8hBXVk=;
        b=WPJ6Hy8bQQxu04z2+8HFCV56z8EB9hnslahHLGSJ0JEtoLhv33oO1FGY7NuoGNvpwe
         s5Fa+kLqz9xpZ51bds9q7d7oq8o3ook3q8usILhFnEwq1evdCrSQ6CztoQ7lbI2VZk/4
         2nWvn+NAX8Z9GRTw5zOmX7KvzCXn9YInFvkOjV5945/yHzOzxGHUt++A1y2l8w3HbAan
         O5QcawiRF78k1dVCwJTZvrjEFYmAXhdGTIIGvBP5LQS1rmA+tg0Z4WnmJ1jyjtuuWicQ
         5MNckihKQhvqTXFEBc45p8RYUWjF5XeZoSaHhiC4GbjMHJNkRu4tUUMdSd7epvJbpikw
         pxSA==
X-Forwarded-Encrypted: i=1; AJvYcCUqjeOl2eQyVrhpbBa8jgWz75szHmRWxyE6edS3ELlktcSn46NEGZgX1FDn1ko+pvca85xHPAs0wQw4hTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHkOXZatgEKMaWAeSFtGwiPMZln0lWLMBmHphtQdxsJu3i/1Z1
	8buesYdffTxBOZOxBsvJnPTo7nhXU/h0VpOJF8XnSyxgCKNGULRb
X-Google-Smtp-Source: AGHT+IFCdbzl4ckoe26AeOzCWVdM876/TTRWm6BE0Bt9Ffroxi6NaMANv0pUCg2ewGZ8WDCvFjiHkQ==
X-Received: by 2002:a05:6512:1598:b0:539:f886:31d6 with SMTP id 2adb3069b0e04-53a1520bd09mr1167492e87.2.1729245450115;
        Fri, 18 Oct 2024 02:57:30 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151b91c0sm175166e87.77.2024.10.18.02.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 02:57:29 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Fri, 18 Oct 2024 11:57:20 +0200
Subject: [PATCH] mtd: spi-nor: atmel: provide .size to the at25ff321a entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-at25ff321a-v1-1-c8380f80c289@gmail.com>
X-B4-Tracking: v=1; b=H4sIAP8wEmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0ML3cQSI9O0NGMjw0TdpOTkZMM0MwNTY4skJaCGgqLUtMwKsGHRsbW
 1AN6JB4hcAAAA
X-Change-ID: 20241018-at25ff321a-bccc1f60538b
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=883;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=ppPiXEetbt7hM7JgNh/mkoO4MmccshLeXaKKm/hvPWg=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBnEjEESYKpmzIrRnTizN1GadHCi897sXAkb4PE1
 HwCMGtRFbKJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZxIxBAAKCRCIgE5vWV1S
 MsS0D/4inV4ltStzrIHXTMDf0XFIFsLY4A0au67eF7n2e1zXL5WQhFNkG4A0ygvgBjmzqs1Q32Z
 3cR//0UBINRQ5mRjPnhf+Cs86Gfy0qgHW2QvuEk+koEs+L2LImtrOQKG/GFofSCh9ICfKjef7r1
 bewkX6peCo9GjrjxQwUnjIK9CbhJgVaBULTv52JmWJUpnD0tek+atfdntANoWtIT7OCLx5CIKfl
 uPDRtr3DuzCY7uNnrvWqpnnY6dpufoBSsc4qZuC3/el732PcYkNd1qilruISxljUKxBS0Skko11
 4FNa+wkFzEgR0/fyi0LoqkymzjExTYY16VPD2JCOF5b9QQDdJWnbmF29QGhWrMua4gOxZFHP9Hn
 oMYd+RrlYsWjiHRHIBnj6/H2JvMKXcyaDji05TVA/E23TCDoTg5KCfkGNLxVON/1LtZYHSQrXku
 e0MxXPXLX0DhdAVoLijVUjWsUqDg7FkWdeLYssEvPRfnG5Sd43uekrRLi4deKImrEuAJRxk6Zjl
 eyaVfk3rjjN653wPavDTDeG+fokFaAmW1fclAFmqdXstrAxhg3FcmhM0EBQp5lLWsdJ7JAyO/c6
 Ls8Rq9vzQYXOZl4ienEN9LyB+r/vMXFxnaokWZMZXI1I0RwTypee7AIQxBZgOajyV0WajtzEYzp
 vgZKwEWeowG7ZLw==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Set size of the flash for the at25ff321a entry.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/mtd/spi-nor/atmel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index 45d1153a04a07b7c61f46b117311b24ab695038f..cc7217e96d0139a06d46f10e35c545f604464b3c 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -214,6 +214,7 @@ static const struct flash_info atmel_nor_parts[] = {
 	}, {
 		.id = SNOR_ID(0x1f, 0x47, 0x08),
 		.name = "at25ff321a",
+		.size = SZ_4M,
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
 		.fixups = &atmel_nor_global_protection_fixups
 	}, {

---
base-commit: 200289db261f0c8131a5756133e9d30966289c3b
change-id: 20241018-at25ff321a-bccc1f60538b

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


