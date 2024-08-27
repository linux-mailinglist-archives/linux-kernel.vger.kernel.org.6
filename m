Return-Path: <linux-kernel+bounces-302660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7996696018E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DCA1C20C8E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2AD1537A8;
	Tue, 27 Aug 2024 06:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhVvlwI9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6330012E1CD
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 06:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739945; cv=none; b=qPNVSJMBZcrkX/IGzyvAlCvqdaBpJc+/PHmEIaamSoiphE4TTgv/VrHLhek4Zyj7xUQFodXr9Zew3rqlS/aywIkrjV/sXPOOcdF3FCznFwdxOiDivWOukL3erw0C4m+OMMqURnf3nO8eDOWW1/KIoG3PncQHFkrBmaMY2+aMsfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739945; c=relaxed/simple;
	bh=U2H/nnmhKqJ1mAbFf1o4lwVgpgis69qFv/radbpXrfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHkCdabxd7zGG9uCRQjdbXy1Ef52nXDXMiDgd1qwMR/6cp/ftdIdSJ67mCRMU21pomm+aDtsvQUMF/BCqH0Xl1fJR5mVsPDakqIJJAmOXa8Jpg3EENxvk5/btgbTTP3GKVii3z+YHB3JSP5T8JK0NfPP/2A2j89e7zXbsDePclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhVvlwI9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724739942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhFymyY3ZzUyMaZHrWjD0+mazgbdoYhFhxFRaaHDnfA=;
	b=NhVvlwI9Xqee/SUeNYkdmAWgoF0URTfFZuHR+D4CZFWtQEKsw5vMILbPVmpINC2C8gg5Hz
	yonVgcWrK/18SA7lggoGCLT5u0YA2JlOofXDtBi9KWaDQ2743Kn2ooujiQucXMaFs+qTZZ
	WRxS/EU0xLIltAXWMU8ZpqsZhVe5dyU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-abvXgBA1MAqE4a2_bMgsLA-1; Tue, 27 Aug 2024 02:25:40 -0400
X-MC-Unique: abvXgBA1MAqE4a2_bMgsLA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6c3982a0c65so98638237b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 23:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724739939; x=1725344739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhFymyY3ZzUyMaZHrWjD0+mazgbdoYhFhxFRaaHDnfA=;
        b=mMnC4lCH3a66uKusVamXlReHqkG3iRqkekTVLZC5bixzNmRXgaM+3mrQR7sCgc1qnl
         sstlkxwIAqDXG+WlmtGXPpr3tOEy65VxkCallb3cL/IwU3Jql6vQ0obAlEosNNQcSKJD
         yzJEL07VRTXdTshStSMNxtsUpAYFPiloe5c/SsLOzmvGMnO05B5ua5tT4daiqOjGt+iL
         t1c1d2lgT7KvNQc3mLrOP7Ui/9xu1PtO3pSFzTS5HCceEYB3EPmsAV8i8ZnzICOCtChb
         mGM+bE3Xd3YpYfnbrQJrldJUv+y0JoO5/tqOJde0yuRNmljuudrgpDz7nhzTnEkvTU8O
         y8oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKZ7DCPu/ITbb7x7+5R0FPGozMxp5Aj42AxwO+UViQa2JAkke2c7BhO6UB3mEapbCTaLS8jh3M03Tohyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDy7TDaDLVOtpH9vLKoGGJUQxXJfiHaQNEKLwlVMX88SE0p9In
	K3QTncZO3srtbc43rSOa2mIOCvCj62PVJYopPFLUhpz6iZzvAbWuvFg9O01u9f9D0TFGEy0yJx7
	gweNIrLpu1f4auXfbXaz9B9AL8y5qteA4z0ERzEj1knIkptwqSkTnCvkq0ohI0Q==
X-Received: by 2002:a05:690c:fcf:b0:6b2:6cd4:7f92 with SMTP id 00721157ae682-6c71437c598mr132010017b3.5.1724739939588;
        Mon, 26 Aug 2024 23:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVWVMNWNr3EUR2KwhdGnL6M1EPVnmlDwDQ1kPq2zVtyZREcNg3pVJaOfG1nOyO5YCizPH52A==
X-Received: by 2002:a05:690c:fcf:b0:6b2:6cd4:7f92 with SMTP id 00721157ae682-6c71437c598mr132009897b3.5.1724739939245;
        Mon, 26 Aug 2024 23:25:39 -0700 (PDT)
Received: from rhfedora.. ([71.217.43.75])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f1fe176sm521044185a.0.2024.08.26.23.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 23:25:38 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Arnaldo Melo <acme@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v2 3/4] Include test_raw_pylibcpupower.py
Date: Tue, 27 Aug 2024 02:24:35 -0400
Message-ID: <20240827062438.71809-4-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827062438.71809-1-jwyatt@redhat.com>
References: <20240827062438.71809-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This script demonstrates how to make use of, and tests, the bindings.

In the future, this script could become part of a larger test suite to
test the bindings and libcpupower.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---

Changes in v2:
	- None.

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
2.46.0


