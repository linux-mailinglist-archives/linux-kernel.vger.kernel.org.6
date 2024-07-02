Return-Path: <linux-kernel+bounces-237577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71347923B14
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E081F22196
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F37E158871;
	Tue,  2 Jul 2024 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+OGRG0D"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA151157494;
	Tue,  2 Jul 2024 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914987; cv=none; b=eZusdWuUGs0zI2i+3WxpQAwM5EOadyb7j3X7fOhfTxOu9sAuDtX0VZEbgXBthYUaMx9LIqrdwf65z9O8yovMT7wHz5IEXZhiX0FPBehEY03O81JQbhKsihPRPtNYn1vfBbF3ZDQTCoOsh0SoYkQROgx76nzoHr8f+fDBn0MIum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914987; c=relaxed/simple;
	bh=4PG+CP1o0ziICuTxILIzZ2DVx1gJQqFm/GCOWpFvB/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j5kCF1o19vkOK2DuRPejSGllFli66hlN1rVrFbiAfbSUi4otYFqTlF3aK00joUQ8zMwSzfQL+QpD+IU5ROrEz2uxFsBzOcr0umzg6hDRRCDWise90aynOMVIJgYIpo3KKPHx1V4mAf/T4t/KIrIPm59Yj+7IeMn7hLe08lWIh1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+OGRG0D; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42574064b16so24667475e9.2;
        Tue, 02 Jul 2024 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719914984; x=1720519784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0jcWjALf5R5/n0HjufCCcQAyNsnnkzTLIqUtc9ewdMI=;
        b=b+OGRG0DdAngUu/jsL4TQry59L5DZQGBdn2vEXuWYJNo1b5gXiwmSMov+Q/wPXjwlN
         PVqGldiihI7kS/3WpWUeO/54HjDHSbtPARCKHdN+s8Am/kkgnFTaRth6akjzHRKQ1Z6C
         9j4mOA2qkl5LsIggx5DQhJALll4mcfHPvKastA8tIaGLZ3ahNaRBH8QG8jBqtqGBVU2W
         o/iEYlZzHWu8b1gGZEZD5SCBAWfp9NgEuR25SoMRxSdbQlPQPs8bYmITAkxGz8fNzpT1
         TKoBNyAl6r6rZcuOKfGe2HB58hFhoM0FVo1sUJafoteDAAYAcNByH5I0d9DowojKZQIX
         wawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719914984; x=1720519784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jcWjALf5R5/n0HjufCCcQAyNsnnkzTLIqUtc9ewdMI=;
        b=asxn18lstrVoPW0lVfHo1lOXKwPMHpi8dFiOh8mxY+RFVFwEBymRFYGNXG0ufBRtNS
         zt/W8JIGl7iOJrBg8VSyx3fL1k6qLuTLbuCzAgUlHacbhLnbF/20+3C4O6uEcY/Cjw0E
         7GsNk+fYjNpOJ2S4vPElzdq4SL4Vqhfrugw49vMByIi7VO3WipXMMWTsa5joh2k8w++V
         zuJU5vLi2p2oWvhr7dsvsAklb/jn04aXWdgniQBKNS/XV/oKCe6uCPPwbJT9pH941nOG
         1kcDenUd4iIOwAS/sMdMnmUAPIHUqIfqrqxvC9EHKhUo24R/r3Qzlv4/s/+Okwz5s4Kt
         CApg==
X-Forwarded-Encrypted: i=1; AJvYcCVPJwKR5GmN5ut7i9OLYkhheafhUJinG5/jzp/k58GVaFHvI9Tv/+fzaiDWM8Zk0+yjx0ahvQnpPhOIoCNk/ow9Q4SZ3zQQffeKGhWG
X-Gm-Message-State: AOJu0YxDH3fvRIvbPS1pWN4Q12h75Wl7f3CmhD5yyWhZDmD7JbjNsRYp
	Pks0kwRscgxmJZJxTJuNOc21jp6cVoCLogRCx8cvDJwrSaFuJbp4/vWaJA==
X-Google-Smtp-Source: AGHT+IFvpA58T+dkA9WmGLMzs2bgQAMgrLRSfrkdq/IVJXHtKiVp5cDfn9pVhgj8HRWQTKhLiAYjMg==
X-Received: by 2002:a05:600c:3541:b0:425:62f7:92ea with SMTP id 5b1f17b1804b1-4257a02f7c9mr50439925e9.14.1719914983773;
        Tue, 02 Jul 2024 03:09:43 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b06377dsm192630315e9.28.2024.07.02.03.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 03:09:43 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 02 Jul 2024 12:09:31 +0200
Subject: [PATCH 2/3] hwmon: (tmp513) Constify struct regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-hwmon-const-regmap-v1-2-63f6d4765fe0@gmail.com>
References: <20240702-hwmon-const-regmap-v1-0-63f6d4765fe0@gmail.com>
In-Reply-To: <20240702-hwmon-const-regmap-v1-0-63f6d4765fe0@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Eric Tremblay <etremblay@distech-controls.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719914978; l=740;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=4PG+CP1o0ziICuTxILIzZ2DVx1gJQqFm/GCOWpFvB/k=;
 b=UbApVp4yQ9RI6fQVaI0cYL8wfgVTfKVEWdSXWdEb5PNzrFw3xyh3jTY0ZR5zHZtftLm0P8LOA
 d+49wa9LGuACDrzaVi59UATMC8mSwwAf6ARGvknUt8TPUVda2+EMgXD
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`tmp51x_regmap_config` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/tmp513.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
index ea6f4416c124..926d28cd3fab 100644
--- a/drivers/hwmon/tmp513.c
+++ b/drivers/hwmon/tmp513.c
@@ -159,7 +159,7 @@ static const u8 TMP51X_CURR_INPUT[2] = {
 	TMP51X_BUS_CURRENT_RESULT
 };
 
-static struct regmap_config tmp51x_regmap_config = {
+static const struct regmap_config tmp51x_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 16,
 	.max_register = TMP51X_MAX_REGISTER_ADDR,

-- 
2.40.1


