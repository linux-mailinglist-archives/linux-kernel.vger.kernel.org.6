Return-Path: <linux-kernel+bounces-271353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A40B5944D29
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50A91C22541
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387E61A4B55;
	Thu,  1 Aug 2024 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWw6Y44b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D7C1A3BC5
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518869; cv=none; b=g5qi3p/UlZkKcdeyar59NZBJe3Ue71nMU98YkxFW046ydNUPwxvXar47r+pNvsohXR2U8TGOWSZMDkSCI81Q9y2g3bxNUsIHfzrDm4yy399ZjpaMfEyhAMixaQZ1Q3f2Bjsn3kj7cUgJ8v0F1XQOugtwKkAz4MLk8BDT1d8/dzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518869; c=relaxed/simple;
	bh=NGq5dJqZqr9q6RfJulMmTHykMNw7OZbPAkupwQdmR7s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZdCafbUH0923vQ2zA++GZcUSZhCdKT51bUQ+kATYiPxF7XrslpNgcrm3gIGw0Tw34CIi+5zSRJtsTgtNLZhHPHsxV0oe5ZxUxnpwoq2e/EutTyGaWdpE5X6LTFYzEUipVICs8R2hZUal0EOxQ+AhQs4zDhTI09ov7wQQhqGwUzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWw6Y44b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722518867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=E2USmONA9SizueAzOm+WwqtIfPfv9XdZg06/upvE0eM=;
	b=SWw6Y44bD3ijPha5r89QZicQ3phHA3ChNA8yehZAwEthMujNx81Di1Eqf/NRhOIFpJSzUy
	Ab2BxnxnZeEguCLQDZvnclVEmFKAOqcJ179q+lA9nX6wegpSRTG3PXJ64wnusQx4xJ0JqL
	Wd9uGL1ZE/BM4G85/cesI9jjzG7ftf0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-BT19dpVENnaIs4xJAOLMaw-1; Thu,
 01 Aug 2024 09:27:45 -0400
X-MC-Unique: BT19dpVENnaIs4xJAOLMaw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 301731955D56;
	Thu,  1 Aug 2024 13:27:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 478FD19560AA;
	Thu,  1 Aug 2024 13:27:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 15:27:43 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:27:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 7/9] uprobes: change uprobe_register() to use
 uprobe_unregister() instead of __uprobe_unregister()
Message-ID: <20240801132739.GA8809@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

If register_for_each_vma() fails uprobe_register() can safely drop
uprobe->register_rwsem and use uprobe_unregister(). There is no worry
about the races with another register/unregister, consumer_add() was
already called so this case doesn't differ from _unregister() right
after the successful _register().

Yes this means the extra up_write() + down_write(), but this is the
slow and unlikely case anyway.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/uprobes.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 974474680820..5ea0aabe8774 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1174,16 +1174,18 @@ struct uprobe *uprobe_register(struct inode *inode,
 	if (likely(uprobe_is_active(uprobe))) {
 		consumer_add(uprobe, uc);
 		ret = register_for_each_vma(uprobe, uc);
-		if (ret)
-			__uprobe_unregister(uprobe, uc);
 	}
 	up_write(&uprobe->register_rwsem);
 	put_uprobe(uprobe);
 
-	if (unlikely(ret == -EAGAIN))
-		goto retry;
+	if (ret) {
+		if (unlikely(ret == -EAGAIN))
+			goto retry;
+		uprobe_unregister(uprobe, uc);
+		return ERR_PTR(ret);
+	}
 
-	return ret ? ERR_PTR(ret) : uprobe;
+	return uprobe;
 }
 EXPORT_SYMBOL_GPL(uprobe_register);
 
-- 
2.25.1.362.g51ebf55


