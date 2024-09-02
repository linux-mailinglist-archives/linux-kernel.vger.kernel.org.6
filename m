Return-Path: <linux-kernel+bounces-311160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFAC96858A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115AD1F21FE9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68701D67B1;
	Mon,  2 Sep 2024 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GSsXqGY8"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901CF1D6791
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274656; cv=none; b=kgW62aVrJoWyjRr26uZLPBCaeZMIj9Ln049AGA8O7d67spYmaXpgBDOIT53gVOy9T8F8SEAhTPTL4nph2/KadWVC5C7lmgjEqrlfTAOFGHMly/GSxkE5R47qwXuRwVQeHqc1tyGYJoM+umwYKPnzMwRjc8btLfLbSFVMBhChi/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274656; c=relaxed/simple;
	bh=vkW6uTgUYKV+aE/4isDqR5FvHAChmg3UGNULzA70Qus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pmc92vy8Ea6B9EEiboi67LI2J4wKgQnhDVQZG2Z1lUGa6oHbt6R5aHEbvp9T56MVqUSJi1AKu2x2/F/SkabXS//WptstJj1ZLm6pN5y6PVyvSEwhwRwuga7n6VhBPHVICSFHYwrvDjv5GxgXZ8I4L+368XQDEIGwkCz82HTSYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GSsXqGY8; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-277f35c01f5so409130fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725274653; x=1725879453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8WuMXTJ73w4rlQxvTYXaVgMatgUypxFNO55TkDJ0XM=;
        b=GSsXqGY8Y/HqEBD/rnuY4nu8nD8TTkUASs2bBBHdcgUy3501PG7ocemhElG0HpcMRv
         jhWOtKGufZwZE4u1Q++2wE6nHgco6je7Kzr9rG9TrMMsgmAV1cSrKxcNDovM8THTm6gb
         MO7xplnWD4RiMFfhhBZ5u2Z8wG2VzDYL53VQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274653; x=1725879453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8WuMXTJ73w4rlQxvTYXaVgMatgUypxFNO55TkDJ0XM=;
        b=dpMkFnva1XjLkJAcbujR8e2qvDIpJpmmrl+dme5Z+uQJzXbkY9wfgALAo5WKSBjmJB
         P8KGFN4VdedUy8vINnQ0I4wJoLV29OhGMdprUmLYi9QMYpIGVLQi/RghiOg11v/B3pIw
         ncjgWZV7i30vJQqBIcwHAiTnxjcLn7WEkTrb4alWQDThJsID24e28ebGyZhCN4uxOoeG
         52kAONSrw/dSkiuilXNH2WujFE1NQHB1FVkxT2wahhlCN02In9ykrh072XTTf8tW9i+2
         ctpx+cAgbnJI5jXhgI9bv42J0dbODGUFax/GiOhpGx+uF/s+Ws2w599HYccLk5DqwyFi
         LRKg==
X-Forwarded-Encrypted: i=1; AJvYcCXb/nSQeHG+VXBsILztCM3CQapwOGdj35EZC+4U1OdHn3jfn4T4XtFT/Sf4S1pYszb1Cvml8vsbdXvDyw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlA0einNayE2RrD5adt+ZTorTPcc2/3lfrkL+4Jy3056cTA4RZ
	dRGd32eICXFAFem0qXEnhf2yh+nrebiT3SI7dn6hRLHTOQbFY0Lpy5JQmHex8MifA8VYYaTgqMB
	IuA==
X-Google-Smtp-Source: AGHT+IHSd6z/TgqX8/BSy59Q22d2r4sVfXIcr4hZ42pK33ZLW6K3laAbvyHjVWmUIX2KgYdEeJknFA==
X-Received: by 2002:a05:6871:e485:b0:278:747:a449 with SMTP id 586e51a60fabf-2780747a5famr784970fac.19.1725274653641;
        Mon, 02 Sep 2024 03:57:33 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a51e9sm6633769b3a.78.2024.09.02.03.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:57:33 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv7 15/24] zram: introduce algorithm_params device attribute
Date: Mon,  2 Sep 2024 19:56:03 +0900
Message-ID: <20240902105656.1383858-16-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240902105656.1383858-1-senozhatsky@chromium.org>
References: <20240902105656.1383858-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This attribute is used to setup compression algorithms'
parameters, so we can tweak algorithms' characteristics.
At this point only 'level' is supported (to be extended
in the future).

Each call sets up parameters for one particular algorithm,
which should be specified either by the algorithm's priority
or algo name.  This is expected to be called after corresponding
algorithm is selected via comp_algorithm or recomp_algorithm.

 echo "priority=0 level=1" > /sys/block/zram0/algorithm_params
or
 echo "algo=zstd level=1" > /sys/block/zram0/algorithm_params

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/ABI/testing/sysfs-block-zram  |  7 +++
 Documentation/admin-guide/blockdev/zram.rst |  1 +
 drivers/block/zram/zram_drv.c               | 68 +++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block-zram b/Documentation/ABI/testing/sysfs-block-zram
index 628a00fb20a9..1ef69e0271f9 100644
--- a/Documentation/ABI/testing/sysfs-block-zram
+++ b/Documentation/ABI/testing/sysfs-block-zram
@@ -151,3 +151,10 @@ Contact:	Sergey Senozhatsky <senozhatsky@chromium.org>
 Description:
 		The recompress file is write-only and triggers re-compression
 		with secondary compression algorithms.
+
+What:		/sys/block/zram<id>/algorithm_params
+Date:		August 2024
+Contact:	Sergey Senozhatsky <senozhatsky@chromium.org>
+Description:
+		The algorithm_params file is write-only and is used to setup
+		compression algorithm parameters.
diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 181d55d64326..96d81dc12528 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -198,6 +198,7 @@ writeback_limit_enable  RW	show and set writeback_limit feature
 max_comp_streams  	RW	the number of possible concurrent compress
 				operations
 comp_algorithm    	RW	show and change the compression algorithm
+algorithm_params	WO	setup compression algorithm parameters
 compact           	WO	trigger memory compaction
 debug_stat        	RO	this file is used for zram debugging purposes
 backing_dev	  	RW	set up backend storage for zram to write out
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ff6724bbdf91..e29e952b99c3 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -998,6 +998,72 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 	return 0;
 }
 
+static int comp_params_store(struct zram *zram, u32 prio, s32 level)
+{
+	zram->params[prio].level = level;
+	return 0;
+}
+
+static ssize_t algorithm_params_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t len)
+{
+	s32 prio = ZRAM_PRIMARY_COMP, level = ZCOMP_PARAM_NO_LEVEL;
+	char *args, *param, *val, *algo = NULL;
+	struct zram *zram = dev_to_zram(dev);
+	int ret;
+
+	args = skip_spaces(buf);
+	while (*args) {
+		args = next_arg(args, &param, &val);
+
+		if (!val || !*val)
+			return -EINVAL;
+
+		if (!strcmp(param, "priority")) {
+			ret = kstrtoint(val, 10, &prio);
+			if (ret)
+				return ret;
+			continue;
+		}
+
+		if (!strcmp(param, "level")) {
+			ret = kstrtoint(val, 10, &level);
+			if (ret)
+				return ret;
+			continue;
+		}
+
+		if (!strcmp(param, "algo")) {
+			algo = val;
+			continue;
+		}
+	}
+
+	/* Lookup priority by algorithm name */
+	if (algo) {
+		s32 p;
+
+		prio = -EINVAL;
+		for (p = ZRAM_PRIMARY_COMP; p < ZRAM_MAX_COMPS; p++) {
+			if (!zram->comp_algs[p])
+				continue;
+
+			if (!strcmp(zram->comp_algs[p], algo)) {
+				prio = p;
+				break;
+			}
+		}
+	}
+
+	if (prio < ZRAM_PRIMARY_COMP || prio >= ZRAM_MAX_COMPS)
+		return -EINVAL;
+
+	ret = comp_params_store(zram, prio, level);
+	return ret ? ret : len;
+}
+
 static ssize_t comp_algorithm_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
@@ -2169,6 +2235,7 @@ static DEVICE_ATTR_RW(writeback_limit_enable);
 static DEVICE_ATTR_RW(recomp_algorithm);
 static DEVICE_ATTR_WO(recompress);
 #endif
+static DEVICE_ATTR_WO(algorithm_params);
 
 static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_disksize.attr,
@@ -2196,6 +2263,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_recomp_algorithm.attr,
 	&dev_attr_recompress.attr,
 #endif
+	&dev_attr_algorithm_params.attr,
 	NULL,
 };
 
-- 
2.46.0.469.g59c65b2a67-goog


