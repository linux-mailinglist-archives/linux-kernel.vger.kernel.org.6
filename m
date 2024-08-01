Return-Path: <linux-kernel+bounces-271348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF7D944D23
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5991A1F2205B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEAF1A38D6;
	Thu,  1 Aug 2024 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGwFoka9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4679F1A0B12
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518844; cv=none; b=XA65P2UyyklUe2OgMKyG3QFD3p0lMJtzmbZSzDwyrPFnWsLpwoOb+awC3njAD96pcXHlj8Ib6g1ubZX9j+MnDSfsoddDt3rNKECsMTj5/TseTq0MgxpZdMQyCLiE4Q4k7n+AMmXnCHYPHN3UXRkDvjpZB3fji/LHcmu3bPALiOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518844; c=relaxed/simple;
	bh=gRdKbpw01kD2jrJlhNae3ccJtTGg4B0Henul+O9OUBc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XttLpA72QQZK8judIZBOCbAMuetx4kugpd3I+9PnXS3awAh6jtSTj4Pya1h2r0JZLAiJoA+l3q9mAlM9xLQFjVaWWqAlXS3uD/FWJ3/R3CAZ2SdSqs2MiCTL1oHTYN3d4+tcmTeDVnXWnt0Gn9HQQkzfl0J+lBj7u6/EMpu+pcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGwFoka9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722518842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Oi5UV/aQpk//MO+rYuzraG2kt40uedD7qdWTKYwRxwI=;
	b=UGwFoka9ZlRxhmp1CNaeMeGTAt9TilOVicN+PtSLAjeGaVYqtxyx7wS/tkDBkwap/ybBQq
	3BwKXPmgFTRjfRYuqJdUsympy8skGkapt+p4pssDtjPUj96oQRqZ/FR525pT/qSEaVgnSD
	IvLuIJVtrTcqwuTKjK3wbQHXaDODldA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336--FPS9MK4PMq82DLQ6gWUxQ-1; Thu,
 01 Aug 2024 09:27:20 -0400
X-MC-Unique: -FPS9MK4PMq82DLQ6gWUxQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FCE41955BF4;
	Thu,  1 Aug 2024 13:27:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DDF1F1955D42;
	Thu,  1 Aug 2024 13:27:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 15:27:18 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:27:14 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 2/9] uprobes: is_trap_at_addr: don't use
 get_user_pages_remote()
Message-ID: <20240801132714.GA8783@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801132638.GA8759@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

get_user_pages_remote() and the comment above it make no sense.

There is no task_struct passed into get_user_pages_remote() anymore, and
nowadays mm_account_fault() increments the current->min/maj_flt counters
regardless of FAULT_FLAG_REMOTE.

Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/uprobes.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 73dd12b09a7b..eb71428691bb 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2035,13 +2035,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	if (likely(result == 0))
 		goto out;
 
-	/*
-	 * The NULL 'tsk' here ensures that any faults that occur here
-	 * will not be accounted to the task.  'mm' *is* current->mm,
-	 * but we treat this as a 'remote' access since it is
-	 * essentially a kernel access to the memory.
-	 */
-	result = get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &page, NULL);
+	result = get_user_pages(vaddr, 1, FOLL_FORCE, &page);
 	if (result < 0)
 		return result;
 
-- 
2.25.1.362.g51ebf55


