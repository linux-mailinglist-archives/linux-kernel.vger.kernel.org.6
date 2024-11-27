Return-Path: <linux-kernel+bounces-423529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3499DA8E2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8354165513
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14941FE468;
	Wed, 27 Nov 2024 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qvc/C3yl"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C621FDE2B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714993; cv=none; b=XCWzP9/LkZvBU2pap4D7bWpmuyIzf8f9NK3457tVmZAFz+O8hPMwBrUfTyAEw68Dgp/9hBeyI+eVTt5DPzNb8viJVtS8ABv9yWCb/xqXumLn3Fg+aPq4FGfBCi4Po8C4ZwkhblPkSuFfxo6KvufZNY6tLN3KlidmJ0qCZZ/+lKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714993; c=relaxed/simple;
	bh=bCjNdPAyXaqp/moo81/tuzqjHlB4vZOR/j9FAkyAsk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dO/DohOLyOoTDbswFcivlNw4TOgARhVuD7j2JfrMV03IEbcadVSgS0q11RsorsP2ebEzkxlqm+RTI0LYDFQADuq3oZOtNCmLu/MAVjyOlXxwuiipSBPQ5/cjjviB4y4VSbPh591BQig5fydGPlFqetE3YFInCFP3CLvbyBHWeOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qvc/C3yl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434aa222d96so8277835e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732714988; x=1733319788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7do7yGcfCic5M1WcR1wYgIJtxjffIMJzcsuDi7uwVQ=;
        b=Qvc/C3yllBm2GgZAR7DY6+aTPjq2YkVo0Ji9yBelycVKpmybqsa8AdjMQ+bYl9eMvp
         sB/94mSyIJmZtN6b1B9ImzWgA8oJiIbTxa4YZomxBNYtsDHP4TYjW+FDXCl0Nv85dCmH
         8iGbKgzl1BNC5ScozkV9Rz9++iHT2o/eGHSojP0dEcm4sRTJXe4B58eDb4PuPIdkB2Tv
         jc0+W/xWQo43OV+XdHHXPMOfoVw+NTgP7m4pUacMiLEko32XQaxfno5NvR7TZEzkMgl7
         m3GLrFz4QjEVFa8CZRzlbQjY2m7a4tZoCGLcpOCQ1ncGU5tXn12MvhC9MuBpvJpfHAGK
         bNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732714988; x=1733319788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7do7yGcfCic5M1WcR1wYgIJtxjffIMJzcsuDi7uwVQ=;
        b=KGmFOpuB+P4X9bmYFjgaI6ylfzV7le3h916CJfBMoyxKdTRKO4fCkbQI4jIIDIEFWh
         A5w6FW1IrFPz69KMLa1Mz2Cfjequ2ijZi4VJgsOVWOpY82rRI8F0+nYSQcuwmhwDZhsU
         waYgdDi1CBwZpjxxSSkVZQP61CB2B4MC/PL+/ln3lbz2DWUtYa7HVxDbmGQJTHvLnmPp
         L3VQNd7OEMTLbDhv1qWc5cFf403fkgFOAumD4Vn5jSr5Jr0arP//SkEMAMc9KmtbVGDU
         TuR9tmIGnbf3Hpz8rCMhdnd8ZbcKaB7H+yvRX7czqQyN9Zj6V04Mank5hiaJOOS/B+Vn
         oeDg==
X-Forwarded-Encrypted: i=1; AJvYcCV2o1w5JrPlp0k6SJnQKriBKjy4bjXHzboyhc4xq7Ybg/hyxgGUCsGukTUzoZvQCavuQfBL6dcc+791wF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyguHKu8a7p5HutMYn/PuND+OJ/9m/93OiOCd4QDmOZEUMmZI1Y
	NvSfQ4JxpVoGnHjatRwdYG1hrUaLeueS+zTPSAi8Pv0CO6E2XS0xQ1nIGvWgCGI=
X-Gm-Gg: ASbGncs6nNCGEh5efOzMvJkOST5Gxy3auD0/I3p7Ec4HdRYq67NqoHj5LDEPVMH4hzb
	qX8k9ebFQJoJto/eizu/JrQSYBiLySiKcIZ+A+q8NLzOHJDW8+6NkGAVx7DVriNa3/uXaRvUdzF
	HyBPZtXVrgKjsANgwwA8kUiJeGYzT0Yaivr/CorMk7TfRnXPo3SCD6dx7WeSI0UXIQgVRsWfctN
	88lpV3oupY9ooamRKdDNjmMfKcrKNy0dr8Yj0phjPpkNu5vgcTh
X-Google-Smtp-Source: AGHT+IE95ZTsUMG+YQJ2vUcIv9oSh/sh9Sh2yNkTBnaiA1qw76pziEvZRGbI0BTyvbVIUvO7OOa03A==
X-Received: by 2002:a05:6000:2b12:b0:382:506b:f627 with SMTP id ffacd0b85a97d-385c6edd72fmr2175769f8f.57.1732714988225;
        Wed, 27 Nov 2024 05:43:08 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6829:901:9ff7:e7c5:5e0f:c5ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad5fa2sm16804645f8f.1.2024.11.27.05.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 05:43:07 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org
Cc: suzuki.poulose@arm.com,
	james.clark@arm.com,
	Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 8/9] coresight: tools: Add configuration table test tools
Date: Wed, 27 Nov 2024 13:42:55 +0000
Message-Id: <20241127134256.2254851-9-mike.leach@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241127134256.2254851-1-mike.leach@linaro.org>
References: <20241127134256.2254851-1-mike.leach@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an example config table generator to test loading configuration
tables.

Provides a table buffer writer function that can be re-used in other
userspace programs.

Table write format matches that expected by the corresponding reader
in the configfs driver code.

Generates tables and outputs in form of binary files.

Add a config table file reader and printer. Takes in config table files
and prints the contents. Uses table reader source from kernel driver.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 MAINTAINERS                                   |   1 +
 .../coresight/coresight-config-table.h        |   5 +
 tools/coresight/Makefile                      |  56 +++
 tools/coresight/coresight-cfg-bufw.c          | 328 ++++++++++++++++++
 tools/coresight/coresight-cfg-bufw.h          |  26 ++
 tools/coresight/coresight-cfg-example1.c      |  62 ++++
 tools/coresight/coresight-cfg-example2.c      |  95 +++++
 tools/coresight/coresight-cfg-examples.h      |  25 ++
 tools/coresight/coresight-cfg-file-gen.c      |  58 ++++
 tools/coresight/coresight-cfg-file-gen.h      |  17 +
 tools/coresight/coresight-cfg-file-read.c     | 239 +++++++++++++
 tools/coresight/coresight-config-uapi.h       | 105 ++++++
 12 files changed, 1017 insertions(+)
 create mode 100644 tools/coresight/Makefile
 create mode 100644 tools/coresight/coresight-cfg-bufw.c
 create mode 100644 tools/coresight/coresight-cfg-bufw.h
 create mode 100644 tools/coresight/coresight-cfg-example1.c
 create mode 100644 tools/coresight/coresight-cfg-example2.c
 create mode 100644 tools/coresight/coresight-cfg-examples.h
 create mode 100644 tools/coresight/coresight-cfg-file-gen.c
 create mode 100644 tools/coresight/coresight-cfg-file-gen.h
 create mode 100644 tools/coresight/coresight-cfg-file-read.c
 create mode 100644 tools/coresight/coresight-config-uapi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e9659a5a7fb3..8b848694394e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2301,6 +2301,7 @@ F:	include/dt-bindings/arm/coresight-cti-dt.h
 F:	include/linux/coresight*
 F:	include/uapi/linux/coresight*
 F:	samples/coresight/*
+F:	tools/coresight/*
 F:	tools/perf/Documentation/arm-coresight.txt
 F:	tools/perf/arch/arm/util/auxtrace.c
 F:	tools/perf/arch/arm/util/cs-etm.c
diff --git a/drivers/hwtracing/coresight/coresight-config-table.h b/drivers/hwtracing/coresight/coresight-config-table.h
index 2cd8fb0630e2..b9935bff7169 100644
--- a/drivers/hwtracing/coresight/coresight-config-table.h
+++ b/drivers/hwtracing/coresight/coresight-config-table.h
@@ -9,7 +9,12 @@
 
 #include <linux/sizes.h>
 
+#ifdef __KERNEL__
 #include "coresight-config.h"
+#else
+#include "coresight-config-uapi.h"
+#endif
+
 
 /*
  * Configurations and features can be dynamically loaded at runtime
diff --git a/tools/coresight/Makefile b/tools/coresight/Makefile
new file mode 100644
index 000000000000..175d2b45bb44
--- /dev/null
+++ b/tools/coresight/Makefile
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0-only
+include ../scripts/Makefile.include
+include ../scripts/Makefile.arch
+
+# Makefile to build the coresight configuration table file reader and generator tools
+
+this-makefile := $(lastword $(MAKEFILE_LIST))
+tools-src := $(realpath $(dir $(this-makefile)))
+srctree := $(realpath $(dir $(tools-src)/../../.))
+
+# ensure we use all as the default - skip anything in included Makefile
+.DEFAULT_GOAL = all
+# MAKECMDGOALS isn't set if there's no explicit goal in the
+# command line, so set the default.
+MAKECMDGOALS ?= $(.DEFAULT_GOAL)
+
+# cs tools includes
+CS_TOOLS_INCLUDE = -I$(srctree)/drivers/hwtracing/coresight -I$(srctree)/tools/include/ \
+		-I$(srctree)/tools/include/uapi -I$(srctree)/tools/coresight
+
+# compile flags
+CFLAGS += $(CPPFLAGS) -c -Wall -DLINUX -Wno-switch -Wlogical-op -fPIC $(CS_TOOLS_INCLUDE)
+
+# object files
+coresight-cfg-file-gen-objs := coresight-cfg-file-gen.o coresight-cfg-bufw.o \
+				coresight-cfg-example1.o coresight-cfg-example2.o
+coresight-cfg-file-read-objs := coresight-cfg-file-read.o coresight-config-table.o
+
+# debug variant
+ifdef DEBUG
+CFLAGS += -g -O0 -DDEBUG
+else
+CFLAGS += -O2 -DNDEBUG
+endif
+
+.PHONY: all
+all:  coresight-cfg-file-gen coresight-cfg-file-read
+
+coresight-config-table.o: src_copy
+	$(CC) $(CFLAGS) coresight-config-table.c -o coresight-config-table.o
+
+.PHONY: src_copy
+src_copy:
+	@cp $(srctree)/drivers/hwtracing/coresight/coresight-config-table.c $(srctree)/tools/coresight/.
+
+coresight-cfg-file-gen: $(coresight-cfg-file-gen-objs)
+	$(CC) $(LDFLAGS) $(coresight-cfg-file-gen-objs) -o coresight-cfg-file-gen
+
+coresight-cfg-file-read: $(coresight-cfg-file-read-objs)
+	$(CC) $(LDFLAGS) $(coresight-cfg-file-read-objs) -o coresight-cfg-file-read
+
+clean:
+	rm -f coresight-cfg-file-gen coresight-cfg-file-read
+	rm -f *.o
+	rm -f coresight-config-table.c
+	rm -f *.cscfg
diff --git a/tools/coresight/coresight-cfg-bufw.c b/tools/coresight/coresight-cfg-bufw.c
new file mode 100644
index 000000000000..3fa7ee968758
--- /dev/null
+++ b/tools/coresight/coresight-cfg-bufw.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020-2022 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#include <string.h>
+
+#include "coresight-cfg-bufw.h"
+#include "coresight-config-uapi.h"
+
+/*
+ * Set of macros to make writing the buffer code easier.
+ *.
+ * Uses naming convention as 'buffer' for the buffer pointer and
+ * 'used' as the current bytes used by the encosing function.
+ */
+#define cscfg_write_u64(val64) { \
+	*(u64 *)(buffer + used) = val64; \
+	used += sizeof(u64); \
+	}
+
+#define cscfg_write_u32(val32) { \
+	*(u32 *)(buffer + used) = val32; \
+	used += sizeof(u32); \
+	}
+
+#define cscfg_write_u16(val16) { \
+	*(u16 *)(buffer + used) = val16; \
+	used += sizeof(u16); \
+	}
+
+#define cscfg_write_u8(val8) { \
+	*(buffer + used) = val8; \
+	used++;	\
+	}
+
+/* write the header at the start of the buffer */
+static int cscfg_table_write_fhdr(u8 *buffer, const int buflen,
+				 const struct cscfg_table_header *fhdr)
+{
+	int used = 0;
+
+	cscfg_write_u32(fhdr->magic_version);
+	cscfg_write_u16(fhdr->length);
+	cscfg_write_u16(fhdr->nr_configs);
+	cscfg_write_u16(fhdr->nr_features);
+	return used;
+}
+
+static int cscfg_table_write_string(u8 *buffer, const int buflen, const char *string)
+{
+	int len, used = 0;
+
+	len = strlen(string);
+	if (len > CSCFG_TABLE_STR_MAXSIZE)
+		return -EINVAL;
+
+	if (buflen < (len + 1 + sizeof(u16)))
+		return -EINVAL;
+
+	cscfg_write_u16((u16)(len + 1));
+	strncpy((char *)(buffer + used), string, len + 1);
+	used += (len + 1);
+
+	return used;
+}
+
+static int cscfg_table_write_elem_hdr(u8 *buffer, const int buflen,
+				     struct cscfg_table_elem_header *ehdr)
+{
+	int used = 0;
+
+	if (buflen < (sizeof(u16) + sizeof(u8)))
+		return -EINVAL;
+
+	cscfg_write_u16(ehdr->elem_length);
+	cscfg_write_u8(ehdr->elem_type);
+
+	return used;
+}
+
+static int cscfg_table_write_config(u8 *buffer, const int buflen,
+				   struct cscfg_config_desc *config_desc)
+{
+	int used = 0, bytes_w, space_req, preset_bytes, i;
+	struct cscfg_table_elem_header ehdr;
+
+	ehdr.elem_length = 0;
+	ehdr.elem_type = CSCFG_TABLE_ELEM_TYPE_CFG;
+
+	/* write element header at current buffer location */
+	bytes_w = cscfg_table_write_elem_hdr(buffer, buflen, &ehdr);
+	if (bytes_w < 0)
+		return bytes_w;
+	used += bytes_w;
+
+	/* write out the configuration name */
+	bytes_w = cscfg_table_write_string(buffer + used, buflen - used,
+					  config_desc->name);
+	if (bytes_w < 0)
+		return bytes_w;
+	used += bytes_w;
+
+	/* write out the description string */
+	bytes_w = cscfg_table_write_string(buffer + used, buflen - used,
+					  config_desc->description);
+	if (bytes_w < 0)
+		return bytes_w;
+	used += bytes_w;
+
+	/*
+	 * calculate the space needed for variables + presets
+	 * [u16 value - nr_presets]
+	 * [u32 value - nr_total_params]
+	 * [u16 value - nr_feat_refs]
+	 * [u64 values] * (nr_presets * nr_total_params)
+	 */
+	preset_bytes = sizeof(u64) * config_desc->nr_presets * config_desc->nr_total_params;
+	space_req = (sizeof(u16) * 2) + sizeof(u32) + preset_bytes;
+
+	if ((buflen - used) < space_req)
+		return -EINVAL;
+
+	cscfg_write_u16((u16)config_desc->nr_presets);
+	cscfg_write_u32((u32)config_desc->nr_total_params);
+	cscfg_write_u16((u16)config_desc->nr_feat_refs);
+	if (preset_bytes) {
+		memcpy(buffer + used, (u8 *)config_desc->presets, preset_bytes);
+		used += preset_bytes;
+	}
+
+	/* now write the feature ref names */
+	for (i = 0; i < config_desc->nr_feat_refs; i++) {
+		bytes_w = cscfg_table_write_string(buffer + used, buflen - used,
+						   config_desc->feat_ref_names[i]);
+		if (bytes_w < 0)
+			return bytes_w;
+		used += bytes_w;
+	}
+
+	/* rewrite the element header with the correct length */
+	ehdr.elem_length = used;
+	bytes_w = cscfg_table_write_elem_hdr(buffer, buflen, &ehdr);
+	/* used must not be updated here */
+	if (bytes_w < 0)
+		return bytes_w;
+
+	return used;
+}
+
+/*
+ * write a parameter structure into the buffer in following format:
+ * [cscfg_table_elem_str]    - parameter name.
+ * [u64 value: param_value] - initial value.
+ */
+static int cscfg_table_write_param(u8 *buffer, const int buflen,
+				  struct cscfg_parameter_desc *param_desc)
+{
+	int used = 0, bytes_w;
+
+	bytes_w = cscfg_table_write_string(buffer + used, buflen - used,
+					  param_desc->name);
+	if (bytes_w < 0)
+		return bytes_w;
+	used += bytes_w;
+
+	if ((buflen - used) < sizeof(u64))
+		return -EINVAL;
+
+	cscfg_write_u64(param_desc->value);
+	return used;
+}
+
+/*
+ * Write a feature element from cscfg_feature_desc in following format:
+ *
+ * [cscfg_table_elem_header] - header length is total bytes to end of param structures.
+ * [cscfg_table_elem_str]    - feature name.
+ * [cscfg_table_elem_str]    - feature description.
+ * [u32 value: match_flags]
+ * [u16 value: nr_regs]	    - number of registers.
+ * [u16 value: nr_params]   - number of parameters.
+ * [cscfg_regval_desc struct] * nr_regs
+ * [PARAM_ELEM] * nr_params
+ */
+static int cscfg_table_write_feat(u8 *buffer, const int buflen,
+				 struct cscfg_feature_desc *feat_desc)
+{
+	struct cscfg_table_elem_header ehdr;
+	struct cscfg_regval_desc *p_reg_desc;
+	int used = 0, bytes_w, i, space_req;
+	u32 val32;
+
+	ehdr.elem_length = 0;
+	ehdr.elem_type = CSCFG_TABLE_ELEM_TYPE_FEAT;
+
+	/* write element header at current buffer location */
+	bytes_w = cscfg_table_write_elem_hdr(buffer, buflen, &ehdr);
+	if (bytes_w < 0)
+		return bytes_w;
+	used += bytes_w;
+
+	/* write out the name string */
+	bytes_w = cscfg_table_write_string(buffer + used, buflen - used,
+					  feat_desc->name);
+	if (bytes_w < 0)
+		return bytes_w;
+	used += bytes_w;
+
+	/* write out the description string */
+	bytes_w = cscfg_table_write_string(buffer + used, buflen - used,
+					  feat_desc->description);
+	if (bytes_w < 0)
+		return bytes_w;
+	used += bytes_w;
+
+	/* check for space for variables and register structures */
+	space_req = (sizeof(u16) * 2) + sizeof(u32) +
+		(sizeof(struct cscfg_regval_desc) * feat_desc->nr_regs);
+	if ((buflen - used) < space_req)
+		return -EINVAL;
+
+	/* write the variables */
+	cscfg_write_u32((u32)feat_desc->match_flags);
+	cscfg_write_u16((u16)feat_desc->nr_regs);
+	cscfg_write_u16((u16)feat_desc->nr_params);
+
+	/*write the registers */
+	for (i = 0; i < feat_desc->nr_regs; i++) {
+		p_reg_desc = (struct cscfg_regval_desc *)&feat_desc->regs_desc[i];
+		CSCFG_TABLE_REG_DESC_INFO_TO_U32(val32, p_reg_desc);
+		cscfg_write_u32(val32);
+		cscfg_write_u64(feat_desc->regs_desc[i].val64);
+	}
+
+	/* write any parameters */
+	for (i = 0; i < feat_desc->nr_params; i++) {
+		bytes_w = cscfg_table_write_param(buffer + used, buflen - used,
+						  &feat_desc->params_desc[i]);
+		if (bytes_w < 0)
+			return bytes_w;
+		used += bytes_w;
+
+	}
+
+	/*
+	 * rewrite the element header at the start of the buffer block
+	 * with the correct length
+	 */
+	ehdr.elem_length = used;
+	bytes_w = cscfg_table_write_elem_hdr(buffer, buflen, &ehdr);
+	/* used must not be updated here */
+	if (bytes_w < 0)
+		return bytes_w;
+
+	return used;
+}
+
+/*
+ * write a buffer from the configuration and feature
+ * descriptors to write into a file for configfs.
+ *
+ * Will only write one config, and/or a number of features,
+ * per the file standard.
+ */
+int cscfg_table_write_buffer(u8 *buffer, const int buflen,
+			    struct cscfg_config_desc **config_descs,
+			    struct cscfg_feature_desc **feat_descs)
+{
+	struct cscfg_table_header fhdr;
+	int used = 0,  bytes_w, i;
+
+	/* init the file header */
+	fhdr.magic_version = CSCFG_TABLE_MAGIC_VERSION;
+	fhdr.length = 0;
+	fhdr.nr_configs = 0;
+	fhdr.nr_features = 0;
+
+	/* count the configs */
+	if (config_descs) {
+		while (config_descs[fhdr.nr_configs])
+			fhdr.nr_configs++;
+	}
+
+	/* count the features */
+	if (feat_descs) {
+		while (feat_descs[fhdr.nr_features])
+			fhdr.nr_features++;
+	}
+
+	/* need a buffer and at least one config or feature */
+	if ((!fhdr.nr_configs && !fhdr.nr_features) ||
+	    !buffer || (buflen > CSCFG_TABLE_MAXSIZE))
+		return -EINVAL;
+
+	/* write a header at the start to get the length of the header */
+	bytes_w = cscfg_table_write_fhdr(buffer, buflen, &fhdr);
+	if (bytes_w < 0)
+		return bytes_w;
+	used += bytes_w;
+
+	/* write configs */
+	for (i = 0; i < fhdr.nr_configs; i++) {
+		bytes_w = cscfg_table_write_config(buffer + used, buflen - used,
+						   config_descs[i]);
+		if (bytes_w < 0)
+			return bytes_w;
+		used += bytes_w;
+	}
+
+	/* write any features */
+	for (i = 0; i < fhdr.nr_features; i++) {
+		bytes_w = cscfg_table_write_feat(buffer + used, buflen - used,
+						 feat_descs[i]);
+		if (bytes_w < 0)
+			return bytes_w;
+		used += bytes_w;
+	}
+
+	/* finally re-write the header at the buffer start with the correct length */
+	fhdr.length = (u16)used;
+	bytes_w = cscfg_table_write_fhdr(buffer, buflen, &fhdr);
+	/* used must not be updated here */
+	if (bytes_w < 0)
+		return bytes_w;
+	return used;
+}
diff --git a/tools/coresight/coresight-cfg-bufw.h b/tools/coresight/coresight-cfg-bufw.h
new file mode 100644
index 000000000000..2d6ce64220a4
--- /dev/null
+++ b/tools/coresight/coresight-cfg-bufw.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020-2022 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#ifndef _CORESIGHT_CFG_BUFW_H
+#define _CORESIGHT_CFG_BUFW_H
+
+#include <linux/types.h>
+
+#include "coresight-config-table.h"
+
+/*
+ * Function to take coresight configurations and features and
+ * write them into a supplied memory buffer for serialisation
+ * into a file.
+ *
+ * Resulting file can then be loaded into the coresight
+ * infrastructure via configfs.
+ */
+int cscfg_table_write_buffer(u8 *buffer, const int buflen,
+			     struct cscfg_config_desc **config_descs,
+			     struct cscfg_feature_desc **feat_descs);
+
+#endif /* _CORESIGHT_CFG_BUFW_H */
diff --git a/tools/coresight/coresight-cfg-example1.c b/tools/coresight/coresight-cfg-example1.c
new file mode 100644
index 000000000000..c562116ffc94
--- /dev/null
+++ b/tools/coresight/coresight-cfg-example1.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020-2022 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+#include <linux/types.h>
+#include <linux/unistd.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include "coresight-cfg-examples.h"
+
+/*
+ * create a configuration only example using the strobing feature
+ */
+
+/* we will provide 4 sets of preset parameter values */
+#define AFDO3_NR_PRESETS	4
+/* the total number of parameters in used features - strobing has 2 */
+#define AFDO3_NR_PARAM_SUM	2
+
+static const char *afdo3_ref_names[] = {
+	"strobing",
+};
+
+/*
+ * set of presets leaves strobing window constant while varying period to allow
+ * experimentation with mark / space ratios for various workloads
+ */
+static u64 afdo3_presets[AFDO3_NR_PRESETS][AFDO3_NR_PARAM_SUM] = {
+	{ 2000, 100 },
+	{ 2000, 1000 },
+	{ 2000, 5000 },
+	{ 2000, 10000 },
+};
+
+struct cscfg_config_desc afdo3 = {
+	.name = "autofdo3",
+	.description = "Setup ETMs with strobing for autofdo\n"
+	"Supplied presets allow experimentation with mark-space ratio for various loads\n",
+	.nr_feat_refs = ARRAY_SIZE(afdo3_ref_names),
+	.feat_ref_names = afdo3_ref_names,
+	.nr_presets = AFDO3_NR_PRESETS,
+	.nr_total_params = AFDO3_NR_PARAM_SUM,
+	.presets = &afdo3_presets[0][0],
+};
+
+static struct cscfg_feature_desc *sample_feats[] = {
+	NULL
+};
+
+static struct cscfg_config_desc *sample_cfgs[] = {
+	&afdo3,
+	NULL
+};
+
+struct cscfg_file_eg_info file_info_eg1 = {
+	.example_name = "example1",
+	.filename = "example1.cscfg",
+	.config_descs = sample_cfgs,
+	.feat_descs = sample_feats,
+};
diff --git a/tools/coresight/coresight-cfg-example2.c b/tools/coresight/coresight-cfg-example2.c
new file mode 100644
index 000000000000..6312a185bd46
--- /dev/null
+++ b/tools/coresight/coresight-cfg-example2.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020-2022 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+#include <linux/types.h>
+#include <linux/unistd.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include "coresight-cfg-examples.h"
+
+/*
+ * create a dual configuration only example using the strobing feature
+ */
+
+/* we will provide 10 sets of preset parameter values */
+#define AFDO_NR_PRESETS		10
+/* the total number of parameters in used features - strobing has 2 */
+#define AFDO_NR_PARAM_SUM	2
+
+static const char *afdo_ref_names[] = {
+	"strobing",
+};
+
+/*
+ * sets of presets leaves strobing window constant while varying period to allow
+ * experimentation with mark / space ratios for various workloads
+ */
+static u64 afdo_set_a_presets[AFDO_NR_PRESETS][AFDO_NR_PARAM_SUM] = {
+	{ 2000, 100 },
+	{ 2000, 1000 },
+	{ 2000, 5000 },
+	{ 2000, 10000 },
+	{ 4000, 100 },
+	{ 4000, 1000 },
+	{ 4000, 5000 },
+	{ 4000, 10000 },
+	{ 6000, 100 },
+	{ 6000, 1000 },
+};
+
+
+static u64 afdo_set_b_presets[AFDO_NR_PRESETS][AFDO_NR_PARAM_SUM] = {
+	{ 6000, 5000 },
+	{ 6000, 10000 },
+	{ 8000, 100 },
+	{ 8000, 1000 },
+	{ 8000, 5000 },
+	{ 8000, 10000 },
+	{ 12000, 100 },
+	{ 12000, 1000 },
+	{ 12000, 5000 },
+	{ 12000, 10000 },
+};
+/* two configurations with differing preset tables */
+struct cscfg_config_desc afdo_seta = {
+	.name = "autofdo_set_a",
+	.description = "Setup ETMs with strobing for autofdo\n"
+	"Supplied presets allow experimentation with mark-space ratio for various loads\n",
+	.nr_feat_refs = ARRAY_SIZE(afdo_ref_names),
+	.feat_ref_names = afdo_ref_names,
+	.nr_presets = AFDO_NR_PRESETS,
+	.nr_total_params = AFDO_NR_PARAM_SUM,
+	.presets = &afdo_set_a_presets[0][0],
+};
+
+struct cscfg_config_desc afdo_setb = {
+	.name = "autofdo_set_b",
+	.description = "Setup ETMs with strobing for autofdo\n"
+	"Supplied presets allow experimentation with mark-space ratio for various loads\n",
+	.nr_feat_refs = ARRAY_SIZE(afdo_ref_names),
+	.feat_ref_names = afdo_ref_names,
+	.nr_presets = AFDO_NR_PRESETS,
+	.nr_total_params = AFDO_NR_PARAM_SUM,
+	.presets = &afdo_set_b_presets[0][0],
+};
+
+
+static struct cscfg_feature_desc *sample_feats[] = {
+	NULL
+};
+
+static struct cscfg_config_desc *sample_cfgs[] = {
+	&afdo_seta,
+	&afdo_setb,
+	NULL
+};
+
+struct cscfg_file_eg_info file_info_eg2 = {
+	.example_name = "example2",
+	.filename = "example2.cscfg",
+	.config_descs = sample_cfgs,
+	.feat_descs = sample_feats,
+};
diff --git a/tools/coresight/coresight-cfg-examples.h b/tools/coresight/coresight-cfg-examples.h
new file mode 100644
index 000000000000..c9719e7b2233
--- /dev/null
+++ b/tools/coresight/coresight-cfg-examples.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020-2022 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#ifndef _CORESIGHT_CFG_EXAMPLES_H
+#define _CORESIGHT_CFG_EXAMPLES_H
+
+#include <linux/kernel.h>
+
+#include "coresight-config-uapi.h"
+
+/*
+ * structure to pass C configuration structure information to
+ * configuration table file generator program
+ */
+struct cscfg_file_eg_info {
+	const char *example_name;
+	const char *filename;
+	struct cscfg_config_desc **config_descs;
+	struct cscfg_feature_desc **feat_descs;
+};
+
+#endif /* _CORESIGHT_CFG_EXAMPLES_H */
diff --git a/tools/coresight/coresight-cfg-file-gen.c b/tools/coresight/coresight-cfg-file-gen.c
new file mode 100644
index 000000000000..c93487d35cee
--- /dev/null
+++ b/tools/coresight/coresight-cfg-file-gen.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020-2022 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#include <linux/types.h>
+#include <linux/unistd.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#include "coresight-cfg-bufw.h"
+#include "coresight-cfg-examples.h"
+#include "coresight-cfg-file-gen.h"
+
+/* array of example table files to generate */
+struct cscfg_file_eg_info *info_ptrs[] = {
+	&file_info_eg1,
+	&file_info_eg2,
+	NULL,
+};
+
+int main(int argc, char **argv)
+{
+	struct cscfg_config_desc **config_descs;
+	struct cscfg_feature_desc **feat_descs;
+	u8 buffer[CSCFG_TABLE_MAXSIZE];
+	int used, idx = 0;
+	FILE *fp;
+	const char *filename;
+
+	printf("Coresight Configuration table file Generator\n\n");
+
+	while (info_ptrs[idx]) {
+		printf("Generating %s example\n", info_ptrs[idx]->example_name);
+		config_descs = info_ptrs[idx]->config_descs;
+		feat_descs = info_ptrs[idx]->feat_descs;
+		filename = info_ptrs[idx]->filename;
+		used = cscfg_table_write_buffer(buffer, CSCFG_TABLE_MAXSIZE,
+					       config_descs, feat_descs);
+
+		if (used < 0) {
+			printf("Error %d writing configuration %s into buffer\n",
+			       used, info_ptrs[idx]->example_name);
+			return used;
+		}
+
+		fp = fopen(filename, "wb");
+		if (fp == NULL) {
+			printf("Error opening file %s\n", filename);
+			return -1;
+		}
+		fwrite(buffer, used, sizeof(u8), fp);
+		fclose(fp);
+		idx++;
+	}
+	return 0;
+}
diff --git a/tools/coresight/coresight-cfg-file-gen.h b/tools/coresight/coresight-cfg-file-gen.h
new file mode 100644
index 000000000000..e823e9c5c508
--- /dev/null
+++ b/tools/coresight/coresight-cfg-file-gen.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020-2022 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#ifndef _CORESIGHT_CFG_FILE_GEN_H
+#define _CORESIGHT_CFG_FILE_GEN_H
+
+/*
+ * references to the configuration and feature example
+ * structures in example source files
+ */
+extern struct cscfg_file_eg_info file_info_eg1;
+extern struct cscfg_file_eg_info file_info_eg2;
+
+#endif /* _CORESIGHT_CFG_FILE_GEN_H */
diff --git a/tools/coresight/coresight-cfg-file-read.c b/tools/coresight/coresight-cfg-file-read.c
new file mode 100644
index 000000000000..153af8a16e65
--- /dev/null
+++ b/tools/coresight/coresight-cfg-file-read.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020-2022 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#include <linux/types.h>
+#include <linux/unistd.h>
+#include <ctype.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "coresight-config-table.h"
+#include "coresight-config-uapi.h"
+
+/*
+ * tool to read and print a generated configuration
+ * re-uses the read code source from the driver.
+ */
+
+static void validate_config_name(const char *name)
+{
+	int i, len = strlen(name);
+
+	for (i = 0; i < len; i++) {
+		if (!isalnum(name[i]) && !(name[i] == '_')) {
+			printf("\n************************************************\n");
+			printf("ERROR: Configuration name %s invalid character(s)\n", name);
+			printf("     : must contain only alphanumeric and _ only\n");
+			printf("************************************************\n");
+		}
+	}
+}
+
+static void print_configs(struct cscfg_table_load_descs *load_descs, int *nr_configs)
+{
+	struct cscfg_config_desc *config_desc;
+	int i, j, p, cfg_idx = 0;
+
+	*nr_configs = 0;
+	config_desc = load_descs->config_descs[cfg_idx];
+	if (!config_desc) {
+		printf("File contains no configurations.\n\n");
+		return;
+	}
+
+	while (config_desc) {
+		printf("Configuration %d\nName:- %s\n", cfg_idx + 1, config_desc->name);
+		validate_config_name(config_desc->name);
+		printf("Description:-\n%s\n", config_desc->description);
+		printf("Uses %d features:-\n", config_desc->nr_feat_refs);
+		for (i = 0; i < config_desc->nr_feat_refs; i++)
+			printf("Feature-%d: %s\n", i + 1, config_desc->feat_ref_names[i]);
+
+		printf("\nProvides %d sets of preset values, %d presets per set\n",
+		       config_desc->nr_presets, config_desc->nr_total_params);
+		if (config_desc->nr_presets) {
+			for (i = 0; i < config_desc->nr_presets; i++) {
+				printf("set[%d]: ", i);
+				for (j = 0; j < config_desc->nr_total_params; j++) {
+					p = (i * config_desc->nr_total_params) + j;
+					printf("0x%lx, ",  config_desc->presets[p]);
+				}
+				printf("\n");
+			}
+		}
+		printf("\n============================================\n");
+		cfg_idx++;
+		config_desc = load_descs->config_descs[cfg_idx];
+		(*nr_configs)++;
+	}
+}
+
+static void print_reg_type_info(u8 type)
+{
+	if (type & CS_CFG_REG_TYPE_STD)
+		printf("std_reg ");
+	if (type & CS_CFG_REG_TYPE_RESOURCE)
+		printf("resource ");
+	if (type & CS_CFG_REG_TYPE_VAL_PARAM)
+		printf("param_index ");
+	if (type & CS_CFG_REG_TYPE_VAL_64BIT)
+		printf("64_bit ");
+	else
+		printf("32_bit ");
+	if (type & CS_CFG_REG_TYPE_VAL_MASK)
+		printf("masked ");
+	if (type & CS_CFG_REG_TYPE_VAL_SAVE)
+		printf("save_on_disable ");
+
+}
+
+static void print_regs(int nr, struct cscfg_regval_desc *regs_desc_array)
+{
+	int i;
+	struct cscfg_regval_desc *reg_desc;
+	u8 type;
+	u16 offset;
+	u16 info;
+
+	for (i = 0; i < nr; i++) {
+		reg_desc = &regs_desc_array[i];
+		type = (u8)reg_desc->type;
+		offset = (u16)reg_desc->offset;
+		info = (u16)reg_desc->hw_info;
+
+		printf("Reg(%d): Type 0x%x: ", i, type);
+		print_reg_type_info(type);
+		printf("\nOffset: 0x%03x; HW Info: 0x%03x\n", offset, info);
+		printf("Value: ");
+		if (type & CS_CFG_REG_TYPE_VAL_64BIT)
+			printf("0x%lx\n", reg_desc->val64);
+		else if (type & CS_CFG_REG_TYPE_VAL_PARAM) {
+			printf("param(%d) ", reg_desc->param_idx);
+			if (type & (CS_CFG_REG_TYPE_VAL_MASK))
+				printf(" mask: 0x%x", reg_desc->mask32);
+			printf("\n");
+		} else {
+			printf("0x%x ", reg_desc->val32);
+			if (type & (CS_CFG_REG_TYPE_VAL_MASK))
+				printf(" mask: 0x%x", reg_desc->mask32);
+			printf("\n");
+		}
+	}
+}
+
+static void print_params(int nr, struct cscfg_parameter_desc *params_desc)
+{
+	int i;
+
+	for (i = 0; i < nr; i++)
+		printf("Param(%d) : %s; Init value 0x%lx\n", i,
+		       params_desc[i].name, params_desc[i].value);
+}
+
+static void print_features(struct cscfg_table_load_descs *load_descs, int *nr_feats)
+{
+	struct cscfg_feature_desc *feat_desc = 0;
+	int idx = 0;
+
+	*nr_feats = 0;
+	feat_desc = load_descs->feat_descs[idx];
+	if (!feat_desc) {
+		printf("File contains no features\n\n");
+		return;
+	}
+
+	while (feat_desc) {
+		printf("Feature %d\nName:- %s\n\n", idx + 1, feat_desc->name);
+		printf("Description:- %s\n", feat_desc->description);
+		printf("Match flags: 0x%x\n", feat_desc->match_flags);
+		printf("\nNumber of Paraneters: %d\n", feat_desc->nr_params);
+		if (feat_desc->nr_params)
+			print_params(feat_desc->nr_params, feat_desc->params_desc);
+		printf("\nNumber of Registers: %d\n", feat_desc->nr_regs);
+		if (feat_desc->nr_regs)
+			print_regs(feat_desc->nr_regs, feat_desc->regs_desc);
+		printf("\n============================================\n");
+
+		/* next feature */
+		idx++;
+		feat_desc = load_descs->feat_descs[idx];
+		(*nr_feats)++;
+	}
+}
+
+int main(int argc, char **argv)
+{
+	FILE *fp;
+	struct cscfg_table_load_descs *load_descs;
+	int err, fsize, nr_configs = 0, nr_feats = 0;
+	u8 buffer[CSCFG_TABLE_MAXSIZE];
+
+	printf("\n\n============================================\n");
+	printf("CoreSight Configuration table file reader");
+	printf("\n============================================\n\n");
+
+	/* need a filename */
+	if (argc <= 1) {
+		printf("Please provide filename on command line\n");
+		return -EINVAL;
+	}
+
+	/* open file and read into the buffer. */
+	fp = fopen(argv[1], "rb");
+	if (fp == NULL) {
+		printf("Error opening file %s\n", argv[1]);
+		return -EINVAL;
+	}
+
+	fseek(fp, 0, SEEK_END);
+	fsize = ftell(fp);
+	rewind(fp);
+	if (fsize > CSCFG_TABLE_MAXSIZE) {
+		printf("Error: Input file too large.");
+		fclose(fp);
+		return -EINVAL;
+	}
+	err = fread(buffer, sizeof(u8), fsize, fp);
+	fclose(fp);
+
+	if (err < fsize) {
+		printf("Error reading file %s\n", argv[1]);
+		return -EINVAL;
+	}
+
+	/* allocate the descriptor structures to be populated by read operation */
+	load_descs = calloc(1, sizeof(struct cscfg_table_load_descs));
+	if (!load_descs) {
+		printf("Error allocating load descs structure.\n");
+		return -ENOMEM;
+	}
+
+	/* read the buffer and create the configuration and feature structures */
+	err = cscfg_table_read_buffer(buffer, fsize, load_descs);
+	if (err) {
+		printf("Error reading configuration file\n");
+		goto exit_free_mem;
+	}
+
+	/* print the contents of the structures */
+	print_configs(load_descs, &nr_configs);
+	print_features(load_descs, &nr_feats);
+
+	printf("\n\n======= Summary ============================\n");
+	printf(" Config File Name:       : %s\n", argv[1]);
+	printf(" Number of Configurations: %d\n", nr_configs);
+	printf(" Number of Features      : %d\n", nr_feats);
+	printf(" Load name               : %s\n", load_descs->load_name);
+	printf("============================================\n\n");
+
+
+exit_free_mem:
+	cscfg_table_free_load_descs(load_descs);
+	free(load_descs);
+	return err;
+}
diff --git a/tools/coresight/coresight-config-uapi.h b/tools/coresight/coresight-config-uapi.h
new file mode 100644
index 000000000000..f3698a5b10ef
--- /dev/null
+++ b/tools/coresight/coresight-config-uapi.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 Linaro Limited, All rights reserved.
+ * Author: Mike Leach <mike.leach@linaro.org>
+ */
+
+#ifndef _CORESIGHT_CORESIGHT_CONFIG_UAPI_H
+#define _CORESIGHT_CORESIGHT_CONFIG_UAPI_H
+
+#include <linux/types.h>
+#include <asm-generic/errno-base.h>
+
+#include <stddef.h>
+#include <string.h>
+#include <stdlib.h>
+
+#include "coresight-config-desc.h"
+
+/*
+ * Userspace versions of the configuration and feature descriptors.
+ * Used in the tools/coresight programs.
+ *
+ * Compatible with structures in coresight-config.h for use in
+ * coresight-config-file.c common reader source file.
+ */
+
+/**
+ * Device feature descriptor - combination of registers and parameters to
+ * program a device to implement a specific complex function.
+ *
+ * UAPI version - removed kernel constructs.
+ *
+ * @name:	 feature name.
+ * @description: brief description of the feature.
+ * @match_flags: matching information if loading into a device
+ * @nr_params:   number of parameters used.
+ * @params_desc: array of parameters used.
+ * @nr_regs:	 number of registers used.
+ * @regs_desc:	 array of registers used.
+ */
+struct cscfg_feature_desc {
+	const char *name;
+	const char *description;
+	u32 match_flags;
+	int nr_params;
+	struct cscfg_parameter_desc *params_desc;
+	int nr_regs;
+	struct cscfg_regval_desc *regs_desc;
+};
+
+/**
+ * Configuration descriptor - describes selectable system configuration.
+ *
+ * A configuration describes device features in use, and may provide preset
+ * values for the parameters in those features.
+ *
+ * A single set of presets is the sum of the parameters declared by
+ * all the features in use - this value is @nr_total_params.
+ *
+ * UAPI version - removed kernel constructs.
+ *
+ * @name:		name of the configuration - used for selection.
+ * @description:	description of the purpose of the configuration.
+ * @nr_feat_refs:	Number of features used in this configuration.
+ * @feat_ref_names:	references to features used in this configuration.
+ * @nr_presets:		Number of sets of presets supplied by this configuration.
+ * @nr_total_params:	Sum of all parameters declared by used features
+ * @presets:		Array of preset values.
+ */
+struct cscfg_config_desc {
+	const char *name;
+	const char *description;
+	int nr_feat_refs;
+	const char **feat_ref_names;
+	int nr_presets;
+	int nr_total_params;
+	const u64 *presets; /* nr_presets * nr_total_params */
+};
+
+/* UAPI allocators for descriptors in common config file buffer read code  */
+static inline void *cscfg_calloc(size_t num, size_t size)
+{
+	return calloc(num, size);
+}
+
+static inline char *cscfg_strdup(const char *str)
+{
+	return strdup(str);
+}
+
+static inline void *cscfg_zalloc(size_t size)
+{
+	void *ptr = malloc(size);
+
+	if (ptr)
+		memset(ptr, 0, size);
+	return ptr;
+}
+
+static inline void cscfg_free(void *mem)
+{
+	free(mem);
+}
+
+#endif /* _CORESIGHT_CORESIGHT_CONFIG_UAPI_H */
-- 
2.25.1


