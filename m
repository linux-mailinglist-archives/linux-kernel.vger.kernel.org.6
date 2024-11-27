Return-Path: <linux-kernel+bounces-423458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E159DA7BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D52AB2E689
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9429D1FC7D2;
	Wed, 27 Nov 2024 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U+p2X9wP"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722941FC0FC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709705; cv=none; b=DmuR/TRRpntwQBIZpAlAGMxXQPClG4Lhshd3UrA2v/znx2TKmx0eV23G7hh5cHRK4uskjjEgx56tffB/eDbvgzgm8XpPs49v63RUzvOgGtuMrx+zqLfBQ1dT7DEaUXEJvjdwOykNOJy7V24N+dupPcFS8oaDffQd5OBGq+4VgBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709705; c=relaxed/simple;
	bh=yv3h2vzWiCSkYvOmOVZOnLbH4e+vqdmkttphrGsTdA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X0cc/34E0yU9E/OiyjAef+epWPuKn+m5UxbmaIRWLLN9XHwCcUpGiEAGn79Vaw/8I+Gsq5DRYdAxYWhZ2Jl0a+4f1Y4Sb1fK2Bd9CInieUIsIspHQQ9c0yCKsAuEWocUytFLG1/0+RXeuvzh0XVpJ/z/NTeDECWK5xZBUMD+JXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U+p2X9wP; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4668f208f10so27634601cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 04:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732709702; x=1733314502; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6PMrA6yfmsQRKTdt+5BI8/0Y5GUPe75YZrlJGsNn64=;
        b=U+p2X9wPu/UMKCx3VFmxhdXB1oJWwXW2/deneWXnmYZIQkCbLIB31/26g5I7m49Vdd
         UivIN4yzh6Bak0ZPALYFBocZm8+pWe5XM1wATMbuQQ1I67HCA6eu3CINNvoMD/8o+i8/
         ZxQOF+qi0w1t1pQMks7vO3NR3xMColOXr3MzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732709702; x=1733314502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6PMrA6yfmsQRKTdt+5BI8/0Y5GUPe75YZrlJGsNn64=;
        b=lSl4OV8QcnW+NiWm189aVs8fS6RwA94DsIBFtK0MKwLUeWDdknhl6NMt2ulJyXBUuX
         FSS5MPB6Pt3dzj8/pCfIn7g8vqZz1LgOt0OQqiJtPh2BHB8DbkEB75bVWjoz8zZgEQ3P
         eoxFu2/AREi9hPKWDWh9oYYrmoYXn2erDuu4+dOeyu1Ge2MY7dBlzZLfONd40ZgLyH94
         HFTWInWzfmyOAtQxpY2OiRAt5jd5ZhbCArq3xNCjFE9Sp/l/Ue1tg8tdA7gE2dXuh0rP
         7/akYoovBmSWpo7gcOzYOjZASPsHdTl2VW+OF+xbv9+1UZu3x2PA0Gzc2Or44Y1fF2zf
         JNQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDVuvvkTkEzPOWczQCIYBI1/0Op/NVr8CzfppSWTHTINAicclPDq5VKlVCt3HIYjG6/6Zh5lv0LowmMmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMqjPFzzi3xPu/fTCiWV46CeZ3781MOp+PhjwYeV9UIuRMoiN/
	W8xSM3fHgHx44ItTpSY0jin4wa79QYCW2825dhyjsm6M5tI9IOxiWUdrsyzTJg==
X-Gm-Gg: ASbGncuGVquRGvUI6Ebl1YWBTEYQl2hGSGRNHBXfSZkOZFjk+N8wGgtTzD2POjfSZNW
	Nfef4uSTZe9mh27wz7QroEtysUvJpt4ly28yRpvLZqFEQfhSEHSLfds034hySno2vaMhP6obje/
	vUjyHAfWLUqi3zxXH4GAmyphDsN5ugAaP2BWOj3UQnO6FXXWAZreLTuEBynPDv/XmieV0DNGL2F
	VWFrJ8DzQr/I/rWCc1OooRcpRv7tpc8XvT3cUzy3vCo2eN6qe2RFIkjrQGqtw9p3mZNdC74vfet
	k6tpf6L/09oOXDSgQ1QvknYJ
X-Google-Smtp-Source: AGHT+IHf6ueSfY60U0HfefcCmnZQ367u8xLsUq+kt1ZVbjF6qn5g8wIQB2Z8/Cf0NEGUz/Jw+SbagQ==
X-Received: by 2002:ac8:594e:0:b0:460:ad52:ab0d with SMTP id d75a77b69052e-466b3516358mr37080091cf.16.1732709702235;
        Wed, 27 Nov 2024 04:15:02 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466be77cf7bsm371171cf.89.2024.11.27.04.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 04:15:01 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Nov 2024 12:14:52 +0000
Subject: [PATCH v2 4/4] media: uvcvideo: Remove redundant NULL assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-uvc-fix-async-v2-4-510aab9570dd@chromium.org>
References: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
In-Reply-To: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

ctrl->handle will only be different than NULL for controls that have
mappings. This is because that assignment is only done inside
uvc_ctrl_set() for mapped controls.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 99ddc5e9dff8..b9c9ff629ab6 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1645,10 +1645,8 @@ bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
 	struct uvc_device *dev = chain->dev;
 	struct uvc_ctrl_work *w = &dev->async_ctrl;
 
-	if (list_empty(&ctrl->info.mappings)) {
-		ctrl->handle = NULL;
+	if (list_empty(&ctrl->info.mappings))
 		return false;
-	}
 
 	w->data = data;
 	w->urb = urb;

-- 
2.47.0.338.g60cca15819-goog


