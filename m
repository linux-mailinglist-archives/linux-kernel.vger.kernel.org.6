Return-Path: <linux-kernel+bounces-558454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C74E5A5E62A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B5117E46E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006F31F463E;
	Wed, 12 Mar 2025 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m2YcEtLs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="if+Pa02u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m2YcEtLs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="if+Pa02u"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BDE1F417E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741813206; cv=none; b=lnTazAthS8Q5Yg5a7t/e3IGAZBf2wMQOsjdDuJrbW4lGzxzPruioD44QT77lG0EnGREjT10HhM5rmwp8U5wVciMvIAQ2LykdCOfXPxTljxs0npDU1kbR/0V4xYl/NbuUs+p9C2FzckGvCW1y2F14uvUWvuAy+R9o0uEHr8+C0t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741813206; c=relaxed/simple;
	bh=Mmj3Yqp6CyMxwfEiNXYWP68P9pJAFK4ZUM/RQJ3aniU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rSBJ84P8UtzCW9ByTvhDTKy9GblDLAf4TD/jfal0S4dSdDTwb9IikLdA3VrsGAZOvyaniCHsrCykaVe6ruOElBM/fMULqowv30ZrrZGt4/DBAor/RwGax8ivSlYUQ9eL6B5t507BJY4iq0n5kiQ8dGScc9NDhKeA1FoiikN/fE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m2YcEtLs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=if+Pa02u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m2YcEtLs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=if+Pa02u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id 7A51A2118B;
	Wed, 12 Mar 2025 21:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741813202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=EKRGBWsyZi1wiUOiswHXSRL8V+SVETl/0JBDCl1+UN8=;
	b=m2YcEtLsU2vwXNV4FhAUDIfdZ0rMIiYUM9fY+0HG8+b/3QhL7ZxsAopQYA3bRH/xp6m2fe
	ugC4g7Iz05c4+E/slzCalJmGTcsBHh2wJonLNtMuJDECmco9EKwQxb/XWzHdN3jTx3OJgQ
	yO2ZFQGktK3ybTf7wMOy2rKzHS5gYCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741813202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=EKRGBWsyZi1wiUOiswHXSRL8V+SVETl/0JBDCl1+UN8=;
	b=if+Pa02u/ZkmWQCDKTXynTtEhigXIfPM3j959XOl2EJ0yk3C5qoEyenotfpcmqm4AYGVk/
	bhqa5yX3oNcN+bAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741813202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=EKRGBWsyZi1wiUOiswHXSRL8V+SVETl/0JBDCl1+UN8=;
	b=m2YcEtLsU2vwXNV4FhAUDIfdZ0rMIiYUM9fY+0HG8+b/3QhL7ZxsAopQYA3bRH/xp6m2fe
	ugC4g7Iz05c4+E/slzCalJmGTcsBHh2wJonLNtMuJDECmco9EKwQxb/XWzHdN3jTx3OJgQ
	yO2ZFQGktK3ybTf7wMOy2rKzHS5gYCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741813202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=EKRGBWsyZi1wiUOiswHXSRL8V+SVETl/0JBDCl1+UN8=;
	b=if+Pa02u/ZkmWQCDKTXynTtEhigXIfPM3j959XOl2EJ0yk3C5qoEyenotfpcmqm4AYGVk/
	bhqa5yX3oNcN+bAw==
Date: Wed, 12 Mar 2025 22:00:02 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: [PATCH v3 0/5] kdump: crashkernel reservation from CMA
Message-ID: <Z9H10pYIFLBHNKpr@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.977];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:helo,suse.cz:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi,

this series implements a way to reserve additional crash kernel
memory using CMA.

Link to the v1 discussion:
https://lore.kernel.org/lkml/ZWD_fAPqEWkFlEkM@dwarf.suse.cz/
See below for the changes since v1 and how concerns from the 
discussion have been addressed.

Currently, all the memory for the crash kernel is not usable by
the 1st (production) kernel. It is also unmapped so that it can't
be corrupted by the fault that will eventually trigger the crash.
This makes sense for the memory actually used by the kexec-loaded
crash kernel image and initrd and the data prepared during the
load (vmcoreinfo, ...). However, the reserved space needs to be
much larger than that to provide enough run-time memory for the
crash kernel and the kdump userspace. Estimating the amount of
memory to reserve is difficult. Being too careful makes kdump
likely to end in OOM, being too generous takes even more memory
from the production system. Also, the reservation only allows
reserving a single contiguous block (or two with the "low"
suffix). I've seen systems where this fails because the physical
memory is fragmented.

By reserving additional crashkernel memory from CMA, the main
crashkernel reservation can be just large enough to fit the
kernel and initrd image, minimizing the memory taken away from
the production system. Most of the run-time memory for the crash
kernel will be memory previously available to userspace in the
production system. As this memory is no longer wasted, the
reservation can be done with a generous margin, making kdump more
reliable. Kernel memory that we need to preserve for dumping is
normally not allocated from CMA, unless it is explicitly
allocated as movable. Currently this is only the case for memory
ballooning and zswap. Such movable memory will be missing from
the vmcore. User data is typically not dumped by makedumpfile.
When dumping of user data is intended this new CMA reservation
cannot be used.

There are five patches in this series:

The first adds a new ",cma" suffix to the recenly introduced generic
crashkernel parsing code. parse_crashkernel() takes one more
argument to store the cma reservation size.

The second patch implements reserve_crashkernel_cma() which
performs the reservation. If the requested size is not available
in a single range, multiple smaller ranges will be reserved.

The third patch updates Documentation/, explicitly mentioning the
potential DMA corruption of the CMA-reserved memory.

The fourth patch adds a short delay before booting the kdump
kernel, allowing pending DMA transfers to finish.

The fifth patch enables the functionality for x86 as a proof of
concept. There are just three things every arch needs to do:
- call reserve_crashkernel_cma()
- include the CMA-reserved ranges in the physical memory map
- exclude the CMA-reserved ranges from the memory available
  through /proc/vmcore by excluding them from the vmcoreinfo
  PT_LOAD ranges.

Adding other architectures is easy and I can do that as soon as
this series is merged.

With this series applied, specifying
	crashkernel=100M craskhernel=1G,cma
on the command line will make a standard crashkernel reservation
of 100M, where kexec will load the kernel and initrd.

An additional 1G will be reserved from CMA, still usable by the
production system. The crash kernel will have 1.1G memory
available. The 100M can be reliably predicted based on the size
of the kernel and initrd.

The new cma suffix is completely optional. When no
crashkernel=size,cma is specified, everything works as before.

---
Changes since v2:

based on feedback from Baoquan He and David Hildenbrand:
- kept original formatting of suffix_tbl[]
- updated documentation to mention movable pages missing from vmcore
- fixed whitespace in documentation
- moved the call crash_cma_clear_pending_dma() after
  machine_crash_shutdown() so that non-crash CPUs and timers are
  shut down before the delay

---
Changes since v1:

The key concern raised in the v1 discussion was that pages in the
CMA region may be pinned and used for a DMA transfer, potentially
corrupting the new kernel's memory. When the cma suffix is used, kdump
may be less reliable and the corruption hard to debug

This v2 series addresses this concern in two ways:

1) Clearly stating the potential problem in the updated
Documentation and setting the expectation (patch 3/5)

Documentation now explicitly states that:
- the risk of kdump failure is increased
- the CMA reservation is intended for users who can not or don't
  want to sacrifice enough memory for a standard crashkernel reservation
  and who prefer less reliable kdump to no kdump at all

This is consistent with the documentation of the
crash_kexec_post_notifiers option, which can also increase the
risk of kdump failure, yet may be the only way to use kdump on
some systems. And just like the crash_kexec_post_notifiers
option, the cma crashkernel suffix is completely optional:
the series has zero effect when the suffix is not used.

2) Giving DMA time to finish before booting the kdump kernel
   (patch 4/5)

Pages can be pinned for long term use using the FOLL_LONGTERM
flag. Then they are migrated outside the CMA region. Pinning
without this flag shows that the intent of their user is to only
use them for short-lived DMA transfers. 

Delay the boot of the kdump kernel when the CMA reservation is
used, giving potential pending DMA transfers time to finish.

Other minor changes since v1:
- updated for 6.14-rc2
- moved #ifdefs and #defines to header files
- added __always_unused in parse_crashkernel() to silence a false
  unused variable warning
 

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


