Return-Path: <linux-kernel+bounces-378523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 272AC9AD1D6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565271C24BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B34205137;
	Wed, 23 Oct 2024 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="NZh3rnyl"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA6220409C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702253; cv=none; b=O7ivOO0joo6NZN63OXmnBPbICweoyvupEhiD68AGoyGFY/mnFjF3kZ6DgZhAVIgL2v9kR/DEPoJoCkXetqCa+sIrCl4EheXhbzgZiQA/2VAEoxEkw5Elf4WgATfZgaA3AQURhzTDFlXItXZNm7WwiUIcwC2KeeGXcPryZipFxtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702253; c=relaxed/simple;
	bh=0je9Y0xbsCwGhDIv3Ukq4aSt2NhWmJSUC9xO7wwoU+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M1xd+p5u9IWn/KeeudTKNLPWaC417ubie1O8LMV4PwJ5AEIVq+okDQUzCums8dcJTdXRNyuNEkXa+ojasUuJf2PVivl0YsRcJdPhA0w0zTRfzIGeOcwyVaXfopeY3ks5veAfu6RtmHT/vXgM1T40EqD0tdmFa357YEjJcQupy60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=NZh3rnyl; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d4fd00574so52041f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729702250; x=1730307050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5HllG+0A2vmKjdDSzHIHJZeNfO9C2BUneILRyscFdw0=;
        b=NZh3rnyln15b4NoTAMJm2xtzQ0XgdJFooE4JGnISCXetjvJg4dIE7//ICE/OHd61Yg
         0DXYN2tDUHx2frZsLDE4LMLHMP/5kCgr9iXKQAsGsga3euHBV+L1eTUtbXCwJiD5Uyy6
         DXX7mpej0RkSVxwjI6pkaxW/6ZD28mPR8jPrIJQ0x/fzmMyzIJLEpz9uhrsc1bHE/1ey
         kDKJ1olOZ5vdkxgW/PeziY28uUx19tXb6LwBW6t4QJLXLKdMUpfeLc7Ihr8+/ua+kFsG
         wokXebkIe8qM81p8/8BJXIQJFtDLk/kKEVprOzH38/uNhXApOlagqpQlxc53x5X6AIAN
         eE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702250; x=1730307050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HllG+0A2vmKjdDSzHIHJZeNfO9C2BUneILRyscFdw0=;
        b=lWmZHjfkb9YD2ocBV++R8UX7785YDF6mwOGUAr9auWItpdgBZrOTFOID0/8VkoRuPg
         KyDxAIUc6hjoYYK1HHqV4WZC2KBbfLj2yvC3a80m3tDTrQo3OqJylK7EycZBYM39lzlf
         pTgARJkU7SAzwnixb/Lh43TC9iA13utl8id6IKAiMl/McU/FLG9zZLKynhxeRdwLutot
         v568Sk8JtCFV/xYPZhFU3EdG3Ww8gdiEJfOhtVYYrMwhtu7lxgtMjK4G2w5tkts3zoB9
         wUKejwoKQGhyXL13OWfbd5kuYx0c0PJ8ibNaUaXi0wYbr5kO0rUgDnNGXnAAty0nY36v
         3Hbg==
X-Forwarded-Encrypted: i=1; AJvYcCV6sy3WqotNdP19baHH3g+GIVHD7ecA1OJM5kfdkg6ydl395vU7RUE0TYICDX6m4zOw9BIcJDcCRUtZI2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmSMPdasmTNdYyFJWgu5wK7UKkGlG7aO/RIihnGeuyJJkVeLw8
	MmMQkPyvwm/gKLLfq+9vxD+3bGVcQXQGiLS7+zrPzxM2D/ychpKVhZmuJX3zewU=
X-Google-Smtp-Source: AGHT+IHiThpqNk1aykeI/HCv+JYxamwU4EBdrmtK4EAyvKSVy0PZGtmgt/LXmRWsriS/yuXmN6RtIA==
X-Received: by 2002:adf:e88d:0:b0:37d:47eb:b586 with SMTP id ffacd0b85a97d-37ef12592e5mr5273994f8f.4.1729702249886;
        Wed, 23 Oct 2024 09:50:49 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43186c50445sm21642035e9.39.2024.10.23.09.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:50:49 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 23 Oct 2024 17:50:27 +0100
Subject: [PATCH 30/37] clk: bcm: rpi: Add ISP to exported clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-drm-vc4-2712-support-v1-30-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
In-Reply-To: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
To: Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dom Cobley <popcornmix@gmail.com>
X-Mailer: b4 0.14.1

From: Dom Cobley <popcornmix@gmail.com>

The ISP clock can be controlled by the driver, so register it
with the clock subsystem.

Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/clk/bcm/clk-raspberrypi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index a18a8768feb4..6d5ee1cddded 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -118,6 +118,9 @@ raspberrypi_clk_variants[RPI_FIRMWARE_NUM_CLK_ID] = {
 	[RPI_FIRMWARE_HEVC_CLK_ID] = {
 		.export = true,
 	},
+	[RPI_FIRMWARE_ISP_CLK_ID] = {
+		.export = true,
+	},
 	[RPI_FIRMWARE_PIXEL_BVB_CLK_ID] = {
 		.export = true,
 	},

-- 
2.34.1


