Return-Path: <linux-kernel+bounces-326856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EBE976DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBECBB23A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BF61BB684;
	Thu, 12 Sep 2024 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n0pCXTZ9"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1D21B9B33
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154803; cv=none; b=A4IH31WEDTE5jFiH5FakY04UaeGKxnt1zjYfz1Lt4KNk1uJ1JRrZSfMFxPCbs13w+YIy5/ofMGD3SaFbR2ThL7dee+JMxqA53K8iQSlH4wqXDXidB2odSZyIR0z6GcG7VHGyqDRSo7M5O5vbnrm2FrPWu3ByHWXGv+UvPZ1C9Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154803; c=relaxed/simple;
	bh=NKleTICc0uMNXV+uSqzUKeNAhOpKOaLVEKAQqBNY/Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XzFxgNpiR8VDUC0Svc0QCFJGbqq+2Ku9RxmLuCdBCC9Hcj8l5xLXLQAC+4Dnn9Wy3yb/j0fX3nN+KjjlWFQUES/ymgCtcuZmy3geI6tqkOilKXpOxDd9FuppmzIjpwN3IleXrkgxekvXwYLupV2Skb3o1T3Sm3VpTClncN5k3iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n0pCXTZ9; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6c3552ce7faso9153186d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726154801; x=1726759601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f7mKFNRTjjADvwf1aB253Jo1v/0MMVkR0nsmT+lRjwc=;
        b=n0pCXTZ9R5rixccQ0sYLNyFAkA/F8gAFh84j6NRrPDV+w0ToFBZ0uAkERuvCWRdP6K
         DPjj0oc8YvThDFxM/SqBDJGJm5kEm0dzLx4RTrAWRoXAFoZm2400X7m1CfCSKN1PfrK3
         cLq41qBKciBwYx/y+qdT4OlLBcLKUrffwW9wQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726154801; x=1726759601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7mKFNRTjjADvwf1aB253Jo1v/0MMVkR0nsmT+lRjwc=;
        b=q5a7S3GmmJWKCmTm66I7SHdj2YJQx0mJWsiNbTt/rGYX0riCkcIh897w4dLm8eV5Zr
         rBQPy5QrR4CWNTJpTbiERWergO+lqpuDRzw2FZXncdDPBQ8boqmx+NiSQZC6HfUM2+nS
         QdHyRFX5SjXbHAuTPeJxZ9E/XeiTPDqmHH1IzJiVoehw9R/AC8kMnsf0pQlW1GQ52iOU
         AlNvtPf1301McS0FJwwLjPtQ4dWgc2wbAQNXTiSAXCxJnolaGR23b2pULnZnQhG2mHSf
         29r+0/zDP9gkhA6CKE7jxcceOZ/FMFZPrlc9SZrvG9XxJiKfNim7iv1YvHoAIZeA4yF2
         CdDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUulwewHudb9XPCUEm1Uh1LMPvhQ10d5uoqhMFY1/eFDB10T/qBdJGus/rnCehVCE4zGQ62dx7vswBF1nc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2wKQfcEojQ/6mPekIetIlyE+uRcj/wE61VFMUlj4AP7lAjpJS
	Qlr/FeTZhC+DmP4KGJy3OItPUHQrkX0N8J/2ZFnmNQWHiD5HzCELSqWfKgPAzQ==
X-Google-Smtp-Source: AGHT+IGchvvlGNJOgyNzd+nGz4P624xph6cEj7rU2+N8kSWMwUA5os9jZO8OZ32oNgHPjsbZb/wcFw==
X-Received: by 2002:a05:6214:5d05:b0:6c5:50c1:befc with SMTP id 6a1803df08f44-6c573b21fd7mr45928266d6.20.1726154800674;
        Thu, 12 Sep 2024 08:26:40 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6c53474d749sm55476786d6.92.2024.09.12.08.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 08:26:39 -0700 (PDT)
From: Joshua Pius <joshuapius@chromium.org>
X-Google-Original-From: Joshua Pius <joshuapius@google.com>
To: alsa-devel@alsa-project.org
Cc: Joshua Pius <joshuapius@google.com>,
	Joshua Pius <joshuapius@chromium.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Karol Kosik <k.kosik@outlook.com>,
	"Steven 'Steve' Kendall" <skend@chromium.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Add logitech Audio profile quirk
Date: Thu, 12 Sep 2024 15:26:28 +0000
Message-ID: <20240912152635.1859737-1-joshuapius@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specify shortnames for the following Logitech Devices: Rally bar, Rally
bar mini, Tap, MeetUp and Huddle.

Signed-off-by: Joshua Pius <joshuapius@chromium.org>
---
 sound/usb/card.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 778de9244f1e..9c411b82a218 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -384,6 +384,12 @@ static const struct usb_audio_device_name usb_audio_names[] = {
 	/* Creative/Toshiba Multimedia Center SB-0500 */
 	DEVICE_NAME(0x041e, 0x3048, "Toshiba", "SB-0500"),
 
+	/* Logitech Audio Devices */
+	DEVICE_NAME(0x046d, 0x0867, "Logitech, Inc.", "Logi-MeetUp"),
+	DEVICE_NAME(0x046d, 0x0874, "Logitech, Inc.", "Logi-Tap-Audio"),
+	DEVICE_NAME(0x046d, 0x087c, "Logitech, Inc.", "Logi-Huddle"),
+	DEVICE_NAME(0x046d, 0x0898, "Logitech, Inc.", "Logi-RB-Audio"),
+	DEVICE_NAME(0x046d, 0x08d2, "Logitech, Inc.", "Logi-RBM-Audio"),
 	DEVICE_NAME(0x046d, 0x0990, "Logitech, Inc.", "QuickCam Pro 9000"),
 
 	DEVICE_NAME(0x05e1, 0x0408, "Syntek", "STK1160"),
-- 
2.46.0.598.g6f2099f65c-goog


