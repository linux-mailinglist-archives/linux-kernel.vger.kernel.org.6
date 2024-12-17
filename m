Return-Path: <linux-kernel+bounces-449939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A719F5862
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DEBD162C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078E91FA157;
	Tue, 17 Dec 2024 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UHNK5P0u"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C441F9AAC
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 21:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469626; cv=none; b=YX/XbqmeiZDsAlkSA9EFQJJO6kyIG/1a8HWygMUrzpvNF28Elpi5+ZMSZVQO1DTyEMr1H6qRGvByLApUzfK8jKvB7QDYE+LrUz2U4elVqVN4zQS2p0Wo/Yn/3XXFy70v4mgP1ghkeWSV9GQM0EffklQJOlmcoQUCVZqB/1EjjO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469626; c=relaxed/simple;
	bh=TMV/gS+pZ0eeGBOV266PLaY1f6B/qSj7zVYBiHN+BO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pFBqylrXW399IRGX2cvRcxqtAKqJ8pXK4m1dc8Uu7hLia9F22EFYlJ0Iqes5KI/WxITEelg2MYtOpAh1Y15QhszqNj9onGLuinU0oS/lBkDuU2yfN6MHTtrWgssRv/zkXVUyOIQEjiJGr0EVzbgb/CMGr4Pb8nZGGx1tr5fiLnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UHNK5P0u; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d932b5081eso52744516d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734469623; x=1735074423; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YaRXnJufUgA+sZgOmkVmsImy13QD0OXBethBAiDBkw4=;
        b=UHNK5P0u81QTCtcfRXwvvoYGD+vqqODGbdhZ8malQF6ZnJPejPHgGMeBagjks8zDXH
         Z6QOtwMmcSWsqmRm+t0r7y4W+AftOM+x1TfUrhh9HSSrXLrMZ8u1UILVoCft2IAhhNeI
         LO3H2/1pK7DBU3RwXYt9/mR8e8C4YYIR9Ul+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734469623; x=1735074423;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaRXnJufUgA+sZgOmkVmsImy13QD0OXBethBAiDBkw4=;
        b=KTXcESBJqMbQ+YITHYjLlBXSaV7NEWs/zrMF4vCcVxhGZRrDdMz/oDJlx7F8+Zrypo
         E5TYEaFTSoxtk+/tM4MInU5LXXGL5qSJBMSzkZID3QrcnRiubbRRYVUyTjU9+Bs7td7X
         yV82sO4fDp3mp/yAEiaNiJjtZRvLLsJOSYJm2W9J+EvowMPoXwRDSc9ny4wSozpSMaIP
         StP5Y7GQy8RUzBf6BVCQLz4fbUuMGdncS6j/RYZVzjlM5W9897GTszqXB3ja9Vc3UzZz
         dXPi01pr3QKZ723W6CWoF4so/pM+JeAn08XPjpRtIqa3w0OWdj6gZd3G0vvy5GoPHPu3
         N2TA==
X-Forwarded-Encrypted: i=1; AJvYcCXX/Ef8qcxDS14O+uB1fUH2FRql5CwCtqUi3lh5n29xmlA+i+XhYVtLWdJSU0IB9xuFW7qgaJSBrO2XRPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/lZdL5QLRXivsmqLMtlrJfDHI0QcOiODOhIGOiHKTcy/1Wolt
	f2KiYygpgPv0BohxpapGCEueD6zQWdrAbtsx1kjztiWxo2RcCLQQ0pBEhFbpeBF4GGri4Bz24JI
	=
X-Gm-Gg: ASbGncvJFH9+boEUXvk5fwBEh5tTbJjY7SZ1DOdRhPgtNnfwAu79yE1CW7CPaH+SO0Y
	WHOpriE+fwTK+HqGF7iw3Dl2l1MNM03HQxM9469gPtUhUjWOtLpRxiItvwKG926oYPKuaBoQdLk
	wNQY51A05btqailOwRgK0Hw8Ucm7gBgv97e2gl2gEUmVpz/ufD4xfIGjvlP/RqB9NXgQj2wFpGk
	rQzU/484/9dbCmnTbsMHt8u5Tpagd1Usi0gwgPc/h+deLNE+cIUzqS5OC8eYYxwYcxpWDrOqd62
	oJEkOp9GQu4eVuIhdg03QBA55VVvgio=
X-Google-Smtp-Source: AGHT+IGEXrMxy1WDPRLI/fTTdd0pTFr9WF7IHUP8Q3LLmBM2sJDZT64JK/AWifyLauuM9iWm29j/og==
X-Received: by 2002:a05:6214:402:b0:6d8:9872:adcb with SMTP id 6a1803df08f44-6dd0923d060mr9539956d6.36.1734469623238;
        Tue, 17 Dec 2024 13:07:03 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd22f2a7sm42825276d6.27.2024.12.17.13.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 13:07:01 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 17 Dec 2024 21:06:57 +0000
Subject: [PATCH 1/3] media: uvcvideo: Swap default value for nodrop module
 param
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-uvc-deprecate-v1-1-57d353f68f8f@chromium.org>
References: <20241217-uvc-deprecate-v1-0-57d353f68f8f@chromium.org>
In-Reply-To: <20241217-uvc-deprecate-v1-0-57d353f68f8f@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The module param `nodrop` defines what to do with frames that contain an
error: drop them or sending them to userspace.

The default seems to be to send them to userspace so they can decide
what to do with the frame.

Change the default behaviour of uvcvideo to match the rest of the
drivers and maybe get rid of the module parameter in the future.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index b3c8411dc05c..091145743872 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -32,7 +32,7 @@
 
 unsigned int uvc_clock_param = CLOCK_MONOTONIC;
 unsigned int uvc_hw_timestamps_param;
-unsigned int uvc_no_drop_param;
+unsigned int uvc_no_drop_param = 1;
 static unsigned int uvc_quirks_param = -1;
 unsigned int uvc_dbg_param;
 unsigned int uvc_timeout_param = UVC_CTRL_STREAMING_TIMEOUT;

-- 
2.47.1.613.gc27f4b7a9f-goog


