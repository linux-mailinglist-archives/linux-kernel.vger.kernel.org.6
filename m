Return-Path: <linux-kernel+bounces-223234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8AF91100A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AFA92882E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E561C9EB8;
	Thu, 20 Jun 2024 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBVFz+TK"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E651C9EA3;
	Thu, 20 Jun 2024 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906296; cv=none; b=AJz7sxfLS9m+ZGrVlM9JDEbiZw3yDIHnRiQN0NEL+xww4/MqOG9NXozwEREhx6A+9B4m9U6UhdodAkS4yY7422SQCvNZ2ngVEpZADH12CWhYHzERpsYTMsI9W58En6XXQ4PyEXLNtuW3+JQUEjW+f//zOY5bLrQvTQPruOzHPuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906296; c=relaxed/simple;
	bh=KdbeHfsgkowpARY2YPlVsmqqW/kJIUxTm29Tdz3OOA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pR4Bxj1THNVvdCpEVRm2wkqxOTUPh67aNJofFOSdMsLpfJIp4DG41wMUFI2YC9fTTZ7dpVruCvKuq4VzAylKjWEm/8u8ytXBNMtiYBJ6ZrXpeCO6nyDlxb5flaaSZzLBTYZerKSPQ2kS/XWZwdlC0AIgjOS1yKQnvWCeJC453uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBVFz+TK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7041e39a5beso983536b3a.3;
        Thu, 20 Jun 2024 10:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906295; x=1719511095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3AS9JVo8Hs/Ti3mNv2gE0HU0UAaWpI1VlkoQQK++VU=;
        b=ZBVFz+TKCMu/ZNUGyZgkeYz7BF2GY99DH+ew+oY29ZTzSudv9CTbrbkXE2QUADVoCj
         9JuiHMxaUWVmzUIC0tDiULah63aKRdOLeHGLcvq/99stzfi1+o7B5s55HaqKpnqgvf8w
         6zD2d5cR8HcRewR0Gmo8/ZJhFx82qzYSJMD8uvrVy2bbJb14dLPgZsG56Eu1H3CCPdEC
         9wwktf3fbXD9F4swDyo5bkbhfXlbe5hAu7+32nerBrPtXDwE6yG1oSRZ86pZ071hVOAF
         PWXY771grJZriqpL81+VBS57ISK1ouJSDy1AuXOgd0vCnH/icqHj630rRvS+7Fp69/ZH
         bm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906295; x=1719511095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3AS9JVo8Hs/Ti3mNv2gE0HU0UAaWpI1VlkoQQK++VU=;
        b=ryOD4z3/pG4zvn1kqKFjGgz1gam3GocHeZ8I+L7r3t+ZhdiEvt88uUDPY5h5yRvB2K
         1LwFPv93po/FBdwQ+esa6dXVgiNvhplPUQA7Hq5SsrPpGLElZAzql6HG8FlZczmMUjnY
         Q5WnSR5s1c84EgJpDudk2DTWoJOrExIZk/YWryoDyapr+w2Bf/CJICvdU0PDozXa/L+Q
         GfiRgrBzZjgcSPNJmzD7eIurJGU92lKUXOL8bSv1CdSDxvE2U6ptidOpGO0lyxbB5vW6
         Mq/bD4xUWGZCq9a2MasmDn4D2yS7BFemxgZTwl3Aeb0BGKaQjD1PCuG32SwOuBUH9L7l
         WrAA==
X-Forwarded-Encrypted: i=1; AJvYcCUMPOOG1sIqitwJy0fz2mRQZ84vu7Ub00SqQjqlhEyUjhznUA+8on7fvt2F+I9NIfq7TjqMotL605dbfKCph0YmR02atUsNxh7Z
X-Gm-Message-State: AOJu0Yy6fuVoZaj6DBkG8+Xt/4cSTG1jnYL3cyhiEoS5TXY+hK701XZ3
	1Dnut4I0wyAlL6A4guP3aUlcL+CNxgbHKqn6ObPWFzkKP8OGJyN2qynVFxyUP/Q=
X-Google-Smtp-Source: AGHT+IFyDwE+Jz3Bn1/3b5AVproXEgZap0y3BwG6IwB5VEhHDqAtrR7HyxflDE7GXDdoxY3T8nE9cg==
X-Received: by 2002:a05:6a20:29d:b0:1b5:2fbb:2d78 with SMTP id adf61e73a8af0-1bcbb656593mr5458467637.48.1718906294899;
        Thu, 20 Jun 2024 10:58:14 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb4c621sm12637089b3a.115.2024.06.20.10.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:58:14 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Oliver Neukum <oneukum@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 23/40] usb: cdc-acm: optimize acm_softint()
Date: Thu, 20 Jun 2024 10:56:46 -0700
Message-ID: <20240620175703.605111-24-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acm_softint() uses for-loop to traverse urbs_in_error_delay bitmap
bit by bit to find and clear set bits.

Simplify it by using for_each_test_and_clear_bit(), because it doesn't
test already clear bits.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/usb/class/cdc-acm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 0e7439dba8fe..f8940f0d7ad8 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -18,6 +18,7 @@
 #undef DEBUG
 #undef VERBOSE_DEBUG
 
+#include <linux/find_atomic.h>
 #include <linux/kernel.h>
 #include <linux/sched/signal.h>
 #include <linux/errno.h>
@@ -613,9 +614,8 @@ static void acm_softint(struct work_struct *work)
 	}
 
 	if (test_and_clear_bit(ACM_ERROR_DELAY, &acm->flags)) {
-		for (i = 0; i < acm->rx_buflimit; i++)
-			if (test_and_clear_bit(i, &acm->urbs_in_error_delay))
-				acm_submit_read_urb(acm, i, GFP_KERNEL);
+		for_each_test_and_clear_bit(i, &acm->urbs_in_error_delay, acm->rx_buflimit)
+			acm_submit_read_urb(acm, i, GFP_KERNEL);
 	}
 
 	if (test_and_clear_bit(EVENT_TTY_WAKEUP, &acm->flags))
-- 
2.43.0


