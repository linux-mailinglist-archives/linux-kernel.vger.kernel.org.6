Return-Path: <linux-kernel+bounces-422567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8F69D9BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E86AB2F910
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F4C1D9A76;
	Tue, 26 Nov 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HIvJtrmV"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C701DA10C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638031; cv=none; b=YfPVqDw9stz2xCXtNMudzMbS3CS+Ydtck+81rj2fYSBcd5ItuulWuwth2aczVEOXsG+pHjHyjOXTgh1sGa0dCbt8IF4uGEATEEyHKrE/CzE2lSL6lYpn8jG7DCbD4418XLv44/tkiU5Zh3nC8X0uwbMMatDcHkFDN2Ow+5+y5j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638031; c=relaxed/simple;
	bh=HyqCzaymRik4He7GN3tEcdLeiRbjJnfCdIYBk4WebLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rpv3+lLY/mIs6CmtuKgUdpdwJWcX9/2mew5RJ/AX95MsGT03ashAsrjClKAR3lbX2UQguM2yzVgzCSdALDAWwItptxHM+rnkRxXod2lydUmBAfSg8G6TnHcYDO4qNcuEtShZUeB8ut0sqPr4ePPYRnZ9Dde5eUOvVET47Jzk9AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HIvJtrmV; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f205c4625dso266074eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732638029; x=1733242829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqSWPss0imTjEBvgoF+O3/N5JaCFfxEYIjh5jyzakaE=;
        b=HIvJtrmVAwGkxd67/HmMmk6/2TZfIMvu60ERUNIt/x1wZ7BQT1jFskbWfHuvlfgq/I
         TZP28N353+K2rKyksjfJw8qiCQAMYF7ONIpTTVJQx5eMe17xUb5iD9TIqaWdMd8ytU41
         HkN+7IisnUfqA1uz4qlewA2na3kGXoIRonSZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732638029; x=1733242829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqSWPss0imTjEBvgoF+O3/N5JaCFfxEYIjh5jyzakaE=;
        b=pv3zSVLlPPGSi1HFvpFkl2AB6WTBnMRYJxU0UmUiJECm8cdHAqyLbunwWbxUZ39Lsb
         6pnyyznMjjWWO9sk5z81aOPisxRFHnh+gQRjZ4bg744SMhQKrCMjYOwOyzP7tUkA9tnO
         h4kDLCy7DUOPNDVLQyFs2BDdBGgqeBB9wsFXoQvNnP7JkzpsV8t6L1Z3vCFKphC1u6t5
         LaPxTG+CzggzJnUYjQ3EZJ3otMkzfvFpn+Ljtt4goGuMuCk91E9lKoRLkyPMz/yrv1Ul
         X8sA42pA1sNHSDd+6d4xfQWfJm/tHzoI4TQj2U9kH+vSpA1Cv9tdH2NI7+prwfEDjezQ
         +f+g==
X-Forwarded-Encrypted: i=1; AJvYcCUxXl0gHX3pCFIBR/hANX8+uxr4PKpjWHSi+qwvn8pjuZMZgDEFmAkyzNGlotPGYGdmicXX5KQ781P1l24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/MHhRy/5fqpO92sm+6jX3yNLoRFbaFcMz+K2rH3K4Iu93rRwB
	7Mq278GvdutpSuymRM0++q89s997KhWR+kgGWhiPJx48Z3sU7yvqsvj6ZysQpg==
X-Gm-Gg: ASbGnctwAAXQAirMhseK2rlMJE02DkbrOPhdZMamI9SEwRW5TRXeBAGL1OgnHh6Cpg+
	EwtBE7Z4RW9kmMOSaQZupN8MxeBXNXY1xBPXiIasaCPfo+DTJC/skq8tZTUiQTW5KCJvqbIvq5M
	blX1swjTCvTZMYeWyh2VQvvclV21zhLh8uX0Si73rvA4a4ZTusELWKP0meJoaK5zZLynCyJvNIC
	WoCAkyT4IvkLx28ST0Sylb85MX04nw2k2HkepcDIBTb2IPfFUtAH8YuQU7BABlBKRra+TBx704d
	fbeetJNE3pcYhCd37QcUdi0E
X-Google-Smtp-Source: AGHT+IFSeCLAxLBaIb6/TUqzxFH7lB3SI+CE6KSiFU+YQRWCA4HwT+r88u630f7asyH+jTHjbUh/lA==
X-Received: by 2002:a05:6358:9209:b0:1b8:f18:3e6e with SMTP id e5c5f4694b2df-1ca79724369mr996360055d.12.1732638029389;
        Tue, 26 Nov 2024 08:20:29 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b4e8205fdsm346532241.1.2024.11.26.08.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 08:20:29 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 26 Nov 2024 16:18:55 +0000
Subject: [PATCH 5/9] media: uvcvideo: Add a uvc_status guard
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-uvc-granpower-ng-v1-5-6312bf26549c@chromium.org>
References: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org>
In-Reply-To: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

It helps will help will the error handling of PM functions.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvcvideo.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index b63194a9c64e..c38ddd10307c 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -759,6 +759,8 @@ void uvc_status_suspend(struct uvc_device *dev);
 int uvc_status_get(struct uvc_device *dev);
 void uvc_status_put(struct uvc_device *dev);
 
+DEFINE_GUARD(uvc_status, struct uvc_device *, uvc_status_get(_T), uvc_status_put(_T))
+
 /* Controls */
 extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
 

-- 
2.47.0.338.g60cca15819-goog


