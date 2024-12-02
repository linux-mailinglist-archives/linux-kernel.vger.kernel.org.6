Return-Path: <linux-kernel+bounces-427691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C2A9E04D1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45AA028430E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C74C207A2C;
	Mon,  2 Dec 2024 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fcXU1MHM"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F9A205E31
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149490; cv=none; b=utuD8jrOlRKT4dHBg54FsIfW6Dhkg08hdyazW08eV9iahwrFAqIcBClilhSDUA7Ucj0S7auR/ceEgI17kBCScdEK1/+8QKUggnPVUcA8nOGoRP1mcQOZ3cLxlJmFGa9ulKDY30alyPAduexYDLD4YgZ5tMKuzS2hBPJFTqfnivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149490; c=relaxed/simple;
	bh=AywEVRIa8VWMmuquTxALkCvhjnUbojSmLJ871LrwGJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aewj1xlHduHkrTPfRjPJiBufVntMavQF6++sSKb9V5s+guJd0cWIXFhnXtAKt0ADp55QzkNyrwvFG/ejMqECaxdhIlbTH7S1b5Vbjb2wHz6kG+3mYh0pEHSS2Dc//upXsOzjmJjdB1Qz5czYwV92Db4zB7YOl5+3G67Vn01NwVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fcXU1MHM; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-29e783392bfso241929fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733149488; x=1733754288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GovaJn86FmnHeAFnjgqTGOhPMZTKviIql5RFEvQWovM=;
        b=fcXU1MHMRPMn5LDryzdrt2KzjjCKKip1+g8PaY1mnx192vtCVb0kL0uZ7zYMtLlMND
         bZjfuS0O8aMVWPKUz403KxkpKi6n7upPmRr74QEX7susveFQpQttuDl1vzIeVOxoNqdI
         2N2u0pF7iEF+paA8mSLgpF+SqlRGOELyZaDmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149488; x=1733754288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GovaJn86FmnHeAFnjgqTGOhPMZTKviIql5RFEvQWovM=;
        b=AI2vRnchFeFlRuqlkvn8SigwneIinm7joEt55tsUEzM1AWCIRpDsqICMuJNW1Ly4bU
         yeLWRBhvZYTQjwh9gda0/85kbKpTxEBponoIJzsE8B4fthZuXzbXDycWo1O5p5nLPcNP
         jkYbKYU6iRJ00GNuMOYgfInAekn/gQlXkufWyfnXtG2nJ60YFXHdWhTmgV9WfM1sbMl3
         gdLF20lWEKgDwjZ8RYguTW3PWeUvA8TPrOdiBMfyMUZgtCYAJmF11LtP6J0X4WJDnzuR
         uP0gKpUooQSNofbR7mYb1bUzoye0SiMb3fJP81J6HFxEEdoXQNx+J2cEvkcocNfz4pjV
         bHGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFOg/oAb2AtfxvbySFydb5ct+RrhPiar+GXwMpRURbuU4CToebS+ZudqFRpYwcDNIJ2LCXAOojQq7/Y88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuaQVI6fwUOCsSUn4pnYnyF7ne/1/6mQnKW/l1RsRVuBSOpiKq
	G8lSHpwot/OC19jyFgQnEfsjDDyLbY4SrOeTlrf6YnktfsaJp0dO/Yo8e0yv4w==
X-Gm-Gg: ASbGnctd78Cu6A7dLBWvU7S85K1YIOh/qZ64UjTeHDFl+9dJc7V4ai4TPEUHG9Tinxq
	eTuPnHoQjnuSNsXL6UIRntGQ8m0xonmzZYixXwQOF0vEpBbF7lD13KExiEXmZu9M09tMZEoPTJ7
	b7GTJARHxJUMuoiZz/vqJB2I/EQ1q4BHW/1m0VvpvP4AOkIjmqrVXNvT7Xug4vrczVihSflgLw+
	j5g1VOiujIsUPJ1eNy/RJiftNFeOEpxSpeJV66Yp30V2y+wT2CC/uEsGRy46QQ+RLOVUGDr3TZI
	o/bFs8/DU6z91VGfxd8Jsjwv
X-Google-Smtp-Source: AGHT+IEx+ANnkYfSAsAjHxydTAAtBt9M12WJreFy9bqMG2XSO0QA+Yiio2xXJ28N01qURnNZAEOWCA==
X-Received: by 2002:a05:6358:e481:b0:1ca:a079:42f with SMTP id e5c5f4694b2df-1cab159b85amr817878755d.5.1733149488534;
        Mon, 02 Dec 2024 06:24:48 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85be9087890sm179710241.25.2024.12.02.06.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:24:47 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 02 Dec 2024 14:24:39 +0000
Subject: [PATCH v5 5/5] media: uvcvideo: Flush the control cache when we
 get an event
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-uvc-fix-async-v5-5-6658c1fe312b@chromium.org>
References: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
In-Reply-To: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Asynchronous controls trigger an event when they have completed their
operation.

This can make that the control cached value does not match the value in
the device.

Let's flush the cache to be on the safe side.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index e90bf2aeb5e4..75d534072f50 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1672,6 +1672,9 @@ bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
 	struct uvc_device *dev = chain->dev;
 	struct uvc_ctrl_work *w = &dev->async_ctrl;
 
+	/* Flush the control cache, the data might have changed. */
+	ctrl->loaded = 0;
+
 	if (list_empty(&ctrl->info.mappings))
 		return false;
 

-- 
2.47.0.338.g60cca15819-goog


