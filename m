Return-Path: <linux-kernel+bounces-423456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391AE9DA786
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33312849A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021081FBEB8;
	Wed, 27 Nov 2024 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X5pAqEZf"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F521FBE80
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709701; cv=none; b=R3MseO0xuPW3HmRHxVLFokUcf2MHOx3wUlpd5TPt5y8fQ42upCVkvIe0vXYXT8mHqT99LNKpxvceWrfyzhEWxvMR5+pu6KoLOtifCsgVEZgYHNuxBpoPg5Gd9PU6q5sKRnmFtsQdkX7lRxxl+sL4WBUDPByp2G4igzR3uAc6/7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709701; c=relaxed/simple;
	bh=VcsvfSq12DS0fnYrIgZKD+Xjd35yhix6s3hD7aEJjAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YbtjoqIQu4DzKBOBCKzc0tdLMpbSTVOoTlvrcgoQApIz3LOSSk6Hp+BaRKhoqES/iBeeAU8XXRczTPPxlkOZIayibGa+jpANAmxLmaeXhHoIaxrMbAYYJAdOCjC0+euDxg9UEBWEQ+9JwGZGuXkr+YODX8U4iJHP5emj7nyICEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X5pAqEZf; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3882273bdfso7071394276.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 04:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732709699; x=1733314499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7nuXBj4+Zy+PgIyL5ZNHJXV9meQjmyhtl3lnhIKUIXQ=;
        b=X5pAqEZf+zMnnErlWNuJLro7DwZWjwm90MDDu+qimjLlhAqD3eNN/YTh60zN5b3fIE
         /1wLi+vhJarn5TqgvKjIA9JG6nmTvDqB24CRYDzg77tkElUi98gSnSaP+IyzC2kJc/Kr
         SKagbPKh5/ap8i9jcKQ8xySS0ZXLNkTSvrqUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732709699; x=1733314499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nuXBj4+Zy+PgIyL5ZNHJXV9meQjmyhtl3lnhIKUIXQ=;
        b=CPv+izOWajqyhWZwfEz3fZuI+KVnYC9Zgj3zrDQQIps3s2ah860rW1YucqYeOhtYnK
         J6taF7CTYhWG38HcFjUiLoOYgk32aiu0l8n2i/DBiD6k+vENGqGMwA28LkVK7Yu2vk76
         LuxDJjKHimWDlQJS4U2S6gf6eRAybHeoeCI7Lr56Ro2uTmGARxZjtlsXX7F8T76M28oG
         J2Zx0OSlQOFPsrwOaCHXwKtmNA5Gqkmi2MlMuqc0Pi8m+TARq293k2fe4WkWCLfNTFuH
         2pEzxrbxE9DZG861O/j4XHp5w/a5rPUuQsLmaCXWv3PmIBR7yOqkrqlBRw4omfP1lfha
         eQzw==
X-Forwarded-Encrypted: i=1; AJvYcCViOtSo6IHqVoMWhwofD5qb2c8Kcfdn6IKwhgOoPTkYG9LgdPPZri/dREb/JXPBpWNTjnjc9VtTxGGEww8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzirpb/fhxpQZ7R/7vL2H39m1E21gpnb/zuWFEr6fDDWvU1TsIS
	2FSRVRgkzJCtbPy2VMY2wFC55Be/JRUjjcGeF9931XKYXJk65q+f5E/EYO2GIg==
X-Gm-Gg: ASbGncsfnCVZM2MkdQ6P8HipYcVp95HIAUX+weGaPA8FIH1lfd5OhjyGgJhRgB3+Mmb
	PReASK/3PyVwz/BB0AGD0ozdm9mmNxIUbwDhdCC8TxdaeZtbPgOC2Ptxe+mrd0KC3WUxWtxM97y
	+lQ6/5pi0AevLsUpugCMroUhJTS0r/M+fxE3EcfSXKuFll9wQ+KjXrM4qBTgpZT9m74/7u6CrhE
	ESSnGwCHRkfXFNMpVPCklrAMgXc1aAmOtXPDF+giGg38FvyDqnrU9SLc7cnDe7dwMyS2LRzZUcb
	4T0oyYPQakW/Ty6Kj20xUCN2
X-Google-Smtp-Source: AGHT+IGLxdpsvDUuDyS/a7VxdrSBPvc4g30hV96tMr/MAEAPEAJCmKtRun3PxzyerPPec80HnLUxYg==
X-Received: by 2002:a05:6902:f81:b0:e38:9b5f:58a6 with SMTP id 3f1490d57ef6-e395b957461mr2580029276.46.1732709698809;
        Wed, 27 Nov 2024 04:14:58 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466be77cf7bsm371171cf.89.2024.11.27.04.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 04:14:58 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Nov 2024 12:14:50 +0000
Subject: [PATCH v2 2/4] media: uvcvideo: Do not set an async control owned
 by other fh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-uvc-fix-async-v2-2-510aab9570dd@chromium.org>
References: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
In-Reply-To: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

If a file handle is waiting for a response from an async control, avoid
that other file handle operate with it.

Without this patch, the first file handle will never get the event
associated with that operation, which can lead to endless loops in
applications. Eg:
If an application A wants to change the zoom and to know when the
operation has completed:
it will open the video node, subscribe to the zoom event, change the
control and wait for zoom to finish.
If before the zoom operation finishes, another application B changes
the zoom, the first app A will loop forever.

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index b6af4ff92cbd..3f8ae35cb3bc 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1955,6 +1955,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
 		return -EACCES;
 
+	/* Other file handle is waiting a response from this async control. */
+	if (ctrl->handle && ctrl->handle != handle)
+		return -EBUSY;
+
 	/* Clamp out of range values. */
 	switch (mapping->v4l2_type) {
 	case V4L2_CTRL_TYPE_INTEGER:

-- 
2.47.0.338.g60cca15819-goog


