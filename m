Return-Path: <linux-kernel+bounces-528716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 047ABA41B39
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E86B7A6E57
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4193E256C6A;
	Mon, 24 Feb 2025 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RidrmXMN"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0057C2566E3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393304; cv=none; b=NxrCA6UlmeWF5kEPAxKncFhH2KoHMiOxF/5htI7prnGVYMct0dLKo76fy64DJFscqfRU0kYXloDtNNH8ci2cIY+vszEqsfIpKahL07Ntijw+Zz8CzBv/qoQVrf80e0ov6YCWFQr81Mgqr9NDKodnDZcb8fIlnbk3avG4GnNtPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393304; c=relaxed/simple;
	bh=7Zc4E7dry8zMPgTaB9RNF65Q6kaOmoZo78utuFPUPWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HmHoEcZNnkBFiqukANgWU8LuuNk4hhXGBCe2Umr6TqGs4eH6LVuDxT5ObDpuGKI/C3ycvZUHqouNLAkquwlkzSZ7qGBoNI0dsbdYjdD780crbw2HMc+ECnPmXP9IiNjlN780ARU0ZW10vxqOC4IJJQit3tOMYh+muEzSoLCxSww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RidrmXMN; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c0b9f35dc7so604194285a.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740393302; x=1740998102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZ9HGsiAPNY2xJi5rKrAGJy/l6zBdXvq6ok3eL48e0k=;
        b=RidrmXMNZkugO0STX+FCTnSp9ABOiW/MQQiIJS6iD3bBVi0UtiVPm8amkAPy+w/58H
         zXSzqkAbJdVsWWnuy3+egF4XS3ks+bsCN2koSHz0kFDisFzlMFhYHok/ME+5Qb4L4xBX
         4VKIxtH6hnIwKCNmG7wEbase4xhLI0qhjOV94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740393302; x=1740998102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZ9HGsiAPNY2xJi5rKrAGJy/l6zBdXvq6ok3eL48e0k=;
        b=I+RpTLomDo8I8X0Hc8vk86GUG2af5KSbES6f1YzE7yOdsqtmXTsEGmIosP36C3lwV1
         4vEFPGIfHlBcRs7E9YwAKcY6A11s5p2Fn07hbeEvfShnBv7COTqzfQPXPilNLUG7Il7r
         ncLxq8PtqScPGz5KwocpxHMqlUjGE1d+82Ocam/3Pkhc5K4Qhd37tAYeR6kMntDj9k7L
         98M2odTM3muX6tODgaS67IgFJEFPTcBuQO0ZTf4chNem3/A6IwKrRvSeIk780F/me8ab
         pd1fFz67Uf8MEAAP9ubxO2xFhWrJ9SZrZGOx5Ik06OqdEZ8/sWs/C4td9OQvTHDX6IuZ
         PB8w==
X-Forwarded-Encrypted: i=1; AJvYcCW03o2EHFz92lI4PPkD9knb32wYkPk8H46D9WZm79yzD0d1XRf2/ceXLxegSiPklIAadJ5j+qf7CGMJF0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxyQ8CcIOyxuP9mPr431xmKggNjctYfjlIVFNsD1GGufKckbK7
	tEFu2Cdgkwnh8t4lUZvzm11gFnNPl4CIJmSYc1+17J8cHgUsBYB7uDcYR44qUg==
X-Gm-Gg: ASbGncsGCp8s5oiNFUVm8+URURtaAC/0uUQbyH6sNaFH6LwSBagm1TLQSfBcm5jT9eo
	vF7OdgwybEnN7ZVK03lw/pZyy9Rz0rHVPFfi/VMExExcU1niVaSG9RNEVCgZNZWAlxuzMDK/Ff9
	5lWd4l9PUn9EDF30txoPmKC301Ha+GKF/YkCM+EmRbN4K+TLp0qyZbiGysJ0A7wkq404InZ/PPk
	xb5eb5OkrrnA8Mtjzl4eX+tC1lHUM44HD5ekJ3I/v11ma3O+NssarY0R0FTyoIm+wjGTuxrMNrS
	T0Z4aoeOK642EdeJG40AQyPj5r2+2KFN/yp6U922Vhq6S2U2qLH5iYUQIk6arCoiNONlhWkrdD9
	8lrE=
X-Google-Smtp-Source: AGHT+IF8qxeqV0BNuSDxSLm5NIehmKiln3cV1c7kK29Y3BIkgHEbetBmeVYcfmb/KpA7P6ZZzKbOWg==
X-Received: by 2002:a05:620a:1787:b0:7c0:a28e:4964 with SMTP id af79cd13be357-7c0ceefd400mr1339463985a.14.1740393301918;
        Mon, 24 Feb 2025 02:35:01 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b0b7f637sm787139985a.33.2025.02.24.02.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 02:35:00 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 24 Feb 2025 10:34:55 +0000
Subject: [PATCH v2 3/3] media: uvcvideo: Rollback non processed entities on
 error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-uvc-data-backup-v2-3-de993ed9823b@chromium.org>
References: <20250224-uvc-data-backup-v2-0-de993ed9823b@chromium.org>
In-Reply-To: <20250224-uvc-data-backup-v2-0-de993ed9823b@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@kernel.org
X-Mailer: b4 0.14.1

If we wail to commit an entity, we need to restore the
UVC_CTRL_DATA_BACKUP for the other uncommitted entities. Otherwise the
control cache and the device would be out of sync.

Cc: stable@kernel.org
Fixes: b4012002f3a3 ("[media] uvcvideo: Add support for control events")
Reported-by: Hans de Goede <hdegoede@redhat.com>
Closes: https://lore.kernel.org/linux-media/fe845e04-9fde-46ee-9763-a6f00867929a@redhat.com/
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 7d074686eef4..89b946151b16 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1864,7 +1864,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 	unsigned int processed_ctrls = 0;
 	struct uvc_control *ctrl;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	if (entity == NULL)
 		return 0;
@@ -1893,8 +1893,6 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				dev->intfnum, ctrl->info.selector,
 				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 				ctrl->info.size);
-		else
-			ret = 0;
 
 		if (!ret)
 			processed_ctrls++;
@@ -1906,10 +1904,14 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		ctrl->dirty = 0;
 
-		if (ret < 0) {
+		if (ret < 0 && !rollback) {
 			if (err_ctrl)
 				*err_ctrl = ctrl;
-			return ret;
+			/*
+			 * If we fail to set a control, we need to rollback
+			 * the next ones.
+			 */
+			rollback = 1;
 		}
 
 		if (!rollback && handle &&
@@ -1917,6 +1919,9 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
+	if (ret)
+		return ret;
+
 	return processed_ctrls;
 }
 
@@ -1947,7 +1952,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 	struct uvc_video_chain *chain = handle->chain;
 	struct uvc_control *err_ctrl;
 	struct uvc_entity *entity;
-	int ret = 0;
+	int ret_out = 0;
+	int ret;
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
@@ -1958,17 +1964,23 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
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
 
-	ret = 0;
-done:
 	mutex_unlock(&chain->ctrl_mutex);
-	return ret;
+	return ret_out;
 }
 
 int uvc_ctrl_get(struct uvc_video_chain *chain,

-- 
2.48.1.601.g30ceb7b040-goog


