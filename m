Return-Path: <linux-kernel+bounces-345450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1783F98B677
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A071C22047
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26AA1BE241;
	Tue,  1 Oct 2024 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="YqjUyA9a"
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B481BDAB9
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769690; cv=none; b=dlq0dgPD17q8TkU5x595LTIBMnwJpltHdHHzeQt1h87zLEx6xJZf+pfm8oWH3on1uSyHVWo4lIrlEydWckEAqGujClrQLCkDGPxSPHjUVjflTwhuuSMIpENqqR98h89/q7fWyr9KLVIvKzwmbAAMGQBbbFT3Nn3GYMmysLYlKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769690; c=relaxed/simple;
	bh=GFzaJ0MFbRasXMqqqJaB4ZF+n+30c3MYiBHLlyHvfdg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r3zGdXuit2cCzSr2QES6DtmXscom42ua9KzVPLOysH8iMMiDa6sPSnhJDOcekdSVzgjeZe8pIPKL2VE/x1HZvjpv1q4Y/AU1nkprRP0WWtlhMDNC+6YV6Mgf2ZZhI/fkCz8DuKd8HfmG7plfcLp1DYGYNkXSuAtDwmYEfzBu2gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=YqjUyA9a; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1727769688; x=1759305688;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L/Ba4CuddkD+e4fPw52EHuHMwtFDq8hBWqlmCnVy1ak=;
  b=YqjUyA9a3IZ6Lnc13dyNdfsMTJMbDyPJH/aHDS4LiOK2EUPbgIaQ/GLy
   vp6h+ICeSzQzooh9QjmMuqWFgtei7JUUITVXOxVinXDOcQAR8QzdGV69+
   jzCMsos/BK5pSjOUYtmUt8VKBNDqE4twApaWvCauDMrSgmsD4+kFHTJrV
   U=;
X-IronPort-AV: E=Sophos;i="6.11,167,1725321600"; 
   d="scan'208";a="133361570"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 08:01:19 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:1795]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.46.202:2525] with esmtp (Farcaster)
 id dd6681b8-edac-4771-9971-99d358a89959; Tue, 1 Oct 2024 08:01:18 +0000 (UTC)
X-Farcaster-Flow-ID: dd6681b8-edac-4771-9971-99d358a89959
Received: from EX19D015EUB003.ant.amazon.com (10.252.51.113) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 08:01:18 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D015EUB003.ant.amazon.com (10.252.51.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 08:01:17 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Tue, 1 Oct 2024 08:01:17 +0000
Received: from ua2d7e1a6107c5b.home (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com (Postfix) with ESMTPS id 65B5880165;
	Tue,  1 Oct 2024 08:01:15 +0000 (UTC)
From: Patrick Roy <roypat@amazon.co.uk>
To: <rppt@kernel.org>, <akpm@linux-foundation.org>
CC: Patrick Roy <roypat@amazon.co.uk>, <david@redhat.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <graf@amazon.com>,
	<jgowans@amazon.com>
Subject: [PATCH] secretmem: disable memfd_secret() if arch cannot set direct map
Date: Tue, 1 Oct 2024 09:00:41 +0100
Message-ID: <20241001080056.784735-1-roypat@amazon.co.uk>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Return -ENOSYS from memfd_secret() syscall if !can_set_direct_map().
This is the case for example on some arm64 configurations, where marking
4k PTEs in the direct map not present can only be done if the direct map
is set up at 4k granularity in the first place (as ARM's
break-before-make semantics do not easily allow breaking apart
large/gigantic pages).

More precisely, on arm64 systems with !can_set_direct_map(),
set_direct_map_invalid_noflush() is a no-op, however it returns success
(0) instead of an error. This means that memfd_secret will seemingly
"work" (e.g. syscall succeeds, you can mmap the fd and fault in pages),
but it does not actually achieve its goal of removing its memory from
the direct map.

Note that with this patch, memfd_secret() will start erroring on systems
where can_set_direct_map() returns false (arm64 with
CONFIG_RODATA_FULL_DEFAULT_ENABLED=n, CONFIG_DEBUG_PAGEALLOC=n and
CONFIG_KFENCE=n), but that still seems better than the current silent
failure. Since CONFIG_RODATA_FULL_DEFAULT_ENABLED defaults to 'y', most
arm64 systems actually have a working memfd_secret() and aren't be
affected.

From going through the iterations of the original memfd_secret patch
series, it seems that disabling the syscall in these scenarios was the
intended behavior [1] (preferred over having
set_direct_map_invalid_noflush return an error as that would result in
SIGBUSes at page-fault time), however the check for it got dropped
between v16 [2] and v17 [3], when secretmem moved away from CMA
allocations.

[1]: https://lore.kernel.org/lkml/20201124164930.GK8537@kernel.org/
[2]: https://lore.kernel.org/lkml/20210121122723.3446-11-rppt@kernel.org/#t
[3]: https://lore.kernel.org/lkml/20201125092208.12544-10-rppt@kernel.org/

Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
---
 mm/secretmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 3afb5ad701e14..399552814fd0f 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -238,7 +238,7 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 	/* make sure local flags do not confict with global fcntl.h */
 	BUILD_BUG_ON(SECRETMEM_FLAGS_MASK & O_CLOEXEC);
 
-	if (!secretmem_enable)
+	if (!secretmem_enable || !can_set_direct_map())
 		return -ENOSYS;
 
 	if (flags & ~(SECRETMEM_FLAGS_MASK | O_CLOEXEC))
@@ -280,7 +280,7 @@ static struct file_system_type secretmem_fs = {
 
 static int __init secretmem_init(void)
 {
-	if (!secretmem_enable)
+	if (!secretmem_enable || !can_set_direct_map())
 		return 0;
 
 	secretmem_mnt = kern_mount(&secretmem_fs);

base-commit: abf2050f51fdca0fd146388f83cddd95a57a008d
-- 
2.46.2


