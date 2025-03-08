Return-Path: <linux-kernel+bounces-552661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B03AA57C6C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3391891128
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A3A1D934D;
	Sat,  8 Mar 2025 17:36:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B20CD528;
	Sat,  8 Mar 2025 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741455411; cv=none; b=kfRyq3XBZjMG9Nx92ezK6GRw8LuHhPKurfiDONiYnTcW0adCeVXMAsux/mQw5G2iwRDk74+TaQ2m/HjZ0K08qHrKSzacT5+raBZhikzFGJsv1MyOdjHWpngH/c+ThFbliKMl86JPzR8euJc7gwgibqNX3OQJdzPZx8KPkpQZMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741455411; c=relaxed/simple;
	bh=BB3LZuB9tJDrDzY4Ie3LaAjfOqqDaX+OJHNb1pEE7e0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HgJUCCiwR4n/MoyRaLGgftJ7X+wZllOO4ZXBgsBv9uMZ4L8MDA+5FkrpPLQJ7a2WKDJQqd2eKAAP0BHErCOEdaFj0BemK6gDPrbPQKQ9M3hNUzZ9MO/1Ds/XP7wcxH/VcHZ7GXFR+YZY63bmL/Hqr0wve78xjjISbUDF76266sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D95C4CEE0;
	Sat,  8 Mar 2025 17:36:50 +0000 (UTC)
Date: Sat, 8 Mar 2025 12:36:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Have parameter to virt_addr_valid() cast to
 pointer
Message-ID: <20250308123649.1330e9ca@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

Some architectures expect the parameter passed to virt_addr_valid() to be
a pointer. Cast the unsigned long parameter to a void pointer.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503090029.zj0DretW-lkp@intel.com/
Fixes: 10a299da2c2b9 ("ring-buffer: Allow persistent ring buffers to be mmapped")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 649724efd1be..94be81edffd2 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7134,7 +7134,7 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 			goto out;
 		}
 
-		if (virt_addr_valid(cpu_buffer->subbuf_ids[s]))
+		if (virt_addr_valid((void *)cpu_buffer->subbuf_ids[s]))
 			page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
 		else
 			page = vmalloc_to_page((void *)cpu_buffer->subbuf_ids[s]);
-- 
2.47.2


