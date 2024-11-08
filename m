Return-Path: <linux-kernel+bounces-402336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D26D9C2686
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8BE1C21E00
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6848202641;
	Fri,  8 Nov 2024 20:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TNun1c5f"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D9E1F4702
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097558; cv=none; b=DtVmeh30OkDWGLnm52E5YE5/6wxBuGZZ5Gr7lkVxM/LVboedoBx9e8AJBKqL+3HOvcZoxjAjJcEL+h9esfFJ2pbKDMg34EhARxqtp0m6BX2uPwdm+9t4FX1VGibGXsSHIc0UWHFR8EtQC3ffY2gBS5HWod0HJ8Y+37EwED2LH0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097558; c=relaxed/simple;
	bh=CEQbOGQ7MRdKXGHNLVjrKRQ53Dwr649n7vnBnnj8ctA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CNma9EoOKjP0RcKoN8PJdtYtAGMfg4bfYyVJH01HpYxlmd1rtnuClhCxT7IGIj/V/3cOeISr1ZlPsntmziurS0d6vHf4sHF2OKY1ancgfMpfp3C80UTS6N2bhK/wMqSWviVk5+xuADM3dSmTqoKeLmVMvGhCzOkZCCjt0FXORNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TNun1c5f; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460b04e4b1cso16122971cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 12:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731097555; x=1731702355; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkMMFzioKVFAa0nRKkB9RNN+8H7kOdLFjqp29pnighM=;
        b=TNun1c5fO/PpGMveSRkPiD1OPH0tF7NWeSRseoxVvPj5tIP++05Jq0DRTz2kklodwB
         idodLlAuT+2TCNRZy4niV7okbpJAR5C1lGaox5wPpBgHPb+YS0n1zhhdpEmP2Y1bw3jP
         vEA840b191t1MzsXs00r7aKE+FFzKrxMkXZC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731097555; x=1731702355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkMMFzioKVFAa0nRKkB9RNN+8H7kOdLFjqp29pnighM=;
        b=kEEbTLWaGr+ipuI7bmnwRGpd7uqihZ8Y8LoHxoUWBiWZpVH6R5uKUPAkzqBA+JQigM
         xX4RcHSD10fQQKe4XtgAnJbOIPvui29jTLKrHOwggWWlU6N78N81nDyRakm0H9WCzxOP
         neCRr7zXT/0qMuJ5zA5XneTM0t3nEB18ae4s6ACyFQfp6FNoQ5CeLiLz1EEgWO1Qg/qY
         293EoUgl/WYUmfsucSRzKS57li+/5DwYwq1gjulkJQGe9/kzmIN83WGrIRCrFdSyF1HU
         YXWfLuYKA6KtyOfCe3lLLBII0zuyg+u13ysYNu/F7ps+V0wgH9WGU3E8jW1DaLfFMZAF
         TwWg==
X-Gm-Message-State: AOJu0YyJ8mxWb1CZ6tfmRuEqBKAj8SbekKkurFrIcT5/xUaz1nVEdgoM
	AKd7ynj0ARHGzTGG/g6KWlKjKpmgGHGmWRSmnGwevOJ0zknQxtc3VIxOPfuByQOe+OfECMERnWE
	=
X-Google-Smtp-Source: AGHT+IHWOvV1IPVUo7h7yQ/dscufz+urxttXJhEzrF799ygWuSvfQI1Q+sg+Un/wfzS9P6xNNA9BQw==
X-Received: by 2002:a05:622a:18a8:b0:461:48f9:44e2 with SMTP id d75a77b69052e-4630921aeddmr58442371cf.0.1731097555504;
        Fri, 08 Nov 2024 12:25:55 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff46d440sm24207341cf.52.2024.11.08.12.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:25:54 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 08 Nov 2024 20:25:48 +0000
Subject: [PATCH v2 4/6] media: uvcvideo: Create ancillary link for GPIO
 subdevice
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-uvc-subdev-v2-4-85d8a051a3d3@chromium.org>
References: <20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org>
In-Reply-To: <20241108-uvc-subdev-v2-0-85d8a051a3d3@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Hans de Goede <hdegoede@redhat.com>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Make an ancillary device between the streaming subdevice and the GPIO
subdevice.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_entity.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
index c1b69f9eaa56..dad77b96fe16 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -53,6 +53,16 @@ static int uvc_mc_create_links(struct uvc_video_chain *chain,
 			return ret;
 	}
 
+	/* Create ancillary link for the GPIO. */
+	if (chain->dev->gpio_unit && UVC_ENTITY_TYPE(entity) == UVC_ITT_CAMERA) {
+		struct media_link *link;
+
+		link = media_create_ancillary_link(sink,
+					&chain->dev->gpio_unit->subdev.entity);
+		if (IS_ERR(link))
+			return PTR_ERR(link);
+	}
+
 	return 0;
 }
 

-- 
2.47.0.277.g8800431eea-goog


