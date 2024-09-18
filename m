Return-Path: <linux-kernel+bounces-332635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D149197BC45
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938A7285C99
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFC918A6B1;
	Wed, 18 Sep 2024 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fmqGxc8M"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBAF18A6B7
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726662764; cv=none; b=Sgy7M9JtgSt1hg71stwQNNHZc9L4N7mQTBrZqowy4FJyvLt+HzPiuNFGb9daodDe2b9jnzXs1vjQTRqc9ywRYk8wlTBFbImnjwywFoVY8wtNfMBdUmetSg0Umr/C1V7QD5CRRTAeJ6ka6MvFFM3GYxk+a6HMc4vfxgyvdoIHlQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726662764; c=relaxed/simple;
	bh=kOxd9hIIzrOu+J19O/SGnOcMPFAhrQs2vHhAmEtEjpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fuFo7sPL4vXFvD58lBEfGd619vC8s9N96c09S0qk/U3AJ0Nuawya6yrxRRjkcHX50KqIOzj59qB7o2TkkiaCOZuwjjZVt9kb/hCyEtH53mQqmotE9UXuVNDjgEQJzdKhsY+c4tPQweJD6oVlUZCpFo8PQTR3Re3pNzSQnUtopVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fmqGxc8M; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso145994166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 05:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726662759; x=1727267559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C/FoiqPcoMPi8o1D9aYXEQxqaTmmjAQElRJaLfC5ZU8=;
        b=fmqGxc8MMukvScUPyjv4UnrOZ5w8NUpnzcw2SWaU4JNUyH4Ndpab5QXs+MFf6Mlx7n
         htEIhGHavFbb9uO85YrGbKWXum/rWKmTJ5b+Af1Pb/vPdrWxvjOE7JxV9o4FToNHxY+z
         zZFrSEFyqYVcDjUcFCiB8+oZpR5f1up74w/jmzil2UGV5gltLqDGxgMS7bXnpv04FiF4
         Evl5t9JA1kuFFT/QPlqJYiMMUBoGfJ5bg/kgj36T9rqq+QvprWI/UKg9Za1HaHhyXjPR
         Efk9Z9lQwLa41YbG5FJL8tmcm7NJYHFaw9dcS+f2ngA4YRKvFGiXZMUNtHWZpFdoySA4
         bR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726662759; x=1727267559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/FoiqPcoMPi8o1D9aYXEQxqaTmmjAQElRJaLfC5ZU8=;
        b=LpK+zltWGWQkumBOHZVXvRdJVDwedb4MhLIxkKUmR+a1BSsjUQ7GW+ZoUrw2z9FZRy
         hA1ABD55dySOjiz6fPfjBhvw2YCyQHYx+FKhUaKEEorHi+RxOuQHaxAjtei+w0DL3vWd
         LxPsWITU0N6Cw3Pm8Mi5sAabFx3TM1o9RryNdg3p2/0IxFGgdwCFrzSJJ6IlRHD+wN+r
         iPw/Dp7TTIdxOWGNQMAkO2VZxmX2SMr5sdUpPq+E1IeRH64K+MMP/b2fwphdA4K0Gr21
         53X44IFNpPHfkitTgdXOkEhNdI2+kCIfzMKUkcCv0YuG+vGtB0PFnDvkO5hMAvOpPMbb
         4uYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZwBX3YEdt0oKRxn/UV7eBUPCol+WGVGulPKhtygtjpFVKKPtC/U76oePjwfqS7gzpZElif5iMdsSy+0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxQpE7p5WZfxN3Uyiqrwa8vEvH+7U0U2CLYUQMAFlL/Ivz+zFN
	zmWrhnyAY+Rc80H8qB8MNtw9y9LsnGct3LNdETQxirO83mpz+RvJ5cbS5EZpUpJAFPJncy5pA5o
	M
X-Google-Smtp-Source: AGHT+IE5Jxem8UHzHB+VP+MJx/8nOqZr7Uu7MQy/5IwXdfgOYZc1XDlhB2tBKk/HW3Jb8uOyGMxEVQ==
X-Received: by 2002:a17:907:72d1:b0:a8d:6372:2d38 with SMTP id a640c23a62f3a-a8ffabc1d72mr3041383566b.18.1726662758730;
        Wed, 18 Sep 2024 05:32:38 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:a2bb:f619:b5e9:672f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9060f39a8fsm585047566b.0.2024.09.18.05.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:32:38 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: Drop explicit initialization of struct i2c_device_id::driver_data to 0
Date: Wed, 18 Sep 2024 14:31:51 +0200
Message-ID: <20240918123150.1540161-9-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1323; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=kOxd9hIIzrOu+J19O/SGnOcMPFAhrQs2vHhAmEtEjpM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm6shAr19LilaNvFAzfO8S0L/dGkK42FS6l4DJy z/2xkG3wG6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZurIQAAKCRCPgPtYfRL+ TksiB/9YD0/tcZ59j1vmS0BJK/DFdgSsCbJcLA1+5ue+VfD4rfoS907Qy1sGJx5WwaopQm19Olt cKNgNyhVqi6WYx4vsjCJoWNt7IBs8JjoJDnlnSNL3XffwkuHHkMqUGbOeaMpz98GQ4xmr0OvZ4t M5zFLjd5EJdYa2mJCAG5eIupmwPJKqNW3T4Um2RSO+pLU8SkiCJiTXMd6BnfjpMfZ71BrL1ksBE 7SK5dL8dS0Q1AETWcBEO7ClQrsHnlcu7wBw7NrauYNMhkzvr7QbFUbiue50oL4bPx7i+P3E0E5l KG7WfXhnu36rz6dJ88+oDRLFrJvYiu8uTnEuAOjwJk18v3Hp
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

These drivers don't use the driver_data member of struct i2c_device_id,
so don't explicitly initialize this member.

This prepares putting driver_data in an anonymous union which requires
either no initialization or named designators. But it's also a nice
cleanup on its own.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/clk/clk-cdce706.c | 2 +-
 drivers/clk/clk-si514.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-cdce706.c b/drivers/clk/clk-cdce706.c
index dd3d42d9ad86..d0705bb03a2a 100644
--- a/drivers/clk/clk-cdce706.c
+++ b/drivers/clk/clk-cdce706.c
@@ -678,7 +678,7 @@ MODULE_DEVICE_TABLE(of, cdce706_dt_match);
 #endif
 
 static const struct i2c_device_id cdce706_id[] = {
-	{ "cdce706", 0 },
+	{ "cdce706" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, cdce706_id);
diff --git a/drivers/clk/clk-si514.c b/drivers/clk/clk-si514.c
index 6ee148e5469d..1127c35ce57d 100644
--- a/drivers/clk/clk-si514.c
+++ b/drivers/clk/clk-si514.c
@@ -371,7 +371,7 @@ static int si514_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id si514_id[] = {
-	{ "si514", 0 },
+	{ "si514" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, si514_id);

base-commit: 55bcd2e0d04c1171d382badef1def1fd04ef66c5
-- 
2.45.2


