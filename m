Return-Path: <linux-kernel+bounces-546777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A26AA4FEA4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25C3166D90
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88910241107;
	Wed,  5 Mar 2025 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qn6cqf3s"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021B21DC9AA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741177945; cv=none; b=Qj9VhSoxM58X56JZgPPoXP/W7eRs2I2cerfigNn9Ya3M2aL9IKxhB3nalzUEraqkxT2etWlkrB6lxa3mKEPVtZOn2iIQ8vrgTUrhxXRIOoqeuoLSOu7vMQQOE6I10SMEjda7vUfDEgKbx9NonIZnQQ8HAPlFYos/lghHf+wn3Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741177945; c=relaxed/simple;
	bh=dXE3te4kQJY93qBMdosIpzt1ZUS/aM0VyK6cRXSNxrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JsRbrEF/UQkJ3DF3BMdTvjYLgLxAdnfAOVO3LuCCYw4qiXoWbMR4xbHvcgt7uYY7T3vL8YPpUUUXhC+MZeariN9TSrncy43Rvc5ZvvB7APWEYdyTvOQBT3/5FX1z5yI3BKIAKuBpsEA4n+qPD+oLz3ylO9VptwI6skqILzyu/js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qn6cqf3s; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741177940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3GecHDOGgegYwrhEKH8zk3nBufY5dLgCupPlLv22dWw=;
	b=qn6cqf3sA2FKk6XMHEacdujDsO8DkgjUNNT6P13JMtd32+VyTf8QLkGcPeVJztGAau/0wf
	eQ001OyTTF0UxmOIJrlEijXCi5/L4yiUVcKv65ZY03xTtQBwg01TfV5yPsM7l4sEjbcPVg
	jEuTnVzuEQyv5X2Lj8QzFJgz4SFT8Cs=
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
Subject: [PATCH v2] perf/x86: Annotate struct bts_buffer with __counted_by()
Date: Wed,  5 Mar 2025 13:31:34 +0100
Message-ID: <20250305123134.215577-2-thorsten.blum@linux.dev>
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

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- struct_size() changes should be a separate patch as suggested by Ingo
- Link to v1: https://lore.kernel.org/r/20250304183056.78920-2-thorsten.blum@linux.dev/
---
 arch/x86/events/intel/bts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 8f78b0c900ef..c7be60c0b94f 100644
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
-- 
2.48.1


