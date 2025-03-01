Return-Path: <linux-kernel+bounces-540041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B00A4ACD4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 17:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C0F3B21D3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 16:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04361E520E;
	Sat,  1 Mar 2025 16:22:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625361E3DE4
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740846153; cv=none; b=F3LMNzJpIU/o2RmUQHyIo7vnT8exUJ+2u+749WqM/wJ2YiX9ufJGlaL9naJmiJkgx+DCO8eiWiZ+48nL9h6W9ReU9PP8rWiuoJOx1ZYeXDTd7TdzS70RQDafilp6bUdyle6ATCTdol2eZpc7MQxmSLsaqDdsFNjhOl0ExUslhzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740846153; c=relaxed/simple;
	bh=iS/TKtHfTKR62iLUTdR4zjY4hsC+3+pNIMjpfDu7Wzo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IpPtklS/pQzP2gL/SPgn7xvmVG457JGS2SXCiJ61rHDnPmjHCH0PPXJ7ZteqVeLx2Z+4Zn7j3LFtBdPTZl4viBKzci+LMgwzjghMjbbHmUBWq2acvrRx39Vs/Iy8mpeivviKa67hsRyLed/2Eza5Ob6Lh14/xFyeRsV8EE/kDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A08AC4CEEA;
	Sat,  1 Mar 2025 16:22:33 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1toPcX-0000000AgyA-1124;
	Sat, 01 Mar 2025 11:23:21 -0500
Message-ID: <20250301162321.091457102@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 01 Mar 2025 11:23:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Petlan <mpetlan@redhat.com>,
 Veronika Molnarova <vmolnaro@redhat.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [for-next][PATCH 3/3] tracing: gfp: Remove duplication of recording GFP flags
References: <20250301162258.654648143@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The gfp_flags when recorded in the trace require being converted from
their numbers to values. Various macros are used to help facilitate this,
but there's two sets of macros that need to keep track of the same GFP
flags to stay in sync.

Commit 60295b944ff68 ("tracing: gfp: Fix the GFP enum values shown for
user space tracing tools") added a TRACE_GFP_FLAGS macro that holds the
enum ___GFP_*_BIT defined bits, and creates the TRACE_DEFINE_ENUM()
wrapper around them.

The __def_gfpflag_names() macro creates the mapping of various flags or
multiple flags to give them human readable names via the __print_flags()
tracing helper macro.

As the TRACE_GFP_FLAGS is a subset of the __def_gfpflags_names(), it can
be used to cover the individual bit names, by redefining the internal
macro TRACE_GFP_EM():

  #undef TRACE_GFP_EM
  #define TRACE_GFP_EM(a) gfpflag_string(__GFP_##a),

This will remove the bits that are duplicate between the two macros. If a
new bit is created, only the TRACE_GFP_FLAGS needs to be updated and that
will also update the __def_gfpflags_names() macro.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/20250225135611.1942b65c@gandalf.local.home
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/mmflags.h | 41 +++++++++-------------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 72fbfe3caeaf..82371177ef79 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -78,6 +78,13 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
 
 #define gfpflag_string(flag) {(__force unsigned long)flag, #flag}
 
+/*
+ * For the values that match the bits, use the TRACE_GFP_FLAGS
+ * which will allow any updates to be included automatically.
+ */
+#undef TRACE_GFP_EM
+#define TRACE_GFP_EM(a) gfpflag_string(__GFP_##a),
+
 #define __def_gfpflag_names			\
 	gfpflag_string(GFP_TRANSHUGE),		\
 	gfpflag_string(GFP_TRANSHUGE_LIGHT),	\
@@ -91,41 +98,13 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
 	gfpflag_string(GFP_NOIO),		\
 	gfpflag_string(GFP_NOWAIT),		\
 	gfpflag_string(GFP_DMA),		\
-	gfpflag_string(__GFP_HIGHMEM),		\
 	gfpflag_string(GFP_DMA32),		\
-	gfpflag_string(__GFP_HIGH),		\
-	gfpflag_string(__GFP_IO),		\
-	gfpflag_string(__GFP_FS),		\
-	gfpflag_string(__GFP_NOWARN),		\
-	gfpflag_string(__GFP_RETRY_MAYFAIL),	\
-	gfpflag_string(__GFP_NOFAIL),		\
-	gfpflag_string(__GFP_NORETRY),		\
-	gfpflag_string(__GFP_COMP),		\
-	gfpflag_string(__GFP_ZERO),		\
-	gfpflag_string(__GFP_NOMEMALLOC),	\
-	gfpflag_string(__GFP_MEMALLOC),		\
-	gfpflag_string(__GFP_HARDWALL),		\
-	gfpflag_string(__GFP_THISNODE),		\
-	gfpflag_string(__GFP_RECLAIMABLE),	\
-	gfpflag_string(__GFP_MOVABLE),		\
-	gfpflag_string(__GFP_ACCOUNT),		\
-	gfpflag_string(__GFP_WRITE),		\
 	gfpflag_string(__GFP_RECLAIM),		\
-	gfpflag_string(__GFP_DIRECT_RECLAIM),	\
-	gfpflag_string(__GFP_KSWAPD_RECLAIM),	\
-	gfpflag_string(__GFP_ZEROTAGS)
-
-#ifdef CONFIG_KASAN_HW_TAGS
-#define __def_gfpflag_names_kasan ,			\
-	gfpflag_string(__GFP_SKIP_ZERO),		\
-	gfpflag_string(__GFP_SKIP_KASAN)
-#else
-#define __def_gfpflag_names_kasan
-#endif
+	TRACE_GFP_FLAGS				\
+	{ 0, "none" }
 
 #define show_gfp_flags(flags)						\
-	(flags) ? __print_flags(flags, "|",				\
-	__def_gfpflag_names __def_gfpflag_names_kasan			\
+	(flags) ? __print_flags(flags, "|", __def_gfpflag_names		\
 	) : "none"
 
 #ifdef CONFIG_MMU
-- 
2.47.2



