Return-Path: <linux-kernel+bounces-550749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468BFA563A1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87F23B4C04
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFF5209F5C;
	Fri,  7 Mar 2025 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1dwYROUq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8poSsgS5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1dwYROUq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8poSsgS5"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131B819E999
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339267; cv=none; b=kNQNLySMhvohYfSuv5vQmM0FTJrsm7ztiKItdFYTrZ/FlVmIfwbocKm3fv0vklBHBjkgJU7ykdIg1eMfjuhqhfLuN6kUaefZQiOc2Qhwr6M2om528RDuBvdUNE7Z1VISobjzZCa8QdPAVA/jAtSK9GYZdB3qzr/tzbcY96cqPSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339267; c=relaxed/simple;
	bh=4UgdeaJoN8VD95IS/kgDks7wzVslreoPHSE1jOsiMP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RxSFPzhilwQuVn9tLEInCKUxbSL3PbcF2iDWeSV2sa1wB6KrgYPdhKA9TZXlq1E2hM4EEczxwcFRFIzwNHgKpdS03BABSPZb87CYtVx/glEnj8hMh5q9APd6DE5dKy4hSamB4qjqR+L5NAvY1FwwYyYHOnC4dFQLmhani47755g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1dwYROUq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8poSsgS5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1dwYROUq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8poSsgS5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	by smtp-out1.suse.de (Postfix) with ESMTP id 2AADC21197;
	Fri,  7 Mar 2025 09:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741339262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kqxqcPqwKkwzQqSoeNGsuK4t8y7YgkAyzT+CFhOL+Xw=;
	b=1dwYROUq+tvV2eJNdDehJTD3S8Mg8iIqQHJ3ioPN3AVogznUpSCpO6ZtH+oWL066noalfX
	xg+qa+17RdjGoPBv2Pls58PMi7cK/6MQdyAFSNLRZoZ/IFL7DWvg5WSXUFX0vxTrStjWE1
	/P0J1aTftRCxUhkU7SRASBcnmS+sqHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741339262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kqxqcPqwKkwzQqSoeNGsuK4t8y7YgkAyzT+CFhOL+Xw=;
	b=8poSsgS5heeqVir9dYeGzPbKeDduyiKEb0mhfyqn3tEnpjtzE2cIw5cYlsY95p9/fWLD3D
	Wkoh/BSRAoPrgRBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741339262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kqxqcPqwKkwzQqSoeNGsuK4t8y7YgkAyzT+CFhOL+Xw=;
	b=1dwYROUq+tvV2eJNdDehJTD3S8Mg8iIqQHJ3ioPN3AVogznUpSCpO6ZtH+oWL066noalfX
	xg+qa+17RdjGoPBv2Pls58PMi7cK/6MQdyAFSNLRZoZ/IFL7DWvg5WSXUFX0vxTrStjWE1
	/P0J1aTftRCxUhkU7SRASBcnmS+sqHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741339262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kqxqcPqwKkwzQqSoeNGsuK4t8y7YgkAyzT+CFhOL+Xw=;
	b=8poSsgS5heeqVir9dYeGzPbKeDduyiKEb0mhfyqn3tEnpjtzE2cIw5cYlsY95p9/fWLD3D
	Wkoh/BSRAoPrgRBw==
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michal Suchanek <msuchanek@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/boot: Fix build with gcc 15
Date: Fri,  7 Mar 2025 10:20:52 +0100
Message-ID: <20250307092055.21986-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,kernel.org,fjasle.eu,google.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

Similar to x86 the ppc boot code does not build with GCC 15.

Copy the fix from
commit ee2ab467bddf ("x86/boot: Use '-std=gnu11' to fix build with GCC 15")

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/boot/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 1ff6ad4f6cd2..e6b35699c049 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -33,6 +33,7 @@ else
 endif
 
 ifdef CONFIG_PPC64_BOOT_WRAPPER
+BOOTTARGETFLAGS	+= -std=gnu11
 BOOTTARGETFLAGS	+= -m64
 BOOTTARGETFLAGS	+= -mabi=elfv2
 ifdef CONFIG_PPC64_ELF_ABI_V2
-- 
2.47.1


