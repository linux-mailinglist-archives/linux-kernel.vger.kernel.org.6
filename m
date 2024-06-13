Return-Path: <linux-kernel+bounces-213608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52005907798
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068541F2358D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BEA12FB2F;
	Thu, 13 Jun 2024 15:55:07 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7E412EBC7;
	Thu, 13 Jun 2024 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718294107; cv=none; b=pUu0kxVQgodoPDRNMqGHIPT9GAXMKBlpgvJppDFfsVUyRlhFAw3Qb9QuCLeDRtbNbwnandBWBKUQbIagM5W60DbRjIpQ3uKLOoueQr+9O9MmNdnluo5eGkmLprgVha//1OWK8uao6Uffdy2mrKS0U+jPhxVeLl6URimeGSZRqZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718294107; c=relaxed/simple;
	bh=M2xV7vzzrRkxotOFpiEZRBjy2P5R3xO1TuJFrK8U2f0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=doOsIl9YnH+X6u5mhfTnkDFJ8Z5OoOaU8OERpXzWOcuNi8e8SQBqkew0nWRzQEYqpXEcriaRE9KIZaC1LyWgJwLMZfNubRTxzKimLxVciyLkxAIiC2YT9Dv0j/VHlBKWjYIoyr3wQQuZSmhfVunx8l7GCUoV4kLWq+CXWsUqwQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FA4C4AF50;
	Thu, 13 Jun 2024 15:55:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sHmnP-00000001jnV-34AG;
	Thu, 13 Jun 2024 11:55:27 -0400
Message-ID: <20240613155527.591647061@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 13 Jun 2024 11:55:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 David Howells <dhowells@redhat.com>,
 Mike Rapoport <rppt@kernel.org>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH v6 2/2] pstore/ramoops: Add ramoops.mem_name= command line option
References: <20240613155506.811013916@goodmis.org>
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
 Documentation/admin-guide/ramoops.rst | 13 +++++++++++++
 fs/pstore/ram.c                       | 14 ++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
index e9f85142182d..6f534a707b2a 100644
--- a/Documentation/admin-guide/ramoops.rst
+++ b/Documentation/admin-guide/ramoops.rst
@@ -23,6 +23,8 @@ and type of the memory area are set using three variables:
   * ``mem_size`` for the size. The memory size will be rounded down to a
     power of two.
   * ``mem_type`` to specify if the memory type (default is pgprot_writecombine).
+  * ``mem_name`` to specify a memory region defined by ``reserve_mem`` command
+    line parameter.
 
 Typically the default value of ``mem_type=0`` should be used as that sets the pstore
 mapping to pgprot_writecombine. Setting ``mem_type=1`` attempts to use
@@ -118,6 +120,17 @@ Setting the ramoops parameters can be done in several different manners:
 	return ret;
   }
 
+ D. Using a region of memory reserved via ``reserve_mem`` command line
+    parameter. The address and size will be defined by the ``reserve_mem``
+    parameter. Note, that ``reserve_mem`` may not always allocate memory
+    in the same location, and cannot be relied upon. Testing will need
+    to be done, and it may not work on every machine, nor every kernel.
+    Consider this a "best effort" approach. The ``reserve_mem`` option
+    takes a size, alignment and name as arguments. The name is used
+    to map the memory to a label that can be retrieved by ramoops.
+
+	reserver_mem=2M:4096:oops  ramoops.mem_name=oops
+
 You can specify either RAM memory or peripheral devices' memory. However, when
 specifying RAM, be sure to reserve the memory by issuing memblock_reserve()
 very early in the architecture code, e.g.::
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



