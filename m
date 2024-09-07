Return-Path: <linux-kernel+bounces-319887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E92D97036D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 19:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9231C2146E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 17:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BB8161319;
	Sat,  7 Sep 2024 17:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxTU3HZJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660E717571;
	Sat,  7 Sep 2024 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725731602; cv=none; b=IIu3VEQCoY7dgmeLLMQdUtb820UGHi+msIQlCPIgiZ3YxQNFdyFvqO6oA5G0PUr9pxQWbifIqC4IDjr5iHE4YJNhOq0CSve2/ckOHXqSO6WWOJolvQAqVMx2emJXC6knTqW4HB6EKcZDqz+r0lMHvUcWExRw3b7oXM+Y4e/wRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725731602; c=relaxed/simple;
	bh=xc49QaUyEGz04dknKL94FaZoL15AuSjqWvoXA7HwTZE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dSvbZ5j6/QzxIN9jMmwJdF6I6kX0XDQ9Cmwopd/y+TuDHz9kKUq/ODznDVIJNWGTwZ+NzGDXMSv3a9fIhM8Fn5uVuhBnAtsRQ0oJya1c8lKgcGILJbB8aRCJOJGeLTKcixD/nq36DoGFEG9sX88ar2KOlk0G4njilxjAXdvScmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxTU3HZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43A0C4CEC2;
	Sat,  7 Sep 2024 17:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725731602;
	bh=xc49QaUyEGz04dknKL94FaZoL15AuSjqWvoXA7HwTZE=;
	h=Date:From:To:Subject:From;
	b=lxTU3HZJ0LZOWhdCqtWNRpnBZxtD3I3Dlus+jymMk2ltnvQvWOix2qZUmmCWypxWL
	 pFvrHVdCw22D41mdtqH+2TnxZWU0jyF+kPFfYByOU9QQemAUqDzzaMBZuEvE4pTjan
	 w+xE+qbw9H/ATGWcVNoOGvSA3QpOVrsdcnKbnVVpRqs4516UccLLZMZsWe0CKOSU7Q
	 P9Y6AWae4UZP0Wgt3BISmG4H+8IeOGNbCL0ww3SFz6L3fosVh1LXQEU6XYR7mR0SF4
	 IbWNiFS0TDVarcJGkrZIfpSsXmDg55yCKJdkyGKarWhPbr3RgrnXri8WmcMo/ORrUI
	 cQTGLjKjkkExQ==
Date: Sat, 7 Sep 2024 19:53:18 +0200
From: Helge Deller <deller@kernel.org>
To: linux-parisc@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Camm Maguire <camm@maguirefamily.org>
Subject: [PATCH] exec: parisc: Fix stack start for ADDR_NO_RANDOMIZE
 personality
Message-ID: <ZtyTDtcYhsqB-lrn@p100>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix the stack start address calculation for the parisc architecture in
setup_arg_pages() when address randomization is disabled. When the
ADDR_NO_RANDOMIZE process personality is disabled there is no need to add
additional space for the stack.
Note that this patch touches code inside an #ifdef CONFIG_STACK_GROWSUP hunk,
which is why only the parisc architecture is affected since it's the
only Linux architecture where the stack grows upwards.

Without this patch you will find the stack in the middle of some
mapped libaries and suddenly limited to 6MB instead of 8MB:

root@parisc:~# setarch -R /bin/bash -c "cat /proc/self/maps"
00010000-00019000 r-xp 00000000 08:05 1182034           /usr/bin/cat
00019000-0001a000 rwxp 00009000 08:05 1182034           /usr/bin/cat
0001a000-0003b000 rwxp 00000000 00:00 0                 [heap]
f90c4000-f9283000 r-xp 00000000 08:05 1573004           /usr/lib/hppa-linux-gnu/libc.so.6
f9283000-f9285000 r--p 001bf000 08:05 1573004           /usr/lib/hppa-linux-gnu/libc.so.6
f9285000-f928a000 rwxp 001c1000 08:05 1573004           /usr/lib/hppa-linux-gnu/libc.so.6
f928a000-f9294000 rwxp 00000000 00:00 0
f9301000-f9323000 rwxp 00000000 00:00 0                 [stack]
f98b4000-f98e4000 r-xp 00000000 08:05 1572869           /usr/lib/hppa-linux-gnu/ld.so.1
f98e4000-f98e5000 r--p 00030000 08:05 1572869           /usr/lib/hppa-linux-gnu/ld.so.1
f98e5000-f98e9000 rwxp 00031000 08:05 1572869           /usr/lib/hppa-linux-gnu/ld.so.1
f9ad8000-f9b00000 rw-p 00000000 00:00 0
f9b00000-f9b01000 r-xp 00000000 00:00 0                 [vdso]

With the patch the stack gets correctly mapped at the end
of the process memory map:

root@panama:~# setarch -R /bin/bash -c "cat /proc/self/maps"
00010000-00019000 r-xp 00000000 08:13 16385582          /usr/bin/cat
00019000-0001a000 rwxp 00009000 08:13 16385582          /usr/bin/cat
0001a000-0003b000 rwxp 00000000 00:00 0                 [heap]
fef29000-ff0eb000 r-xp 00000000 08:13 16122400          /usr/lib/hppa-linux-gnu/libc.so.6
ff0eb000-ff0ed000 r--p 001c2000 08:13 16122400          /usr/lib/hppa-linux-gnu/libc.so.6
ff0ed000-ff0f2000 rwxp 001c4000 08:13 16122400          /usr/lib/hppa-linux-gnu/libc.so.6
ff0f2000-ff0fc000 rwxp 00000000 00:00 0
ff4b4000-ff4e4000 r-xp 00000000 08:13 16121913          /usr/lib/hppa-linux-gnu/ld.so.1
ff4e4000-ff4e6000 r--p 00030000 08:13 16121913          /usr/lib/hppa-linux-gnu/ld.so.1
ff4e6000-ff4ea000 rwxp 00032000 08:13 16121913          /usr/lib/hppa-linux-gnu/ld.so.1
ff6d7000-ff6ff000 rw-p 00000000 00:00 0
ff6ff000-ff700000 r-xp 00000000 00:00 0                 [vdso]
ff700000-ff722000 rwxp 00000000 00:00 0                 [stack]

Reported-by: Camm Maguire <camm@maguirefamily.org>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/fs/exec.c b/fs/exec.c
index 0c5f06d08c35..e5805108e940 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -782,7 +782,8 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	stack_base = calc_max_stack_size(stack_base);
 
 	/* Add space for stack randomization. */
-	stack_base += (STACK_RND_MASK << PAGE_SHIFT);
+	if (current->flags & PF_RANDOMIZE)
+		stack_base += (STACK_RND_MASK << PAGE_SHIFT);
 
 	/* Make sure we didn't let the argument array grow too large. */
 	if (vma->vm_end - vma->vm_start > stack_base)

