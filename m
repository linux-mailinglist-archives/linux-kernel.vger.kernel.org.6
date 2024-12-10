Return-Path: <linux-kernel+bounces-440427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCF89EBDC9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE0A28B835
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D680212D9D;
	Tue, 10 Dec 2024 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YAXYICRv"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB84211277
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733869356; cv=none; b=Nybp7FcQchU+rmNM6iOSr9EI+GgV304+8KNypwH/BbBCa26UOaOdNjxzSCzzmCUcmpLEgvKM8CSxjd1qPFm63WOJWCkKrqPaEKPvfdSz0VFPnaMlb3LJEQUUdW/l3TBF/36fuLefivvxudzWLJSW+SGI7oSPzJAkUtrWvgtJjR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733869356; c=relaxed/simple;
	bh=D0ZexnELTKVfQSmyeA71ynoDvywobwhOrZ/0Katurbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TOaPcd8kDzEvdOEEuaD9avTb2A4T3vDQk0CWla/wRxCYfrLwh/Oo7SDTYqMtq6chHOyqrvSECs8qVEZtxLDL/T4T5sdTZYNSOzfY8lhZbR5X08v42fOjS4m7U7fAiGZoeYUh1bV6g5J21MPJleOCiNYBsuWvTXKOtXAFz39z8uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YAXYICRv; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46769b34cbfso35129771cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733869354; x=1734474154; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kcafMw9Z0U3vF7FScCVFpDYTrMToPYmiLDGfXKQJyjY=;
        b=YAXYICRvgicHaSE72QRN8t/j9+S1e+f832n3k+6VXCMXRCYMWSzIl9vtDm2SxcV8sZ
         CjLym5feYxtUQ79KHOHXhzn97o7QSE/gYcx6evnlaywxy98llZrt8xNnAxwihLKUOXWI
         UTnzwDRmRs/ojbOWEqBTsCtbiNUONvaSYQWkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733869354; x=1734474154;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcafMw9Z0U3vF7FScCVFpDYTrMToPYmiLDGfXKQJyjY=;
        b=qbBKbz6VR2hitfkLAb6SFencx19z+mjFuQCvE0pgFIt3gbWnHKW3BjiRRW0/CkB13m
         kB+BbEtM53s4U+7vDGyk/Xhcr0eFkQBrEVjsPyGIq13nk7Bs6A+LO3RdQQCJx7wZl9QR
         H9I55ovULAeephE07srrlh1R5dcSjcO4P+wFVB23G5xd51PsjTWMUN/kQCUzO00/IMya
         LqeemOXaRQE1rW2Dmn5kmUtO9SGEI8GUmGJajUefCpAKvu1jCzFusjXC9KFIKbGNDTCd
         /GtNfh//PXlEsBLvUzgFyWMaZob7MP+Y80RMsqRKo2DPbs3dpZhMEi3KmD9b+CjbFCrq
         YvmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBnCUsJEGX8wrRQV4jpQJoFu+xrZdoxWLsLoR+ulz9WjxdmUSFN7arvK08sfLY6GntpuvHs26Hsdxr6Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5okmhP3kFOg0/XyIH01VWeAyhKkfG4siFDnxDodQB95Ei+Dke
	eBH8V1DRku56kGjv6VSUXVhr/zzxSnd+Y9CvQqVyHMBF2aVey7afLhvvx+EdsQ==
X-Gm-Gg: ASbGncsLKhlAs9SCQfePYPlAcxAuKCqC0gyN7nzcCDy70tgiCMwjROeqGzqZu0YfqoT
	KdvMrOK1B1KwPZWCwsF/SHD9yWTEec6WdbEj2jKJNUCeJ8OWRj6wFE18VlHgnljxTgAXvF6eKLr
	R1zaOK/yk6BHFWmWKIQtqSJJxTGuNFTzOnOxFlyGlAyK76LGShh8gZ6GTjkHyusiryc61UW00WM
	GxmrTpIKMYboO+cPfHh2Y/dZShYdApVocVOpfqJ0wmqYGhCQWTmoLQbOnMF0bsTooKpzR5axKwJ
	CASg+YNPEQHg8Uy4vPpHT8TVgo3e
X-Google-Smtp-Source: AGHT+IGo9/Hxonb35H4V5LFXpS6P8ognfkxmBy4lOIHwm8Bg86/UKY88TGsyICxmZNUCI03BbZfnNQ==
X-Received: by 2002:a05:622a:1b16:b0:467:60a8:8a9d with SMTP id d75a77b69052e-467892932e9mr12907201cf.8.1733869353966;
        Tue, 10 Dec 2024 14:22:33 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467776034b0sm11232441cf.74.2024.12.10.14.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:22:32 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 22:22:24 +0000
Subject: [PATCH 3/3] media: uvcvideo: Rollback non processed entities on
 error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-uvc-data-backup-v1-3-77141e439cc3@chromium.org>
References: <20241210-uvc-data-backup-v1-0-77141e439cc3@chromium.org>
In-Reply-To: <20241210-uvc-data-backup-v1-0-77141e439cc3@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@kernel.org
X-Mailer: b4 0.13.0

If we wail to commit an entity, we need to restore the
UVC_CTRL_DATA_BACKUP for the other uncommitted entities. Otherwise the
control cache and the device would be out of sync.

Cc: stable@kernel.org
Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
Reported-by: Hans de Goede <hdegoede@redhat.com>
Closes: https://lore.kernel.org/linux-media/fe845e04-9fde-46ee-9763-a6f00867929a@redhat.com/
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 9496ac970267..93c355b53101 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1825,11 +1825,14 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 	unsigned int processed_ctrls = 0;
 	struct uvc_control *ctrl;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	if (entity == NULL)
 		return 0;
 
+	if (err_ctrl)
+		*err_ctrl = NULL;
+
 	for (i = 0; i < entity->ncontrols; ++i) {
 		ctrl = &entity->controls[i];
 		if (!ctrl->initialized)
@@ -1854,8 +1857,6 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				dev->intfnum, ctrl->info.selector,
 				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 				ctrl->info.size);
-		else
-			ret = 0;
 
 		if (!ret)
 			processed_ctrls++;
@@ -1868,12 +1869,19 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 		ctrl->dirty = 0;
 
 		if (ret < 0) {
-			if (err_ctrl)
+			if (err_ctrl && !*err_ctrl)
 				*err_ctrl = ctrl;
-			return ret;
+			/*
+			 * If we fail to set a control, we need to rollback
+			 * the next ones.
+			 */
+			rollback = 1;
 		}
 	}
 
+	if (ret)
+		return ret;
+
 	return processed_ctrls;
 }
 
@@ -1904,6 +1912,7 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 	struct uvc_video_chain *chain = handle->chain;
 	struct uvc_control *err_ctrl;
 	struct uvc_entity *entity;
+	int ret_out = 0;
 	int ret = 0;
 
 	/* Find the control. */
@@ -1915,16 +1924,23 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 				ctrls->error_idx =
 					uvc_ctrl_find_ctrl_idx(entity, ctrls,
 							       err_ctrl);
-			goto done;
+			/*
+			 * When we fail to commit an entity, we need to
+			 * restore the UVC_CTRL_DATA_BACKUP for all the
+			 * controls in the other entities, otherwise our cache
+			 * and the hardware will be out of sync.
+			 */
+			rollback = 1;
+
+			ret_out = ret;
 		} else if (ret > 0 && !rollback) {
 			uvc_ctrl_send_events(handle, entity,
 					     ctrls->controls, ctrls->count);
 		}
 	}
 
-done:
 	mutex_unlock(&chain->ctrl_mutex);
-	return ret < 0 ? ret : 0;
+	return ret_out;
 }
 
 int uvc_ctrl_get(struct uvc_video_chain *chain,

-- 
2.47.0.338.g60cca15819-goog


