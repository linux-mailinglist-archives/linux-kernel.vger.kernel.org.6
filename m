Return-Path: <linux-kernel+bounces-204254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA1A8FE643
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E491C254C6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC180198A06;
	Thu,  6 Jun 2024 12:11:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673E8197530
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675862; cv=none; b=dEauC0bOOanIzOPvQwdAS2IwosU+i7UhobfNCdmh9Nh9fbJTJmNZEWd9YJRKP303+gXcw6S4oq5q773h95ol4YoSikFdBOAHy7gKqlBtlKQcqHTA0As+yH4piRHNdFWNcKo+W/fNJJ1FtjSgr7pDZR0Bva3jGzmpPg1x10Q5oME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675862; c=relaxed/simple;
	bh=g5J78wUfojd2WmwHbBCDPFONoHxtPGid/f23v9af9tU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IyrWECULQKgEydictZUIOz3GKMyGdo9PwPYjRIVT/LvNKU/noyb9Svc4gO4TglCN80y4ajKpyPF7Ecwdrx1QL1TIxrrqC02KkRaEjvsijwS2OKBe64c6INHU326TINNadrhH4PjXmaO5rLg6GAVoDGtH46ApA08756gDVw5js9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B4CC4AF5F;
	Thu,  6 Jun 2024 12:11:02 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFBxS-00000000nPp-3rmn;
	Thu, 06 Jun 2024 08:11:06 -0400
Message-ID: <20240606121106.784134644@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 08:10:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Abaci Robot <abaci@linux.alibaba.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [for-next][PATCH 15/15] fgraph: Remove some unused functions
References: <20240606121004.857581251@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

These functions are defined in the fgraph.c file, but not
called elsewhere, so delete these unused functions.

kernel/trace/fgraph.c:273:1: warning: unused function 'set_bitmap_bits'.
kernel/trace/fgraph.c:259:19: warning: unused function 'get_fgraph_type'.

Link: https://lore.kernel.org/linux-trace-kernel/20240606021053.27783-1-jiapeng.chong@linux.alibaba.com

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9289
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index c0e428c87ea5..a13551a023aa 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -255,12 +255,6 @@ static inline int get_frame_offset(struct task_struct *t, int offset)
 	return __get_offset(t->ret_stack[offset]);
 }
 
-/* Get FGRAPH_TYPE from the word from the @offset at ret_stack */
-static inline int get_fgraph_type(struct task_struct *t, int offset)
-{
-	return __get_type(t->ret_stack[offset]);
-}
-
 /* For BITMAP type: get the bitmask from the @offset at ret_stack */
 static inline unsigned long
 get_bitmap_bits(struct task_struct *t, int offset)
@@ -268,13 +262,6 @@ get_bitmap_bits(struct task_struct *t, int offset)
 	return (t->ret_stack[offset] >> FGRAPH_INDEX_SHIFT) & FGRAPH_INDEX_MASK;
 }
 
-/* For BITMAP type: set the bits in the bitmap bitmask at @offset on ret_stack */
-static inline void
-set_bitmap_bits(struct task_struct *t, int offset, unsigned long bitmap)
-{
-	t->ret_stack[offset] |= (bitmap << FGRAPH_INDEX_SHIFT);
-}
-
 /* Write the bitmap to the ret_stack at @offset (does index, offset and bitmask) */
 static inline void
 set_bitmap(struct task_struct *t, int offset, unsigned long bitmap)
-- 
2.43.0



