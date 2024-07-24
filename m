Return-Path: <linux-kernel+bounces-261562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7F393B910
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF6A2820B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BC113C675;
	Wed, 24 Jul 2024 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3giVy6D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C958513C9CA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 22:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721859238; cv=none; b=teCChZYxVZf0OdkwtoOGX9S2mWrMN8Ohks/WzHYJ9x7bHvh+kwrZ++fl3xqQ7aD35i7q3XQLkQQfS/OH1nx+D5aupt1RW2q9C1r0duI2ZJiK4Jks+JMw/JR+Zr8b1iy7zpDWltfyoPk6tVUDWxKb6/jfNCS0Ry5QJRCWsYPscZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721859238; c=relaxed/simple;
	bh=rdxqSma22UUNhO8GRP1xfHjICj9ttsvc4m76NncJc0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3YI5Nm1jU5J7BgsIYQSrMkGIl9EG5kVs6q74Ys4MiFDLvh/gIUi+dTiLWVBUb7ir6YcOsqbn6aIRMg5K42GBFY5+beLvPN3xNiV+yN8bV6YiiptrhFIh56iuvTEVE/G8Yl8wqwZeWkrbF2fgQiHsZWEh6pa6ekKMRFut33ieeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3giVy6D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721859235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZDN0EpYdGH4QTVcef68WhZG9zzbZoHSE92tNxLJUpI=;
	b=F3giVy6DvfyHEElymKk+N/hm5curq56zJ+UrSvGKveAey49fN/ote/sueBWW1XQAbCEdNV
	7GZp9SADX3MB8COqaNj7atK7dVQ0au8ijFOmtD514Uz0gbIQdx9j+umovQgRoWc3wWI4tg
	MyF6txWrh8tLk7f8Jur9v9nw4mU+PNg=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-fDWMgqDlOu-mHs6qCGbNuA-1; Wed, 24 Jul 2024 18:13:54 -0400
X-MC-Unique: fDWMgqDlOu-mHs6qCGbNuA-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-8200332b4f2so79951241.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721859234; x=1722464034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZDN0EpYdGH4QTVcef68WhZG9zzbZoHSE92tNxLJUpI=;
        b=es2fsAT5JeTgtJQPvwT2aFF9cfda0Jpl+aM/buuXOydrbOytfqZGNuiSCO7juSw8IV
         H9x0yc3VCaie1iwvhEt0t//TexZdEiu07Hg4g4hkB4RrT5r/HQv8ObuOqnsXgQykpjyQ
         a9OWmrw3z9gVbHT7dWbFeB0odNtA6ffS6bnUXUXXu+eLBUbfd1/Qy2jJQd/Q5g9veIJz
         Mupb8nWrXuheIBVZF4v0g/CZdzKhzapFutlyqYaR2F36478xTGhp/VzWg3ttpZHvMwFU
         FoFm8962oYuQ/ivqVjfbDvxcoBpyLLp0pNRIagUocFe0WWLON8qUyoQYzlmNtNqduncr
         n7tA==
X-Forwarded-Encrypted: i=1; AJvYcCUL4fKK2NEMXkLwdplqMSoqtTlzYMRRlkCpTC/C16D0kq2a0EQ94IIdf5R419oh8RUx/vmx+aN7q1mNsvFf2adrobLlYXvyr179I00J
X-Gm-Message-State: AOJu0YxGe46NrY/DsSsLr5QRZGMs/olzFe24lSF61OpvVJhWAjS9CpKK
	KWwuTARv4jat3ArU08dflBNRYQHIjo4qN/rH/0IS7Y+QcGnYcsQmveRzPEyURFHSjq55f+scuWn
	GdUjTQick9ZBT1J88jyQyFoSxf7aPCmWl1aZ6wGcleHbjfGPHDoLlIM9Wgm3MOw==
X-Received: by 2002:a05:6102:2c86:b0:492:8dbc:c1c with SMTP id ada2fe7eead31-493d9aceda8mr167987137.16.1721859233639;
        Wed, 24 Jul 2024 15:13:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcd3gUwhhsm4W+Vb5EQ8SWvV970VSd0d0iC1pmnTuNlKfecuyjyVo3PW17Zk2UTrUJmcQwlg==
X-Received: by 2002:a05:6102:2c86:b0:492:8dbc:c1c with SMTP id ada2fe7eead31-493d9aceda8mr167960137.16.1721859233335;
        Wed, 24 Jul 2024 15:13:53 -0700 (PDT)
Received: from hatbackup.redhat.com ([71.217.44.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7435227sm7542685a.82.2024.07.24.15.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 15:13:53 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: linux-pm@vger.kernel.org,
	"Thomas Renninger" <trenn@suse.com>,
	"Shuah Khan" <shuah@kernel.org>,
	"Shuah Khan" <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-kernel@vger.kernel.org,
	"John Kacur" <jkacur@redhat.com>,
	"Tomas Glozar" <tglozar@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH 1/2] Add SWIG bindings files for libcpupower
Date: Wed, 24 Jul 2024 18:11:19 -0400
Message-ID: <20240724221122.54601-2-jwyatt@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724221122.54601-1-jwyatt@redhat.com>
References: <20240724221122.54601-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SWIG is a tool packaged in Fedora and other distros that can generate
bindings from C and C++ code for several languages including Python,
Perl, and Go.

A latter commit will demonstrate taking a SWIG .i file and
the libcpupower object files to generate the bindings.

Note that while SWIG itself is GPL v3+ licensed; the resulting output,
the bindings code, is permissively licensed. Please see
https://swig.org/legal.html for more details.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 .../power/cpupower/bindings/python/.gitignore |  8 ++++
 tools/power/cpupower/bindings/python/Makefile | 31 +++++++++++++
 tools/power/cpupower/bindings/python/README   | 33 ++++++++++++++
 .../bindings/python/raw_pylibcpupower.i       | 45 +++++++++++++++++++
 4 files changed, 117 insertions(+)
 create mode 100644 tools/power/cpupower/bindings/python/.gitignore
 create mode 100644 tools/power/cpupower/bindings/python/Makefile
 create mode 100644 tools/power/cpupower/bindings/python/README
 create mode 100644 tools/power/cpupower/bindings/python/raw_pylibcpupower.i

diff --git a/tools/power/cpupower/bindings/python/.gitignore b/tools/power/cpupower/bindings/python/.gitignore
new file mode 100644
index 000000000000..b83e0f5e26a0
--- /dev/null
+++ b/tools/power/cpupower/bindings/python/.gitignore
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+__pycache__/
+*.c
+*.o
+*.so
+*.py
+!test_raw_pylibcpupower.py
+!raw_pylibcpupower.i # git keeps ignoring this file
diff --git a/tools/power/cpupower/bindings/python/Makefile b/tools/power/cpupower/bindings/python/Makefile
new file mode 100644
index 000000000000..a6c779333f8d
--- /dev/null
+++ b/tools/power/cpupower/bindings/python/Makefile
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Makefile for libcpupower Python bindings
+#
+# This Makefile expects you have already run the makefile for cpupower to build
+# the .o files in the lib directory for the bindings to be created.
+
+CC=gcc
+
+LIB_DIR = ../../lib
+BIND_DIR = .
+PY_INCLUDE := $(firstword $(shell python-config --includes))
+#PY_INCLUDE = $(shell python-config --includes | awk '{ print $1 }')
+
+OBJECTS_LIB = $(wildcard $(LIB_DIR)/*.o)
+OBJECTS_BIND = $(wildcard $(BIND_DIR)/*.o)
+
+all: _raw_pylibcpupower.so
+
+_raw_pylibcpupower.so: raw_pylibcpupower_wrap.o
+	$(CC) -shared $(OBJECTS_LIB) raw_pylibcpupower_wrap.o -o _raw_pylibcpupower.so # raw_pylibcpupower_wrap.o
+#	$(CC) -shared $(OBJECTS_BIND) $(OBJECTS_LIB) -o _raw_pylibcpupower.so # raw_pylibcpupower_wrap.o
+
+raw_pylibcpupower_wrap.o: raw_pylibcpupower_wrap.c
+	$(CC) -fPIC -c raw_pylibcpupower_wrap.c $(PY_INCLUDE)
+
+raw_pylibcpupower_wrap.c: raw_pylibcpupower.i
+	swig -python raw_pylibcpupower.i
+
+# Will only clean the bindings folder; will not clean the actual cpupower folder
+clean:
+	rm -f raw_pylibcpupower.py raw_pylibcpupower_wrap.c raw_pylibcpupower_wrap.o _raw_pylibcpupower.so
diff --git a/tools/power/cpupower/bindings/python/README b/tools/power/cpupower/bindings/python/README
new file mode 100644
index 000000000000..a2663a2d23d1
--- /dev/null
+++ b/tools/power/cpupower/bindings/python/README
@@ -0,0 +1,33 @@
+
+This folder contains the necessary files to build Python bindings for libcpupower.
+
+To begin, first build the object files for libcpupower by running make in
+the cpupower directory.
+
+Next you will need to install SWIG. Using Fedora:
+
+sudo dnf install swig
+
+Please check that your version of SWIG is compatible with the version of
+Python installed on your machine by checking the SWIG changelog on their
+website. https://swig.org/
+
+Then return to the directory this README is in to run:
+
+make
+
+To run the test script:
+
+python test_raw_pylibcpupower.py
+
+Note that while SWIG itself is GPL v3+ licensed; the resulting output,
+the bindings code, is permissively licensed. Please see
+https://swig.org/legal.html for more details.
+
+Original Bindings Author:
+John B. Wyatt IV
+jwyatt@redhat.com
+sageofredondo@gmail.com
+
+Copyright (C) 2024 Red Hat
+
diff --git a/tools/power/cpupower/bindings/python/raw_pylibcpupower.i b/tools/power/cpupower/bindings/python/raw_pylibcpupower.i
new file mode 100644
index 000000000000..9a920ecf1f47
--- /dev/null
+++ b/tools/power/cpupower/bindings/python/raw_pylibcpupower.i
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+%module raw_pylibcpupower
+%{
+#include "../../lib/cpupower_intern.h"
+#include "../../lib/acpi_cppc.h"
+#include "../../lib/cpufreq.h"
+#include "../../lib/cpuidle.h"
+#include "../../lib/cpupower.h"
+#include "../../lib/powercap.h"
+%}
+
+/*
+ * cpuidle.h
+ */
+
+unsigned int cpuidle_state_count(unsigned int cpu);
+int cpuidle_state_disable(unsigned int cpu, unsigned int idlestate, unsigned int disable);
+
+/*
+ * cpupower.h
+ */
+
+struct cpupower_topology {
+	/* Amount of CPU cores, packages and threads per core in the system */
+	unsigned int cores;
+	unsigned int pkgs;
+	unsigned int threads; /* per core */
+
+	/* Array gets mallocated with cores entries, holding per core info */
+	struct cpuid_core_info *core_info;
+};
+
+struct cpuid_core_info {
+	int pkg;
+	int core;
+	int cpu;
+
+	/* flags */
+	unsigned int is_online:1;
+};
+
+int get_cpu_topology(struct cpupower_topology *cpu_top);
+void cpu_topology_release(struct cpupower_topology cpu_top);
+int cpupower_is_cpu_online(unsigned int cpu);
-- 
2.45.2


