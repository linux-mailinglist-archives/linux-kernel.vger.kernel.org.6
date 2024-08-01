Return-Path: <linux-kernel+bounces-271355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32474944D2B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D881C22480
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1D21A57D1;
	Thu,  1 Aug 2024 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jwwcc207"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42F41A57CE
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518879; cv=none; b=uQitmPKq6O76VxixnJnMMvknLuGlNtj7wNsQx24tJr4c7+GDpM66s7lv4p3YtuALh0IS0YdYPlPZbT+7BeV14FiDkBMUc+p9vjM46/s19Y/68aQ5V6aVoVk4y9daZRO1JwQzLlwdy+Q0I7BbT5A7V7gIf0+OuTbzKOp0HviSpJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518879; c=relaxed/simple;
	bh=3mptqJqBUcpOt3OBU92I5V+BMLBESmQwmLrel09LDdc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R7wUbhalOmVOvIYZgw+khoxCsi5f3KhqEgOy6sNlUI8pPcn+MsswQiK8njFTA0jah45tdfnQrmLq2JAUQBmNoR+TJh8Nqt5O+6Yu2fKUHGA11arTZnnRwMENZ5IHyEfxF+Nnif4vfI8BqoWrL2nJGiG6b7VMQ2GbtzeO9MVKxK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jwwcc207; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722518876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=aKS1JV/k2FXROHkTQCa9V8ezijNkEnvTPKAJbOfwO5M=;
	b=Jwwcc207f8Hr1Mlq0vjh1gnAvlaoKQtF0JGOrmz31dS1ZxF+QsEbgmlxAKuupzDft5CIfO
	OlYsRbPmSZhWhpMpdeV1uwe1yY6dtJ2p9IaPqrjNOYNniVk3rxUcAtFP8QMWFzDeVsjXYf
	hQijxVnclBxH/tcxLCyaS6p+GFJRxhY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-qOR-ioryMWm5rZoCL8BFVg-1; Thu,
 01 Aug 2024 09:27:55 -0400
X-MC-Unique: qOR-ioryMWm5rZoCL8BFVg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D041E1955BF4;
	Thu,  1 Aug 2024 13:27:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E06C41955D42;
	Thu,  1 Aug 2024 13:27:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 15:27:53 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:27:49 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 9/9] uprobes: shift put_uprobe() from delete_uprobe() to
 uprobe_unregister()
Message-ID: <20240801132749.GA8817@redhat.com>
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

Kill the extra get_uprobe() + put_uprobe() in uprobe_unregister() and
move the possibly final put_uprobe() from delete_uprobe() to its only
caller, uprobe_unregister().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
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


