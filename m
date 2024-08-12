Return-Path: <linux-kernel+bounces-283395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F58A94F1F0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB8A1F22354
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042D4184548;
	Mon, 12 Aug 2024 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQpLBlgF"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A22184538;
	Mon, 12 Aug 2024 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477400; cv=none; b=aCUVWlnGH12gGTm+J5VoOswTwSHRDQsbVCN7ayoPYfztnWNhOsZe+dNje/xjtn70PimJNOdA84dCKlGXar/2voMw8IQ1UctANF0dnS4k1neYj2Tm+EaGo5/M+g/LxboHtj3f18Y4AxAp+TA/0Ks5A5CRgo6uuS4TzQzP1F6GuyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477400; c=relaxed/simple;
	bh=2e/SJZWxsVQF14SfYRDYZ+IT0RptZld+vlK1Oi4VfHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UfatTMpFipoQt7s+y5Sta5++5b4sD5OV9hVQ0/YvPmGa3AuOt7Tg0AQE1vEAaE2Oo+WxQYz7cRzbmfO+M2xE0/fO6iGR7piz1u59Y21MrNyGGizJzmF29CLIRxXhWpwj2e8nxYm1WsUPxHfIM0Nb6Unh1PzuJknXM+MvWXmq+yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQpLBlgF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso34684265e9.0;
        Mon, 12 Aug 2024 08:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723477397; x=1724082197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HMcXMafGUeagH3HWTYPTPUP8C9AvF//ox7xL6mXw1Q=;
        b=eQpLBlgFekkamyjF7UvvEwhfb2z4NT43csUzIT0Qq19aqeUXFswOHPxO5wMI/i/KFA
         JolqbOAkkT3R7kxu3QkMbHjbi7uDdPN7jmh573x1U/Dd213HXTs0rNSpTtGnK09TuigA
         U+gAZd/78qoAyTvtVocOigfdNYypr0IeuPGEVEB4F7/jA02BLI6GiPbwVlMNCeQl4/eP
         a+xLEUKANDauwPsO943ggwi+AxBCn1Jgo1SchmrJcxkT3zRU6XonMaEWfkFBGEGOs4DX
         BxBHsV4eKqeL94QzRp6MtAVLGJ9bGN5KStURPEA831iWOwo0GBph93PuEK7940iD+V/d
         xUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477397; x=1724082197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HMcXMafGUeagH3HWTYPTPUP8C9AvF//ox7xL6mXw1Q=;
        b=nV4vGvrWlqRFOJYdK4wJ6I3B+nYmNRCPXnDg6Pc2hCiIBdUou5O0VRIIVmY0D1p4AU
         QJM9yhmiz2ORXe+jvac3i9WA8KlgtA9yjhtxnKx9PQf92GLoF7efF9vEegICA0Vk8jSV
         1GlJv8AU02f/OD20HACmX/KpOhmTIvXF45EWQ6exSUniJBNCxLoCsgN9NAqogPzXrlc+
         6VfOlCIEbE3D55EUiprD65B+ktI/kxxozEyci+Bswbxpvt4tekbJfw1oAaV/fBX545m4
         LEAZPxtLKnWjJPcY36DFEH2YYkGjJbAuBCiG1iCwftP7zLPau4VYwrzE+SR8fmc0iwKJ
         TVCg==
X-Forwarded-Encrypted: i=1; AJvYcCXXlO5pkp4aL5UAj/7kbZZXG5NbjpPR0RiI4maBxWAzYDCGcP41aCu1UyFMi1vAJgb73Mn6WJ1Mzc9Lmdpkx1wgK3NvIeDqmCDU5F7h
X-Gm-Message-State: AOJu0YwUw19gvLEmT5Gi+lpCtWcadGb8ynnJa6aspFSkNt1+OQ3fu3lt
	5MP3tIq8KIMOnTWw+9nAoI0nIsS8hEBbaTnKWTQvweVRhzOVG8YfcGSN7Q==
X-Google-Smtp-Source: AGHT+IH4f+SaTULKgu0pKn586U406O9anuvW9LlX2fW5MTIEos1E43Efo0aXwVljuzz82X8z80Ibag==
X-Received: by 2002:a05:600c:138c:b0:426:5ee3:728b with SMTP id 5b1f17b1804b1-429d480cba5mr6046195e9.13.1723477396774;
        Mon, 12 Aug 2024 08:43:16 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51eb47sm7859713f8f.88.2024.08.12.08.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:43:16 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 12 Aug 2024 17:43:02 +0200
Subject: [PATCH 1/2] hwmon: chipcap2: return dev_err_probe if get regulator
 fails
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-chipcap2-probe-improvements-v1-1-3cdff6d16897@gmail.com>
References: <20240812-chipcap2-probe-improvements-v1-0-3cdff6d16897@gmail.com>
In-Reply-To: <20240812-chipcap2-probe-improvements-v1-0-3cdff6d16897@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723477394; l=989;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=2e/SJZWxsVQF14SfYRDYZ+IT0RptZld+vlK1Oi4VfHw=;
 b=HgrOP6h7NFu+rOzmfKgN98F7iKqXe2en3TSEqNiIuzmSxeLHyI7AWhC25OIzy4hglLOUlntbn
 CVaE7k5YEc2BDRrk0VLqsuhgOIuu7HwMotBD0ToOLFyHmqQo7775ycw
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The error value can be directly returned via dev_err_probe(), and there
is no need to split that into two instructions.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/chipcap2.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 6ccceae21f70..88689f4eb598 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -740,11 +740,9 @@ static int cc2_probe(struct i2c_client *client)
 	data->client = client;
 
 	data->regulator = devm_regulator_get_exclusive(dev, "vdd");
-	if (IS_ERR(data->regulator)) {
-		dev_err_probe(dev, PTR_ERR(data->regulator),
-			      "Failed to get regulator\n");
-		return PTR_ERR(data->regulator);
-	}
+	if (IS_ERR(data->regulator))
+		return dev_err_probe(dev, PTR_ERR(data->regulator),
+				     "Failed to get regulator\n");
 
 	ret = cc2_request_ready_irq(data, dev);
 	if (ret) {

-- 
2.43.0


