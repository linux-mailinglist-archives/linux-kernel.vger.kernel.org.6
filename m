Return-Path: <linux-kernel+bounces-556983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 694BBA5D1DA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34603189CAC1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2190264A89;
	Tue, 11 Mar 2025 21:41:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF13229B01
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729313; cv=none; b=CagmXZTPzg5Dd+j2xHM7+kN+WFFdQSPhkzZTyIx4IPsurSVawsaoxlgCHmAlJzLcJPJ5KHVQ7TnVnROK9E155/ZQsKFMfO4b/xc3efpJ4PHEcCrleRIEe/ny1L9emMgd4uRG1t38eb9WbV7t7/siHM8yZSj92x1KgrUVE42vV6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729313; c=relaxed/simple;
	bh=XEv3LmnSszyWJrndUDLUpYRc/Ykb2Ig+lp0rzCH0oBo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=V4b+olm3byvM2XRXfDWrlFMoGDVd8pmNNCSBB5aMViQb4McmhfbywPVNI/b4r2orGFYqKGJB8RE88RXC0af4cTnqZXq3OjOB2wOuq4uoAou3+IJhSwwBeS+xFJ1jfrb+yH+UvaQ0xtJ0AqoQKXWtwKLMaeI5QE2AfeCbDP6QVDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB93C4CEEC;
	Tue, 11 Mar 2025 21:41:51 +0000 (UTC)
Date: Tue, 11 Mar 2025 17:41:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [for-next][PATCH] ring-buffer: Have parameter to virt_addr_valid()
 cast to pointer
Message-ID: <20250311174149.641b63e3@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/for-next

Head SHA1: 7f4decf8f94431afb7e613ac05e927d3592afe37


Steven Rostedt (1):
      ring-buffer: Have parameter to virt_addr_valid() cast to pointer

----
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit 7f4decf8f94431afb7e613ac05e927d3592afe37
Author: Steven Rostedt <rostedt@goodmis.org>
Date:   Sat Mar 8 12:36:49 2025 -0500

    ring-buffer: Have parameter to virt_addr_valid() cast to pointer
    
    Some architectures expect the parameter passed to virt_addr_valid() to be
    a pointer. Cast the unsigned long parameter to a void pointer.
    
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Link: https://lore.kernel.org/20250308123649.1330e9ca@batman.local.home
    Reported-by: kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/oe-kbuild-all/202503090029.zj0DretW-lkp@intel.com/
    Fixes: 10a299da2c2b9 ("ring-buffer: Allow persistent ring buffers to be mmapped")
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

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

