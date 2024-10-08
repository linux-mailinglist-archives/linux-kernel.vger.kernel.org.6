Return-Path: <linux-kernel+bounces-355476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F2D9952CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FEC52880F4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5A31E1047;
	Tue,  8 Oct 2024 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fcz2s1hy"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7681E1020
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399614; cv=none; b=ZjCmfvIz2fZQsRxI+H7e29LH7fHP8GqK08Zx0LD9pwcolnH27JVNuxtkH+nmBfwGXAjTBwkAcDLxvlOH//677A/09n6vK394fy51FgYRfrRotV2VoAnFJ6HGe7wNVGQpdMD7JycyrM5MHaMwpv3lsAjq/vPz0pe/0lThL31c+aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399614; c=relaxed/simple;
	bh=pvyPWsToTZtRlgvmX7LMTSxDbnGxM8D+iYsUDPJR3zI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YymUB6kLyrz51MZsKN3SYRwGFUxwpnhNdxuvkHGyHwSEipP9EoKCO4viXz2NJVojfSHxbprbDeXSBuherbx7ddOxarCrwVIAxZjOeW5YujNRPLZlICXWRoDgUzXX27x5WwPhmU6yBjZelHOYI3tmwQhK0Q1YseheEbVTCUoHV8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fcz2s1hy; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7afcf0625a9so10006385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728399611; x=1729004411; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCWa9i1F2c8oRuwsqOTxWxy2qXb4GIjxtma/YuRpfzQ=;
        b=fcz2s1hy66U4WVHN6J4+dFtg0LyAw46ZZ+oJgxpLstkeMnqTC937ed20jLqrYuud6z
         oHQowi57h7/V5kUtW4me9b4CMbqXmFNeMb1caUJ3l/6HGMOSiZY+1Tz9EBrWFaBpCCO8
         0bFh5SMRVFDhfRohOk7yFKq4gUaaLcFu8lqWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399611; x=1729004411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCWa9i1F2c8oRuwsqOTxWxy2qXb4GIjxtma/YuRpfzQ=;
        b=vbai22H44HaQZ95Pz8vgBEudFxSD4tuVQZ8FXuz1yXqtaCy8+25qHPpG3euAWdHZEt
         nc6XBqVQXDnyo790su7hj2Lwu72o50yY4uEuqvfdJ4Vu7o5ZMBOzLt6MYFyUkK6HGVGM
         t4XB9JodcqldcPAnmIRsdtldG3geAYYzt3Tkg+sE86lJZbDbq48hcaSPVQBAwk/pi9pO
         EQbAB/xkMwLgtDD6bb3kdGqvQOuulf9PhnsvuJiLmxmL6ldnxxBENP0jDPPymY9geVtm
         w2PC4yY2R/Bh63IvOD/Zq4DaMHS75MsfX40hP4P06YXCUK1YFUNQTOVSCrIT5d10o95B
         Fn2w==
X-Forwarded-Encrypted: i=1; AJvYcCWNRjOyNWXdrNe+/zu+0e+sqyXix/oBA/eH0/9lM8nZSWNQ01aK/WThGSA5+difXIlO5Sfv6zq1khYPitc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoc3E+1JbSKsGQ27MwVg935wY35yFqSAtfqYHvT58K1ToKVyH4
	dKAi+rW+ZXL7a4C36nSXDcizYKhrnvXJGbN1cRgzaaPug4N+Dlv3tXAPJ4oDhQ==
X-Google-Smtp-Source: AGHT+IG5PsXIAlrZHuvZt4cgIpu7/vve2DpwC1FBFLl1/3rpAI6lcB69ZNNqDPmjs3XOrOpvCATW1Q==
X-Received: by 2002:a05:620a:2952:b0:7ac:e869:b073 with SMTP id af79cd13be357-7ae6f49f5e8mr2806863885a.63.1728399611473;
        Tue, 08 Oct 2024 08:00:11 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75762a36sm360886085a.124.2024.10.08.08.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:00:10 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 08 Oct 2024 15:00:08 +0000
Subject: [PATCH v2 2/2] media: uvcvideo: Add more logging to
 uvc_query_ctrl()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-uvc-readless-v2-2-04d9d51aee56@chromium.org>
References: <20241008-uvc-readless-v2-0-04d9d51aee56@chromium.org>
In-Reply-To: <20241008-uvc-readless-v2-0-04d9d51aee56@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
X-Mailer: b4 0.13.0

If we fail to query the ctrl error code there is no information on dmesg
or in uvc_dbg. This makes difficult to debug the issue.

Print a proper error message when we cannot retrieve the error code from
the device.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index f125b3ba50f2..6efbfa609059 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -111,8 +111,12 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	error = *(u8 *)data;
 	*(u8 *)data = tmp;
 
-	if (ret != 1)
-		return ret < 0 ? ret : -EPIPE;
+	if (ret != 1) {
+		dev_err(&dev->udev->dev,
+			"Failed to query (%s) UVC error code control %u on unit %u: %d (exp. 1).\n",
+			uvc_query_name(query), cs, unit, ret);
+		return ret ? ret : -EPIPE;
+	}
 
 	uvc_dbg(dev, CONTROL, "Control error %u\n", error);
 

-- 
2.47.0.rc0.187.ge670bccf7e-goog


