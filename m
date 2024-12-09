Return-Path: <linux-kernel+bounces-438295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B639E9F78
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0296188349D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D98C19924F;
	Mon,  9 Dec 2024 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VCwtBMaI"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6832017C990
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772339; cv=none; b=C/AP7MErToXnRKTSDSPMP2T6Db98TMo4RqYc997raUsi+BnUANB5pts7xD8s4KMcX20RnaGcI5/llmKulXSCh4GecH0kGrhlXOlM1Xbe5ZykNoQw0wEe4I8eKW97jirHwbG3X2Z8tZ6vBn4kXq4cyMXoNB4wkHXcz+VaFWFHvOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772339; c=relaxed/simple;
	bh=n8ESl2FNmzgV2J4Gu+GXBLuTnzpMfyubm8vIAlksLz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tBbTC7+RfIzjCX27UfB6Gd/ZouEYUdlliWZLkaoXVc0+CqMvQIT8l6Up8GGwSLKzvzfxpsjX+LHwyVFeecylhuKtk06wQRp6dACTHH2S74ogG8Zh0KDfjH/WJaw1g5i70qWTC+MzseCP4wi5H8X2sAvxwjH39VRoHQD25jnLeYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VCwtBMaI; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6c2bc1d21so193270385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 11:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733772336; x=1734377136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42cU5HndT5BBlsrtO6ikMSsiagZ6GECUgrygXPNYYzM=;
        b=VCwtBMaIEtcZLSJ5GhjTDwfRKvtrAASRUt7liqs5t+EgdA94NFfjpxx6RxICVoXAyA
         LUWmM+XpJu0S1EMNT2pUI1FoUoZxmm+8Atlvz1EgJYCPCp19CgBo4iWXQU1LTVZ1K6xw
         xqu7T38ksx5lObjlDtodsuttPf9hhHMwVWixw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733772336; x=1734377136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42cU5HndT5BBlsrtO6ikMSsiagZ6GECUgrygXPNYYzM=;
        b=DDjwR28/UqPuPV6zCx7mHVhbYOimzWrWZ33rLuiXIuzKSmfVDh8l6OHJtLvEmsMXMe
         AmFQG2W46D1u0NQF03wARd85nSvZ5/AiL+18XTkJZox6G7wE4XTSl2M6q9ijps1LNuAt
         WT6Rk9tWQlKBPyub8z0wifUq5bqPq+BUx+2wgDtWPjrhZzjR7FKrO4SvluujZl+JMVwu
         G3Fe8YrE42S2GRCArVkB9u3MOOncCJH+DY1fSiO1jjCX3YgXpYIIsPmQj5AsgbDWCLmF
         O1dBvZKnfdVOHjRf3F0NFVgZkn+lU/iyE9bXa/PK9WSuQCpgow85XTUkCbRKJobC5P3U
         l2mg==
X-Forwarded-Encrypted: i=1; AJvYcCUtnh0PAAn7F8xOGyhK+uJfF96xqVzAQXzAU5XD+oFwIufedvA2s+gcoCmwn4tupcJHiotZcYA2HmSUyiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4UEqDRjVHQKE4cza1VouvuHYV3ZjCY/Bwl/BbfPNgqH3fxI+4
	Yddespm7kvFtrbQIqjXa+BE36V2VbUIsxMpXFD0wWM52lA/tyWOsMYoF7Y8e2A==
X-Gm-Gg: ASbGncv+TUxc6kXd4d+3i8RrnvygcV6DuqkOKOWxL4WVdmqOZllFGMm2r16+n8YIGBC
	Wbol45kJqCHg/QCzsT5Kjh1+cB4qh6ss2bg8hUXTc0f1u5jJf/pvpBrKP0xuRkXiFo5zTeuWEP1
	Pj+0UiqrEca8/zvHHCkcwOPf3beCLaP/yNLU2XJd7EFLHAM1mvSgGtkNymbeiiLrBvX3ZAzbfNA
	UuYJGiRELjAP2T1H1zeLwAVbTAWazPC1A+GQMPwazBM+be8/PdIu9X58Ns91c11xKvKIcBZuexm
	CFzltDV/ES9Wsjo53QMDKkYq
X-Google-Smtp-Source: AGHT+IEy6l30xGUpPrtDhWxzqtb+SOk5CYgv2g/6hAF9Khw34+20F7wqboI2TcspSBsyb30HCeEv+A==
X-Received: by 2002:a05:620a:261d:b0:7b6:cbe5:4072 with SMTP id af79cd13be357-7b6dcee4214mr257887485a.61.1733772336321;
        Mon, 09 Dec 2024 11:25:36 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6cc1cf6fesm217433385a.102.2024.12.09.11.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 11:25:35 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 09 Dec 2024 19:25:33 +0000
Subject: [PATCH 02/10] media: pvrusb2: Convert queryctrl to query_ext_ctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-queryctrl-v1-2-deff7acfcdcb@chromium.org>
References: <20241209-queryctrl-v1-0-deff7acfcdcb@chromium.org>
In-Reply-To: <20241209-queryctrl-v1-0-deff7acfcdcb@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Mike Isely <isely@pobox.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-staging@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The driver was missing support for query_ext_ctrl. Instead of adding a
new callback for it, replace the current implementation of queryctrl and
let the ioctl framework emulate the old function.

Most of the fields are identical, so the change is pretty simple.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
index d608b793fa84..7c8be6a0cf7c 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
@@ -497,8 +497,8 @@ static int pvr2_streamoff(struct file *file, void *priv, enum v4l2_buf_type i)
 	return pvr2_hdw_set_streaming(hdw, 0);
 }
 
-static int pvr2_queryctrl(struct file *file, void *priv,
-		struct v4l2_queryctrl *vc)
+static int pvr2_query_ext_ctrl(struct file *file, void *priv,
+			       struct v4l2_query_ext_ctrl *vc)
 {
 	struct pvr2_v4l2_fh *fh = file->private_data;
 	struct pvr2_hdw *hdw = fh->channel.mc_head->hdw;
@@ -521,13 +521,16 @@ static int pvr2_queryctrl(struct file *file, void *priv,
 	}
 
 	pvr2_trace(PVR2_TRACE_V4LIOCTL,
-			"QUERYCTRL id=0x%x mapping name=%s (%s)",
+			"QUERYEXTCTRL id=0x%x mapping name=%s (%s)",
 			vc->id, pvr2_ctrl_get_name(cptr),
 			pvr2_ctrl_get_desc(cptr));
 	strscpy(vc->name, pvr2_ctrl_get_desc(cptr), sizeof(vc->name));
 	vc->flags = pvr2_ctrl_get_v4lflags(cptr);
 	pvr2_ctrl_get_def(cptr, &val);
 	vc->default_value = val;
+	vc->nr_of_dims = 0;
+	vc->elems = 1;
+	vc->elem_size = 4;
 	switch (pvr2_ctrl_get_type(cptr)) {
 	case pvr2_ctl_enum:
 		vc->type = V4L2_CTRL_TYPE_MENU;
@@ -549,7 +552,7 @@ static int pvr2_queryctrl(struct file *file, void *priv,
 		break;
 	default:
 		pvr2_trace(PVR2_TRACE_V4LIOCTL,
-				"QUERYCTRL id=0x%x name=%s not mappable",
+				"QUERYEXTCTRL id=0x%x name=%s not mappable",
 				vc->id, pvr2_ctrl_get_name(cptr));
 		return -EINVAL;
 	}
@@ -812,7 +815,7 @@ static const struct v4l2_ioctl_ops pvr2_ioctl_ops = {
 	.vidioc_try_fmt_vid_cap		    = pvr2_try_fmt_vid_cap,
 	.vidioc_streamon		    = pvr2_streamon,
 	.vidioc_streamoff		    = pvr2_streamoff,
-	.vidioc_queryctrl		    = pvr2_queryctrl,
+	.vidioc_query_ext_ctrl		    = pvr2_query_ext_ctrl,
 	.vidioc_querymenu		    = pvr2_querymenu,
 	.vidioc_g_ctrl			    = pvr2_g_ctrl,
 	.vidioc_s_ctrl			    = pvr2_s_ctrl,

-- 
2.47.0.338.g60cca15819-goog


