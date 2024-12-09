Return-Path: <linux-kernel+bounces-437860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FFA9E99A4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8112D1885578
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605231F0E2B;
	Mon,  9 Dec 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="dwRcVnqK"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD481F0E23
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756175; cv=none; b=NoQCDayPICsyQryu/q7z+WfJLvWcIlfpn9A55+QGHg2F3QVys22SK5bR8rfimGuRgVKsYyeupaizI5NEBdPjv+ZpDoHodqp2EyF5HpRScCBqB7lg7ZEdlTWl56qbfDE1Am8vyubUeQm65Ao0O+NRFpYOirRLKB+XKRrNvtD+E9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756175; c=relaxed/simple;
	bh=v7fEv+PQgG49lk4iKaJBPXeCbWAcgmJ4OBYd6cOxNC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fkyO0X9Ly83z4MeYH3fEkT5v5EfNhRXteS9jE7/pppWjenmgdqEGVLJZzEX9h1X7iTi2G/39Jk4adThYyTb42May/Znp5Y3qW+EjQJPoHazEcsauxWI2JjTeuGW3lstgENsNKtPQ19UhJtTa+rhJcgM7JpmSMDrIYgHZR/FPbCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=dwRcVnqK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434f094c636so10542475e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1733756172; x=1734360972; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h9/sTnTDQc8p68+X06XluYmO4nBose0FpqExl64Pr6M=;
        b=dwRcVnqKAgq6uHprOsggi0YGVyseb5g60WJYDwQrOFJbpBO5YXMz2XNKGBG0HC4JoI
         q0vDVDTySShKqrPIlAklSzCw3u30pVb29lKqKUuXHPuLaCxzSsX+Ca8SXMDQaemscAjX
         vhyUJ1oJvlQgt0jn3oJt2+D3w8BMJGCUMRXvcn1xQ9zMy7ZGOUrczdV9zDWhdEH1aFjb
         dDCYKXWRW3q2onHFwzYHs+Wytw60wbBLkUMc2YebG1m9zxoConwDnYDckn5hwm+YVI8x
         0Ps2E/RVETugnb2xJKkv0H58F6fNBcDT1vJooOhaO4r+OYo12byh0RisjnVaVN1c2P5T
         ITog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756172; x=1734360972;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9/sTnTDQc8p68+X06XluYmO4nBose0FpqExl64Pr6M=;
        b=uQ+buLp8sseFSYxG6tKrkNltZYLiBXRVDsthT06KmOTkxUwCbeT22eiQtcYoCpME/1
         SNOK7qh21g/TL13nyQ7SrTCIpPM8lJzETyfGVh6W6j6DfPyAFhK5vLJLKLVpluNXnF+m
         nFD+PZpEcjpEWX9BSPEMPevRhNZdhiyPZZ9SddTxBEhFDI/CnbLamOWlxsD/UEe47QTc
         BhR3HecRaCcoq8sBECTwRhB13UFFH9VUncfpmyjSOZy5jtDqHgkqexZr/cd6JOxfRg1F
         yZxATa/Su0NL+JnLitLth/67l45/bcS5YwXl2sMDmyw4SVij7+TqqFutv14Zn9l20760
         4Z+A==
X-Forwarded-Encrypted: i=1; AJvYcCX8uuAlYOKFTDRcY0hMyfdyV8iH1KQG/uLjQeZ/LzMJdTpF5GzCRk9eE9zbQR+ai47ph+DxGUf31Envx0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9qHRadWyeyJ9Aabr9DD1XHlSDsQtavsCqOuYcBvMXpAkJcEIz
	XIvRwflnr/ywYPrXHrJBY8yiT4hXd89QyAyM99s/RrG0dfkPN40bYpPzIoYGZ3E=
X-Gm-Gg: ASbGncsk7/2PGVBPr/vS4pRFzDkJfUR9pfr2a8kRxYyV7nIr5aJjiOyyLPliaCddlsr
	blONQUkQQSYdMa6ifk0HlzulMl/GBCJFirPRJIQqVaVDcG9nzf3T5h2CbKRQDverfTlFUvWhKta
	pfT2a5cQQ2GNLN7kd4/hCom8hvT21KIUsb6Lx9X0dUrek+ja2qZvNNtYY5q76MPa0umAUu9sfs/
	m9tLkN6tlvvTzWQODXAuY1LLBdM1lA9uBBKN2E3Eg==
X-Google-Smtp-Source: AGHT+IHhHCXqjaznY5Q6KEGwqqpPsaxnnFCKGS+fgXu9MlUG5T4//fuuGvyhnK/fDHt70l+KnjfY4w==
X-Received: by 2002:a5d:64ef:0:b0:385:fb56:fb73 with SMTP id ffacd0b85a97d-3862b3553cfmr8496529f8f.15.1733756171744;
        Mon, 09 Dec 2024 06:56:11 -0800 (PST)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3861ecf4119sm13221887f8f.14.2024.12.09.06.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:56:11 -0800 (PST)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 09 Dec 2024 14:55:45 +0000
Subject: [PATCH] media: i2c: ov9282: Correct the exposure offset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-media-ov9282-fix-v1-1-d06bb7546f18@raspberrypi.com>
X-B4-Tracking: v=1; b=H4sIAPAEV2cC/x2MywqAIBAAfyX23IIuRdmvRAfRtfbQAwUJxH9PO
 s7ATIHEUTjB0hWInCXJfTXQfQfusNfOKL4xkKJBkzJ4sheLdzY0EwZ50Wp2SlMYaSJo2RO56X+
 5brV+mx3ztWIAAAA=
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Martina Krasteva <martinax.krasteva@intel.com>, 
 Daniele Alessandrelli <daniele.alessandrelli@intel.com>, 
 "Paul J. Murphy" <paul.j.murphy@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

The datasheet lists that "Maximum exposure time is frame
length -25 row periods, where frame length is set by
registers {0x380E, 0x380F}".
However this driver had OV9282_EXPOSURE_OFFSET set to 12
which allowed that restriction to be violated, and would
result in very under-exposed images.

Correct the offset.

Fixes: 14ea315bbeb7 ("media: i2c: Add ov9282 camera sensor driver")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
This was picked up by one of our users noting that images were
going dark for captures through libcamera. libcamera was resetting
vblank and hblank to minimums for the capture, and that put us in
the situation where it broke the datasheet requirement for
exposure being at least 25 lines shorter than the frame length.
---
 drivers/media/i2c/ov9282.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
index 9f52af6f047f..87e5d7ce5a47 100644
--- a/drivers/media/i2c/ov9282.c
+++ b/drivers/media/i2c/ov9282.c
@@ -40,7 +40,7 @@
 /* Exposure control */
 #define OV9282_REG_EXPOSURE	0x3500
 #define OV9282_EXPOSURE_MIN	1
-#define OV9282_EXPOSURE_OFFSET	12
+#define OV9282_EXPOSURE_OFFSET	25
 #define OV9282_EXPOSURE_STEP	1
 #define OV9282_EXPOSURE_DEFAULT	0x0282
 

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241209-media-ov9282-fix-a1ec012f5272

Best regards,
-- 
Dave Stevenson <dave.stevenson@raspberrypi.com>


