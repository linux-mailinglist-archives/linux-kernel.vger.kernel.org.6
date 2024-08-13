Return-Path: <linux-kernel+bounces-284744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 909209504AA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3A0286E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B159619ADBE;
	Tue, 13 Aug 2024 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UbDlZ6d8"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D15E1993B0
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551235; cv=none; b=VjJWI7Tl8I65Yqqttt4gkc12StZG+Hf6EAYw6vxCfq9DfPQDSgPeJrgR2QdzNr3FCxW3F+UyDlWuqb0hqUwvw41ZFWJdNpuUMbv539BrJAdQCuSJgKi3TaoJ/nx9HKT+fbvIiynzObxjNlGiWM8AkZCMstIWEG6WfIcIia/gjzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551235; c=relaxed/simple;
	bh=F14N6L/7XjC8oRmavmnQiXfhM7cavcf0lfyqWY/R5js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sbXTKYot3J7nOSkCABSwZFKK3Efy1az2b5PQLp0OcG82b4RAkI7CuzNiqhHN/mXC/AkEhNb0wBt9VtDE1j2Bq2g0E6SqyWcSBU2/CF8I6RFezo2PCTuG+uOAbuoPkp72R5nqIl5mj2B+YmduqaGtN8RidLDDRlgvXTp0OTSPdwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UbDlZ6d8; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d7a544e7so365189485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723551233; x=1724156033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LrZdtpz/qyn21riVVQ3i7W1bl9boREamJ7f5SQNbyMY=;
        b=UbDlZ6d8Kfn+w1WNhEcrYWG1Ri4Yg6sAGi38rXGDkVBS2hTzI7n/I30K5qZrA6nJOP
         cFt0uzjbN3uArZ/n11SGX9jlXJFmF20O4TfNok4JtQvVNkrFnGbqvZ9GJG4gOoD63Ooj
         AxvR7kASGCwsSu8hze71fCXDqGeY0x3SJCNtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723551233; x=1724156033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrZdtpz/qyn21riVVQ3i7W1bl9boREamJ7f5SQNbyMY=;
        b=t6AH3tKtDyc4MEbDk3goUFXE4JzHeWpIsWydqjJBAR5w6+T9qtejeQOEryEyqpf734
         bos280P0YsovmSlO6/CkAtWfZ4VQfmSaPzBjZduB5CwdmDxybdhQNnhGlfhuaf5aa0KC
         aZtAq2JbH1MJGwXimWYTp3ACzwAXdE4XXqavu2libcemCv2G0qaxuSDIHMUT4a8Tll2u
         HdQncIvB+lDdWX1W7OR23GPZ5OCfopaz4FZTwFGcjP0v9KyLxGZ58nLQMa0ojt5rV5RV
         7o5lA7s9RpKhCB6NPqZdDyYEk/0vV8bMm30lv1cftzaSYtedx3P7STii1h+gKvwN5O1Y
         g6ew==
X-Forwarded-Encrypted: i=1; AJvYcCUKkT/gfg078R7vHP79BhICUGEgBdLxYphR7t7GhqnF6NpoI9qvjSp4IzvXQa18aE/88h2AMewwIn14NAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFO4MeE3JbCBELHs9GDfx6tpycVGXiMV7WqanQkIxZ+wIO/QkL
	hq84hVJ5vo/IY0tevKTs/uJALUaHSCImJHS6+esJabGA0PfkbmB/QW+YgNd44Q==
X-Google-Smtp-Source: AGHT+IFw/fFUPyShPG2/Ze40YU4KamjQKDfYMrBvg1bfZRKNcTmejJtMfWfYfhDU5SD5ItOdKzwbXQ==
X-Received: by 2002:a05:620a:4043:b0:79f:515:e211 with SMTP id af79cd13be357-7a4e15bdc69mr410951685a.46.1723551233113;
        Tue, 13 Aug 2024 05:13:53 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d71ca8sm331765485a.50.2024.08.13.05.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:13:52 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 13 Aug 2024 12:13:50 +0000
Subject: [PATCH 3/6] media: i2c: s5c73m3: Move clk_prepare to its own
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-smatch-clock-v1-3-664c84295b1c@chromium.org>
References: <20240813-smatch-clock-v1-0-664c84295b1c@chromium.org>
In-Reply-To: <20240813-smatch-clock-v1-0-664c84295b1c@chromium.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 =?utf-8?q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Smatch is very confused by a clk_prepare_enable() being called in an
error-path. Fix this warning by moving the clk_prepare_enable() to its
own function.

drivers/media/i2c/s5c73m3/s5c73m3-core.c:1425 __s5c73m3_power_off() warn: 'state->clock' from clk_prepare_enable() not released on lines: 1425.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/s5c73m3/s5c73m3-core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-core.c b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
index e89e888f028e..7716dfe2b8c9 100644
--- a/drivers/media/i2c/s5c73m3/s5c73m3-core.c
+++ b/drivers/media/i2c/s5c73m3/s5c73m3-core.c
@@ -1392,6 +1392,16 @@ static int __s5c73m3_power_on(struct s5c73m3 *state)
 	return ret;
 }
 
+/*
+ * This function has been created just to avoid a smatch warning,
+ * please do not merge into __s5c73m3_power_off() until you have
+ * confirmed that it does not introduce a new warning.
+ */
+static void s5c73m3_enable_clk(struct s5c73m3 *state)
+{
+	clk_prepare_enable(state->clock);
+}
+
 static int __s5c73m3_power_off(struct s5c73m3 *state)
 {
 	int i, ret;
@@ -1421,7 +1431,8 @@ static int __s5c73m3_power_off(struct s5c73m3 *state)
 				 state->supplies[i].supply, r);
 	}
 
-	clk_prepare_enable(state->clock);
+	s5c73m3_enable_clk(state);
+
 	return ret;
 }
 

-- 
2.46.0.76.ge559c4bf1a-goog


