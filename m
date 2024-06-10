Return-Path: <linux-kernel+bounces-208781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D28A902914
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC4B282194
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D6D1C694;
	Mon, 10 Jun 2024 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I+lIlsk1"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849F2381AD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047086; cv=none; b=FbK0xflJRjHDyVdbJwD+KQ1joxuHlacLXycxt+CE0l9sPFyQNx71tXXZTIIbCKi7LPe3Ckup8l9K5zPfnG+z2g/IJMQyN4kWDETycxN6U5RqnkDdZ4/7lRnfj+N5Lhj9OKcMm5RLyylPETCzOFwPBce3bw6kFWfYYwN+vN3Bcfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047086; c=relaxed/simple;
	bh=e8QAijiS+vWnLQpugeeTYJFotv4VJR9R4QIMdah8zUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VAtWEt+cIM5Uc7gaZsFoyqvJ6EdsZ7bQARfJx0dLCZoJuXLgG8KHlY2iDq5Pp/FWjWlWBhSlHT0NnhPrhbvGA7qhnwyeAZE3Nj3UE0GMfgOFwrDOeIcv0NYjpV64RDFTIcA5e3q3GKb6lpy9mO6/cNifJgWCkU/bjwqAj1RX+uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I+lIlsk1; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f8d0a00a35so3223781a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718047083; x=1718651883; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1ZskNZ0DEFVgNBAvorO0HFPnB7vczxbbUnw5BSBQT4=;
        b=I+lIlsk1aVXtjXI4th3FZP7V2fS7uz+YVMS0q7D1aLHrbjmn7SGjquQDvnG5uwvqV/
         7yw5voTgHcKMx+CXgQy2ugexiJa+85chWkJM/BInQue3/89mZL5fj/amu8StGrFJaz8J
         HZzunJx1X2OfbbF+2VTfkijr1VqvJjG7iWoZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718047083; x=1718651883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1ZskNZ0DEFVgNBAvorO0HFPnB7vczxbbUnw5BSBQT4=;
        b=Tx/GDd0tMYlskij89DeBRKGiZQ1e7XCu9p2zAXDbuilIYdZ5eeRV7eiNQqrAReFgie
         bi0T4E/H7iO0dtbK5XutSw6dDD1NIQZSDxq4iHEu9pqPFI7Q1Tk0hWK5TjszNgfDF+fL
         7UQBtP59pCTWNJY7mDJ8l+6VdXsJJel5OCDM7mBIitRjKMuFm1EZ/madhlboRkHBP66w
         NjjEt4oJK46VxXoGL1ZC9BngkTEA8SIW63SydCyv8H9O21UdupRFzOgA8IkNuvBR0PtV
         +oJ07zVusXIAejPC0JLLpgZeLzvzMAW+rgHCyiPaYKournV296o2lJP9+8RxwmmhPsf1
         ZaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW8/dVzfn36ocdio8gwVWRhzlycJXw6sD7fYmUMIJWT/ZEc6m74PE6VrV4BqMsszMYFe67N9JZuvNgkH0v1i6XtqqjOSZ42BfIp/Fi
X-Gm-Message-State: AOJu0YwebKUtT4dTmYjdasKpEgpkCIG6+NiHb2cCKL3JAlnmewwfJsJi
	yza89edakAFeSIbSkBwuv30JfLn8MuhXT2QYhHwwv8kXQbYyrGm/p15dKcj/DQ==
X-Google-Smtp-Source: AGHT+IF4eYv4EReM/nxxzD6ehaqsLavj92SzMNnIGlCozlFThq/B614BQ9LCW1qL6n8vFMy7zMWFHA==
X-Received: by 2002:a9d:6c57:0:b0:6f9:df67:a8f2 with SMTP id 46e09a7af769-6f9df67ac08mr1454050a34.28.1718047083384;
        Mon, 10 Jun 2024 12:18:03 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b06e66ad80sm26224546d6.129.2024.06.10.12.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 12:18:02 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 10 Jun 2024 19:17:48 +0000
Subject: [PATCH 1/2] media: uvcvideo: Fix hw timestamp handling for slow
 FPS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-hwtimestamp-followup-v1-1-f9eaed7be7f0@chromium.org>
References: <20240610-hwtimestamp-followup-v1-0-f9eaed7be7f0@chromium.org>
In-Reply-To: <20240610-hwtimestamp-followup-v1-0-f9eaed7be7f0@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 HungNien Chen <hn.chen@sunplusit.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Tomasz Figa <tfiga@chromium.org>
X-Mailer: b4 0.12.4

In UVC 1.5 we get a single clock value per frame. With the current
buffer size of 32, FPS slowers than 32 might roll-over twice.

The current code cannot handle two roll-over and provide invalid
timestamps.

Revome all the samples from the circular buffer that are more than two
rollovers old, so the algorithm always provides good timestamps.

Note that we are removing values that are more than one second old,
which means that there is enough distance between the two points that
we use for the interpolation to provide good values.

Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 23 +++++++++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h  |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 76a375fe47dc..869876afdcce 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -471,8 +471,30 @@ static void uvc_video_clock_add_sample(struct uvc_clock *clock,
 {
 	unsigned long flags;
 
+	/*
+	 * If we write new data on the position where we had the last
+	 * overflow, remove the overflow pointer. There is no SOF overflow
+	 * in the whole circular buffer.
+	 */
+	if (clock->head == clock->last_sof_overflow)
+		clock->last_sof_overflow = -1;
+
 	spin_lock_irqsave(&clock->lock, flags);
 
+	/* Handle SOF overflows. */
+	if (clock->count > 0 && clock->last_sof > sample->dev_sof) {
+		/*
+		 * Remove data from the circular buffer that is older than the
+		 * last SOF overflow. We only support one SOF overflow per
+		 * circular buffer.
+		 */
+		if (clock->last_sof_overflow != -1)
+			clock->count = (clock->head - clock->last_sof_overflow
+					+ clock->size) % clock->size;
+		clock->last_sof_overflow = clock->head;
+	}
+
+	/* Add sample. */
 	memcpy(&clock->samples[clock->head], sample, sizeof(*sample));
 	clock->head = (clock->head + 1) % clock->size;
 	clock->count = min(clock->count + 1, clock->size);
@@ -605,6 +627,7 @@ static void uvc_video_clock_reset(struct uvc_clock *clock)
 	clock->head = 0;
 	clock->count = 0;
 	clock->last_sof = -1;
+	clock->last_sof_overflow = -1;
 	clock->sof_offset = -1;
 }
 
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index e5b12717016f..f21207debd54 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -501,6 +501,7 @@ struct uvc_streaming {
 		unsigned int head;
 		unsigned int count;
 		unsigned int size;
+		unsigned int last_sof_overflow;
 
 		u16 last_sof;
 		u16 sof_offset;

-- 
2.45.2.505.gda0bf45e8d-goog


