Return-Path: <linux-kernel+bounces-425957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A75C9DECF3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 22:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67654163D60
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3361AA1FC;
	Fri, 29 Nov 2024 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VlOtASaq"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CFE1A38C2
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732915837; cv=none; b=AHfYgGe8SeeR6PipLaju2SfAtjjq9iH5y/xSkRNrURg2xEnAZyUnCKW4LVeNaS+25m8YYdCdwK+9mZm9c9affcyBK0Cz+DYXn+I7hLv/lZ9bb1FmCWzlhOqoS9aEsnGhgN1/gHUsiliyzTRLAfiADpHb5/AqfFXi1BELGUX3YiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732915837; c=relaxed/simple;
	bh=v5QezjflINmr1he5MndfMVx+1wL6381Mly0MlSiNytI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DLv0qib1586gJ3ybWLjeXmqJdetppK54Jm4YgAIQ0t5BIgTciin8RN82XnL9PNaORDMRWibmFKerObba4bTC7pC701b58KCV4r/sqQ8oUvum+XixEXn0BqGtj5B1qd2uQi4MZlZyoNZznPqp2SF0GkAdBsPIwoYndo2JZy+UG+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VlOtASaq; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-85b88a685e6so439470241.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732915835; x=1733520635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucJjvH6Z5O34BPMy+Kt0AFvVfn1owPFISOzjaTX5B9k=;
        b=VlOtASaqZgGUN69hfmv2Q3C06dVq6HZ0oZ5O9zpr4MoV8hFqszUHXMe2OlKzGIKatA
         1qMmb5mBPkDYA9ueUHWJWUkIiyq4q9rkstP98TXzICFTZACTgPwYiIZtDEAiTkjFh8f3
         kFhI7QEWuFM8VTt3AnA6iB2dXL141oLZcD4Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732915835; x=1733520635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucJjvH6Z5O34BPMy+Kt0AFvVfn1owPFISOzjaTX5B9k=;
        b=K9Wn+FAqKWB3Wf0uvEZ1zJhJv90vNC+aZFOs0ZMY7rqXpDMCzr+dEvfxHjg0OylIYQ
         H2IG2gh2vhM30GPLQTgp+vtHOtcuvv8tjGkEnwL+xGfUZRYwaBBUsT7Q54Q0GAlBnIrr
         9HrKotAZO86SH7wDqLB5uG0hRHZOsq3ZJbPuYmt1D2ZhxyCkuMEAMV9IJL70gaMkOko4
         YRWSf98k0hftfUkPD9u3VOXsKHIA8FUopFPe6HySyTk6a9hWjq3H9EyAUBGNt0UPrzvq
         gk0JvEZ8DgKmofUwMS4QZhC7GRNQIUvLdWzbd/AKgk+YTMLN2QhHLu3UGloa+2AuFuTS
         kV7A==
X-Forwarded-Encrypted: i=1; AJvYcCXloAzrldLHa4nx1dw17Qxzso4RCrhn5TBPDJ5XjNn1L4pVf/HrNLm1ucwSd04kn5OxeCE3vGLr6l8pgdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6cWnKYPaWZ587elFjKD0G5e06mHRenKmxeF0MjqFlthoA94Eo
	VpY1Y8cj+IS30q0sFG35YwjgFQYHhbcPWz1694vua4pRf68InDwPJzBZzWmThAjBePgMeneFk6w
	=
X-Gm-Gg: ASbGncvLN/6HUCqv/qdwvkPPtrRX2M2lPjQTky6oRhaKfY9g1QVg/dJHHpdD06IfJgT
	I0etrVqgMPKDefGuDn7Z4k/gMwDZTzmU15UahO61V+bUZdQiNgEw2WC/GbaN7PiLlHRhx6bd60W
	kh6MLwJkd9S1fFn+JMgOW31DZKkl7ReHgoYSB2iJzTO5YSZQ4oWt7uJyk+zzIS3Y0Nc5DNT4yeB
	ueTvfiGcQkQMUfGJBm/XtwrQgxy5P1Dft8ayuuwdtNWpCkKqHYQNyPUnOVQIuzPAnPpPTB1dR9n
	olxa27XiWF9m06nZVlPZ4yOX
X-Google-Smtp-Source: AGHT+IH3VfM6LqkrJkK/UlQJJZ22q3iU/5oBBscMFmZZcqik+YSMZUFM/OEX7FkQUFRdN8ccT/KNFg==
X-Received: by 2002:a05:6122:2a11:b0:50d:35d9:ad60 with SMTP id 71dfb90a1353d-5155692de66mr16955127e0c.5.1732915834862;
        Fri, 29 Nov 2024 13:30:34 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5156d0c1b7asm607254e0c.36.2024.11.29.13.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 13:30:33 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 21:30:18 +0000
Subject: [PATCH v4 4/4] media: uvcvideo: Remove redundant NULL assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-uvc-fix-async-v4-4-f23784dba80f@chromium.org>
References: <20241129-uvc-fix-async-v4-0-f23784dba80f@chromium.org>
In-Reply-To: <20241129-uvc-fix-async-v4-0-f23784dba80f@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

ctrl->handle will only be different than NULL for controls that have
mappings. This is because that assignment is only done inside
uvc_ctrl_set() for mapped controls.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index e02540162dd4..8483e6760be2 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1667,10 +1667,8 @@ bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
 	struct uvc_device *dev = chain->dev;
 	struct uvc_ctrl_work *w = &dev->async_ctrl;
 
-	if (list_empty(&ctrl->info.mappings)) {
-		ctrl->handle = NULL;
+	if (list_empty(&ctrl->info.mappings))
 		return false;
-	}
 
 	w->data = data;
 	w->urb = urb;

-- 
2.47.0.338.g60cca15819-goog


