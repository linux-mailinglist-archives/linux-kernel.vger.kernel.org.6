Return-Path: <linux-kernel+bounces-398498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FF79BF1F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A0E1C2440C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8380203716;
	Wed,  6 Nov 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rncnbojg"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DAA203704
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907805; cv=none; b=hL63LxUj5BlL5jCDdmygEAixh6L8SwNhddKuZ7Ic4ZPV1LR05D4B2fmrvY4mCEKDEnbLLoZxpFTo8D3A9HQ6SmT8H+M3/2S/E1G2YQeW2QgYG0WvVI4HU8uQ5G4Fnn8aQXLTJddCy2Q6IuQ6LeBD62ze9w+YPQz4UgGTCPDAZ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907805; c=relaxed/simple;
	bh=zqwApSOBUe6y59khKvnm/MLLsQaVHXHGoT8NFv0YSG0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mIZYAJ4XJANoicxvC7UfF0eCFux6gv+Snv/PlT/5N2bGymP2fivxCFfrPOrdpz+4oR+jkYzbx13W1p+AuAT/ndJev6jSuR4tT/uSsU0UHszHMA0o456UIVdUpxvcQr014ZKTi2x1cirBOT9q+f8mPey2eHJeIpKNXGcpOYKmyeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rncnbojg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--peternewman.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e7e7568ed3so13005557b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730907802; x=1731512602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rpMCCSlHBuQiWR6CwJkbGsor0amVgFYqaXc9yIN4xnM=;
        b=rncnbojg12hptRZTT6CW3rwfqUfgc2vgnjEPUXrFOiEZUW60G/HPu0ucQXmRPfhqts
         YjcudYjDRcHXIdUYiuywT83YVLkEwokI5zBNclrp6vdBwHkDczLttVmuLNfxi9hWSSO0
         gN18+3bw4sGO6zh+DUxm2v0rfZCiTKbyghBW3gqNdnPpg4QmE+bDEp6B24aRDjgKKeBK
         n1ol2dcekd+LP91cWUimJeDYskabftqErknq4h953pBEL0/phAMHW8p6ZGfctnRbnZRL
         V/yZaHYedffpo9RoRwHQ44KMqWC16gwjAbIGi9Exfguuzc6ub6ndcFbifk98B3jHpgRc
         vCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730907802; x=1731512602;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpMCCSlHBuQiWR6CwJkbGsor0amVgFYqaXc9yIN4xnM=;
        b=wnsCLFY4hy0tVHna12zTzPpe8VQXe9AfLhzbSGSPwdqDvQcZ/5JzRODnDHojo2AEao
         42lfz953IZMJHuM7Hpr46aIdyCHn/I5dWG0qEFpp5PQ6xe+DA+b0Hajt2lRTRDkCeDSZ
         eGq+NVTlsXOvACglx75K+1LD4HTdguwH81wOhFW+HBuWTY3kixfNniApdp70EotP/uBu
         BVyY6y07b10S/zNuuoIbuCIStaAbiuluRPSvFJiuVbiHa80LMGTBHw2dsfyUP4mK/DKY
         pgLtfzM+JCCEXAQtll+YyTD+ZwIT0kxcUb5/thvX7W96Fatd+n63VpbNbVtiE+kfjt2T
         BH8g==
X-Forwarded-Encrypted: i=1; AJvYcCV99z2YEzvGu5ThIeocjhb9gUSZEhHZuIc1bAO1KhayZNoOqS2XcLkGjWQbh3j+N6WIAHaeedjDNUn7vmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxlj+zPclWpdZ9QvRq3J8PMV6O/KEoMXaiJsh5HN/+iOBkD3ZF
	8nBqdTo9JSVehm8xs/HBNTsJQ8xWUcqlzeHujY42OMtukAGNhNdTMa94Vd+HvrMkkMJy2cQS3U/
	Yn91YXmVpEsbY0cHyWmxHyQ==
X-Google-Smtp-Source: AGHT+IHYs3jGZSAV4UYPslwpat576cU0bo99kA75/3wsIElrz6+7WqDfkEghUF0PgwtmSHaJWEHCuK2sFRTdjRHsFw==
X-Received: from peternewman-vh.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:ce0])
 (user=peternewman job=sendgmr) by 2002:a25:3605:0:b0:e30:b89f:e3d with SMTP
 id 3f1490d57ef6-e335a60c697mr10494276.1.1730907802345; Wed, 06 Nov 2024
 07:43:22 -0800 (PST)
Date: Wed,  6 Nov 2024 16:43:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106154306.2721688-1-peternewman@google.com>
Subject: [PATCH v2 1/2] selftests/resctrl: fastcat for benchmarking counter reads
From: Peter Newman <peternewman@google.com>
To: reinette.chatre@intel.com, fenghua.yu@intel.com
Cc: babu.moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	eranian@google.com, hpa@zytor.com, james.morse@arm.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nert.pinx@gmail.com, 
	tan.shaopeng@fujitsu.com, tglx@linutronix.de, tony.luck@intel.com, 
	x86@kernel.org, Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch is provided for reference and not intended for submission.

This test program is used to evaluate the cost of reading resctrl
counters. It is essentially a drop-in replacement for cat, allowing
presumably small files, like resctrl nodes, to be read repeatedly using
pread(). In contrast, repeated invocations of cat would open and close
the counter files, which is an order of magnitude more costly than the
actual counter file read operations.

For example, the steps below were used to determine the cost of reading
a large number of local or remote counters on a dual-socket AMD Zen2:

Bind to L3 domain 6:

 # taskset -c 24-27,152-155 bash

Measure local read cost:

 # cd /sys/fs/resctrl
 # FASTCAT_READ_COUNT=100 FASTCAT_DELAY_USEC=1000000 perf stat \
       /tmp/fastcat mon_groups/*/mon_data/mon_L3_06/mbm_*

Measure remote read cost:

 # FASTCAT_READ_COUNT=100 FASTCAT_DELAY_USEC=1000000 perf stat \
       /tmp/fastcat mon_groups/*/mon_data/mon_L3_07/mbm_*

Signed-off-by: Peter Newman <peternewman@google.com>
---
v1: https://lore.kernel.org/lkml/20241031142553.3963058-1-peternewman@google.com/

---
 tools/testing/selftests/resctrl/.gitignore |  1 +
 tools/testing/selftests/resctrl/Makefile   |  6 +-
 tools/testing/selftests/resctrl/fastcat.c  | 73 ++++++++++++++++++++++
 3 files changed, 78 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/resctrl/fastcat.c

diff --git a/tools/testing/selftests/resctrl/.gitignore b/tools/testing/selftests/resctrl/.gitignore
index ab68442b6bc8d..11a40e331f4ad 100644
--- a/tools/testing/selftests/resctrl/.gitignore
+++ b/tools/testing/selftests/resctrl/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 resctrl_tests
+fastcat
diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index f408bd6bfc3d4..c5ec1e8289390 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -3,10 +3,12 @@
 CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
 CFLAGS += $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := resctrl_tests
+TEST_GEN_PROGS := resctrl_tests fastcat
 
 LOCAL_HDRS += $(wildcard *.h)
 
 include ../lib.mk
 
-$(OUTPUT)/resctrl_tests: $(wildcard *.c)
+$(OUTPUT)/resctrl_tests: cache.c cat_test.c cmt_test.c fill_buf.c mba_test.c mbm_test.c resctrlfs.c resctrl_tests.c resctrl_val.c
+
+$(OUTPUT)/fastcat: fastcat.c
diff --git a/tools/testing/selftests/resctrl/fastcat.c b/tools/testing/selftests/resctrl/fastcat.c
new file mode 100644
index 0000000000000..0b362421fd34d
--- /dev/null
+++ b/tools/testing/selftests/resctrl/fastcat.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+int main(int argc, char **argv)
+{
+	int nfiles = argc - 1;
+	char *nread_str;
+	int nread;
+	int delay;
+	int *fds;
+	int i, j;
+
+	nread_str = getenv("FASTCAT_READ_COUNT");
+	if (!nread_str)
+		nread = 1;
+	else
+		nread = atoi(nread_str);
+
+	nread_str = getenv("FASTCAT_DELAY_USEC");
+	if (!nread_str)
+		delay = 0;
+	else
+		delay = atoi(nread_str);
+
+	if (nfiles < 1)
+		exit(1);
+
+	fds = malloc(sizeof(*fds) * (argc));
+	if (!fds) {
+		perror("malloc");
+		exit(1);
+	}
+
+	printf("opening %d files\n", nfiles);
+
+	for (i = 1; i < argc; i++) {
+		fds[i - 1] = open(argv[i], O_RDONLY);
+		if (fds[i - 1] < 0) {
+			perror(argv[i]);
+			exit(1);
+		}
+	}
+
+	printf("reading %d files %d times\n", nfiles, nread);
+
+	for (j = 0; j < nread; j++) {
+		for (i = 0; i < nfiles; i++) {
+			// Assumed to be large enough for any output of
+			// mbm_*_bytes
+			char buf[40];
+			ssize_t r;
+
+			r = pread(fds[i], buf, sizeof(buf), 0);
+			if (r < 0) {
+				perror(argv[i + 1]);
+				exit(1);
+			}
+		}
+		if (delay)
+			// Try to read cold...
+			usleep(delay);
+	}
+
+	printf("closing %d files\n", nfiles);
+	for (i = 0; i < nfiles; i++)
+		close(fds[i]);
+
+	return 0;
+}

base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
-- 
2.47.0.199.ga7371fff76-goog


