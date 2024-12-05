Return-Path: <linux-kernel+bounces-432892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DDD9E519B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8FB416671A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563451D5144;
	Thu,  5 Dec 2024 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjf/BsHK"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA6DD26D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391952; cv=none; b=JgLU7URfMe/5GTEsGgB9SoVbG+fC46RF+5JIu2zAL3LUlggLIsfcEpGC2KfHL+lfB28UDF75KCx63jJdeJI9Podl09hjuV+8CiZWU/QuDZJz2z17aDxmlcy+DiO7BJ/WWQAMZCF8oeO+E7IKc9DIgyngySyG6Ci0NOnqiPyoqhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391952; c=relaxed/simple;
	bh=SNdPmDkLdDDYLgeO+TmHif43uTpTv/p2qWIljnnh6FA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PmGBh6AzH0jNikpqj2QADDD2McEmsPBtbqv7cX0sYYTyaGtSPA8s/JWHJsqtlFOfURY4ttl6ilEMUIGpWm2G4/ZHgitZXOCX9rNz75HVRPh7BdigCKjtwh4eV3uvb8w5RnuzYNCpjSLOTrNLc2X81Kz1w7PmsTS28REeWcI117g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjf/BsHK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fc99fc2b16so545779a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733391951; x=1733996751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sSCTRtTZFzC38u5ELH86ExDbi7PEAa9+kuBPOpVRQXg=;
        b=hjf/BsHK2JpIJvN8kHMy6EvV0TtCiCPdrWfR+DEejukQlSh9yRDg0Bd+qoeMF1RkDJ
         +YJOr3pr3MpmkVVr4iu3wsF7QO5bgzDl3pxRmcfqDqwOtxzk3q9Imgr2fePeS/eqi+CP
         /V+SYfj8d5Kv7x8+Aym3nz0iETelwaXHYFtRe0ttvoJXBgt1SLviCHyNGKU9vwiPh5eY
         NCpQlbdRWqyjh7hUTXQLd4JcSNYbBjA48jCXKqm4Q6//ubtJAKOd+lWB8/K3Rzy6mfGj
         WUUSM8PWY4DaEs7sxXlBGlf3oRiYw3iYHgkLxHlFtEptQXgnrmhrxTyhNoaOfV4NrtHA
         mrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733391951; x=1733996751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSCTRtTZFzC38u5ELH86ExDbi7PEAa9+kuBPOpVRQXg=;
        b=UupQtjmNisavLmVOO16gyBxRDHqlvyWcaYBtIJbi6bL2GulGVjP5HucvOQmJrv58Ys
         O46YhTUDATNGNWjVWkShLCzez/05bo3JxcXmyUraghax5Hxfbg3+ZIniC51EHqeBS4qh
         8BcOVqGYsEa3nbSpdv3HnXe+FkI92IB3sGl221pKYMa1dsioKlYVjqF0Dk0HC9sHmm/B
         V2oi/LpVspGYYjdcdPTcGKunMwhQP/0tRPTR+BmhDtEblVtL/qa1Cyw9VXcONOZio26n
         r1CudMGO3tqraPTk0jaTQexuPLjgPTAB09a1hKzAg1/e4lS6PA0mkDBI999doJaXtfui
         91Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUOSOTTF75Xw0k1JoHUkLp4ekGWZO27G2xaQwxpgq0YUQz0/ncaINvb0hNFdQldm0kUJgw0f+SUnRRsSVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp0Ktj4rppxebAfIcfDB6KDAAGxzS+3cAYvrffNAItjjTnVdl8
	RE+GDxYP8eslSSboB+NmNZss0/RuOpJmofjyqIYGxSgcWS8TqDF2
X-Gm-Gg: ASbGncvJ1C9cKOo3e9XNxviEpocRdJJ9MQY8ngeZ3RtFmSqR+UXgyEk1TyH+oiOxS4G
	EGA9Wfy92a1JXF1SHCGHbo5KWYU1XWEfBvosgQvL5u0Dkl4ybI+IBzkzgEmVdWD579YY6yOUa9D
	Or8+JsDAlpQF56J4rAnkxrWQY0SpsRH/6AY0/W3w48VMmlXYGFQ1IxaFNmFNquzYJW8+WpAyVA3
	MupQzeYIu0k/88N+Fh3y5nLdm9nIuu+KAZD7jIh4tIS/paRaBpp6Y/tN5gTbVI2iQoUEBT4Fw==
X-Google-Smtp-Source: AGHT+IEdC91bc1pFn/Lu1UYwciLcGwDw8pC1DZiNh/OvhZTcQykXZV+bgtvqpQ9MycoZffLtElbsiw==
X-Received: by 2002:a05:6a20:430b:b0:1d9:c78f:4207 with SMTP id adf61e73a8af0-1e1653b7c9amr13021353637.11.1733391950622;
        Thu, 05 Dec 2024 01:45:50 -0800 (PST)
Received: from localhost.localdomain ([36.110.106.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a90542sm889686b3a.106.2024.12.05.01.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 01:45:50 -0800 (PST)
From: Guo Weikang <guoweikang.kernel@gmail.com>
To: amir73il@gmail.com,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Guo Weikang <guoweikang.kernel@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/shmem: Refactor to reuse vfs_parse_monolithic_sep for option parsing
Date: Thu,  5 Dec 2024 17:45:21 +0800
Message-Id: <20241205094521.1244678-1-guoweikang.kernel@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `shmem_parse_options` function is refactored to use
`vfs_parse_monolithic_sep` with a custom separator function,
`shmem_next_opt`. This eliminates redundant logic for parsing
comma-separated options and ensures consistency with other
kernel code that uses the same interface.

The `vfs_parse_monolithic_sep()` helper, introduced in commit
e001d1447cd4 ("fs: factor out vfs_parse_monolithic_sep() helper").

Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>
---
 mm/shmem.c | 65 +++++++++++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 38 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index d23602a33f31..c9c5862848e6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4646,48 +4646,37 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 	return invalfc(fc, "Bad value for '%s'", param->key);
 }
 
-static int shmem_parse_options(struct fs_context *fc, void *data)
+static char *shmem_next_opt(char **s)
 {
-	char *options = data;
+	char *sbegin = *s;
+	char *p;
 
-	if (options) {
-		int err = security_sb_eat_lsm_opts(options, &fc->security);
-		if (err)
-			return err;
-	}
+	if (sbegin == NULL)
+		return NULL;
 
-	while (options != NULL) {
-		char *this_char = options;
-		for (;;) {
-			/*
-			 * NUL-terminate this option: unfortunately,
-			 * mount options form a comma-separated list,
-			 * but mpol's nodelist may also contain commas.
-			 */
-			options = strchr(options, ',');
-			if (options == NULL)
-				break;
-			options++;
-			if (!isdigit(*options)) {
-				options[-1] = '\0';
-				break;
-			}
-		}
-		if (*this_char) {
-			char *value = strchr(this_char, '=');
-			size_t len = 0;
-			int err;
-
-			if (value) {
-				*value++ = '\0';
-				len = strlen(value);
-			}
-			err = vfs_parse_fs_string(fc, this_char, value, len);
-			if (err < 0)
-				return err;
+	/*
+	 * NUL-terminate this option: unfortunately,
+	 * mount options form a comma-separated list,
+	 * but mpol's nodelist may also contain commas.
+	 */
+	for (;;) {
+		p = strchr(*s, ',');
+		if (p == NULL)
+			break;
+		*s = p + 1;
+		if (!isdigit(*(p+1))) {
+			*p = '\0';
+			return sbegin;
 		}
 	}
-	return 0;
+
+	*s = NULL;
+	return sbegin;
+}
+
+static int shmem_parse_monolithic(struct fs_context *fc, void *data)
+{
+	return vfs_parse_monolithic_sep(fc, data, shmem_next_opt);
 }
 
 /*
@@ -5037,7 +5026,7 @@ static const struct fs_context_operations shmem_fs_context_ops = {
 	.free			= shmem_free_fc,
 	.get_tree		= shmem_get_tree,
 #ifdef CONFIG_TMPFS
-	.parse_monolithic	= shmem_parse_options,
+	.parse_monolithic	= shmem_parse_monolithic,
 	.parse_param		= shmem_parse_one,
 	.reconfigure		= shmem_reconfigure,
 #endif
-- 
2.25.1


