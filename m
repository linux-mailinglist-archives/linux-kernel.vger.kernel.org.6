Return-Path: <linux-kernel+bounces-212405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E66905FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 02:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E17D1C21796
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838808BEE;
	Thu, 13 Jun 2024 00:34:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153A0811;
	Thu, 13 Jun 2024 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718238893; cv=none; b=dqqsFwt22fTkIV/kIVMQZBNCrtMUY3vSsEMvHHzZO71hGUb9X1BO8znpJ2/dPCF2XrfYL01PmywysnYduRqGycQ66hDsnqBALb4jNGL6FQr04i4ISOZojQuJE3v0C4LmVG+sNM6sqQlXvRA+8UsIlsUBqc8Bf+c3uveHL5NcH10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718238893; c=relaxed/simple;
	bh=RCywxSRqgN9zs+tmyibAJXz51CnsmORFuB06u95Pauw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=uJg6vPYzj0wpspl+UxnSGXuYuX/VcScB90bwixTIjXmNzXvQCfcED9hYTsaKN99w+mTCqEcFUbqPD4dOvhdq6cZrKJ3e4avWKXhW/fiQOTg96AiDb3+uVvj45TFrMh0c70sLoa9f6VKEiNjfOXzArefzaufFrrNLN2p0+HMTckU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BC8C4AF1C;
	Thu, 13 Jun 2024 00:34:52 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sHYQn-00000001eNW-0G6T;
	Wed, 12 Jun 2024 20:35:09 -0400
Message-ID: <20240613003508.918902349@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 12 Jun 2024 20:34:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 linux-hardening@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>,
 Ross Zwisler <zwisler@google.com>,
 wklin@google.com,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v5 2/2] pstore/ramoops: Add ramoops.mem_name= command line option
References: <20240613003435.401549779@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add a method to find a region specified by reserve_mem=nn:align:name for
ramoops. Adding a kernel command line parameter:

  reserve_mem=12M:4096:oops ramoops.mem_name=oops

Will use the size and location defined by the memmap parameter where it
finds the memory and labels it "oops". The "oops" in the ramoops option
is used to search for it.

This allows for arbitrary RAM to be used for ramoops if it is known that
the memory is not cleared on kernel crashes or soft reboots.

Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/pstore/ram.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index b1a455f42e93..4311fcbc84f2 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -50,6 +50,10 @@ module_param_hw(mem_address, ullong, other, 0400);
 MODULE_PARM_DESC(mem_address,
 		"start of reserved RAM used to store oops/panic logs");
 
+static char *mem_name;
+module_param_named(mem_name, mem_name, charp, 0400);
+MODULE_PARM_DESC(mem_name, "name of kernel param that holds addr");
+
 static ulong mem_size;
 module_param(mem_size, ulong, 0400);
 MODULE_PARM_DESC(mem_size,
@@ -914,6 +918,16 @@ static void __init ramoops_register_dummy(void)
 {
 	struct ramoops_platform_data pdata;
 
+	if (mem_name) {
+		phys_addr_t start;
+		phys_addr_t size;
+
+		if (reserve_mem_find_by_name(mem_name, &start, &size)) {
+			mem_address = start;
+			mem_size = size;
+		}
+	}
+
 	/*
 	 * Prepare a dummy platform data structure to carry the module
 	 * parameters. If mem_size isn't set, then there are no module
-- 
2.43.0



