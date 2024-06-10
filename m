Return-Path: <linux-kernel+bounces-208715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A2490286B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C961F22D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3CF14F9F0;
	Mon, 10 Jun 2024 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4eaNNo2"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588EE14EC73;
	Mon, 10 Jun 2024 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718043056; cv=none; b=AzUSlC4jkoHK63De2bh1sed1bQqxKiECC1mLTuFWctqQpbLPjtuCgQWa8ttXRe2JTHgW46c1HNKdkOym17MFTeCUAHq+MdsZVw1nC4aSzqOrjy/qUuqhOSP3AeM3FN96fTYtIyufSjAz2tr/2baHV3NH9RNRxgyLS0+jvkVr+Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718043056; c=relaxed/simple;
	bh=9zjOarVLW+SBvaeGCw+THYMGtZMeawipUNd7eF/rih4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tHGX5odSOLYNT/1Hng8efbPBX0xj734CVwyVNMzaV+g3TEfTf/maHAOTK7NP/TYzUoImrYjdUstm0GBHtTumxb6HOIOexjLzGQwRFlCo8m3uA9Puyb5hcDEZdVesm/sCj0qqCDapEHzPPjQ12tuFIltcpJxGAOnU1KJGVdOoibI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4eaNNo2; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7024d571d8eso225800b3a.0;
        Mon, 10 Jun 2024 11:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718043054; x=1718647854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wI+PZ7h0a3YwBJogrFDchjGG7jDSfmWZKRcxXZ4YjYY=;
        b=l4eaNNo2DYI2JsAIVvQOGtZ/FpPJbzewpBdQfJRCa5cxoqf25ICK2FwHnfs+OOXh5O
         QdDzFhS3nsxtGJhXSUvnXXNsd+e6DdkssLfB0HpgVn2U0casKlwLt+fHsXOHRYQ5goiP
         B5WCl8IOC1fZngENUjkGO/Cbp9B/dRsHDHdOR7adKHGpIjvqys4NKh/WBnvobpzOoiO+
         dKDA0uHUfNNCg/xl+kx7o8QZ8A9gFaaXQkYv8OjKhFzPbQXkou9Uz2HO4eippL/H2Lbg
         rNhz/vc/ycJQoUGFufYGQLDsQltE5QzfqPSatSQi8h9p4i6F82Rvbe5Jk9lJtG1tIP7S
         j2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718043054; x=1718647854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wI+PZ7h0a3YwBJogrFDchjGG7jDSfmWZKRcxXZ4YjYY=;
        b=SEi/MI6ps3w1kOZ6YEHXeOdvtQ4ka7EUH1nxwCCBtUkRpjStWYtjZmx15DDpzj8nLX
         ViKDA8BqTeZEzp6z/nBIkgHuowq80Da3KBvwTYWPtqYj8AlbAXhDLdkmbdLnZnV3/7OZ
         U9necx8YgenHdjBb3utobkz7hLbtF8yvQXMOxG7hp77MoyBJEu6EdbtBa7CaDT0Vbj/d
         xNoMB6g6OF1FBfLIqreGmeAGrb8AO6eo+ZEung/d6Y8KlrW7kJ1uXDYGLfOhA20AZr8o
         YxvwTLdEdDcLwQiutUMBieaJ9N5lUhfLnfGtqoTuEuodFc3Fzndqp6gLjwejzQbu/qQc
         sveA==
X-Forwarded-Encrypted: i=1; AJvYcCUgfPGMNCpntJHpGaaFPxR89SNTvv/VM004WW1nGhW/emPPHSiXnlTa9gusDlpFzRfqJdrQPjD4L/lbzT/aFCwYNNhtxGsXzP0vvySK
X-Gm-Message-State: AOJu0YyVryL+U2YHzh3hXJif68nJtRJ5pyhDtHXCdFtH5eatvk6ewe3K
	Qy3zyMCxe/zoZOQ0NZrLCLv/rD5kYXTfMxS3hS88/dnuzznzJ9tzOHvG5w==
X-Google-Smtp-Source: AGHT+IELcIlg5odwQ6B94ZQxqkakid+M/03MSICoIEdeR0lvDXp+jSDHVwlbklfAiU0OODprzXxi9w==
X-Received: by 2002:a05:6a20:431a:b0:1b8:54f8:3857 with SMTP id adf61e73a8af0-1b854f83952mr1483461637.30.1718043054091;
        Mon, 10 Jun 2024 11:10:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e8080c2f55sm3839630a12.83.2024.06.10.11.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 11:10:53 -0700 (PDT)
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
Subject: [PATCH 2/4] hwmon: (nct6775) Let enum kinds start with index 0
Date: Mon, 10 Jun 2024 11:10:44 -0700
Message-Id: <20240610181046.1991436-3-linux@roeck-us.net>
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

Commit 10a0575ea09d ("hwmon: (nct6775-i2c) Use i2c_get_match_data()")
introduced calling i2c_get_match_data() to the nct6775 driver. As part
of that commit, enum kinds was changed to start with 1, based on

    Adjust the 'kinds' enum to not use 0, so that no match data can be
    distinguished from a valid enum value.

The patch had to be fixed later with commit 2792fc8f8c83 ("hwmon:
(nct6775-core) Explicitly initialize nct6775_device_names indexes") and
commit efe86092ab31 ("hwmon: (nct6775-platform) Explicitly initialize
nct6775_sio_names indexes").

Various patches submitted later show that the change from 0 to 1 is
not really necessary. As it turns out, it is perfectly fine as long as
there is an i2c_device_id array with the same data as in the of_device_id
array. This data is used as fallback if the data pointer in struct
of_device_id is NULL (0).

Let enum chips start with 0 to avoid confusion against other drivers
where the enum starts with 0 and i2c_get_match_data() is used as well.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct6775.h b/drivers/hwmon/nct6775.h
index d31e7a030216..296eff99d003 100644
--- a/drivers/hwmon/nct6775.h
+++ b/drivers/hwmon/nct6775.h
@@ -4,7 +4,7 @@
 
 #include <linux/types.h>
 
-enum kinds { nct6106 = 1, nct6116, nct6775, nct6776, nct6779, nct6791, nct6792,
+enum kinds { nct6106, nct6116, nct6775, nct6776, nct6779, nct6791, nct6792,
 	     nct6793, nct6795, nct6796, nct6797, nct6798, nct6799 };
 enum pwm_enable { off, manual, thermal_cruise, speed_cruise, sf3, sf4 };
 
-- 
2.39.2


