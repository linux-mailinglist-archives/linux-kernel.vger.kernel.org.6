Return-Path: <linux-kernel+bounces-349840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 581FE98FC16
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 04:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E93283689
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B665210EE;
	Fri,  4 Oct 2024 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkKwrb2k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582CF1CAAF
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728007196; cv=none; b=lK/9rlzHDSUXwEguFaPayOrhd5EDrlyHAxcWdtfzbi485VJ0peO/EHBtXrtVXwJMg+z5TF0a+Mu4xY+k4rpgjKaYDQrQ+JwE3+vucrmAKHCUS0k5B8TBGeTc/ClAeTrgPCdeCmKAWt9NbDepbd4H6a0aFkQV3tb75vRJx+Wpdq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728007196; c=relaxed/simple;
	bh=zrQT/I2PK5lAcMS9tlIOjHCcoibHU9rgFnqoXsDWCX0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g21uvgXmDR/FM7nOwn1EteggtD5cIb6TxfZLmPPQnBmYAmBJ9Rd8hVaRsNvo4cQ7fP8O2GKqOuEH1r8U3O+7xgdG9JjUFjBbrULaaoxj8wv2R0lpixgaQ4OIzA+velMK21Y9s6P0BgX+2grIpZXMSbDRpX3QhOf5je62rsWHhGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FkKwrb2k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728007194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qQE2RJORatJZ4HbSL1fxpt77UC2FjfgZSgKiByM6mc=;
	b=FkKwrb2knDABJnxWNVN/AJWMW0gC28Cv6PiCNHTeGoyVAQ1FnFYQqtDn4tox5yB5tamzwe
	0EoPlEkNF9duReUoUwTGru42/1hsGMjZPuVvE7Jkl1XB22TtUkJENam9hpTg/bnnOEXhq6
	bzHm20rq+qRM4Wlb/yp7SBux5b2mDiQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-NvTDSUtvPEOnbRzjKMyEXw-1; Thu,
 03 Oct 2024 21:59:51 -0400
X-MC-Unique: NvTDSUtvPEOnbRzjKMyEXw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCF0519560AB;
	Fri,  4 Oct 2024 01:59:49 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 15DF319560A3;
	Fri,  4 Oct 2024 01:59:45 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/7] vhost: Add a new modparam to allow userspace select vhost_task
Date: Fri,  4 Oct 2024 09:58:15 +0800
Message-ID: <20241004015937.2286459-2-lulu@redhat.com>
In-Reply-To: <20241004015937.2286459-1-lulu@redhat.com>
References: <20241004015937.2286459-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The vhost is now using vhost_task and working as a child of the owner thread.
While this makes sense from containerization POV, some old userspace is
confused, as previously vhost not and so was allowed to steal cpu resources
from outside the container. So we add the kthread API support back

Add a new module parameter to allow userspace to select behaviour
between using kthread and task

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 9ac25d08f473..a4a0bc34f59b 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -41,6 +41,10 @@ static int max_iotlb_entries = 2048;
 module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
 	"Maximum number of iotlb entries. (default: 2048)");
+bool enforce_inherit_owner = true;
+module_param(enforce_inherit_owner, bool, 0444);
+MODULE_PARM_DESC(enforce_inherit_owner,
+		 "enforce vhost use vhost_task(default: Y)");
 
 enum {
 	VHOST_MEMORY_F_LOG = 0x1,
-- 
2.45.0


