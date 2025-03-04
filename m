Return-Path: <linux-kernel+bounces-545369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3C5A4EC20
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5A7166D37
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFAA280CC3;
	Tue,  4 Mar 2025 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xr3xqP0R"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62532E339B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113134; cv=none; b=HTVlu5bLOSWU3cQznTAIIZQvauDgRqRNzwtW2FTlvtEtTgFw4px/SBYXwhlrYamxOCwgrT1Xy9qzpo+prLM1J3b5MesniIpfkgQuGAQRTioXjJAVJitWIWBaYtsWkzCxs3dtRsQwzadIBEPc/N1vVb4+YD5yxrRAVQ+3jn3mako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113134; c=relaxed/simple;
	bh=vGHhoZfSBCLfhNbj+z9hq68N6pc1lruYQH9l4YRcnOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UHJKtJWKmg6civQw93Hqrm63Cr0iNrUpBEmF1QArTyhKQOLUGkIYs6APmJ0LffmNpnr10SJB9IZNCF2UTfukVz+FMAOYhHLrIqtyWWRDHT2ZZVA8NYaQ0ZfDfU4IAVDQZ7kqmHqPCR0h5yPJkzpYdGllxgNT39NUBo/wAHZrins=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xr3xqP0R; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741113117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mWsz93lszhKk6kI3/ZIcSbVMk3+DGP/u5MfiIB/5Cr4=;
	b=Xr3xqP0RlV+xDEvMzTYkPqpb+gYsJVaS2jtW3vWLTZmr28nvleP3d5GnqX8f7iHuAPkRdi
	88TKyxjk8O2mAVI07tr9wU2OvIC7VExRIoYiAsTNMsykFihtLaAiAKxyo4PcbR3qtkg6/n
	t0vzYkeROEcpW9gXZbus9bVfzvdOJn4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] perf/x86: Annotate struct bts_buffer with __counted_by()
Date: Tue,  4 Mar 2025 19:30:57 +0100
Message-ID: <20250304183056.78920-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by() compiler attribute to the flexible array member
buf to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Use struct_size() to calculate the number of bytes to allocate for a new
bts_buffer. Compared to offsetof(), struct_size() has additional
compile-time checks (e.g., __must_be_array()).

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/events/intel/bts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 8f78b0c900ef..2888edb3f7c5 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -58,7 +58,7 @@ struct bts_buffer {
 	local_t		head;
 	unsigned long	end;
 	void		**data_pages;
-	struct bts_phys	buf[];
+	struct bts_phys	buf[] __counted_by(nr_bufs);
 };
 
 static struct pmu bts_pmu;
@@ -101,7 +101,7 @@ bts_buffer_setup_aux(struct perf_event *event, void **pages,
 	if (overwrite && nbuf > 1)
 		return NULL;
 
-	buf = kzalloc_node(offsetof(struct bts_buffer, buf[nbuf]), GFP_KERNEL, node);
+	buf = kzalloc_node(struct_size(buf, buf, nbuf), GFP_KERNEL, node);
 	if (!buf)
 		return NULL;
 
-- 
2.48.1


