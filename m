Return-Path: <linux-kernel+bounces-550516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10157A560A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D82A3B5336
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B409919CC05;
	Fri,  7 Mar 2025 06:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ORH6dbqI"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5BB1A239A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 06:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741327946; cv=none; b=b/O9MnTJw8nYQ5JBI50KY8T2jgwlfb8GMtiXNxQFi1RcU63NvudzO5zR+O5itMZcVYLrDwLQ6Wyzr5e1AHIEAShfFq0tz6slazR3qSkC2YxIIzTSuijG53n+5V7HIm2PYz62AsnvtMEUn8SvobzxBcbFzsTOvop+SCoRuWVi4ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741327946; c=relaxed/simple;
	bh=xO8ZI9a0KZOG1OBVqu6pteabFCxnjmcR2BLrYKbuEV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o1PdLpDkUzS+VyLEHALrH2Z9H2LF7T0H/1IeKXrJdRmp9qmay9NgFQQbHgdFPOP97JJIb4yIlxXxHO4ccFAhxsfXrbAZpdlWSpQck0i6P4XEq3KFs5JSeqn6Vjr4EsEMsZCVFgwt/hW9bIFwt8uArGxuOIFJ5iGQtFqT+NG3gXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ORH6dbqI; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741327941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bioy24DUV/2OG8cBBKOG2c94GvtSiwsNOhqhjVfSmEE=;
	b=ORH6dbqIDicSzrn6+UeGXamopLDg39lSxzptTnJsQxJfiA5kMm/NUWgDnTfvnkiZYFlV3X
	OjKt7+L+UKAy02k4mInJ51JsEF1SbPtUzSlJz4J8CnjasSqIimvBy5yQrcIkG2ZBrfewRG
	On2m9r5QHhVQcMAPHCsAlrJijF/xS8w=
From: sunliming@linux.dev
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kees@kernel.org,
	ebiederm@xmission.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	sunliming@kylinos.cn,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] fs: binfmt_elf_efpic: fix variable set but not used warning
Date: Fri,  7 Mar 2025 14:11:28 +0800
Message-Id: <20250307061128.2999222-1-sunliming@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: sunliming <sunliming@kylinos.cn>

Fix below kernel warning:
fs/binfmt_elf_fdpic.c:1024:52: warning: variable 'excess1' set but not
used [-Wunused-but-set-variable]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 fs/binfmt_elf_fdpic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index e3cf2801cd64..bed13ee8bfec 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1024,8 +1024,11 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
 	/* deal with each load segment separately */
 	phdr = params->phdrs;
 	for (loop = 0; loop < params->hdr.e_phnum; loop++, phdr++) {
-		unsigned long maddr, disp, excess, excess1;
+		unsigned long maddr, disp, excess;
 		int prot = 0, flags;
+#ifdef CONFIG_MMU
+		unsigned long excess1;
+#endif
 
 		if (phdr->p_type != PT_LOAD)
 			continue;
@@ -1120,9 +1123,9 @@ static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
 		 *   extant in the file
 		 */
 		excess = phdr->p_memsz - phdr->p_filesz;
-		excess1 = PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
 
 #ifdef CONFIG_MMU
+		excess1 = PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
 		if (excess > excess1) {
 			unsigned long xaddr = maddr + phdr->p_filesz + excess1;
 			unsigned long xmaddr;
-- 
2.25.1


