Return-Path: <linux-kernel+bounces-439247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E989EACB5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B202960BB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A6D2343BC;
	Tue, 10 Dec 2024 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g0ZcH7lg"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB32343A8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823764; cv=none; b=YIN8S6h4cB+wi4LeBcPauavADg6tXOwp+zE/YzOlHiL4I7hwo16AQO/uuc4PVlLoaun70nep1YPacjG0Nn6Jmq34Kgu6nz6TMm0sR9j2fgZRu9F8CPz73zwt5oRXQI2fXz0gNGC/yS+UsIB7JuMP+Js1CCJSbE+qBXp1Iu0e/Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823764; c=relaxed/simple;
	bh=rmwFzpOA42dIRXNsU2drW2dWyEvkHqz3gtgDji2Och0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HTnL7fkBJ+sP4hGTvAJu1TNjIfFlcPdRTJHpwMeeQg/FdxAE03a3grPpgGyytRwQSYLdXYi3ul0CxcEnMFfzO/CjtaMtcxtxjou+6odFfxEipsfiPNFOmYTUeDKwl3dzhpmtcOGASn8rzAA5FoB/W3i7NPmInpb6X7EYpBeHyBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g0ZcH7lg; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46375ac25fbso51373851cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733823762; x=1734428562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgd78hYMarmsibCfxN09wNv5VkU7Kl0GIxvAEFpsb+k=;
        b=g0ZcH7lgdUKw3HuKI6e6x0CocS+EEmi8/0aZiOK6E7N7SuqVCkgmDKlG39cWCCNTiY
         Hs7v7KP3GEXtVOPu8YpXPE+vSazCyN3b8EQJCpU7gDexXouh94cdpiH+qCS2iIDu+sh2
         RFSB1h7BgEI22lGPLYDMEAUL8VOTCC6aiU8T4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823762; x=1734428562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgd78hYMarmsibCfxN09wNv5VkU7Kl0GIxvAEFpsb+k=;
        b=mdo6zdVUB+5DSmkBkiVxAcL6a5KVTD8rqCHl/+qlycVSIw40xMLp5P7wgoxqIiqGhL
         ynO4sno3E+ogVsoEhzLSEIdapFnKD+lIGP4VZ0JS3KWgQJ+HI/71n6eHNfUhBnBD+KZ1
         VTa9TTUlKdCKy57NB2TldtWkFaZMxnXvK341Vkgj8d/t7IhSwK0VUkI1ai3faahkXnZA
         d3jerFzktP/ZUKDQGozoazpIq/BOaFkkHUEkxsKbQuV70btcqYuQ6qTV/S9AAZiDIIsW
         FF5k64k32I6vKLipfCa3AG0NMA5ytyzD5J4nwLft17r63F6OHCVTRlOBDfp5VMeA4LHp
         vzVg==
X-Forwarded-Encrypted: i=1; AJvYcCVUuJmMExBGnGvq9ZEBK+rgjFufBBRQ4mvBUHmpBRSeE3rmAeRnQLAoBRIS6MgsD0HEDm00mTDkCYmSdfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQKFr+gd+FgMD4kY1LY1nWFDzmOo49q4Fbjcw48Yk2GhGp6Zh
	E+BjnYTBFdpWIa8kk/y0sJx+HuL1oHtYn1+Is3ay3hsxqK9GfaiKU7GLKRihiA==
X-Gm-Gg: ASbGnctEv+sAJXNjQfurMiOLR3lCq4PpZzE/fN+poMoHBYcmM4lZK82hgYcepuj5q0O
	PKABjnkmt/gXykXR1nsr4wGNVtPswVZKmciycqM/qHx85ZpJozU8RqYEEdoWDs1KeLHZNcdZ9ma
	ZkVmtVAUv0b/3D5SID3YqvLkPHWc0jR6hoTaDovBNc4J5tn4ZNxHnGSwpuZru43JNvA1/ThIMHB
	a8ywjG/vm3rwy/2lT96EjA6Npk6vcl9fz1OUEzm5aVRq1p9ylasjys/D2vECfn3qtrPCgjanjLn
	iB0vtfZ3mTRNnVYj6WwByu4LSgNA
X-Google-Smtp-Source: AGHT+IEoHdjAOUrtfazsH3n6Y31nFhgn307yyWvBWJlDV472zk6B1DrShdvegUY+dN1ioRJHlGD/zg==
X-Received: by 2002:a05:6214:c25:b0:6d1:7433:3670 with SMTP id 6a1803df08f44-6d91e2d3799mr68330476d6.4.1733823762206;
        Tue, 10 Dec 2024 01:42:42 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d92f7c2bc1sm773326d6.83.2024.12.10.01.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:42:41 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:42:37 +0000
Subject: [PATCH v16 01/18] media: uvcvideo: Fix event flags in
 uvc_ctrl_send_events
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-uvc-roi-v16-1-e8201f7e8e57@chromium.org>
References: <20241210-uvc-roi-v16-0-e8201f7e8e57@chromium.org>
In-Reply-To: <20241210-uvc-roi-v16-0-e8201f7e8e57@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org, Yunke Cao <yunkec@google.com>
X-Mailer: b4 0.13.0

If there is an event that needs the V4L2_EVENT_CTRL_CH_FLAGS flag, all
the following events will have that flag, regardless if they need it or
not.

This is because we keep using the same variable all the time and we do
not reset its original value.

Cc: stable@vger.kernel.org
Fixes: 805e9b4a06bf ("[media] uvcvideo: Send control change events for slave ctrls when the master changes")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Yunke Cao <yunkec@google.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 4fe26e82e3d1..bab9fdac98e6 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1673,13 +1673,13 @@ static void uvc_ctrl_send_events(struct uvc_fh *handle,
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
-	u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 	unsigned int i;
 	unsigned int j;
 
 	for (i = 0; i < xctrls_count; ++i) {
-		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
+		u32 changes = V4L2_EVENT_CTRL_CH_VALUE;
 
+		ctrl = uvc_find_control(handle->chain, xctrls[i].id, &mapping);
 		if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			/* Notification will be sent from an Interrupt event. */
 			continue;

-- 
2.47.0.338.g60cca15819-goog


