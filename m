Return-Path: <linux-kernel+bounces-564623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07491A6587F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20041888B55
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FFC1E00A0;
	Mon, 17 Mar 2025 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOnK2zFa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1B91A0BD6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229476; cv=none; b=rqjRj9VXW1tMURp7f835KR47p1ZRCYXtMHaq4onRivUfyhXD1ZNYCNxHMIo5gTB3+vGUWO0GDiAUtqf8OEVYG/eu/gJIerxJUiQ5hB9i34lFIo5Lnh0G+1DT3O/3Eh+NTUHqJHmoCPmbsmpKWcAvcT4BZ2mFIkKaURPThRB4OBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229476; c=relaxed/simple;
	bh=xJgC0H9lzIM57GZ1j7kOyitOHpUwGjjj7f2RdwSCtO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lDr1m+FyvcsL8xB+aLA8zpVXIw/C1yxlVbXygb6gh5yMwV7jyylnydQOsM/He4TOIrkYWpJ5H+vKqIODOeJ1VIT9AXxW7JGcwPiJSCHchsYC+O2u2gh6l9YNe9rjMlqkuiBP7YADq60+e/OAX8nfrEoTDbR5NYnEgFNPr81J3So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOnK2zFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F38C4CEF1;
	Mon, 17 Mar 2025 16:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229476;
	bh=xJgC0H9lzIM57GZ1j7kOyitOHpUwGjjj7f2RdwSCtO0=;
	h=From:To:Cc:Subject:Date:From;
	b=QOnK2zFaIXo1k+PFc6R5yMNoKLeDnQBhY+1ZjTWTGut8CDD/Q3glmdwsVdZaY6PHZ
	 pMIRRd9T7rIeZRtMGe32PE3H1rZDF9PXm3WVaWCQKYndT8XnBMbrPCFEnrLWU1Rv7q
	 oN1bSEhokQuc+pxPD1hmUwPJ65CAzYAEBame7TM2vQMVU0uj1b7ii4j2JK12n/MPS5
	 hAb/iLg75Bem4sYl01M7biVwep+X+YSKWI4DuV4CyUVED64kOqDzPY27Z64H7Hy0SV
	 YmwtuCutPi9mvm3waaG2ipSTsizG1DemjK+fWniXonW9/wSIcMUPjSIZx6S96fx8v2
	 B+7sD6Rd38isg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Matteo Rizzo <matteorizzo@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH v2] perf/x86: Check data address for IBS software filter
Date: Mon, 17 Mar 2025 09:37:55 -0700
Message-ID: <20250317163755.1842589-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IBS software filter was to filter kernel samples for regular users in
PMI handler.  It checks the instruction address in the IBS register to
determine if it was in the kernel more or not.

But it turns out that it's possible to report a kernel data address even
if the instruction address belongs to the user space.  Matteo Rizzo
found that when an instruction raises an exception, IBS can report some
kernel data address like IDT while holding the faulting instruction's
RIP.  To prevent an information leak, it should double check if the data
address in PERF_SAMPLE_DATA is in the kernel space as well.

Suggested-by: Matteo Rizzo <matteorizzo@google.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2)
 * fix a build error  (Boris)
 * use kernel_ip() instead  (Peter)
 * combine sw filter checks  (Ravi)

 arch/x86/events/amd/ibs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 7b52b8e3a185157f..fbe10b469e8b03d5 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1267,8 +1267,13 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		regs.flags |= PERF_EFLAGS_EXACT;
 	}
 
+	if (perf_ibs == &perf_ibs_op)
+		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
+
 	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
-	    perf_exclude_event(event, &regs)) {
+	    (perf_exclude_event(event, &regs) ||
+	     ((data.sample_flags & PERF_SAMPLE_ADDR) &&
+	      event->attr.exclude_kernel && kernel_ip(data.addr)))) {
 		throttle = perf_event_account_interrupt(event);
 		goto out;
 	}
@@ -1283,9 +1288,6 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
-	if (perf_ibs == &perf_ibs_op)
-		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
-
 	/*
 	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
 	 * recorded as part of interrupt regs. Thus we need to use rip from
-- 
2.49.0.rc1.451.g8f38331e32-goog


