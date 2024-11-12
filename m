Return-Path: <linux-kernel+bounces-406441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B219C5F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F65B28D29
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD279217F31;
	Tue, 12 Nov 2024 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EYkR0ynE"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420DA215F7F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432668; cv=none; b=dpGsybJU1mJ5JRYw7uQRWvTJjfSXwnyMuSv9d7DMCG3Br14GLn8j4Tn/zk656Wrb6/PPx7Td9UZTe28ckGP3TO0AZYtMSMLtbBW1HAO8LXi/LC8bmnqgB9lEb40ggxHjun4cZMY6u3D4ckRp4T8LKpYJui9/+pJI2TVcjBZdjGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432668; c=relaxed/simple;
	bh=aNTUZZhZyqVU9gy8l8yK7jgccZ+2XSUjodsCiy8OgCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CeV0ia6XfJCV6//g0smqpktydgr4CP7Fy8xbvE6oieQy/eqDY/l4GyOxGh1mUcBfDuryEomc+DwTH+ZSKnoivGGdFnBkDdrfUTmWCXMb1xdOydTiTFrLguACTn0KsnZN47iQI5CXstfBtneg2Z/+31uTprCHWU48o1/DOutaf50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EYkR0ynE; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b147a2ff04so444977285a.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731432666; x=1732037466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mtTXn3udpu62k3Atn4vt+FxsonuY7lt9lS81AKORGg=;
        b=EYkR0ynEli2+3e3OFpywcuIUZJ1YAnWx+QLl0GZI4lsqRKajq0YgXe+vP3VwX5qBzo
         fvAG/jxAwRuGzcscyuqZY5o0i6B0kPpsQRBKm7Yb79zkEpglOm91sm8rW7NCVxyxHyGp
         mNRRyOVpBBkvbB508eQw46kYcGoMPThGMqqr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731432666; x=1732037466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mtTXn3udpu62k3Atn4vt+FxsonuY7lt9lS81AKORGg=;
        b=bcvZmIBpVTQNVVL3aCZxC2cyd8pWI/cuQ7zFo9ow4C8t2z2W3P+hUVuCST3FXPkRx9
         E3APy5/5rIKrBdSOrmQxbXv6fgRAVHaBq3gEkFIcFg9RUZGKiUgWom5Y6EnFisiim7aF
         O348QSgvlVI52E/NWXUWvVzvh3gDW+30v37g+pqkduXDQ2YQMxDi2HWi/IDf/OZVJxth
         yhQhC96R7xdcYPlJ0h7QHzaRnvERL7RNakju+YxsUJFm2DzuVtCtx8cNFNMoyhOCzjF8
         5zXm7AySCdpMISkC1PL+pd9g8lN3/smmXeu3QhsHnE+eC6qKyY0mmCWOjdKvAt+joBtN
         O/WA==
X-Gm-Message-State: AOJu0Ywdo8Uvmnfcty2hkLbvhnTHzvzdlbGgztAnYGDHwPuV4TATQbKD
	oc9pGCd5c0IxdqFSmRmhQ0QBUnyvd0q0PBt4dZgA55+/DlyitLmFuOzIZo+BoTyfln+x1ZbR5uE
	=
X-Google-Smtp-Source: AGHT+IE6DeF9yyQEoLuMSjlzOxCp8Mz1HxU1DGwfXvz8Qk3lJu0bxx+avH9OkExkGfDmegsKe4Wd4Q==
X-Received: by 2002:a05:620a:290f:b0:7a9:b2dc:99a6 with SMTP id af79cd13be357-7b331eb6d20mr2147972285a.24.1731432665768;
        Tue, 12 Nov 2024 09:31:05 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac2dcebsm608292285a.7.2024.11.12.09.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:31:05 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 12 Nov 2024 17:30:48 +0000
Subject: [PATCH v3 5/8] media: uvcvideo: Create ancillary link for GPIO
 subdevice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-uvc-subdev-v3-5-0ea573d41a18@chromium.org>
References: <20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org>
In-Reply-To: <20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Hans de Goede <hdegoede@redhat.com>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Make an ancillary lik between the streaming subdev and the GPIO subdev.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_entity.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
index c1b69f9eaa56..7b8fb85d8c03 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -53,6 +53,17 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
 			return ret;
 	}
 
+	/* Create ancillary link for the GPIO. */
+	if (chain->dev->gpio_unit &&
+	    UVC_ENTITY_TYPE(entity) == UVC_ITT_CAMERA) {
+		struct media_link *link;
+
+		link = media_create_ancillary_link(sink,
+						   &chain->dev->gpio_unit->subdev.entity);
+		if (IS_ERR(link))
+			return PTR_ERR(link);
+	}
+
 	return 0;
 }
 

-- 
2.47.0.277.g8800431eea-goog


