Return-Path: <linux-kernel+bounces-409823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B89CC9C9234
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66594B28337
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B501AC882;
	Thu, 14 Nov 2024 19:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ab3VSkGU"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA471A9B4F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731611453; cv=none; b=pnbVSbaNIh+GQvjC8U6Vzow90DIB7vWz6Qk6LSdS5msR6SK3ofD1/wePrjuXBszCS24t3cAytANQT5cRAwQjuPklWdxBFuMzVPzL27UVkhHFaP+xh4/cdyQmOrZspd4HAASeLaABOcyn6bW/fmrTg0NVudoZji3yUzm3j/snE8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731611453; c=relaxed/simple;
	bh=rPQhRflph/OInqLTKMInrEsUWj88dYYh+206vtmsiRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rsRYOLIGkx9Dl4CwWhneLdB073Kqu9CE1C92/uNE2bvCFEmRhlT1QjhWNBaWCwXBPczjNCE3ojI0vR4yaD6pCTos6r8lcchjsiDuhZrukhCIRfJP1C6wU+tD5J6nWO3EsnKn9pRXTV9c2ybvIZ+eSJbMZ4FMUCQpcJtfjpv9610=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ab3VSkGU; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d3f3cc0585so4779466d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731611450; x=1732216250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pH1OuQ5/XwP0NAJGYmmTzFwWtNbM3f5Um97UBRgql50=;
        b=ab3VSkGUm3iJRXFp1KRbrezr7zk52+k68rw9vHTgPmR2Gni5OPfY1vcE0T+hsOTYna
         fJTDnSY++el4Pvs6+5XSPbGSUOOmJ+G/rmfyn11LjOz+r7a6dqEy0iBNYSRuGzhqzcmq
         qejw3zByGrFr23waC5XaABSh3r7lbzoJKGP8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731611450; x=1732216250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pH1OuQ5/XwP0NAJGYmmTzFwWtNbM3f5Um97UBRgql50=;
        b=Jt8oIVrbYgj78h6QpMuODdL9zy4GdoPYyYo+0Q6ysUAp0Y/eViePFHMiLQ/LeX2QKe
         fSMjvxayToF9wzVo5iweD4gLvPA0HLai7/+MEHjPOdr9jvDIw2VYCOeKKhqtCOQQJdW4
         +5yu+YcyCqVAiKFBs/h/wY+6FaLuPKNCLDf/ioLO4GUh/zNhbHPsAo1SJ30X+nYrnTiB
         5nNHGu+lbhgTgleti51yUejPEB673trf6EaTEy6rkKyUkarvg59XRPIbaD9dQidDMfDp
         Kd5V+UiN5pznXhThEFqhCv4UBaL58VFrq4Xn1ZVWlIT0/jqT773HlgsQB2s2yy0z2XPQ
         Mn2g==
X-Forwarded-Encrypted: i=1; AJvYcCU8BlurClMT+M7KnIcXzlHSZ5ZYaOgdiK0EB+qhhCuZSJzUv31UUF8vty7sdjREzr9vSsZuUy1QWno2Zlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPLiNrF2WbyoRczMktTwR430VkMViyOJsEYF5ESbR/OBUM3iWp
	7k/FCcuYrRClwMcpFDEb0bK+jvViHL8t679FVIq0shwMG/9I1pk7QliFe2x4wQ==
X-Google-Smtp-Source: AGHT+IFTGsrShBjgM848OqL1CfPKk91R3Op/+31v6HbDQXfgIAqpr7uyzdwQGXGarOa1YbiIhfrByw==
X-Received: by 2002:a05:6214:4347:b0:6ce:266a:85d5 with SMTP id 6a1803df08f44-6d39e14f151mr369822306d6.20.1731611450688;
        Thu, 14 Nov 2024 11:10:50 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee7cc7e1sm8857766d6.53.2024.11.14.11.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:10:50 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 14 Nov 2024 19:10:35 +0000
Subject: [PATCH v15 06/19] media: uvcvideo: Handle uvc menu translation
 inside uvc_set_le_value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-uvc-roi-v15-6-64cfeb56b6f8@chromium.org>
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
In-Reply-To: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, Ricardo Ribalda <ribalda@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Be consistent with uvc_get_le_value() and do the menu translation there.

Note that in this case, the refactor does not provide much... but
consistency is a nice feature.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 77f7058ec966..c975e0ab479b 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -939,6 +939,8 @@ static void uvc_set_le_value(struct uvc_control_mapping *mapping,
 	int offset = mapping->offset;
 	u8 mask;
 
+	if (mapping->v4l2_type == V4L2_CTRL_TYPE_MENU)
+		value = uvc_mapping_get_menu_value(mapping, value);
 	/*
 	 * According to the v4l2 spec, writing any value to a button control
 	 * should result in the action belonging to the button control being
@@ -1988,23 +1990,23 @@ int uvc_ctrl_set(struct uvc_fh *handle,
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


