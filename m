Return-Path: <linux-kernel+bounces-553182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2294CA5854D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E04F188AE4B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999701DDC07;
	Sun,  9 Mar 2025 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoChI9Ul"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A8610E5
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532759; cv=none; b=ZgOS7NC1AOVEU86zJ8dLSHFUL29rAVSQh1LqrhX79nZ+2N+LbQLGX6g4RyQ3hO4FEt7H4Egq8f22h6oMTBP08+wgSi4W//g/G3CQoRFw+Rr5W8E4BcRG9mUfBuya2snFyB29ctTK7hpNgr0vTH2EtpIWdoeCVb4YZI0oJAGt+V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532759; c=relaxed/simple;
	bh=ebfZERffrcxvr64/MPxzlnS0hE43Pk0ur9n5LoJtHXE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BkDzjLySyMJ9W2vvwiWYPF6EMK9W0euc0h2BUj6AQW2HmjWxP1qPYbUezc32NVrdeL4m2a9AC4hPxupHYXQrNbzbL5oXqgBqzbd12wkISHZ8BfCkSvPQNzYubvvY4j49ksr3pBW8WpRRYnkiCQGUNUalWGxyQTxVLPsuSG0pSyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoChI9Ul; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224341bbc1dso29680935ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741532757; x=1742137557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ozonw66VG2iXCj9BlQvmRvg7NIoSJ4Sd9BE/3KwnJQ=;
        b=HoChI9UliBE1uLkgziFNiOfBxjVZ4tg+sDbec2OfQ+QONOajED++IOSHX+Am7oedzV
         JIPcVjZD/7EMHO6bsOVh62Vd7xfSys0wANc7zWdJG9xRlxhIOE2pyXnEnLfVPrYe31oH
         lXSd1sW8yUFQB80jfOaUegOr8v9RYrbnpH7EQ471cufgQkurTdDikdbAwvVEfscJjWtR
         9SH4wEDBHmPjD/n6Uxy8buZKdLA4CwfL9ypfheEeqcW2IgcZACudzR8CiJmkkyLxguEB
         4b94EOK1slaT3LtygQjD7gJ5UmLD795l49QFqjzheN7pgyBKblBRsX8GDFYKOL9uV1xZ
         iGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741532757; x=1742137557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Ozonw66VG2iXCj9BlQvmRvg7NIoSJ4Sd9BE/3KwnJQ=;
        b=b8nRDabBFA+/zT1+/89dKyrCQbzqXsnQneXG8v578+wAJh8U6UgOzDwI9sqRWZKMB3
         +7zM4y0fnZondAOYmmpQxBRB/T6xU25BoCL+vqvjtAqoV7GJjY4czqZxOOwwLQJVxiFD
         FRmkge99Q9khZ80Ugfzi6JV/UDSjmYHfi6eqScn8iKlQ7t+Fhch2tnKi+W1FGmpLIfMB
         cxFXwHTvHC6+iZLyAbF5+dQUW4qCYaA1lJTX3zYSiqNnU3h5aTfuFQ60SsvPDAfJ2/BE
         Kf5mJZT1Z1LYGIFHytisW+5w04GKYsKmeUojsiRX04Gn9lt4jQ1BqCNKQ2r1ohPRrCZx
         d7Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVg83j6zwDLZOdSMmfTgwkv/row1+O2rnDNfyImqQVv71/LQS7Vdma+rFdAZKrXwLmVTw1dec7H8K0FUY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3V/QrRdBO6DHf21s+huCGlhGBdV73/oxcE//qpMDchx9szT+9
	MB6/J/QpqIbTI3T51lzz9gtD6amXGYYetggXeAhSR0x/kGDQKW9G
X-Gm-Gg: ASbGnctNc4jlEx6d/aTZromSLHVhwVF99w/GoXO0PnbpyCZ0/aYjnyMFqs/BORD4G7K
	zCdJmCsxohoOgmFn/uflTeFV9xSbFYXBMfbOZzA5aAuRFW+uLObNHMK3mz1gq0i4GzOqA2UMQM+
	cfIS8ZRhsupZlfIvM2VHEFS9MTqa3uUUEClArCAdpy2C7k8etLxlDOXtsEUq9l9LIXUVb7frA4v
	ePS5RgC788E6mFZkpnK4CeHdmFKA4GkPWN8lP2BrMSwh+34l7xTEvOhEOW/irfZmFjRUudCVS04
	JqJ/Aq6xe2tvG9BHTms+HpD5usCzmADUFCyoeBObIHVCxsP+UWF9+PsOBY+IMOeDuyUN
X-Google-Smtp-Source: AGHT+IF3XolKks3dhcsCKSfRs574KeRdphITuYA1m1fhh5tR6rQlFLzi7EK3NZkkbjX9v78orRXH+Q==
X-Received: by 2002:a05:6a00:1703:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-736aa9df8afmr16477900b3a.8.1741532756844;
        Sun, 09 Mar 2025 08:05:56 -0700 (PDT)
Received: from localhost.localdomain ([240e:3b1:300a:bd50:c889:b2e6:3a9c:90dd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736ad0f7eaasm4772168b3a.76.2025.03.09.08.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 08:05:56 -0700 (PDT)
From: Qiuer Zhu <chaozyhaha@gmail.com>
To: peterz@infradead.org,
	frederic@kernel.org,
	tglx@linutronix.de
Cc: chaozyhaha@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] time: Add macros to prevent duplicate inclusion of headers
Date: Sun,  9 Mar 2025 23:05:24 +0800
Message-Id: <20250309150524.760-1-chaozyhaha@gmail.com>
X-Mailer: git-send-email 2.32.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add macros to prevent duplicate inclusion of tick-internal.h
and posix-timers.h.

Signed-off-by: Qiuer Zhu <chaozyhaha@gmail.com>
---
 kernel/time/posix-timers.h  | 5 +++++
 kernel/time/tick-internal.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index 61906f0688c1..5166b832143f 100644
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _POSIX_TIMERS_H
+#define _POSIX_TIMERS_H
+
 #define TIMER_RETRY 1
 
 enum posix_timer_state {
@@ -50,3 +53,5 @@ int common_timer_set(struct k_itimer *timr, int flags,
 		     struct itimerspec64 *old_setting);
 void posix_timer_set_common(struct k_itimer *timer, struct itimerspec64 *new_setting);
 int common_timer_del(struct k_itimer *timer);
+
+#endif
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index faac36de35b9..bcccc0975f70 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TICK_INTERNAL_H
+#define _TICK_INTERNAL_H
+
 /*
  * tick internal variable and functions used by low/high res code
  */
@@ -213,3 +216,5 @@ void hrtimers_resume_local(void);
 #endif
 
 extern ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt);
+
+#endif
-- 
2.32.0.windows.2


