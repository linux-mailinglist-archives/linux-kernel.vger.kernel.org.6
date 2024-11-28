Return-Path: <linux-kernel+bounces-425069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D79D49DBD19
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993FC281B69
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432681C460A;
	Thu, 28 Nov 2024 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hH89A8WH"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE21C3043
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732827261; cv=none; b=WqFvjehJhQXKL1Kb9bNSrPqae1riE6dGxF7s17EoeeZsPosO782ptxtTuskf68wSelyl9r9roKceZBr8RkwfxSDSS3fDXTtRxw7hVRFtlYeEnMQE9YPgFPqIU805M6nTse2l5pXvuqSmBAEIC5E5PhhacCSSnQXTtUs3b4nBtC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732827261; c=relaxed/simple;
	bh=H2sUBB+fsICTdnFjz8Lj6jJqXgJsJGlzoShvTjrlPXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AQ0unLsxoj5wq7/pHFhYjelNmTlhv37DYoGroLy0V9Oxa25z7SzTObcTCCasIKE/1Esvp6104DPM3ZqX+0h8S+Wvijfe/6g/sboKdhJ2YM2qscZwZKvDYLYV2HLVIHlVOkxl/FBgWNQYLiilQCu+RY6vxPduCUqsh9Jt5l3EZkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hH89A8WH; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46684744070so9423901cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732827259; x=1733432059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4fn8wn/VKVd1lfp+Uuux+ZckEB87hkFaLSp4OUxjOQ=;
        b=hH89A8WHUG40tV201+z2UytElqO0LZFfvRmZ+eqK5zNiTc7jsWhaBu9sU8m9g4ALLQ
         4DDEss1NpXkE0+pYMyPRqEmPQGtL3G7yHltYR+KWtUDAxevdE+3tpbovp2PKQRMlDFpf
         GwNmOBQK3PhDGWkfz54onmfCP2YYkzukF00io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732827259; x=1733432059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4fn8wn/VKVd1lfp+Uuux+ZckEB87hkFaLSp4OUxjOQ=;
        b=vQxEdJmZq8Ywu2Rv6acZF7pB3ZAvrYWiRXXOpvXkWYUFT8okCtBkYabi3yI+tmkhwK
         e/dgwLYSsOE8+HvT+EVSjhq6CbAQPJmzAZwgCBasEwRkBVoEARBlzPgLdN0el+AGFrRo
         CleKx970L0TgcfmgKOPnTvXmJ6wj+Pe7gg7Pee2bniO+oShhnnKyP/ldRI9bRYS3ygqz
         wYXoh9CB6EmKDcIEnaYUltan1xifMsZgd31H7pOBwMixMF8nHpl1p5XU/J08aqwKwVSA
         HnHdQsT2lfR83/DQfJgrnHYuh5mAvrY/N7UBARlULLGwOti9+ofiLxUhM/iVhsJ2ukpU
         EAtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsKTuYSxOOofaCev5q9ADSMWiSNu6nCkD8+XGF3R2wEUZqbSs5rheR8INbyKO6KeErK+Pkmg90z7R8zlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw40sUPEVnui/SuXBFW9J3aDil7Vnj1zAfk7xT0lTRhcz04FSxG
	7+hxoixY+ddXURGpqhU/tJvAQpfsyAhxpoFmLPaxjPbMv1Cs5rx4pkOhOXcvSg==
X-Gm-Gg: ASbGncv56UaYhgzRzAcKMfunli6H32J/gLwanJuoBoQm6NoQxk/cGB6WNw1fgBhM9CV
	3ViRC9vzfAJ2olfwmUC5TTnjm6VOFdjuyJ34/5/u/q1KpiXOX4xUhBmSkbcRnuFwhBCAXmhx8rE
	vO9nJZiWItb6HKWMZAc/jco1Cy2zxRoqGF6E5wjwHBafSEcFCYzV9w9DnuaPxqKft8+et/mVSAO
	lRDO3J0aTC31mD9LMedA2pv2gqx4J350z2oGIEWDIowLNmxkwCiXZSFmUuFrMJUkRwaApuzK7hi
	HwDbXlaS24rRzwpqSwfhnosh
X-Google-Smtp-Source: AGHT+IGsQPPcE1Y6kRMFJwvkPvXDD4RZbAEeird+u3mx85igV+v5RYgUf1lgiIsUgpYQjUBWW7Ft1Q==
X-Received: by 2002:ac8:5d94:0:b0:464:c8f2:e553 with SMTP id d75a77b69052e-466b36549f8mr88277511cf.42.1732827259063;
        Thu, 28 Nov 2024 12:54:19 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c407e6acsm9923421cf.52.2024.11.28.12.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 12:54:17 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 28 Nov 2024 20:53:41 +0000
Subject: [PATCH v5 1/2] media: uvcvideo: Support partial control reads
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-uvc-readless-v5-1-cf16ed282af8@chromium.org>
References: <20241128-uvc-readless-v5-0-cf16ed282af8@chromium.org>
In-Reply-To: <20241128-uvc-readless-v5-0-cf16ed282af8@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

Some cameras, like the ELMO MX-P3, do not return all the bytes
requested from a control if it can fit in less bytes.
Eg: Returning 0xab instead of 0x00ab.
usb 3-9: Failed to query (GET_DEF) UVC control 3 on unit 2: 1 (exp. 2).

Extend the returned value from the camera and return it.

Cc: stable@vger.kernel.org
Fixes: a763b9fb58be ("media: uvcvideo: Do not return positive errors in uvc_query_ctrl()")
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index cd9c29532fb0..67f714bca417 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -79,6 +79,27 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	if (likely(ret == size))
 		return 0;
 
+	/*
+	 * Some devices return shorter USB control packets than expected if the
+	 * returned value can fit in less bytes. Zero all the bytes that the
+	 * device has not written.
+	 *
+	 * This quirk is applied to all controls, regardless of their data type.
+	 * Most controls are little-endian integers, in which case the missing
+	 * bytes become 0 MSBs. For other data types, a different heuristic
+	 * could be implemented if a device is found needing it.
+	 *
+	 * We exclude UVC_GET_INFO from the quirk. UVC_GET_LEN does not need
+	 * to be excluded because its size is always 1.
+	 */
+	if (ret > 0 && query != UVC_GET_INFO) {
+		memset(data + ret, 0, size - ret);
+		dev_warn_once(&dev->udev->dev,
+			      "UVC non compliance: %s control %u on unit %u returned %d bytes when we expected %u.\n",
+			      uvc_query_name(query), cs, unit, ret, size);
+		return 0;
+	}
+
 	if (ret != -EPIPE) {
 		dev_err(&dev->udev->dev,
 			"Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",

-- 
2.47.0.338.g60cca15819-goog


