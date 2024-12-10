Return-Path: <linux-kernel+bounces-439188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D34279EAC05
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637DD165A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C697E78F3B;
	Tue, 10 Dec 2024 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SxTnZMvX"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE03DABF7
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822935; cv=none; b=Kd/0oA8S7w2VQVaVBrgGXGUBvHB3/KSat3X2D0BT8xJFDGU7T9mf1xNWZmQvn1X9p72JSVGgCbguuhLQsFXb82MDK/v18W0Rfxp+Xtgl38F13QSfOcZVkU/hnrGN9Cfdpx5ekcZDMA2JX6WMlvaG5MzfGdmsePtZ8ickRWbeq/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822935; c=relaxed/simple;
	bh=n8ESl2FNmzgV2J4Gu+GXBLuTnzpMfyubm8vIAlksLz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P/mXmCE+l/hYoYrcNNIEoCNhBoRqJd3tJxWR7o25RuxMtsY0+nmBsyGQBWCI7zk6iPyYjcODYkvsI+xi++A/Ysg0v7Bj7I4Wv17xzEdGWufRh5pPUtK4HUU9AkLdqPc7N6BzdeN2GnyjqtkZd5VNDCeFpYZPU5ED8ALGinynh0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SxTnZMvX; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4674a649083so22371521cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733822932; x=1734427732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42cU5HndT5BBlsrtO6ikMSsiagZ6GECUgrygXPNYYzM=;
        b=SxTnZMvX8xgruBlCJAHo3R2iSJR/rFt8/xdCpRfr+4ZkBk+0Kcnue6wVp2QgSuTZPt
         g0Oal51JT0Wp/sQdsqLjPsikgq1gTy/GrYx9/KnhGR6A21o5+cGUWlhKwYnGv1/PObbU
         DbKVgP77kLZ7d89iJjCSR79N7MgLET26Zqd6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822932; x=1734427732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42cU5HndT5BBlsrtO6ikMSsiagZ6GECUgrygXPNYYzM=;
        b=LzKL8U8u6AQP8D7gyKEpDdrZKdsKSWwJybZuo0v3fP8rLIa0pPW78RJnRhDkCjcQf7
         9Vxn2Nv0jRk6ow6wuZy5Kp6lfYIyF2FSt7kcKU9qD2qUG3s5rfy/B+FcPn2IbFQnTZcg
         YkvnnISfte4iqhfu3ZkIVnSD4VhwcDEbKVnSa7YMBQiFzvT/TW1sE9JEP3EhE+rGCeAs
         QjkDV/2ShvEmN63zq+cOoBbrUkr3s2wtoEAfvZVVll744hlKDrob1fJzDnGTTmlyLQKX
         QNN7Xz6hHav6/20+Zy+mJOGubc/U7SBo21TDMG4XLgJvpr+uMAbf/ViO2TuiWIBaPcAI
         Go9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXF/+Yjoc82RQSQwcljNWXhHlqhJ3CbSRHTu5orA3VNC9nNweAIVnuqReYdUMoa/i3OpqGm7JkHE9ZKkXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOmXfO0NUcvLPAgNscqi+z0F3Xo3lWHqdpwdloEfB6E9n6fAyw
	/3YyMWl0XbbeGNsbPvvQI1V0plzkSjyIzdQW1Jn/cgruMUXvbmV2o3NLKBnFMg==
X-Gm-Gg: ASbGncsjPzKHT7pB6sghVCWLFiO5TPUN6rUdPXFsEnbXZdYrrDu7X86GFfkxfMsB6MI
	Za5b8PymnZGSfIMmL1F3MRDk7v+xtWBLco1FZylvW4ckozBgwWxpf6bhrN+r9ktb9ETEQ6vGlvr
	Uz6Bu8HENlAdiKOCFM04wfQn0nXEv+oHSWRfPqxD3+NROOwiknphPYCAUW0XtjD5zSybkCYszpk
	eNB7uVnCc1dW7p813bbkRI0fwGC4PhMN0zmOZlMCLdk4eufbnp22GzwtALxurSjgrBc5/QE0e28
	rjRWimuxM6Izig7spo4pP8NzRTLp
X-Google-Smtp-Source: AGHT+IEnoOn63V/B5cYU2djMibYmXdFhIdrVCbSMu3sxT5u6BPOOJNCg12HGpwhTcUzr8+E2oUFdNA==
X-Received: by 2002:ac8:59c5:0:b0:467:5e71:73f5 with SMTP id d75a77b69052e-46771ff47cbmr61831041cf.34.1733822932248;
        Tue, 10 Dec 2024 01:28:52 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4675dd86ce4sm24343241cf.30.2024.12.10.01.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:28:51 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:28:46 +0000
Subject: [PATCH v2 02/11] media: pvrusb2: Convert queryctrl to
 query_ext_ctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-queryctrl-v2-2-c0a33d69f416@chromium.org>
References: <20241210-queryctrl-v2-0-c0a33d69f416@chromium.org>
In-Reply-To: <20241210-queryctrl-v2-0-c0a33d69f416@chromium.org>
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


