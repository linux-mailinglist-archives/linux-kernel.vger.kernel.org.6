Return-Path: <linux-kernel+bounces-170473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 354A88BD7A3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 00:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C9C6B2426B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 22:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D28B15B132;
	Mon,  6 May 2024 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4EaaeJR"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B109E12D1EC
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715035111; cv=none; b=owspNb7T11uCODL9nYmWcZolJf2/16oN3HAV0dHux8npX/Cd/P13AElL8BOUkTKJFoKSTHysBGeyS7+xFIQeIXMCRU/krwJ0/1nM5rrpCXXK4fzkEWN0tq5BZQHJoSDnygvuuZfynBkg9IgYKmZQeFk74e14uJSsQ9sM49kPyk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715035111; c=relaxed/simple;
	bh=x6iZsTaXUAWHv5Yc0/wKoYsMpmLoZ0ewfrbGSYTHXTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AjAHzzDhLcsMXm4vfxTSfZuCKOkomQozEEGNnoKZV/8ZwK0cDY9h+VWxi5FvbsfSN2UXKumruEtZNxCsJhgjkeAjqzd/9QVAGR9B/MRw8gCSXNaAyom6Yuvl7pqBUn+WTx1aw3GoAzDKJ8q6QUxF5aUkZ06ctUqXUnFB/aCrpDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G4EaaeJR; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a59b58fe083so341800266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 15:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715035108; x=1715639908; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ6YOnYyqSrD4O0njh6d9wC2eB8fg7WZdjq/cUZ4FVE=;
        b=G4EaaeJRhY6lrkDkAPOJ5AHOYwNQu7reSwUoIZeoc/Sc+bBX4JGrXUQktmbF7uoLQq
         4OonirepKkWdXMT6ffg2MIBOvm4LK7PfMenhir1dwlYbp3EsnhXbeMu2cdd4xGNiZA3F
         9B/kNOgVJdIawdt37jo+MTsE7hkykd12YYDhwTPs2EZK+nVd9mzPJFYciLl+IG1NVVWg
         skkzc14agJqI6lDMp/M4o6NLC/xGSCjZdSxke8SwZkRUHut5ps8kikW1MvOnwLvljea1
         TyVVYOFO4neQd2Xz072LNzYz+vL0PLNdsZaHls0SvqvAKkF3HTS9Ebp5qzrl/wezh83g
         dk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715035108; x=1715639908;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQ6YOnYyqSrD4O0njh6d9wC2eB8fg7WZdjq/cUZ4FVE=;
        b=gur9aeYmdtn8O6mve9HHNpRj4JJRpJxKEJG5T+yMk+zLw5qE+UJGTpoORMlkS0daZQ
         3bH9e+Tv1PZIk+JNzQU40oxtjtWLvyCK43AWawuFlP+iPkaNiI/E6kjoYg3mpGexux16
         d3/BoxwiOPWAzi1AN3W7nmQq+jvFeX8DKFfU44XWvBxt1H/uLadFjYQZEODatwPbjEhc
         nsr4nzzkn7n9JHuCTgiOjzlLY4z4Pinl4gDN+0pXHq+WcKNxyd9d/eZ7XCEXWW9dT08y
         Fk2SIpLny/wtgDAoMJtiBtWRO9OC6Oj3WQWg7KuSUcMJia+0WRV4uGr0bEer/rNgjcCQ
         dq3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7V3cNEC+Nnwh9gphkIRgFz8YY+66W4s/jIGb6Ev0eQKZK6574jNvACJOsnfex7SA2u8r6Dd7S/lvph8qHGCLPxg2+Nhnq1KmHhB/3
X-Gm-Message-State: AOJu0YzJK0WyBio3Yo8zTm0PO/CshezLCAN6x68WQ6KhuP+aCVo/Mw4g
	K5iyk6nKcDulxnGmn/rQyCPRxJqMpfX+Kdg9/PO7xAOUwCmJDGHAS8zgkI/QRz4=
X-Google-Smtp-Source: AGHT+IHYpdWaailbj4mKDZiQZUauPEmoTqEasrMPXQE8mPtipsq5LHOkDshEBzhu4iXqZcYxUq53Ew==
X-Received: by 2002:a17:907:720a:b0:a59:c963:830 with SMTP id dr10-20020a170907720a00b00a59c9630830mr3884880ejc.58.1715035108033;
        Mon, 06 May 2024 15:38:28 -0700 (PDT)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id bo15-20020a170906d04f00b00a59b87dd0bbsm2810081ejb.161.2024.05.06.15.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 15:38:27 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Mon, 06 May 2024 23:38:26 +0100
Subject: [PATCH v2] media: i2c: Fix imx412 exposure control
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-b4-linux-next-camss-x13s-mmsol-integration-in-test-imx577-fix-v2-1-2e665f072f8f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOFbOWYC/62OQQ6CMBBFr0K6dkxbCqgr72FYFBxgEmhNp5Iaw
 t2tnMHdf3/x398EYyBkcSs2EXAlJu8y6FMh+sm6EYGemYWW2shK1tAZmMm9EzhMEXq7MENSJcO
 ysJ+BXMQx2JhncoaIHIGWVDUNDJRgUANiLRtZGyWy4xUw14f/0WaeiKMPn+POqn7tv8yrAgWmK
 +3V6Lp74uWex2zwZx9G0e77/gUE6Bg5CwEAAA==
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Paul J. Murphy" <paul.j.murphy@intel.com>, 
 Martina Krasteva <quic_mkrastev@quicinc.com>, 
 Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13-dev-26615

Currently we have the following algorithm to calculate what value should be
written to the exposure control of imx412.

lpfr = imx412->vblank + imx412->cur_mode->height;
shutter = lpfr - exposure;

The 'shutter' value is given to IMX412_REG_EXPOSURE_CIT however, the above
algorithm will result in the value given to IMX412_REG_EXPOSURE_CIT
decreasing as the requested exposure value from user-space goes up.

e.g.
[ 2255.713989] imx412 20-001a: Received exp 1608, analog gain 0
[ 2255.714002] imx412 20-001a: Set exp 1608, analog gain 0, shutter 1938, lpfr 3546
[ 2256.302770] imx412 20-001a: Received exp 2586, analog gain 100
[ 2256.302800] imx412 20-001a: Set exp 2586, analog gain 100, shutter 960, lpfr 3546
[ 2256.753755] imx412 20-001a: Received exp 3524, analog gain 110
[ 2256.753772] imx412 20-001a: Set exp 3524, analog gain 110, shutter 22, lpfr 3546

This behaviour results in the image having less exposure as the requested
exposure value from user-space increases.

Other sensor drivers such as ov5675, imx218, hid556 and others take the
requested exposure value and directly.

Take the example of the above cited sensor drivers and directly apply the
requested exposure value from user-space. The 'lpfr' variable still
functions as before but the 'shutter' variable can be dispensed with as a
result.

Once done a similar run of the test application requesting higher exposure
looks like this, with 'exp' written directly to the sensor.

[  133.207884] imx412 20-001a: Received exp 1608, analog gain 0
[  133.207899] imx412 20-001a: Set exp 1608, analog gain 0, lpfr 3546
[  133.905309] imx412 20-001a: Received exp 2844, analog gain 100
[  133.905344] imx412 20-001a: Set exp 2844, analog gain 100, lpfr 3546
[  134.241705] imx412 20-001a: Received exp 3524, analog gain 110
[  134.241775] imx412 20-001a: Set exp 3524, analog gain 110, lpfr 3546

The result is then setting the sensor exposure to lower values results in
darker, less exposure images and vice versa with higher exposure values.

Fixes: 9214e86c0cc1 ("media: i2c: Add imx412 camera sensor driver")
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # qrb5165-rb5/imx577
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
Using libcamera/SoftISP on a Qualcomm RB5 with the imx577 sensor I found
that unlike on other platforms such as the Lenovo x13s/ov5675 the image was
constantly getting darker and darker.

At first I assumed a bug in SoftISP but, looking into the code it appeared
SoftISP was requesting higher and higher exposure values which resulted in
the image getting progressively darker.

To my mind the software contract between user-space and kernel should be
increasing exposure requests always meant higher exposure but, to be
certain I asked around on IRC.

Those polled agreed in principle that the software contract was consistent
across sensors.

Looking at the range of imx sensors, it appears this particular error has
been replicated a number of times but, I haven't so far really drilled into
each sensor.

As a first pass I'm submitting the fix for the sensor I have but, I expect
if this fix is acceptable upstream it should be pushed to most of the imx
sensors with what seems to be copy/paste code for the exposure.
---
Changes in v2:
- Fix typo in patch 42 -> 412
- Link to v1: https://lore.kernel.org/r/20240506-b4-linux-next-camss-x13s-mmsol-integration-in-test-imx577-fix-v1-1-4b3a9426bde8@linaro.org
---
 drivers/media/i2c/imx412.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/imx412.c b/drivers/media/i2c/imx412.c
index 0efce329525e4..7d1f7af0a9dff 100644
--- a/drivers/media/i2c/imx412.c
+++ b/drivers/media/i2c/imx412.c
@@ -542,14 +542,13 @@ static int imx412_update_controls(struct imx412 *imx412,
  */
 static int imx412_update_exp_gain(struct imx412 *imx412, u32 exposure, u32 gain)
 {
-	u32 lpfr, shutter;
+	u32 lpfr;
 	int ret;
 
 	lpfr = imx412->vblank + imx412->cur_mode->height;
-	shutter = lpfr - exposure;
 
-	dev_dbg(imx412->dev, "Set exp %u, analog gain %u, shutter %u, lpfr %u",
-		exposure, gain, shutter, lpfr);
+	dev_dbg(imx412->dev, "Set exp %u, analog gain %u, lpfr %u",
+		exposure, gain, lpfr);
 
 	ret = imx412_write_reg(imx412, IMX412_REG_HOLD, 1, 1);
 	if (ret)
@@ -559,7 +558,7 @@ static int imx412_update_exp_gain(struct imx412 *imx412, u32 exposure, u32 gain)
 	if (ret)
 		goto error_release_group_hold;
 
-	ret = imx412_write_reg(imx412, IMX412_REG_EXPOSURE_CIT, 2, shutter);
+	ret = imx412_write_reg(imx412, IMX412_REG_EXPOSURE_CIT, 2, exposure);
 	if (ret)
 		goto error_release_group_hold;
 

---
base-commit: ff3959189f1b97e99497183d76ab9b007bec4c88
change-id: 20240506-b4-linux-next-camss-x13s-mmsol-integration-in-test-imx577-fix-f1fee6070641

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>


