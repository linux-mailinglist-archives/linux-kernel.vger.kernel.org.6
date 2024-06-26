Return-Path: <linux-kernel+bounces-231378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3116991973E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91D21F22712
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCBF19149C;
	Wed, 26 Jun 2024 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsPx/t1e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D9E14EC65
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719429119; cv=none; b=cSSZ2aykz8tLp9QNSGEOExe+yI0sF06fwfBBCk1cyqnOnYNyNPI5WnjFYwtM/XDCOlQMJQ2H9XWw1QRWzQVDUQRahxG2ASklfdhJs+yQbutIaXJTuh0LH4Ds0TDbUtoRyHDNKOjjKSmqlIBtKJHYG4PLKjAo/K0Qw5OzFTxEhec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719429119; c=relaxed/simple;
	bh=infxX9gwZoaSPP26U3aYq9eo5iGTSPeUUGG/CJFrJgA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dB+QyRvHqpBcNs526iepYCXDkVnT5IlGyNmOiL8u3i85j8ddXWR3xsgLgt7eirkOO7sW/ae1sMSO7u2jV7BH96eWq5lWro4aotOULIJXrUO+fvD5zIwA3cfysKaenQueAqzldXqZllAzFZfb4J79fV72eFgBxRFW8ZRFj0vHzYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsPx/t1e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719429116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=sqJKJWGFYdhtdKrF6F8t2nbjWvOkwK6q5ywXhWfleu0=;
	b=BsPx/t1ekD1c7SdmVE4xLboznNd/k1jfnTk6FTb2MzLx6sVijdrGbU7u7m/r4vZBM3gL/y
	9hh8Bo5qZABWvI+OXCAFhCxgXMH7UUNGs+w/B4JiSIX5TlgiKnriw6n24hUpdUvUgIFIBl
	Bia1hYn49EWqAWG39LgOFYtTNkJZzO8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-rn07ZSo3O0eH1RIvSIxZXQ-1; Wed,
 26 Jun 2024 15:11:54 -0400
X-MC-Unique: rn07ZSo3O0eH1RIvSIxZXQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A655A19560B0;
	Wed, 26 Jun 2024 19:11:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.94])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C6D1E1956050;
	Wed, 26 Jun 2024 19:11:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 26 Jun 2024 21:10:20 +0200 (CEST)
Date: Wed, 26 Jun 2024 21:10:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] get_task_mm: check PF_KTHREAD lockless
Message-ID: <20240626191017.GA20031@redhat.com>
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

Nowadays PF_KTHREAD is sticky and it was never protected by ->alloc_lock.
Move the PF_KTHREAD check outside of task_lock() section to make this code
more understandable.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/fork.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 4c361d2bdc12..d3dc623a1247 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1536,14 +1536,13 @@ struct mm_struct *get_task_mm(struct task_struct *task)
 {
 	struct mm_struct *mm;
 
+	if (task->flags & PF_KTHREAD)
+		return NULL;
+
 	task_lock(task);
 	mm = task->mm;
-	if (mm) {
-		if (task->flags & PF_KTHREAD)
-			mm = NULL;
-		else
-			mmget(mm);
-	}
+	if (mm)
+		mmget(mm);
 	task_unlock(task);
 	return mm;
 }
-- 
2.25.1.362.g51ebf55



