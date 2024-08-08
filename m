Return-Path: <linux-kernel+bounces-279615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A80E94BF96
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA5B1C22351
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC6818FDB6;
	Thu,  8 Aug 2024 14:21:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA5118EFE8
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126884; cv=none; b=UMIf75m6LgsH1hAehRF6U2MPgEaBTqF8nC2jUoKU1EYr1NnKGaz+ZEHp86uQLHsdg/j8R/lLiPuDT4rheInclu9brK6JMdiAyg9yBRSo2DWX95PbUOwtrWi8vezzvFUBU8l4wIuRjS8DZ0b8RwIhnk2ia69KcxEMoLnl1rvM/FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126884; c=relaxed/simple;
	bh=+cFkbbgK/44VSnlXOWVc8XdxtHti1L8Hcpt4FRMHFd4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gJs3amc6yaqS8voxSCXT1Hwj6K+NpsmGh4oGYlRJ3n0vJ++QeVolljlHLMxrfCwazROfecQnnufHhN15cqyYuRmLMl6HikYpeSnv+bc63kdkZR24VyABDFhmBAVAv7eeOPa71KZ5JyA/nsuM7aYL7WqeS3nzDUaNgAuHZHNrFY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D869DC4AF48;
	Thu,  8 Aug 2024 14:21:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sc416-00000000BTU-3X1y;
	Thu, 08 Aug 2024 10:21:24 -0400
Message-ID: <20240808142124.703952456@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 08 Aug 2024 10:20:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jianhui Zhou <912460177@qq.com>
Subject: [for-linus][PATCH 8/9] ring-buffer: Remove unused function ring_buffer_nr_pages()
References: <20240808142037.495820579@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Jianhui Zhou <912460177@qq.com>

Because ring_buffer_nr_pages() is not an inline function and user accesses
buffer->buffers[cpu]->nr_pages directly, the function ring_buffer_nr_pages
is removed.

Signed-off-by: Jianhui Zhou <912460177@qq.com>
Link: https://lore.kernel.org/tencent_F4A7E9AB337F44E0F4B858D07D19EF460708@qq.com
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  1 -
 kernel/trace/ring_buffer.c  | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 96d2140b471e..fd35d4ec12e1 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -193,7 +193,6 @@ void ring_buffer_set_clock(struct trace_buffer *buffer,
 void ring_buffer_set_time_stamp_abs(struct trace_buffer *buffer, bool abs);
 bool ring_buffer_time_stamp_abs(struct trace_buffer *buffer);
 
-size_t ring_buffer_nr_pages(struct trace_buffer *buffer, int cpu);
 size_t ring_buffer_nr_dirty_pages(struct trace_buffer *buffer, int cpu);
 
 struct buffer_data_read_page;
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 28853966aa9a..cebd879a30cb 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -692,18 +692,6 @@ u64 ring_buffer_event_time_stamp(struct trace_buffer *buffer,
 	return ts;
 }
 
-/**
- * ring_buffer_nr_pages - get the number of buffer pages in the ring buffer
- * @buffer: The ring_buffer to get the number of pages from
- * @cpu: The cpu of the ring_buffer to get the number of pages from
- *
- * Returns the number of pages used by a per_cpu buffer of the ring buffer.
- */
-size_t ring_buffer_nr_pages(struct trace_buffer *buffer, int cpu)
-{
-	return buffer->buffers[cpu]->nr_pages;
-}
-
 /**
  * ring_buffer_nr_dirty_pages - get the number of used pages in the ring buffer
  * @buffer: The ring_buffer to get the number of pages from
-- 
2.43.0



