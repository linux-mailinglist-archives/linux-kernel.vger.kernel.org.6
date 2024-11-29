Return-Path: <linux-kernel+bounces-425899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFF49DEC5E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C1D281251
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E75E1A7274;
	Fri, 29 Nov 2024 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aBf+X/Bb"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4981A3AA8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908315; cv=none; b=IEpDPxxc5a6OQkNQSLxxVP4fZNZln9d+T12myzl6/eNyAS3ojkPtMhkQI0oZzqc9yCd3Pf/QOgBKJnIqZ6D209dxrbbR82lidJnFk5exoXwcogXcxIbhpVhX8L/kgqXqyFTIFGEtcCp7BITnphypW47+KH69SvumoOoAh64v00w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908315; c=relaxed/simple;
	bh=mTx9kJaioWNO5uqqFbQnJEwHqDWVPPS5kmBz66j5EZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pCbQqV63xgj+WxDXHXxURYMtSR0YdcxHaGn8BAPP04sAwuMuRWQu8kBDbf+Nj7tSUfifB2VZ1aOzeZGPC40/MNLCCLQvKc7SNWgQj8/P+bruVKV7HjDY2QipRrxLJao8g6UM8Zpa+AVyX5CrUtM6Bl+oG7s5rPooQsTbNlyY2pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aBf+X/Bb; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d88c6d0fa3so3766766d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732908313; x=1733513113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lc5F8NAtNe3x2vw3Nhwg+vdINmv6+xp/VOBllqqRjXg=;
        b=aBf+X/BbIT2TBPYOdGMT3WNce3nAk91uPGEa1eSOjtxItwyhmnyzpA81asTyUdYVoR
         MF9yw609uGMtYkgpsjcfMnrQLxu0zU8KXbBa7gnM0Gsbfcj2tPiwMScxk6of278MNOKb
         MDWXtw//kOGgY0OiVjGUj17CLF2Q4HlhxO5A8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732908313; x=1733513113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lc5F8NAtNe3x2vw3Nhwg+vdINmv6+xp/VOBllqqRjXg=;
        b=RCtbWnotFP5mXbLQGd7a6uCYmKcJU8jhwKSz5v6HIMwXqENrF3qUlA1+0QJpDjGXft
         RR28vxcq5QY3kzuuEdEvjPuxwqCMMCodh428Z3SPjjnFZxKiHdbTjJT7RRlePSmKxCJ3
         aQUFQjJqmKO9k/rCLrc+GMF130fnfA4EXy3OrNFb1cO4snr/Y7cqlCxUPjNKHAL9K/WS
         Hk6wuYndqnd9CtpZ4qTCkF2hSu5cDTiAuitNO6edxFH7I3gcAGpBP/ZS2sINqE0B28N9
         xXRrzOnagWuargMDIn3gT2PB9iWfAidanI4DCRDatGs3VhmVA95QKjCLgnqVoiJvA4CJ
         A7Gg==
X-Forwarded-Encrypted: i=1; AJvYcCX8ITA+Q6Q5oO5FekRCOT63FXtLq3wh3EGNpR/27QIhshefRzGX2+sgF/yvBWf9kSwHW05siXTFYOrBngc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpfvGXQzTxcYO3LUllmAtMTCmfPCW/ntlpOynK2DGnGVnpV15l
	yPhCzCEMZ+TuUW9Jv7wT6bHfuPpbvAjEAtUuOr0ziGVvTgYsXcE+4os8A4btog==
X-Gm-Gg: ASbGncuJ9KscGiem9qohPLDJFv3VB5LTX3DFUOxXx32lrnFP+ztNLlx51V8Qv0FnIAX
	/hvrx5ZLYov8oFEiovaapcpiX6EjNnbvkQpmaFISuBGbhruFh2+7le18tYkNtOj9BDhK9yCXd/U
	U8oXr4UyHU8g7fvCpsQErl1D9WuOpzL6eG2XA4yW1Z9u7IHYV9rmAYVQuPZJUHPGJEuRRGS6Mgj
	loNkBOyeje6MLaFl1rn2ZRMukAvLZqR9gWRkFJL1LtUvCBWAjVJ6tPFAZpCbJRwt97VLH6u3dM0
	pPYamK7hodFifO1tgxIgwPTo
X-Google-Smtp-Source: AGHT+IFdLvcLiH4k2Om49MhI8qLceyQxgKY9mTSa5zTIbcimzBKS55ZzkocL0pPO1xLeZHkbghcwGA==
X-Received: by 2002:ad4:5aa5:0:b0:6cb:ec71:f1a1 with SMTP id 6a1803df08f44-6d864d44973mr199471616d6.17.1732908313178;
        Fri, 29 Nov 2024 11:25:13 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d87d899ec2sm14462146d6.50.2024.11.29.11.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 11:25:12 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 19:25:04 +0000
Subject: [PATCH v3 3/4] media: uvcvideo: Annotate lock requirements for
 uvc_ctrl_set
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-uvc-fix-async-v3-3-ab675ce66db7@chromium.org>
References: <20241129-uvc-fix-async-v3-0-ab675ce66db7@chromium.org>
In-Reply-To: <20241129-uvc-fix-async-v3-0-ab675ce66db7@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Make it explicit that the function is always called with ctrl_mutex
being held.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 0a79a3def017..1b58e558604b 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1958,6 +1958,8 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	s32 max;
 	int ret;
 
+	lockdep_assert_held(&chain->ctrl_mutex);
+
 	if (__uvc_query_v4l2_class(chain, xctrl->id, 0) >= 0)
 		return -EACCES;
 

-- 
2.47.0.338.g60cca15819-goog


