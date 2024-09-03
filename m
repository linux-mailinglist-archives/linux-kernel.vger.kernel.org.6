Return-Path: <linux-kernel+bounces-312499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 814FC96977A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F001F24FDC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF1F1AD266;
	Tue,  3 Sep 2024 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RTTiztNl"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026042139C6
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352868; cv=none; b=mnnQqB35TxoQHvYn5GZOgctfkG/+GRtq8G/y/2pm5REK53NUPp7VGRQbuY1Q5E+lymMWnTinwbj88z/QVnE6tk99oP4+9YJcbDOKl+Vjmv3FBzqwWqoVzjLv9JKuNdWKkRkCvMVlXIUWssR/5KoYYqpUepBQNraf1/T5Pua/d9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352868; c=relaxed/simple;
	bh=HRTm6FMoTj7icyw+BDc4OcrvXVqdobLmvETifTGDXZs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pE5UBPEJFM9IHi9htcQVLE6V+Y3jsqPrssYBjBax98BbtZq4kIgbfd3f2KmNCVVcnt+XT2Itjq6dS67C2Nhv9RY1UTBs3QTONKWRfayoEGZJ36vWJzwOk+5eTtjaw9yUTgWuAudFQGh3/pbq7A+eJLpvwNuLjGUTgAFvDXVxKX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RTTiztNl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7176645e4daso880888b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725352865; x=1725957665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p16rGgsm4xckpgdT1zNkI4kgPUb4epe1Eaf93VAZH3Q=;
        b=RTTiztNl9f11fewyhfk31HOhhMzAtaAdM/455nG/I+9+T4ENRz/51EBgoN0EmzP/SW
         xWYP6E5UL4lG6fZzhu1cEj+mfXoVE2yKFlXBSVLpT77pYbl+7XACVg+AK0g+/6Lqxcff
         H/y7eieRMXI5O97tCyArNKOVQ8yID22EK9jPaeHXdxm2QG478wbes4A6d/C+4FrOXouH
         /2lTdvKnnlBmo0bSFfVLIjm8ARXvhReuwOKGmT+yvQlxE+To7I2gMy13F0nB03+2syuY
         dMLQffMpX/VT8VV+QGW4x3LJdR6uN9eBSLS0jwsaCo6+LeiQ0duBlP2TVtyil5Zb3Wvv
         dzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725352865; x=1725957665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p16rGgsm4xckpgdT1zNkI4kgPUb4epe1Eaf93VAZH3Q=;
        b=VX9iXIXPSqUYeR71wOgXha2/OPz7zgR0LMBWCgUl9NODv7h/Yhd/7f7dGGE8ZIhOB4
         oJ4Y8XcHVHKDNlvLk3jTXK3vu69uwKf0ILHI33wD0jXNT5U1jVEFTxpLu5hT/4AMmiiK
         nMCtFl6d+O6vMcAETAhMlt959l1vuBqICQkdEyshuoyCLT+4FqyXLrj6X4cHxQzG6c6M
         Y3J21IVKqMSWhuCOUxwaeDl3PiW9Wid/sIw1YBoSbTZsQXpmgBHwlxIxMq83A+w5st6J
         q30VN+TtYOUhZX7eXaH9U74NoT8vaw8OEbMbW+HeiT3vVng2mYExa0QQw5Ln+ZH130nU
         KMVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvwGK0fTD+E1AdGl+4X9tOvTyyXpPqORE8Gyluc2BNk/1FnaeQfbjthYF+PjJXbb5wmv+UebHY/QYG3/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtgqdAR+A2hrM6ztliyW1Gi1gRGZQT8/0c+EuCkYX0QH1ZF2Yi
	CUwv4OEcrTmWvFw8ayWpsEMEcVYO/MYNJv6N8a2Sc+7AT78zuXSqeLc0bsJ8V2Q=
X-Google-Smtp-Source: AGHT+IH4uV69NEot5xOV4KWWeuTFkrpmvWEXPnzuNlbZv/tHuhOYGF3kqeM1e/T6MtaCwt+lFY/MJQ==
X-Received: by 2002:a05:6a00:a22:b0:70d:2583:7227 with SMTP id d2e1a72fcca58-7173fa0a2d3mr9097144b3a.6.1725352865060;
        Tue, 03 Sep 2024 01:41:05 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55769f3sm8277836b3a.10.2024.09.03.01.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 01:41:04 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: irogers@google.com,
	acme@redhat.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH] tools lib subcmd: Use array data to save built usage string
Date: Tue,  3 Sep 2024 16:40:48 +0800
Message-Id: <20240903084048.766892-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 230a7a71f922 ("libsubcmd: Fix parse-options memory leak")
free built usage string to solve the memory leak problem,
which causes perf tool to not print subcommands when outputting usage help,
reducing the friendliness of the information.

If use original method of dynamically allocating memory, caller needs to
free the memory in appropriate place. In order to avoid it, use an array
to save built usage string.
Currently, only perf tool uses this function, 128 bytes are enough.

Before:
  # perf sched

   Usage: (null)

      -D, --dump-raw-trace  dump raw trace in ASCII
      -f, --force           don't complain, do it
      -i, --input <file>    input file name
      -v, --verbose         be more verbose (show symbol address, etc)

After:
  # perf sched

   Usage: perf sched [<options>] {record|latency|map|replay|script|timehist}

      -D, --dump-raw-trace  dump raw trace in ASCII
      -f, --force           don't complain, do it
      -i, --input <file>    input file name
      -v, --verbose         be more verbose (show symbol address, etc)

Fixes: 230a7a71f922 ("libsubcmd: Fix parse-options memory leak")
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/lib/subcmd/parse-options.c | 27 +++++++++++++++------------
 tools/lib/subcmd/parse-options.h | 10 ++++++++++
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index 4b60ec03b0bb..1e41a204864a 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -633,20 +633,26 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
 			const char *const subcommands[], const char *usagestr[], int flags)
 {
 	struct parse_opt_ctx_t ctx;
-	char *buf = NULL;
 
 	/* build usage string if it's not provided */
 	if (subcommands && !usagestr[0]) {
-		astrcatf(&buf, "%s %s [<options>] {", subcmd_config.exec_name, argv[0]);
+		int n;
+		static char buf[USAGESTR_BUF_SIZE];
+		int buf_size = sizeof(buf);
 
-		for (int i = 0; subcommands[i]; i++) {
-			if (i)
-				astrcat(&buf, "|");
-			astrcat(&buf, subcommands[i]);
+		n = scnprintf(buf, buf_size, "%s %s [<options>] {",
+			      subcmd_config.exec_name, argv[0]);
+
+		for (int i = 0; subcommands[i] && n < buf_size - 1; i++) {
+			n += scnprintf(buf + n, buf_size - n, "%s%s",
+				       i ? "|" : "", subcommands[i]);
 		}
-		astrcat(&buf, "}");
+		if (n < buf_size - 1)
+			n += scnprintf(buf + n, buf_size - n, "}");
 
-		usagestr[0] = buf;
+		/* only provided if a complete string is built */
+		if (n < buf_size - 1)
+			usagestr[0] = buf;
 	}
 
 	parse_options_start(&ctx, argc, argv, flags);
@@ -678,10 +684,7 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
 			astrcatf(&error_buf, "unknown switch `%c'", *ctx.opt);
 		usage_with_options(usagestr, options);
 	}
-	if (buf) {
-		usagestr[0] = NULL;
-		free(buf);
-	}
+
 	return parse_options_end(&ctx);
 }
 
diff --git a/tools/lib/subcmd/parse-options.h b/tools/lib/subcmd/parse-options.h
index 8e9147358a28..654ba0a2201c 100644
--- a/tools/lib/subcmd/parse-options.h
+++ b/tools/lib/subcmd/parse-options.h
@@ -174,6 +174,16 @@ extern int parse_options(int argc, const char **argv,
                          const struct option *options,
                          const char * const usagestr[], int flags);
 
+/* parse_options_subcommand() will filter out the processed options
+ * and subcommands, leave the non-option argments in argv[].
+ * If usagestr is empty, it will build usage string based on subcommands
+ * in format of "exec_name argv[0] [<options>] {subcommand1|subcomman2|...}".
+ *
+ * NOTE: In order to avoid the caller needing to free memory,
+ * use an 128-bytes array to store the built usage string.
+ * If need to expand the array size, please modify USAGESTR_BUF_SIZE macro.
+ */
+#define USAGESTR_BUF_SIZE 128
 extern int parse_options_subcommand(int argc, const char **argv,
 				const struct option *options,
 				const char *const subcommands[],
-- 
2.25.1


