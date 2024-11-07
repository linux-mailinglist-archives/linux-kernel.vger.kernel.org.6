Return-Path: <linux-kernel+bounces-399184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43F09BFBF0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57A81C21EA1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50C5FC0B;
	Thu,  7 Nov 2024 01:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rLhPO/y4"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6947748F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 01:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944114; cv=none; b=Gh2wnUjVh31bBsuBhu4QG3aDBdNhuzWpRSdss3wk22RO0XKBwwbI5bq92VEG5C36u7ZbSWxjUXf1LovL6kYVVfiDcxRYoXjPeGuL6j1RtHr7iSfIR/B80aJI9voe7lm5Egu6Hiw57EBdKWoQKGKAGv+PCZPBWJUgIo33a4yHv9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944114; c=relaxed/simple;
	bh=V10QHZfYVQD9HFzRtETykMtC4OBrdMMBil6kxYAZ6Tc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZGwYE3mSNBvT57kI2MfVGjGSItVKB6e3IUZhBbytvtCo6NM1OrvhBf/mHW9uclfw+9QsnpJ7/Rr4cSKXv4Ycl04MQjE6u8+3My+xUBFIrXuGQmT9cUKG0HdJaPVURV/MY9d4Q4cm5NdCteiOPHWW0xwSzAqcS8fyWnIuB8xT6D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rLhPO/y4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eaa08a6fdbso7553497b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 17:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730944111; x=1731548911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gL8t9nFQsC/c96Z20xSFXHjy1Xqit+dwKJbQYn+hSkQ=;
        b=rLhPO/y4b8LGZ4XBgAVRdexrsvc2chYMesGpWLaPu81dB7z47zOgGWItHD/I3pedr2
         toRmKIqJoP21AZ4Z80gdoc7svw8B13PmczLebNvQPyikOn9n0ShRj+cEAxOzmlVcFN/Z
         RXTKVfxfQD1xmI3R8ZOwyWZ9sHc+ZitwvtYT/xiLtuLrDuh+Hjn+xIfA0kiujx0ciNCF
         5X5daO8sCjB1lxS5rSsxs2cmhBr5CEi6yRH7wXKfvBP+G6CVozSuKAJIpoIOS9vqDYMJ
         XK1wVgMGa2ECuoCpKcVclk+7HVkSIL6aGSya95XMGXr+1a6IBEyPgHuIeZITlysBaI/W
         zmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730944111; x=1731548911;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gL8t9nFQsC/c96Z20xSFXHjy1Xqit+dwKJbQYn+hSkQ=;
        b=vFcJ1BBj7BUKeNbg1mKwnTTscAgZwWbL8J1Kh3nYdHTbzT2oKRqAaSM0eJJSuMItA7
         iUhjOSCagutVJBBI+jkQpMMjpHHToglI4yN+pGFZ2aDDqx9qz94+wMYSqINyxaeXL/zy
         q3sYovQo5fNICp9ltkXBT9Xu6km1RPnnxm2MOZq5MjIwWuC+Dpv3muQFrxuO831j1KAv
         WBYuhWLPvrWkvlHdt4oUyZzPo4H5hXUuOKDMCCZzZkin8gc6jDHyhFujp0pl9WwRFoz7
         z5VvWxYggpYY26UQifq2m99zIx38imo+SQWqzrEVzMhNG8D5YeUmxeArZiL24pkzN09z
         LbdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIpmuBULdRQ+l/JGIlX4H6LDZhOWz7xNiMnopqWmce2p/veN7jfzwtyeRScsCn5CR5orNXcvwPwjl5cGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGfjDdcUhdclhLG10Go1XTlegrtxPs2J2jQi6QpVNzpmW23OGi
	E8rI7xqM8Xx3Z+VLX8cPOKneCHwQ4yvRIiaTn7sDE/lEP2i0hvTXxIstlNM/Yb6pBstBykVse1K
	/u8TMr1rTag==
X-Google-Smtp-Source: AGHT+IH5q2CSopFJCMFNkDZJtYacCpApjZqhwnvyXYGycM9PriE3s7h0cVn2vA6Wb1UdS8o+oKwirsOazZ5VTA==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:ef:85c8:ac13:4138])
 (user=ipylypiv job=sendgmr) by 2002:a05:690c:6711:b0:6a9:3d52:79e9 with SMTP
 id 00721157ae682-6ead169d03fmr2637b3.4.1730944111724; Wed, 06 Nov 2024
 17:48:31 -0800 (PST)
Date: Thu,  7 Nov 2024 01:48:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107014827.3962940-1-ipylypiv@google.com>
Subject: [PATCH] i2c: dev: Fix memory leak when underlying adapter does not
 support I2C
From: Igor Pylypiv <ipylypiv@google.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.de>, 
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

i2cdev_ioctl_rdwr() receives a buffer which is allocated by the caller.

Fixes: 97ca843f6ad3 ("i2c: dev: Check for I2C_FUNC_I2C before calling i2c_transfer")
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/i2c/i2c-dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 61f7c4003d2f..5d15519ef737 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -247,8 +247,10 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 	int i, res;
 
 	/* Adapter must support I2C transfers */
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		kfree(msgs);
 		return -EOPNOTSUPP;
+	}
 
 	data_ptrs = kmalloc_array(nmsgs, sizeof(u8 __user *), GFP_KERNEL);
 	if (data_ptrs == NULL) {
-- 
2.47.0.277.g8800431eea-goog


