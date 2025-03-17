Return-Path: <linux-kernel+bounces-563586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A76AEA644D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4BB1892EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B62121B9D5;
	Mon, 17 Mar 2025 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2WsFXV1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA8A217709
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199060; cv=none; b=GpZmWyE060nCucMD+APVVYgkGKlqtiuhEY47X9l9yTHEYeLOZkSN8bhXE94I2t5snrx49DLrPDtIMqAf1mLmIU+pl+I1Q7QwR12y9X1O9YfnQ7hbIW1IRmcHp6+f/cswPb+/uywgfrc+HVk8QEgwmfPy7kikeq5DuqzpzchtO6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199060; c=relaxed/simple;
	bh=m1RbjsO+ZvOohbWjfBM0qDoeRq6O8dvuNDEItgFW4dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3Xg1kAJUMqkCM8LvYJ+FPBmfmPRsTdSDLDU61YeFpLOcm2d3bcUBE0hTJeu71648XSzV3EJUlZsBlaFHz0sChSZWtHSCxOxHsjN0BJflGnMOI7qleHZe6Yc/vrn55vZ5qA1El546qqWRjdTuhvHfY0hBOdGUmXmutPqsrdaJGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2WsFXV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954EAC4CEE3;
	Mon, 17 Mar 2025 08:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742199060;
	bh=m1RbjsO+ZvOohbWjfBM0qDoeRq6O8dvuNDEItgFW4dc=;
	h=From:To:Cc:Subject:Date:From;
	b=m2WsFXV17ntd1fSzuKZZPtQOMh1mgw0HvCAteGsLE+hE2K3Ts44N2RuNKG5zCVHLt
	 4XdL8SLhGzpUIoM+OPGDy2q7+Wf6ET9Ww4ubnixJ3/mgxGc/W+P0XBKc2EOpKEtGk8
	 FrHERn2ZLdmhd+73QVLO+Fr2NJzNaGjSwsB7XGfkDJKbvkP4OXMEx/lmDPeG0Lq0nb
	 ZiV8hL9C/WTHkTChnEc2Lpw+z12fsx9/dzM8icfp5NWDvKJDE3bGR1d+K7uskC8hyL
	 cYM3irnTus2BosJm306yMEgRGeDTEIym6zHC9ceeUta06S42xCTBukIkB5DiOK5GQ5
	 /sR0hzy1ZZF0Q==
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
Subject: [PATCH] perf/x86: Check data address for IBS software filter
Date: Mon, 17 Mar 2025 01:10:58 -0700
Message-ID: <20250317081058.1794729-1-namhyung@kernel.org>
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
 arch/x86/events/amd/ibs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 7b52b8e3a185157f..8b3b76fad587b3ff 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1286,6 +1286,13 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	if (perf_ibs == &perf_ibs_op)
 		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
 
+	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
+	    (event->attr.sample_type & PERF_SAMPLE_ADDR) &&
+	    event->attr.exclude_kernel && !access_ok(data.addr)) {
+		throttle = perf_event_account_interrupt(event);
+		goto out;
+	}
+
 	/*
 	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
 	 * recorded as part of interrupt regs. Thus we need to use rip from
-- 
2.49.0.rc1.451.g8f38331e32-goog


