Return-Path: <linux-kernel+bounces-558475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE29EA5E661
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A7917545D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D9C1EF38E;
	Wed, 12 Mar 2025 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eAeVEYg1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1frobXGW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qabWvGZU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lH5LOpbQ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3713E1EE014
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814295; cv=none; b=Mag+M8VSSfwJxXfRKp8hxp0TnbaLtvKjFbbdVBqg9H8KqokEjRVzX3xgFA2ZgOKC362LAtITAeptpb9iat37DAgmLqWhcc954tFG/1T8ryv4KhqrGe5JECO9V5B57w8HAQ0Ne4zhNBbTPY3FlKsuG8/GQBje2HMCU/zOYNd2vaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814295; c=relaxed/simple;
	bh=UcmN1VlV6icK88x+PsR6N8aJg7b5k3NRdyPZEKfDrXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLKwhOExZTLGBAbRGMrildeDOvbLre8VAyVD896E90sqmTjnttbTwPoeNPLAFFHnXeN1o1FS9VWmCNuBfIQxhZiIievjFU9Q8bB1IC79GKx5CKMCuRyyDt8yT2vO9O8LQWkowaCpoqTkmT5M8UrJ+VuFK5gHxYKS/Jtp99f4Lro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eAeVEYg1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1frobXGW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qabWvGZU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lH5LOpbQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id E633D21180;
	Wed, 12 Mar 2025 21:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741813781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YQbt+oFmaaNv/NMjBEdk51ik/ZthlcNfaY1dZ8X+y5Q=;
	b=eAeVEYg1oKb/jqK3mj1MD6uelnRztRT+Vzy4iqSyyYRTRlZBOFW1mQtuPua1FSBjOaJKva
	HDGYWVfNDLK0XAL9qao+hp53cVGQZbIproq/k0A4UJ6cIf9L1ojmJsr72qH1OfAj0vrNIw
	Y6r36HEhUauJUjLQP7md4Juftp5E3m0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741813781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YQbt+oFmaaNv/NMjBEdk51ik/ZthlcNfaY1dZ8X+y5Q=;
	b=1frobXGW60b8vrjJwYPkDn6pGVf+XkrPnPKFop7agS5HVdl1fAaIxgbBH4Fjvm8mMSqO35
	QqFr6XizbBstmSAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741813780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YQbt+oFmaaNv/NMjBEdk51ik/ZthlcNfaY1dZ8X+y5Q=;
	b=qabWvGZUC1x9OUycHRz36WT2uQtOBRORelgR6FwUS1uxVODB1QT1ss6bMSXVj94+3F2G9w
	rl6v94QXf4yf467sFcuh01Kykd/5B3lewjFpKOUUf7L4mqbBHfEcByM7eHic/EubPlkI5Z
	aA1pQONsL+pd7qgss9TQ6Ct1+GJY/gU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741813780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YQbt+oFmaaNv/NMjBEdk51ik/ZthlcNfaY1dZ8X+y5Q=;
	b=lH5LOpbQ5XWfsn/0nLeKkW6+/+JSqAG7hgW9fz47VXPAkcn3Qqa08Gfx4CG40fyfbfUppo
	B8Twq863Vbqz9lDA==
Date: Wed, 12 Mar 2025 22:09:39 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: [PATCH v3 3/5] kdump, documentation: describe craskernel CMA
 reservation
Message-ID: <Z9H4E82EslkGR7pV@dwarf.suse.cz>
References: <Z9H10pYIFLBHNKpr@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9H10pYIFLBHNKpr@dwarf.suse.cz>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.949];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.cz:email,dwarf.suse.cz:mid,localhost:helo];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Score: -4.29
X-Spam-Flag: NO

Describe the new crashkernel ",cma" suffix in Documentation/

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
---
 Documentation/admin-guide/kdump/kdump.rst     | 24 +++++++++++++++++--
 .../admin-guide/kernel-parameters.txt         | 22 +++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 5376890adbeb..0a7ec98c74fa 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -315,6 +314,27 @@ crashkernel syntax
 
             crashkernel=0,low
 
+4) crashkernel=size,cma
+
+	Reserve additional crash kernel memory from CMA. This reservation is
+	usable by the first system's userspace memory and kernel movable
+	allocations (memory balloon, zswap). Pages allocated from this memory
+	range will not be included in the vmcore so this should not be used if
+	dumping of userspace memory is intended and it has to be expected that
+	some movable kernel pages may be missing from the dump.
+
+	A standard crashkernel reservation, as described above, is still needed
+	to hold the crash kernel and initrd.
+
+	This option increases the risk of a kdump failure: DMA transfers
+	configured by the first kernel may end up corrupting the second
+	kernel's memory.
+
+	This reservation method is intended for systems that can't afford to
+	sacrifice enough memory for standard crashkernel reservation and where
+	less reliable and possibly incomplete kdump is preferable to no kdump at
+	all.
+
 Boot into System Kernel
 -----------------------
 1) Update the boot loader (such as grub, yaboot, or lilo) configuration
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8..895b974dc3bb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -987,6 +987,28 @@
 			0: to disable low allocation.
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
+	crashkernel=size[KMG],cma
+			[KNL, X86] Reserve additional crash kernel memory from
+			CMA. This reservation is usable by the first system's
+			userspace memory and kernel movable allocations (memory
+			balloon, zswap). Pages allocated from this memory range
+			will not be included in the vmcore so this should not
+			be used if dumping of userspace memory is intended and
+			it has to be expected that some movable kernel pages
+			may be missing from the dump.
+
+			A standard crashkernel reservation, as described above,
+			is still needed to hold the crash kernel and initrd.
+
+			This option increases the risk of a kdump failure: DMA
+			transfers configured by the first kernel may end up
+			corrupting the second kernel's memory.
+
+			This reservation method is intended for systems that
+			can't afford to sacrifice enough memory for standard
+			crashkernel reservation and where less reliable and
+			possibly incomplete kdump is preferable to no kdump at
+			all.
 
 	cryptomgr.notests
 			[KNL] Disable crypto self-tests

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


