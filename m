Return-Path: <linux-kernel+bounces-422570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7869D9B49
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E12282343
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E343D1DDC1E;
	Tue, 26 Nov 2024 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jtS5RrYw"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F41DC04A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638034; cv=none; b=aeQrDyzywXzN6qv9vsExkQEXAOBj5N8dodnO1bfoPMHahVWqhgTryViEL6AD8rBmlIy1XUDBROFp75H4SlHxMAfseWABwoxdfY6EX4ASwQfczA/Z2AWrVHf+mcEV30hl5tudGw+dGbOc1VyQmiUQsCxW8XO1WnH8/Niksc5XZuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638034; c=relaxed/simple;
	bh=3AS4904ZrJWWmtzo+XQDjxmA+Exv2p0QUHnWYejIDuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NDTJOqj3Tj3eD9RZuTQKDjaG017IYCpVY2uj4+NehX27ujz1IhzT17WUqXNN9ZaQop6LY0yrAbirwc8OyIe39VeBuLqXhy0yttaAyvwMIDNhQ55ioUKVV7Bs0+UpE6JhHOpp7+veQYC+wkWFUlXtNU159bpDes1sEqTiP2nwUj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jtS5RrYw; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d42b87aceaso60756326d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732638032; x=1733242832; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38DVVdNZ+9OXPNjKWQaX+5zY7dH2BnytoxnJmJsLz5s=;
        b=jtS5RrYw9EeCtS2ZR2MwAnH1UDCU407zwTtDCQKj3ekRSvqxLdi6ftIBIOwPrZBZq4
         0VDChiwy+jBjcz7V5VIzhsL6AHlxXjBza4rzkDdCyIv9YlC75i7jLswYisWdcMlgb19U
         8QHMY0f9AK0qy7RTvtP4CsB2oYjcBcTlThnxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732638032; x=1733242832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38DVVdNZ+9OXPNjKWQaX+5zY7dH2BnytoxnJmJsLz5s=;
        b=v+oGk8/Ms4NBVqJPxWHjCrLK7oHbybpHWgazXSe6FgUueq5fZvG9nRcnWaaIKzS4EU
         F2E8Ic7mYQDuuESG8o0uNQkZ29W1gvQ1W+S1P8YM1G74Djmk39xg+B/cgp1SwrRyWdh6
         /SRM57RU1TVh90oe1eBaR5CztimLhscd4Jw3nSD7Re4/M4OFQJyzbWFn+NbphGj412jE
         +KunACDZSeqBqzMXztKRwnSyl3h+Bz25kV4IDbldVjwGzbEYQkiai+V2bbBrVvzRGsdB
         mmxG9Q1BqNdu3TupqqzbN9xIAHXCvJTcIMKgb4s8rHAX5hHO+n6KjbOINO6mfW7Lcxt1
         s92A==
X-Forwarded-Encrypted: i=1; AJvYcCXS70Fa+NpMU0+FapOGrEpHLkDCDSW6eLgEOnsp5ISFuxWUepPaWqZPcnSp1XnF2IYeHlklvtB4xSOPZkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTlfMD1ZdJOLRJ2dYBebQIoAUOfznCM0Tv2E0etbaIa2kS9DVP
	G+awE9Z/2FJe8l/eby+Bfj0M72YUih0sFqgkP6HveMqO8thFGc5XjGrafPE2dw==
X-Gm-Gg: ASbGncsXk2Y6o69rnpPOiqrAgxHgDn8RXd8Cp30u049GhTaf9npvBdU5Eocopk3M0p9
	i+wZu9mpy9TWqSiIJrewO6ziZq4V0P/8LHmNqFUhrgBpB6l10VhcXeFs1GOb4u4XevFzWAgvwMX
	82998t5MNV0ySUT5dvAdXG5Dzxeq3D6QZbYg3ioLCvbWFgcznRAqXklkYvG+ZnPR5iaqcIG3NaK
	OaL0VYkU8INV5akBs0gS51RZt3Ca9ZbxH6C08E4OQlrIv2g5/h/LD5PYVxWtxpoBl/vIzGl+YOq
	22kfZaJdafHQ9PwSzYdWVXEc
X-Google-Smtp-Source: AGHT+IGr/+2B6+LJ1kyUP+IBLvQ2LLQlOOS30Ru02Ofx3ziT/PGCoQW+M+Ou9DSuWC6URGy5iQFp+g==
X-Received: by 2002:a05:6214:268f:b0:6cb:c9cf:cd40 with SMTP id 6a1803df08f44-6d856bd1e51mr59641196d6.8.1732638031784;
        Tue, 26 Nov 2024 08:20:31 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b4e8205fdsm346532241.1.2024.11.26.08.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 08:20:31 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 26 Nov 2024 16:18:58 +0000
Subject: [PATCH 8/9] media: uvcvideo: Do not turn on the camera for some
 ioctls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-uvc-granpower-ng-v1-8-6312bf26549c@chromium.org>
References: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org>
In-Reply-To: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

There are some ioctls that do not need to turn on the camera. Do not
call uvc_status_get in those cases.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 3595f67fd7e2..0a058798d075 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1455,6 +1455,26 @@ static long uvc_v4l2_video_ioctl2(struct file *file,
 {
 	struct uvc_fh *handle = file->private_data;
 
+	/* The following IOCTLs do not need to turn on the camera. */
+	switch (cmd) {
+	case VIDIOC_CREATE_BUFS:
+	case VIDIOC_DQBUF:
+	case VIDIOC_ENUM_FMT:
+	case VIDIOC_ENUM_FRAMEINTERVALS:
+	case VIDIOC_ENUM_FRAMESIZES:
+	case VIDIOC_ENUMINPUT:
+	case VIDIOC_EXPBUF:
+	case VIDIOC_G_FMT:
+	case VIDIOC_G_PARM:
+	case VIDIOC_G_SELECTION:
+	case VIDIOC_QBUF:
+	case VIDIOC_QUERYCAP:
+	case VIDIOC_REQBUFS:
+	case VIDIOC_SUBSCRIBE_EVENT:
+	case VIDIOC_UNSUBSCRIBE_EVENT:
+		return video_ioctl2(file, cmd, arg);
+	}
+
 	guard(uvc_status)(handle->stream->dev);
 
 	return video_ioctl2(file, cmd, arg);

-- 
2.47.0.338.g60cca15819-goog


