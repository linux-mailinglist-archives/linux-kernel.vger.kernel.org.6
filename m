Return-Path: <linux-kernel+bounces-346119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CEF98BFD7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2121F263D5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5098F1C6F48;
	Tue,  1 Oct 2024 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQIc2GGB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F07319D06E
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792734; cv=none; b=EfZ9rLSLmFqYQ/66DYXuGyLnvpWIIPiHWzOmNE6NBXK4OJSsj9uFl0EKueSAeb9fdHRR9yp8Tv2Xwr1GAxYLSD/1DOsczT26244J6cHGhCX1SX4Z6UaoAX0K5+BKGmMaovb25C9nQvr+S+Mo3Sxwg7xttVnABD8JehwMKUIJUwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792734; c=relaxed/simple;
	bh=kB/vCOQVk1IMdjsq58HX7OYOPky84hE7fvfuCRDEbaE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c9zUfTyyFJMcDwD98RbQ6AmH8tcGXPgJRvoRZfltv+4C8dS9IzwxxAL7vJuQjfuJkzQHUmrZJiSGZGyPuSVeDdJoOq0TvLNkZqsSrr93sdI6JacvDui0PyVBwbEiSy0yzwLqhxwdvFQxERrrEYivGFR3cU2pe/8fs1YHAO650q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQIc2GGB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727792732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=CAhIXQw4AKu0nqECcGYlfSjZV7z+K8tHHRI3flDnkjE=;
	b=KQIc2GGBRprM2B+2VfPKuvlhlMUUoOHvkeY5cl7w7oI7wnCh0msCcUgmaPyxYSAzOSRcQb
	HTW6+iRHRpuh6PS/rPELk16CaXMz2/2dH2/6ymXt8tLp+HqCWlHd2/F3bKfOoUncj7KkNu
	ul04jRvPm55xCkaEz+yvdKfDm58ocEE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-3yGILTEaMIiaAB3D8evZpg-1; Tue,
 01 Oct 2024 10:25:26 -0400
X-MC-Unique: 3yGILTEaMIiaAB3D8evZpg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF7CA18D9F11;
	Tue,  1 Oct 2024 14:25:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.88])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 861EA301228D;
	Tue,  1 Oct 2024 14:25:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  1 Oct 2024 16:25:07 +0200 (CEST)
Date: Tue, 1 Oct 2024 16:25:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Liao Chang <liaochang1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/2] uprobes: fold xol_take_insn_slot() into
 xol_get_insn_slot()
Message-ID: <20241001142503.GA13633@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001142416.GA13599@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

After the previous change xol_take_insn_slot() becomes trivial, kill it.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 38d91e10d455..40ecab0971ff 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1643,29 +1643,20 @@ static unsigned long xol_get_slot_nr(struct xol_area *area)
 	return UINSNS_PER_PAGE;
 }
 
-/*
- *  - search for a free slot.
- */
-static unsigned long xol_take_insn_slot(struct xol_area *area)
-{
-	unsigned long slot_nr;
-
-	wait_event(area->wq, (slot_nr = xol_get_slot_nr(area)) < UINSNS_PER_PAGE);
-
-	return area->vaddr + slot_nr * UPROBE_XOL_SLOT_BYTES;
-}
-
 /*
  * xol_get_insn_slot - allocate a slot for xol.
  */
 static bool xol_get_insn_slot(struct uprobe *uprobe, struct uprobe_task *utask)
 {
 	struct xol_area *area = get_xol_area();
+	unsigned long slot_nr;
 
 	if (!area)
 		return false;
 
-	utask->xol_vaddr = xol_take_insn_slot(area);
+	wait_event(area->wq, (slot_nr = xol_get_slot_nr(area)) < UINSNS_PER_PAGE);
+
+	utask->xol_vaddr = area->vaddr + slot_nr * UPROBE_XOL_SLOT_BYTES;
 	arch_uprobe_copy_ixol(area->page, utask->xol_vaddr,
 			      &uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
 	return true;
-- 
2.25.1.362.g51ebf55


