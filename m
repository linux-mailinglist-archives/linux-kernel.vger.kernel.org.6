Return-Path: <linux-kernel+bounces-377148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350D09ABA6A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B76F1C22BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051781C28E;
	Wed, 23 Oct 2024 00:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8NpyZs+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5799F171BB
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 00:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729642172; cv=none; b=g+YW6uU1sx7BHa+wxqOywST0x3CdvC+lEHofqnKRZ9SOPuAF9r7xkxdpXq7TGIQylFtsov7Yr+PXSFHeVy8qo80UPDtMRMjZfbO71amHrkWUEqEy9iP+JWWbmH7Zqa217u5x6cXcVtLWIf/I/mpJEpuj4C366RArf8oGc015pPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729642172; c=relaxed/simple;
	bh=19tEuIYfqiZ31nw60wQoKj/BrMPUXOXCbGkABPMtDio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUTMjKLE8ib74Sistoia0pAc+T2uy966BH+cY78f9qU87FS2uRIiUOoY3KG+Nw5UWAm07FaujlOjwDcoPXbRliko5/N6XIR5R0rMBwuYX2DER6wui8RbP+B200VP8E9jENRovRWSFQNu/yhAqQWC+bAnvs2C3Qlm1a7AvsxM55c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8NpyZs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3034C4CEE7;
	Wed, 23 Oct 2024 00:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729642172;
	bh=19tEuIYfqiZ31nw60wQoKj/BrMPUXOXCbGkABPMtDio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d8NpyZs+nIvTORI8b9ezVmcZhx5k/19f3THU1Sz6tPdDk4bJpoc3q9iqoCQ+DczyZ
	 AuVWeHu8DrHMUK+x3jRTWXnXfXxj9L+7D0z7NC8UdLDs7/It8qwoLcFx4RHJ6cR4F1
	 s0Fl8VcOfNnfSTO58/4NWU6keFxoTjgES1UISVCQYkPZgckQhPa2uKs6Mu4WAzZrqY
	 w3VvD8Xubfjk3QZH0iZdFillQA+aFfgA53Sxs/s5QpDSR9hmsTXnSG1SZ4RmhhAxCc
	 bxDBQ5Lu5U47eKZw3oE8jvvZ65p92T0keU+oXZlHxAHzQ0tip9XComAdE/mm3LBl9P
	 weMgJOwI2r1zA==
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
	Sandipan Das <sandipan.das@amd.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 4/5] perf/powerpc: Count dropped samples in core-book3s PMU
Date: Tue, 22 Oct 2024 17:09:27 -0700
Message-ID: <20241023000928.957077-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
In-Reply-To: <20241023000928.957077-1-namhyung@kernel.org>
References: <20241023000928.957077-1-namhyung@kernel.org>
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

Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
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
2.47.0.105.g07ac214952-goog


