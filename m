Return-Path: <linux-kernel+bounces-425071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B4B9DBD1C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842E6B21F39
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67671C4A1D;
	Thu, 28 Nov 2024 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lsq7+dVf"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BF41C2334
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732827263; cv=none; b=YG3zpQWxdlEPMrhtfpVsOxtSH9W/VHKPpcXWJybdAcaMg7X1qXHhNJp0WVdj/HIItKry//6JzjEO/iAUhBXEAMTugGOma3UodxUsGO9Tmq753hHa4sww9jVZkFJmcL9rqQWnJVfxTHG8nmse4IIpnXG0OZ4HRofoAXlC0bJl2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732827263; c=relaxed/simple;
	bh=Y5C5MWAZhdZte1MeZGyGG8T5yKjM2AgYRlaA3take34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rQUkJjJ3Nzfnd3Pyke/RM7izrCNq1PzgLHopuTu+gnpie/K9x//F1FTCFdV/hLUp43hA7/kq64cLsgqN0kCsSaipbjD8Z6wW52JFNvgARHPGzAhWBI7S+K8V1lOfVCtcWQES7i7AsdQWT88ZLsaIjNyIt7Yvec6pmWECr0+di+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Lsq7+dVf; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46375ac25fbso7968471cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732827260; x=1733432060; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxVXaAiENeJFjrFqbCn460gp3zbaHpUySHHf/yPGG+c=;
        b=Lsq7+dVfFMBhFcAXcKAs1wOhjBWpqYJD94BbGLRVY4N2F53tQJb0Y9ikhg9ixaHWcB
         09H+bhZk38zP9Y96nrW/0lVZjiVqjLuN7HRcqlWqjnxQOrWVQm75OOCv/fqQOEA4ez0L
         55vghVnlGrV7tt+lR7wRNbJbR5fRgTKOflzyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732827260; x=1733432060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxVXaAiENeJFjrFqbCn460gp3zbaHpUySHHf/yPGG+c=;
        b=YZiiQMb7rggvADROOAyJw54Q6/3ZqqYHYV9YbiEOdu8DG3rbABxiizSm1TvJNOMQwR
         EpLs+RCewaZNuXc3VMHFchp/QAoz+Q29ZcuFOxngdRm3m0IJ3/T3pf6na5YXIyrfCgWt
         BaFrIYRkKXyLlnGR5qz51bDEX/mSt+v2NsF0FJpWJjYWbTUegFgiXj/5UQw33wNKVYQF
         SsYtYMAb5I8GGcPpbWI5qje6n4Xc4FzG2lT6XxbQKjI6Wi1lE8hpBFaRxiC0zvBseegQ
         0BpPaJS/YMMR025G8qYoJHTxB3EJv1w1tvQwqEjuOOQfKkx94Ixeq63sFVlO+5+USvwQ
         e57Q==
X-Forwarded-Encrypted: i=1; AJvYcCUU3sMwUcsM+nXYaO8S9KhrdaiwbFlgiDU+itP37jKeMUTN4FhmQP9ANI0R8C6V61rYrtqPU8sviQXNN1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbE5mhbkXcktKZudDSVsGUf0X4N7yDDa1KnmQZJ4c6BeELX34I
	vB4VVGK6u08GrtrLNu+OAqIT5uBj4m/fPO7GBOEOsWcMAAxmn5gAsYsy0mUj1g==
X-Gm-Gg: ASbGncujzvOAwAqUbyU7b0g2qW74aGw3UjM735R+EQ6L8/fR/f8twkDtQOedD4aBJdm
	d1CbtkpseHTfh8IRw+hjbKk2CPeHQLIq3X5Vf+by4zcvfs+keYXty4N+1yXid/5qPj67itwT5qU
	GXItGlmz/V/aA6RVwWKQAKUXcRRhbGqvdT+M1Ja0HArpNuOaAtb9fJLiy/XUk8Vuiz7K5xnS4iB
	bkGu0SloV5h7DxxoVheceIsObk2bJGhwk04i79FVF831WepoMrbYEvm0RueH8eQpOXEG8WxpXGQ
	7IDbcY+yZec7N/YcDTsBcZjz
X-Google-Smtp-Source: AGHT+IFhNqdJQHvPtm+cSgql+Cy+Vo9Zp6MGOSWpy0pWACKPy+MTjCMMkW6LxG7oUEPZLhW0sH4fEg==
X-Received: by 2002:a05:622a:1392:b0:466:957c:ab22 with SMTP id d75a77b69052e-466b3647463mr118797371cf.43.1732827260407;
        Thu, 28 Nov 2024 12:54:20 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c407e6acsm9923421cf.52.2024.11.28.12.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 12:54:19 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 28 Nov 2024 20:53:42 +0000
Subject: [PATCH v5 2/2] media: uvcvideo: Add more logging to
 uvc_query_ctrl()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-uvc-readless-v5-2-cf16ed282af8@chromium.org>
References: <20241128-uvc-readless-v5-0-cf16ed282af8@chromium.org>
In-Reply-To: <20241128-uvc-readless-v5-0-cf16ed282af8@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
X-Mailer: b4 0.13.0

If we fail to query the ctrl error code there is no information on dmesg
or in uvc_dbg. This makes difficult to debug the issue.

Print a proper error message when we cannot retrieve the error code from
the device.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 67f714bca417..a650d886e922 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -117,8 +117,12 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	error = *(u8 *)data;
 	*(u8 *)data = tmp;
 
-	if (ret != 1)
+	if (ret != 1) {
+		dev_err_ratelimited(&dev->udev->dev,
+				    "Failed to query (%s) UVC error code control %u on unit %u: %d (exp. 1).\n",
+				    uvc_query_name(query), cs, unit, ret);
 		return ret < 0 ? ret : -EPIPE;
+	}
 
 	uvc_dbg(dev, CONTROL, "Control error %u\n", error);
 

-- 
2.47.0.338.g60cca15819-goog


