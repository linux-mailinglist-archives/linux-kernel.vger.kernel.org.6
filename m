Return-Path: <linux-kernel+bounces-565175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4E8A6625E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10BCC16B078
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8031B204F75;
	Mon, 17 Mar 2025 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9TKZT5h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800D376
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742252683; cv=none; b=l4AGYma3JJAYGgtRa8F7h52yD3u/4Bq5mJKw5CqOha/AOHMXMcrPC1OEyTdb18DaJW1isFhI7JGP2nhRtFCLykTRdNDqBx8aoFuDjonqrpNPRBJqJza2ipV5UcdiQV9cn2KHrmLCsO02uyAq7DKeDXDz6zDpWHmNcpgo4AjVces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742252683; c=relaxed/simple;
	bh=Yy70oMWOZQMwd3RKb7kqvh4omvBAkjSXrQ+l1ZlMjnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R26fbuN9IaIhHQG51F2BsylxrbUG7gkJBEMaw5YB6YHvvyfSNv5fCKpIh7Z/wUgKttfj4SCeIV7u5e9+J1vPrzImdbw0Tl9LgmTPDA/eKru4R9xuoKZGbRm0zoZEPR1TUxhFeCGrv+LMtddGkf9JOeO/u4nbzGy9qvGYe8tg5y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9TKZT5h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742252680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AHO8/RMWauQedkj7l6Avu6Pc03g5Wf/i1/CgriQQ/qQ=;
	b=Q9TKZT5hWVX6Kp/EqdIv7n7sXJZi0eymoY62rbO0l/5nJHAM1KZ6H1eT+qFsx/s0UfzG3l
	azQkrKAwrLzimavzBDsGR5wIUzXT1MgyJDoqZ23kv0BFJaH+CaCj7Ua8xPB3Tqorm6Q7nU
	o6mIDbjDDO0BrO+XUfMwiIiLwZrEKng=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-h-QEZmJNMPqDOO63agHSmw-1; Mon,
 17 Mar 2025 19:04:39 -0400
X-MC-Unique: h-QEZmJNMPqDOO63agHSmw-1
X-Mimecast-MFC-AGG-ID: h-QEZmJNMPqDOO63agHSmw_1742252677
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6D941955DCF;
	Mon, 17 Mar 2025 23:04:36 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.116])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE1961955BE4;
	Mon, 17 Mar 2025 23:04:32 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kirill.shutemov@linux.intel.com
Cc: corbet@lwn.net,
	akpm@linux-foundation.org,
	surenb@google.com,
	pasha.tatashin@soleen.com,
	catalin.marinas@arm.com,
	david@redhat.com,
	jeffxu@chromium.org,
	andrii@kernel.org,
	xu.xin16@zte.com.cn
Subject: [PATCH] Documentation: Add "Unaccepted" meminfo entry
Date: Mon, 17 Mar 2025 17:04:03 -0600
Message-ID: <20250317230403.79632-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Commit dcdfdd40fa82 ("mm: Add support for unaccepted memory") added a
entry to meminfo but did not document it in the proc.rst file.

This counter tracks the amount of "Unaccepted" guest memory for some
Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP.

Add the missing entry in the documentation.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 Documentation/filesystems/proc.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 09f0aed5a08b..8fcf19c31b18 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1060,6 +1060,7 @@ Example output. You may not have all of these fields.
     FilePmdMapped:         0 kB
     CmaTotal:              0 kB
     CmaFree:               0 kB
+    Unaccepted:            0 kB
     HugePages_Total:       0
     HugePages_Free:        0
     HugePages_Rsvd:        0
@@ -1228,6 +1229,8 @@ CmaTotal
               Memory reserved for the Contiguous Memory Allocator (CMA)
 CmaFree
               Free remaining memory in the CMA reserves
+Unaccepted
+              Memory that has not been accepted by the guest
 HugePages_Total, HugePages_Free, HugePages_Rsvd, HugePages_Surp, Hugepagesize, Hugetlb
               See Documentation/admin-guide/mm/hugetlbpage.rst.
 DirectMap4k, DirectMap2M, DirectMap1G
-- 
2.48.1


