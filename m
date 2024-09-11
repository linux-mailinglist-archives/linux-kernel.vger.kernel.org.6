Return-Path: <linux-kernel+bounces-325525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75689975ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E79F285DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D906F1BA291;
	Wed, 11 Sep 2024 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS3ZVO0C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B8A1AAE1C;
	Wed, 11 Sep 2024 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726082420; cv=none; b=DCWCkCjAIEZ96F80wn/Uzerl3p+S1AAhmgIUlNrsNw4DADgMH0N1G7eSfkT/iQHF6OknKLC3j1c8Gg/EWeqx3K/gSePx6l09c49T9iw4249sdDSXTUjVJWQGkiljGQN54FzAW8+OBzUCDPVeF8XtTH0UgyHR5nOerpQMYmXo5yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726082420; c=relaxed/simple;
	bh=q607gZ7bOXAshnrnxWeCn9nyXjUqdJHM08X3Sq7cS80=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k+KZ3vhEiKjFDTl7EDxjFcZgv8tQ7I8f8oX+ai3uxscMCq2ydWI3tHbd98RLuXY2MOjlue2fYBC3/GJCPrAwgKkmjNU7U15FuUtogvYjvSGih5NjWG4aVrbtuMjutUNfv3mrL1bZO63AA3/yHRaNUj10gPcLgBjIlni4Ipuir2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS3ZVO0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590F4C4CEC0;
	Wed, 11 Sep 2024 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726082419;
	bh=q607gZ7bOXAshnrnxWeCn9nyXjUqdJHM08X3Sq7cS80=;
	h=Date:From:To:Cc:Subject:From;
	b=bS3ZVO0CiuxGRQoi9DLloyk/wC9ZLzvW/ysi9fA1TBYlCLMeGUlGpEprzWAauaSi4
	 /q3zRqXdMBTgUXrSxR8IxXMNnLaIE60V/CQX/dR2gNaHs8KoOADowfYiaRzFmjaRJk
	 G67oLBcLVtdMiWS2mmjfqGppyFwiKAfLqc103pBrMmmCipWtlQbs/voZjBiQl2hVgb
	 rJT2pKgG6j/+GADO/UJSlRkzLhTcJmO5cwziPbDfrQEaSGNIkp5UwqLvyeNbAuX0dX
	 KGlaSYDq2O4a3T6V6dZJK50oJE53tPoCQcS768i0Wb1Q8wdUgPqIbVjCraiwDBvTeT
	 y26TN2UBCFkkw==
Date: Wed, 11 Sep 2024 21:20:15 +0200
From: Helge Deller <deller@kernel.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: linux-parisc@vger.kernel.org
Subject: [PATCH] [RFC] mm: mmap: Allow mmap(MAP_STACK) to map growable stack
Message-ID: <ZuHtb43Ar21ZptNz@p100>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is a RFC to change the behaviour of mmap(MAP_STACK) to be
sufficient to map memory for usage as stack on all architectures.
Currently MAP_STACK is a no-op on Linux, and instead MAP_GROWSDOWN
has to be used.
To clarify, here is the relevant info from the mmap() man page:

MAP_GROWSDOWN
   This flag is used for stacks. It indicates to the kernel virtual
   memory system that the mapping should extend downward in memory.  The
   return address is one page lower than the memory area that is
   actually created in the process's virtual address space.  Touching an
   address in the "guard" page below the mapping will cause the mapping
   to grow by a page. This growth can be repeated until the mapping
   grows to within a page of the high end of the next lower mapping,
   at which point touching the "guard" page will result in a SIGSEGV
   signal.

MAP_STACK (since Linux 2.6.27)
   Allocate the mapping at an address suitable for a process or thread
   stack.

   This flag is currently a no-op on Linux. However, by employing this
   flag, applications can ensure that they transparently obtain support
   if the flag is implemented in the future. Thus, it is used in the
   glibc threading implementation to allow for the fact that
   some architectures may (later) require special treatment for
   stack allocations. A further reason to employ this flag is
   portability: MAP_STACK exists (and has an effect) on some
   other systems (e.g., some of the BSDs).

The reason to suggest this change is, that on the parisc architecture the
stack grows upwards. As such, using solely the MAP_GROWSDOWN flag will not
work. Note that there exists no MAP_GROWSUP flag.
By changing the behaviour of MAP_STACK to mark the memory area with the
VM_STACK bit (which is VM_GROWSUP or VM_GROWSDOWN depending on the
architecture) the MAP_STACK flag does exactly what people would expect on
all platforms.

This change should have no negative side-effect, as all code which
used mmap(MAP_GROWSDOWN | MAP_STACK) still work as before.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/include/linux/mman.h b/include/linux/mman.h
index bcb201ab7a41..66bc72a0cb19 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -156,6 +156,7 @@ calc_vm_flag_bits(unsigned long flags)
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
 	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
+	       _calc_vm_trans(flags, MAP_STACK,      VM_STACK     ) |
 	       _calc_vm_trans(flags, MAP_STACK,	     VM_NOHUGEPAGE) |
 	       arch_calc_vm_flag_bits(flags);
 }

