Return-Path: <linux-kernel+bounces-340763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BBA98778C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77391C21FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AF3158DCC;
	Thu, 26 Sep 2024 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPwru2er"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6C3522A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368168; cv=none; b=QQ67BNWL9pwRqOI5mULNE8VQi+rZwG1PSRf9ZgLgYeh4dSuaVr3KJ6F2Ao12EMw8hOW6BZprImalpm8ba9GCqEcfcXgZbgVGAuLkXJ99ApN0ebR2K+Hfrc6rYX57NKyW+ae7VidIEhYMonQsOGKwwxAorYLzTj6r7e5XkN/Qg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368168; c=relaxed/simple;
	bh=qHqpC9iuCHCJRUqsEuFXoNDgUucLxcwhn5pVQapAinY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I5gmKt4ufHbrI2iRv23pgU2Mkgf6PvqGMM1MSsjQSCipdCOjohZqiWMIDHMTQP55c3kV/kRO5jFrfREsE1z4tcIxbGt3kTap68ddYzOjz7V31PqkKnDbXoZH89p1P+gDhlLnfGaqiBFc1baJWv+yNaHL+uO2dw0Ck0zXVcB5dVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPwru2er; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727368166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=U/7NVh83GSAxVyoir3z75bzhp+4poRgUCR8AetV5Gz8=;
	b=cPwru2er+P/t7a9qerjs/ChdB0MNH34kiGyvycRsoMC9/IsZHy+J4NQuAAEHMPV0HTuYhL
	wMQ72u6nXEhcwJHJCQDn+tuTQUcHoHkqSIAZ/CGoNmL8geuHyq4KbgKo4VhOmDp3nEXFux
	2hofM75F4rgBMC9d7mKIOaTImEbni9M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-N4LRuNZ7MWOQLfnGKR9QFQ-1; Thu,
 26 Sep 2024 12:29:20 -0400
X-MC-Unique: N4LRuNZ7MWOQLfnGKR9QFQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD13C1936CF3;
	Thu, 26 Sep 2024 16:29:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.133])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EABFA1955DC7;
	Thu, 26 Sep 2024 16:29:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 26 Sep 2024 18:29:05 +0200 (CEST)
Date: Thu, 26 Sep 2024 18:29:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	"Liao, Chang" <liaochang1@huawei.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] uprobes: fix kernel info leak via "[uprobes]" vma
Message-ID: <20240926162901.GA9716@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

xol_add_vma() maps the uninitialized page allocated by __create_xol_area()
into userspace. On some architectures (x86) this memory is readable even
without VM_READ, VM_EXEC results in the same pgprot_t as VM_EXEC|VM_READ.

Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2ec796e2f055..4b52cb2ae6d6 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1545,7 +1545,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	if (!area->bitmap)
 		goto free_area;
 
-	area->page = alloc_page(GFP_HIGHUSER);
+	area->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
 	if (!area->page)
 		goto free_bitmap;
 
-- 
2.25.1.362.g51ebf55



