Return-Path: <linux-kernel+bounces-547751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC50EA50D13
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC10A1889350
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C0425332F;
	Wed,  5 Mar 2025 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EnK95gVk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E781F5433
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 21:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741208957; cv=none; b=gIpcZBhr0579ZlkwNZDRkJbSHZke3coiW3xXiRYc8L1s5xkhAEtbWajq3bzvR10UmxTfrsTPkcLFNjex08ia+uYbRVNl6PrsiRsoMeCBDmuLfz8p4u28YJ9nvkAO4K2n/8IlNFYHzhIBWMbIcKjdRhYuklMjggDZHHgL62S4RKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741208957; c=relaxed/simple;
	bh=5MzVbm/LAs+F+H+zTiCF4O9dBTGD8VIrr8mu5CUmgEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IxWCWY/KRq+7x7kh6mcroPhxPghhQbRfj8pI0/qewaM2zPitGiqRN6AU1vx1vKiDqI2qTaoa7ZCwGR8E0WMwFPJ5b2vkB+lA9Zsdyn8+Df4iYQJ00p1q1BTutG1o0F+rWAreWVqsaVoeO6QhIjwTpeefEghH16XmJCzOSzzJ4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EnK95gVk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741208953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KHKt2zEc/QTV6k6F5DybCuz0karApHeXVJ670H4cwRE=;
	b=EnK95gVkyuhGdrBAHPi4fpkSuCH7EoD8ginooSQ7E8NlxGb6NLlP0DPIlZDpphxlSmkAq8
	OWwiSCHi7wS0HjR32+Sfl60DQVtGRgEHMQG9ZQk2UBaNgLCfyQHDXHJf68vRO0N16P4roz
	CY47pBcBc4KOhYOrZPS+7zXzttj2wr0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-OANOazruM1m2_swvw3e2ow-1; Wed, 05 Mar 2025 16:09:12 -0500
X-MC-Unique: OANOazruM1m2_swvw3e2ow-1
X-Mimecast-MFC-AGG-ID: OANOazruM1m2_swvw3e2ow_1741208952
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c3b53373f7so1011462285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 13:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741208951; x=1741813751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHKt2zEc/QTV6k6F5DybCuz0karApHeXVJ670H4cwRE=;
        b=kRoKoplkqiHoyQZQI0+NI4be4J4CatS/frFWqBM+H/H0cItHCg3VbbxfwaKJKmP3el
         E0apkNyLIqx9Ww4cZL0df8I4GDfFvIyQMUEJnZYxCelj/Xptehtv5yIqSSvShj03h+Z6
         uX39pVXNdOkb1519z76Bybm8M4N+CPMVrSQyF+pNuduMQ9PcXXvCIeqBIbLf1qWU21+h
         zKaCN32686CxadlO8wEGJ5HlPQF9PIaG7MEFKHWq0AgwzUAY0ou9pmETvzanqILoaeZq
         a08ZPqN1cQhrTSTHPL5qg3e6xkrIbI96NZn6ECZQ2nxpF4auQrLJASHpHth8BLCkd0Bg
         6U9A==
X-Forwarded-Encrypted: i=1; AJvYcCVp05v+NHKmht/5xDDW8cGR1ktuGrA8SVeo5Tw4PACtX9UuCkdEEB4oGKdlnqvq0oeu+owYJVHrx+JLSLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwABHcKH3gZKVsUUI9Ic/pMbWAFGVixHaaBjrKPOAsyQEs5G4tj
	MaSujK6HEBF0DvkcCKebYSiu7DTNoAlKNc5wOtjBjosgbVhWiEIEraCW2gJTmpFZE7vePTV5TwE
	/nDxJtPrcqZTg9i4y1j4fJBmrUK3X0AiMeHDGJ5fqi2ELhbIpj/6CCpHE4ii/lIrBeFsF+Ui/6P
	0=
X-Gm-Gg: ASbGncvunm3YG5v3sPrS4uIjr6w8qjWJxZDyF4cXs24rzwwXxUfH5X4A4W13uNqDLyU
	O0kO/mCYBsWLk6hKbfqcb3mVpqyb12dCHDqz9yvZFFrIHzaOj5yM3jI7iBJn3280yD47VHCN5xw
	lF9G1gT1CN8zjUPwEtykxbOU3zQ60Dmv4cXK4DocOrz+OjUM1pKcEqGw3IUWkq9rNDCT7ZUPTZs
	9JUlycC5C9OZU3pWxueYYQ/WuQkUuVfkEdi3VtsbZVcBliJuS2PtyZCeSZZooS8nlftxC4YJzrO
	gcJQBPbm0k7EWw3MhPNCgiggcg==
X-Received: by 2002:a05:620a:600a:b0:7c3:c0ba:1774 with SMTP id af79cd13be357-7c3d8e60945mr611979885a.26.1741208950943;
        Wed, 05 Mar 2025 13:09:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyMFtn/n214bpFuEQ+36CWAhQsMYLMHYXkXKm2ZX2CJdRQZDCOBv7Dcf40n39WDjiuw5LzxA==
X-Received: by 2002:a05:620a:600a:b0:7c3:c0ba:1774 with SMTP id af79cd13be357-7c3d8e60945mr611975385a.26.1741208950506;
        Wed, 05 Mar 2025 13:09:10 -0800 (PST)
Received: from thinkpad2024.redhat.com ([71.217.65.43])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3de6a993csm89635585a.95.2025.03.05.13.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:09:10 -0800 (PST)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Renninger <trenn@suse.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH] cpupower: Implement CPU physical core querying
Date: Wed,  5 Mar 2025 16:08:59 -0500
Message-ID: <20250305210901.24177-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is also an issue report. get_cpu_topology will always save
into cpupower_topology a cores size of 0. The code to handle this looks
like it was commented out, and what is commented out is missing a curly
bracket.

https://elixir.bootlin.com/linux/v6.13.5/source/tools/power/cpupower/lib/cpupower.c#L206-L212

Inspiration was taken from psutil to implement this by querying
core_cpu_list. Instead of using a hashmap, I used a sorted array, and
counted the number of valid unique strings. The counting of this takes
place before the qsort for .pkg as the following code says it is
dependent on the order of that sort.

The previous code claimed Intel CPUs are not numbered correctly. I was
not able to reproduce that issue and removed that comment and the code.

This commit was tested with the libcpupower SWIG Python bindings and
performed correctly on 4 different setups. The most notable is the
Framework Intel laptop; a hybrid system of 4 P cores (8 threads) and 8 E
cores (8 threads).

The 4 setups: A 4 core virt-manager VM running Fedora 41 4c/4t (specs not
listed) was tested as a sanity test for VMs. A Lenovo Ryzen 7 Pro 7840HS
8c/16t. A Supermico Intel(R) Xeon(R) Gold 6330 CPU w/ 56c/112t with 2 CPU
sockets. A Framework 12th Gen Intel(R) Core(TM) i5-1240P with hybrid
cores.

CPU(s):                   16
  On-line CPU(s) list:    0-15
Vendor ID:                AuthenticAMD
  Model name:             AMD Ryzen 7 PRO 7840HS w/ Radeon 780M Graphics
    CPU family:           25
    Model:                116
    Thread(s) per core:   2
    Core(s) per socket:   8
    Socket(s):            1
    Stepping:             1

CPU(s):                   112
  On-line CPU(s) list:    0-111
Vendor ID:                GenuineIntel
  BIOS Vendor ID:         Intel(R) Corporation
  Model name:             Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz
    BIOS Model name:      Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz  CPU @ 2.0GHz
    BIOS CPU family:      179
    CPU family:           6
    Model:                106
    Thread(s) per core:   2
    Core(s) per socket:   28
    Socket(s):            2
    Stepping:             6

CPU(s):                   16
  On-line CPU(s) list:    0-15
Vendor ID:                GenuineIntel
  Model name:             12th Gen Intel(R) Core(TM) i5-1240P
    CPU family:           6
    Model:                154
    Thread(s) per core:   2
    Core(s) per socket:   12
    Socket(s):            1
    Stepping:             3

Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
---
 tools/power/cpupower/lib/cpupower.c | 48 ++++++++++++++++++++++++-----
 tools/power/cpupower/lib/cpupower.h |  3 ++
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
index 7a2ef691b20e..ce8dfb8e46ab 100644
--- a/tools/power/cpupower/lib/cpupower.c
+++ b/tools/power/cpupower/lib/cpupower.c
@@ -10,6 +10,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 
 #include "cpupower.h"
 #include "cpupower_intern.h"
@@ -150,15 +151,25 @@ static int __compare(const void *t1, const void *t2)
 		return 0;
 }
 
+static int __compare_core_cpu_list(const void *t1, const void *t2)
+{
+	struct cpuid_core_info *top1 = (struct cpuid_core_info *)t1;
+	struct cpuid_core_info *top2 = (struct cpuid_core_info *)t2;
+
+	return strcmp(top1->core_cpu_list, top2->core_cpu_list);
+}
+
 /*
  * Returns amount of cpus, negative on error, cpu_top must be
  * passed to cpu_topology_release to free resources
  *
- * Array is sorted after ->pkg, ->core, then ->cpu
+ * Array is sorted after ->cpu_smt_list ->pkg, ->core
  */
 int get_cpu_topology(struct cpupower_topology *cpu_top)
 {
 	int cpu, last_pkg, cpus = sysconf(_SC_NPROCESSORS_CONF);
+	char path[SYSFS_PATH_MAX];
+	char *last_cpu_list;
 
 	cpu_top->core_info = malloc(sizeof(struct cpuid_core_info) * cpus);
 	if (cpu_top->core_info == NULL)
@@ -183,6 +194,34 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 			cpu_top->core_info[cpu].core = -1;
 			continue;
 		}
+		if (cpu_top->core_info[cpu].core == -1) {
+			strncpy(cpu_top->core_info[cpu].core_cpu_list, "-1", CPULIST_BUFFER);
+			continue;
+		}
+		snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/topology/%s",
+			 cpu, "core_cpus_list");
+		if (cpupower_read_sysfs(
+			path,
+			cpu_top->core_info[cpu].core_cpu_list,
+			CPULIST_BUFFER) < 1) {
+			printf("Warning CPU%u has a 0 size core_cpus_list string", cpu);
+		}
+	}
+
+	/* Count the number of distinct cpu lists to get the physical core
+	 * count.
+	 */
+	qsort(cpu_top->core_info, cpus, sizeof(struct cpuid_core_info),
+	      __compare_core_cpu_list);
+
+	last_cpu_list = cpu_top->core_info[0].core_cpu_list;
+	cpu_top->cores = 1;
+	for (cpu = 1; cpu < cpus; cpu++) {
+		if (strcmp(cpu_top->core_info[cpu].core_cpu_list, last_cpu_list) != 0 &&
+		    cpu_top->core_info[cpu].pkg != -1) {
+			last_cpu_list = cpu_top->core_info[cpu].core_cpu_list;
+			cpu_top->cores++;
+		}
 	}
 
 	qsort(cpu_top->core_info, cpus, sizeof(struct cpuid_core_info),
@@ -203,13 +242,6 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 	if (!(cpu_top->core_info[0].pkg == -1))
 		cpu_top->pkgs++;
 
-	/* Intel's cores count is not consecutively numbered, there may
-	 * be a core_id of 3, but none of 2. Assume there always is 0
-	 * Get amount of cores by counting duplicates in a package
-	for (cpu = 0; cpu_top->core_info[cpu].pkg = 0 && cpu < cpus; cpu++) {
-		if (cpu_top->core_info[cpu].core == 0)
-	cpu_top->cores++;
-	*/
 	return cpus;
 }
 
diff --git a/tools/power/cpupower/lib/cpupower.h b/tools/power/cpupower/lib/cpupower.h
index e4e4292eacec..2e67a080f203 100644
--- a/tools/power/cpupower/lib/cpupower.h
+++ b/tools/power/cpupower/lib/cpupower.h
@@ -2,6 +2,8 @@
 #ifndef __CPUPOWER_CPUPOWER_H__
 #define __CPUPOWER_CPUPOWER_H__
 
+#define CPULIST_BUFFER 5
+
 struct cpupower_topology {
 	/* Amount of CPU cores, packages and threads per core in the system */
 	unsigned int cores;
@@ -16,6 +18,7 @@ struct cpuid_core_info {
 	int pkg;
 	int core;
 	int cpu;
+	char core_cpu_list[CPULIST_BUFFER];
 
 	/* flags */
 	unsigned int is_online:1;
-- 
2.48.1


