Return-Path: <linux-kernel+bounces-570212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4086A6ADE6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF09C164B58
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951C522DF9B;
	Thu, 20 Mar 2025 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0oPyJ77"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460B22D79B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496808; cv=none; b=RS1ZbxUJX7XQUlv2ItRQaZp46E8Tq9DovVrkbP1o9Vie01cSNHdWaVok+/qyl7Csj0kq1Pk3m3U4WYRDXBCogTyDOe82ahbQD6tIaDhalbE1PQHo36AOzgFTbCJ6x0s56OkP/MYawctnXklZxam2dAz8fuf4+wIPk+WTN+roquo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496808; c=relaxed/simple;
	bh=qFRH4iZ1oCB5ctC6Y8JGf9ZepD1vxhdEIeSFsngeOBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5elNudjO0Na6C3dNWQUbxURSZV0V0/ywQkTdX9dKTBugJ38z4eRebhn+/WmvtbXuTGllQVyL4YMXkvMZEcn/89afVRE2IYgmaIqrDEomvEffHR9PNkA6lLcDA6k0Uom4eJPZ++hbeobXPIom4FebDEeVQNAOtq8cHqQy29u19Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0oPyJ77; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85dac9729c3so88960139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496806; x=1743101606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9crVnbk3XjpJrHsY0dIqQRNI8E7oyjJ17chOf0dhmBE=;
        b=Z0oPyJ77ql9cQKRywVmc1eu8iW0uZirtJNHWIahHxbkLF2JLatuiBVI87qQ8KRrdRj
         +mitt7LW9YoIY8AanNMinvvmOLChKEWTgL6bQExLkBvL4xGr7kvf6s+MwMZcgLyUao6Z
         P94RPULELf80Pcu0MrU3UK/tzmraoLS5oEde3pY0M3Hvcp8rwAgyUB+bwsuGhT3mYMm5
         Ff2xrzAJmJL1+HnpDNuimPvrMw3MYvMP6RLKPu9Ns87hdOfE5bKXq/IvqPLnE3A+aK32
         vvxbXouA+dzVyMfNy3j/eFmmEDeykGZf3kGVHzyrZyFW56XQJFH/szVPjPkBcc+NBbEu
         sdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496806; x=1743101606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9crVnbk3XjpJrHsY0dIqQRNI8E7oyjJ17chOf0dhmBE=;
        b=H2BlQHUjNDxIj2sm1kX3NyMY2pnGpv/9FE2aQuUA39R53Et/py7jgo8hoL7RbC5Qgb
         g+b6hxpg2Gp0fJBYIEEUjbTZPsNrGHmGTHt7Elv8SSEIy7ZmADPGdsufxczOQf/FCb6l
         OXYND+Y+pIN9JghGJVYsOVOk1ZXcTXuqxk5YjEwTcuYkOEgIVK2JU3wVJXqoJITKMAP7
         rFxrgV5wavYaRhXPLcCeaa+jie1N8DIQbWDKQ5H5YHW+C7HspcO06d7nOtT+x7HZ0gQ8
         BZ2+jsY17/Sz5Ke18Zofja7s/2wxF69nZ5llXdbK9M9tuMBBnm45tDvqrGHHxxVlqIHI
         FV4A==
X-Gm-Message-State: AOJu0YyR7PjfGBaBA7xNKTz8PloJqpXM95eMP5M5xt6ON/n1Wi8LfE4c
	ccAe3/CA5Z2KBd6HUUjY0eJFcXy5m0DKqeJ/MUS6Y0ftfZ1A9oZX1CH8QfEI
X-Gm-Gg: ASbGncvgK36k6LSmybG3KW5+hujIRklvtwKloh6n5fxQ80AP3Ww2gIAypZTvq+C7Lc0
	LtLYHtc3zMdTmnQ0JV3gGhav5zAtOhGtP1o+mvYLAeQRS34PSHEC3EEo8ZqmZjWMSRTvJ4LYhkJ
	RHsFkbN9jHT9lz31dQ+kJbmkEIRbAVBXRWNaZavLkWgPoOy957A8Xjxwd1Is3aUcgz3Kiz86lXe
	uPPWGP6O9q0nrKW5fbVBg44bSDMN2hYTHzdNsvDhw0nhl3HqxISClfaRdbIPAYj0ObIYOYKiNTn
	BA/AkMPknyb9H52xNxyC6PxB9iITXEJ6x9x0S5ClS61NUfX0yvnUAMskdnK6MgVUxkXrWxgoWys
	HUqqJdJZdU9OD
X-Google-Smtp-Source: AGHT+IFxuCjaPGKkc88YGwLvCjCbtuIgV8RzngvtW7+0U59GwUXVQHXX/CedAfIKgwgp/utTkRuZ3w==
X-Received: by 2002:a05:6602:2b15:b0:85b:482b:8530 with SMTP id ca18e2360f4ac-85e2ca2d1a0mr42658039f.2.1742496806093;
        Thu, 20 Mar 2025 11:53:26 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:25 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 21/59] dyndbg-test: change do_prints testpoint to accept a loopct
Date: Thu, 20 Mar 2025 12:51:59 -0600
Message-ID: <20250320185238.447458-22-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

echo 1000 > /sys/module/test_dynamic_debug/parameters/do_prints

This allows its use as a scriptable load generator, to generate
dynamic-prefix-emits for flag combinations vs undecorated messages.
This will make it easy to assess the cost of the prefixing.

Reading the ./do_prints node also prints messages (once) to the-log.

NB: the count is clamped to 10000, chosen to be notice able, but not
annoying, and not enough to accidentally flood the logs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 9f9e3fddd7e6..4a3d2612ef60 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -29,18 +29,30 @@
 
 #include <linux/module.h>
 
-/* re-gen output by reading or writing sysfs node: do_prints */
-
-static void do_prints(void); /* device under test */
+/* re-trigger debug output by reading or writing sysfs node: do_prints */
+#define PRINT_CLAMP 10000
+static void do_prints(unsigned int); /* device under test */
 static int param_set_do_prints(const char *instr, const struct kernel_param *kp)
 {
-	do_prints();
+	int rc;
+	unsigned int ct;
+
+	rc = kstrtouint(instr, 0, &ct);
+	if (rc) {
+		pr_err("expecting numeric input, using 1 instead\n");
+		ct = 1;
+	}
+	if (ct > PRINT_CLAMP) {
+		ct = PRINT_CLAMP;
+		pr_info("clamping print-count to %d\n", ct);
+	}
+	do_prints(ct);
 	return 0;
 }
 static int param_get_do_prints(char *buffer, const struct kernel_param *kp)
 {
-	do_prints();
-	return scnprintf(buffer, PAGE_SIZE, "did do_prints\n");
+	do_prints(1);
+	return scnprintf(buffer, PAGE_SIZE, "did 1 do_prints\n");
 }
 static const struct kernel_param_ops param_ops_do_prints = {
 	.set = param_set_do_prints,
@@ -191,17 +203,20 @@ static void do_levels(void)
 	prdbg(V7);
 }
 
-static void do_prints(void)
+static void do_prints(unsigned int ct)
 {
-	pr_debug("do_prints:\n");
-	do_cats();
-	do_levels();
+	/* maybe clamp this */
+	pr_debug("do-prints %d times:\n", ct);
+	for (; ct; ct--) {
+		do_cats();
+		do_levels();
+	}
 }
 
 static int __init test_dynamic_debug_init(void)
 {
 	pr_debug("init start\n");
-	do_prints();
+	do_prints(1);
 	pr_debug("init done\n");
 	return 0;
 }
-- 
2.49.0


