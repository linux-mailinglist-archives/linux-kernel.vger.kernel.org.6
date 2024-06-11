Return-Path: <linux-kernel+bounces-209701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B53D903992
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274891F2587A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE9B17C203;
	Tue, 11 Jun 2024 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RBPI+5fi"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418C1179967
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103789; cv=none; b=gohORmLrY96mkmcYQ8LszwUI/sPSco4YFPou47XL2JvyS7H5AI/TTbTlClqaKvqiBifumq+HmtsFoGEjpjcA+leEnUnRNGj3u8ccj+xxkkJmIQAVGTPr5/44LjQ/61jfe8T2EeeCj7Z1H9qBhkoiZ7wy3sW5JwEgbUFGY0EBoI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103789; c=relaxed/simple;
	bh=axQU43Aml76H/iOKeENoFQKWJ7/gXB7cHl8R20BADw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c8v0sbCzUPFNVIl8+bwcZoH01H9dqAVz6XCeFwuH5CyhfDh3F2ZvCHs5VuPZ30uIkxzcZlYh0cr0JoaptrKglFwNo9RJrOCc/h1W3cnaNGKKqgB6+ab8f1HQXVYuDNxNnM59rJWvVKcs/maLn+MNUIxG75OEE3HGo9IhZKdA9rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RBPI+5fi; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62a0873c6e4so10901847b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718103786; x=1718708586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImkowAObGGvWARM8qyLmBbLia+4Yl3rwgPb+hZwmCUk=;
        b=RBPI+5fi+7ZtMQlr8m+cof2zBRR1hqx/EWUmps6wAv/Fg5AYKOj73UnB22sTrKSiG8
         IBdUVb8iawNejjSzj2wF6IXvmN3mk7RlXQ/l0HoWoAYHaSwHD3o83LwdSxRYqNzF69Mq
         lX3CTDy+ci3KdBSMdyTa58+jvRTLZlrvbOQeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718103786; x=1718708586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImkowAObGGvWARM8qyLmBbLia+4Yl3rwgPb+hZwmCUk=;
        b=k+/7xBwnOF+BVbXrL/nEFrhPuULaMfbYTnryLtIghzoZeqI+Wom45g1pn0p7LE95L+
         dDlf7C/JJw3EUVrv3+LQ55zpanRMp7xGqkBBGX8F8BbhAleT5XwuFrTyPOtO+pLu5ooL
         9MBKjUBFkpOX3vs1nhbXRLwdWdLYMyVHgEIhX2bVsW7SBbyM4yzdwSEBijEMmHObLpj4
         cW8iH4s1493vXbmj+Utc0A3nSaRwEbn8uYeyHGCUHTo0Aw56jXbIRH2nG1cKmbaG2YrK
         THRavvaaryifKxqlrcrsbpMdTU4ahI35sFivbppJ4lw8X/8n/tkWCRNnkReZV2N7aic2
         g0zQ==
X-Forwarded-Encrypted: i=1; AJvYcCViU2nUK2iM8kblelAQj01hYsj1DFJ0aNq26MKU2SE7HUh3loudwZn57+94vWH6aZF5VUbeknExcrpmhb47DPW1KEDW1b6alZHMiTnC
X-Gm-Message-State: AOJu0YzQavUezt3WLFVKkl4wizs2tdLj6AbcWRoNkpwbljD21g94E3N8
	pgRVnkBHMxQYJ/LRg+U6RI8iNvnSD3P09mGAWUHo2xDnNqgB4aEz1FGd3Dk6jkTni58KS6Dt+yT
	z3I1c
X-Google-Smtp-Source: AGHT+IGKfgJjl5AbFdYEmHwgB4UA+CO9/L0Ej5JUQlX4Aq+awTo2bU562C9zspGvacUwumd87j7oSA==
X-Received: by 2002:a0d:d442:0:b0:615:4e88:c02d with SMTP id 00721157ae682-62cd55f46c1mr126934237b3.23.1718103785263;
        Tue, 11 Jun 2024 04:03:05 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b08bf006f4sm6392076d6.90.2024.06.11.04.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 04:03:04 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 11 Jun 2024 11:02:57 +0000
Subject: [PATCH 1/2] media: drivers/media/dvb-core: Split
 dvb_frontend_open()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-coccinelle-followup-v1-1-df2de9c2f320@chromium.org>
References: <20240611-coccinelle-followup-v1-0-df2de9c2f320@chromium.org>
In-Reply-To: <20240611-coccinelle-followup-v1-0-df2de9c2f320@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Move the actual opening to its own function.

Not intended code change. This is a preparation for the next patch.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/dvb-core/dvb_frontend.c | 143 +++++++++++++++++-----------------
 1 file changed, 70 insertions(+), 73 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index 4f78f30b3646..e81b9996530e 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -2760,80 +2760,13 @@ static __poll_t dvb_frontend_poll(struct file *file, struct poll_table_struct *w
 	return 0;
 }
 
-static int dvb_frontend_open(struct inode *inode, struct file *file)
+static int __dvb_frontend_open(struct inode *inode, struct file *file)
 {
 	struct dvb_device *dvbdev = file->private_data;
 	struct dvb_frontend *fe = dvbdev->priv;
 	struct dvb_frontend_private *fepriv = fe->frontend_priv;
-	struct dvb_adapter *adapter = fe->dvb;
 	int ret;
 
-	dev_dbg(fe->dvb->device, "%s:\n", __func__);
-	if (fe->exit == DVB_FE_DEVICE_REMOVED)
-		return -ENODEV;
-
-	if (adapter->mfe_shared == 2) {
-		mutex_lock(&adapter->mfe_lock);
-		if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
-			if (adapter->mfe_dvbdev &&
-			    !adapter->mfe_dvbdev->writers) {
-				mutex_unlock(&adapter->mfe_lock);
-				return -EBUSY;
-			}
-			adapter->mfe_dvbdev = dvbdev;
-		}
-	} else if (adapter->mfe_shared) {
-		mutex_lock(&adapter->mfe_lock);
-
-		if (!adapter->mfe_dvbdev)
-			adapter->mfe_dvbdev = dvbdev;
-
-		else if (adapter->mfe_dvbdev != dvbdev) {
-			struct dvb_device
-				*mfedev = adapter->mfe_dvbdev;
-			struct dvb_frontend
-				*mfe = mfedev->priv;
-			struct dvb_frontend_private
-				*mfepriv = mfe->frontend_priv;
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
-
-			mutex_lock(&adapter->mfe_lock);
-			if (adapter->mfe_dvbdev != dvbdev) {
-				mfedev = adapter->mfe_dvbdev;
-				mfe = mfedev->priv;
-				mfepriv = mfe->frontend_priv;
-				if (mfedev->users != -1 ||
-				    mfepriv->thread) {
-					mutex_unlock(&adapter->mfe_lock);
-					return -EBUSY;
-				}
-				adapter->mfe_dvbdev = dvbdev;
-			}
-		}
-	}
-
-	if (dvbdev->users == -1 && fe->ops.ts_bus_ctrl) {
-		if ((ret = fe->ops.ts_bus_ctrl(fe, 1)) < 0)
-			goto err0;
-
-		/* If we took control of the bus, we need to force
-		   reinitialization.  This is because many ts_bus_ctrl()
-		   functions strobe the RESET pin on the demod, and if the
-		   frontend thread already exists then the dvb_init() routine
-		   won't get called (which is what usually does initial
-		   register configuration). */
-		fepriv->reinitialise = 1;
-	}
-
 	if ((ret = dvb_generic_open(inode, file)) < 0)
 		goto err1;
 
@@ -2871,8 +2804,6 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 
 	dvb_frontend_get(fe);
 
-	if (adapter->mfe_shared)
-		mutex_unlock(&adapter->mfe_lock);
 	return ret;
 
 err3:
@@ -2891,9 +2822,75 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 err1:
 	if (dvbdev->users == -1 && fe->ops.ts_bus_ctrl)
 		fe->ops.ts_bus_ctrl(fe, 0);
-err0:
-	if (adapter->mfe_shared)
-		mutex_unlock(&adapter->mfe_lock);
+
+	return ret;
+}
+
+static int dvb_frontend_open(struct inode *inode, struct file *file)
+{
+	struct dvb_device *dvbdev = file->private_data;
+	struct dvb_frontend *fe = dvbdev->priv;
+	struct dvb_adapter *adapter = fe->dvb;
+	int ret;
+
+	dev_dbg(fe->dvb->device, "%s:\n", __func__);
+	if (fe->exit == DVB_FE_DEVICE_REMOVED)
+		return -ENODEV;
+
+	if (!adapter->mfe_shared)
+		return __dvb_frontend_open(inode, file);
+
+	if (adapter->mfe_shared == 2) {
+		mutex_lock(&adapter->mfe_lock);
+		if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
+			if (adapter->mfe_dvbdev &&
+			    !adapter->mfe_dvbdev->writers) {
+				mutex_unlock(&adapter->mfe_lock);
+				return -EBUSY;
+			}
+			adapter->mfe_dvbdev = dvbdev;
+		}
+	} else {
+		mutex_lock(&adapter->mfe_lock);
+
+		if (!adapter->mfe_dvbdev) {
+			adapter->mfe_dvbdev = dvbdev;
+		} else if (adapter->mfe_dvbdev != dvbdev) {
+			struct dvb_device
+				*mfedev = adapter->mfe_dvbdev;
+			struct dvb_frontend
+				*mfe = mfedev->priv;
+			struct dvb_frontend_private
+				*mfepriv = mfe->frontend_priv;
+			int mferetry = (dvb_mfe_wait_time << 1);
+
+			mutex_unlock(&adapter->mfe_lock);
+			while (mferetry-- && (mfedev->users != -1 ||
+					      mfepriv->thread)) {
+				if (msleep_interruptible(500)) {
+					if (signal_pending(current))
+						return -EINTR;
+				}
+			}
+
+			mutex_lock(&adapter->mfe_lock);
+			if (adapter->mfe_dvbdev != dvbdev) {
+				mfedev = adapter->mfe_dvbdev;
+				mfe = mfedev->priv;
+				mfepriv = mfe->frontend_priv;
+				if (mfedev->users != -1 ||
+				    mfepriv->thread) {
+					mutex_unlock(&adapter->mfe_lock);
+					return -EBUSY;
+				}
+				adapter->mfe_dvbdev = dvbdev;
+			}
+		}
+	}
+
+	ret = __dvb_frontend_open(inode, file);
+	mutex_unlock(&adapter->mfe_lock);
+
 	return ret;
 }
 

-- 
2.45.2.505.gda0bf45e8d-goog


