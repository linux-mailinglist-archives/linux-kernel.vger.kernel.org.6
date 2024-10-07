Return-Path: <linux-kernel+bounces-354209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D65993994
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 23:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00E88B22B41
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9B818C32A;
	Mon,  7 Oct 2024 21:53:36 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2A074C08
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 21:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728338016; cv=none; b=Pj0RBo7vEvLhZM7wqXr4qFT0mzKF5KhYycqdf1aiysZK+1XsW7CpNnN1dlIoL8if/JJ9Dt08oxmcpTYI2NiZFZccVpdf+WjYNlquTDyWz/2j+1GGKyLA+WsxySJLEgfd4n7hrIr5osMN5FX/LLvcJTwny2L13raOpc7JcEcfxec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728338016; c=relaxed/simple;
	bh=8YMYtHzQXi6m3VkmMmnjDB1sY+5Er3nXEixu2AstuJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KwMdmbGTkwUmOiScTt0ZwegiqdaULvmgXnX/3zMssDc7xtm4uf/OymMJhE1TpGjWehM5Z0BFhpQvVatyedYkBOCWr3GbCGUTOw/gq8F4heOWByLJeEPFjv4VNlO5TCFQPqaLUQTtobswjPjhl5jOuwCnTUfQBguPi0z0gnOgPOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sxvPB-0003hN-EI; Mon, 07 Oct 2024 23:36:37 +0200
From: Florian Westphal <fw@strlen.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	Florian Westphal <fw@strlen.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Ben Greear <greearb@candelatech.com>
Subject: [PATCH lib] lib: alloc_tag_module_unload must wait for pending kfree_rcu calls
Date: Mon,  7 Oct 2024 22:52:24 +0200
Message-ID: <20241007205236.11847-1-fw@strlen.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ben Greear reports following splat:
 ------------[ cut here ]------------
 net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register_fn has 256 allocated at module unload
 WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_unload+0x22b/0x3f0
 Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat msdos fat
...
 Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
 RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
  codetag_unload_module+0x19b/0x2a0
  ? codetag_load_module+0x80/0x80

nf_nat module exit calls kfree_rcu on those addresses, but the free
operation is likely still pending by the time alloc_tag checks for leaks.

Wait for outstanding kfree_rcu operations to complete before checking
resolves this warning.

Reproducer:
unshare -n iptables-nft -t nat -A PREROUTING -p tcp
grep nf_nat /proc/allocinfo # will list 4 allocations
rmmod nft_chain_nat
rmmod nf_nat                # will WARN.

Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Reported-by: Ben Greear <greearb@candelatech.com>
Closes: https://lore.kernel.org/netdev/bdaaef9d-4364-4171-b82b-bcfc12e207eb@candelatech.com/
Fixes: a473573964e5 ("lib: code tagging module support")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 lib/codetag.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/codetag.c b/lib/codetag.c
index afa8a2d4f317..a3472d428821 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -228,6 +228,8 @@ bool codetag_unload_module(struct module *mod)
 	if (!mod)
 		return true;
 
+	kvfree_rcu_barrier();
+
 	mutex_lock(&codetag_lock);
 	list_for_each_entry(cttype, &codetag_types, link) {
 		struct codetag_module *found = NULL;
-- 
2.45.2


