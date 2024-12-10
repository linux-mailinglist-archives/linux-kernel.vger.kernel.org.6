Return-Path: <linux-kernel+bounces-439191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0669EAC0E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E884F28D5EB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DCC2080C6;
	Tue, 10 Dec 2024 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yx1G88Bl"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFC81DC998
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822940; cv=none; b=WQbkZWusQtBon9lUXHGORUQ2sOFiRTFlg36W18l2nKAGCFHao6YA4SSqR00jCrkww4SsQljleDeJVzlipn+fFnZ7vV+620ohfylboCU50xXg0shDh1NEIb7WqBiawwGfgt9RzEvN6onpIYBl172xtszNJo1oaxxRXLQtgXkIF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822940; c=relaxed/simple;
	bh=ctL5AnJGV5DJC9CXkrWVL7zWfndzHWXxxUlRLsEsOfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=go4X65v6GU04bqGtDBId351l8ewHIXNxXnEEkEnTQNHTo5ivL+/6UOPqZri0mBzAgoDvB7jXo1Ldu0AEb/bWp4jXpuc1lB2cLxxyS0785m/4FVpMpcsVxxAXLPcOn/7aPEsRcFOs5wd1/7j7ILi6kuvnRmsTIjxynKp2r0j2hno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Yx1G88Bl; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467540980c9so31312011cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733822937; x=1734427737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6+2CPj9NTbpQOo8ueUbGM8wqslpqQFkOdhDSPG4NAo=;
        b=Yx1G88BlOsFZXeZaeSr4+qTi6TLPnSqodP55Tf/fizkfz2AeROlAMrfNFuEcsO/UDD
         eJ05o4/rQakXKP7jOeapYkr6fEgA7kt1gXE0541yeaMr5zqX8jmbu+2yxevTDShahfsC
         xGcXR72Qgv5mqq2W8kpx5zm6y+S+kB0uM2lyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822937; x=1734427737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6+2CPj9NTbpQOo8ueUbGM8wqslpqQFkOdhDSPG4NAo=;
        b=wsjyTUy9f2zKKUEUtLnWAWZGB2IGoY8aiBAZ/p6SP48Yofgrz2FoR6zeY5Z49UOACC
         eTtcXJ4QkoPyCrpx6WLN365WF6xQO686G+xODVZ5zfq/aqU1TFAk/n6kT2dp4hUlJVWW
         ESp7dmp1yPtuPoR/aq35bm4prKlpY23N2J5Stz4zSWvbOmql2aCia4gqsWSV4TV9wB2j
         hJx6CY79/vRVlB1Lp5RUSnWQsKMwBmzEyh+du6w6FCvSrtxo9aP8h/hXdWH+MO50w6Rd
         /a11XTQvysg415KpBeNOzA5aJLD8QGt3hxjNaA/dmAj90Sf/xtrBnQ5AAinnhAQdcAJn
         ndKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpwjL0nBaIDcTAofSE7COY54Gi8Pl0zQ0ZoSN51/tiJSP8cHxKnlBkxA6Y7YYwIGlGgI/p6t18/55lYqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTrquOeNa5T0k5Z/x/BiPZH6LodLoABXJBgsu0AeOXXjHMHCQG
	aUQ2Pz4tOZI2K3cEST4lxm0wRnXPKC/ktUIgyJH/ecToVQ8GpVIP2ZYBdc8sQw==
X-Gm-Gg: ASbGncv3d0SaSQgB0lKTfqCDeNjud9rvOt0sycYO1yIG9c+h/vxZ/oBK6ST8fH0ekv6
	9vbtTOSistoJsCiQ3MbqlwU8AQOSTMBwThJRTtUjpeEyxgF4dfv4FkwlH4HVZ/BzZ5ZPVaWablT
	gxv3+66bYKXOzCxgi8Fty+qRNP0pKm1p4kxbVrD6ex6c1x0sP/L3bO8CGdaEEzd5z/bEMwO0BNN
	7celLdXW4u/2cT272J4Un/PTz/vNYcLOkktJcS0xM4vLbAgcuPqkER26EcwkgzmamZGgt3/I1ai
	4/oTfI6Zky1Gpqwc3CaPqa9IOeo5
X-Google-Smtp-Source: AGHT+IE8b0PM7gKALz88Rd23P5sKAeyq0cPFEHzTFCgEulkAqAHRhkOVnMDbHAXt7ijPFaIS17Apgg==
X-Received: by 2002:ac8:5fc6:0:b0:467:774b:f04b with SMTP id d75a77b69052e-467774bf44cmr28726901cf.22.1733822937679;
        Tue, 10 Dec 2024 01:28:57 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4675dd86ce4sm24343241cf.30.2024.12.10.01.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:28:56 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:28:49 +0000
Subject: [PATCH v2 05/11] media: atomisp: Replace queryctrl with
 query_ext_ctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-queryctrl-v2-5-c0a33d69f416@chromium.org>
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

The ioctl framework provides an emulator of queryctrl using
query_ext_ctrl.
Replace our implementation of queryctrl to support both.

Now that we are at it:
- Add comment about missing functionality.
- Remove superfluous clear of reserved[0].
- Remove ret var.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c | 33 ++++++++++++-----------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index 1a960a01854f..6b84bd8e6cf3 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -34,7 +34,7 @@ static const char *CARD = "ATOM ISP";	/* max size 31 */
  * FIXME: ISP should not know beforehand all CIDs supported by sensor.
  * Instead, it needs to propagate to sensor unknown CIDs.
  */
-static struct v4l2_queryctrl ci_v4l2_controls[] = {
+static struct v4l2_query_ext_ctrl ci_v4l2_controls[] = {
 	{
 		.id = V4L2_CID_AUTO_WHITE_BALANCE,
 		.type = V4L2_CTRL_TYPE_BOOLEAN,
@@ -1140,31 +1140,34 @@ static int atomisp_s_ctrl(struct file *file, void *fh,
 
 /*
  * To query the attributes of a control.
- * applications set the id field of a struct v4l2_queryctrl and call the
+ * applications set the id field of a struct v4l2_query_ext_ctrl and call the
  * this ioctl with a pointer to this structure. The driver fills
  * the rest of the structure.
  */
-static int atomisp_queryctl(struct file *file, void *fh,
-			    struct v4l2_queryctrl *qc)
+static int atomisp_query_ext_ctrl(struct file *file, void *fh,
+				  struct v4l2_query_ext_ctrl *qc)
 {
-	int i, ret = -EINVAL;
+	int i;
 
+	/* TODO: implement V4L2_CTRL_FLAG_NEXT_CTRL */
 	if (qc->id & V4L2_CTRL_FLAG_NEXT_CTRL)
-		return ret;
+		return -EINVAL;
 
 	for (i = 0; i < ctrls_num; i++) {
 		if (ci_v4l2_controls[i].id == qc->id) {
-			memcpy(qc, &ci_v4l2_controls[i],
-			       sizeof(struct v4l2_queryctrl));
-			qc->reserved[0] = 0;
-			ret = 0;
-			break;
+			*qc = ci_v4l2_controls[i];
+			qc->elems = 1;
+			qc->elem_size = 4;
+			return 0;
 		}
 	}
-	if (ret != 0)
-		qc->flags = V4L2_CTRL_FLAG_DISABLED;
 
-	return ret;
+	/*
+	 * This is probably not needed, but this flag has been set for
+	 * many kernel versions. Leave it to avoid breaking any apps.
+	 */
+	qc->flags = V4L2_CTRL_FLAG_DISABLED;
+	return -EINVAL;
 }
 
 static int atomisp_camera_g_ext_ctrls(struct file *file, void *fh,
@@ -1561,7 +1564,7 @@ const struct v4l2_ioctl_ops atomisp_ioctl_ops = {
 	.vidioc_enum_input = atomisp_enum_input,
 	.vidioc_g_input = atomisp_g_input,
 	.vidioc_s_input = atomisp_s_input,
-	.vidioc_queryctrl = atomisp_queryctl,
+	.vidioc_query_ext_ctrl = atomisp_query_ext_ctrl,
 	.vidioc_s_ctrl = atomisp_s_ctrl,
 	.vidioc_g_ctrl = atomisp_g_ctrl,
 	.vidioc_s_ext_ctrls = atomisp_s_ext_ctrls,

-- 
2.47.0.338.g60cca15819-goog


