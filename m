Return-Path: <linux-kernel+bounces-261563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6A093B912
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47872856E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142D713B58E;
	Wed, 24 Jul 2024 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arbF3inG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B898113CA93
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721859241; cv=none; b=UvaypUDpghTSeAmsVpemQcgX/B8yWH1JnHHcYTgwwcPwdvVP0q3zPpTEEx/mwivX6SJOx3uyMpdjTiC01IgHQJYJg/ViMDyhHG1RlIBYvEGmlhfRT5leugTibqDio7XyIgib9QVbA5YWleehTbdta43UlFtCy32/hhtMOfsA4Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721859241; c=relaxed/simple;
	bh=gNmWzbPCwsNn3iBECMmvE1pa/3xdm645kUt+trqbGcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhwbNcGKqMusfyuQCKJzGZn0ZvG0/+HEf3aMZWonwu0ZmF7qZ42zRyZbGwthwlV4gM1l5EobF+oRQ9ueP7VfEn8mju35NEmw2t+XxmhjNXCZ4zMD8V/k0M7ZZcy1We6GBcoyXjsY6Bt1ZxlpwAYN/SeqyuGpc0orT5gMCgQjMX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=arbF3inG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721859238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1oDlIFLL5CHDliwMOUVKHCIO32QiYYQzCXXQNVqBa5o=;
	b=arbF3inG6LF6vrqTDNZU73E+EAsZnpTEXJn32lEYzbonfHwZQNy0lyTs/rkNC+JslvfyfT
	c7ct3fBIe2Zp1sPe2V2AvFdmnvAL7jiuhWGKQGOWJoYsKMpGT0i441jIgxx3V5NU9b//TM
	lTvywpez78Ije+VDziitsnPVvSd+mPQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-oKyiQaJnPN2PyKLIqirkxw-1; Wed, 24 Jul 2024 18:13:57 -0400
X-MC-Unique: oKyiQaJnPN2PyKLIqirkxw-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5d1f7855cd7so243079eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721859235; x=1722464035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oDlIFLL5CHDliwMOUVKHCIO32QiYYQzCXXQNVqBa5o=;
        b=Cud7+VL2jLzmEUQ9Tj5Dfn3T/lvdBLRIITJxfcfeulPSqbfAMvaZC2V+ByWTbdJR7a
         wW/ApyUnt6xnaWHL3AbDuXT1gWimi+EoSrAK4/3y2LKzw+bKhJbehTDCtGIpn/Cqg6Vk
         GoFHnAu+BLX9/b2HzWCziAHPsDNUUbBXStTqKDy8ZL2ewuTGWJqDea8RDg2DuLSKBSKr
         BZOVtmHU9OvfYfPgolslPlskNYw/L/ud6Rnb+mwMnEAPoIAS6+TnG908mtoH0CrB3drx
         E6eD0DfGq4bhUb9/C+tX7eVl9zytY1AkQGsR4v9rlKuXFR+hg11qaD5DwpqzMzlVXr28
         pbWg==
X-Forwarded-Encrypted: i=1; AJvYcCX9thwbCOlVMFyfs1EfWPm15c+4+ggOMVbMT7Cpq/QHSeXpVqDpMKRoeQtApfe4GrsRARnxfHU64drdlm+Ku66EYRUVj/f6XjpVKvXz
X-Gm-Message-State: AOJu0YwAduT19VOdefoGZOqBwB7Jvta8QZ8BdaN/YSftvn9poczYHEWu
	AhAXNmm6ghvsL9cbjNkiFKmJpDm+8am4KnIefTDHothe2q9MFvKssrVDNIaDFpZeCl+GLhAbbPo
	/kz1g7Z6cGiPssURcxxiCZn9YxYI6K9/5QyNPiP48HPSd+zBRkON6nHZ3axX8HSGY9m2yZarE
X-Received: by 2002:a05:6359:4595:b0:1a8:c0fd:cf2d with SMTP id e5c5f4694b2df-1acf8869b8fmr161039955d.9.1721859235481;
        Wed, 24 Jul 2024 15:13:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8XXO039xnVzDHimc3GzVZUVBr2GcfRiEvX7FSDvCGjlyRhlzijS5vlgD8K63bsxdP19pT4Q==
X-Received: by 2002:a05:6359:4595:b0:1a8:c0fd:cf2d with SMTP id e5c5f4694b2df-1acf8869b8fmr161037355d.9.1721859235139;
        Wed, 24 Jul 2024 15:13:55 -0700 (PDT)
Received: from hatbackup.redhat.com ([71.217.44.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7435227sm7542685a.82.2024.07.24.15.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 15:13:54 -0700 (PDT)
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
Subject: [PATCH 2/2] Include test_raw_pylibcpupower.py
Date: Wed, 24 Jul 2024 18:11:20 -0400
Message-ID: <20240724221122.54601-3-jwyatt@redhat.com>
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

This script demonstrates how to make use of, and tests, the bindings.

The .i file currently only binds a limited subsection of functionality
with the bindings.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 .../bindings/python/test_raw_pylibcpupower.py | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100755 tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py

diff --git a/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py b/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
new file mode 100755
index 000000000000..3d6f62b9556a
--- /dev/null
+++ b/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
@@ -0,0 +1,42 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+
+import raw_pylibcpupower as p
+
+# Simple function call
+
+"""
+Get cstate count
+"""
+cpu_cstates_count = p.cpuidle_state_count(0)
+if cpu_cstates_count > -1:
+    print(f"CPU 0 has {cpu_cstates_count} c-states")
+else:
+    print(f"cstate count error: return code: {cpu_cstates_count}")
+
+"""
+Disable cstate (will fail if the above is 0, ex: a virtual machine)
+"""
+cstate_disabled = p.cpuidle_state_disable(0, 0, 1)
+if cpu_cstates_count == 0:
+    print(f"CPU 0 has {cpu_cstates_count} c-states")
+else:
+    print(f"cstate count error: return code: {cpu_cstates_count}")
+
+match cstate_disabled:
+    case 0:
+        print(f"CPU state disabled")
+    case -1:
+        print(f"Idlestate not available")
+    case _:
+        print(f"Not documented")
+
+
+# Pointer example
+
+topo = p.cpupower_topology()
+total_cpus = p.get_cpu_topology(topo)
+if total_cpus > 0:
+    print(f"Number of total cpus: {total_cpus} and number of cores: {topo.cores}")
+else:
+    print(f"Error: could not get cpu topology")
-- 
2.45.2


