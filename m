Return-Path: <linux-kernel+bounces-235728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDF791D8FD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1CC81F21C87
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63855502BD;
	Mon,  1 Jul 2024 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPHW7dKx"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648BB1EB21;
	Mon,  1 Jul 2024 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719819179; cv=none; b=d7hHPaoQAJpkMusJV3b5ndW1wMRTFOAEseNZEdAsy96ERkhaljS42DQbtZKuGFmhfW8xaJwz+f8v5af+eTVkeea09c3njaj3fJhJ6mqu7GYGFhnlWz65AE/e0DyCtQC34DV9w9qO6t5VzHcJkM9h99oin4lBXRmW5Mb3+2ERiwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719819179; c=relaxed/simple;
	bh=WbtuBMd2IByJQX0W6gj+d7EnRuHQh52tTvI6du8Qlrc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=twS8oYXlUOrbpyPuKuJiBaFPbTLKZTXVe6L5n4zlEoLU3lB6DISnkFXqi+d8g7kRhEln0h1iZi2Iem/Bwf/LVyWS+lM5FFlLTXJ0Q1VFP6P9uvwkD+tbej3X9T2cW6RtP6unx23C8QDVCSrj1sJepsPBfcvNqT0rlYd8UFukzzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPHW7dKx; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2598ae41389so1419512fac.3;
        Mon, 01 Jul 2024 00:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719819177; x=1720423977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oLy2cq14RkKNAt+7WuMcRJ5BnQQoHbm/EbwstZmPmMU=;
        b=XPHW7dKxSQD0ouUwlsDHfDeag945aPwFocf8pIR6YUka9Emm9GHRl0DxD4BiBRvQoC
         7/X6nJ60iH26W5qscK/PgjwFZEPOnoHDJIPwL2PXTjxxdc77ZwxZqavdOLBZkJ8gtnky
         KEqw/Y0ZjPQtrXfyFVp43SGZDpl0G0I9c6IVqQ2AMudpASpYO+Csn/Qa8bSgIwtfV26v
         5h8nyVNtbrJhu/G+BU2AtD9oOBmti/ZazxDlnfT+stdULVW/TdebiLC9cgar9Zi5uiJ2
         zx3CLGcN9x0USXxKSYRJnGp5aG0aYNOtj8jmK+D/Mq0fjE1hbPjJdqhRT3fzrFe8m9O0
         L14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719819177; x=1720423977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLy2cq14RkKNAt+7WuMcRJ5BnQQoHbm/EbwstZmPmMU=;
        b=jKzAAYT30THOdhsUEqbIo3ed9MMXOieJYLACrLkUjVle4os9w5xAyUhpYA6WXC+UES
         U2HXmsI8ZhDO53jav6wsT6U8MXrRt5xt0NjhUqsi0fTQGa5VxR8JKsS4UHnVp0m6YOoI
         65+k0B/Kg1k5oLEfRZY3ojdPiqY/giUfsTcJNoQxBixZ5mJrw60HLdMvboOb29lpC+La
         tLaQGLwYz2KU76cnmmuR4Myu3b0PAZ+X8jGlXmSAxa1N7PewFMtg67sWGtFVIQFgqNzx
         kRr6smbJxDzDE0M2Tnx8iASDmRXoUHdHUhSV9fl7Q9gpUlzFeNiLu4CZwUkQXhWlN6v1
         7OxA==
X-Forwarded-Encrypted: i=1; AJvYcCVqQ6bq0Z2ywkw6PNRqmWYg+JUZfMQkqu7n1QNHgx7dm24YH4+JUqwLE9VbBWhD+6MTzb1dduuTnDpJnj7KYbiHur9EVW8yKM6wNEg5
X-Gm-Message-State: AOJu0YytzYGG7vRo/uEMEgalkhE1z/wKmQxzsYxY3T+EHnPBSvn0O8Cq
	gGHtZ8Hl6UrcuDSIsXkjHcy4g8DPF1Zfzk28CUv0wIukwgsQ262v
X-Google-Smtp-Source: AGHT+IFxdA3X0lwBKIgXTIu/H0fR3TTWnLGft1+hTrkbw4jxmtFcGAHe3W1OEL6URUsJ4f/VFuVodQ==
X-Received: by 2002:a05:6870:64a1:b0:250:8255:e793 with SMTP id 586e51a60fabf-25db341e207mr3566514fac.23.1719819177433;
        Mon, 01 Jul 2024 00:32:57 -0700 (PDT)
Received: from localhost.localdomain (61-220-35-170.hinet-ip.hinet.net. [61.220.35.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708025656a0sm5793058b3a.73.2024.07.01.00.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 00:32:57 -0700 (PDT)
From: Wayne Tung <chineweff@gmail.com>
To: jdelvare@suse.com,
	linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wayne Tung <chineweff@gmail.com>
Subject: [PATCH] hwmon: (adt7475) Fix default duty on fan is disabled
Date: Mon,  1 Jul 2024 15:32:52 +0800
Message-Id: <20240701073252.317397-1-chineweff@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the comments on fan is disabled, we change to manual mode
and set the duty cycle to 0.
For setting the duty cycle part, the register is wrong. Fix it.

Signed-off-by: Wayne Tung <chineweff@gmail.com>
---
 drivers/hwmon/adt7475.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 4224ffb30483..ec3336804720 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1900,7 +1900,7 @@ static void adt7475_read_pwm(struct i2c_client *client, int index)
 		data->pwm[CONTROL][index] &= ~0xE0;
 		data->pwm[CONTROL][index] |= (7 << 5);
 
-		i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(index),
+		i2c_smbus_write_byte_data(client, PWM_REG(index),
 					  data->pwm[INPUT][index]);
 
 		i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(index),
-- 
2.34.1


