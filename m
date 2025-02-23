Return-Path: <linux-kernel+bounces-527905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456AFA41127
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2931C173697
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7551B20C01B;
	Sun, 23 Feb 2025 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q4a8Lvhg"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DA41C862C
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740337167; cv=none; b=fTJONOs9xlc1uhcnVxUm/OQV4numxEPi2NRFzrgCCzZ5UVQasO2ti0ttWIDl1/O5EwNTbFRnEZkqkIujcsopfZH4K8MGuzdUJzqKcfM46Zp351y492d/dELR8B0XLBs4K9ImDTDIc6a0zAfleM73jm1XexGFdlenX3F0FsbniHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740337167; c=relaxed/simple;
	bh=dOYR+rU45ZTedZeI7JX0raU+lCcGXk5RD8f4I9wTnUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nQ43bZ/5VTfADEKOCXx1KgYHCh0HAsW0DVVKym17pMZ5IXaBk+lJbnwWapx5cXT5dyyaWysU8IWKAWbe3VF3zB94wD2BuHJFBV+TBJSr3HXyU9NG+Vqjn+/O8eA3Z7yyp6QujcLD23CdwtAcNLnAteYRlhF1eSrtVWJnVbOQdTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q4a8Lvhg; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7be8f281714so467359085a.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740337165; x=1740941965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJWyEAap1+WfidHk2zAGjrE4DT6kHcz4NCpxCTH1+J0=;
        b=Q4a8LvhgAGDD3w+L3oYRKQMVnHMN9QXblFGINkt0/SXZBQJnUGEfSjl03qTzkUDzY9
         QDYRiCysasnAxjiV+8hPgIouzhOwCGPPv6Vfqdkge4wKNIy4n73CbpLw432UccgrrCeP
         gvDHZU72we0yKXXBlkbWUkDWgijltPslmkNQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740337165; x=1740941965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJWyEAap1+WfidHk2zAGjrE4DT6kHcz4NCpxCTH1+J0=;
        b=OKVuYoHf6TLoSl7FMEI1pmRXY3/F3O6w7Wfsi+3Kg7I+tEn57jVb0gzFzGk14NjLMk
         tm6gubrtPH7lq08FvWciqtWsV1AACShaS+bS0Y5y+q3kkwnJ3Cv7KFf0LnLgZFnpZpwz
         BlauL9UFoVhZBZIHzrnBnwvxdk5x8a585LGWRwNbb8xQsweugAuOx3+io7sZOlxE4tbz
         JZm8hkvrmI7M/mXhvBT8g2YssrI4oD8koerq2WOtVirfsjBFOsqHNiIDXi7K5osV1bvj
         TbZOwc/YRJij2yzdJfcY4dYMZ8/Tc3ez7O/OAsLn3ksMNqwULQIBeG/7yivg4OgFJ+1g
         TVpw==
X-Forwarded-Encrypted: i=1; AJvYcCWTLUHaik2JrOEpFRvZakGMoL/9uYKp0PxWSwYy8dNpZVhD0wgyZf0r/pO5MWKS5XVPd30puRVhKmzqN8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi++qH+5qR+vhgGRnPfCzUNc5rJhfugeGKCKkYnxC7Q9SdqQW4
	zmtkqFg0ixSAAqKuWKz4PogO50zLjZ49tzY+F+/48/P7XwJ9rZGO2M1aD/Hoxw==
X-Gm-Gg: ASbGncs9g7yI1Spjzgfymp9QeQ3qFNLie8Y4vIr1rNlZys74C3mrOWYDvbjitHSkYH9
	mMZ1nk75KI1qunvCzF315x3hdnmxEJPSX5f+xfDsUlc/f+4X44t9Qt3XDRNpVvgZCWcNW6NePnG
	AzKIlA0JU4fC0yipJjQqC68U/PWd3I1+yWW77i6ggCdmkpwd5UNO+52XgjgJ+6PkmYUYMhPKr3j
	0U7Lqdv/UOVfbawMop6tbA4nfUmQU9RFNETcJ+iJJ0GF/MbzQ1MX7DPepmWKPK+9b/i3Kg4rqdV
	fldaMeG9kkD2dG42o6hNQWDAU6geM5v0axOMFZEFD1TcCB9JxWQHJUTp0ocguLlO0qbAyGt+VS3
	jmmE=
X-Google-Smtp-Source: AGHT+IFYqDOGgV28QPyX8iJ9ppiO1sSvPVW9QWBsd+01pbtAkqxHgdzjOQyBpkU8O/OVREpVDay7zA==
X-Received: by 2002:a05:620a:1786:b0:7c0:c2ac:c087 with SMTP id af79cd13be357-7c0ceefa3f1mr1372556685a.19.1740337164924;
        Sun, 23 Feb 2025 10:59:24 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bf81253sm894052885a.47.2025.02.23.10.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 10:59:23 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 23 Feb 2025 18:58:05 +0000
Subject: [PATCH v3 02/12] media: pvrusb2: Convert queryctrl to
 query_ext_ctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-queryctrl-v3-2-4292911cab6b@chromium.org>
References: <20250223-queryctrl-v3-0-4292911cab6b@chromium.org>
In-Reply-To: <20250223-queryctrl-v3-0-4292911cab6b@chromium.org>
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
2.48.1.601.g30ceb7b040-goog


