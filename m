Return-Path: <linux-kernel+bounces-361108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCE099A379
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3A11C21CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F3919923C;
	Fri, 11 Oct 2024 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxiH3Hmu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4D6217308
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648676; cv=none; b=Ig3WZz8YMnzUeL58LPjJp7/xfkI1/0kvlxaI6/bbaKQCszPzS/VbiSSEevE+eIuCuKJnYLIxjalXd1cwJgpnq1UvtDZz5DspVl78sF8nEZuSmZ6hy7nx/gZoy6aMCNYGVsw/zjdoL2mPRPuiT6eQurPCjo234Yjyu8sKCY/p6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648676; c=relaxed/simple;
	bh=FW3Re/4MHihDttNtVRFbhXjPmq3mJgrq2bIrt+qc2FY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yw0gN4jERG7mIPvvfB+/Lqr9Y1jPLEof0BGOrp4ND0MVubPDqUr1IPgX/WlXiBH0iaqST55jinzVT7QLqZD6Uecs9TEkoYUPsY0rItn7kV+HHLu+BO9r7WHv9XfSU+JQDmeidO3u+qVIcZ4sR3SvhHUP6OLS2ixAVaAJzYXButk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxiH3Hmu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728648673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fR97u16bwxFaVWpMfck9/Mx40KkeiFmSRTriXUbZio0=;
	b=bxiH3HmuAO98NJDyz6e98W2ei3XNcugNvzR4oeu4DWG+IRZ9TIfKDdi9rTXtw3EawrNPba
	jS+7OcAkD/pdo5Oce/7jFwj9ytvv6Cu1GS6hWiCqgYd0ozGhxWT2HJhQnenYh4/O8ppI8i
	UD3dkzPOd8F9sPZTE/03h9jpdeMBAiA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-mYXRnlHWOXOON-vqiW7jYQ-1; Fri,
 11 Oct 2024 08:11:10 -0400
X-MC-Unique: mYXRnlHWOXOON-vqiW7jYQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B06119560BF;
	Fri, 11 Oct 2024 12:11:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.178])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 882FD1955F42;
	Fri, 11 Oct 2024 12:11:06 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkacur@redhat.com,
	lgoncalv@redhat.com,
	Tomas Glozar <tglozar@redhat.com>,
	Attila Fazekas <afazekas@redhat.com>
Subject: [PATCH 1/2] rtla/timerlat: Make timerlat_top_cpu->*_count unsigned long long
Date: Fri, 11 Oct 2024 14:10:14 +0200
Message-ID: <20241011121015.2868751-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Tomas Glozar <tglozar@redhat.com>

Most fields of struct timerlat_top_cpu are unsigned long long, but the
fields {irq,thread,user}_count are int (32-bit signed).

This leads to overflow when tracing on a large number of CPUs for a long
enough time:
$ rtla timerlat top -a20 -c 1-127 -d 12h
...
  0 12:00:00   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
 1 #43200096  |        0         0         1         2 |        3         2         6        12
...
127 #43200096  |        0         0         1         2 |        3         2         5        11
ALL #119144 e4 |                  0         5         4 |                  2        28        16

The average latency should be 0-1 for IRQ and 5-6 for thread, but is
reported as 5 and 28, about 4 to 5 times more, due to the count
overflowing when summed over all CPUs: 43200096 * 127 = 5486412192,
however, 1191444898 (= 5486412192 mod MAX_INT) is reported instead, as
seen on the last line of the output, and the averages are thus ~4.6
times higher than they should be (5486412192 / 1191444898 = ~4.6).

Fix the issue by changing {irq,thread,user}_count fields to unsigned
long long, similarly to other fields in struct timerlat_top_cpu and to
the count variable in timerlat_top_print_sum.

Reported-by: Attila Fazekas <afazekas@redhat.com>
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_top.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 210b0f533534..ee7c291fc9bb 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -54,9 +54,9 @@ struct timerlat_top_params {
 };
 
 struct timerlat_top_cpu {
-	int			irq_count;
-	int			thread_count;
-	int			user_count;
+	unsigned long long	irq_count;
+	unsigned long long	thread_count;
+	unsigned long long	user_count;
 
 	unsigned long long	cur_irq;
 	unsigned long long	min_irq;
@@ -280,7 +280,7 @@ static void timerlat_top_print(struct osnoise_tool *top, int cpu)
 	/*
 	 * Unless trace is being lost, IRQ counter is always the max.
 	 */
-	trace_seq_printf(s, "%3d #%-9d |", cpu, cpu_data->irq_count);
+	trace_seq_printf(s, "%3d #%-9llu |", cpu, cpu_data->irq_count);
 
 	if (!cpu_data->irq_count) {
 		trace_seq_printf(s, "%s %s %s %s |", no_value, no_value, no_value, no_value);
-- 
2.47.0


