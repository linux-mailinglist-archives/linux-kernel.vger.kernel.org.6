Return-Path: <linux-kernel+bounces-229853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BE6917530
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F14C1B21F07
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93266441F;
	Wed, 26 Jun 2024 00:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6iqPDsD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3F015C0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719361019; cv=none; b=OMY0aL0ku8Qw/6oesFH/Hy/s5xC9eNMkr5UMNbR7Nmzg5i6zJWBIZKjn62Fm2qKq+eZysFVpSogyQ96cjajLfcWMhBhHUiQbPAWW7j7WJywPyEmV6czcBa/DyTppXUmYz2W31E3g6Pzg1nzFvq451ruX5OFgNjvLDn5k/6DzuYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719361019; c=relaxed/simple;
	bh=ZgdySlI6yCFoybjZygFc7ygwQwV4JIsqn7odc3kRDYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KFSOp28QdIdq0VFPEPfQAp3ZVKjmHz1JICNZjL1aoaXshgcdUAmbm0QR/z0eqpx8qWxLK/oKTwvJ8F2fx3su2z86kyXQE4wab/2m0GtH9Es0tW4aiDZ3SSkyVS7Thl9hom4W6UeDCI8eif+WWBKDWmKp/EBlSZbK5FTywmJw+xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6iqPDsD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719361017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zdU+rDDqlIgpLxiqowKiFIoMTlc4uejP8unMxUUC8sQ=;
	b=M6iqPDsDqkM3LPwISHiy/HG1eEnupkRBqff8ojKWPvhZmBYIucxBPY2Ts3xEO2J8HcncYs
	xsOCw98IGSUrMyfhV2lq7bFrjSR8dI5SMkfYWQFs9TBDLV2QgBFBQ4ojgujDeKrza/tQ1l
	LKyxhHtsi0ScM+gaflUidWMC8fS9jtE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-MBZNVlmGOCyCMcXoEicPAQ-1; Tue,
 25 Jun 2024 20:16:55 -0400
X-MC-Unique: MBZNVlmGOCyCMcXoEicPAQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30284195609E;
	Wed, 26 Jun 2024 00:16:54 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.23])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F3C71956087;
	Wed, 26 Jun 2024 00:16:52 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Charan Teja Kalla <quic_charante@quicinc.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] mm: Prevent derefencing NULL ptr in pfn_section_valid()
Date: Tue, 25 Jun 2024 20:16:39 -0400
Message-Id: <20240626001639.1350646-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Commit 5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing
memory_section->usage") changed pfn_section_valid() to add a READ_ONCE()
call around "ms->usage" to fix a race with section_deactivate() where
ms->usage can be cleared.  The READ_ONCE() call, by itself, is not enough
to prevent NULL pointer dereference.  We need to check its value before
dereferencing it.

Fixes: 5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing memory_section->usage")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/mmzone.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8f9c9590a42c..b1dcf6ddb406 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1980,8 +1980,9 @@ static inline int subsection_map_index(unsigned long pfn)
 static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
 {
 	int idx = subsection_map_index(pfn);
+	struct mem_section_usage *usage = READ_ONCE(ms->usage);
 
-	return test_bit(idx, READ_ONCE(ms->usage)->subsection_map);
+	return usage ? test_bit(idx, usage->subsection_map) : 0;
 }
 #else
 static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
-- 
2.39.3


