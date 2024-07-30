Return-Path: <linux-kernel+bounces-267483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D1D9411FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C418B23DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2711A00F1;
	Tue, 30 Jul 2024 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIXEPxGp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7633B1A00E8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342909; cv=none; b=BscgSsyXCRNmgN4eeZhhoOlUFUzspvtWLC+5LBbNWTKvQ1PvrZpPGoKT61p3SH9pS5CUvvvUUD4jkpRCpoVuZfHCtJHYlrKxBAGepmPneZuLqlDUioxMfMfaMeePqb0co3wEu5KTPPP236AFJK9Dr0mwvmjaYEiqQ/v3cNg9j5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342909; c=relaxed/simple;
	bh=/PCbAvWmRtPIzmNX9OnXe40hTDSZWtCJ0mGNTRGIJnI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RCetzNo48z2NJolcn8+hnErPVcbqah3q25g8/fF7dk1z+2jGEEjmGWjXa051Nclsbwrv53E9MEGB3Iq2Wcq+9/xAM/GydV/pmLbwcV5Fc4F22al/7Z4H43Ivfs3T67lF0dMD50Nz6F74+E1cHIKl7IJ+B+H4AVthztgpSOe88y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIXEPxGp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722342906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=834ISJOXXbFjU55uIUoKOdwIp7ruo2OPQB7D9lPIwf4=;
	b=UIXEPxGp3MsNYmMGfBSbYIUeCr/lrRxVa8svmUoAjafpv6myPiKhN4ioT4ETU1zGIWUCkB
	llpmoLW2w2IyVLwl9KdFX6A6gcsbyjh74xvnmzPGDla9T9UpIDpr64kVYSxzeuuqPEIHGH
	lUEro5mr34lc5/Ck5nUqiuPp5ILxotQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-_PSnSOoJPJW3AJtrPJmjQQ-1; Tue,
 30 Jul 2024 08:35:03 -0400
X-MC-Unique: _PSnSOoJPJW3AJtrPJmjQQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BD3E1955D50;
	Tue, 30 Jul 2024 12:35:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.179])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C5868300018D;
	Tue, 30 Jul 2024 12:34:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 30 Jul 2024 14:35:01 +0200 (CEST)
Date: Tue, 30 Jul 2024 14:34:57 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/3] uprobes: shift put_uprobe() from delete_uprobe() to
 uprobe_unregister()
Message-ID: <20240730123457.GA9108@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730123421.GA9085@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Kill the extra get_uprobe() + put_uprobe() in uprobe_unregister() and
move the possibly final put_uprobe() from delete_uprobe() to its only
caller, uprobe_unregister().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index c06e1a5f1783..f88b7ff20587 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -939,7 +939,6 @@ static void delete_uprobe(struct uprobe *uprobe)
 	rb_erase(&uprobe->rb_node, &uprobes_tree);
 	write_unlock(&uprobes_treelock);
 	RB_CLEAR_NODE(&uprobe->rb_node); /* for uprobe_is_active() */
-	put_uprobe(uprobe);
 }
 
 struct map_info {
@@ -1094,7 +1093,6 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
 	int err;
 
-	get_uprobe(uprobe);
 	down_write(&uprobe->register_rwsem);
 	if (WARN_ON(!consumer_del(uprobe, uc)))
 		err = -ENOENT;
@@ -1102,10 +1100,16 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 		err = register_for_each_vma(uprobe, NULL);
 
 	/* TODO : cant unregister? schedule a worker thread */
-	if (!err && !uprobe->consumers)
-		delete_uprobe(uprobe);
+	if (!err) {
+		if (!uprobe->consumers)
+			delete_uprobe(uprobe);
+		else
+			err = -EBUSY;
+	}
 	up_write(&uprobe->register_rwsem);
-	put_uprobe(uprobe);
+
+	if (!err)
+		put_uprobe(uprobe);
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister);
 
-- 
2.25.1.362.g51ebf55


