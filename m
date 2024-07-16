Return-Path: <linux-kernel+bounces-254167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DF8932FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9451F227D2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA7A1A0702;
	Tue, 16 Jul 2024 18:06:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93181A01B8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153194; cv=none; b=PQICaGQakR++5wGqSppt7RiEQRV84ZlK/RYiKY0Y/zETz9IYBk00TZdOmXIQg0J41RZXp58rq4aKiyqQzl7ej/JVMKkLLRZ+RcvG4a123QmzWTgZWiNEKHffO9m85KW8Tiu3Fubk8cGtg9g29LA8nztr00e/6AlT4481AAD/omk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153194; c=relaxed/simple;
	bh=vMYrVIZS21Q7RXWB1NFE1Hsxh5EjEgaMmk9xdgkOlU8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=q71Vk0E7B68PChBeLPhMQRwUepQkr6XVgXytZJ9j0EsqzG2rSPoI/eLSTXdGHSEK7grp4VG6jXmFAKUBzuYCX18W7LjFvzOUaxDEco4sLU+meJ9ARGNXOMqdtJ+auEtL82+/O03qqIbUNhIHdQ1fy621c+cidD39nhWApfCouKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1F7C4AF13;
	Tue, 16 Jul 2024 18:06:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sTmZP-0000000073z-1REd;
	Tue, 16 Jul 2024 14:06:35 -0400
Message-ID: <20240716180635.200391428@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 16 Jul 2024 14:06:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@goodmis.org,
 "levi.yun" <yeoreum.yun@arm.com>
Subject: [for-next][PATCH 3/3] trace/pid_list: Change gfp flags in pid_list_fill_irq()
References: <20240716180613.399475893@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "levi.yun" <yeoreum.yun@arm.com>

pid_list_fill_irq() runs via irq_work.
When CONFIG_PREEMPT_RT is disabled, it would run in irq_context.
so it shouldn't sleep while memory allocation.

Change gfp flags from GFP_KERNEL to GFP_NOWAIT to prevent sleep in
irq_work.

This change wouldn't impact functionality in practice because the worst-size
is 2K.

Cc: stable@goodmis.org
Fixes: 8d6e90983ade2 ("tracing: Create a sparse bitmask for pid filtering")
Link: https://lore.kernel.org/20240704150226.1359936-1-yeoreum.yun@arm.com
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: levi.yun <yeoreum.yun@arm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/pid_list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index 19b271a12c99..4966e6bbdf6f 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -354,7 +354,7 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 	while (upper_count-- > 0) {
 		union upper_chunk *chunk;
 
-		chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
+		chunk = kzalloc(sizeof(*chunk), GFP_NOWAIT);
 		if (!chunk)
 			break;
 		*upper_next = chunk;
@@ -365,7 +365,7 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 	while (lower_count-- > 0) {
 		union lower_chunk *chunk;
 
-		chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
+		chunk = kzalloc(sizeof(*chunk), GFP_NOWAIT);
 		if (!chunk)
 			break;
 		*lower_next = chunk;
-- 
2.43.0



