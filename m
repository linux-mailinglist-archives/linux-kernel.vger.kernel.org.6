Return-Path: <linux-kernel+bounces-377351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 961499ABDAB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A76EB21BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B214613D276;
	Wed, 23 Oct 2024 05:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bny3iGHi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bny3iGHi"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC07482
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729660284; cv=none; b=IWTFmGjWI8KNrmiW2ozNWvTx9x4EUtyxC+lsbc9kFY72if2vcCTym8bLXdsjrjf2DNAg7fVEL80MfO4ZuNIjuyuDyN2sMJzn+HGdPbpJiVkdkgesBoZplZ1oAT2szImY27k6WAYbQnuouoqWFSyvkd2fYs/yySa4IROGteyvfWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729660284; c=relaxed/simple;
	bh=bxIHS03U07sbCMqlR1B6ijgxGx2rqOtj2IbPj5zNa6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WFyKage6saIa1g81mtlA5n9Kmv6rvAdyhU1KflqfoOWaqPkCH4+jGwNicYPfRuSFSaGJtsTpYVLg/xPHC7N1E5y59g4wKm7oipk+Q2tJrbKSzc5myVZuZiCl/3l7DJ8SSzGDjR5/IkLhzvbr524JEPD1tUjpmAoBpt5PoCCCBYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bny3iGHi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bny3iGHi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2972E1F84A;
	Wed, 23 Oct 2024 05:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729660280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LqlMyDU+3Diae63/JK3Q8T8le5eZ81nm+LXzBbtI4wY=;
	b=bny3iGHiFW8OGtuS3vCgBdxKoUaGRN0unVi/T9Ee3JVIQE9gyjqvDfy5Ium7yZ9NGNasK/
	Yd09KX1A3TS9yPfaLfj3a23fcPirO9tJ8SFxbPv8rJv8fn5nedXIiOYvA+p3Jc7eNnr61O
	4iroGYUBNlnQDhl1EUyeuqPTEFSrm3I=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bny3iGHi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729660280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LqlMyDU+3Diae63/JK3Q8T8le5eZ81nm+LXzBbtI4wY=;
	b=bny3iGHiFW8OGtuS3vCgBdxKoUaGRN0unVi/T9Ee3JVIQE9gyjqvDfy5Ium7yZ9NGNasK/
	Yd09KX1A3TS9yPfaLfj3a23fcPirO9tJ8SFxbPv8rJv8fn5nedXIiOYvA+p3Jc7eNnr61O
	4iroGYUBNlnQDhl1EUyeuqPTEFSrm3I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCC8713A63;
	Wed, 23 Oct 2024 05:11:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jFxaM3eFGGdyXQAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Wed, 23 Oct 2024 05:11:19 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: gregkh@linuxfoundation.org
Cc: rafael@kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] cacheinfo: Don't opencode per_cpu_cacheinfo()
Date: Wed, 23 Oct 2024 08:11:18 +0300
Message-Id: <20241023051118.888065-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2972E1F84A
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

That file contains a local helper that returns ->info_list, just use it.
No functional changes.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 drivers/base/cacheinfo.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 7a7609298e18..5344df24fd09 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -367,9 +367,7 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 
 		cpumask_set_cpu(cpu, &this_leaf->shared_cpu_map);
 		for_each_online_cpu(i) {
-			struct cpu_cacheinfo *sib_cpu_ci = get_cpu_cacheinfo(i);
-
-			if (i == cpu || !sib_cpu_ci->info_list)
+			if (i == cpu || !per_cpu_cacheinfo(i))
 				continue;/* skip if itself or no cacheinfo */
 			for (sib_index = 0; sib_index < cache_leaves(i); sib_index++) {
 				sib_leaf = per_cpu_cacheinfo_idx(i, sib_index);
@@ -409,10 +407,7 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 	for (index = 0; index < cache_leaves(cpu); index++) {
 		this_leaf = per_cpu_cacheinfo_idx(cpu, index);
 		for_each_cpu(sibling, &this_leaf->shared_cpu_map) {
-			struct cpu_cacheinfo *sib_cpu_ci =
-						get_cpu_cacheinfo(sibling);
-
-			if (sibling == cpu || !sib_cpu_ci->info_list)
+			if (sibling == cpu || !per_cpu_cacheinfo(sibling))
 				continue;/* skip if itself or no cacheinfo */
 
 			for (sib_index = 0; sib_index < cache_leaves(sibling); sib_index++) {
-- 
2.34.1


