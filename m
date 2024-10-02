Return-Path: <linux-kernel+bounces-346889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D2F98CA51
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE431F246C5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD92B666;
	Wed,  2 Oct 2024 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8kZqp/9"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AE28BEA;
	Wed,  2 Oct 2024 01:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727831301; cv=none; b=DxQzigAee6F5m3udwTWwwLRhl6JrZ6G+OzeyvelQsyweGTX0lRHg5khexb3FabifPW0C7bJ3BKUPofMJCD68WCTDlGvsvhymC6wXJL+m+8JptJf3vIym1KqzjF6l4oFL80/GTMuCEKKIW9+P4uUfejXv+a0CX6RWhTJXduSLbSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727831301; c=relaxed/simple;
	bh=b0PwLrPwpyq/J8QWShA9j6YVReN5JMgm9/S3Bp0lOgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nXihaf+hzujii+qUsTIyIhWZupK5/0RNjZAiA0jLbn/2VEmjrYIGapwZ/MFdMRvNgoWRLQKVzKOOgdzRk3tLNwepPGdnTlw+Yvejd1MytgSromVRBWUs6y1h5+RFbxaerf6KXUxWguYEYiCqe1lg4wBnIyq0RfBDyso9aos0URU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8kZqp/9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so23945475e9.1;
        Tue, 01 Oct 2024 18:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727831298; x=1728436098; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeLuTvZ79d9IaRG2kzO/5EV5kqkvacRIzXeh7t89fkU=;
        b=W8kZqp/9HClTDsyHIz6p9q0iDvbgvCHmR/Jm09C/FK7sg1n1CgZXF+hWA69r4zlU9F
         3WevmDMyV83vavMoz6Wa8QqDBsHLg4gm3Pu1HrUkpb1x+CgMSL60my4VivoUFQ0NlPa8
         NJ3AibhvJ9lD3iNFtVuI38ESNouCsRxRv6AnWpz5GZD3LMYBYCUAL1bRfRq0vx5us6+h
         cYuIBdFtzkNSyTiCDwnyPIo2dW814N73vni0ZjcHvZP4QyhvHJl4kjE478Daqj5veH16
         FKbNvcRvkQmVNRVEoLZNEqdzdDdLJRXNh7P9Y63fJGwce/97Y6HNsdUy3Aw8D57rvPo9
         wRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727831298; x=1728436098;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeLuTvZ79d9IaRG2kzO/5EV5kqkvacRIzXeh7t89fkU=;
        b=V8u4HOiXKWKjgATa2Nf4fn5Ixyl2N/3iX7tjddPZ88RpftWIc+EGVIPnTMvHmkacyH
         uOnoU13cUO5FjAWeeQrnwclrmoy6qm4gVUlkrRdn8+80aU49xHrmExEnIR61LtTcO7MT
         NQC8Ch/B7b7jegreu0/UNmoQak8zJ+aZzSeuADhTw5jOsRyC87SetqX0YFNkeHuOP4DL
         eCNkwZeQjkcFjAXCrgRiPsYZTts4p9lbzfiUg93bnLFX+YcaRQR8JkuqX94R+JcP/c9o
         tsR/cdRLHeYdORZ6Ak1hh5Kre4VS6/IHH8/aCl9k2l1bUmwhEV43834Su9ITAHWbqDoq
         p9vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWShF2MFe3BFlre9Ab22Zch92oHlzkqDwNT2ArCVZIvHltZA6uS2KALPiEw9TxDq0WauIglc31hdI+pFbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBwQNLeZxPKcvMF22yzfPHmKLpXU0geoKnWGlYwALW5xk7bz0H
	FkkhQBuB5zv57KMtKjDkj0oJqcknCRPLF27tEBDMnPtgHlun52GYZBUaSRZy
X-Google-Smtp-Source: AGHT+IGAEFyQuOW9E26VoKToud0BWbnnfuA0BFhEDg2iWH0BeWTtIaQsauCOX563qA7HM9ARqRulCw==
X-Received: by 2002:a05:600c:5254:b0:426:5fbc:f319 with SMTP id 5b1f17b1804b1-42f778f4e11mr8667405e9.33.1727831297930;
        Tue, 01 Oct 2024 18:08:17 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-325d-7a87-742c-96fa.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:325d:7a87:742c:96fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e89b4sm12881345f8f.53.2024.10.01.18.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 18:08:16 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 02 Oct 2024 03:08:09 +0200
Subject: [PATCH 2/4] hwmon: (adt7470) Add missing dependency on REGMAP_I2C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-hwmon-select-regmap-v1-2-548d03268934@gmail.com>
References: <20241002-hwmon-select-regmap-v1-0-548d03268934@gmail.com>
In-Reply-To: <20241002-hwmon-select-regmap-v1-0-548d03268934@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727831289; l=778;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=b0PwLrPwpyq/J8QWShA9j6YVReN5JMgm9/S3Bp0lOgs=;
 b=D2/pKB1YQisrJpesfRAL2lP2VQJZoy/nfxkvwuUPiV+CRX/N9Iwt3S+5i00dK4+0liaJa3vYF
 yNNxPi6DtgVCiSFQHN+/UoBNMxZ+mTgo6NcjAhUh9NpCG8G/a0NjBbr
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver requires REGMAP_I2C to be selected in order to get access to
regmap_config and devm_regmap_init_i2c. Add the missing dependency.

Fixes: ef67959c4253 ("hwmon: (adt7470) Convert to use regmap")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index f47f6a28d1c7..d4a9440a5fca 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -224,6 +224,7 @@ config SENSORS_ADT7462
 config SENSORS_ADT7470
 	tristate "Analog Devices ADT7470"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for the Analog Devices
 	  ADT7470 temperature monitoring chips.

-- 
2.43.0


