Return-Path: <linux-kernel+bounces-538648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F41A49B74
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF033BBACC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832E9271816;
	Fri, 28 Feb 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DdY1jAQ+"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0FB26FD99
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751651; cv=none; b=FHCBTl2NfOJkK/jey59KJ94mkzGYsVFm20r1KqMSEW5eB76ui9molyMgL2EleY3YXinElTj8TnPGaCpcIlYaAVlqiTJRz36fmYLO1Z5iHJ93ZQYhGx0Wamfsjj7PDAnDcBKBt9g/LEH1pIvAFUtOm+bS3xh1KcHjqaPB2FbCD0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751651; c=relaxed/simple;
	bh=UGMJ3GCPyVV/uGz6DNqBy2mH3s73qryTRoU1mvi31cQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rEi88SJDdpNmUZa+fIFGrmN3DBbSl8ny0QkL6BwG1PAy+HGhhjUPq/UIA9okDMMFE9sS7CHhjytQesvaNvW6wZo3OzyafITkT2E0dIpKHK80dMlQmwv+AqswutIvlboGb42X87kRJa9HcQpfWsw/eoSj661f4QzoinVF8Takkqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DdY1jAQ+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e0b70fb1daso3544820a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751647; x=1741356447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvWUKPp3Qf/mJMvtGf6kleKwT9jTpA0O53gNmEgl49A=;
        b=DdY1jAQ+yjUwqYfgqH9cNfvplNpOsyXlmerA6D719DmwyePTExZbTjec/fn9Ijrhd4
         cRcjrUON4m6KBm2dKUpSGjT0WvUdyVAKRhyWmiOytmXk6z2hYnCUTEALexQSWdjavfmn
         L0a1do+XcvL//KwWx7wttKuLlPdyKvXmpXrhpieOm7aJnhv2H5+VwimdReXH4SduXWfq
         IpzNE0YvV0t2vVzJj6xu5b8oyq5Ac0ZyeGcZ/nFqHvP1UnfwH7diE5V6IFJ25v8u9fuJ
         rimxFS4YUZvidbLulGnGDbep+2CZrriPXO1aK+j4UpgL3YN4t79/jHNJ67zBfflQ1nzi
         HJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751647; x=1741356447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvWUKPp3Qf/mJMvtGf6kleKwT9jTpA0O53gNmEgl49A=;
        b=QNOk+LDZPqkDzGRjJHDYQoglrvtc5ItSWqZT+sNg2UWi+MC6y60RokO/DyiTvRpRTb
         6D8jK/gXC3lAHOK4Jk4G7jLJRDBzuhsZlTTGFYdHfQcpwcnWx//tiyDHeZg+0JkhjBmW
         vtFr5n4cV0KgrkwuE6pzHtYI/zMyQPWvaZlab+Jz2LVDrNA+C/GmhIu89qqJTfOMtrqu
         KgJMFpjFw3f9WFexWbNTvhLY/VUDRMYKwl6nGlR08A0xirdgiImIs3mJNwxliTrXMPjC
         8ilkMFFq+9zqv5nrIaQF+703JK3B7dv1IX4qzM2C1VsNXMeLzpMibVE30fmq22wmj0Gb
         FNmg==
X-Gm-Message-State: AOJu0Yz26y1M3JLwH+ezsZMJaFlZBfNLf3k03+LFIyzoVT71uK7mlfx2
	gGQRidnxE1QjOmSsSPOJGJ7nc4KlFOff2H19e4UQ9s31EbdRcj1Xc4miFgEhs8g=
X-Gm-Gg: ASbGncsO8lfpWIh9pdoaG6S7+yoQSre9jIMjX7ix8O3biVc3oPonlVWeRFc/QBrNW4A
	ZzY1g1oCI8KPVDfhvYsBVXP/gnxnWiHHoIWba0HCW4hTZyKbQ/SMcIoKqG0Wt+og5UGTz3dGHtz
	lIudHzMzCLBBFQYkq3ai3M1vzsyLA94wREGOJiByEVzLFIbJOkDjeklDkl3w3yI+t1dzuuroQXF
	U05705mEBxKwS8D3vp5R69E6qeUkOG3/T27qq7hvTAxthJka0io8i1zMzxqDfGwzlk6T8GZVmo0
	Z0qI8ZBjP4Tu7pj+fxANRr2cEcrlb+aB2DQU+zkzfdx5EYpsGC3C5jjcO1koDTnsdoHIDj78NMT
	frIvoqb0aCg==
X-Google-Smtp-Source: AGHT+IGZCKi+h7liDGF2k254zFpRo0bnTt6a/BEgRPyIDc7kptNekspya74S4whe/rs/kwdpZDQeGw==
X-Received: by 2002:a05:6402:27d1:b0:5e0:82a0:50ab with SMTP id 4fb4d7f45d1cf-5e4d6b6240bmr2836488a12.27.1740751647311;
        Fri, 28 Feb 2025 06:07:27 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:26 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:07:22 +0000
Subject: [PATCH 09/18] rtc: meson-vrtc: drop needless struct
 meson_vrtc_data::rtc member
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-rtc-cleanups-v1-9-b44cec078481@linaro.org>
References: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
In-Reply-To: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>, 
 Dianlong Li <long17.cool@163.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-amlogic@lists.infradead.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The memory pointed to by the ::rtc member is managed via devres, and
no code in this driver uses it past _probe().

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-meson-vrtc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-meson-vrtc.c b/drivers/rtc/rtc-meson-vrtc.c
index 5849729f7d01d7ec7868ff3bbdc5ed599aaa8238..7d38258cbe376e5a1b2af6250cb6d04c313175fb 100644
--- a/drivers/rtc/rtc-meson-vrtc.c
+++ b/drivers/rtc/rtc-meson-vrtc.c
@@ -13,7 +13,6 @@
 
 struct meson_vrtc_data {
 	void __iomem *io_alarm;
-	struct rtc_device *rtc;
 	unsigned long alarm_time;
 	bool enabled;
 };
@@ -65,6 +64,7 @@ static const struct rtc_class_ops meson_vrtc_ops = {
 static int meson_vrtc_probe(struct platform_device *pdev)
 {
 	struct meson_vrtc_data *vrtc;
+	struct rtc_device *rtc;
 
 	vrtc = devm_kzalloc(&pdev->dev, sizeof(*vrtc), GFP_KERNEL);
 	if (!vrtc)
@@ -78,12 +78,12 @@ static int meson_vrtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, vrtc);
 
-	vrtc->rtc = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(vrtc->rtc))
-		return PTR_ERR(vrtc->rtc);
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
-	vrtc->rtc->ops = &meson_vrtc_ops;
-	return devm_rtc_register_device(vrtc->rtc);
+	rtc->ops = &meson_vrtc_ops;
+	return devm_rtc_register_device(rtc);
 }
 
 static int __maybe_unused meson_vrtc_suspend(struct device *dev)

-- 
2.48.1.711.g2feabab25a-goog


