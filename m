Return-Path: <linux-kernel+bounces-171250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4703D8BE1D3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7444288A80
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6E815747E;
	Tue,  7 May 2024 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="DlBDuFVN"
Received: from sender-of-o51.zoho.eu (sender-of-o51.zoho.eu [136.143.169.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99BA73530
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084183; cv=pass; b=rPjUreElMk1bZjax+IWuNzrJs+/6TYDFkq8ZAPrn+Hxur+OuHxBFcdDyMk0Kc6dsf3+ft+85igGZSioacmdA+OjnDyP3YYcgwjn5WNSoJKhyScfmM46+Fw+VPGz4dzAG9pnv6aj8MX9JJcg7FGGwSKCRs6Q+o9Fa8Hb7ibMBN1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084183; c=relaxed/simple;
	bh=UNytWRjy0n4ufLE4F4bgxm6zk7gEYUpI72DLf8Lh5nI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u98cPtB4tuv5RLYwwvWxjt7pBPkKKXmFZy0wy5NkCaHg0md/RylY7xSGxrxNjg37fIZST1d5odXO/sAfRsCX+oXbKDsFtLpJyeGdvnfw7oLpV9YYZvaBg6MrOlPxp3S70m1J7Dluu25t3/V+PdarWuH+6swnDuE36q2i+uQaC/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=DlBDuFVN; arc=pass smtp.client-ip=136.143.169.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
Delivered-To: vitaly@bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1715084147; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=eDhgaghwNO9TkR+6P3sk9209X/Av29QJ+dZ08tiqdNuNI4cO/NbU+FZ9qILWIAFcFELF5KDRIYTUUtCZAZG3UDVhnCloVz/Y/oSkef/idXRnc+HK5hWWhw3fRH4SsM3YvBsIFDLJpWrWNcfDExox9rjD+IrYbev0Y608pwSn3X4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1715084147; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=ztyWG1tL5SLCHcSqhDRsGp0b5KZvYGYaxjeAuQmObZI=; 
	b=C2WDLSV4C3vw7yohjhzOuQmkQE/AXQFqX44q2lX1yhdS4k6w2xy/LjqKbYEaRn02DCgi1h75cWqiOrLmVO9QKIzbBIxBZX9fN6Gs8AroY6L/3wdYQkg5DybRn5TzIl2yGCuUmUDEnPWS01lIZkvg7FdZQNnG+C5Tb4If36ypG+Q=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1715084147;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To:Cc;
	bh=ztyWG1tL5SLCHcSqhDRsGp0b5KZvYGYaxjeAuQmObZI=;
	b=DlBDuFVNVCo7Y0r8HV6HNTPJ3bCx3tbX3/guZf9EpcjlakXuGYdSZsJajtJDUx1c
	u6SQyfkwIyqnlQaemwep7bVHUhVVFei43+CBJKAR6whOeHW/vqiiXvJho5YDDQ7qSdw
	LG3cX7e/ehTLCQ9TxD1cT3Ld8+hyRCJNVlrBQa8A=
Received: by mx.zoho.eu with SMTPS id 1715084145078400.64154813110486;
	Tue, 7 May 2024 14:15:45 +0200 (CEST)
From: Vitalii Bursov <vitaly@bursov.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Vitalii Bursov <vitaly@bursov.com>
Subject: [PATCH v5 3/3] docs: cgroup-v1: clarify that domain levels are system-specific
Date: Tue,  7 May 2024 15:15:33 +0300
Message-Id: <986e31abb79644e74df0b80adc829eb71a1e4551.1715083479.git.vitaly@bursov.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1715083479.git.vitaly@bursov.com>
References: <cover.1715083479.git.vitaly@bursov.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a clarification that domain levels are system-specific
and where to check for system details.

Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
---
 Documentation/admin-guide/cgroup-v1/cpusets.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
index 7d3415eea05d..f401af5e2f09 100644
--- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
+++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
@@ -568,7 +568,7 @@ on the next tick.  For some applications in special situation, waiting
 
 The 'cpuset.sched_relax_domain_level' file allows you to request changing
 this searching range as you like.  This file takes int value which
-indicates size of searching range in levels ideally as follows,
+indicates size of searching range in levels approximately as follows,
 otherwise initial value -1 that indicates the cpuset has no request.
 
 ====== ===========================================================
@@ -581,6 +581,11 @@ otherwise initial value -1 that indicates the cpuset has no request.
    5   search system wide [on NUMA system]
 ====== ===========================================================
 
+Not all levels can be present and values can change depending on the
+system architecture and kernel configuration. Check
+/sys/kernel/debug/sched/domains/cpu*/domain*/ for system-specific
+details.
+
 The system default is architecture dependent.  The system default
 can be changed using the relax_domain_level= boot parameter.
 
-- 
2.20.1


