Return-Path: <linux-kernel+bounces-237576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FADB923B12
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091C51F2241F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478B21581F8;
	Tue,  2 Jul 2024 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA5QR3w5"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0203F157483;
	Tue,  2 Jul 2024 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914986; cv=none; b=SnEneYcXd5h92hM4QWqHXViN/ae9M/iYMDDVXq0iluBxn6NcCi9QTSLeLQ/6mWbCvTwCjSK19JwNugToRLMWTHI5lLakxqRlj3zVVGj/I/tj3EmlBiIAuIyz5EFYMjYkKjt06CfO0nIuudq/Lyai6o4gO/falqfubliYJDBGRp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914986; c=relaxed/simple;
	bh=Q4wxK5Xsi7At365fA/JgfON7QfEWfI2AgnMzg/4FVwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jdfeocxvcm4QGcQTn/VfvYWWpFdLjtuizUDILeHxOzwYwK0b8uOuhx2IsVePemDQLeZXS2NJFzWp/B6GfcJcA3QmUzJwnkhHZD2f1yeF650fPZCn1ledo8FoupAX1xyx8KCb9G5q5AwAlAV2w/M6qR0knkKL9DxpAdndGMDewzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iA5QR3w5; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso38774621fa.3;
        Tue, 02 Jul 2024 03:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719914982; x=1720519782; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NhyCBFcJUM0/bnKu+Ibt45W+8fZqRGuE3dKlxsjvmBY=;
        b=iA5QR3w5K2id5egrXITTbzr0UQmsAYWJTzuMaPPKuD0S3FzRvaxhxA7GzJLb8qRUDE
         nJbuq/be3UDnnKayyQ7Iqd537WdgxK2SuLvqz67bDGGQtT4b9kl2oli1HXv8RqRYJqHS
         FBio/Sb62+QCyG5Ev6eJiQsTd8CcsCKwmw+OVRkG1MT9vqdv4YF8V/oyypMb1lgU+BpA
         3KX0ps4Q7c8jfmQnKHAxzVW6RY7l+NwFA1dYOVkbTP0zS3MLpd5FgSgR5BpwO9GqDP0C
         ZtOP/KkEYRNHJxANUba9FXTPu9+TfVBhtV4l/kJJ3F7Qn9Vc2ukpFASALpdfyqvAJ8kR
         yU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719914982; x=1720519782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhyCBFcJUM0/bnKu+Ibt45W+8fZqRGuE3dKlxsjvmBY=;
        b=EbnVvC1RB2sDNCcr7N0ZM0kWHVlzgMvtmbtfz8wbi7iMpV4myDtP6/MxNZ4odoC43F
         mMkucBdDM0Yhk+dIi1M2/2GluPa8P6p+QOtNylmmxhDhYLzYjwTXwS/KIyDM9jo5YXlI
         dqpWKWBZhYsyncpbVmLSz2YryblbRicoj1Wtx+orRBq+pCcOAEYlmdVeNErVmCHh+evW
         sqgDzT/occWguYal1/V/vz1s7mbhDsJ7Jhm2coYHs+l6mdsNnYl1ezXg5yqkl9DFktKt
         BBQr4l+NZgo9GgwgVyvBuyT6T4byADI/TR0eIP8/y66Vkcn210Rsx2nH6K7iXFbq8pFw
         qF8w==
X-Forwarded-Encrypted: i=1; AJvYcCVdIxnFKCUw1iXcS5L5qVAGnsMgJBwG7qT7TvZeI10Lk37BLVXSDzt5oaLMC/P4tQsW706mtdw7TEnvJEvSE0OvCrM4Wmp8SIVehScr
X-Gm-Message-State: AOJu0YzufYSbljkIc//14lFsmuobgl5goPh37AXCrOVujbCGmSEH3r++
	ZsZBPrlbSrFT1rksRnzlCA0xN8aQds9ubYBrdDO6R8dCvO92DjcwBHiYew==
X-Google-Smtp-Source: AGHT+IGyLnUUrN+QJumdzVq7TcZ5bNg3+0APvy/FgZjryyudh7H3ZkACRGuEAaTnRbGybpr2OeunFQ==
X-Received: by 2002:a2e:3018:0:b0:2ec:5fe1:c762 with SMTP id 38308e7fff4ca-2ee5e6e7333mr51125601fa.46.1719914981751;
        Tue, 02 Jul 2024 03:09:41 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b06377dsm192630315e9.28.2024.07.02.03.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 03:09:41 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 02 Jul 2024 12:09:30 +0200
Subject: [PATCH 1/3] hwmon: (ina238) Constify struct regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-hwmon-const-regmap-v1-1-63f6d4765fe0@gmail.com>
References: <20240702-hwmon-const-regmap-v1-0-63f6d4765fe0@gmail.com>
In-Reply-To: <20240702-hwmon-const-regmap-v1-0-63f6d4765fe0@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Eric Tremblay <etremblay@distech-controls.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719914978; l=765;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Q4wxK5Xsi7At365fA/JgfON7QfEWfI2AgnMzg/4FVwE=;
 b=qhFxkZtD9nGlsKn+KkKxNRvSmOe+yJbo/MSZRqSC6yblufhlZ5vo7kQFmp22MoMPWUwRl5F1r
 GemNiTTNYpBBDvui8gNEuVc4/t9gzBYLshoVogRGtXnhhEETbbzNRg5
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`ina238_regmap_config` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/ina238.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina238.c b/drivers/hwmon/ina238.c
index 855626f1bc01..2d9f12f68d50 100644
--- a/drivers/hwmon/ina238.c
+++ b/drivers/hwmon/ina238.c
@@ -96,7 +96,7 @@
 #define INA238_BUS_VOLTAGE_LSB		3125 /* 3.125 mV/lsb */
 #define INA238_DIE_TEMP_LSB		125 /* 125 mC/lsb */
 
-static struct regmap_config ina238_regmap_config = {
+static const struct regmap_config ina238_regmap_config = {
 	.max_register = INA238_REGISTERS,
 	.reg_bits = 8,
 	.val_bits = 16,

-- 
2.40.1


