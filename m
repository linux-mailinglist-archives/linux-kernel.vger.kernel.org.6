Return-Path: <linux-kernel+bounces-271354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 192CF944D2A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE91528B394
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8711A4F35;
	Thu,  1 Aug 2024 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVk/aIFu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216221A3BD7
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518874; cv=none; b=k2Jv6YQL7dJigMjTFRTCgQth8KvM7ew/og7/wGMF1o++9g06zpXaVW4Ca17FY1b81vNfmV52fYO8XRBL838W5fAt5m9KHagGYnSX7fxHzAHiwxiSh7nh+FoElgdQzgINcUtqn85YiEgMM62SNmNA548AIApSfO/80wixhYtGATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518874; c=relaxed/simple;
	bh=jEEZP+Pk2H225A3SW76266+ap+IrdA7Op1pwDuBfNKE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Hw2yHnArntdQ5CpRcH0zCnsDnb6whMCYyMc6nzPnrQWHLcFnWWZx4aGOyW3p+OvSeiRPojjbgAy7hDr060kYjpABDAFidzhI3Cf5h1PuGqP9AunLfwxMSngHvqE1aM/ZD1WIYws67SV4aAXKcH3OXGcyUjHlqRsxxtJlWGf15Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVk/aIFu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722518872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=OXmgynbq1bkVhUcMMchL2Y521eQlQHyLkiICBIwyHIo=;
	b=gVk/aIFuC41QrDmnXtTwD/YqJC2lvZtpo9APxBD6fOm2Zxk7vlefU6LjQZEkrsZRJCek1j
	J3OPWKbTYgkBTSbofMMMlIqc+FE6hDnv2lTj2T6OC7Mh06nwM5VmP/eAxT36IEmpnhu7s8
	2rsMQKjS3YGLibXd/UL7cu/WT4zZnEc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-JsGZ0owOMoSqqYKNoYBWcQ-1; Thu,
 01 Aug 2024 09:27:51 -0400
X-MC-Unique: JsGZ0owOMoSqqYKNoYBWcQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43E681955D59;
	Thu,  1 Aug 2024 13:27:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1A2E819560AA;
	Thu,  1 Aug 2024 13:27:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 15:27:48 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:27:44 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 8/9] uprobes: fold __uprobe_unregister() into
 uprobe_unregister()
Message-ID: <20240801132744.GA8814@redhat.com>
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

Fold __uprobe_unregister() into its single caller, uprobe_unregister().
A separate patch to simplify the next change.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
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


