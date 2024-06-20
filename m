Return-Path: <linux-kernel+bounces-223870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E3B9119B9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224941C22A83
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 04:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FE813E022;
	Fri, 21 Jun 2024 04:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gypKUVDQ"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61146130ADA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718945214; cv=none; b=tVZsFOXWjxZYQki9mCta59+4tztMkRb0z4X25ITnzmaoN8CCW4Hocm0Hgv1bZK50MrkwYihGSr+LFOaBRS5p4qR3mksojrJ6YMVmOyNyjYe5DAx+/oAufR2AtKARWo4iNrohQZzkmuyXuict5BLnZ5LX4F1IZSxO53uPtpUzT9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718945214; c=relaxed/simple;
	bh=eg31BoRkeTJON7zXV4K1jhgM/v2n2k+KGM9iQFc0N64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUSlydx6OPnl8hS3dJEvdNCwmmRVio3j9RCTEZLBEwHpn9AezAmjDWWPcI4G5Mks7c/L+F9ZpyHSIMv11Tulp4BWlY6zqE8AoW0Oqe0R3Mu3cWY6he8gnpEHYOgDibR7vqb3ddea61xMd0mHT0TeR2uEvDjahSxFre0bTjjDKLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gypKUVDQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6fabe9da3so13471285ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718945212; x=1719550012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qs6kToBk8YjSTiZsPQaIgz5b7g4VfXjvffstHMdxZFU=;
        b=gypKUVDQI7Ffbl1Wnu5kXb6vzVS7KgCFDOg35Gvy3gOBUINWAXQs1iw6d3VvzEAi+m
         GQqiTDnctqGGfcHg/1x5jvz73sFrhJUH4+jIG8mgC4uJdhcr9HJzVWjw+x9Tz0sC6aIS
         r1v0OK7YXl3hutUpZJXjrCWMOimuDKiwaAafI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718945212; x=1719550012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qs6kToBk8YjSTiZsPQaIgz5b7g4VfXjvffstHMdxZFU=;
        b=xMo7Yx5FlCzILbaZJA0Kn6AeJQsMoTOIjf1UjkW5FUfvAvUGk2RkSOtBoek9qkfyQo
         AKq1KPplrEuG9YleEGuETJEccXrxzdPXNFrM7ZnXpJo0Ht7cxIKxwiZsvKrXaeiY/YKA
         9OOyX10iAzQqcN1V8GUJXul01v69Nb44iGV6ETWmmk04xqAwQuNNiGBdBq1NeNWiCkUf
         4/kTvGqK+AVEVuKJydjVgt3+PqyPSv+1UEZW1U+LVrty5/M0CCBpwqf4Qip1kutU34HS
         quNURYFORksSe+YmvhOba81tLufZmq1Ai7HO36oOcL6KObJDaK63MpNkvU9MSquWKqg8
         dm4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3kf2W+Ap73psYUQOAmN9msK41kmYkow5zTho0g3I8ee2T9DWs1v9X/KLxdQisFZ148tYQel049hkqLNs6XnbFzRdgwDT+Wtfjp/a9
X-Gm-Message-State: AOJu0Ywh7+2jlX/vAXVX7Gkv+KQiE7Z85IKLyZotKbGEHQDs/LrFyjgO
	BjQRXuSlvIw/L75WjMXrgFY88FcHC+88DQBT/2KqHmT3I34AV69Pen74VxtdYDEDluyLVgvtNBc
	=
X-Google-Smtp-Source: AGHT+IGBWYpF1pYJ9+icaGVYwbZfvFF5d0o4lVQn5+tcG9E+8MIgi+4DUMl+GZROA3IqIr4GWwFgNA==
X-Received: by 2002:a17:902:ecd0:b0:1f9:eb2e:d32 with SMTP id d9443c01a7336-1f9eb2e0ffamr10912895ad.22.1718945211680;
        Thu, 20 Jun 2024 21:46:51 -0700 (PDT)
Received: from mstaudt.tok.corp.google.com ([2401:fa00:8f:203:3c9:e095:f93c:9c3c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb5aa5sm4780755ad.271.2024.06.20.21.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 21:46:51 -0700 (PDT)
From: Max Staudt <mstaudt@chromium.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Ribalda <ribalda@chromium.org>,
	Max Staudt <mstaudt@chromium.org>
Subject: [PATCH v1 2/3] staging: media: ipu3: Return buffers outside of needless locking
Date: Thu, 20 Jun 2024 23:45:42 +0900
Message-ID: <20240620145820.3910239-3-mstaudt@chromium.org>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
In-Reply-To: <20240620145820.3910239-1-mstaudt@chromium.org>
References: <20240620145820.3910239-1-mstaudt@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In imgu_vb2_start_streaming()'s error path, imgu_return_all_buffers()
is outside the streaming_lock and after the call to
video_device_pipeline_stop().

Let's apply the same order in imgu_vb2_stop_streaming() as well.

Signed-off-by: Max Staudt <mstaudt@chromium.org>
---
 drivers/staging/media/ipu3/ipu3-v4l2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
index 541556037c42..3ff390b04e1a 100644
--- a/drivers/staging/media/ipu3/ipu3-v4l2.c
+++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
@@ -556,10 +556,10 @@ static void imgu_vb2_stop_streaming(struct vb2_queue *vq)
 			imgu->streaming = false;
 	}
 
-	imgu_return_all_buffers(imgu, node, VB2_BUF_STATE_ERROR);
 	mutex_unlock(&imgu->streaming_lock);
 
 	video_device_pipeline_stop(&node->vdev);
+	imgu_return_all_buffers(imgu, node, VB2_BUF_STATE_ERROR);
 }
 
 /******************** v4l2_ioctl_ops ********************/
-- 
2.45.2.627.g7a2c4fd464-goog


