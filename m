Return-Path: <linux-kernel+bounces-434015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D039E6027
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 22:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B24281AC6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FF91C07C8;
	Thu,  5 Dec 2024 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uze7RWOz"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974A13A1BF;
	Thu,  5 Dec 2024 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434402; cv=none; b=ojrm/vkJdeJeYiHfi9CE+DFjJ6GqIX7wxHmfXV+1GMT/85OIaP4/3kkyYDSEF+z5VkVpZhj2LNSok8U6/TkHsZGFprlE++Ty1RI19e/2y+SYiA2Ptz0pGYxmFR91Gf2mCfqvPz+XPWmtoAgjx0w9b2HlkwHuofkjb/IZOs5D1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434402; c=relaxed/simple;
	bh=HUOXxkGz2gXCR6o1hCI5S+nZ0frDZ8AEK2vcrjyTOC4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lrc3ZrxGaESZOH5492WvWfI1woNRfvGzUKyjkVBiVQXZ6uK/KvUzWUY/nXeNz0zwyd8ZREI9qbEAKgCo1HWtNpM9N4udgHGOfNKnOVwL8/a90ABDCig2xLvX53IZee5aoziMcRTP4OWHHpxr28i6VNVEjuI4GoOU2ldp2S1ZGqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uze7RWOz; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so2236676a12.1;
        Thu, 05 Dec 2024 13:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733434399; x=1734039199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6bcJ+adG+PTC8FsMnuLdxJ2qQh/RKRqifnJAV/qUxPQ=;
        b=Uze7RWOzYXkRkB/qk8bUjDX7GSfMAHCYHNLWcaAFBLfW8kVsW5MeBsLtNu5T0o4s/v
         YVQmDPZWn6UZpsbaUn3Eeo9+849Cn7DWa/pzjugoLW9d7UBS/KKBwqIdtwOhD9ubz9fk
         FRmi9H7LzhRWpFxT+XPJBqnDTJPAApvLSx63q5X75MqVP/35oVvBN0xPU+/tCrhlGWV5
         4e+Pe66vHUdwGmDPrbonA5XOQ+d3tdeYPSZbn3eQbIMB0t5ZTDgOQ8cz8O8wou+zxaZW
         qQG8PIg6JMsbSWuvCYlIFYOfiJNUy7D8EuqFlG94mTv0hR4YB/AWO8U+SkxUJFos4Xob
         7PSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733434399; x=1734039199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bcJ+adG+PTC8FsMnuLdxJ2qQh/RKRqifnJAV/qUxPQ=;
        b=PRd0FYJTWl/pydu9RHggvNsHXMryazdIxxWIUgw9pxxHEd9hcbpf2IfN53c5ONU+wi
         nzqyY9KY+QvaxFbMXpt3iZOnJlt0H8j/GjPO+Z6bJDs/sMY2yd8PFw35tCUI+/UpNCLw
         C7zKQV4KyxWj2X6nvoGxWo7najEaqFEWYebDEiSFDA/OYSehBwDYvijRthgA5sqGr0jL
         /eS2K2sDDJ66Cj9JC/Y2cLGhdnOJRm63cAKM3g3Y1Ws4DPZqtNF767WgT5iovNI8DfLQ
         XWf13skcuPSuR1AsNGoczKHFfHYPQuiaTMXbaImowSKoP1iiPHtI7CFS3qAAlRhVaegT
         v4/g==
X-Forwarded-Encrypted: i=1; AJvYcCWYfuS2tFzfXyJ9CKbRP1e3YUwv1VmhTpYT6t4AG9MHhO+gDikcpowdWQnxCK8m80M5AjNVV8YLYoxAj38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsBiLx7MCc9DeHRLbzgaoPlS1jZG22UiQnJ1myMrc/TOxBaFzI
	CimUWWg9ZJhgKXtZtPI26rJJSlAPET0c6zfT0XwhEaREDOQSSsAc
X-Gm-Gg: ASbGncsZedZkTd8z0zIm2FvhgheRxkZwKXPA7OZaDovvZ4gkDwbTLE3I+hIaOU+qTa/
	c31CtC7F1SbN+fzTIt2NZw+qaWVBPZ8D8PODV2kbW+5zFoucaGKKSfOEaTQyjPFH75qJC3e7ftM
	jSoZK15tx6r3MGeQhFbA6/+qNZEAju+xIptWTRWfpwfbguGhwTvHFzGZoibTBbKEjtFTn787lnW
	KUUoWBkHcyRJR17i2shi9aaflznJsMCOrIwEQWvCFzenOkGSVUHo5hlm3Kx
X-Google-Smtp-Source: AGHT+IF/FvMHqVKEDwOojM1aSQV+L/Bz+DGKiOQubIm1awf08FCWcLO+KqwSvrc4esN06W6kBRxWYA==
X-Received: by 2002:a05:6402:5d4:b0:5d2:7199:ae6 with SMTP id 4fb4d7f45d1cf-5d3be6b46ebmr516111a12.9.1733434398597;
        Thu, 05 Dec 2024 13:33:18 -0800 (PST)
Received: from localhost.localdomain ([83.168.79.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a2602esm1311768a12.18.2024.12.05.13.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 13:33:17 -0800 (PST)
From: Karol Przybylski <karprzy7@gmail.com>
To: karprzy7@gmail.com,
	skhan@linuxfoundation.org,
	jbrunet@baylibre.com,
	jdelvare@suse.com,
	linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: tps25990: Fix unreachable code in tps25990_read_word_data
Date: Thu,  5 Dec 2024 22:33:15 +0100
Message-Id: <20241205213315.3073207-1-karprzy7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tps25990_read_word_data function contains a block of unreachable code caused by the syntactic structure in the PMBUS_VIRT_READ_IIN_MAX case.

Specifically, the return TPS25990_READ_IIN_PEAK; statement immediately exits the function, making the next lines unreachable.

This patch removes the return statement, leaving the expected handling.

Discovered in coverity: CID 1602227

Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
---
 drivers/hwmon/pmbus/tps25990.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/tps25990.c b/drivers/hwmon/pmbus/tps25990.c
index cc0f5c7ce..0d2655e69 100644
--- a/drivers/hwmon/pmbus/tps25990.c
+++ b/drivers/hwmon/pmbus/tps25990.c
@@ -130,7 +130,6 @@ static int tps25990_read_word_data(struct i2c_client *client,
 		break;
 
 	case PMBUS_VIRT_READ_IIN_MAX:
-		return TPS25990_READ_IIN_PEAK;
 		ret = pmbus_read_word_data(client, page, phase,
 					   TPS25990_READ_IIN_PEAK);
 		break;
-- 
2.34.1


