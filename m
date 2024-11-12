Return-Path: <linux-kernel+bounces-406257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F419C5D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0E1BBA3959
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C38C206E76;
	Tue, 12 Nov 2024 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhODKlZ3"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CA9206E6E;
	Tue, 12 Nov 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427117; cv=none; b=KhrVvOSR4a/7Q9S4Q1SDpof4k3ry5lZzqEcOtIpN33PgTmkzMYO7O+5TtlFi8zfUExonu6ZTzfN0WbfWS6q5vjOWQo90+NPud4YrD/3tEDvbVyrNJCgtkmmPKD9st0/2rNKKZ3yayxI51V2cSBMeLHnsvTtXUyi2r8qbBp6X1MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427117; c=relaxed/simple;
	bh=kx9RV/7hh8OxwyU6O/CqIX9Yzgup8/L0Sqd2aGul450=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W5Ja3ZBv0Xq+R6E/xbhSp6PoTR9VaPMm0YJmMD56uPgtgpNld6iHicgCLMsGSYuv+joZEuQEXYxouNWME1ZQQdjdyrpEn7+/PnwTsJQP/9b4hDAMWzSitoi2R9HBvxqO26dVHNBFMZMfOjxaxJIRyzAP5KW1i71imvcpgb7rBlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhODKlZ3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so51784405e9.1;
        Tue, 12 Nov 2024 07:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731427114; x=1732031914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKbcoc75O9Cb98zpsIShjH5Q68sP76O0sTpNDdmUgyw=;
        b=DhODKlZ3B+oSCMcRT7Iy8x+r1xllM4m1xtrqb5GCG/LVmfrxkpeyXh1XU95+jmNwt7
         aPXZ7l0SDhXSbGKLILVBwUKahCyphbW9sUBKTaYSMwgfzTzUv+4DGsRnl5Dumk6bjdjk
         dfFU7HmQ2adbC5FWBxYCNObD3Gfzpfg2u6HXXH2cvbAUMjJqKul1pEWcLdjhdT9lE3sC
         Ysr7kgz24D7lglyMT3XFrRz7oahnRZBlCzUrmZnr3cvyBhB7fY1matZ68F5PMIEAQ5Fg
         6wCZPHn4hbKce62/vbzsyYCXINeOP8eX7vcr9VXyEYs+cPn6HGVKSOikn7hjB+rrvPRz
         Ehsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427114; x=1732031914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKbcoc75O9Cb98zpsIShjH5Q68sP76O0sTpNDdmUgyw=;
        b=RSlEWcqPrn+MPtR0N7B08C/S8OqBfzY1DABZpOPpLb3oDrsdw67qJSkjywSYlmVQBH
         BKz3OEUlVU7Cd5nv3GEFUjD5UMJD8N87d5K+7OnMityl/W/69navb7MqnakFz/wjisdg
         DV1FiI3Sy3dRO9dyuCp3sEEnXrODnV37AKATVExyrUWxa60na4WoC189OTv+pFxyMGEi
         dmnC9DZaX9EcP46oX3Rg8PkHpgdpcx9wdfZ+5ZwfwB2/IHnSD5vLBgAuEIfoIpw/KFqo
         IIgwzmQFNthnr5R5DuO/mPvolORuRKvm02W7U6fhYjCfJSmCXos4v0abbhCmfBgZjx1w
         KJuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWTzuPShf/FRqVBa1uv8XGR4eIuTh3dQ5DyiDFmo+TXDZe+nyCOic367mLfmMhAnpFED8k9UBKXlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLrFTm6Cva9ci8ykSJWVy4+SlvgdIU+0uXbXqBevIAXxYgiq1j
	0e/ji0TB9pmB4e+aVb/pLCq+0PguRgPcGplUMB0/YcS6zlhBMVWX
X-Google-Smtp-Source: AGHT+IHFM0NmW34275yJbQeBGl/55ILfHlCyt7SGKx4KH7xPXJmZehxAQekfXV7mMWXzQaSI1omRNw==
X-Received: by 2002:a05:6000:402a:b0:37d:5103:8894 with SMTP id ffacd0b85a97d-381f1881319mr13351957f8f.42.1731427114129;
        Tue, 12 Nov 2024 07:58:34 -0800 (PST)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381edc1104asm15991136f8f.88.2024.11.12.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 07:58:33 -0800 (PST)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: gregkh@linuxfoundation.org,
	andreyknvl@gmail.com,
	b-liu@ti.com,
	johan@kernel.org,
	oneukum@suse.com,
	stern@rowland.harvard.edu
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	snovitoll@gmail.com,
	usb-storage@lists.one-eyed-alien.net
Subject: [PATCH v2 3/8] drivers/usb/host: refactor min/max with min_t/max_t
Date: Tue, 12 Nov 2024 20:58:12 +0500
Message-Id: <20241112155817.3512577-4-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112155817.3512577-1-snovitoll@gmail.com>
References: <2024111251-spill-hatchback-72da@gregkh>
 <20241112155817.3512577-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure type safety by using min_t/max_t instead of casted min/max.

Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 drivers/usb/host/ehci-hcd.c     | 2 +-
 drivers/usb/host/oxu210hp-hcd.c | 4 ++--
 drivers/usb/host/r8a66597-hcd.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index cbc0b86fcc36..6de79ac5e6a4 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -547,7 +547,7 @@ static int ehci_init(struct usb_hcd *hcd)
 		 * make problems:  throughput reduction (!), data errors...
 		 */
 		if (park) {
-			park = min(park, (unsigned) 3);
+			park = min_t(unsigned int, park, 3);
 			temp |= CMD_PARK;
 			temp |= park << 8;
 		}
diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index ca3859463ba1..eaa34ee0a535 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -902,7 +902,7 @@ static int oxu_buf_alloc(struct oxu_hcd *oxu, struct ehci_qtd *qtd, int len)
 
 	/* Find a suitable available data buffer */
 	for (i = 0; i < BUFFER_NUM;
-			i += max(a_blocks, (int)oxu->db_used[i])) {
+			i += max_t(int, a_blocks, oxu->db_used[i])) {
 
 		/* Check all the required blocks are available */
 		for (j = 0; j < a_blocks; j++)
@@ -3040,7 +3040,7 @@ static int oxu_hcd_init(struct usb_hcd *hcd)
 		 * make problems:  throughput reduction (!), data errors...
 		 */
 		if (park) {
-			park = min(park, (unsigned) 3);
+			park = min_t(unsigned int, park, 3);
 			temp |= CMD_PARK;
 			temp |= park << 8;
 		}
diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 6576515a29cd..d693fdfaa542 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -1336,7 +1336,7 @@ static void packet_read(struct r8a66597 *r8a66597, u16 pipenum)
 		buf = (void *)urb->transfer_buffer + urb->actual_length;
 		urb_len = urb->transfer_buffer_length - urb->actual_length;
 	}
-	bufsize = min(urb_len, (int) td->maxpacket);
+	bufsize = min_t(int, urb_len, td->maxpacket);
 	if (rcv_len <= bufsize) {
 		size = rcv_len;
 	} else {
-- 
2.34.1


