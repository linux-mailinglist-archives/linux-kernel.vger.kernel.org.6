Return-Path: <linux-kernel+bounces-178941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DF28C5997
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690162838B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0451802BA;
	Tue, 14 May 2024 16:17:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A428717F38B
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703427; cv=none; b=igyKOvmrN0NFn5dvKAuoHcRWCWvTWtEcdJN2oB6GRTlzhpoC9LrhDv0csoRKkxEK9MIDlhbp8p/hXCoadtdIYGsLmDze5c5JMabR5pWA26ff2S65ZkgyHrobrQMTWH8u7Ava9hk5Lirc4IL3gLQK5FylSX26pSkO9q3pwuqwu9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703427; c=relaxed/simple;
	bh=VuXalIPTL9sTa7bnw/R/Fo8g3BmGZ0SIUARYlC9WdwQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Fxm0Vbo5TbllSZuUfOPKzokc4acUhhhcDVc+8iLDXaMViOFFLEDHAP4cxDXLWBFGklPp4Q7p4dwqCIOPXSLwMuWjnyg1Q+yPDVODx9JTFk57ER62Et/V08w6gcPrbjCj/tkEUdctT12IlWLYq13Tjvs5m2R1wTcGaNwkihR9UKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7CCC32786;
	Tue, 14 May 2024 16:17:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s6uqJ-00000003tK8-3wp5;
	Tue, 14 May 2024 12:17:31 -0400
Message-ID: <20240514161731.798160831@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 14 May 2024 12:17:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 2/2] selftests/user_events: Add non-spacing separator check
References: <20240514161710.977621701@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Beau Belgrave <beaub@linux.microsoft.com>

The ABI documentation indicates that field separators do not need a
space between them, only a ';'. When no spacing is used, the register
must work. Any subsequent register, with or without spaces, must match
and not return -EADDRINUSE.

Add a non-spacing separator case to our self-test register case to ensure
it works going forward.

Link: https://lore.kernel.org/linux-trace-kernel/20240423162338.292-3-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/testing/selftests/user_events/ftrace_test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index dcd7509fe2e0..0bb46793dcd4 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -261,6 +261,12 @@ TEST_F(user, register_events) {
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
 
+	/* Register without separator spacing should still match */
+	reg.enable_bit = 29;
+	reg.name_args = (__u64)"__test_event u32 field1;u32 field2";
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(0, reg.write_index);
+
 	/* Multiple registers to same name but different args should fail */
 	reg.enable_bit = 29;
 	reg.name_args = (__u64)"__test_event u32 field1;";
@@ -288,6 +294,8 @@ TEST_F(user, register_events) {
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
 	unreg.disable_bit = 30;
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
+	unreg.disable_bit = 29;
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
 
 	/* Delete should have been auto-done after close and unregister */
 	close(self->data_fd);
-- 
2.43.0



