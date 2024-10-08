Return-Path: <linux-kernel+bounces-354629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE42B99406F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621ED1F218A6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7328C1FAC4A;
	Tue,  8 Oct 2024 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iqVKYuuq"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758061FAC29
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371186; cv=none; b=LVDWs0i6O2Ye+DUN7TudUkh05MALiE0bhDNcQnPjl7Y/qMSGd0hlp9bnNtOySAOk+cIGeVv/LkrigMbQLS3CYsri+4xnBa4CHOWz4WxDHcOgAOQqk7QhIuRHzjY68NJ3vnb0zwkTz5Ccp3+SG+AvnKaRauanqBadn4XFHVM58XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371186; c=relaxed/simple;
	bh=d5b7dVLR3ZR74qnhfrQJ5ldkhIB/k3f0HhwHYi75Hio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iUarFjMtVLxcJTySNyLbKRPX5zVn2zxFEtyUX07JOvwLSketG2/WhouuPzGAyMNouHJC2B4bUSr0dd/LJqlOlGhSPMjUETRYlncYMWTzXlihNzVssK51FaVcc6DzeffYsAG/mynOi49AT9jyy7Nie1ZaGb7zUQ6cQRry4TuQWlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iqVKYuuq; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-45f05a65398so589991cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728371184; x=1728975984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDX1gk9WLS0lOp3uclg0B3j1XeJVdEOnGdjwzsvJlzE=;
        b=iqVKYuuq909fG5Ig77lAqHozDxJB1cJlQ9q5+vZ4vkDwKEaoA2JhEtiSKIPF+6uYbL
         mXkBXarILRptzv4eSYN34Rvewbuo/246OXafNEE1RUlmfw0n4Ts/kVpp8Ww4sJC+xykf
         uOvgwt/X+s0HP3Ac+E1reHbBFqVMFoNJ9uGRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728371184; x=1728975984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDX1gk9WLS0lOp3uclg0B3j1XeJVdEOnGdjwzsvJlzE=;
        b=aD33qTMaWi715e51APCU3JZc9f9oxBplePFwYc5jHYLCa/LeOqBj4lq1JXSxVqJHnv
         NKh+wDq6Jg7BGcoZ14qgCnXDS7q/uKvpGDnAFoXMQytjyw13zSQrwBCeFLRK1AvtNdoF
         Z8TUUtl8VvGmZ+KiSn0Nb+UWmamEx/H2QmknHS4w93MNTBMq61Q0R8UmGnJ4+N6y+2bs
         pG3BxD2BK/lfkZecdeBy6QFAHHsGIDwoLAO5hrnZRBgEPuOQF2VCYMh3PfvfJ3dljrZh
         sF5y675C8/9GUwdQpBFRUVX0gqyR7z+qK/iTufhJechx4qnpX/47EIYvoAuHwo/51QKI
         uu/A==
X-Forwarded-Encrypted: i=1; AJvYcCWNkfdkx+M+NK1lYfIot1x1JJq0jQXYcc/ctea9gW19HOXcs43KPIIe6q9tQfdZMwM2q16kfxEncpTnxyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV9FNFIZ6cv/gNRpMBnQ9diic1HORfqgq1501vh0hqNMo9GzG5
	kgeGtL9coNFi0JgLts9SWJxpcvc/HyXOLJcv4KYI4WRbFsNlek9wsF1L3vDL8Q==
X-Google-Smtp-Source: AGHT+IG39BBoTTcIAWGA9WiMjv/rkPGoXXlsuN2UqZIeIx/T7ZMNueHs9O13LRs8lKx5eIeZ5zSWSw==
X-Received: by 2002:ac8:7fd0:0:b0:44f:f287:c9b4 with SMTP id d75a77b69052e-45d9bb5b04bmr203085781cf.44.1728371184187;
        Tue, 08 Oct 2024 00:06:24 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da764043esm33801921cf.88.2024.10.08.00.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:06:22 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 08 Oct 2024 07:06:16 +0000
Subject: [PATCH 3/3] media: uvcvideo: Add more logging to
 uvc_query_ctrl_error()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-uvc-readless-v1-3-042ac4581f44@chromium.org>
References: <20241008-uvc-readless-v1-0-042ac4581f44@chromium.org>
In-Reply-To: <20241008-uvc-readless-v1-0-042ac4581f44@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

If we fail to query the ctrl error there is no information on dmesg or
in uvc_dbg, which makes it difficult to debug

Reorder the log position to fix this.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index a57272a2c9e1..bdc3f545a15e 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -83,11 +83,11 @@ static int uvc_query_ctrl_error(struct uvc_device *dev, u8 intfnum, void *data)
 	error = *(u8 *)data;
 	*(u8 *)data = tmp;
 
+	uvc_dbg(dev, CONTROL, "Control error %u, ret %d\n", error, ret);
+
 	if (ret != 1)
 		return ret < 0 ? ret : -EPIPE;
 
-	uvc_dbg(dev, CONTROL, "Control error %u\n", error);
-
 	switch (error) {
 	case 0:
 		/* Cannot happen - we received a STALL */

-- 
2.47.0.rc0.187.ge670bccf7e-goog


