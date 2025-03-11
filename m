Return-Path: <linux-kernel+bounces-555304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FD9A5B53C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 01:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13AB0173C17
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14771DE3B1;
	Tue, 11 Mar 2025 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBjvCMTP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB6F79FD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 00:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741654081; cv=none; b=jUc4BJIBNt9rK0ahG0YNg04EFfVJmmpAa2QAWp+3tSIpi16FzgmPC+LoOvoEKLlkTN0kjVDVPho2GGk/rs+B+Fy5UacA36rVM8qCJcc4P1pWjmdAwsQ47D62XPtE2zjO6I4kIPz2rX9WUyc89m985y4yWolMjXa1MMuEu8dQbfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741654081; c=relaxed/simple;
	bh=KAljwSvGX1g+l2eBUttGm0UZUh5aUyhM+EPHYMjqKvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HITA6PkfR4iWuc5uEWTgZlMIjKOY3wPcmsMgbsdhLpjUv5FjFVdNt+qBDOzfYmfcShSWMJa6SBxCz4C6IByT1CAWjHY9qum5k2CT+oZj15jlMKsvIcTbBZeXFson5Cl/jKJPoMgzuy6vnpqDjjG70h7vNm3Db1Zkdvm30HVyv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBjvCMTP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741654077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hgrxg5qAPOx7K2ONkn1MCXNcggxF5k+2r/MNYL/OtKg=;
	b=jBjvCMTPIHxrur7h8NvCAjTB7oogy8vHiWG5etwvodDenkF6by7yauvfUHV2Z5Nn86QGaW
	Ruh6GttvYEjn3SNZbG/DdiEIEfI0EFSSzVbdfwzqanFffQ1w06hF+cMAdrmUL07r/QxZn1
	ALdrkncqqUTQgSSnfY+ohQ6LNM4vokM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-eQAVUnAIOIizaZ8uLe3bPw-1; Mon,
 10 Mar 2025 20:47:56 -0400
X-MC-Unique: eQAVUnAIOIizaZ8uLe3bPw-1
X-Mimecast-MFC-AGG-ID: eQAVUnAIOIizaZ8uLe3bPw_1741654075
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C90271956048;
	Tue, 11 Mar 2025 00:47:54 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 611301828A8A;
	Tue, 11 Mar 2025 00:47:48 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	akpm@linux-foundation.org,
	shan.gavin@gmail.com
Subject: [PATCH v2 1/3] mm/sparse: Expose for_each_present_section_nr()
Date: Tue, 11 Mar 2025 10:46:55 +1000
Message-ID: <20250311004657.82985-2-gshan@redhat.com>
In-Reply-To: <20250311004657.82985-1-gshan@redhat.com>
References: <20250311004657.82985-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Expose for_each_present_section_nr() to be used by drivers/base/memory
in the next patch.

No functional changes intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 include/linux/mmzone.h | 5 +++++
 mm/sparse.c            | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9540b41894da..0f6646da34d7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2097,6 +2097,11 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
 	return -1;
 }
 
+#define for_each_present_section_nr(start, section_nr)		\
+	for (section_nr = next_present_section_nr(start - 1);	\
+	     section_nr != -1;					\
+	     section_nr = next_present_section_nr(section_nr))
+
 /*
  * These are _only_ used during initialisation, therefore they
  * can use __initdata ...  They could have names to indicate
diff --git a/mm/sparse.c b/mm/sparse.c
index 133b033d0cba..fe77d523ab8d 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -170,11 +170,6 @@ static void __section_mark_present(struct mem_section *ms,
 	ms->section_mem_map |= SECTION_MARKED_PRESENT;
 }
 
-#define for_each_present_section_nr(start, section_nr)		\
-	for (section_nr = next_present_section_nr(start-1);	\
-	     section_nr != -1;								\
-	     section_nr = next_present_section_nr(section_nr))
-
 static inline unsigned long first_present_section_nr(void)
 {
 	return next_present_section_nr(-1);
-- 
2.48.1


