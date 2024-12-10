Return-Path: <linux-kernel+bounces-440426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF4F9EBDC6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9C028B311
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E08211275;
	Tue, 10 Dec 2024 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZizVTI5a"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9F1F1900
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733869354; cv=none; b=dY4z6xwG353+FbRgpfZymNQCqDHDXEvuH89ECzssl9+LGdWBGAi084nWH8QuluDlbPqCT+97Dwp1hjuW96KimpxuLrWFtlNkvBd8Iqi3Cj8zJunn8lm4teR1Ktbw2nJYcA7X9fogRq7MUVVd8fAvmLUbubdEqRpwZv3uV+7b5iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733869354; c=relaxed/simple;
	bh=K72388Mo46bPaPYonT5jJ6Lw47MWUey0RMwa7LB7+rA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HLixuU53hoJympBNQCQovIXFny5SJT81c4nMgMTBjmyDY9q0/RtHEftCP5GrkiCjoNshqAgcj5l69FPxMwBg+KQzpHPKyFE5/Jt4O0h+N++/8X/7nkyGeZU9zFcu+UJmTWjLASqAcntoKz+EYrgDTK4IicR3SD8bSCfQ66jnZ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZizVTI5a; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4677230a9ccso20031101cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733869352; x=1734474152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJLKxDvZkcys4CNhxAUoQwbKiFgypyACQZbRSa8Ir9s=;
        b=ZizVTI5a/DNfthesS7iIWDxpaRQfpXo4AiqT18JO7TPnDp+HCwawjlk9OvBgqhGxEb
         ie6ODoosk99RBcC6dh+MCvIMA7NLUYRKA++E647UOuJrn6/PsVFF5vGZGywKFDffHA9y
         NwIFfRFG9eJVrYFLWKSYZnjWVkaqJa02hONX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733869352; x=1734474152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJLKxDvZkcys4CNhxAUoQwbKiFgypyACQZbRSa8Ir9s=;
        b=v+SY0OknBnMVsSQO4zjZRtoSYfZ6/wXVP59MIKQp/CG4XgmY/cvQJ++uWkM8nalrcE
         SiWFsdQEfQcQhELbQy6+IcC2wMlQ9AfagYJO8as1rohP6yjsa1jyrbjy9cWlhXFuXlge
         GYhkMRspQbXfjEqlJw2tWy7wKQJQN3EFsmiIIL5zTCiKVktOMPaBv27lPclMl+WIgbBa
         kpbutLxhcJzd5yHKtd+pQsi83T/ydm23Wzgma2usRAqtU7j8kC/6w4Fo9YM4sV8rrWiz
         4eRzIw91V47TSquHvmzqNatgkzYSAMPuAzeUfWUyRg8pzf5yPkdM4mjvD1K494K9VBoY
         kscg==
X-Forwarded-Encrypted: i=1; AJvYcCXdBTli7SUpOXGgiw85Cf266A+esZ1tQNbnM9zwRMNn4IKQH24KELIAJphZDYXFNho7xucQ4sUcM8HpsZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGQ3chjN1nUkVjfCGhriftLALXT4fq/PwmpK5kHlCeED36+u7y
	Lt5VVa0JWs3uLol/biOTdTawDYyz1eUadfOaLikPxB0aA6NbRaQgzmTzWKMPuXFZDH0QJuA9x7w
	=
X-Gm-Gg: ASbGncu6e1wfcHFcyUS5qMYXCt9BQwhidJactEg9QvLyeh0CvPTviwDL15PQXoPyT49
	M9vtyEHfHXgivkMIL6meJlc+LJixyt/ILgowNduJPhy9aEsH0C8KLYdW16dhz0LTx7LdvuuanxU
	3ugrmZQ03XtNF4bDm9lN0gr2XVr65b/cm4+LtsG58+bK2VB29W53BaPCap4CX5FvtIGWCAMqe4G
	DJp7k6qTBF+vBEvOtVYbNOgU/fPc6V4y1lIb9Bb/5ODToaF8KoHVoaUDJOA/67vFj6qtX7CXBh8
	XIxXxnvOjDFDwsTTXIoEgVAJdJqh
X-Google-Smtp-Source: AGHT+IGwaoCAcWJN2GJxUO5RU2+RMPWc2ZQl9JG0CXgAkbSPwqLMrUX3CS7unfn384D0Zdx4YTo8rg==
X-Received: by 2002:a05:622a:5448:b0:467:6833:e30c with SMTP id d75a77b69052e-46789309cdfmr11188201cf.30.1733869351829;
        Tue, 10 Dec 2024 14:22:31 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467776034b0sm11232441cf.74.2024.12.10.14.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:22:30 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 22:22:23 +0000
Subject: [PATCH 2/3] media: uvcvideo: Do not send events for not changed
 controls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-uvc-data-backup-v1-2-77141e439cc3@chromium.org>
References: <20241210-uvc-data-backup-v1-0-77141e439cc3@chromium.org>
In-Reply-To: <20241210-uvc-data-backup-v1-0-77141e439cc3@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@kernel.org
X-Mailer: b4 0.13.0

Only send events for controls that have actually changed.
E.g.: We are changing entities A, B and C. If we get an error while
we change B we do not continue setting C. But the current code sends an
event also for C.

Due to the fact that the controls are grouped by entities, and the user
might group them in different orders, we cannot send the events at the
end, but when we change an entity.

Cc: stable@kernel.org
Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 7e2fc97c9f43..9496ac970267 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1669,7 +1669,9 @@ static bool uvc_ctrl_xctrls_has_control(const struct v4l2_ext_control *xctrls,
 }
 
 static void uvc_ctrl_send_events(struct uvc_fh *handle,
-	const struct v4l2_ext_control *xctrls, unsigned int xctrls_count)
+				 struct uvc_entity *entity,
+				 const struct v4l2_ext_control *xctrls,
+				 unsigned int xctrls_count)
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
@@ -1680,6 +1682,9 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
 	for (i = 0; i < xctrls_count; ++i) {
 		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
 
+		if (ctrl->entity != entity)
+			continue;
+
 		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			/* Notification will be sent from an Interrupt event. */
 			continue;
@@ -1911,11 +1916,12 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 					uvc_ctrl_find_ctrl_idx(entity, ctrls,
 							       err_ctrl);
 			goto done;
+		} else if (ret > 0 && !rollback) {
+			uvc_ctrl_send_events(handle, entity,
+					     ctrls->controls, ctrls->count);
 		}
 	}
 
-	if (!rollback)
-		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
 done:
 	mutex_unlock(&chain->ctrl_mutex);
 	return ret < 0 ? ret : 0;

-- 
2.47.0.338.g60cca15819-goog


