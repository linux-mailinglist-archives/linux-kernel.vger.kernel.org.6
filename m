Return-Path: <linux-kernel+bounces-179033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84648C5AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95231C21CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FD81802CA;
	Tue, 14 May 2024 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxWmw0Ta"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFDA1802BC
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715709651; cv=none; b=J6yNxnAouHbdyitdzU05929YCz1a3DjrtjGnSzJXb5PwIj3VKTr3EOX04ZXy0hlsD7A/tUsc+id7WHUVYOou+lHNEXVI6fvbllHaMjEknDbVoyDm9T9bnZ+egYSx7pA58aCIgzN33sE9OBqTiiGwUSo0upHGqOUrKeih/MupBMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715709651; c=relaxed/simple;
	bh=U1yWnXT2Sr4P5dC2uObQWu8ccCunhmR9/1rilnD2jBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aAVA+9y5rhrjUNtblc/S9PxwVnCOIRrqS3CGQOWhv5eUWlsTeUsVASWC7UJQxSyuvzC2JN4sUwq/kB2l9NQ3aV0lz9y/wZC5Lbd7mptnjbIy0CSGZerjyi9g3m+9ZsRJXKNTDDZ0gB9iAAfFiXPGsUUui2tRlToebRAJ6H5XirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxWmw0Ta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA626C2BD10;
	Tue, 14 May 2024 18:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715709651;
	bh=U1yWnXT2Sr4P5dC2uObQWu8ccCunhmR9/1rilnD2jBg=;
	h=From:To:Cc:Subject:Date:From;
	b=oxWmw0TaAaRNZ3X0MvdRTyFoL/SoNARC5pKMO+sapb0WN1m8CtTZxnq1t8OBxWuNh
	 aUEKCpfw2w+yQMts+xQAmxavfC3+OcRPzkOHL0pY1sdzCTmPVLUxiNihOToWv1IDDU
	 Pm0ML4l645Qy3DVfZ134gtWjn2d6BKJpqkrNf5T5gnGSOTw5JpLVP/k/xHsYFawCdI
	 qk2+3iyQ3EUSeGUEGpXfaC5NiEICBqoiZ+iS0eptPMwav5ZuC4u0wC71893Pu3l38X
	 El+1yh4PAmN2S6lxHRodlnMMk0O/TuQ7tperO9IZ2KIbEb3ywXEYN9hKxGxIRhKpXw
	 Rv+RswwYubt3w==
From: Namhyung Kim <namhyung@kernel.org>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Greg Thelen <gthelen@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Tuan Phan <tuanphan@os.amperecomputing.com>
Subject: [PATCH] perf/arm-dmc620: Fix lockdep assert in ->event_init()
Date: Tue, 14 May 2024 11:00:50 -0700
Message-ID: <20240514180050.182454-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

for_each_sibling_event() checks leader's ctx but it doesn't have the ctx
yet if it's the leader.  Like in perf_event_validate_size(), we should
skip checking siblings in that case.

Fixes: f3c0eba287049 ("perf: Add a few assertions")
Reported-by: Greg Thelen <gthelen@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Tuan Phan <tuanphan@os.amperecomputing.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 drivers/perf/arm_dmc620_pmu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 8a81be2dd5ec..88c17c1d6d49 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -542,12 +542,16 @@ static int dmc620_pmu_event_init(struct perf_event *event)
 	if (event->cpu < 0)
 		return -EINVAL;
 
+	hwc->idx = -1;
+
+	if (event->group_leader == event)
+		return 0;
+
 	/*
 	 * We can't atomically disable all HW counters so only one event allowed,
 	 * although software events are acceptable.
 	 */
-	if (event->group_leader != event &&
-			!is_software_event(event->group_leader))
+	if (!is_software_event(event->group_leader))
 		return -EINVAL;
 
 	for_each_sibling_event(sibling, event->group_leader) {
@@ -556,7 +560,6 @@ static int dmc620_pmu_event_init(struct perf_event *event)
 			return -EINVAL;
 	}
 
-	hwc->idx = -1;
 	return 0;
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


