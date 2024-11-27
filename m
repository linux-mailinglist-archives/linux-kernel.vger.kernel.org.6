Return-Path: <linux-kernel+bounces-423457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14C59DA7E3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC654B2E1AD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886CE1FC0FA;
	Wed, 27 Nov 2024 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NyzKEgCq"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3901F6686
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709702; cv=none; b=L0IdSWRgLJh5UVunzDDDy96xOoOEFJK0NZZKy0zF1DzWxWgEHUuK2RFdW3spYRZJR54Ft3yG8hRGjXLKl3/Kc2i5V3kBiZ22wPZgFsF85Ctgjzzrt3Vsn8FQdVDzC7vkVYqEHJTc+SQwArbr44DShvf3xU9ap3XIUgQ1r7xCdxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709702; c=relaxed/simple;
	bh=qscvc4/+8WAanATzK91OtjUbi7ikSGl3avQzHX8sCU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PH+q2beqd+YnYqgncNr6dTrVD8ve+ImANBJCj+q+7kQlzb6+7tM6qWV2TH5yFGDwuagP0wXglJz4b/Zf/EZwVyOjNZ15Dd/ajZw96kMYeRAjMMb46xI/CvPv4pkDhQeIvPpySJHrlFHW6vJoBI+oK+t60kgN2+Z8p0rSK+r5meU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NyzKEgCq; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46679337c24so40140371cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 04:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732709700; x=1733314500; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkd0hfrtGi6wFG+eppx3CwdzsgWeJcO0RuYZmaKBy34=;
        b=NyzKEgCq8Wq1LGDpojFYKQpXwY78+p1Smzh8OPbK8G3A0e24oBbEs5KACNH+gHCigf
         3mdSo+7yWgpiR842B+/p0d7uqGRTAqUUnk7inw1M9PJ/7ahVbgqIRJqlFINF/bu1okuz
         mIN784VoxApKOZ8sZADAvdQ8acfofy8r8PoDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732709700; x=1733314500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkd0hfrtGi6wFG+eppx3CwdzsgWeJcO0RuYZmaKBy34=;
        b=F8wq6JOR/dSBAAu1kpR24qJf0tQj1V+sfuFUbEUEjZWCw5Nu8r5QomxHrJqU4erYD8
         7cuyp4dSdBrPfcDxd+JOR/B363aBpJLNW8z/Aupxhz1FQqtd0FuX1swrFj+/kpsVaEEf
         OSuhJ7dBy8Gw9538H3BdUyii7Lo1vewgP/I6kEwUHfTbHO8cBjLazE805vLrdIMt8Tsl
         aNiorowV08Hbf6XQZ4pnwmSZxzbH1bRhqpK2X5wglb5shxpV0gSrYSS2dWsmC5/g65ht
         UNPv2wCeNXIZm1pa8TaJ+qoSQMEnzZSbhnO7YupXmbl2xe/pI2XmPcJx6WQUdScslmRi
         21mg==
X-Forwarded-Encrypted: i=1; AJvYcCU56yRzoYom73hxvLz/8D7HXF5gqvPpyCqBLcSSUO6Tb5BGvOthACGebGzrU0rJFnkRRs9+JQmi7RujQmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSLbq1JFs97/UDg/OCMAZI84cXJ59QUIBb1RtJDKFVTDySmwJl
	5Mssd7zs+btDyNWO6jloVGJl3+c9CKSNMq0Q0Jo9LJMoPe58qPozBpx4DQhuxw==
X-Gm-Gg: ASbGnct17VcPigKG5YFgtLXy5VM43O5G5VQ1ZL0eE/aEAQzwNcAC778+WWFZdiQASEn
	JPlphmkPS7O58ZCOEdsAYoMoCxfZrds2Qjlm6lqgOjsP+HjGAlSGUT3i5R2gQnW131UG08QC1+U
	cfnsbwEqCkvy8aP+dZ/UbGtkCQ9G0SOBT0KLtq2c1cIba6Jfht6jUQShnE4IN0SV9t9nH62xBez
	oLBDG6iZpzcd7/bYNlWbu+vpLJeFu9Z4Z/gEUo6d2eY7yx+cbD+XPPgyg40BMTZC77S9BYGH3Ar
	djCL6gPdgBb9DLrmYB2BC9oC
X-Google-Smtp-Source: AGHT+IEJp12s0m0Yk1hs2ex6FW8MZF5oXzJGL5WHwF8YV678OPemZ9ffP4a8dvh2jsPCipIpLWswVw==
X-Received: by 2002:a05:622a:14ce:b0:466:8543:b96f with SMTP id d75a77b69052e-466b34d362emr28958981cf.6.1732709700243;
        Wed, 27 Nov 2024 04:15:00 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466be77cf7bsm371171cf.89.2024.11.27.04.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 04:14:59 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Nov 2024 12:14:51 +0000
Subject: [PATCH v2 3/4] media: uvcvideo: Annotate lock requirements for
 uvc_ctrl_set
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-uvc-fix-async-v2-3-510aab9570dd@chromium.org>
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

Make it explicit that the function is always called with ctrl_mutex
being held.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 3f8ae35cb3bc..99ddc5e9dff8 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1946,6 +1946,8 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	s32 max;
 	int ret;
 
+	lockdep_assert_held(&chain->ctrl_mutex);
+
 	if (__uvc_query_v4l2_class(chain, xctrl->id, 0) >= 0)
 		return -EACCES;
 

-- 
2.47.0.338.g60cca15819-goog


