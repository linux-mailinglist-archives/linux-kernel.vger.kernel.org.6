Return-Path: <linux-kernel+bounces-319478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD92C96FD2D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 23:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92301C21F0B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288591D79AD;
	Fri,  6 Sep 2024 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KfW152WU"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C411B85F7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 21:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725657299; cv=none; b=HTix8p9+Ur56E9VMMfcFJPJEMK7Y6oFTux/IlAHBNM4PawB78eHD1cHbh/PduSZzDHVYyvb1w2NSsY7XJS6tEY671Pd/G/jsNrtZTrnDCMeSHqLS42HKuisnjlHZIjSZKs3IQWHRPKjVpujC7PdJX3k7MGe2nYOeytEsYAhxoxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725657299; c=relaxed/simple;
	bh=ZEvUEorOsia9rQcPYFPa22tCoLVCyg1slnig8NMKf50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fddNXV8QpwVF9icmkqVPjfCe8Ntr5IliuRpidxp4pB4QXx0DYHUWTczZThnLAuBN1Xo/2kiwkZZXIMXOf+9AfqsGDTNQBjkEA+qlv9HVLKgo6rnzyBixuSWat/HXOxOe+GQg4xmH3cJO8v5sPyaZcVS63vldgPB/LiQau3uiHIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KfW152WU; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-49bc13c3a47so1015200137.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 14:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725657297; x=1726262097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs9aVK4sfy3gpXBpKGUO42369WUFZ09m2WcyDCsX/ac=;
        b=KfW152WUvRKNpsfg7492fsYSrqcNXTAYHl9X65e2wLEhY9Z1nAGcS8aq78q3VCzWrG
         lFVPmi1FSHyJLpFIBACn2ZDjopYjrmEMxRZX1YcNu94YA7MrahtCrSdmukh5RYIZPFIh
         zyEkkttilsx96epy224zXFEnoO2cRWWIRM4mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725657297; x=1726262097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cs9aVK4sfy3gpXBpKGUO42369WUFZ09m2WcyDCsX/ac=;
        b=lNZysrHMX4sYwcx971rAh0Tu/pK0Zrkoir1bT++0gxO1bAoHCuPjPuPJJx65vbNTsJ
         wWmTTiUsMStWlQDofCdap+XpOPS+18BOrqD5vsbaymzEJt1b5wfgEKj/bACKlaIfm0t4
         hwzQdqZKV9cnyxN84RQ+oMYK1zlNQoVYHhLchAjrlIx0hMQs84T/tX5Z7K7PczVffrFa
         ADARxJ3oFgY6um42imdmyLAHbbyFwmDSd+Yegzd+WFu9dEyE0+RWDDgPd6eOEZFvETPW
         OWxnIfQ7eIVn8wt83RBpkYUeAoY59K/4TQCq+mrogqUK/HJcrlQA7eXEW6s2COmK2P0o
         vJjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvi4dIsiRAtqnPVjDxcLOnpPsben/0UbWTFrax9pUYmoXhnncY+VJkJT0+6PhxEfWLCOTv5r64oyqZWEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBYx1tOUGt+XMj8RdKG38aaH5k5wzL3y5jBwJcwxeYaJjQOrNg
	6fUNtDe/mgiHd04wHAfFmX6mdCtz9iiCn5MnIEsZIGT318WPzz02ibjT3VTs5Q==
X-Google-Smtp-Source: AGHT+IGu1gSdn+TAhuXyZYC0Jo1w5AWPPH8ZYSvd0b/4lADstyEw4lDaVQ72agnawfprbU0iJrsTYg==
X-Received: by 2002:a05:6102:38d0:b0:48f:dfb3:f26a with SMTP id ada2fe7eead31-49bde1c74f5mr4625071137.15.1725657296870;
        Fri, 06 Sep 2024 14:14:56 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7a99dc0f8b0sm63299985a.23.2024.09.06.14.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 14:14:56 -0700 (PDT)
From: Joshua Pius <joshuapius@chromium.org>
X-Google-Original-From: Joshua Pius <joshuapius@google.com>
To: alsa-devel@alsa-project.org
Cc: Joshua Pius <joshuapius@google.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"Steven 'Steve' Kendall" <skend@chromium.org>,
	Karol Kosik <k.kosik@outlook.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Add logitech Audio profile quirk
Date: Fri,  6 Sep 2024 21:14:38 +0000
Message-ID: <20240906211445.3924724-1-joshuapius@google.com>
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

Signed-off-by: Joshua Pius <joshuapius@google.com>
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


