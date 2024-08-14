Return-Path: <linux-kernel+bounces-286576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A38951CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F18C1F2223E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9D11B3743;
	Wed, 14 Aug 2024 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DB1WRNnI"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB91B32C7
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644632; cv=none; b=LAzoB+gqFg9pNsXkhlJIMTQrIDbAmCr03C1QEy6kOVR9CgfFVB7SsmnQNCl4RV2GvxHI4/YupHYMqrPpQ1iHjDlHN/ZgFgXoWXjz5HnTaSzVUL32/bgLlP3qr4AtGoV2TbbzghLEqrqYJpDVbFQJvYt80Pgm1ZQ8BCKT8q0jaeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644632; c=relaxed/simple;
	bh=4gn8bYoICNRPD5yYaXqN7k4ps+ZaI5ktDDh23/kBYnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WAbZUB+Pfk3yGqUYe2s2oY009bRUd3ZNU3+0Ojkei/Yz5/6C7roQiVzz37yGAAzEuontdjWEm+uvvviz3egi1FgNYTFqCCCVZp6WFB971XpRW3pekHQC4bcgmy5SjS2e4KW4/MoOR+18bzVYd6iYBax5ngft344FWYpuHOWrlnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DB1WRNnI; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bb96ef0e96so36666166d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723644629; x=1724249429; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54a5u/AIPf3FUAW8TNrqnrThXWk83FvG6faGGYYzLrQ=;
        b=DB1WRNnIlvhxurNUWgR+OE5VSZXk0ZEjvalmFRPFIo9xZp4lxnKLG8aCRC6+cPFXJF
         4f5vc2x3XkTOMr4i/MLhPzlqBYiXSU5/4WiAAohhXiYJ30AUlfKBd5+ukIwTGHVWKo6Z
         5IlDSJukIbgxCcfZFzAp8PI8hzA2LAdKZ6Lx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723644629; x=1724249429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54a5u/AIPf3FUAW8TNrqnrThXWk83FvG6faGGYYzLrQ=;
        b=icQXMxw/AeH54eM4rS6RpW9T501A5V6WcEve1l0s7lpZZghsuTZWrdvVxD6xlw8fXm
         SEeCODsObJiVJArSXyQE/iLKEAe3RwdFF+3OFmsLhMX8176BDC7sdn1Ls5GIE3iEgP++
         T63PKHzP5SknWTv1+OVKMTjCJgVyOt3jJHQYTbPvhyTrxl25pM+w+g3qVpY5Lcy9+kkv
         7JYbMZdLetu2xJ+Da87dKGvEU3ef/fgqTVLBaDq/Thg2gpzwL+JEBNFjlsmFlTGmnQRB
         yUNVaFK2l5VV02zaWuH+kjEjTEL8jCqgjsNeFPxUbkjo++ELvvJFewcrTxZ/+gEJvQa6
         jiEg==
X-Forwarded-Encrypted: i=1; AJvYcCXpdjNjtAgzquT/yq6hISR2haCtSFu49rIXPYn8iN2vPhCuFtNeVv1WxuymIorXPnn33jWF8eKzqPb1BqnV+t/WbwhvThEzapl+iyv4
X-Gm-Message-State: AOJu0Yw1ybB6s6g1Pc/fLxQHUZC1SvyGQDCM/Q2lim0W4hNFmuwRJY/F
	CZO0TDWe4SW188llMhB9EStRthfXVRRVBV9oNP1xdZviJNf2yereGBHyMSy+i9BGALi/QOxMkDi
	Nefv3
X-Google-Smtp-Source: AGHT+IGoc+E8kKrWo1+MczAL0858Q7D1ror/nkleb+dMvRF8IpoDO/rkwov2Dl1lO/HtMEEoy1wPXA==
X-Received: by 2002:a05:6214:225:b0:6bf:6375:397f with SMTP id 6a1803df08f44-6bf63753b38mr12558086d6.25.1723644628736;
        Wed, 14 Aug 2024 07:10:28 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82c61637sm43861036d6.7.2024.08.14.07.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:10:28 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 14 Aug 2024 14:10:23 +0000
Subject: [PATCH v2 2/2] media: drivers/media/dvb-core: Refactor
 dvb_frontend_open locking
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-coccinelle-followup-v2-2-88b4e4a9af56@chromium.org>
References: <20240814-coccinelle-followup-v2-0-88b4e4a9af56@chromium.org>
In-Reply-To: <20240814-coccinelle-followup-v2-0-88b4e4a9af56@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Split out the wait function, and introduce some new toys: guard and
lockdep.

This fixes the following cocci warnings:
drivers/media/dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2776
drivers/media/dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2786
drivers/media/dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2809

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/dvb-core/dvb_frontend.c | 58 ++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index e81b9996530e..7f5d0c297464 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -30,6 +30,7 @@
 #include <linux/kthread.h>
 #include <linux/ktime.h>
 #include <linux/compat.h>
+#include <linux/lockdep.h>
 #include <asm/processor.h>
 
 #include <media/dvb_frontend.h>
@@ -2826,6 +2827,34 @@ static int __dvb_frontend_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+static int wait_dvb_frontend(struct dvb_adapter *adapter,
+			     struct dvb_device *mfedev)
+{
+	struct dvb_frontend *mfe = mfedev->priv;
+	struct dvb_frontend_private *mfepriv = mfe->frontend_priv;
+	int mferetry = (dvb_mfe_wait_time << 1);
+	int ret = 0;
+
+	lockdep_assert_held(&adapter->mfe_lock);
+
+	if (mfedev->users == -1 && !mfepriv->thread)
+		return 0;
+
+	mutex_unlock(&adapter->mfe_lock);
+
+	while (mferetry-- && (mfedev->users != -1 || mfepriv->thread)) {
+		if (msleep_interruptible(500))
+			if (signal_pending(current)) {
+				ret = -EINTR;
+				break;
+			}
+	}
+
+	mutex_lock(&adapter->mfe_lock);
+
+	return ret;
+}
+
 static int dvb_frontend_open(struct inode *inode, struct file *file)
 {
 	struct dvb_device *dvbdev = file->private_data;
@@ -2840,19 +2869,16 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 	if (!adapter->mfe_shared)
 		return __dvb_frontend_open(inode, file);
 
+	guard(mutex)(&adapter->mfe_lock);
+
 	if (adapter->mfe_shared == 2) {
-		mutex_lock(&adapter->mfe_lock);
 		if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
 			if (adapter->mfe_dvbdev &&
-			    !adapter->mfe_dvbdev->writers) {
-				mutex_unlock(&adapter->mfe_lock);
+			    !adapter->mfe_dvbdev->writers)
 				return -EBUSY;
-			}
 			adapter->mfe_dvbdev = dvbdev;
 		}
 	} else {
-		mutex_lock(&adapter->mfe_lock);
-
 		if (!adapter->mfe_dvbdev) {
 			adapter->mfe_dvbdev = dvbdev;
 		} else if (adapter->mfe_dvbdev != dvbdev) {
@@ -2862,34 +2888,24 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 				*mfe = mfedev->priv;
 			struct dvb_frontend_private
 				*mfepriv = mfe->frontend_priv;
-			int mferetry = (dvb_mfe_wait_time << 1);
-
-			mutex_unlock(&adapter->mfe_lock);
-			while (mferetry-- && (mfedev->users != -1 ||
-					      mfepriv->thread)) {
-				if (msleep_interruptible(500)) {
-					if (signal_pending(current))
-						return -EINTR;
-				}
-			}
 
-			mutex_lock(&adapter->mfe_lock);
+			ret = wait_dvb_frontend(adapter, mfedev);
+			if (ret)
+				return ret;
+
 			if (adapter->mfe_dvbdev != dvbdev) {
 				mfedev = adapter->mfe_dvbdev;
 				mfe = mfedev->priv;
 				mfepriv = mfe->frontend_priv;
 				if (mfedev->users != -1 ||
-				    mfepriv->thread) {
-					mutex_unlock(&adapter->mfe_lock);
+				    mfepriv->thread)
 					return -EBUSY;
-				}
 				adapter->mfe_dvbdev = dvbdev;
 			}
 		}
 	}
 
 	ret = __dvb_frontend_open(inode, file);
-	mutex_unlock(&adapter->mfe_lock);
 
 	return ret;
 }

-- 
2.46.0.76.ge559c4bf1a-goog


