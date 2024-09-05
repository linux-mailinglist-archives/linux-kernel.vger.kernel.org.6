Return-Path: <linux-kernel+bounces-316252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3B396CD11
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53A11F298CB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CCF153BED;
	Thu,  5 Sep 2024 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD7dO11t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AE014D29B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505832; cv=none; b=aILGHug+4JhWtTfYHvE3w5FKfKoFx9No9mePMCrJcEyJKP8JvE5ks4PXkwHn6qDXrzTFzvUMen3Sd9ThxmaYA73bScsHXuHCnI/ApYAPQGhbK0/jQxQKfg4ORiioP6BcqzrFdaHMrHssKY6w21d9PGj/AFgQ5kuOXZ44f/1A7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505832; c=relaxed/simple;
	bh=aziyQ829/wguwAKETpVg+pRPOujyMEAw4EHfDvYu2+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEdRiDg4ybPWqy29iZ65txJ3MC7fjO6BA+IQaW0lJEho/jMqADw1dk9RXBBbLuMYsXOOSpwScDTKp5W9vnbf77PmxR8/LBPvwllCzm01zEYt6ppJgqqGik8gCEQZZi7e8lJcQA0mek3Jv5UhPm6w6LNPACUm5rF8fPpffSRfa1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD7dO11t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A766C4CEC2;
	Thu,  5 Sep 2024 03:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725505830;
	bh=aziyQ829/wguwAKETpVg+pRPOujyMEAw4EHfDvYu2+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mD7dO11tKbOKYa8rLno4b/Crd5G/0t/zA0m4V1HbuuyqSnJjEHaj432FJyQzSl4Th
	 XlJvlSa/eHf7EWGOJ05u9teTfKfNVRjVKrSYlpRmMbDFRqW2LninIBueVH4liyHXNA
	 +afXGYrBbO/gIlL9QoN163JckmbxYZu9pIyNopNKDTFHxPMOqwwy63NkF2G6R+bPvZ
	 9yl5sM0AtaLm9hIGQQqQSblCri+P2KLA7GPiFxGs6123EpPo8c0wUGuC85PYsJlxtS
	 BLPU76BDrJhhVUakoOoJap2YCvl1Ttm1wYDrg9/A+ltybTgdWssj2Ug4lpXiNlOem6
	 4n+Yl1JbGTyXA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] perf/powerpc: Count dropped samples in core-book3s PMU
Date: Wed,  4 Sep 2024 20:10:26 -0700
Message-ID: <20240905031027.2567913-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240905031027.2567913-1-namhyung@kernel.org>
References: <20240905031027.2567913-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the hardware limitation, sometimes it could sample kernel address
while attr.exclude_kernel is set.  In that case it silently drops the
sample.  Let's count that case in the new dropped_samples counter.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/powerpc/perf/core-book3s.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 42867469752d73cf..553e288b9f113836 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2287,8 +2287,10 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 	 */
 	if (event->attr.exclude_kernel &&
 	    (event->attr.sample_type & PERF_SAMPLE_IP) &&
-	    is_kernel_addr(mfspr(SPRN_SIAR)))
+	    is_kernel_addr(mfspr(SPRN_SIAR))) {
+		atomic64_inc(&event->dropped_samples);
 		record = 0;
+	}
 
 	/*
 	 * Finally record data if requested.
-- 
2.46.0.469.g59c65b2a67-goog


