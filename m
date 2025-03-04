Return-Path: <linux-kernel+bounces-545450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D08A4ED4E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A14718908B3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAC724C08E;
	Tue,  4 Mar 2025 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/d7Upz3"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCA625523D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116489; cv=none; b=KQxO8y+5Bj+/xoJOTYP89yRBgbIeAGLkYYptiYudc9j3yaZ9hmW5p8/fz7f2Ry07Dr6OJpcPtM/72gcwtnyaORwre27gwFwY3zOOy7+E2mORERK/tRWrw0U+Y8grpa1Adkemwdqcb/qf0e1o1eFOLlOQuFoFkN8sf2WN4TYjDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116489; c=relaxed/simple;
	bh=R9opTtkqiR3EVB5DiuJYrC8B6crJ7i7OxRy9XNgNAB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Km22ViYj/eLugBLBNXx+o+8wvjr8wNm2oS7adeXn5FlczxopH7ov08QbxC7qyCbhuBFXccah+sGlaBus+RBYNU3UWnFNnYiIh65iCj2+HduwJc/7+VZdi2QgLKWudeOGLBtLx7sBt8k5VXK/RWy9pnmZMd7WFEkgtacJ9cXOJUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/d7Upz3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2232aead21aso15999375ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 11:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741116487; x=1741721287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epmOVtfS9+Yo2ZaSmvnox3J1qzYW8Hx3jkXGEoYH3uA=;
        b=K/d7Upz3A8fA4nJHoSzfZNAARmoNXH5f3vCkMaEL4UJf98B36zhEvX8/gEeyhBtGQq
         /uXyfcpvlyotiObErqQXjY+CB4rlVrzxa+FCd+ZMT7jXd2PYiE43y3TLBp1k489rqge5
         v03wxR0cJrpbbPhjN1H15MgNoZz37J6zQlOr/GKjVmcOy13xT2e8rqt3kpt2YQiQBIdn
         hDXGcb85hj/MIL3Mo4i7NZCIrGerss8nKovPMUsZFoEGO+RQppHe9HfHwnN56jvyQSVm
         h/+PhEAawoer6PwRg5/lfoSY2u8c2xMXh8T63dwkATNo1aNMwp/bO9BI0fGY2RPWo/nF
         fJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741116487; x=1741721287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epmOVtfS9+Yo2ZaSmvnox3J1qzYW8Hx3jkXGEoYH3uA=;
        b=q3XLTs6U26iCigRMU16l+YoShvrqh3ZTLhRxnufyU6sb4/9ZWx41N0WdxIMbHWY7H5
         kBuGGF+9z5Ttu1i/HZBZODq2+Ck7DIL0PyK4ccRyWmR2lZ1R45OqOengX/rTbgXhRGhR
         PYHf/f/v5rGfsvl0Equ5wQDpvS5jvFwStDXeRshOkt8/ibazze3PU777Ua955n68edhO
         crERnDcw6I/qKs/xZy4FSnlB4g0egawVfKYJbLoD9HqvfebYX5cxNS+CoirSCttNrByX
         0tKQUemgo6wY7eXLWp6SoxXjN8v2nVZagHNQqJW0w3WMK8mf1N9ptXBOXHEecbUoKM/x
         EJ2w==
X-Forwarded-Encrypted: i=1; AJvYcCXnKLG0yY8mqkwkCnXTIZwzEhx1HGfDtuG0y8GSrSrWxyPor7hhxFgFqWj6qSrVWm9+qosA4+SfpTFXNsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyftqOATPwY8dQ7cZqyg+OCmwy1RWb5UksUfoAE4IcYkehu0eb
	auHACw8S9Z7ecZjEyGRHn86NlqHSMJp3XrAsAT9OKZskaqgrZD0b
X-Gm-Gg: ASbGncvZy7hjb3pMS7oNHKLv+Wl5RniSHCCYkpLk/D6LgXnh2CE24AwjK+WTef7SRRC
	XFQtG/VI4TUPoQqTZF5m5qxInQL3w+Sy+FVxQwYiGYh5Ff04BwiLQ0l+qTdOdtaTiA2t3G1VyHQ
	g2pe6ddmen3VrZl+vF78ObaBXAmqGOzBdoPfMUD7e+Ardth19B5hLvG9EIiSwtyarH0bYZM+uD1
	eAkaD2glfJTq0YfilqufjLQTE/AIMCs+bf4P63aiJ1OK3pQ3w1gmFQ/1RsUY9AcOXq9ZRNA8Vqy
	jvlzGCQe/ZulnpJPYmd0i3RtgZI1AaZTQayHuYK5tgfEllrSc2WoxOXrfg==
X-Google-Smtp-Source: AGHT+IEdX0BHGO1aNI4wvVQv2mPr+fwnaDksYZRGrdWeJn/GT7+TqDieWrNAWkuFEHO7F4AFLt2RNw==
X-Received: by 2002:a05:6a00:244f:b0:72a:a7a4:99ca with SMTP id d2e1a72fcca58-73682b4e2a4mr73072b3a.2.1741116486856;
        Tue, 04 Mar 2025 11:28:06 -0800 (PST)
Received: from localhost.localdomain ([2802:8012:1f:3200:f1d1:c186:ba5b:8f06])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734d444a9fasm9341920b3a.60.2025.03.04.11.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:28:06 -0800 (PST)
From: Gaston Gonzalez <gascoar@gmail.com>
To: linux-staging@lists.linux.dev
Cc: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	dan.carpenter@linaro.org,
	arnd@arndb.de,
	niharchaithanya@gmail.com,
	jiapeng.chong@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	Gaston Gonzalez <gascoar@gmail.com>
Subject: [PATCH 3/4] staging: gpib: fix kernel-doc section for usb_gpib_line_status() function
Date: Tue,  4 Mar 2025 16:25:41 -0300
Message-ID: <20250304192603.40565-7-gascoar@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250304192603.40565-1-gascoar@gmail.com>
References: <20250304192603.40565-1-gascoar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function name field in the kernel-doc section for the
usb_gpib_line_status() is defined as 'line_status'. In addition, after
the kernel-doc section, there are three macro definition instead of the
function definition.

These issues trigger the warning:

warning: expecting prototype for line_status(). Prototype was for WQT()
instead.

Fix the warning by renaming the function in the kernel-doc section and
by moving the macros at the beginning of the file with the rest of
macros definition.

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 090857824d07..f7dd0809b06c 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -78,6 +78,10 @@ module_param(debug, int, 0644);
 			dev_dbg(board->gpib_dev, format, ## __VA_ARGS__); } \
 	while (0)
 
+#define WQT wait_queue_entry_t
+#define WQH head
+#define WQE entry
+
 /* standard and extended command sets of the usb-gpib adapter */
 
 #define USB_GPIB_ON	 "\nIB\n"
@@ -131,6 +135,7 @@ module_param(debug, int, 0644);
 
 #define INBUF_SIZE 128
 
+
 struct char_buf {		/* used by one_char() routine */
 	char *inbuf;
 	int last;
@@ -644,17 +649,12 @@ static void usb_gpib_interface_clear(gpib_board_t *board, int assert)
 }
 
 /**
- * line_status() - Read the status of the bus lines.
+ * usb_gpib_line_status() - Read the status of the bus lines.
  *
  *  @board:    the gpib_board data area for this gpib interface
  *
  *    We can read all lines.
  */
-
-#define WQT wait_queue_entry_t
-#define WQH head
-#define WQE entry
-
 static int usb_gpib_line_status(const gpib_board_t *board)
 {
 	int buffer;
-- 
2.49.0.rc0


