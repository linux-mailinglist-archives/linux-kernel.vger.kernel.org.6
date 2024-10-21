Return-Path: <linux-kernel+bounces-374324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50389A6895
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDC79B25DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD3E1D1E6D;
	Mon, 21 Oct 2024 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+TOnV9a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917771EF0B8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513934; cv=none; b=cXezd8jtxB5NRlO+BPYLOw5t0+sO+oYstjZ1i+n7zPnAQXr62d4C7TLHengn5C14pWxUoXxqfFDrwdInQzCGc2x80g5hFNdf4p/cxE7l9xIwhNrwYEZlmnwqGwYKnRgvULbhkuEy9SnIXntDGo01b1LS15W9NfJUYs6thFQvU+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513934; c=relaxed/simple;
	bh=sMI+4p6bbn4mBhWbUnHVUAiUgRt6suBuPrQ3jUQZuYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dLCbFywU+L2EX4soCr4IBYZ7dgRKTAzHjqjsC1mQTaHAoSc4JaBgthr08+5GwiB4tGE2IH84YJULD3IZLz6gNCfb8TkxmYLYli3ESfHlJE0Xpjsqwp5zbyboeeopA4bp07pNb9O5F1baMmfP/lIi9lQ1Q++ehjTRlJzY3PRmb7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+TOnV9a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729513931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=171RL1+SWED9LX/FCBKVSSNEGIWh+rc7bti0upgcSBU=;
	b=Z+TOnV9aPWc1AcHenY73HNwbteYHarYWCXT4FhQYkbwBrapLlAF3ScmO58/kUQRwn3T8FP
	MZFtKRMyXJFPg0ChVfqkFE2PWrztccK/BpSDlTdygmVeJ1Cnc4BHqRUN7DLxFQNSXo0K68
	uKPGYHncFokjmpNGvvhvrMvcUvW8QtE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316--4m2MVPbNLGbiqHvXos0_A-1; Mon,
 21 Oct 2024 08:32:09 -0400
X-MC-Unique: -4m2MVPbNLGbiqHvXos0_A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 514C819560B8;
	Mon, 21 Oct 2024 12:32:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.67])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A0196300019D;
	Mon, 21 Oct 2024 12:32:06 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] rtla/timerlat: Do not set params->user_workload with -U
Date: Mon, 21 Oct 2024 14:31:40 +0200
Message-ID: <20241021123140.14652-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Tomas Glozar <tglozar@redhat.com>

Since commit fb9e90a67ee9 ("rtla/timerlat: Make user-space threads
the default"), rtla-timerlat has been defaulting to
params->user_workload if neither that or params->kernel_workload is set.
This has unintentionally made -U, which sets only params->user_hist/top
but not params->user_workload, to behave like -u unless -k is set,
preventing the user from running a custom workload.

Example:
$ rtla timerlat hist -U -c 0 &
[1] 7413
$ python sample/timerlat_load.py 0
Error opening timerlat fd, did you run timerlat -U?
$ ps | grep timerlatu
7415 pts/4    00:00:00 timerlatu/0

Fix the issue by checking for params->user_top/hist instead of
params->user_workload when setting default thread mode.

Fixes: fb9e90a67ee9 ("rtla/timerlat: Make user-space threads
the default")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_hist.c | 2 +-
 tools/tracing/rtla/src/timerlat_top.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index a3907c390d67..829511a71222 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1064,7 +1064,7 @@ timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_hist_param
 	 * If the user did not specify a type of thread, try user-threads first.
 	 * Fall back to kernel threads otherwise.
 	 */
-	if (!params->kernel_workload && !params->user_workload) {
+	if (!params->kernel_workload && !params->user_hist) {
 		retval = tracefs_file_exists(NULL, "osnoise/per_cpu/cpu0/timerlat_fd");
 		if (retval) {
 			debug_msg("User-space interface detected, setting user-threads\n");
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 210b0f533534..3b62519a412f 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -830,7 +830,7 @@ timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_top_params *
 	 * If the user did not specify a type of thread, try user-threads first.
 	 * Fall back to kernel threads otherwise.
 	 */
-	if (!params->kernel_workload && !params->user_workload) {
+	if (!params->kernel_workload && !params->user_top) {
 		retval = tracefs_file_exists(NULL, "osnoise/per_cpu/cpu0/timerlat_fd");
 		if (retval) {
 			debug_msg("User-space interface detected, setting user-threads\n");
-- 
2.47.0


