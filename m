Return-Path: <linux-kernel+bounces-285230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90148950AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488B5284391
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCD81A4F2B;
	Tue, 13 Aug 2024 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OKSwEPTo"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF2A1A4F03
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568392; cv=none; b=boH6RNCB92Zh/oE7bckA2NyjN1uwA7oJOpcjUzDOr02GJSFMJI0iSo0//AKoBQ9YbWi5vnV+ltORJjKoAAqRtBceRevsqBz7ItqeycdqhJCuxNwgt59CdoedvGi95QGoaAhqfV/hw4hldn0FlKYIlm7gs4IHCoO1j0nTrlNtdG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568392; c=relaxed/simple;
	bh=E3sZsNR1YDqdKFQzjzHncZWFfHtHPWAP/JNt5fBaZxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HUrDKeYGwg6pmLLdNKvIQJkderdT95819MTjCOyQEUvVaau4IpR+Kra2S9hZZFJBcWirR4l8NCqfM7SGAdZs/8jExsPn9x7vpRCN34eoJXX9zQgDJYTLk9xNWIBtrSx6E/Aoqx8caXsKcu4RbYM7aQlhQl7NmtzDoDSe/Gt/MUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OKSwEPTo; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0be7c74d79so8484950276.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723568390; x=1724173190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hOP5SFFIvPyG4OwQTVSroxGri5wlFhobHFeL7lq0KZY=;
        b=OKSwEPToulZl0T2izwfPaRPN6vFy2Ki+eztr4Ofu2n8anxMZpvueHA5TRSepOjckvw
         1XtpUP0K8pBKDvotcZUpnntALkCe71c55Tqw/8ZKotBE9RMfvgIdy9LhC10xUtnfNSnB
         N0sk325a+O6S0fXbk3TZSjmJm7lMYfm7OH198gJN3n/c6X/izQ5V78tdnrdI7t+Rwa+m
         TxsNRby1cdFkSkCJFyMlAPGmtQT/P378e4dvuyiQHg7+XBBUemWA3pa51eSLgr2GpXYi
         IdWh/dIygaeDLTHrC4BMZvLfl9JGdS2U1QVH52BA44N77y7ggOICaqqEea/p/B3NRCf2
         dBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568390; x=1724173190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOP5SFFIvPyG4OwQTVSroxGri5wlFhobHFeL7lq0KZY=;
        b=msZsbH+MXcXRiEFXSDyvJD/2W+3A/qduYraOjzdcs0RTffNrOWIfOZpNifEB/jpTCv
         UH2NLgfTNza7IolmaY11q0QG5CemkvwpKUQoXRcgYxMLc8mYcjGcY+tgs48EJzt2y00s
         dQfdN8v83lep/O0GWErUSGokvWVnCRInI1IpgdgAAb703ET2d1AYEpHLDbad/klT/Kh2
         i3dNmFiIwjXj9whlkyXbz+QsgFpSs++3w4jdQji079Fg/I9KrXVloSKLJeSu+EHF5VHJ
         J4ae7weyXZr+nTkRy4M2vWJ3xSmcvXm+xrdGi/cmA/HlYQNvSw9RDxFOMAiCRaIb4zI3
         uNdw==
X-Forwarded-Encrypted: i=1; AJvYcCWwawLiQQjbKR64xCskTzh92Qac/6WIiRZtN6zxD9puRvTR/pCfMhRM70yYKjnh/QjorJLV7/jE/UgdX081DGGSDPSgt5Ng7It/73q0
X-Gm-Message-State: AOJu0YydsSzt+uV4W/NwxWBRYXuM8yCt9aSGny/V5jzMhqbVL5T//M4G
	OEfAiBSFypvyhallXAeychIG/YST4ZhxEr3k6aA0MtDhcToxkbxHXZiNMAZviOh0PGQbxmGdMvh
	WZ2/1DQ==
X-Google-Smtp-Source: AGHT+IECAXtBsp42GLKJ5N1BoyX/FjeEZsFBUtplL8hab3FEghl0VDuEX9j5TFSLO+qQ7fOJRfdfV8wWTHGk
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:b50c:66e8:6532:a371])
 (user=yuanchu job=sendgmr) by 2002:a25:7450:0:b0:e05:fc91:8935 with SMTP id
 3f1490d57ef6-e1155a4ac06mr3055276.3.1723568389892; Tue, 13 Aug 2024 09:59:49
 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:56:18 -0700
In-Reply-To: <20240813165619.748102-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813165619.748102-1-yuanchu@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813165619.748102-8-yuanchu@google.com>
Subject: [PATCH v3 7/7] Docs/admin-guide/mm/workingset_report: document sysfs
 and memcg interfaces
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kalesh Singh <kaleshsingh@google.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, 
	Kairui Song <kasong@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yuanchu Xie <yuanchu@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add workingset reporting documentation for better discoverability of
its sysfs and memcg interfaces. Also document the required kernel
config to enable workingset reporting.

Change-Id: Ib9dfc9004473baa6ef26ca7277d220b6199517de
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 Documentation/admin-guide/mm/index.rst        |   1 +
 .../admin-guide/mm/workingset_report.rst      | 105 ++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/workingset_report.rst

diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index 8b35795b664b..61a2a347fc91 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -41,4 +41,5 @@ the Linux memory management.
    swap_numa
    transhuge
    userfaultfd
+   workingset_report
    zswap
diff --git a/Documentation/admin-guide/mm/workingset_report.rst b/Documentation/admin-guide/mm/workingset_report.rst
new file mode 100644
index 000000000000..ddcc0c33a8df
--- /dev/null
+++ b/Documentation/admin-guide/mm/workingset_report.rst
@@ -0,0 +1,105 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Workingset Report
+=================
+Workingset report provides a view of memory coldness in user-defined
+time intervals, i.e. X bytes are Y milliseconds cold. It breaks down
+the user pages in the system per-NUMA node, per-memcg, for both
+anonymous and file pages into histograms that look like:
+::
+
+    1000 anon=137368 file=24530
+    20000 anon=34342 file=0
+    30000 anon=353232 file=333608
+    40000 anon=407198 file=206052
+    9223372036854775807 anon=4925624 file=892892
+
+The workingset reports can be used to drive proactive reclaim, by
+identifying the number of cold bytes in a memcg, then writing to
+``memory.reclaim``.
+
+Quick start
+===========
+Build the kernel with the following configurations. The report relies
+on Multi-gen LRU for page coldness.
+
+* ``CONFIG_LRU_GEN=y``
+* ``CONFIG_LRU_GEN_ENABLED=y``
+* ``CONFIG_WORKINGSET_REPORT=y``
+
+Optionally, the aging kernel daemon can be enabled with the following
+configuration.
+* ``CONFIG_WORKINGSET_REPORT_AGING=y``
+
+Sysfs interfaces
+================
+``/sys/devices/system/node/nodeX/workingset_report/page_age`` provides
+a per-node page age histogram, showing an aggregate of the node's lruvecs.
+Reading this file causes a hierarchical aging of all lruvecs, scanning
+pages and creates a new Multi-gen LRU generation in each lruvec.
+For example:
+::
+
+    1000 anon=0 file=0
+    2000 anon=0 file=0
+    100000 anon=5533696 file=5566464
+    18446744073709551615 anon=0 file=0
+
+``/sys/devices/system/node/nodeX/workingset_report/page_age_intervals``
+is a comma separated list of time in milliseconds that configures what
+the page age histogram uses for aggregation. For the above histogram,
+the intervals are:
+::
+    1000,2000,100000
+
+``/sys/devices/system/node/nodeX/workingset_report/refresh_interval``
+defines the amount of time the report is valid for in milliseconds.
+When a report is still valid, reading the ``page_age`` file shows
+the existing valid report, instead of generating a new one.
+
+``/sys/devices/system/node/nodeX/workingset_report/report_threshold``
+specifies how often the userspace agent can be notified for node
+memory pressure, in milliseconds. When a node reaches its low
+watermarks and wakes up kswapd, programs waiting on ``page_age`` are
+woken up so they can read the histogram and make policy decisions.
+
+Memcg interface
+===============
+While ``page_age_interval`` is defined per-node in sysfs, ``page_age``,
+``refresh_interval`` and ``report_threshold`` are available per-memcg.
+
+``/sys/fs/cgroup/.../memory.workingset.page_age``
+The memcg equivalent of the sysfs workingset page age histogram
+breaks down the workingset of this memcg and its children into
+page age intervals. Each node is prefixed with a node header and
+a newline. Non-proactive direct reclaim on this memcg can also
+wake up userspace agents that are waiting on this file.
+e.g.
+::
+
+    N0
+    1000 anon=0 file=0
+    2000 anon=0 file=0
+    3000 anon=0 file=0
+    4000 anon=0 file=0
+    5000 anon=0 file=0
+    18446744073709551615 anon=0 file=0
+
+``/sys/fs/cgroup/.../memory.workingset.refresh_interval``
+The memcg equivalent of the sysfs refresh interval. A per-node
+number of how much time a page age histogram is valid for, in
+milliseconds.
+e.g.
+::
+
+    echo N0=2000 > memory.workingset.refresh_interval
+
+``/sys/fs/cgroup/.../memory.workingset.report_threshold``
+The memcg equivalent of the sysfs report threshold. A per-node
+number of how often userspace agent waiting on the page age
+histogram can be woken up, in milliseconds.
+e.g.
+::
+
+    echo N0=1000 > memory.workingset.report_threshold
-- 
2.46.0.76.ge559c4bf1a-goog


