Return-Path: <linux-kernel+bounces-208717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C5990286F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38BBDB263E1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6361509B9;
	Mon, 10 Jun 2024 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0uOp1oR"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7AE15098E;
	Mon, 10 Jun 2024 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718043060; cv=none; b=SUB2lEaJfP+rSe1lRrlXE3NB0HAiGA7T+8ebpC4O6lZkQZwn5aCgqKIuON99yKnRti9ORf0PS1jKNwQbcqUmMS/R+ehRT55HAwtRrOc/C42RVSX2bhM1wxFkUfe2bsKv7t5Bd48Ehc52NhYzv0cLYb6VVvP9TskDsMwtxacDtgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718043060; c=relaxed/simple;
	bh=8TaujMwdgSneCfMTDXBI6ITPwOa00KHwjWVTqUEnIr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KvWmNfxGZ6EIKWh/WE4ZZZ0+tLKGqu5PlvuI9OcI2Ylcu6NMH6hgYE2f0KAV1j1cqM+5HGDcMNJewLKtlWSHSJS3u7eDL2iz0NACj2piV6eiqc+YkelDwzSZUmE6WErToU0GCYtmUSJ62bdZHZBjzc6mlDvkkJSGdO4vl/HiPyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0uOp1oR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7042ee09f04so1780769b3a.0;
        Mon, 10 Jun 2024 11:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718043058; x=1718647858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah0Dh0Ya0pvnHgWC+yxqoBec5cmdNc4DrDcokbfP3BU=;
        b=G0uOp1oR1lCtzYdw40yLqvzsY1W4JN77oTdCK7iQZrgPZtn2ey9GzqLf71NBVS/NkC
         eJYCB84AXocuxq/Coq57KC6iFaSUARZKz5VsSt2zLD2lPax444/y9K9LVpe232qO1vEw
         Aw+7aVVwsHwotx13753jc3kutI4RRtgnunOTwIEPXUYgEjwat7O6MuTCv7m4ISt8rXff
         cDukq8nnk/CWArK24OaI88DfHA70GEi7yJzOamE2oewlMD8k4jhtKOLr4Ph4W2WR4nA1
         FgyzI15Kc6428JAxqMmim+bRRY5zSzFVa7/x3yGRn5wUm7VhwIhMPLQEeYnkNe7Zx06G
         zNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718043058; x=1718647858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ah0Dh0Ya0pvnHgWC+yxqoBec5cmdNc4DrDcokbfP3BU=;
        b=EcbhyGjtaSVRl6xf95zFWL/SC5a8S2GSeRlvnKdOnQdXoMhLjlduJB/sMdYrV4PfNB
         yEJM530DlGsEXM+un8OlTANe1IS28QjS0j+4TXtxM8vdcYCuAJjlVzxIS9Dn0/jn/6eU
         erIaPKwTQDvFSfeusXO/Zz+I8A8RyqvrQibTsq/zyBfKkzb83VZ3Tsi2d5IJWpJT/G8b
         0kohJuT8CCg67KxWo+P7MIgxX83yi//so/GSeTVW3+5nUqByyhpqS+P+AWxKx8llX90C
         URf/S9U9+J97gfb0Zqp0F3+paMSGaxOUqQPo+lVoVj6vDkyRzh+bV2Asg9nyamA6se64
         mILQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXEaw+/dku84AUVpugUj+Zb+iZbhnD9UyjlSAwCcsa4bOqaUMLn7ft6QFdp41IRuCNK/rNYTZG0QUBsgnEzxq/UnrMHPWUAtsMi0aW
X-Gm-Message-State: AOJu0YyX36mF7GNlSmWJqtErmZ0KyVa4N/DDk3S4D8yxaYhMBe0vhszU
	oog+0JcncFLM677AKnw2AUIuP8ys/SKwFduHgN/gMKEXhA7ZsUgUVWYYRw==
X-Google-Smtp-Source: AGHT+IExL81YqzOb/K5/BG9qjCpKDPD94xS28sVG9pO7hfUNP0seAyXDh6MVH7UsCCjQAe3cW0Zu2g==
X-Received: by 2002:a05:6a21:3a86:b0:1b5:ac9b:a59e with SMTP id adf61e73a8af0-1b5ac9ba77bmr7352956637.32.1718043057716;
        Mon, 10 Jun 2024 11:10:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70414a801besm5489914b3a.126.2024.06.10.11.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 11:10:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Potin Lai <potin.lai.pt@gmail.com>,
	Daniel Matyas <daniel.matyas@analog.com>,
	Andrew Davis <afd@ti.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4/4] hwmon: (pmbus/max31827) Explain why enum chips must not start with 0
Date: Mon, 10 Jun 2024 11:10:46 -0700
Message-Id: <20240610181046.1991436-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610181046.1991436-1-linux@roeck-us.net>
References: <20240610181046.1991436-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a driver calls device_get_match_data(), the .data pointer in its id
data structures must not be NULL/0 because device_get_match_data()
returns NULL if an entry is not found. Explain that in a comment to avoid
confusion why this is required in this driver but not in other drivers.

Cc: Daniel Matyas <daniel.matyas@analog.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/max31827.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
index f8a13b30f100..391cb059e94d 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -46,6 +46,11 @@
 #define MAX31827_M_DGR_TO_16_BIT(x)	(((x) << 4) / 1000)
 #define MAX31827_DEVICE_ENABLE(x)	((x) ? 0xA : 0x0)
 
+/*
+ * The enum passed in the .data pointer of struct of_device_id must
+ * start with a value != 0 since that is a requirement for using
+ * device_get_match_data().
+ */
 enum chips { max31827 = 1, max31828, max31829 };
 
 enum max31827_cnv {
-- 
2.39.2


