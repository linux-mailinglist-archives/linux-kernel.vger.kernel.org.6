Return-Path: <linux-kernel+bounces-271345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EFD944D20
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B403BB20E62
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A08A1A257B;
	Thu,  1 Aug 2024 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="To0JB6xw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351541946C7
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518812; cv=none; b=byyXUQPLE8a/WO1l+CIrn+4MTHfCkjWLo64y3rX7u1ZSt8onUyaSQ0eL3eyUaLzvuo/zL42qUxR+4DBd2biZCTuKeQPhh3NqXp81K+VfU0qkYq5mII4IJogTO2jremjW7e0963Or0/wSGcMyB5aoExag3Amj8fRhWJ34qtZGltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518812; c=relaxed/simple;
	bh=hWsYFooRQcoP2Bz07kAvGISR9ZLpTUwI4zwlWdXj3iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ykw3qpUL/k/xVLmmjlGPPHWa35YU3rzx9jlv+xIAr4jfN0foAbjjhP0tpNLnXpw7JvdXmVIDTc5kil2Zt6wpobjiq9zyPC+Acz/q2OMnsC0AP/RrZA/ntTQl+yFMKvYDty4F10QmeiDCexvtTbkzWCjhvejCzYyLmj/G7kmCRXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=To0JB6xw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722518810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=yfCti4AmwEcsX6LuFMa3GXv/+hDYeVMmSmtqgkUuKSQ=;
	b=To0JB6xwkLGj7fhZ8j5lzG+K8qbxXRgY5ZqT9JjYVDYTATtAqy1Q1uXiHRUdFcJY8RraKP
	248T7ZzR3iaTtVt7RJgLotp2EdQET+C9n9CO6b8aMGlZ6TgFrzImWt6eiDz1FqdZZEAtWK
	BbD+lqI22J7BMn2ALSSNS8FzUjpMv80=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-gaOQMd0MPGei-zTuwwtcBg-1; Thu,
 01 Aug 2024 09:26:45 -0400
X-MC-Unique: gaOQMd0MPGei-zTuwwtcBg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 659BD1955D61;
	Thu,  1 Aug 2024 13:26:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5BAC519560AE;
	Thu,  1 Aug 2024 13:26:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 15:26:43 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:26:38 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org
Cc: jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 0/9] uprobes: misc cleanups/simplifications
Message-ID: <20240801132638.GA8759@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

(Andrii, I'll try to look at your new series on Weekend).

Changes:

	- added the acks I got from Andrii, Masami, and Jiri
	- new 4/9 patch from Jiri, fixes the unrelated bug in bpf_testmod
	- adapt tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
	  to the API changes in 5/9 an 6/9

see the interdiff below.

Oleg.
---

 include/linux/uprobes.h                            |  22 ++--
 kernel/events/uprobes.c                            | 137 +++++++++------------
 kernel/trace/bpf_trace.c                           |  25 ++--
 kernel/trace/trace_uprobe.c                        |  31 ++---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c        |  26 ++--
 5 files changed, 103 insertions(+), 138 deletions(-)

-------------------------------------------------------------------------------

--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -432,7 +432,7 @@ uprobe_ret_handler(struct uprobe_consumer *self, unsigned long func,
 
 struct testmod_uprobe {
 	struct path path;
-	loff_t offset;
+	struct uprobe *uprobe;
 	struct uprobe_consumer consumer;
 };
 
@@ -446,25 +446,25 @@ static int testmod_register_uprobe(loff_t offset)
 {
 	int err = -EBUSY;
 
-	if (uprobe.offset)
+	if (uprobe.uprobe)
 		return -EBUSY;
 
 	mutex_lock(&testmod_uprobe_mutex);
 
-	if (uprobe.offset)
+	if (uprobe.uprobe)
 		goto out;
 
 	err = kern_path("/proc/self/exe", LOOKUP_FOLLOW, &uprobe.path);
 	if (err)
 		goto out;
 
-	err = uprobe_register_refctr(d_real_inode(uprobe.path.dentry),
-				     offset, 0, &uprobe.consumer);
-	if (err)
+	uprobe.uprobe = uprobe_register(d_real_inode(uprobe.path.dentry),
+					offset, 0, &uprobe.consumer);
+	if (IS_ERR(uprobe.uprobe)) {
+		err = PTR_ERR(uprobe.uprobe);
 		path_put(&uprobe.path);
-	else
-		uprobe.offset = offset;
-
+		uprobe.uprobe = NULL;
+	}
 out:
 	mutex_unlock(&testmod_uprobe_mutex);
 	return err;
@@ -474,10 +474,10 @@ static void testmod_unregister_uprobe(void)
 {
 	mutex_lock(&testmod_uprobe_mutex);
 
-	if (uprobe.offset) {
-		uprobe_unregister(d_real_inode(uprobe.path.dentry),
-				  uprobe.offset, &uprobe.consumer);
-		uprobe.offset = 0;
+	if (uprobe.uprobe) {
+		uprobe_unregister(uprobe.uprobe, &uprobe.consumer);
+		path_put(&uprobe.path);
+		uprobe.uprobe = NULL;
 	}
 
 	mutex_unlock(&testmod_uprobe_mutex);


