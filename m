Return-Path: <linux-kernel+bounces-561430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1138A611A4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B4A3BC656
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599431FF7D7;
	Fri, 14 Mar 2025 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HQLotulo"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215E61FF601
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955987; cv=none; b=RPhqpTXfvNKYAMNu+SqM9mHZzeIiZDWuks6qDIrBRB/Au+I1dgynubxJxqVtXRxqOAc2eHukUfDP2Lv5kbUIGwCQtOXOHpZkxyqFIWMRFKce1R8W5resU8FJENtAAC4paZa3C/qrK8diwyXquxIcH6JvCHVrtV//coi5t9b/VD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955987; c=relaxed/simple;
	bh=dxUpB1tGOworbd0sAwMOcMt/CpptUDHtvAP/Ih3P+Ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s5ACz/Y7al8uxJTD6c0AXcGXugVhbawi29wAzw3fabBzYEmyDh5HSnMziEHxQW3pts2ltK/0mXXuc100ibrwmzbamFLU5FqC0jjfaKK+A3iiu+BSCmhadf9eMAd71VNDQ44JkNyb4iFDGwy3U/ngvmuPQQRIRKpi6l8Cy46A8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HQLotulo; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47688ae873fso19769551cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 05:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741955985; x=1742560785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGpztL6BjNBivYA0NChHSF5JTshEi+LMCDwRcuw+8OI=;
        b=HQLotulovV5XaZGA6dT9CYr0Lli5JFWL8doUoEgwoJ0sM2Ne626h41NxlblccD4ep/
         I/eXn54cqbfV0ArpSPK49sWzvuiJuPjFLHI1fQhunB2fZAUdDgixbT4afKKDqZO8BZ8t
         n0dsXvlYtDJ/QrKHQh6WtFpMmn6Viga3dqwNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741955985; x=1742560785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGpztL6BjNBivYA0NChHSF5JTshEi+LMCDwRcuw+8OI=;
        b=Q3AsbaHPc/yRPfkARrOzTnTKYAEJnBApmKF+AahZ8s8Bu+vWPEQ6V3U0dnCjM4n8YZ
         X8ISViypKvtwSHqtcbMdWQg10DcTCBZ9DgKRwjSM5JtZlz2/r4GA2fODQGVQJYHHXW4W
         HJbqdd9PJyel+7bwLqOVhAzPLZTcO6Gkbg7aGzk9qxRhonNrnaTbGEms4tteFsthPEan
         W/K1sbB89ts4z6nCI/1qd4Rn4rvLX2q8q1zDkLc66oBgFK6/E7ZEfThIyl+eQoCbu18H
         oLLBZNK+hhk0qaUMFzuJpUlTL7ZLJg4jJzJpBdQAy8Tu+aV7P/NLqad4XTOCjh/i6Z60
         yLsA==
X-Forwarded-Encrypted: i=1; AJvYcCWubRQdJJwebop8QpNXTnUtUNt1yePY+/I9gwSBXF1EMmgfgT5AYB2nAHsIaK3LBaQzsvhSUqGJdv6bDmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmajoee8duxlESriqlKDl4dUw2ivRDAVJyja/Rb1DM6N7eVwO6
	6UcS9SHTOks5ufzn1OcPlDWjt158FJS4/28DsS3rX/7Z+GmZQOwBuj7XdqeRSA==
X-Gm-Gg: ASbGncuFhqMYc3euicOaGIZLC9ClWdDBhR+7ajW9ZYo8Yk32TeBzT5buI6OnqUSgCEX
	JhYiqAUF9T9W4vo47QlyVTxjMhrczPb6MNmq9P3C8GDxN2h6cxV3fxm/2FwOSsnVipAaidw48q9
	qKL7nIR5odLrpeA7gP4HI6T5CRKseEm0kd/7mQaTtO0mAamYlCz1wCetQtKlhMKaKTxllhiasMh
	3NJ1BxS6hL/q4UF3FXhFYaElTbugGSEXFbotgJ02lM0sV88PBT3Dc9vIYFnHwu/52SiJBtzqW9O
	p+h20dJLLdH3BHmTO+PyOvgy5t+1z0mZYHKZ4EqOWJeUzNYBHt/QCq7VG0Jbiw9pZD+9EcldNiu
	5qNIlEhxfN5/Uf6l4F7jxQA==
X-Google-Smtp-Source: AGHT+IHtgUymcNvTlk8gc+ET81zehXYtGld8Q10RH9uzFtc/wuhFJJlTZSaH1eoYEa2rNaGXyrS9Ww==
X-Received: by 2002:a05:6214:260c:b0:6e6:2395:7634 with SMTP id 6a1803df08f44-6eaeaab0fd0mr28848156d6.27.1741955984973;
        Fri, 14 Mar 2025 05:39:44 -0700 (PDT)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24b8c2sm23031586d6.50.2025.03.14.05.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:39:44 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 14 Mar 2025 12:39:41 +0000
Subject: [PATCH v2 2/2] media: vivid: Add more webcam resolutions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-vivid-fix-twice-v2-2-dcfca4053704@chromium.org>
References: <20250314-vivid-fix-twice-v2-0-dcfca4053704@chromium.org>
In-Reply-To: <20250314-vivid-fix-twice-v2-0-dcfca4053704@chromium.org>
To: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hidenori Kobayashi <hidenorik@chromium.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

Add 3 more common resolution for webcams. This is required to increase
the test coverage of unit tests based on vivid.

Co-developed-by: Hidenori Kobayashi <hidenorik@chromium.org>
Signed-off-by: Hidenori Kobayashi <hidenorik@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/test-drivers/vivid/vivid-vid-cap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
index 623ba1e5e54791c0ac62aa2f0fcc3dcd444c873a..df726961222be874c39d19e1fb457bd816ab45fd 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
@@ -25,9 +25,12 @@
 /* Sizes must be in increasing order */
 static const struct v4l2_frmsize_discrete webcam_sizes[] = {
 	{  320, 180 },
+	{  320, 240 },
 	{  640, 360 },
 	{  640, 480 },
 	{ 1280, 720 },
+	{ 1280, 960 },
+	{ 1600, 1200 },
 	{ 1920, 1080 },
 	{ 3840, 2160 },
 };

-- 
2.49.0.rc1.451.g8f38331e32-goog


