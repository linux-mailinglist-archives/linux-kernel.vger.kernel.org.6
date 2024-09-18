Return-Path: <linux-kernel+bounces-332457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1831797BA01
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC0C1F224A8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539D9172BDE;
	Wed, 18 Sep 2024 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlAdhyEe"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D39314D435
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726650770; cv=none; b=aGB8ZOBHr2OS/HQTVmNpMNTytEgfdmbkfUd0HTH3fLEq4+SwoItG3Yqjggznu3NNL9T/+CyrYnW7JIF1oko2DxDXY0bkAWdXl6s3hDyvDnJSaQ0bppxbshk8CQh1vRZ4yRDeZn8NtqyXKRls6DvW+U5AepbSAcj62IYnwuLaZFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726650770; c=relaxed/simple;
	bh=RFaTtUenK96MwnPQMkGxyku0XuC0wHswbbHVNaTgQWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XvlRk8+a+MniZjR95Nt/wF9novOPPWv7zXOHGCuvQ5GlAkeXGlcEE7E31ff3jQoaPKsmWInw5YOItjJ65QiHCxY8a39U/L6+pvWN+KSh8JCn7eW3vl6LfoPeZK+eL/ZGZ8O1CW8wcHlw78l4Q64lYEm3rWLDJo3hbex5FOYAE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlAdhyEe; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53659c8d688so449447e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 02:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726650767; x=1727255567; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e7mtzrrfHxAMFofM7L/3yu5MdFC0tPyQO52LstTKoIY=;
        b=UlAdhyEeqOehGFP4I8viF3KhhLNXOVd0DQqapdOZQ3BSmV0ht0WxeVfIXhESmc7wFe
         8OqK29vzP0okHEEBY+H+7HEfRH4YU80Nkw9VSkHxwePdZKJL7KGGujuGhtDoJiS7zGz2
         IhcCfztwjldu5ZEwIgmyuc7uXwQfGmVY+jUFVgUHwm7xLGl7EW5tGBnC0FU/uSb6180I
         oiZmR1gFj7/H5MKwYXqYk8Cir3hBqNH5BwKflmOkYnlk4IZaq4wse2PEQzP90paBeBG9
         pCqUwhFZo0n7iQvsOljaMpUjcbFbAHKw8Irs9pH3jFs0+L1KFJuoyRN2fB+r86pj6+Bh
         5P1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726650767; x=1727255567;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e7mtzrrfHxAMFofM7L/3yu5MdFC0tPyQO52LstTKoIY=;
        b=tcBzVyEBsGADpbGfbjm2CAr9KtY1+lfXhdWnQqn84VNrw78+VkCtOBDxQlnix7Ft1z
         aB9DB8q2niTDtuUlZevMQnHhNzUesg1QEDl9iCuvCk/cD0BjPP4TJuBtZ68RJldt5dk2
         vYWnMD+XQ/yExOgV4KhcYrb3FSEY6+9sR/GKeStof7gCE1G3W9Y1VnQZUZ2KN/rf6T2O
         g1xeCmhDUm0OzSYfhOsjDi7gxA8au/kWawrL48ve++kdi/MpN2TfwAZxYU4T3M97h8gW
         ykjW/P3+QrFmFPF09VzjoMHR2jrKajtYfvw9tS3Y9q0RB9OitwMD6BgybepeUeOZtiRW
         /wHQ==
X-Gm-Message-State: AOJu0YxA5Ej4OVyFoZt2XUw/er5Ii90JEXopc3HHpz9SoB9W3xufb4x+
	Cquk3KiqqJOPih8TJXJJU6oOIsBq2pGdqYuzKFLXsmLIGfG3QoHH
X-Google-Smtp-Source: AGHT+IGz+tMJNGHNA2ZUcmgJmfgaZLbzXaiOzjSVliKYOZ8sMxSJ/RcKohM+OMOO1/cr0ZznmZ8i7g==
X-Received: by 2002:a05:6512:108b:b0:536:552e:5d36 with SMTP id 2adb3069b0e04-536790761d9mr6949284e87.12.1726650766825;
        Wed, 18 Sep 2024 02:12:46 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704dc1fsm1466970e87.103.2024.09.18.02.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 02:12:46 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 18 Sep 2024 11:12:22 +0200
Subject: [PATCH] mfd: da9052-spi: change read-mask to write-mask
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-da9052-v1-1-ce7e7024e48c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHWZ6mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0ML3ZRESwNTI92UNAsT40TDJMsUg1QloOKCotS0zAqwQdGxtbUATUh
 adVgAAAA=
X-Change-ID: 20240918-da9052-df843a1b9d0e
To: Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=927;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=RFaTtUenK96MwnPQMkGxyku0XuC0wHswbbHVNaTgQWA=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBm6pmHj0W1HaF3fJAxU3+2zRbGwGctD3V2oy18J
 PD64NHFkoqJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCZuqZhwAKCRCIgE5vWV1S
 MsfDEADHGSnaQmsVA8KuK9ONhnxSm3/hagEB+WAjcbm5o+NX6WJWwR7OTYbkK/ElEWevZ7yTUjd
 xOrhr34aRwPwKdJwgvOo8NQInl0Dt0C2HzckPJoZTWzgdXuY8v6kxYhvMBMycRZHqS6UhR4l9T/
 8qca0mV+h81OBxtUfxJ9I+RG38TpXTTVUe+9603U2idImtcp2rbd6VznT4rPs3hdg9KxP2GORXv
 PWFnLWrtNI1vqq9/+eX6f2zeeH28i+kend4WiezqORXBEJz8w2qaiqOscIQyL3YjajT6gM+44ar
 o81iTwA2xZvMQ05KCMVZT7Z7bWTizI/35Ni1TT1zW3YjUWl84iaq/swXDyfE01k7lEiw8dGkdS1
 AJ4RtEy/GTNA50K/YSKGcACFgFgTw4pR6wuYcncFS9GYJaOMQWGMrzxmNpEMCwm7BCjM28UyWFm
 Bo5Ba5uVKU9gHzMOW8UV86nHudsw5raVrmRV4E1OB8R1GuqU2Y7lmpsnCdrM8YrD9jjmFzNZ84A
 8g96FIIGPeAebyUgmGgV6qe0mmrna4+pB7oySquLrr2XgVTO/ZkGsxv73ZvmuglS5ZtycWEgG7H
 w3PTp5+XM7kE8kueLQT3DFok1GLtvzSShIEfNncmJQSGZieDh/Gl8EUEZmh/eXgA9riRnQWRAXj
 fDa+p5l8hkpD1Pg==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Actually, the LSB bit is set on write rather than read.
Change it to avoid nasty things to happen.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/mfd/da9052-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/da9052-spi.c b/drivers/mfd/da9052-spi.c
index be5f2b34e18aebc7a9506123b366af5a5447df43..80fc5c0cac2fb0e5e99e6db8972f80ae4155b226 100644
--- a/drivers/mfd/da9052-spi.c
+++ b/drivers/mfd/da9052-spi.c
@@ -37,7 +37,7 @@ static int da9052_spi_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, da9052);
 
 	config = da9052_regmap_config;
-	config.read_flag_mask = 1;
+	config.write_flag_mask = 1;
 	config.reg_bits = 7;
 	config.pad_bits = 1;
 	config.val_bits = 8;

---
base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
change-id: 20240918-da9052-df843a1b9d0e

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


