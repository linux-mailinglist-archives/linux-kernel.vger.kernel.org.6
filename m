Return-Path: <linux-kernel+bounces-559436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 301CAA5F3C9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09451188CFAF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B9B267396;
	Thu, 13 Mar 2025 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lfxjgeLv"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F0E266EF0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867591; cv=none; b=JHCDT/layh9EKHiVUMQ3k81DqCL6BKz4iFQdBqyL2CzBClW/s/1K2WiPZ1fzV5DptqocdwbcQ49lJXIjCJBoRh5BBuuF1YKkUEincDWTCsAOXCFpC9iGvLmIMON9FOgW6B+tdgG840eY6s8G83JA2wDtPhQPMVKHizuMu2iBqiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867591; c=relaxed/simple;
	bh=TdeKYj+nKDmLMq5rDHi0EKfmM8Q9c+Fp2RgC37HVEwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlPHh4N6QzHFiI5RCedtDlqK+2g7lNlPK7ASUFEJ78cwEj7khdU02q8raXtgCbDV6be/cABjEfxqOSBpmsjCiWf2O/iYm5MTmHlX9VmklfK/DRD4rPwHn5R1K93Bai2lC8nlchhIEk25ioTXBw8eJgLJ98nbyh/R4TLYhQnI9/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lfxjgeLv; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c554d7dc2aso129434085a.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741867588; x=1742472388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3p062ai1AaXGIlqJv8w3IqJw84i5gPWV6oy5k5lnYA=;
        b=lfxjgeLvKObeZgFihWb0q52OYllBAKTdF/4lQ7HCrmU5Ign3Qf85EdNwKEnH5McfiQ
         RlOGZj7dQ1ZuTdkFMephTsFrTUBDna2WLKl6IDTAmvfn/RK9JbprpFJa+rWoeLFANhEz
         Tb1MnLvdy/4Ecf9myTEc4r7kOJLzSIkUWPGGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741867588; x=1742472388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3p062ai1AaXGIlqJv8w3IqJw84i5gPWV6oy5k5lnYA=;
        b=MK//w4krJvgugc+TIJEBVjfEONbH9sUZenGC+7wR9F+m/cd6AamkXxWLkZuDUx7xCb
         1MmNjUtMnBm95Dpk4cZ6CM25RaFy3wBNc3op0s5Sepf5aMZpTWvemfJCYzSFr0vVhMM8
         A7zKC149kiTSk95G/55ZXhbiytBBP0/WnjkzadYXArfGM7jKOgQoOyI1cTj0Cs0aiBPO
         xoj+ZR6JW6sR6xd5oDNIBK7WVEZ1h/RzdEmDUrgTKVDVMXB+JGejRLC7s0gLTnTmAaOx
         Jofv1Uf8LZfXPWZBG+8n81EZSoTXoEJgqwLaTbRTa0JRsDFzzp8V1IDvfnz7rJHG4ctu
         pBPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu/HR8FRPJiAEbQ29X5t2E9zWh46T/4nk/dS423CKmxQ37nxEMvidRk3PQRLj6Qm+niU9O2gNpv8gA1pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkT7Lw3FEeOy5RvbVvT10RJuh8/ri54sA+mK7rTWuzduGv02h3
	StQksBCVE9EtHWnex1WJa9QWqNIUh/+pQDihHz2OjI2NDH/TT1/IKcoiXNzoOPQwqWB+BMBeoFo
	=
X-Gm-Gg: ASbGncu7OKBL/Xa6Sj2PtSdfszHKcBBEGvF45D0U9sL61wgQJKLpFUa9xBvYHIlP9qA
	vii8F6PG1whrPVaBPxIuNMRfVjpY6Sd9E9SLXWIBu9q2MNVnyYSMchp6h5zpf1QOLSavr7Sn6pG
	oM++ugDpHx2Rr9cMWTit5PNHggbc68Fn4S2bI1DBgk6XQbIyvPDk8mCTI+onsbQggqjBPRAOxpp
	61tMqTf+DlVd2m9dB9rhzzAU6lhi0Aqm7xB1g7kebZ71n5Uzsj8FmCwgZ6O8efhPk68MoXy9gaO
	dfWAipG7T3InHbyOr236lf3PiQKv5QRDglEyobnRkW0CXxrmI7FREGE9M57mW9b8B2shMzXQoVJ
	illABacLGUc/P+1AqaPCT3w==
X-Google-Smtp-Source: AGHT+IEs1dnda/05lwv48p1kChP8H4iqWWWnIRWvPPrcVe+HE60b6DEE4FUAP4bsiwKGbIpAGianVA==
X-Received: by 2002:a05:620a:8803:b0:7c5:5a97:f784 with SMTP id af79cd13be357-7c55a97f9fbmr1863851085a.33.1741867588213;
        Thu, 13 Mar 2025 05:06:28 -0700 (PDT)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4db57sm92117685a.8.2025.03.13.05.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 05:06:27 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 13 Mar 2025 12:06:25 +0000
Subject: [PATCH v3 1/3] media: uvcvideo: Do not mark valid metadata as
 invalid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-uvc-metadata-v3-1-c467af869c60@chromium.org>
References: <20250313-uvc-metadata-v3-0-c467af869c60@chromium.org>
In-Reply-To: <20250313-uvc-metadata-v3-0-c467af869c60@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

Currently, the driver performs a length check of the metadata buffer
before the actual metadata size is known and before the metadata is
decided to be copied. This results in valid metadata buffers being
incorrectly marked as invalid.

Move the length check to occur after the metadata size is determined and
is decided to be copied.

Cc: stable@vger.kernel.org
Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index e3567aeb0007c1f0a766f331e4e744359e95a863..b113297dac61f1b2eecd72c36ea61ef2c1e7d28a 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1433,12 +1433,6 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 	if (!meta_buf || length == 2)
 		return;
 
-	if (meta_buf->length - meta_buf->bytesused <
-	    length + sizeof(meta->ns) + sizeof(meta->sof)) {
-		meta_buf->error = 1;
-		return;
-	}
-
 	has_pts = mem[1] & UVC_STREAM_PTS;
 	has_scr = mem[1] & UVC_STREAM_SCR;
 
@@ -1459,6 +1453,12 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 				  !memcmp(scr, stream->clock.last_scr, 6)))
 		return;
 
+	if (meta_buf->length - meta_buf->bytesused <
+	    length + sizeof(meta->ns) + sizeof(meta->sof)) {
+		meta_buf->error = 1;
+		return;
+	}
+
 	meta = (struct uvc_meta_buf *)((u8 *)meta_buf->mem + meta_buf->bytesused);
 	local_irq_save(flags);
 	time = uvc_video_get_time();

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


