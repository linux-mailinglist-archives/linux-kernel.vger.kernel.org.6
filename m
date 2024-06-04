Return-Path: <linux-kernel+bounces-201026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E410C8FB8FC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 380F8B301D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74862148FF6;
	Tue,  4 Jun 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KNDNcKUT"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4452146A98
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516911; cv=none; b=pt9ISHsznKiqi/stI8sMbzLMT0Z9JKZF/VVrEvF2BCB/yzGehMkZ3oBkt5ZDSP9MFsr0HkZEFW0xLMbd93+v8HEH03XnDlqy8p0K3LMC6WLzURHRpc/zAO+0jQAA+SxuzDJZ7Cf300XPCjGwOuLA7saQel9kM4G1/mpH1xGbHmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516911; c=relaxed/simple;
	bh=2XiXCEZWGzGuogpB7UrNVjSqiElFtO0aCEYdeEc0X1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGNJxV3ju7SDt5vZdrpoYhKFkVyv0vO9fV4i1bRDmgSWKAF4HNZtFI2ZyXO+8MZiKqgMTRQkCkJ3rHw1wT+E0/c8Oh8XzriiynSn749AcjT6aVcvDzCHz8H426AF0km7dnC8ZJsWYE7IBQWNgztbUAxF7bwHAz/OMgHJn555PKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KNDNcKUT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f62fae8c3cso42443905ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717516909; x=1718121709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+b1f17eVJb80Zj1W53g2Cg6ZxrWFmpqnvW69q4l7Uo=;
        b=KNDNcKUT0lvSNVCsy6BrWeidvN+LQJ3AGkk3v27IMzZ9UCqL4Fu8sI/OvXgGPHdK+1
         ba5dyIL/nKVn6ARWYX34RvAHpKcWSEDIomcncWepEvZPOycejY21cXB9cyoiRtfxCgEP
         c3dlHNObLyCz5XHEL8tW5VLqhZdmV6wfKAKR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516909; x=1718121709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+b1f17eVJb80Zj1W53g2Cg6ZxrWFmpqnvW69q4l7Uo=;
        b=VELqyyr6hsfbwcUs9vGK2HbL2OPLtDInfkTY7lcStukiptQEghDL410kUpRQkbsRkT
         c83yP6qrlbqzHqw5xkjpMGQSHPZJSnJxOVb0N9u/ZWJkSZgKv7esFBy5vfbMOaD+kWWj
         Y5Stu8uPfHo8vxwxHL+JLnrHB2Xlu8Uy0bxqi98Kcm/I93a+uTLz8wCLgFr7zgOktzZX
         sNRfLClIswyyXhgs5v539L366K7u384Uj5Z0hLe4QZlHhHWYiJbMbEGZ1OeclT+9vtam
         Be00vXaKYhp+Dj2M+m8P/cQ65LYfIpBI6QdkiZ24Mi+7+UbR/4whsH3tzshujYB6kqD7
         IXig==
X-Forwarded-Encrypted: i=1; AJvYcCWVLhJH7KHepZcktIw7a6Wkt78ACrby/At3Pu6XeT/myyZmvvkGTud5ZGFBfPMXPSb+0yPHFGzeRONJBhpswkIpCTFsJ35Oi+OK+68F
X-Gm-Message-State: AOJu0Yw8VpsGVgmEklYkzQu174Bzx5tW5yIb2dAg5rq4DPksiT4rHw6Z
	7T1kC3QbL8cw+BvvKe5DNCp11dL3z+Y9RtIMHKnroNLM3AJ6ir6rvyAiLbB7iA==
X-Google-Smtp-Source: AGHT+IGiBs6CoEcjZoTZjvUybhOhGJoQkUpTWYueMh4xEVk/MVLaHWzkiQ429PcJ6uh2d03TU8ZR5g==
X-Received: by 2002:a17:902:e152:b0:1f4:9138:8178 with SMTP id d9443c01a7336-1f63709e30amr92494075ad.49.1717516908948;
        Tue, 04 Jun 2024 09:01:48 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632358519sm86118385ad.82.2024.06.04.09.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:01:47 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Tony Lindgren <tony@atomide.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 3/7] serial: qcom-geni: Fix arg types for qcom_geni_serial_poll_bit()
Date: Tue,  4 Jun 2024 09:00:29 -0700
Message-ID: <20240604090028.v3.3.I24a0de52dd7336908df180fa6b698e001f3aff82@changeid>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240604160123.2029413-1-dianders@chromium.org>
References: <20240604160123.2029413-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "offset" passed in should be unsigned since it's always a positive
offset from our memory mapped IO.

The "field" should be u32 since we're anding it with a 32-bit value
read from the device.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- New

 drivers/tty/serial/qcom_geni_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index a48a15c2555e..e5effc2f5878 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -265,7 +265,7 @@ static bool qcom_geni_serial_secondary_active(struct uart_port *uport)
 }
 
 static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
-				int offset, int field, bool set)
+				      unsigned int offset, u32 field, bool set)
 {
 	u32 reg;
 	unsigned long timeout_us;
-- 
2.45.1.288.g0e0cd299f1-goog


