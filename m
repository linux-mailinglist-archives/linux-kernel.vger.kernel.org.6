Return-Path: <linux-kernel+bounces-267482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D33F19411FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621BA1F24418
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC2A19FA86;
	Tue, 30 Jul 2024 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgpWvZ3B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CE61A00D4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342905; cv=none; b=T7JzDF6GuFodDgox34OeTDi8DNRzeL0gnqmfExArcER+u9HjMcetBpJY4J+hZhJlkMCMWvGI1ZsJEjnzdyngXwi8B/YUyQfamcHB8EbBE45mGwbY4mhqWendD/Bf0tUrBvXSJUN4j1PUUPBEnSb4gpeGrTI8dFtjnaDPqllyqQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342905; c=relaxed/simple;
	bh=eTPlETMFSzawnE7+nWGynmK/voAnwa4EzyxfwYwnCLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jFNLkvlkyVFLNleeiJ5RCCUISm1Tbubx8psLyPAepFoq6p4k2vrhqykuZTZXALlvskNtZv8rJS7ZbZyMFALMT8+GqK+GHS+vShfvmGpSLCYToJ0yWXy0ArBJUK69jyd4KmKEdl5f86m0S9Us0NaIYkmgMEiDN5szc/5gml/QRTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WgpWvZ3B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722342902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=m2S9pMY0lLQ0FyIYgioWcdjQraPadw78t9CcL3DCq40=;
	b=WgpWvZ3BV2wcS2rKVm6y/JEQD5glQglQn8w81dCk2dF5PULEy/OZVrpTy5Patl549Cx4vz
	MpkeFnSuKcdVdaAELcYbnc23rvyJiDIW//19vnm3HMln2KvHlU/QqNdo1OJ9QyaQlRU/k1
	rYYgHGxcLVZYmMrv0CDL/tRIoUspQB0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-u0b2-BC2MyCsNt1Av35Xhg-1; Tue,
 30 Jul 2024 08:35:00 -0400
X-MC-Unique: u0b2-BC2MyCsNt1Av35Xhg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E87091955F2F;
	Tue, 30 Jul 2024 12:34:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.179])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 30C3119560AE;
	Tue, 30 Jul 2024 12:34:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 30 Jul 2024 14:34:56 +0200 (CEST)
Date: Tue, 30 Jul 2024 14:34:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/3] uprobes: fold __uprobe_unregister() into
 uprobe_unregister()
Message-ID: <20240730123452.GA9102@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Fold __uprobe_unregister() into its single caller, uprobe_unregister().
A separate patch to simplify the next change.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/events/uprobes.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 5ea0aabe8774..c06e1a5f1783 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1085,20 +1085,6 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 	return err;
 }
 
-static void
-__uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
-{
-	int err;
-
-	if (WARN_ON(!consumer_del(uprobe, uc)))
-		return;
-
-	err = register_for_each_vma(uprobe, NULL);
-	/* TODO : cant unregister? schedule a worker thread */
-	if (!uprobe->consumers && !err)
-		delete_uprobe(uprobe);
-}
-
 /**
  * uprobe_unregister - unregister an already registered probe.
  * @uprobe: uprobe to remove
@@ -1106,9 +1092,18 @@ __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
  */
 void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
 {
+	int err;
+
 	get_uprobe(uprobe);
 	down_write(&uprobe->register_rwsem);
-	__uprobe_unregister(uprobe, uc);
+	if (WARN_ON(!consumer_del(uprobe, uc)))
+		err = -ENOENT;
+	else
+		err = register_for_each_vma(uprobe, NULL);
+
+	/* TODO : cant unregister? schedule a worker thread */
+	if (!err && !uprobe->consumers)
+		delete_uprobe(uprobe);
 	up_write(&uprobe->register_rwsem);
 	put_uprobe(uprobe);
 }
-- 
2.25.1.362.g51ebf55


