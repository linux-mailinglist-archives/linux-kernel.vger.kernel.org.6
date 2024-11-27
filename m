Return-Path: <linux-kernel+bounces-423388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597239DA6AB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288A51604A2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012F31F4280;
	Wed, 27 Nov 2024 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ZYOOX5Y+"
Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com [209.85.128.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB871EF0BA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732706125; cv=none; b=szLGzF88jC35qZFBuBWp71h8RU3KdRshOAe5kbBWhqOtQ23RXRBH0oij3ypBxsFEdsoSY/KP19idHga+Z6P1iKmo9quNYK4u8xEWQi4CeaxdFmM3rw0Jwbsw4+R6fY98hJa1trnA3yKoT9Iv57s6m4qIe+/wJUPug/1sKbzm4ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732706125; c=relaxed/simple;
	bh=2NOMVN6qGPtVqsDC17KQHFq1EI6laocjfEVCvcsOBBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sp57WpJl6bkYgTetQOJU9Yuj47B4C+Rmk5GxH9q9ao6case7sq8gmUZeElAjesKeZe+aOJCbQzBtFAvleDOBTi/iUS0B4cjxRLTNjIoBRzzc//CkD+10o9m//gvVYCziK3sLZYqc4ogymAh4mqGB82+QJBmPZXKcLY4GEDv4Z2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=ZYOOX5Y+; arc=none smtp.client-ip=209.85.128.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f99.google.com with SMTP id 5b1f17b1804b1-434a752140eso13510885e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 03:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1732706122; x=1733310922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OeHJ5VmorUPFsKfp3L5ZEPCj51aQDOtY3qfB7PKLqU=;
        b=ZYOOX5Y+se1tjjUYxEZHrGnY/yP9C2leTZbrej6Qztnuf88JZLSq6jFxCEpqfK1/KI
         HAsiLtv6QOtcmebU7wmnRx5SaxTVnyrasAw1siS0RAZFgkQrRSLsU624aD8HNa0lnxtO
         rI7A/8zC+6IonQy73W68FpT02Ol5uRLgt7clK6ZBeIRK/yhu2YS5JWSJ2bctiBDfjN89
         pltH5kCFbfc3GarmzUbPr5JFdJx7PoYvE4jJ3SqZX8TkRSBtBYCQaXtwoyZfwZwhMqru
         GXWTkcJhMQZ7Mp6MeTm7YtiU7/ftN4OKGzLar9kfpbxvRXZ9LBRwXjOmeNTbM5pLrAYn
         BFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732706122; x=1733310922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OeHJ5VmorUPFsKfp3L5ZEPCj51aQDOtY3qfB7PKLqU=;
        b=V7ecI0mwGZCEEvYtVM+2QxOoop3bMlcVxscnBEiPBhgFuVc6zf3TvPx5h5KFfcqhkw
         S7rfTCIG/ksX8UA4JPJSGu0bxlWjp6B8QDrT6ZTfu1lOxRxrp5DaJnxFC8qxNcdwby/r
         pVYqxIYGjVe5iPZUOCLx7H0h1O/IEfVIj+HH4KUOgeV1rYskcD5aBFActTsY0Q4s9J8i
         P5AbeG/7Qw0Shtxyl3FbjRSjNcfLCSaJDgD3j2VayPvtxqZ4RaKICwX1s0/kEQfM+yYF
         GTebcbJvmfua8dUgDfcxLSsORxeMNsbht3JU5ZB2sxV0jjOdtYTc6QCCEvYN+IQT3mNv
         uBew==
X-Forwarded-Encrypted: i=1; AJvYcCXzfixUf43d6rpZNIccoXllsnr2ibCCnh9HWqXSBWo5HTADzaeZG19OFsJs9veWFB8pwxC2EeJ6C3SPyBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdRtdH7oLjp4aweTiOyYIVxwtZwK4IQUxbjXwKnkWRO0qL3KJo
	hSGL4iQ50MiIFduPfZqgdrqWTVYryFxQ98n/4DM1tCbEjNi8mIsnmh1c8N7mr00fYxo6gxi2GEW
	hNH8qarJxk67cfEG74BStTJ/Aby6QxaOv
X-Gm-Gg: ASbGnctCg9kAUttyNThJGp5FUONEnfRjnrGeaeIHev0x/W1L78fFLKU6c8k8ZLDHla0
	Eg4TJrfzO8ZuDUxgtDjHNB+kaAUcDpFah/6hrOW/v0zrOrYZy5eMe6dlU8RKjHSj72SgKV/WP/J
	VHBhZl+s/P6a3pq36IPUFDnbR5S7q82kYOBL+Osem8DNWanW+/uTnRr4ac+m0fYv0t6T54Gs6r0
	NLbTH/LmooECe7iY593WAtr7MXW0oi7Hpyt51ck0/PfDOY/o1xbI7bj/m7vr7N+tA==
X-Google-Smtp-Source: AGHT+IG8NIxF+WfvLMMyexhQ4F78Jja+ecK4xzKxkdy9lOD0O56mEG25LOMSGylsAkrpJskIxuI6TCXFkAK1
X-Received: by 2002:a5d:47a4:0:b0:382:5066:326f with SMTP id ffacd0b85a97d-385c6eb72bamr1917091f8f.17.1732706121697;
        Wed, 27 Nov 2024 03:15:21 -0800 (PST)
Received: from raspberrypi.com ([93.93.133.154])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-3825fae4853sm441870f8f.4.2024.11.27.03.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 03:15:21 -0800 (PST)
X-Relaying-Domain: raspberrypi.com
From: Naushir Patuck <naush@raspberrypi.com>
To: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: linux-media@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jacopo.mondi@ideasonboard.com,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Naushir Patuck <naush@raspberrypi.com>
Subject: [PATCH v2 4/4] drivers: media: bcm2835-unicam: Fix for possible dummy buffer overrun
Date: Wed, 27 Nov 2024 11:15:15 +0000
Message-Id: <20241127111515.565992-5-naush@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127111515.565992-1-naush@raspberrypi.com>
References: <20241127111515.565992-1-naush@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Unicam hardware has been observed to cause a buffer overrun when
using the dummy buffer as a circular buffer. The conditions that cause
the overrun are not fully known, but it seems to occur when the memory
bus is heavily loaded.

To avoid the overrun, program the hardware with a buffer size of 0 when
using the dummy buffer. This will cause overrun into the allocated dummy
buffer, but avoid out of bounds writes.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
---
 drivers/media/platform/broadcom/bcm2835-unicam.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/media/platform/broadcom/bcm2835-unicam.c
index 550eb1b064f1..f10064107d54 100644
--- a/drivers/media/platform/broadcom/bcm2835-unicam.c
+++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
@@ -640,7 +640,14 @@ static inline void unicam_reg_write_field(struct unicam_device *unicam, u32 offs
 static void unicam_wr_dma_addr(struct unicam_node *node,
 			       struct unicam_buffer *buf)
 {
-	dma_addr_t endaddr = buf->dma_addr + buf->size;
+	/*
+	 * Due to a HW bug causing buffer overruns in circular buffer mode under
+	 * certain (not yet fully known) conditions, the dummy buffer allocation
+	 * is set to a a single page size, but the hardware gets programmed with
+	 * a buffer size of 0.
+	 */
+	dma_addr_t endaddr = buf->dma_addr +
+			     (buf != &node->dummy_buf ? buf->size : 0);
 
 	if (node->id == UNICAM_IMAGE_NODE) {
 		unicam_reg_write(node->dev, UNICAM_IBSA0, buf->dma_addr);
-- 
2.34.1


