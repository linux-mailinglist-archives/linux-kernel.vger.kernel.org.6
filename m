Return-Path: <linux-kernel+bounces-390496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBF79B7A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D68B21225
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF0519D8A7;
	Thu, 31 Oct 2024 12:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frf9+YQW"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED0119D07A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378024; cv=none; b=sCX+KxXdlWELGw19mJyGzvwVsUFe+AQfmcFYgZ0fZvw8MN8hOgXUcnt6aY6H+JlQNR0RXDJjK2obpqvqeeFH83fjcIY9tDY6EDRlJvFRsO9oVBbTMw68S/uBvguemGkMcEYM4GyEY//o76p4Kb63Y38veiRo5rn33TKbN0tRvBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378024; c=relaxed/simple;
	bh=XY/e+qqPS7e0meMx5s4+Qz6L5qELEoWgsNV6AMJ2Cko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OITQFwAZom8DcGb1HGMHxpenRweCjQxtd5+EvpvIGSuamX6/80zSi4gRP3V2pR8rzmKU9NoDzJbXsjR2MA2SXkaSXBaq9qwBx5ST62FUR6mYSrWlMh/TyezzfQYL+1qbbesPZFQUL9e2ZhxuSeFw8Zy+6LIN5UAw6TS1gb8P/yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frf9+YQW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so6956455e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730378021; x=1730982821; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xblh8h/kAs6iXd31tRjqnAQ6XZmMD34sBupGmOL7KPY=;
        b=frf9+YQW1IALvSQ2rQgp9OXYNnqz27C6icVbvcTEvKqFbHw5kj1jwUc865uKm8N0vr
         69v9GlB0u2TUkldinnEGj7LNwPCm5FlHuq3AYAh0wviM3BWYhPcr6Wm4cmn3BB3UJEZ2
         OhdC+H1P3M/TDYLzQMDOl32eJ4ccZTZh6AWT/1IgEZcYOLxQAGozuxMQkmSAZdkOxFMA
         2LwjdLAkSiLR3BL7yKFJsuxzONs0tMmEHYNgncDxGCQHBgIlrrteIJ75Nj5pCkpeuDAx
         Oi+B65kHnE433nlXXpZNeCqtITzYponUGAeyEz/7em6KKGbGMILjiUH9RxA6HAzpJNRn
         Z4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378021; x=1730982821;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xblh8h/kAs6iXd31tRjqnAQ6XZmMD34sBupGmOL7KPY=;
        b=rDFlSXji6cXxFroXDWMFHmgzG4WiunyRpJRLWcQCDIBzEU6M3E58vM7v9MeoUf2+TH
         7EPHtZi/nn49GuvKWOtKfpCBV5gW3JsGkk1pxpfDRZcchoq/8YfhkJkiHZ19kNGrSnZp
         oAceWXBSeYnoyz545nNaXa3XBmsp4RJzoFDwx7KkHI/YUXbVAwQ7x/OiOCXLni1rdTGC
         YSCXavDEVkhXnFvOCUGsrQ0J1R991iqf7/aJR4l0c5U7GCEbxz8QDBJeiqNa51GZzfEf
         TIFQAZgYL83ob8UEzr9vWq03OvTaNT3ojp4VHDXHgllTepSzXza8Iha8e/wtDKsSgrtY
         B6rw==
X-Forwarded-Encrypted: i=1; AJvYcCV0tVsnGe22/MwHUoYiriTSPrUAN8Nlnpu+IFp40jLpAiqCLa/74819//09YBjuV8vPg+SiG7CGtKaGM+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YysQ4JpEa00EQ1ChchuSH+dWhilGulx/71vl71LH5ZD45YAprtY
	8IEoIyyEGg5DDcOZpAjY6cDWPo52+e4Ad6E5axDGckqROHGEoRLM
X-Google-Smtp-Source: AGHT+IFeyhhAwD+U7wvpGW1to0bqTyogY7pqH01jXa1OXe1oSVmcsTNTQEvgBNoc9bsK9FR5T/WTMA==
X-Received: by 2002:a05:600c:5114:b0:431:60ac:9aef with SMTP id 5b1f17b1804b1-431bb9de94bmr64537225e9.29.1730378020647;
        Thu, 31 Oct 2024 05:33:40 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d7b9-afdb-c541-d023.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d7b9:afdb:c541:d023])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5ac002sm24703855e9.5.2024.10.31.05.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:33:39 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 31 Oct 2024 13:33:36 +0100
Subject: [PATCH v2] soc: atmel: fix device_node release in
 atmel_soc_device_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-soc-atmel-soc-cleanup-v2-1-73f2d235fd98@gmail.com>
X-B4-Tracking: v=1; b=H4sIAB95I2cC/4WNQQqDMBBFryKzbkoyEdSueo/iIklHHVAjiQ0tk
 rs39QLd/ffhv39ApMAU4VYdEChxZL8WwEsFbjLrSIKfhQEl1kpqKaJ3wuwLzWdyM5n1tYl2cIO
 W2FmLLZTtFmjg9+l99IUnjrsPn/MmqV/7z5iUkEKj7Ug2jbaqvo+L4fnq/AJ9zvkLeGMpqroAA
 AA=
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730378019; l=1518;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=XY/e+qqPS7e0meMx5s4+Qz6L5qELEoWgsNV6AMJ2Cko=;
 b=qqq3DIRvNYIGMvKD6DUlQ2EMYsP2DULjMXQz9qGUrSWrumJ4JKW7+uyvvZ2gOy8GQsxB+7V+t
 5pKfY3wsTniCd7wWKjfOa1//T6yOwSbdWIlkym1nnYMcyaCGb6m0pqv
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

A device_node acquired via of_find_node_by_path() requires explicit
calls to of_node_put() when it is no longer needed to avoid leaking the
resource.

Instead of adding the missing calls to of_node_put() in all execution
paths, use the cleanup attribute for 'np' by means of the __free()
macro, which automatically calls of_node_put() when the variable goes
out of scope.

Fixes: 960ddf70cc11 ("drivers: soc: atmel: Avoid calling at91_soc_init on non AT91 SoCs")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Squash patches for mainline solution without intermediate steps.
- Link to v1: https://lore.kernel.org/r/20241030-soc-atmel-soc-cleanup-v1-0-32b9e0773b14@gmail.com
---
 drivers/soc/atmel/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 2a42b28931c9..298b542dd1c0 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -399,7 +399,7 @@ static const struct of_device_id at91_soc_allowed_list[] __initconst = {
 
 static int __init atmel_soc_device_init(void)
 {
-	struct device_node *np = of_find_node_by_path("/");
+	struct device_node *np __free(device_node) = of_find_node_by_path("/");
 
 	if (!of_match_node(at91_soc_allowed_list, np))
 		return 0;

---
base-commit: 86e3904dcdc7e70e3257fc1de294a1b75f3d8d04
change-id: 20241030-soc-atmel-soc-cleanup-8fcf3029bb28

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


