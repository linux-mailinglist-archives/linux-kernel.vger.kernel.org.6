Return-Path: <linux-kernel+bounces-214908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EB1908BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DBC21F23D31
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C30319AD63;
	Fri, 14 Jun 2024 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ybaa0PRF"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75530199389
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718368903; cv=none; b=PbNb/ZiLs/0NLtGLufVfRJ21YhguHeWjjUGnPoCcLeDO/tZkqHoOt7ddVVLJXtJS/Iep+cx7dZKLE47Pt0yovRm7zJ2cJX0vrr4Jrk0apTm82xdXbGqd3OLoNmVWdAyNddDPbx2xQs2LWloWm1U+tdPkc9Wfm1Vw/OicUy3E8PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718368903; c=relaxed/simple;
	bh=qBhEPUORN0+wfjTZKZ+VX36yspUBM554ilvl/WxMkYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DFbAkKPHpdQblDt8tliOfk3FGTZ6hzS4yciwG5/7v5pkVtbMQtyXmb9e0TaYgI1nyoM4A8lZhPQhcbR2/TgIWbNoQ76Y7dIiBn0YFYjQHBgTXvuQjnHBEqc3uWVfdklSvij5xLAGU4Mf33avdvay5dsQ5bdUGbpx2iVFSdaiUgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ybaa0PRF; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6ad8243dba8so10008726d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718368901; x=1718973701; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gp8nRHlyjFIEZs46UyxWOxZiNNyfZrapMqA1AdjCANo=;
        b=Ybaa0PRFN7IrdBIf28pGUp9N0wNde7PPgfna2APda/FI+XxKukWqcG/L8f8UjQV4lj
         QuTSpCkNclRYsM7GUpmDLjv2J9QzB60CUrLg+WmOV8jgeEMUWbPWq589XfXYpeejR3da
         hMT+a7ElF02A/tDPkhNMQR+i17ubGHSiZWhOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718368901; x=1718973701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gp8nRHlyjFIEZs46UyxWOxZiNNyfZrapMqA1AdjCANo=;
        b=PXUvw590EzEFBcaxK2Nyxmd2UsAeF30o78daW8jh5Mfj1PcLvhYfde6eRb3OQ480R/
         eEvrvHqY9GIxsi+DeZFllEXKojQb2BXHW5GNeTCC+/Ij4K8/UGr31QkjVECSotyHbJdV
         oIMp1BvrKcnTcWwgHDHR6wiN/2c0cFFRyHJxTDKtU33je5OalfOOVhyvsjd+ToUSbd0Y
         tOrJQZ5/ELJFSIP/R9F6MsusmeTC3Waf1BrHjaMIBq2TMEM/TNwKGJCPWk1u7fqzlcaa
         poGF6rVpL60gmZuMOQgkc5Of4r4xFj0IdoH7hfN41kqAvgV6r4HDdnKwT3/XdE+Xlwgi
         Bdjw==
X-Forwarded-Encrypted: i=1; AJvYcCUp0CMwmzSP7iNs1qax+aBwOIRgd3w+9SRNKMs1JkkJ+0NMWrymcFcozf0JLguu9VUGyUdplYE08NwQMUIKMolegWGXJ48UQjJMQkAU
X-Gm-Message-State: AOJu0Yyb60pjLfxS06o1vj2o+s2wUIVk5zR4DpOTZzKkLHJEKX4N1FRj
	SqREjZNzad953RHNohewnf68ixzYSBpcKDXut3OSKZgP7sH1ufpvWXZzgUehpQ==
X-Google-Smtp-Source: AGHT+IHJtNT5OlxAJG5HTDAFmHTNEauVEn25IMzysKx6zq1wIY70PbE6ooXmIq4IYnjopljkwoIOcg==
X-Received: by 2002:a0c:f7c5:0:b0:6b2:ad94:2195 with SMTP id 6a1803df08f44-6b2afd6ab6dmr27101546d6.46.1718368901539;
        Fri, 14 Jun 2024 05:41:41 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c202e8sm17734056d6.50.2024.06.14.05.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 05:41:40 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 14 Jun 2024 12:41:29 +0000
Subject: [PATCH v6 3/4] media: uvcvideo: Avoid race condition during
 unregister
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-guenter-mini-v6-3-7b7fdc3b21b3@chromium.org>
References: <20240614-guenter-mini-v6-0-7b7fdc3b21b3@chromium.org>
In-Reply-To: <20240614-guenter-mini-v6-0-7b7fdc3b21b3@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Tomasz Figa <tfiga@chromium.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.13.0

The control events are handled asynchronously by the driver. Once the
control event are handled, the urb is re-submitted.

If we simply kill the urb, there is a chance that a control event is
waiting to be processed, which will re-submit the urb after the device is
disconnected.

uvc_status_suspend() flushes the async controls and stops the urb in a
correct manner.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index 375a95dd3011..8fd8250110e2 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -294,7 +294,7 @@ int uvc_status_init(struct uvc_device *dev)
 
 void uvc_status_unregister(struct uvc_device *dev)
 {
-	usb_kill_urb(dev->int_urb);
+	uvc_status_suspend(dev);
 	uvc_input_unregister(dev);
 }
 

-- 
2.45.2.627.g7a2c4fd464-goog


