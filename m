Return-Path: <linux-kernel+bounces-214909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADE9908BE4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9661D28716E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5094A199389;
	Fri, 14 Jun 2024 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T50MrKNc"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B365C19A29F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718368906; cv=none; b=j/bvv0xk7qMW8aMZN4FAVHxOkg6kX92/v4F9mhxirC+xDKp4UMr3TwDtBMSP5gt8tD2/YgbczBcszfP1BKnZqFBmIRexxNVc7pxerd2cB+E/iLPtsi6nrFhI9Y0s4TEg2sgkIl2pe+poeqR31rJZjMCQxO4ZRPeZdFmvpir4fwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718368906; c=relaxed/simple;
	bh=OVCh0xiNtbKDo7jHdOZaakUb3rirDOQ3yptayCuHr+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GcFNGH2lRzZXPXku0t4AXTeGNVQoZIoc9WJJeOcJCA2RDPivlpJPSeeExYMAak9pk1dxvbzPOxUbjawUu4zD163RvLTc5rAMbc5ABKlqvafkYNmDHIxLOrXQ1frRaCjuLX7Wb8vuvYa90/T2hA0aS6+2RoGNQ3VhBwF/pujWuQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T50MrKNc; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4405304d062so12184131cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718368902; x=1718973702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmhzD6drL+dqelhUuMiG4rDosl5mRy0mIhnFlZNZ6YM=;
        b=T50MrKNcSLj0hGcRihRrH9Ok907alJUsFeoP952I+XrOArHlgHCBxDMpxYrgOhnyKx
         UYBDGXgF+vp2hfBV0dfglqZyuXdDqC81EBkJIcnimrEuAUHNpH1kVbKdJbHCmgl2JHvP
         0Iwz/KJ9ISkMpnaRr3Zac+SuTyDF1J7SIT7y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718368902; x=1718973702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmhzD6drL+dqelhUuMiG4rDosl5mRy0mIhnFlZNZ6YM=;
        b=THc8aLdOqjJtn9Gt7Rd6q3Qt2hKK1mJxnfAMXEBQDlZSofPBf3ri3BZ7gxd8qrb06d
         ZSHAg0yNKk/8uH4h68i7ctTWyopAGEcBebfA8QnSitYvpTRUmJIXURbNSTbOBw6i6pTv
         DagO4QEe5n8k3dE0/eifg+1lkK6N6+1IDTi0ckiNd/JLiOge8DSN3+LVZrAjVCakUYSM
         Ow2SnQd9Ey78695K3wF+WHmztKm/YlmAKlhqUq4I/xDpusm7ZaU/hao3DqDkRlHs8EL+
         Znet//FGK8K20GDQjG2zPmBEfPgXy8Nw8syrtEvDB+TL+QWKnEZ7ypMsjQr5Q1jtn/I2
         a+5w==
X-Forwarded-Encrypted: i=1; AJvYcCX1e2FGYoadgDO1NV9So/zAphDgbNyBj7ZzPK5R4LP5vXOJcjEJXdvM0SiNJcfTNFPSv9O44gOxwIxZZiJAW1BgFUALpIw0FVlacAGw
X-Gm-Message-State: AOJu0Yy+w3XE1TQau8DR4ugB6Xg+iWpv8e0hYPE3sviuj8i1aP7QdDo1
	V1tk/0MpdQCy0uQH0mtHerYHhsB5jL1awORG5LrnmBw20yj89eWgjT3EO3lohA==
X-Google-Smtp-Source: AGHT+IEhkccRGU/pAfXr2wII9wTmtO39p/PGCYtDnTWQ8tgsir/ZFOzyqT7qIyMxanAIk0Mr5KL2DQ==
X-Received: by 2002:a05:6214:4b85:b0:6b0:76f1:8639 with SMTP id 6a1803df08f44-6b2afd5a04amr24760176d6.42.1718368902656;
        Fri, 14 Jun 2024 05:41:42 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c202e8sm17734056d6.50.2024.06.14.05.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 05:41:41 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 14 Jun 2024 12:41:30 +0000
Subject: [PATCH v6 4/4] media: uvcvideo: Exit early if there is not int_urb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-guenter-mini-v6-4-7b7fdc3b21b3@chromium.org>
References: <20240614-guenter-mini-v6-0-7b7fdc3b21b3@chromium.org>
In-Reply-To: <20240614-guenter-mini-v6-0-7b7fdc3b21b3@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Tomasz Figa <tfiga@chromium.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.13.0

If there is no int_urb there is no need to do a clean stop.

Also we avoid calling usb_kill_urb(NULL). It is properly handled by the
usb framework, but it is not polite.

Now that we are at it, fix the code style in uvc_status_start() for
consistency.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_status.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index 8fd8250110e2..9108522beea6 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -308,7 +308,7 @@ static int __uvc_status_start(struct uvc_device *dev, gfp_t flags)
 {
 	lockdep_assert_held(&dev->status_lock);
 
-	if (dev->int_urb == NULL)
+	if (!dev->int_urb)
 		return 0;
 
 	return usb_submit_urb(dev->int_urb, flags);
@@ -320,6 +320,9 @@ static void __uvc_status_stop(struct uvc_device *dev)
 
 	lockdep_assert_held(&dev->status_lock);
 
+	if (!dev->int_urb)
+		return;
+
 	/*
 	 * Prevent the asynchronous control handler from requeing the URB. The
 	 * barrier is needed so the flush_status change is visible to other

-- 
2.45.2.627.g7a2c4fd464-goog


