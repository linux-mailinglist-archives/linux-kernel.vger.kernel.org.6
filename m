Return-Path: <linux-kernel+bounces-422989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FEB9DA0EE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 03:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE84285BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 02:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94F56A8D2;
	Wed, 27 Nov 2024 02:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RElf2k7h"
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3D9149C6F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732676280; cv=none; b=rjjzzTILltHVnFWMfgu7ql719OkRHCD0ku2AV5cVhvrkmKFJc6+KOS+F1G4C6NOrVEk2EAblV/3RbzGQsRimItqVx1bOAEWYMlryc8jrqP4atZ8U1muM01FiNMFY7D81NsJpSG7BI4Tph4p+idnm3ctBZhU9vHof0znswuOnGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732676280; c=relaxed/simple;
	bh=n3v2ZTKy4XayzWP8FCTYHWj0NyVizXv/4ojexhsmJFw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IULGQvF+ilMqqJhMzMiiNM9uK0C/j3WIw25xciG2SyTPRFI/lkSEidRiHnfrGCn9/DFBIv7t2Yvkpuo1Qf25sWxo4B0Pbdw+pDid6a7/2f0JWZR/hxpnfc9SpybQLqBpyaV7qYpwG6POXcbWDhXOwAuQ+SqpJY1Li1M1m45ksrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RElf2k7h; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-5eb7ed1d6deso4132612eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732676278; x=1733281078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PZpBMHL8IdsZHMO87vdTflNT6N6icPZfEjrZz1n0oFE=;
        b=RElf2k7hxC2lnn71XaZXdrFRxNlEO3cTvLQINs6bpLOLmMzYSMkopjpOmMPFIjFY3d
         uHC/1EUEbCavJrX/h6mv/BrVxzNUjSOcWbLr5PPSgtAe0DQN9pHF0ZMeBPINB0kF+bfx
         1+jK9flgY6W5UOzr/UpUkR+dDJIW/Z5pIQBPUd53eROs5RVLu4nRznVg+NIs4lOPf/Cf
         UH2tb64f9J4QV6uL64fMeLA3qr9dGKEPdzwN4fhsbdMhuV2jxnIk38ImmA+k1G4xCtck
         3QBkCK98BA1OYQNtwbpOVHF30BzJSLqhn0XZqfs4wkuOxZyMS/IhAWr5Vxy51mo7PGX0
         LXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732676278; x=1733281078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZpBMHL8IdsZHMO87vdTflNT6N6icPZfEjrZz1n0oFE=;
        b=oCPWCJ0xMBjczxzVNVIC80sBPmOvgckQiZFgThEucrQeRSlu8D/WaNNEN0tXNvEMk4
         DRoUnBFBUE0pZLHFs+SNNTBAmiCgDrxueWqKajO6/l3D9vsztOTzNBupw7XWNAMeWUXB
         fh3z7XpedSIrwRx+WRDLM2ohiZ2JOS5/vofi0wkPFMOMKg5Dnio+ID5d52cOMK4xyq9E
         KMhHxd0AYldOgaKkU2Xk/NmleBlsbBjO4urwzJ3lzEFJvK9Qzpj74GUb+IkOUmz5QDHo
         NAAL9hNXDah//33HI9w213mdKBBnj64sTZd1NhIKGB04F11zSNycNAAgbY5XSHbrgNNV
         8xRA==
X-Forwarded-Encrypted: i=1; AJvYcCV1hqH1VH2/l0ioVULIkBoR1EevT5rkpSzgmgRn9HyWXNXAEdljIV8p1DlRUR3q/TPmbsGHgO/ZX7T76h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRaL3lBvOvGV1Ebok37HF2N1cIJxy5zXsXzTqzDUNxKIWM9Iky
	z7IjdX2PSi4bCTn8taCF+Y2tyqHu4AZNdUTZrlNgA4OiCRqSXiSU9HmwBNQvw23AHNEDWZumWpD
	6c+6Iqg==
X-Google-Smtp-Source: AGHT+IFKHf2rAZNzRLIYi5pyoUxBdmbZ99C2meBLNg4KMzGEhTQ6C34gvUg4FAtRwQPJnnGabMdsTk0k6Rq/
X-Received: from oabuz16.prod.google.com ([2002:a05:6870:af90:b0:295:ebc2:deb2])
 (user=yuanchu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:5d8f:b0:297:270c:575
 with SMTP id 586e51a60fabf-29dc40097dbmr1170968fac.16.1732676278453; Tue, 26
 Nov 2024 18:57:58 -0800 (PST)
Date: Tue, 26 Nov 2024 18:57:27 -0800
In-Reply-To: <20241127025728.3689245-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241127025728.3689245-1-yuanchu@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241127025728.3689245-9-yuanchu@google.com>
Subject: [PATCH v4 8/9] Docs/admin-guide/cgroup-v2: document workingset reporting
From: Yuanchu Xie <yuanchu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Daniel Watson <ozzloy@each.do>, Yuanchu Xie <yuanchu@google.com>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add workingset reporting documentation for better discoverability of
its memcg interfaces. Point the memcg documentation to
Documentation/admin-guide/mm/workingset_report.rst for more details.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 35 +++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 2cb58daf3089..67a183f08245 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1784,6 +1784,41 @@ The following nested keys are defined.
 	Shows pressure stall information for memory. See
 	:ref:`Documentation/accounting/psi.rst <psi>` for details.
 
+  memory.workingset.page_age
+	A read-only histogram which exists on non-root cgroups.
+
+	This breaks down the cgroup's memory footprint into different
+	types of memory and groups them per-node into user-defined coldness
+	bins.
+
+	The output format of memory.workingset.page_age is::
+
+	  N0
+	  <interval 0 of node 0> type=<type bytes in interval 0 of node 0>
+	  <interval 1 of node 0> type=<type bytes in interval 1 of node 0>
+	  ...
+	  18446744073709551615 type=<the rest of type bytes of node 0>
+
+	The type of memory can be anon, file, or new types added later.
+	Don't rely on the types remaining fixed.  See
+	:ref:`Documentation/admin-guide/mm/workingset_report.rst <workingset_report>`
+	for details.
+
+  memory.workingset.refresh_interval
+	A read-write nested-keyed file which exists on non-root cgroups.
+
+	Setting it to a non-zero value for any node enables working set
+	reporting for that node.  The default is 0 for each node.   See
+	:ref:`Documentation/admin-guide/mm/workingset_report.rst <workingset_report>`
+	for details.
+
+  memory.workingset.report_threshold
+	A read-write nested-keyed file which exists on non-root cgroups.
+
+	The amount of milliseconds to wait before reporting the working
+	set again.  The default is 0 for each node.  See
+	:ref:`Documentation/admin-guide/mm/workingset_report.rst <workingset_report>`
+	for details.
 
 Usage Guidelines
 ~~~~~~~~~~~~~~~~
-- 
2.47.0.338.g60cca15819-goog


