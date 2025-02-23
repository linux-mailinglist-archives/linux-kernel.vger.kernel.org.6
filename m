Return-Path: <linux-kernel+bounces-527908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2957BA41131
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A88987AAE42
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20D920D51E;
	Sun, 23 Feb 2025 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bkMaNGH+"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF8420D4E8
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740337174; cv=none; b=XV9abHj8noEsn7GcE6t0LgZpTKCwP2X3RMsxu9tiI9f3PhExXIqOp5apPCQghTyVmiubpey+YpZCkKmu8Inoux9+fcOx2rcWal3IIrnrjJCT0ATPjavVQ1a4lOG5k3cuDiJew1cFLLBEC+yXrcT4dyPUHTLQw7rWD32EmFVH/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740337174; c=relaxed/simple;
	bh=+FQk73Re7Vj5uP8e4zt7dSl+Ft1aZSIU+rolZ0DzE5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GWpsABtCpLB/N56Uzz2OaW1rvXjt4G/3M7tU7mHcMPuH8Al1140jtZkE4GLGeM1n2vq6SrnMzRbEXn+NULZjqc/K7ATyEEftqwqUWCYU6wccaoms5GlxAzv4ksn4x/2GpyngO3EbgfOVZBK+ogKmq78aKvBC/f+CXxc0hVaGFX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bkMaNGH+; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0bb7328fbso390502685a.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740337171; x=1740941971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8IZ/POm13BMEX8p04+c3Nhi5+imiB9PsNNFLrPKcpkU=;
        b=bkMaNGH+TWmaiA27q/9/D2BTliMN6XtOlLEzbZXC9WEqOgg18K4dJFtDQCTnbLe4vV
         nDYI0VzYpEpk/3QSiyFRUfM2nsjqmYnkLFp0nZIvf/pWsPjrfY35XdCOocqfwfc5g4Kc
         hJe9HJvYWoVL9ac48R4hQaqDtn/glaouj/akY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740337171; x=1740941971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IZ/POm13BMEX8p04+c3Nhi5+imiB9PsNNFLrPKcpkU=;
        b=s9ZQ4EzB5cYuqG40M/oNfgp/9CK87plUe14kXsI2pNEow277PWDW66G1nXIi2LzApR
         2hwEj7CIoLUTbbBGxuj7a/n+BaG7ZgTWlIqGn+b/NPrhvtA3Bfv9upC632rGxg/wzjw5
         HJ2G38rn9sf12JKj5Ycktd/OtUsKZZQLVbraDvI2O7UwuQ2Ayu3uYp2iifOQfkOlYbSB
         jOo7yJRm56p/sMJRg9CIhynm1jE3YJz1SkSovU3g0HPnIk8Io4jZy4gdVSnnFzBc4cTh
         skLD6he2ho/3O7Nav+f6rdNhsmJkSeTRz4kimqVLhKkQXj8rR1EKeg3rhbC4c5b9XerR
         2M5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5MMYK3giQhjafdsJxljlDqlf2iIa1VwNtaPKylqaL7rzcIcZ+pL28GpXnqVZexSxBHqZFyUDnE3Qq/oI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+8rteg7nhRFjooR3QQrhsjPBnR2NWayQ5dBWGq07B/0AhZ2Vd
	d1M+HidoN/+/dIEP7EgsAVAUCNry04pZIbJmUk5sDGrEwcRgHLSbqdGIYGLawQ==
X-Gm-Gg: ASbGncuPcccivqST5icUCAE6w8g3/qDqslk/tCH69IFLOhCXO0L0Jx89IhHt9u6cflP
	415zjJpNlimuVQQyEwN833EjGBI7+R/dLVbrEScy3pvH5Ni7ShJ+5283ina05MbnLilqwAbSbw5
	+dbmqMNuTecldPGJvJ/kTDZEcUBgnT8SB+CfjkLkdvUEdduytnzgsL/RIorwWEFoDDb6E6wK8z7
	4GS6IikB8QIGUi1JFri8o1MZlFTelZRgAXFsaI+5RVoydQbjT2InlfHkFX9ueRTUGYxM06qKTXo
	JO/DwGI+O9SXiJKX+MTVfWFARRNvWgmctaB+CpEDKvrLNVjKQsllMaDUOKoBcKUs4C0Pqmyr7RI
	szds=
X-Google-Smtp-Source: AGHT+IFfEI9iYEbJVGs23xVGmjulSbd3/xfIZiF/IMBZDKee+F4TF5guUHDs7mH9mdkDy3gDc+h3Sw==
X-Received: by 2002:a05:620a:4688:b0:7c0:c15c:1177 with SMTP id af79cd13be357-7c0cef10115mr1616776085a.30.1740337171454;
        Sun, 23 Feb 2025 10:59:31 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bf81253sm894052885a.47.2025.02.23.10.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 10:59:30 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 23 Feb 2025 18:58:08 +0000
Subject: [PATCH v3 05/12] media: atomisp: Replace queryctrl with
 query_ext_ctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-queryctrl-v3-5-4292911cab6b@chromium.org>
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
2.48.1.601.g30ceb7b040-goog


