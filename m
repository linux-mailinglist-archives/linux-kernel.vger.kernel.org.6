Return-Path: <linux-kernel+bounces-293443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EB3957F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E582128209B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F37E189B83;
	Tue, 20 Aug 2024 07:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0nUkX1W"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A3F1898E7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138634; cv=none; b=uQTxqn5D9tsYjQrzGZBNB1N8uEMVvj1USxCO5dpm30Vjw8CPvQBQw7aldO1TVnTpcFRTLhd/SkQdoH30OtQvi0GsGH376hbCk45F1rxJCEGvjj7JHfmh1GZMxIhEgsaTej668+0u34J2i3z7owJ1qsYxtAYZ0caLmHPI9HUpcT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138634; c=relaxed/simple;
	bh=J8oc+N1gOHDuszM+U40BXlUVqAOEm6SVRNR/s6/yS48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rwi0SSARbx9FcUzy6iNAfLlkHaePKWF2EAHe2SMb7RmrW/0eyjxuytTgbX1VJm+IJn4qH9QlNqn0yC7Wc/5mGyQJpr6bhEaMjRBY9/kAs94+zHxCz9dpGi1ZgvbMwfPrfOIp4Ug0Nqe3jXs4cBXDnvfNRNQ5WBiGMlR8NktS6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0nUkX1W; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7bb75419123so3418713a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 00:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724138633; x=1724743433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaV+ofSgk5cjNQPZ6nI14C/JQ9RmxXoGJ/nt9BVcIWQ=;
        b=H0nUkX1W27CtQjnOU79R7pef2FlWtHxLvJPBvwPpKknrn7Xxm3nch0n7/7qVxeGXwi
         6IzCRrz25ox0E8LApmAe8x0FQeuVbsm9m3Wmjou93DqsugiHXkVtX7I22R5npYtcyZyK
         aKQRSGlxVZH/H7507bELaSi54uyRoPy30kywjSUfAmu3qBRYj8+Uqf6aRTej4nKAEsjU
         gAljCJu/WisZHemURbS4lRooVwU6v2du6qsP3FFzXUswWEKEnw2RA4TEG3fSr/2FnDKz
         mxlZtyEqm/nvsAdJN86qJdjZkB6Gpq8/rSqNz+hlxUeaVi2g2b4Sh+YhkjBalNMGRng0
         SWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724138633; x=1724743433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaV+ofSgk5cjNQPZ6nI14C/JQ9RmxXoGJ/nt9BVcIWQ=;
        b=C7YozFI7/fx14o5DOPYaTA16xu+Ux4llrZfe+1K1G2+q56yA0Oc7TQOlSb/e+fSOvu
         gji4HcchtvdsSlpc1/tS3Foe2y33dbWUWXPzmy+zWXWuWbO2AUPwc+Xj+BP3JnG1c5Nw
         n5C1JxLJQMFs/Jwk38ZL3dMfKMmwLOYw881DoIW8Wolgr1rIMwvtZnYG6pjtkofsOukr
         4KdYIyp5AA4dqFooQ7lBo6rtEVOelh3/rUG/Xqr+qCmdx7EdntWVxA0CrPFKKov9hkGL
         srlVrwZD5xqpjVDTg9pvx7QZOcWZYwMgT/Q0109CXeLiEixPSZzrsoNKJkaOjSow/n4Q
         PYpA==
X-Gm-Message-State: AOJu0Yw6gKJsVTe7MkRLE1EIaf9fkoByQvAbA/lHFTboCN3c0/FkRwVz
	ZORmc/K57gJuYph2zuaotl5hMtjfdSAvt4QRE8UTrHuLlaD2fIfS
X-Google-Smtp-Source: AGHT+IEnOlaIYri+TogPcjCVp2FdKW9zYnnycbIh5sDHH9/h2Aj/AeWMe55dO+MDJ/1+oxKHX4In8g==
X-Received: by 2002:a17:90b:a41:b0:2d3:c675:41e7 with SMTP id 98e67ed59e1d1-2d3dfc3a9acmr11978356a91.7.1724138632766;
        Tue, 20 Aug 2024 00:23:52 -0700 (PDT)
Received: from dudes-co-ThinkPad-T460.. ([49.207.208.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6d16asm8642488a91.21.2024.08.20.00.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 00:23:52 -0700 (PDT)
From: Rajkumar Vadhyar <rajkumarvad@gmail.com>
To: jacek.anaszewski@gmail.com,
	rbmarliere@gmail.com,
	skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Rajkumar Vadhyar <rajkumarvad@gmail.com>
Subject: [PATCH 2/2] tools/leds: Add '-h' & '--help' cmd options to led_hw_brightness_mon
Date: Tue, 20 Aug 2024 12:53:41 +0530
Message-Id: <20240820072341.41153-3-rajkumarvad@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820072341.41153-1-rajkumarvad@gmail.com>
References: <20240820072341.41153-1-rajkumarvad@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add '-h' and '--help' command line options to led_hw_brightness_mon

Signed-off-by: Rajkumar Vadhyar <rajkumarvad@gmail.com> 
---
 tools/leds/led_hw_brightness_mon.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/leds/led_hw_brightness_mon.c b/tools/leds/led_hw_brightness_mon.c
index eb65ae988839..712a4f8edb98 100644
--- a/tools/leds/led_hw_brightness_mon.c
+++ b/tools/leds/led_hw_brightness_mon.c
@@ -12,6 +12,7 @@
  * CTRL+C will exit.
  */
 
+#define	USAGE_LED_HW_BRIGHTNESS_MON	"Usage: ./led_hw_brightness_mon <device-name>\n"
 #include <errno.h>
 #include <fcntl.h>
 #include <poll.h>
@@ -36,6 +37,11 @@ int main(int argc, char const *argv[])
 		return 1;
 	}
 
+	if (!(strcmp(argv[1], "-h")) || !(strcmp(argv[1], "--help"))) {
+		fprintf(stderr, USAGE_LED_HW_BRIGHTNESS_MON);
+		return 1;
+	}
+
 	snprintf(brightness_file_path, LED_MAX_NAME_SIZE,
 		 "/sys/class/leds/%s/brightness_hw_changed", argv[1]);
 
-- 
2.40.1

