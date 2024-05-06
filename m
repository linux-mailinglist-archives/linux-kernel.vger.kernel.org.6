Return-Path: <linux-kernel+bounces-170114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8838BD202
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020CB285C99
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E93155A25;
	Mon,  6 May 2024 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uZNr1gnf"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175DC155A39
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011191; cv=none; b=UMkSfqCT1iOdb43b7ZbxOBKcn54t5inzaUhluxtHTIooXwPB4PdkGn0OxxwSn/OyP0PJnJ1+NcR640/WziMfl19AWH1YWuTMkpaTVoNsudwv2Ajgz1sdNC8KLX8Exu5byHxxhcYijpRW//rutAhU82u8KV4tKtnqszgMMPzavw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011191; c=relaxed/simple;
	bh=Z4JtbWwDYUVBekkPFVCgO2D/g+JZlEmJ5TZ/YseaHn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zq564jHEc/ok3v7h48OD2dE110IoAB3Ek1VUCdELLPe6GG1TMQdML2ySLAJsTt/cVn7m8DqM5kRtYa4PW9OJMqjbvh7ek7Hj58knwdZ4HCuW9koWYF1+PECLHXiuDVqOA8YrlRATF9b/aU6zA39q00+LpuoLvzjrT+F1+0MG4HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uZNr1gnf; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-23dd52c6176so2761012fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715011187; x=1715615987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8bK6fC+/hctk+PwvfTwpigK2iNyGvKKcVfohzYbxwA=;
        b=uZNr1gnfdcxuch5/Cxj8FV/ntFB1WnNgLWVzpmp4U64+hYMkP08FEVuroXFwMA3SFz
         TiTH6LNd427ct88IyvjCx7wZQRDtn4RBgNZ3/VMitqeRlOKPxQvjvQvrv3QGQ1qGbygn
         IwxA5LxNJl5c+zUxmIcP2wpRARBVUMfBFkpWVHpq6QjnOYSh/GE4LMB/nJHNG1zfxfE/
         YtsT7PFj3HJDlsgmMQb12L9b8rQmmGjhfV7ZMlsb5lYLC4dUg2UkSMafpYWmlK3DaPtw
         XdZ/X2JBB0/bFgWG50/DzpopPE0+y+6j2f/vUgvlfYdZzKTReL+/EhEmlzjcVJVSim6l
         938w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715011187; x=1715615987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8bK6fC+/hctk+PwvfTwpigK2iNyGvKKcVfohzYbxwA=;
        b=XGfSPS0lU4sTiSA4A2uDEWxfQlipYfM7E1mFuzkLeMOnCXx3qIBUhrC74B0GcL+AV7
         d77iV2PTXwUoUmG3iqdji9G8ddxgi9h9sENQmzYONESuLMmbYlpurUJlMHitpRWhR1AX
         y1mufQbNzn175k709pUnAC73DqmyxTxUC8sqIRDoInDwaRJsZpzuTcQKbmmEBHOBLjDI
         krDF43VJwAh2wugvHi3z48zXTzbpibWQV0z9lRfyBaPtP9kLaXJ77B72QwqaICyrqu9R
         B5cZPZfpzSW/eBFB/fUN40hFkUUndYZtojobFyOayK9QalFgazOk0yjzQEzoKb1cB1c1
         46sA==
X-Forwarded-Encrypted: i=1; AJvYcCWK5yaxb01iy3rygJPEudt8JXTa8ezM0rIxfMYai8RivzBTfCoKtZQdMSCwmORmCihzcsIlM6K8I6pQ0tJ916wbT/a4EpFnrTBfEIds
X-Gm-Message-State: AOJu0Yysd+ek71X2hL5IfyuRoY4CGb3IJnj2s5mCMrXdFMdYraf+Ey4o
	P/oGygAt57V1WSl/huOoKuLiWNO+/c8FyHUY0nqKPpamn/6Yt+0/kMaNYFHFN4+/sefPdrbGgDc
	3SlY=
X-Google-Smtp-Source: AGHT+IGceg5dzRVIGMGeu+y17mgOISrw/lpfzXT+ptk9o2+Vn10KZdcOhZRcjW//XSOCilsK6On4tA==
X-Received: by 2002:a05:6871:713:b0:23f:4413:67bd with SMTP id 586e51a60fabf-240193912c8mr35622fac.6.1715011187143;
        Mon, 06 May 2024 08:59:47 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id e17-20020a056870451100b0023c82e5be0fsm1955226oao.7.2024.05.06.08.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 08:59:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (adc128d818) simplify final return in probe
Date: Mon,  6 May 2024 10:59:16 -0500
Message-ID: <20240506-regulator-devm_regulator_get_enable_read_voltage-fixes-v1-2-356cdd152067@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506-regulator-devm_regulator_get_enable_read_voltage-fixes-v1-0-356cdd152067@baylibre.com>
References: <20240506-regulator-devm_regulator_get_enable_read_voltage-fixes-v1-0-356cdd152067@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

The final return in adc128d818_probe() can be simplified by using
PTR_ERR_OR_ZERO rather than an if statement.

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/hwmon/adc128d818.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/adc128d818.c b/drivers/hwmon/adc128d818.c
index 2a35acb011eb..321a61977396 100644
--- a/drivers/hwmon/adc128d818.c
+++ b/drivers/hwmon/adc128d818.c
@@ -475,10 +475,8 @@ static int adc128_probe(struct i2c_client *client)
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
 							   data, adc128_groups);
-	if (IS_ERR(hwmon_dev))
-		return PTR_ERR(hwmon_dev);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
 static const struct i2c_device_id adc128_id[] = {

-- 
2.43.2


