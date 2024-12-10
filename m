Return-Path: <linux-kernel+bounces-439253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD909EACC0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50E728C0E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358F32153FA;
	Tue, 10 Dec 2024 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PLz7bCwU"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3D878F4E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823778; cv=none; b=izJV6YsxDIjNh/altvP65JBYcaQRnwfx2NbBzvPhJ5a7IEWviOyrZy5SvXq3YnunGMBICH3rMh247Z1q4F85mCnSM0hpUZ4D5DnVzWwpt9FI3F24bhWGtPUqqgTA8B9FT2wpVm34KDUGdfR15WeWAkUNjkhfFXvE8cA7B+CBHYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823778; c=relaxed/simple;
	bh=u449lsO4Hxwuzsi+uevB0tOEaOX42zxpyNVYt6QiE+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pjGRvWgJmc9wkv+tGRguZENpTblghnokdC31M97r3rm1pKtHyyBziXulk1vvAwTKFhVal/jS7dLT/R1rl7v/6+1rJoVFxpmoJ7xIX+boysrOpgLu8usisc1zR+/iRt/fJwOq5/KUw0zPalOcN20Q5dALdBHtnjX4ldaJpK3aYAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PLz7bCwU; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46774573043so11779461cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733823776; x=1734428576; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWfbsZInLShg4gyqs0rpMPp74K9ThJEcDiTxSB3xYgo=;
        b=PLz7bCwUPOjzxNjoeP4Zhx6RcnEpz6azTb0zg1/H5aVLr5fPrUKaZbzYNebuPZQrmO
         /AtSsiJY7cUyiCcvMXyR0aG/m9OoQ7PHBiyMOQcsDsvCdaKgF/+qiAdbmDJG9466jo5Z
         7Gft6p6Y5qQHem+zOsHlvz9CzAuiqG7kb39xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823776; x=1734428576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWfbsZInLShg4gyqs0rpMPp74K9ThJEcDiTxSB3xYgo=;
        b=F75Pl8DK7sKCW5zR+/gFnjR0zVtZgDz+oCEZS6Vpanh/Uhd4q8/j5Myqx1rp86tO+T
         /UJugM0IRI1Qj5k4S4leXB9QvtEn8iXen1u+4cqsW0zfhklFpeWKvpGAUmjJjOUMqt8+
         rHl1AIHYvXlgCLt2PL/HjWRXPNyoIW5RPyYasakHgLMQb1MQrgFl4zr7+Ynoe6HOvOJu
         xPTTch3g32pJbe360TaEpADN3pFXSz2RkWWXov/FfiYP7QXR8wrFowZCCWmxWdVmpTXa
         8Vi97681p8i1TipDw1DfrJzkyjPZmJZytARjfiN2KHJ9jMHWXML61cq0mHdArGtGYgli
         wZjw==
X-Forwarded-Encrypted: i=1; AJvYcCVCkEFJJh3q0B9MGles6Yq/Q1gyWKPNnMOr79u/k6iIyOmB5IfUh1UOBxo+E7yn6cDCE52ePD9DRtIFqzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm7/bcJPYYNKdyPu0oMSRUTXpT0kG1UYSgSszwU5ez9oPx45/m
	bt6yc5VZJMrrRg+0nvWrEzfoVmtBAJIg1Ivaur9cK1Wes6/r8dg0xw6p7dGmOA==
X-Gm-Gg: ASbGncscM4GZhZCrIBHk6fV3Q4fBYmrcnMjcsIWIjojkCZfh3NcjhqV+Ia+PCYeNu9o
	6MPI71Ue/QLvJdrqEKfTZKgXjf/K+PqE0qXM7gq0VSmaWZxpB+NgYiQmH+lUmKYApUSkQ/B9ZrG
	GzldvENeFrh+kMv4V3biUnf9MEDO1HDvqgC4rbCz7h7IbrTiT84smyevzMOFQfQFHdpnK1Hvhv5
	mInDcsM73C6/NNh3kRk3y4LuxgRcjD6waWQ7pDI7XdPi2ARwP+4LNZWr3i3C+YOY45NldiyvEfu
	20Rx84MiZAx5MamrVZR0dt94q+dY
X-Google-Smtp-Source: AGHT+IGuOmp0WbqkpDp2dV3LPmaXUEWbDVLaY4faBYplusjjW5QMSEy+Ggl5P5GPgFHXeQMWUS+EDg==
X-Received: by 2002:a05:6214:5087:b0:6d8:8d16:7cf3 with SMTP id 6a1803df08f44-6d91e43ce55mr65152556d6.40.1733823775842;
        Tue, 10 Dec 2024 01:42:55 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d92f7c2bc1sm773326d6.83.2024.12.10.01.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:42:54 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:42:42 +0000
Subject: [PATCH v16 06/18] media: uvcvideo: Handle uvc menu translation
 inside uvc_set_le_value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-uvc-roi-v16-6-e8201f7e8e57@chromium.org>
References: <20241210-uvc-roi-v16-0-e8201f7e8e57@chromium.org>
In-Reply-To: <20241210-uvc-roi-v16-0-e8201f7e8e57@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 Yunke Cao <yunkec@google.com>
X-Mailer: b4 0.13.0

Be consistent with uvc_get_le_value() and do the menu translation there.

Note that in this case, the refactor does not provide much... but
consistency is a nice feature.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Yunke Cao <yunkec@google.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 77f7058ec966..987a9700bed9 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -939,14 +939,22 @@ static void uvc_set_le_value(struct uvc_control_mapping *mapping,
 	int offset = mapping->offset;
 	u8 mask;
 
-	/*
-	 * According to the v4l2 spec, writing any value to a button control
-	 * should result in the action belonging to the button control being
-	 * triggered. UVC devices however want to see a 1 written -> override
-	 * value.
-	 */
-	if (mapping->v4l2_type == V4L2_CTRL_TYPE_BUTTON)
+	switch (mapping->v4l2_type) {
+	case V4L2_CTRL_TYPE_MENU:
+		value = uvc_mapping_get_menu_value(mapping, value);
+		break;
+	case V4L2_CTRL_TYPE_BUTTON:
+		/*
+		 * According to the v4l2 spec, writing any value to a button
+		 * control should result in the action belonging to the button
+		 * control being triggered. UVC devices however want to see a 1
+		 * written -> override value.
+		 */
 		value = -1;
+		break;
+	default:
+		break;
+	}
 
 	data += offset / 8;
 	offset &= 7;
@@ -1988,23 +1996,23 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 		if (!test_bit(xctrl->value, &mapping->menu_mask))
 			return -EINVAL;
 
-		value = uvc_mapping_get_menu_value(mapping, xctrl->value);
-
 		/*
 		 * Valid menu indices are reported by the GET_RES request for
 		 * UVC controls that support it.
 		 */
 		if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK) {
+			int val = uvc_mapping_get_menu_value(mapping,
+							     xctrl->value);
 			if (!ctrl->cached) {
 				ret = uvc_ctrl_populate_cache(chain, ctrl);
 				if (ret < 0)
 					return ret;
 			}
 
-			if (!(uvc_get_ctrl_bitmap(ctrl, mapping) & value))
+			if (!(uvc_get_ctrl_bitmap(ctrl, mapping) & val))
 				return -EINVAL;
 		}
-
+		value = xctrl->value;
 		break;
 
 	default:

-- 
2.47.0.338.g60cca15819-goog


