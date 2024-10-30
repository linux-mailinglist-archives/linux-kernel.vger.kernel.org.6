Return-Path: <linux-kernel+bounces-389559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB56D9B6E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C12E282103
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D8A2144A7;
	Wed, 30 Oct 2024 21:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hUJ+M//G"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F030F1C4609
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322586; cv=none; b=SX2jY3CVVpnhwQBNTFAGXdhif6iwFRXjrIgnEXSRwCr+zubCFVi2AhOnS+7GUhaxCeJn1xa92ez92OURyBBI2XajCbay5OYNcrlqTZThdATC35aEW8mwm7ASohn8TFW06YpTZTCANXBfx0PT840oZMunsGPv/tYDQUcP4uaFUoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322586; c=relaxed/simple;
	bh=dtzSsuOsjrMsDUkaJ8ZCN4Md4sSP4PrAoDcNwjhOekA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AoTJt4ixMtpeHVGQUHI/lJS0aGEFXaN3vIPfDj0xx8AJHvsEUrPrRdYj1vGYy2qwVzNlpl2OgdqLEkFsPS/2eSqMkMZ+oW9RIi4R0jtxPAGi09CW6DMJDJWzzdg4fdLsZCL21ifwQtYQm4QEmUPlll2syte0Lei9RH3ObZnZc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hUJ+M//G; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-718078c7f53so147687a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730322583; x=1730927383; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v946MMe7vLct0HqxsJKsBrfIkZPTq8ZRm2oG1sT2VpY=;
        b=hUJ+M//GSSAAc92pM/Fi7+R0kxyQkIjMpATbVwpc7r/xWDa2v5Z9VXSRr7yIAAsEUK
         29liW6bus9rugEJC50He17dnng3ToCVOhROghpysIkQUtTzf2cbV+E0x3QIoKzSpSkco
         pGEpNBdZMrZwDVnwp3Hf3CG/wL9sY4T3EW6LSUGltVS4Fya4Yci6XiEyWjQ8y95nxuIo
         Hk8gW6tS6wAUq5qieqRZJcAUH6O8t3wq7RpsEx7KUy6ClHWbfG/cyIdI8eHVaA0++hwQ
         wcwpkv69u7cdS3O+LThaer87w5DoCYyEfgMDLh0Jr3dxiiH7MqPtRSEpDvdxul+dPiDn
         2fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730322583; x=1730927383;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v946MMe7vLct0HqxsJKsBrfIkZPTq8ZRm2oG1sT2VpY=;
        b=EIt3vKEcjdWxt9uGCSQ2JXovUm2V4yMnVIQUzC6lrA8eEKzumVJob60vk8CY0lr4L6
         E1KajIoj/TfaJojiLiqXRBt0zQX59vLElW/ALRMI2ODUhm0nu4R9485c9ESasqy71cWP
         VJlfDVsbPmyIS4OvCzBgX20sXgP+lEispTLO0zZrpAnVAD/eGVGLUoONhqgXUMj4e2n4
         WrrB8H41Ro+QFz1vnkbhkKqJg7ZFQYiJb/in2jD/THBZHhJ7gllTU6L4R/Zn3jFSYnKc
         17VcVCCrZ9NupjtfsxJxPsfTu1KW9WDIkuf+ys3LXmjOnlkAzgmxVvaBsBc6cT7L4DqB
         U7jA==
X-Forwarded-Encrypted: i=1; AJvYcCVD8ISqaqgXk4PpiSkmaosHRollRt4kPs8MHwtNHd9p9s41W9V9o+EdLca8/vIilLc5u8+0vQKHwHNn/hA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNCjoTmM5rdXthC5k54J2ACnHtkufWAWHWPELj1uETWNcdSZ4A
	rpa4OFIr/amN/IMAbYx+gzIhtjbEV7CNCTLbGYLejVJdtInvboSe6Qy7rEgS5AQ=
X-Google-Smtp-Source: AGHT+IGTjtKWZENtiMSPHMMhWP5XL9suYtm5rdO9OICFcYMD33T6XZ+W6/+ori11obVOa0lQc20Hjg==
X-Received: by 2002:a05:6830:358e:b0:709:3a3d:6cca with SMTP id 46e09a7af769-7189d50dc56mr38971a34.11.1730322582945;
        Wed, 30 Oct 2024 14:09:42 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cc7ff23sm38814a34.41.2024.10.30.14.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:09:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 30 Oct 2024 16:09:41 -0500
Subject: [PATCH] iio: adc: ad4000: fix reading unsigned data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-iio-adc-ad4000-fix-reading-unsigned-data-v1-1-2e28dd75fe29@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJSgImcC/x2NQQrCQAxFr1KyNpCplQ5eRVyESTrNJpUZlULp3
 Q0u3uLB4/8DujbTDvfhgKZf67Z5SLoMUFb2qmgSDiONU6IrodmGLCWYiAgX27Epi3nFj3erroL
 Cb8acOYnmXJbbDDH3ahrx/+rxPM8fTDyDj3oAAAA=
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Fix reading unsigned data from the AD4000 ADC via the _raw sysfs
attribute by ensuring that *val is set before returning from
ad4000_single_conversion(). This was not being set in any code path
and was causing the attribute to return a random value.

Fixes: 938fd562b974 ("iio: adc: Add support for AD4000")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
FYI, there is also another unrelated bug I noticed but didn't fix.

We are calling iio_push_to_buffers_with_timestamp() but there isn't
actually a IIO_CHAN_SOFT_TIMESTAMP() channel. I assume the intention
was to have the timestamp channel?
---
 drivers/iio/adc/ad4000.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index 6ea491245084..fc9c9807f89d 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -344,6 +344,8 @@ static int ad4000_single_conversion(struct iio_dev *indio_dev,
 
 	if (chan->scan_type.sign == 's')
 		*val = sign_extend32(sample, chan->scan_type.realbits - 1);
+	else
+		*val = sample;
 
 	return IIO_VAL_INT;
 }

---
base-commit: fa4076314480bcb2bb32051027735b1cde07eea2
change-id: 20241030-iio-adc-ad4000-fix-reading-unsigned-data-88a1de88cf57

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


