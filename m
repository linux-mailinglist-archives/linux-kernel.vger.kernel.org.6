Return-Path: <linux-kernel+bounces-179752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1128D8C64D3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6A41F2404F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128AD5BAC1;
	Wed, 15 May 2024 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="gW9tRZSe"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A810E39855
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715768000; cv=none; b=cPK11Jc2L+cNNjUqA/vsRAIpsOHzRY6hI4HG2VSh/cn3p2S5S34OLWIH5xlokRBsWkxaZ2cmxjUIJj7BQoQqzYZ13keQd1vU/+UXZAhe2UXOjYq1YQVBcW1lBw9Ged94cLnVamZ5JkOBkB4R4bwnuOToeb1n5NVXgrkMfFphXMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715768000; c=relaxed/simple;
	bh=AqLoV3x4o52X7+j7qJv+wOgrwV27X06+t1guufZrfIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=taf9Bb3yNqp/8sKMu2+MNrTZkvx+2tjzXhlmGL4g5F8bzXNMvOGIJveOyfD+W4vkJVSoDxbyGMZXZxOEbeBzcwwGrYFBjNYVVGgCRXl84jKHuuU89IvELPOQEWN1fhBOCvFk7ly62Dc0wjPWmZ+Kh0Q30TYgFeMkrKrEUOeLWWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=gW9tRZSe; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4200ee78f35so30374345e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 03:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715767997; x=1716372797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z8kE4aGf4W+ZFrXbXFQuSqYNAtdE2dLfFezL8urZZ58=;
        b=gW9tRZSeRS2rpADWB/auQkh6m9YFfqPLi2O8kiYbl9phVeBPBBe86LoQG3pVyK1MEW
         NcGHypnBvlh1i75MkBr0c8O2Pp+Zsx4FkTfOGf5SDOWvdienfy5PO/xOPR9T4pzEhoG9
         EvHxPbppvj9rX/KVTcTgaHNgxfqjw+cgqUdWY5MbPopolBt/TWpGHIljmY0Slbfh2O51
         4RF94GalYHMAp/lEmZ1D0S7xg6zc+SPFD9vPWuFyNHn44PFuRyP2D7MjnmnhHtH7m+g7
         0FIJcUt37XUL6PEapT+flLg1joWIxujdQUlGmAAt3lbS8AAMQ5/gHqt5JFowkVSoHP21
         pO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715767997; x=1716372797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8kE4aGf4W+ZFrXbXFQuSqYNAtdE2dLfFezL8urZZ58=;
        b=sA6tdXsEVUJ/unk0TpaXqzCh8CB0Y8VxRFXSZeJFCDDFWv9sf+n8LOMVyRvFabTUNt
         SPOEyHC4VpNO2sVWbbOOdN5hE7ddE6cciCzuLHpRNXMcYwML2TMbH0zE/oCSSCRxW0Fy
         fjoUVgv9wOMkHNg6x4veVRdQNUvBNVLutik7z3bHc1HYE3X961ZvROMCwm3oHs0Ij34h
         MhiVDtZIArcOyHsXz9oa14U73Fyi2reCzBbg//pYEZAqAhH+lmKzIhnIC6hKKiutOhpU
         sGzJKQQzl7t8o2ghjHlCjVjlyHZ3KGA2iSwpsuAGRWtKLFOK1DsSxUAOBi/zgV772GLH
         uPeA==
X-Gm-Message-State: AOJu0YycK9f3QrWk3DsfYOnuBS8YMTWD7v8pFg4XSi26ivJxYRW6+qeh
	3JW4gJWUi2M/LxQKCydYVVU9AHCUlSKwXK0FpHZVFmiT5efbxA0xN5hM6Uvm6qU=
X-Google-Smtp-Source: AGHT+IHMnSblYuX4saXvavk/MZZwrr0XbBzH7gBcJD0C9fU+Tek6INy5WGEdNbNGHhVl8zAR5wjmEg==
X-Received: by 2002:a05:6000:12d0:b0:34d:95f:c46 with SMTP id ffacd0b85a97d-3504a96ab3cmr14982151f8f.59.1715767996567;
        Wed, 15 May 2024 03:13:16 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bcedsm15941593f8f.19.2024.05.15.03.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 03:13:16 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] w1: Add missing newline and fix typos in w1_bus_master comment
Date: Wed, 15 May 2024 12:11:51 +0200
Message-ID: <20240515101150.3289-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Add missing newline before @return
- s/bytes/byte/
- s/handles/handle/

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 include/linux/w1.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/w1.h b/include/linux/w1.h
index 9a2a0ef39018..064805bfae3f 100644
--- a/include/linux/w1.h
+++ b/include/linux/w1.h
@@ -85,7 +85,8 @@ typedef void (*w1_slave_found_callback)(struct w1_master *, u64);
  *
  * @data: the first parameter in all the functions below
  *
- * @read_bit: Sample the line level @return the level read (0 or 1)
+ * @read_bit: Sample the line level
+ * @return the level read (0 or 1)
  *
  * @write_bit: Sets the line level
  *
@@ -95,7 +96,7 @@ typedef void (*w1_slave_found_callback)(struct w1_master *, u64);
  * touch_bit(1) = write-1 / read cycle
  * @return the bit read (0 or 1)
  *
- * @read_byte: Reads a bytes. Same as 8 touch_bit(1) calls.
+ * @read_byte: Reads a byte. Same as 8 touch_bit(1) calls.
  * @return the byte read
  *
  * @write_byte: Writes a byte. Same as 8 touch_bit(x) calls.
@@ -114,7 +115,7 @@ typedef void (*w1_slave_found_callback)(struct w1_master *, u64);
  * @set_pullup: Put out a strong pull-up pulse of the specified duration.
  * @return -1=Error, 0=completed
  *
- * @search: Really nice hardware can handles the different types of ROM search
+ * @search: Really nice hardware can handle the different types of ROM search
  * w1_master* is passed to the slave found callback.
  * u8 is search_type, W1_SEARCH or W1_ALARM_SEARCH
  *
-- 
2.45.0


