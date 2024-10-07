Return-Path: <linux-kernel+bounces-353932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C439934A6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55E8282173
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C4B1DD554;
	Mon,  7 Oct 2024 17:16:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207421DC195;
	Mon,  7 Oct 2024 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321414; cv=none; b=O3xKwFvPHnKPpxR62NxkbXz70a/DlTDck3y6FN50MkwoEyfBKazzv8raYO6/G7VLcc7Tpk7pVMa+YAZ2ss3MIFNOOaJzAaI1AfEpdfJA4y491dgxnrcE2FHFGlG3GwqCVSFnhBZJsL4f8wWNL8gqh8eVQJ4QooIS6j1gXq3ludY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321414; c=relaxed/simple;
	bh=lH24Udzh2CIejB1eq0MjXnTe3f1g+72yysWMgDnZksY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=F07MinscO6lBvYY3PSWtsBJOM2ieAW5rS5FmqG+TqBjCJBDSTutyQ4aZwtwQxeTNovlIa/RNlqxKNwZl57BFIOmcZsGMj4PqKfVKZGIUUcvzkxAKwdLGd6N6hbXdqteR1MTfV3zs0ZXR3haQM3d9jOqvtoJqsD1O0JQZbvyPTOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EB5C4CECF;
	Mon,  7 Oct 2024 17:16:52 +0000 (UTC)
Date: Mon, 7 Oct 2024 13:16:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers 
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, Mike 
 Rapoport <mike.rapoport@gmail.com>, Kees Cook <keescook@chromium.org>, Ard
  Biesheuvel <ardb@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3] Documentation/tracing: Mention that
 RESET_ATTACK_MITIGATION can clear memory
Message-ID: <20241007131653.35837081@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

At the 2024 Linux Plumbers Conference, I was talking with Hans de Goede
about the persistent buffer to display traces from previous boots. He
mentioned that UEFI can clear memory. In my own tests I have not seen
this. He later informed me that it requires the config option:

 CONFIG_RESET_ATTACK_MITIGATION

It appears that setting this will allow the memory to be cleared on boot
up, which will definitely clear out the trace of the previous boot.

Add this information under the trace_instance in kernel-parameters.txt
to let people know that this can cause issues.

Link: https://lore.kernel.org/all/20170825155019.6740-2-ard.biesheuvel@linaro.org/

Reported-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v2: https://lore.kernel.org/20241001095734.11a67b4b@gandalf.local.home

- Fixed typo of "you system"

 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..3978fb704c53 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6867,6 +6867,12 @@
 
 				reserve_mem=12M:4096:trace trace_instance=boot_map^traceoff^traceprintk@trace,sched,irq
 
+			Note, saving the trace buffer across reboots does require that the system
+			is set up to not wipe memory. For instance, CONFIG_RESET_ATTACK_MITIGATION
+			can force a memory reset on boot which will clear any trace that was stored.
+			This is just one of many ways that can clear memory. Make sure your system
+			keeps the content of memory across reboots before relying on this option.
+
 			See also Documentation/trace/debugging.rst
 
 
-- 
2.45.2


