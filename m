Return-Path: <linux-kernel+bounces-388145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9669B5B41
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFD01C20DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903C21CFEA3;
	Wed, 30 Oct 2024 05:36:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7971CF5E9
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266572; cv=none; b=bd6DCmJrPnQ6WhmnbadgX/7QPQOi4oo+rjHVDJkJSrDd7Y0/wgHCxfe9WduQscM7ZK8oy5zfDEdIBRgGE4OH4qGyNY6xOBoKNJ1yUazEM3dGP/pk+dWCalycn9hv1haSPOW9njStgo4gQ+E66D6dM6vmqdSXxMY3xW8eKhuAxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266572; c=relaxed/simple;
	bh=RZcE8kYwVBL5aI5YvzmADyiAuU5C/gpT3PizaPFFQNc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=LknfrF5M/bLRJvnQ6iNo7LamFRX7FHnv0Yo4UCei/HVBJ7PFFPJ6nartHqcFyMtihG15HzXG4G+daoEADYNZTDJw8fEjCcHG1ckPf3B1WD/twRs3nPgZ6W1unNw8yp1Ptp8EEYckzIKnRkMIfbI/qQZS50DH1RPpcE0+Pi//P5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0672C4CEE9;
	Wed, 30 Oct 2024 05:36:11 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t61OC-00000005BCe-3Bw4;
	Wed, 30 Oct 2024 01:37:04 -0400
Message-ID: <20241030053704.621655585@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 30 Oct 2024 01:36:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>
Subject: [for-next][PATCH 1/7] fgraph: Separate size of ret_stack from PAGE_SIZE
References: <20241030053650.956861738@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The ret_stack (shadow stack used by function graph infrastructure) is
currently defined as PAGE_SIZE. But some architectures which have 64K
PAGE_SIZE, this is way overkill. Also there's an effort to allow the
PAGE_SIZE to be defined at boot up.

Hard code it for now to 4096. In the future, this size may change and even
be dependent on specific architectures.

Link: https://lore.kernel.org/all/e5067bb8-0fcd-4739-9bca-0e872037d5a1@arm.com/

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20241019152951.053f9646@rorschach.local.home
Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 13fcc25d15a0..4ce87982966a 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -153,7 +153,7 @@ enum {
  * SHADOW_STACK_OFFSET:	The size in long words of the shadow stack
  * SHADOW_STACK_MAX_OFFSET: The max offset of the stack for a new frame to be added
  */
-#define SHADOW_STACK_SIZE	(PAGE_SIZE)
+#define SHADOW_STACK_SIZE	(4096)
 #define SHADOW_STACK_OFFSET	(SHADOW_STACK_SIZE / sizeof(long))
 /* Leave on a buffer at the end */
 #define SHADOW_STACK_MAX_OFFSET				\
-- 
2.45.2



