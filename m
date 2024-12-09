Return-Path: <linux-kernel+bounces-438297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34A49E9F7B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB6F166748
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200F719ABD4;
	Mon,  9 Dec 2024 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j3J9HS76"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061911990AF
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772340; cv=none; b=asNAJnpaYfOVJQejqhwbTC1dynaK0KxOgD0r9IbvjHgmJ45+M3ziNUzz1V9sYQcutWWH8WRfKrH+7dmBiuAlvOCKNs+LzouKi1YhZ1YTgOH9KguFlVnDnB+d28zJYvpdcq4yAvoEgnGtgebR8x90Zo5aX0eEyNFesXJz6Y05YaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772340; c=relaxed/simple;
	bh=64tvBdAJsYjij/MYhZgHmQi1NAwPb0Ws3Nyiuj2wFEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nV2sn49wsX4+5BFL623aeMH+g4gcSnvzTOE0u22n/7qgkjB2fGFxFMKXxsP7hyN18v0FrArHuDJhVHy5Z8Unge/YLbdwEiMX5bhr1Zd2Y2eHYdrX8/bmzPtvefPM5LC22aMETqoGc/DjTIuS1AV87Y1HOBpzoCWQB4aHFEvLEwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j3J9HS76; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6d6fe8b16so98083785a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 11:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733772338; x=1734377138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjvmPnf8Z5eA5SFOWcK4xqjLhjw4Qhz4HdUq4wZg+ks=;
        b=j3J9HS768c3Ch4LlgB/MDrznPR/pg595aotX7TfjwmFVjR2ac+VnuiBAncyLub2zLG
         BaxyEfzr964Oqis7d9iVfNPFHXtOFrTJcjewHVoTw6oVM4mgJ4RtoSsRCn5PuloKELrV
         ZYNrVK2dwz/fY5T1ncqf+dibKvgdxbIJzbfrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733772338; x=1734377138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjvmPnf8Z5eA5SFOWcK4xqjLhjw4Qhz4HdUq4wZg+ks=;
        b=kD3e/20Nb0s6pNf1AtXs1sphJIPvwfMJz3eEQCx24kKhOZ8jXHHjn6/xOW9+DsPX80
         nD+1oUiBTeTDflurDgwT6Fbu+VdDxv7JiW9nfuZPnRnnH+eLurYAMHorQRT0Ws4lJUqS
         1w/vg0Qmg7PMRqo+oJ8Sw2sckBRjXn4pUibpimEtWGG78v1qx59s830AzGZkbK6wKrIe
         vIM7MIUUriRE7rSRU5A0nVgdKlg8AR0hzPcgPYh/+Q04g7WB7B7QRlRG8f/IXhz9LEDD
         tVhcRyeXvrArUTTIjBuTUSe34WXh2PS34CrD3+L9HUtfbW3MiUftZOD7HDRchu56fwhf
         wF/A==
X-Forwarded-Encrypted: i=1; AJvYcCXkd7nc1NbLqReqXYNAB4rCUp6b9ubPgp56eeUiWrgF1wlhDN76LOvr/Tef0em68ta7Fax/uY+9rSYhl1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ewowGIMIuT8MGVzqFLUi5Bqcb5PmGhZaDdzJj4oibn5NSRrW
	NDMVk5x5s1r3r8lTyQN7y/pVsflyXPMG4aeV7VTq79gL9ie87hF5hl+ncZIGWw==
X-Gm-Gg: ASbGncvMW28nCD8NCFVxEtIzgMSrb4vspvdkwhD8fWOdHI6Za7sUDArulCsOr0tQNZh
	Oco0KCxmbNJAM7henjsd5tvoRDZcoAT30DGJw2hLYU4wHkXfPdKsvEvSe/b8fmrGWUSRaKCzsNd
	DUeBOamRoPpK9Pn5sMt0vhzTEsds7FY6y1FTN+o8XAPB2R+YGnCT10D7tyd8QjNRRgE/hICSKmS
	IXZhAS+9ER4e6rQfXeTuEa3UDi2G6Vaq+kzTvNxAtFCSESPBfnql6q5TxLKDVJSFl298CH0QPTt
	l/N6iph7oixXL20T4jbYv4s5
X-Google-Smtp-Source: AGHT+IH1wzP+i+irxWUKaESGp3CH30PU34aVuj1OORJWuuu0GU8d5eHV3sDCSLEwq9q3e/12onKEKQ==
X-Received: by 2002:a05:620a:8904:b0:7b6:dc74:82a5 with SMTP id af79cd13be357-7b6dcdcdcd8mr249752585a.10.1733772337958;
        Mon, 09 Dec 2024 11:25:37 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6cc1cf6fesm217433385a.102.2024.12.09.11.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 11:25:37 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 09 Dec 2024 19:25:35 +0000
Subject: [PATCH 04/10] media: uvcvideo: Remove vidioc_queryctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-queryctrl-v1-4-deff7acfcdcb@chromium.org>
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

It can be implemented by the v4l2 ioctl framework using
vidioc_query_ext_ctrl.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 97c5407f6603..39f0ddb6d01c 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1014,15 +1014,6 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
 	return ret;
 }
 
-static int uvc_ioctl_queryctrl(struct file *file, void *fh,
-			       struct v4l2_queryctrl *qc)
-{
-	struct uvc_fh *handle = fh;
-	struct uvc_video_chain *chain = handle->chain;
-
-	return uvc_query_v4l2_ctrl(chain, qc);
-}
-
 static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
 				    struct v4l2_query_ext_ctrl *qec)
 {
@@ -1563,7 +1554,6 @@ const struct v4l2_ioctl_ops uvc_ioctl_ops = {
 	.vidioc_enum_input = uvc_ioctl_enum_input,
 	.vidioc_g_input = uvc_ioctl_g_input,
 	.vidioc_s_input = uvc_ioctl_s_input,
-	.vidioc_queryctrl = uvc_ioctl_queryctrl,
 	.vidioc_query_ext_ctrl = uvc_ioctl_query_ext_ctrl,
 	.vidioc_g_ext_ctrls = uvc_ioctl_g_ext_ctrls,
 	.vidioc_s_ext_ctrls = uvc_ioctl_s_ext_ctrls,

-- 
2.47.0.338.g60cca15819-goog


